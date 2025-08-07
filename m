Return-Path: <linux-kernel+bounces-759259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D7B1DB21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376A9620A07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76E26A1B9;
	Thu,  7 Aug 2025 15:58:30 +0000 (UTC)
Received: from mail-m15597.qiye.163.com (mail-m15597.qiye.163.com [101.71.155.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA32367BF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582309; cv=none; b=ZUYaeqxIJsYBLFx//ZdtBmaSm1iwyBOLGj8u28SH7jexR3C/SYsWkLr8nzPXKEtIse7wtc3ho7IiaYPwh75V7WNoMpb0W45evG8hzI/Jm8fGfJOrTDb+oM/X1fxKtLArEKcuOJNghp/j2Lfwd2yH/WOdg95RwyudUV+7Qd1ITvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582309; c=relaxed/simple;
	bh=2FcZkk+xEDG3rUE0WWzuxXebsp/ITy84v19kDDs0yHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4740sHweQn+uFLFqQdO6B9zI1YZQF2dCL0oC6H94tCIKfhkvdQt7Cr6zFqPrCvTcS/T7eKADDW85tiw4v0yH5kghiJuELj8MSujJQdjM8WArWrC5hjtjMVxES9B7ebSisHVZ4MYDHIFd0ZbUuXGJsW56Uu9NyJ0A/eVMmUz28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com; spf=pass smtp.mailfrom=winhong.com; arc=none smtp.client-ip=101.71.155.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winhong.com
Received: from localhost.localdomain (unknown [183.6.116.60])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ea7f7fec;
	Thu, 7 Aug 2025 23:58:13 +0800 (GMT+08:00)
From: yili <yili@winhong.com>
To: yili@winhong.com,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: Fix super block reserved field offset comment
Date: Thu,  7 Aug 2025 23:57:49 +0800
Message-ID: <20250807155749.164481-1-yili@winhong.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9885411aff03ackunm8c16af54187a570
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTExIVh4ZHh5JHRhCS0oaSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKQ0hVTVVKSk1VTUtZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

The offset annotation for s_reserved2 in struct ocfs2_super_block
was incorrect. After the preceding fields:
- s_xattr_inline_size (2 bytes at 0xB8)
- s_reserved0 (2 bytes at 0xBA)
- s_dx_seed[3] (12 bytes at 0xBC)

The actual offset of s_reserved2 is at 0xC8,
when calculating from the start of the structure.

Correct the offset comment from C0 to C8 to reflect the proper
location in the super block structure.

Signed-off-by: yili <yili@winhong.com>
---
 fs/ocfs2/ocfs2_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index e8e94599e907..ae0e44e5f2ad 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -614,7 +614,7 @@ struct ocfs2_super_block {
 	__le16 s_reserved0;
 	__le32 s_dx_seed[3];		/* seed[0-2] for dx dir hash.
 					 * s_uuid_hash serves as seed[3]. */
-/*C0*/  __le64 s_reserved2[15];		/* Fill out superblock */
+/*C8*/  __le64 s_reserved2[15];		/* Fill out superblock */
 /*140*/
 
 	/*
-- 
2.43.0


