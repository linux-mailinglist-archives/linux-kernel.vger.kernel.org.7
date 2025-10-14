Return-Path: <linux-kernel+bounces-852008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CFBD7F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2E427A35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359530F92F;
	Tue, 14 Oct 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2r+7uKo"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA72DA750
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427067; cv=none; b=sSQolCmFVfLrcSiUAQApP3YqdQ3CfU3CX0NxEmJURIHPIbzcWNLVWPek5D44ErGDZ++YtgOvOv5QSMh4QzYoGy4s8PnL5WCAcD8XGTXlKzEl9v7wwMkckY3cy/mfzcC9Iq5b6TeqvyzCwSCBOiePbEMedVqFKdwglMi5pPT5D/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427067; c=relaxed/simple;
	bh=bGSjiGhKrW0fwcd2uFIhvIfrxchHrqrL9vlAAJS9bRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2hZ6CJuaqpdu5+IU+Ifr4UgNhYaN5FAAQYKEVg62bmnrGmDZYmWV+WpWTcpdfttVE77iBDuiY2w8qw2a8IooGlLkmwNL6e1moPzo9M0zVfbE5JQmBSFw+L8WihLdMXcoi/Zm/I/cZ6Nn/efzVMPn1xlr6ReEytr4PootrJR2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2r+7uKo; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760427057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D865cd6ixAF9y5yQJbV2j+wjuGezJ19F02+Jcz5YZoA=;
	b=t2r+7uKobJdi0ZRB+9K2o6FiPN1Qm50wu9DOGTNkroqabC1zsBvPgJ+1uTSoZEOcuxH4Oz
	G0ihbV3mUu1wqAgBjMFvroHuHowPdPS3ZdWGoaGInNpFlnlgJ5ya+BGuyo+RR4IohZIcfI
	rxrWMNgXyVtbrsecAtR5K+X3TxyxzZ4=
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
Subject: [PATCH v3 21/22] smb: move SEARCH_ID_FULL_DIR_INFO to common/cifspdu.h
Date: Tue, 14 Oct 2025 15:28:55 +0800
Message-ID: <20251014072856.3004683-11-chenxiaosong.chenxiaosong@linux.dev>
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

Rename "struct file_id_full_dir_info" to "SEARCH_ID_FULL_DIR_INFO",
then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifspdu.h    | 17 -----------------
 fs/smb/common/cifspdu.h    | 18 ++++++++++++++++++
 fs/smb/server/smb2pdu.c    | 14 +++++++-------
 fs/smb/server/smb_common.h | 17 -----------------
 4 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 3db5e7e6172e..68e3af176add 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -2150,23 +2150,6 @@ typedef struct {
 	};
 } __attribute__((packed)) FILE_UNIX_INFO; /* level 0x202 */
 
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
-	__le32 EaSize; /* EA size */
-	__le32 Reserved;
-	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[];
-} __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
-
 typedef struct {
 	__u32  ResumeKey;
 	__le16 CreationDate; /* SMB Date */
diff --git a/fs/smb/common/cifspdu.h b/fs/smb/common/cifspdu.h
index cf5e3ee577d0..b4ca0c36cf84 100644
--- a/fs/smb/common/cifspdu.h
+++ b/fs/smb/common/cifspdu.h
@@ -401,6 +401,24 @@ typedef struct {
 	char FileName[];
 } __attribute__((packed)) FILE_FULL_DIRECTORY_INFO; /* level 0x102 rsp data */
 
+/* See MS-SMB 2.2.8.1.2 */
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
+	__le32 EaSize; /* EA size */
+	__le32 Reserved;
+	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
+	char FileName[];
+} __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
+
 /* See MS-CIFS 2.2.8.1.7 */
 typedef struct {
 	__le32 NextEntryOffset;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8c5700102cc6..065e0daaa91b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3804,7 +3804,7 @@ static int readdir_info_level_struct_sz(int info_level)
 	case FILE_NAMES_INFORMATION:
 		return sizeof(struct file_names_info);
 	case FILEID_FULL_DIRECTORY_INFORMATION:
-		return sizeof(struct file_id_full_dir_info);
+		return sizeof(SEARCH_ID_FULL_DIR_INFO);
 	case FILEID_BOTH_DIRECTORY_INFORMATION:
 		return sizeof(struct file_id_both_directory_info);
 	case SMB_FIND_FILE_POSIX_INFO:
@@ -3859,9 +3859,9 @@ static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
 	}
 	case FILEID_FULL_DIRECTORY_INFORMATION:
 	{
-		struct file_id_full_dir_info *dinfo;
+		SEARCH_ID_FULL_DIR_INFO *dinfo;
 
-		dinfo = (struct file_id_full_dir_info *)d_info->rptr;
+		dinfo = (SEARCH_ID_FULL_DIR_INFO *)d_info->rptr;
 		d_info->rptr += le32_to_cpu(dinfo->NextEntryOffset);
 		d_info->name = dinfo->FileName;
 		d_info->name_len = le32_to_cpu(dinfo->FileNameLength);
@@ -4000,9 +4000,9 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 	}
 	case FILEID_FULL_DIRECTORY_INFORMATION:
 	{
-		struct file_id_full_dir_info *dinfo;
+		SEARCH_ID_FULL_DIR_INFO *dinfo;
 
-		dinfo = (struct file_id_full_dir_info *)kstat;
+		dinfo = (SEARCH_ID_FULL_DIR_INFO *)kstat;
 		dinfo->FileNameLength = cpu_to_le32(conv_len);
 		dinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
@@ -4250,9 +4250,9 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
 	}
 	case FILEID_FULL_DIRECTORY_INFORMATION:
 	{
-		struct file_id_full_dir_info *dinfo;
+		SEARCH_ID_FULL_DIR_INFO *dinfo;
 
-		dinfo = (struct file_id_full_dir_info *)d_info->wptr;
+		dinfo = (SEARCH_ID_FULL_DIR_INFO *)d_info->wptr;
 		memcpy(dinfo->FileName, d_info->name, d_info->name_len);
 		dinfo->FileName[d_info->name_len] = 0x00;
 		dinfo->FileNameLength = cpu_to_le32(d_info->name_len);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 9e72c45c100b..4f48dbf9c13b 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -107,23 +107,6 @@ struct file_id_both_directory_info {
 	char FileName[];
 } __packed;
 
-struct file_id_full_dir_info {
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
-	__le32 EaSize; /* EA size */
-	__le32 Reserved;
-	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[];
-} __packed; /* level 0x105 FF rsp data */
-
 struct filesystem_posix_info {
 	/* For undefined recommended transfer size return -1 in that field */
 	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
-- 
2.43.0


