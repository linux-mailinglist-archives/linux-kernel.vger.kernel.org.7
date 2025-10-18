Return-Path: <linux-kernel+bounces-859464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4382BEDBAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266B519C196F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B922D979F;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7I73goU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB627462;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820292; cv=none; b=VW6RAB96uub2Ylj4HL1AIaE2t2G4RicYZq2DI55ybCehkA2RKrbNgD0+8cDhCMVWrrqQPUxr6Dl4x1mHRl+y1gJux0sDA9kOaCG90l6kFNIr0HoiwoE+AFaUqTxr0ZCQR2KcbKYamAac3X7s7ebs+xDZY5r3SLUZYPjc5LC2XDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820292; c=relaxed/simple;
	bh=CeZZk9p5z6KkgS+x4IVFKcC4JWjTbvSMfd0yyRSruDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ3HJGxbRfa3hvF8bpspzDUjTTHG2miBDx1flqRmOe4xIGb0gGAnWQz5AL+KDQ+mRKmZD9SGfAQ1UXFWCTmLMnmMvAZDUDQCuugfP2VndPD8lufbnO6tp1WwtZ0Xv1DVU1kTSYVDfyglPapQMj2mLQzFNneKu9LcZrXDMkP1tJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7I73goU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29529C4CEF8;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760820292;
	bh=CeZZk9p5z6KkgS+x4IVFKcC4JWjTbvSMfd0yyRSruDY=;
	h=From:To:Cc:Subject:Date:From;
	b=f7I73goUIQgzvVeUabqDD8fY5jbdxieK4x5mjlKJPTGypIiqKbjsZntJR3jrTbKui
	 3bk/9TD3om0MatV/qQw6rMSvtZZVEwvB5er/jlIDkqNHqZprevvQ3CabjF2uMCayQK
	 al6YEuwFeKp0jxe44zwxDLo2JtWm5mt9EWx1hYK+7bp7jCRtF0v7YnQxehhqWkntUR
	 1g/E8zeIntDKzD4+ybhrg2nQ0sLWk/2A6UUDDJMn61eR6dQQV1hFhU1E9A/2IDucz7
	 VA5Oraxe5hzKAaKGos/Y9iZwbyEj9w6avLQtJLRJ9sDYNIh+k4NLc041IndztpdDHq
	 To3/4ZT7ON2DQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] selftests/damon: add a test for obsolete_target sysfs file
Date: Sat, 18 Oct 2025 13:44:41 -0700
Message-ID: <20251018204448.8906-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RFC patch series [1] that add a new DAMON sysfs file for arbitrary
targets removal is under review.  Add a selftest for the feature.  The
new test uses the feature using the python wrapper of DAMON sysfs
interface, and confirm the expected internal data structure change is
made using drgn.

So this patch series may better to be a part of the other one [1] that
introduces the obsolete_target file.  But, because no significant change
is requested on the series so far, I'm posting this as an individual
RFC.

In the next version, I may merge the two series into one, to add all
related changes at one step.

[1] https://lore.kernel.org/20251016214736.84286-1-sj@kernel.org

SeongJae Park (4):
  selftests/damon/_damon_sysfs: support obsolete_target file
  drgn_dump_damon_status: dump damon_target->obsolete
  sysfs.py: extend assert_ctx_committed() for monitoring targets
  selftests/damon/sysfs: add obsolete_target test

 tools/testing/selftests/damon/_damon_sysfs.py | 11 ++++-
 .../selftests/damon/drgn_dump_damon_status.py |  1 +
 tools/testing/selftests/damon/sysfs.py        | 48 +++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)


base-commit: 1aba8bd57e6aaa1c9e699c8de66bcc931d4b1116
-- 
2.47.3

