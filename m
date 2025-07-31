Return-Path: <linux-kernel+bounces-751646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B5DB16BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759BC564A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741023B61F;
	Thu, 31 Jul 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9PLlmil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BB1876
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941827; cv=none; b=Ya2irNsyRNXWZNLk/LPSXUJBtxmYYqu6ndD9BvvpAIEEtWH6kize9NNxJOtGA3NrD+opAOYf9Fb6DQkx9oIoLARDvVeebnHuehK4ZyZbj8CtWl82+n2Toj0ttiamQk3C8ajY3yGHGgc9JqNcfbW9UbpnPGI2lhKXuKLgZZby8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941827; c=relaxed/simple;
	bh=Va3gFAjQvLD9uc8s9zeI+fE2DCJGgTUkQCU2sAHwohg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+fUDPKuXLA/2cc7GoPCEtR8FdCNXSErB1DDwHmi5ehYlodam2VYrMeD4Whfn7VVWwSNCFy3Slrrr5Voyt4PA1+pmO6yKvAbHiJuQkCHclkN38s7Ukn6Nx7kzVg0Xo8+1fmuHTMx+rLomDb8zVo5QkwMEgTKzCHE9gQNj8ltw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9PLlmil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF150C4CEEF;
	Thu, 31 Jul 2025 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753941826;
	bh=Va3gFAjQvLD9uc8s9zeI+fE2DCJGgTUkQCU2sAHwohg=;
	h=From:To:Cc:Subject:Date:From;
	b=F9PLlmilllgBhtSfqfRDBCPieGlGB63NGg2QruiWsdJatYYAisl8JOCgn16RAyVbt
	 b5bPNrt0L+DOyCoCgOMA+fPhQvrAAOi1xJpfiD5X3f89cpm0Q1+zMpPDPRlAKkRg0h
	 Hgbya6Ab9sHN4OVWpELBQpNDdCiOPGTbg5gdSEyGLDGxg3rXQ0G0maLnYFFDL4vcmD
	 xsSMDq2tt66NhcvcJy9lShbjNVdqnvm57wA6UAE77FbBd4uoP5BSmJarwgfYvMhRIU
	 BPL+J0h/GCvfw2N+yDw3CpN20+0f/uK0ui4tfie697kMaFSaD/VzcSHFxG/UWaw1bc
	 OoeDuEaaGhP0g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix condition in __allow_reserved_blocks()
Date: Thu, 31 Jul 2025 14:03:38 +0800
Message-ID: <20250731060338.1136086-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If reserve_root mount option is not assigned, __allow_reserved_blocks()
will return false, it's not correct, fix it.

Fixes: 7e65be49ed94 ("f2fs: add reserved blocks for root user")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 691af2a6c159..c40ff0c6796e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2396,8 +2396,6 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 {
 	if (!inode)
 		return true;
-	if (!test_opt(sbi, RESERVE_ROOT))
-		return false;
 	if (IS_NOQUOTA(inode))
 		return true;
 	if (uid_eq(F2FS_OPTION(sbi).s_resuid, current_fsuid()))
@@ -2418,7 +2416,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-- 
2.49.0


