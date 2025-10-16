Return-Path: <linux-kernel+bounces-856718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC3BE4E42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24914FC5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268120E032;
	Thu, 16 Oct 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNbbHMAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B317C21E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636381; cv=none; b=lmS3ZRqs7V1malp0+oWzeVeedrc+RluBWvlHSTiCmNApcJJZqAdLILSGqWGRVHH8Mg/azBRWL02PQBJ9lgstlefhbQmi6GYU1bfv+8nYhyTIwWFecwwTOKDCl0A8C653NlTO2Wz+mq00D1t/x8hM8q6w2mtZZyRiMd+ymJAEdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636381; c=relaxed/simple;
	bh=eOq2qhTSMPD2ObFUJ67WfeOoa0dy5B3akOcSy4XfLeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EEVqDUg0VBWbWLOqm78lfTC96R//8A99QYvYdAXoDR6hJDDAS3AR8XdcZDtno1PvtqqHknRr5Sa8hd2zDTS+etC5q4FvOOaq3cke9uRSYooX/JO8uUSsXCJtUaOkiRN+GMAM79TjIK/yCSHNGTWyhrTzu3NxF/vHNwzGELNoIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNbbHMAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1331CC4CEF1;
	Thu, 16 Oct 2025 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760636381;
	bh=eOq2qhTSMPD2ObFUJ67WfeOoa0dy5B3akOcSy4XfLeU=;
	h=Date:From:To:Cc:Subject:From;
	b=ZNbbHMAqqaHwVE8NGCSk5qWFMMJYCSSSwtuBrgETyhIkitAXW48z1nFJXGwPmHoMS
	 Zag2hnp1byMgU4pHXHjgV/yykoR/VXuiaw+ADlIvjboxDloqo91GlPkq/2iOg5cdD8
	 WQSdtfE4aBroHzji/bPOGSr6JvDexK/KJZLdsX/WpEzQOUPgfYtcpU08nXpmj8rAC6
	 QqEilivsYurOYM3R1IYJq1lQAs9V/fQvxokrlUFedGdd8AiLGaJlWrm1oN5I2slTGf
	 KRnYbTSS61kRqaeI3HsvLtbZnCu43fS5Sg1PhApJ2PLR8QS8X0Rrdk5aJSS5/QxYZF
	 JsHqsq1gEPx6g==
Date: Thu, 16 Oct 2025 17:39:39 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs fix for 6.18-rc2
Message-ID: <aPEt2-u8J16L9Xnk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider this pull request?

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.18-rc2

for you to fetch changes up to 9d5c4f5c7a2c7677e1b3942772122b032c265aae:

  f2fs: fix wrong block mapping for multi-devices (2025-10-13 23:55:44 +0000)

----------------------------------------------------------------
f2fs-fix-6.18-rc2

This includes two urgent fixes:
1) iput() added by bc986b1d756482a causes soft lockup [1].
2) fix a wrong block address map on multiple devices.

[1] https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com

----------------------------------------------------------------
Jaegeuk Kim (1):
      f2fs: fix wrong block mapping for multi-devices

Mateusz Guzik (1):
      f2fs: don't call iput() from f2fs_drop_inode()

 fs/f2fs/data.c  | 2 +-
 fs/f2fs/super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Thanks,

