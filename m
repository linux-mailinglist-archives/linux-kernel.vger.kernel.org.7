Return-Path: <linux-kernel+bounces-870956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919CC0C145
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B5D18A0079
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA72E36E3;
	Mon, 27 Oct 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s5SwCmnE"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BB2E264D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549354; cv=none; b=NvkroDESCbWoz1UzcfWsYRSb9rBpL1K4A4YLbCc7Ox9HHz+gHX2QSMjE/JueHfhhTIaYzKAuX4qxyNL9Mo3yS1S7qCaPH6s0c8arQhfsTWG1h5EicE6U17cDC6juro+KIXiLWhbf1LbC9PKHrluzpstXGhEu5OCsPzR6EdKVHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549354; c=relaxed/simple;
	bh=x5IvPi+zVIBpscGzduW/FHzyjDbbXeHzUUCF5tcvyPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwtff58cPVQZYbVqN1n2z3yIZoTgRNVgU3Kdchq6ODVWd+zXJcLj7Wq6FLUN0IW6FOMyfDjTc5vwaqZpCxLCrQESG89AXAA/udGN2kK2iH0R4BtR1HjiNDzPWGzGX/xqMSstdm4hB6E024pk10KI2OZDOrOLWB2RzC+wokkqmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s5SwCmnE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761549350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNUm/R/QhScINFNbvi0WP2wwN2c8t5jYII8ZEWq1Vbo=;
	b=s5SwCmnELirSY+HOry8y8BoZTr0+9io00Mvm9cO+CSmebUygM7GLosKyqHUZRRZNssg2Ya
	MFKwTpkwi1a1BDf5kE7eXsdiKIX+PWRHzW4Bm5FkkMrY7QXHLGMS/gukloSRggNV4Z2luB
	4QYD1D7C8Bs7aHtiCKtsQj9NSp4FMxs=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v4 13/24] smb: move FILE_BOTH_DIRECTORY_INFO to common/smb1pdu.h
Date: Mon, 27 Oct 2025 15:13:05 +0800
Message-ID: <20251027071316.3468472-14-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Rename "struct file_both_directory_info" to "FILE_BOTH_DIRECTORY_INFO",
then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifspdu.h    | 18 ------------------
 fs/smb/common/smb1pdu.h    | 19 +++++++++++++++++++
 fs/smb/server/smb2pdu.c    | 14 +++++++-------
 fs/smb/server/smb_common.h | 18 ------------------
 4 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 8cf01f04153b..8aac0e04f9fd 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -2176,24 +2176,6 @@ typedef struct {
 	char FileName[];
 } __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
 
-typedef struct {
-	__le32 NextEntryOffset;
-	__u32 FileIndex;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 EndOfFile;
-	__le64 AllocationSize;
-	__le32 ExtFileAttributes;
-	__le32 FileNameLength;
-	__le32 EaSize; /* length of the xattrs */
-	__u8   ShortNameLength;
-	__u8   Reserved;
-	__u8   ShortName[24];
-	char FileName[];
-} __attribute__((packed)) FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
-
 typedef struct {
 	__u32  ResumeKey;
 	__le16 CreationDate; /* SMB Date */
diff --git a/fs/smb/common/smb1pdu.h b/fs/smb/common/smb1pdu.h
index bd2a78c75902..0bc1e2373210 100644
--- a/fs/smb/common/smb1pdu.h
+++ b/fs/smb/common/smb1pdu.h
@@ -399,4 +399,23 @@ typedef struct {
 	char FileName[];
 } __packed FILE_FULL_DIRECTORY_INFO; /* level 0x102 rsp data */
 
+/* See MS-CIFS 2.2.8.1.7 */
+typedef struct {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	__le32 EaSize; /* length of the xattrs */
+	__u8   ShortNameLength;
+	__u8   Reserved;
+	__u8   ShortName[24];
+	char FileName[];
+} __packed FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
+
 #endif /* _COMMON_SMB1_PDU_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 36a60be72c63..b6daac1cd080 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3798,7 +3798,7 @@ static int readdir_info_level_struct_sz(int info_level)
 	case FILE_FULL_DIRECTORY_INFORMATION:
 		return sizeof(FILE_FULL_DIRECTORY_INFO);
 	case FILE_BOTH_DIRECTORY_INFORMATION:
-		return sizeof(struct file_both_directory_info);
+		return sizeof(FILE_BOTH_DIRECTORY_INFO);
 	case FILE_DIRECTORY_INFORMATION:
 		return sizeof(FILE_DIRECTORY_INFO);
 	case FILE_NAMES_INFORMATION:
@@ -3829,9 +3829,9 @@ static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
 	}
 	case FILE_BOTH_DIRECTORY_INFORMATION:
 	{
-		struct file_both_directory_info *fbdinfo;
+		FILE_BOTH_DIRECTORY_INFO *fbdinfo;
 
-		fbdinfo = (struct file_both_directory_info *)d_info->rptr;
+		fbdinfo = (FILE_BOTH_DIRECTORY_INFO *)d_info->rptr;
 		d_info->rptr += le32_to_cpu(fbdinfo->NextEntryOffset);
 		d_info->name = fbdinfo->FileName;
 		d_info->name_len = le32_to_cpu(fbdinfo->FileNameLength);
@@ -3960,9 +3960,9 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 	}
 	case FILE_BOTH_DIRECTORY_INFORMATION:
 	{
-		struct file_both_directory_info *fbdinfo;
+		FILE_BOTH_DIRECTORY_INFO *fbdinfo;
 
-		fbdinfo = (struct file_both_directory_info *)kstat;
+		fbdinfo = (FILE_BOTH_DIRECTORY_INFO *)kstat;
 		fbdinfo->FileNameLength = cpu_to_le32(conv_len);
 		fbdinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
@@ -4217,9 +4217,9 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
 	}
 	case FILE_BOTH_DIRECTORY_INFORMATION:
 	{
-		struct file_both_directory_info *fbdinfo;
+		FILE_BOTH_DIRECTORY_INFO *fbdinfo;
 
-		fbdinfo = (struct file_both_directory_info *)d_info->wptr;
+		fbdinfo = (FILE_BOTH_DIRECTORY_INFO *)d_info->wptr;
 		memcpy(fbdinfo->FileName, d_info->name, d_info->name_len);
 		fbdinfo->FileName[d_info->name_len] = 0x00;
 		fbdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 023e3b933dd1..649b45695449 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -88,24 +88,6 @@ struct file_names_info {
 	char FileName[];
 } __packed;   /* level 0xc FF resp data */
 
-struct file_both_directory_info {
-	__le32 NextEntryOffset;
-	__u32 FileIndex;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 EndOfFile;
-	__le64 AllocationSize;
-	__le32 ExtFileAttributes;
-	__le32 FileNameLength;
-	__le32 EaSize; /* length of the xattrs */
-	__u8   ShortNameLength;
-	__u8   Reserved;
-	__u8   ShortName[24];
-	char FileName[];
-} __packed; /* level 0x104 FFrsp data */
-
 struct file_id_both_directory_info {
 	__le32 NextEntryOffset;
 	__u32 FileIndex;
-- 
2.43.0


