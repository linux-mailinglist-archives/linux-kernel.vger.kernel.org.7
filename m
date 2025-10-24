Return-Path: <linux-kernel+bounces-868913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5CC067E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E3A3B6AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E331B806;
	Fri, 24 Oct 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAaP7ZVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78E2D3A75
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312353; cv=none; b=oIvU8XNjsODIGgXOZqrD2S5KIE2cv4EJHcWnV2FSXlq76Y3/joMGdwgKoHqL7zvvICQfywWiijnibLBUiy+z3xgEtBR25p/i2n6NhJ3qk0WcdGX/V1ZfZw2259tjePNbNzdEtRTZQ1MQgvBw9cxLo2+rDKt2f2FGpiFIYt0kIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312353; c=relaxed/simple;
	bh=ca4FOp589+Z4avUlf5XZZrsqGiyG4LYV8lB6Ys4hvEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjVUXl3EYKlwhkcBxfvRhUT9AhUi4h/91+vSyKQFy2MwIZM6YikjCvgFFVIRGGV5OcC4BNaYGegJ5dofEczX8QzTMgyZ2HkfW+B62AWVYFz+9CypNdRei5zzfT6jhdhqtpZYJPxfpbLDG+nhhpEwkNS5wwf8DzLk+VrkBll2DGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAaP7ZVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DB9C4CEF1;
	Fri, 24 Oct 2025 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312352;
	bh=ca4FOp589+Z4avUlf5XZZrsqGiyG4LYV8lB6Ys4hvEE=;
	h=From:To:Cc:Subject:Date:From;
	b=pAaP7ZVpb0nfipPcxcDbibGEG7uph2IJY7OOndAYondpqpf1aSEhq9xJQDnhvIMXr
	 LKWqZ1tbKaM0hFFm5QzeO+aXWqWm0JvAZO2afyClyPFXfSkSR5084yeuwAyDP0gHgJ
	 FgshhS6ZJBygZco4mpGk1NI8hC4YRjc6+bQ33iKYZS74qWKVzDxmu5DBQPG/U9hZnI
	 iQwC1d6PWjqT+klivjYt40GTInhCShJpGU40+0mMt9YmmiovMGs89a7m2aZXNvRUAB
	 Gt3CriFlc2aHi01CI15vdKrHVl1Xbbbzuz9bbULTqAu6I9jUDbgKVHCvwa9OUcbq0p
	 A7ueMRlQJsQYA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/6] timers/migration: Fix NUMA trees + cleanups
Date: Fri, 24 Oct 2025 15:25:30 +0200
Message-ID: <20251024132536.39841-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A while ago I found out that NUMA tree layout had flaws but I thought it
was only about rare setups. Having had a closer look while thinking
about the big.LITTLE handling, I realized the NUMA timer tree are
actually imbalanced in many cases, except perhaps when 0-7 CPUs are lucky
enough to belong to the same node, and yet up to a certain amount of
CPUs.

Here is a fix proposal, plus a bunch of cleanups.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core

HEAD: 4adecc004d35dbe8a48df3d23ed2b8cf42772716
Thanks,
	Frederic
---

Frederic Weisbecker (6):
      timers/migration: Convert "while" loops to use "for"
      timers/migration: Remove locking on group connection
      timers/migration: Fix imbalanced NUMA trees
      timers/migration: Assert that hotplug preparing CPU is part of stable active hierarchy
      timers/migration: Remove unused "cpu" parameter from tmigr_get_group()
      timers/migration: Remove dead code handling idle CPU checking for remote timers

 kernel/time/timer_migration.c | 279 ++++++++++++++++++++++--------------------
 1 file changed, 143 insertions(+), 136 deletions(-)

