Return-Path: <linux-kernel+bounces-852009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8FBD7F20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF82426E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152230F936;
	Tue, 14 Oct 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nRkJCviX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7830F808
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427071; cv=none; b=F01AFHnRshoqUdbJDClgeMQlEwBeWXqimC24jpzQ5Pfd90G08CCzfIj0vzlc4Yl0SBDYLy2tSjInAayAB0s/x0lG+dXP3lqSbjqyV+O4FvDorSM2UBLZ8FNvnUt3ESbdxY0WXJxkeZVBq00gOIZKpdExMxFWNR8QhzTEQ7owGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427071; c=relaxed/simple;
	bh=Xf8YDORNtEKfBSYe5NMLOToggAz3uvjWZVx2WzEpT+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7RWM4K4547PFF10rKTkHJU0z3D4GvjY3G7W18zw4ML2tLXKd2asYWcKekYl4V/94mtDXo7Ww2unYwY5REM90/wcD1oaoEpPJ9Szs0Rir3l+PJIUAvcs305WxaHx5vdfvKVQgFJnPvIkR1W1kly0u8JZAHGfSx4SCx+NCFRqNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nRkJCviX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760427061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAwW4/cgUKuRNiz5xi6WRrOnB+WoNorROPmk3jHIW9U=;
	b=nRkJCviX76BreT9/al+bjPSOt4dqBBQqOm4jhEyfvjOwnpkCVd+rTK2/CDL9bdH3z/IbFP
	syr3GofFIwT0kfjVH1R3oz9fT/rUrhGX1FxQv22fJaOKoB0XtyNSeO2KM2XHyzmXLpWX0i
	66GMo+pQrNq75ewZooFL61vj5/qIfJI=
From: chenxiaosong.chenxiaosong@linux.dev
To: stfrench@microsoft.com,
	metze@samba.org,
	pali@kernel.org,
	linkinjeon@kernel.org,
	smfrench@gmail.com,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	bharathsm@microsoft.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/22] smb: move FILE_SYSTEM_POSIX_INFO to common/cifspdu.h
Date: Tue, 14 Oct 2025 15:28:56 +0800
Message-ID: <20251014072856.3004683-12-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251014072856.3004683-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251014072856.3004683-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Rename "struct filesystem_posix_info" to "FILE_SYSTEM_POSIX_INFO",
then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifspdu.h    | 22 ----------------------
 fs/smb/common/cifspdu.h    | 23 +++++++++++++++++++++++
 fs/smb/server/smb2pdu.c    |  4 ++--
 fs/smb/server/smb_common.h | 23 -----------------------
 4 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 68e3af176add..ab23a233153a 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1866,28 +1866,6 @@ typedef struct {
 
 #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for new QFSInfo */
 
-typedef struct {
-	/* For undefined recommended transfer size return -1 in that field */
-	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
-	__le32 BlockSize;
-    /* The next three fields are in terms of the block size.
-	(above). If block size is unknown, 4096 would be a
-	reasonable block size for a server to report.
-	Note that returning the blocks/blocksavail removes need
-	to make a second call (to QFSInfo level 0x103 to get this info.
-	UserBlockAvail is typically less than or equal to BlocksAvail,
-	if no distinction is made return the same value in each */
-	__le64 TotalBlocks;
-	__le64 BlocksAvail;       /* bfree */
-	__le64 UserBlocksAvail;   /* bavail */
-    /* For undefined Node fields or FSID return -1 */
-	__le64 TotalFileNodes;
-	__le64 FreeFileNodes;
-	__le64 FileSysIdentifier;   /* fsid */
-	/* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
-	/* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
-} __attribute__((packed)) FILE_SYSTEM_POSIX_INFO;
-
 /* DeviceType Flags */
 #define FILE_DEVICE_CD_ROM              0x00000002
 #define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
diff --git a/fs/smb/common/cifspdu.h b/fs/smb/common/cifspdu.h
index b4ca0c36cf84..853e03f395be 100644
--- a/fs/smb/common/cifspdu.h
+++ b/fs/smb/common/cifspdu.h
@@ -329,6 +329,29 @@ typedef struct {
 	__le32 BytesPerSector;
 } __attribute__((packed)) FILE_SYSTEM_INFO;	/* size info, level 0x103 */
 
+typedef struct {
+	/* For undefined recommended transfer size return -1 in that field */
+	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
+	__le32 BlockSize;
+	/* The next three fields are in terms of the block size.
+	 * (above). If block size is unknown, 4096 would be a
+	 * reasonable block size for a server to report.
+	 * Note that returning the blocks/blocksavail removes need
+	 * to make a second call (to QFSInfo level 0x103 to get this info.
+	 * UserBlockAvail is typically less than or equal to BlocksAvail,
+	 * if no distinction is made return the same value in each
+	 */
+	__le64 TotalBlocks;
+	__le64 BlocksAvail;       /* bfree */
+	__le64 UserBlocksAvail;   /* bavail */
+	/* For undefined Node fields or FSID return -1 */
+	__le64 TotalFileNodes;
+	__le64 FreeFileNodes;
+	__le64 FileSysIdentifier;   /* fsid */
+	/* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
+	/* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
+} __attribute__((packed)) FILE_SYSTEM_POSIX_INFO;
+
 /* See MS-CIFS 2.2.8.2.5 */
 typedef struct {
 	__le32 DeviceType;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 065e0daaa91b..d49cd1ad1d70 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5626,14 +5626,14 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	}
 	case FS_POSIX_INFORMATION:
 	{
-		struct filesystem_posix_info *info;
+		FILE_SYSTEM_POSIX_INFO *info;
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			path_put(&path);
 			return -EOPNOTSUPP;
 		} else {
-			info = (struct filesystem_posix_info *)(rsp->Buffer);
+			info = (FILE_SYSTEM_POSIX_INFO *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);
 			info->BlockSize = cpu_to_le32(stfs.f_bsize);
 			info->TotalBlocks = cpu_to_le64(stfs.f_blocks);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 4f48dbf9c13b..d349b3443219 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -107,29 +107,6 @@ struct file_id_both_directory_info {
 	char FileName[];
 } __packed;
 
-struct filesystem_posix_info {
-	/* For undefined recommended transfer size return -1 in that field */
-	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
-	__le32 BlockSize;
-	/* The next three fields are in terms of the block size.
-	 * (above). If block size is unknown, 4096 would be a
-	 * reasonable block size for a server to report.
-	 * Note that returning the blocks/blocksavail removes need
-	 * to make a second call (to QFSInfo level 0x103 to get this info.
-	 * UserBlockAvail is typically less than or equal to BlocksAvail,
-	 * if no distinction is made return the same value in each
-	 */
-	__le64 TotalBlocks;
-	__le64 BlocksAvail;       /* bfree */
-	__le64 UserBlocksAvail;   /* bavail */
-	/* For undefined Node fields or FSID return -1 */
-	__le64 TotalFileNodes;
-	__le64 FreeFileNodes;
-	__le64 FileSysIdentifier;   /* fsid */
-	/* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
-	/* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
-} __packed;
-
 struct smb_version_ops {
 	u16 (*get_cmd_val)(struct ksmbd_work *swork);
 	int (*init_rsp_hdr)(struct ksmbd_work *swork);
-- 
2.43.0


