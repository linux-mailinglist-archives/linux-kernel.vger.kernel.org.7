Return-Path: <linux-kernel+bounces-804617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC726B47A7E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DE03BB8E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E524886F;
	Sun,  7 Sep 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahDn+lM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B91ACEDA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757241357; cv=none; b=mFMPLYkwgD78sG0LCI6W/jkbOUEOJuPBMuoYNq7cTPA89ofJ2o6u567vJFIw+NpPJvD6pzAuNQrgkM1fsaCBkiiiqTO4iqzPlDhzGbEK0bDjKWwbSJYatBGKNO7D4A11yRt2u7Z+Dwt3sRCDiEUbYlzFgvCYBFvIKorpeyk+WwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757241357; c=relaxed/simple;
	bh=q1aoAgnc4AyoQiV0cRXBP5xVDW0ePiVqrkz77V9tlzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OWlLz/NK0JGuV+FfqpvXNwD/458NmNx5C2JQAsVE8CFS1HxWQ46qSVQgc61uIqqjmtZGQ4CmqNEh0+HwfOBsWTMJPrVmoNy2MMm2nb3GTQnxlj2gi1xuzeAcF5rsPsoVgXK9BmPwhHfLdOUqPMyAftld+yDWMRNn/ki0IHB0Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahDn+lM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F9C4CEF0;
	Sun,  7 Sep 2025 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757241356;
	bh=q1aoAgnc4AyoQiV0cRXBP5xVDW0ePiVqrkz77V9tlzI=;
	h=Date:From:To:Cc:Subject:From;
	b=ahDn+lM1MSrmxJC95MrODBki+nqsRUL9D0f311oRCHhSM5GN7BhdkdhECamEuQJ7K
	 Vocz+aO0GnwLJHTApNz0ZR5/FUfd1e1EfwWn3/+0SdIJa4bcFvnJ9NHale0GWiyqwf
	 2+W+xJanyel67lb9yJ8VWKg3EGs1KKKPJbGRdcjMxH/w13KHabRIqjCwh9sEEohsvW
	 1LT2j3mu4a/zhipPyh7dChQCGV90fDWq4jvfZ2x0vTtdTtBVl66JNlYR5p1/3MXoom
	 e+el9chLEaF3+esERVJKhvBU6OsyfoQKK6qsrW40nLn+CogO8wG/7u3ShgUjhoiiqO
	 8a9BetLL1mhag==
Date: Sun, 7 Sep 2025 12:35:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [GIT PULL] timer subsystem fix
Message-ID: <aL1gCBN1MlhGPAja@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-09-07

   # HEAD: 762af5a2aa0ad18da1316666dae30d369268d44c vdso/vsyscall: Avoid slow division loop in auxiliary clock update

Fix a severe slowdown regression in the timer vDSO code related
to the while() loop in __iter_div_u64_rem(), when the AUX-clock
is enabled.

 Thanks,

	Ingo

------------------>
Thomas Weiﬂschuh (1):
      vdso/vsyscall: Avoid slow division loop in auxiliary clock update


 include/linux/timekeeper_internal.h |  9 ++++++++-
 kernel/time/timekeeping.c           | 10 ++++++++--
 kernel/time/vsyscall.c              |  4 ++--
 3 files changed, 18 insertions(+), 5 deletions(-)

