Return-Path: <linux-kernel+bounces-619109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C924A9B807
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 21:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986B5189305E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021D292939;
	Thu, 24 Apr 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z7pOzkkk"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90C28F53C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521588; cv=none; b=nV4QshaC55KEvLO8+IKl3QTMdhzXSueIujHfh8909xfpipuIXseDfxva7dd7uQWzFXbb8P7t/UZc5qoIE/9uiYGr6mB445axfIDtln/+VJ92LQqC4JpBc/0zCwVMx21PARbQewPOBlPUqpjb3gDx1W6Y7OKs4Zbat8XF3LR/iVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521588; c=relaxed/simple;
	bh=6FaFvY8Ll3PltdEEdKEHjLwIeMKq9+dnJtsXptluj9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jYBBh86VYGQBHrjxgRcKXLQt7G3/LM1XvLY/wNmxElrIPV25IEhS4RbOWI+1H8jhclOtKnpZkByUZBIM+Fd8Fp8uM4i54qCmav31BFvaeao7SzklrVOjeHIhIioTcwEdrVrWH22TAMHn/MiDZ60kQstVxPzMUhTjNL/T65O2ok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z7pOzkkk; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zk56Z2GrbzGG0;
	Thu, 24 Apr 2025 21:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1745521574;
	bh=AJZuZQVgkQN5VFPhVIHuyE8h71pNG+lc4Di/0XENLWs=;
	h=From:To:Cc:Subject:Date:From;
	b=Z7pOzkkkqBzDSNrOUdAlbEdfGCo0uFcjrbWoLZTBMznCCG/U0lS6djbh0k/BoW1AQ
	 IcnMaGEcKrnhGrumBREP/UsP7NoyIF1HjBpDYdrWwqno0r+InMnNTGlknOFUoyjYCa
	 PINyC0Db0mOsfMRtB7B/AailT8Jm7vECLsL9vpqs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zk56Y4PFWz9W4;
	Thu, 24 Apr 2025 21:06:13 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.15-rc4
Date: Thu, 24 Apr 2025 21:06:04 +0200
Message-ID: <20250424190604.1007961-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Linus,

This PR fixes some Landlock audit issues, add related tests, and updates
documentation.

Please pull these changes for v6.15-rc4 .  These commits merge cleanly
with your master branch.  They have been been tested in the latest
linux-next releases.

Test coverage for security/landlock is 93.6% of 1524 lines according to
gcc/gcov-14, and it was 93.6% of 1525 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc4

for you to fetch changes up to 47ce2af848b7301d8571f0e01a0d7c7162d51e4a:

  landlock: Update log documentation (2025-04-17 11:09:10 +0200)

----------------------------------------------------------------
Landlock fix for v6.15-rc4

----------------------------------------------------------------
Mickaël Salaün (7):
      landlock: Remove incorrect warning
      landlock: Log the TGID of the domain creator
      selftests/landlock: Factor out audit fixture in audit_test
      selftests/landlock: Add PID tests for audit records
      landlock: Fix documentation for landlock_create_ruleset(2)
      landlock: Fix documentation for landlock_restrict_self(2)
      landlock: Update log documentation

 include/uapi/linux/landlock.h                 |  87 ++++++++++-----
 security/landlock/domain.c                    |   4 +-
 security/landlock/domain.h                    |   2 +-
 security/landlock/syscalls.c                  |  27 +++--
 tools/testing/selftests/landlock/audit.h      |  21 ++--
 tools/testing/selftests/landlock/audit_test.c | 154 +++++++++++++++++++++++---
 tools/testing/selftests/landlock/fs_test.c    |   3 +-
 7 files changed, 226 insertions(+), 72 deletions(-)

