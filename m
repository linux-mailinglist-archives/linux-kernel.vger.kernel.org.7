Return-Path: <linux-kernel+bounces-851977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A7BD7DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3622E4FA61E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A530E85E;
	Tue, 14 Oct 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QDB7/KJ2"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD930E855
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426475; cv=none; b=eLTKNJHSRBwbb2C9XesQ+Qpbob4U9V7pv69SFQh4TXuRBEIhx+qXgu1WN+kYHPThETKXfxhrC9besSgNp8W82qU3Qm6UkhN2hYww3defxr5ATBfdyaQwsHbRxs628u5cj6qRrJFg+ReTYMh9acuBUEh5M6LXJEd7n9W7TcZPotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426475; c=relaxed/simple;
	bh=TdL36T/j3jgWpAt/N06fhUUzW/dR9NYMD1/D7X/JCdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdiZAKIT5q2zlBrz3rjik0g/0pWYsIYZBygmLKhT1BNklKKGx6gI4Fc9H7P/V4dVnljRC6W27pJVoDdMLctMQrcn+jSVcdv8xn1QhprWe8N8NSHgaXNDf6ZxLsiHXC8WH16zjdDSHYD6oDfxfMcCTTUpauGNyFGFiYp6AyTUZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QDB7/KJ2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760426470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIN5wYpqH24e+jSDyhcyEsheGtVXtTCQTJdOJcoRTSw=;
	b=QDB7/KJ2XHWOvVL57IJp9oI/+jfg5Ma6p9BDvVLB3bKsWS9evHSpOlSWXDv4ZJ3IqoZHjC
	5J3jy2gTzazW2SrkzmOJG1xmHWd+Emq0IqpHgtnZmEafmjDqvH+PmHP6/XvC54Kb12xoRx
	9CUDlUzsDO1N6RVwA6j8LERbWaztSUM=
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
	christophe.jaillet@wanadoo.fr,
	zhangguodong@kylinos.cn
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v3 04/22] smb: move smb_version_values to common/cifsglob.h
Date: Tue, 14 Oct 2025 15:18:59 +0800
Message-ID: <20251014071917.3004573-5-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ZhangGuoDong <zhangguodong@kylinos.cn>

Merge the struct members of the server and the client, then move duplicate
definitions to common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
---
 fs/smb/client/cifsglob.h   | 22 ----------------------
 fs/smb/common/cifsglob.h   | 31 +++++++++++++++++++++++++++++++
 fs/smb/server/smb2misc.c   |  2 +-
 fs/smb/server/smb2ops.c    | 32 ++++++++++++++++----------------
 fs/smb/server/smb2pdu.c    | 10 +++++-----
 fs/smb/server/smb_common.h | 29 -----------------------------
 6 files changed, 53 insertions(+), 73 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index c5034cf9ac9e..88a428e3903a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -638,28 +638,6 @@ struct smb_version_operations {
 					       struct kvec *xattr_iov);
 };
 
-struct smb_version_values {
-	char		*version_string;
-	__u16		protocol_id;
-	__u32		req_capabilities;
-	__u32		large_lock_type;
-	__u32		exclusive_lock_type;
-	__u32		shared_lock_type;
-	__u32		unlock_lock_type;
-	size_t		header_preamble_size;
-	size_t		header_size;
-	size_t		max_header_size;
-	size_t		read_rsp_size;
-	__le16		lock_cmd;
-	unsigned int	cap_unix;
-	unsigned int	cap_nt_find;
-	unsigned int	cap_large_files;
-	unsigned int	cap_unicode;
-	__u16		signing_enabled;
-	__u16		signing_required;
-	size_t		create_lease_size;
-};
-
 #define HEADER_SIZE(server) (server->vals->header_size)
 #define MAX_HEADER_SIZE(server) (server->vals->max_header_size)
 #define HEADER_PREAMBLE_SIZE(server) (server->vals->header_preamble_size)
diff --git a/fs/smb/common/cifsglob.h b/fs/smb/common/cifsglob.h
index 00fd215e3eb5..eda5e666a761 100644
--- a/fs/smb/common/cifsglob.h
+++ b/fs/smb/common/cifsglob.h
@@ -9,6 +9,37 @@
 #ifndef _COMMON_CIFS_GLOB_H
 #define _COMMON_CIFS_GLOB_H
 
+struct smb_version_values {
+	char		*version_string;
+	__u16		protocol_id;
+	__le16		lock_cmd;
+	__u32		req_capabilities;
+	__u32		max_read_size;
+	__u32		max_write_size;
+	__u32		max_trans_size;
+	__u32		max_credits;
+	__u32		large_lock_type;
+	__u32		exclusive_lock_type;
+	__u32		shared_lock_type;
+	__u32		unlock_lock_type;
+	size_t		header_preamble_size;
+	size_t		header_size;
+	size_t		max_header_size;
+	size_t		read_rsp_size;
+	unsigned int	cap_unix;
+	unsigned int	cap_nt_find;
+	unsigned int	cap_large_files;
+	unsigned int	cap_unicode;
+	__u16		signing_enabled;
+	__u16		signing_required;
+	size_t		create_lease_size;
+	size_t		create_durable_size;
+	size_t		create_durable_v2_size;
+	size_t		create_mxac_size;
+	size_t		create_disk_id_size;
+	size_t		create_posix_size;
+};
+
 static inline void inc_rfc1001_len(void *buf, int count)
 {
 	be32_add_cpu((__be32 *)buf, count);
diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index ae501024665e..67a2d7a793f6 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -460,7 +460,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	}
 
 validate_credit:
-	if ((work->conn->vals->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU) &&
+	if ((work->conn->vals->req_capabilities & SMB2_GLOBAL_CAP_LARGE_MTU) &&
 	    smb2_validate_credit_charge(work->conn, hdr))
 		return 1;
 
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 606aa3c5189a..bcf05caa2304 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -15,7 +15,7 @@
 static struct smb_version_values smb21_server_values = {
 	.version_string = SMB21_VERSION_STRING,
 	.protocol_id = SMB21_PROT_ID,
-	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
 	.max_read_size = SMB21_DEFAULT_IOSIZE,
 	.max_write_size = SMB21_DEFAULT_IOSIZE,
 	.max_trans_size = SMB21_DEFAULT_IOSIZE,
@@ -41,7 +41,7 @@ static struct smb_version_values smb21_server_values = {
 static struct smb_version_values smb30_server_values = {
 	.version_string = SMB30_VERSION_STRING,
 	.protocol_id = SMB30_PROT_ID,
-	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
 	.max_read_size = SMB3_DEFAULT_IOSIZE,
 	.max_write_size = SMB3_DEFAULT_IOSIZE,
 	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
@@ -68,7 +68,7 @@ static struct smb_version_values smb30_server_values = {
 static struct smb_version_values smb302_server_values = {
 	.version_string = SMB302_VERSION_STRING,
 	.protocol_id = SMB302_PROT_ID,
-	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
 	.max_read_size = SMB3_DEFAULT_IOSIZE,
 	.max_write_size = SMB3_DEFAULT_IOSIZE,
 	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
@@ -95,7 +95,7 @@ static struct smb_version_values smb302_server_values = {
 static struct smb_version_values smb311_server_values = {
 	.version_string = SMB311_VERSION_STRING,
 	.protocol_id = SMB311_PROT_ID,
-	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
 	.max_read_size = SMB3_DEFAULT_IOSIZE,
 	.max_write_size = SMB3_DEFAULT_IOSIZE,
 	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
@@ -204,7 +204,7 @@ void init_smb2_1_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_HMAC_SHA256_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_LEASING;
 }
 
 /**
@@ -221,20 +221,20 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
 	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 }
 
 /**
@@ -251,19 +251,19 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
 	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
 	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
 }
 
 /**
@@ -280,14 +280,14 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
+		conn->vals->req_capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
 
 	INIT_LIST_HEAD(&conn->preauth_sess_table);
 	return 0;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b731d9b09408..8a615e8c600f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -282,7 +282,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	/* Not setting conn guid rsp->ServerGUID, as it
 	 * not used by client for identifying connection
 	 */
-	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	rsp->Capabilities = cpu_to_le32(conn->vals->req_capabilities);
 	/* Default Max Message Size till SMB2.0, 64K*/
 	rsp->MaxTransactSize = cpu_to_le32(conn->vals->max_trans_size);
 	rsp->MaxReadSize = cpu_to_le32(conn->vals->max_read_size);
@@ -956,7 +956,7 @@ bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
 	 * SMB 3.0 and 3.0.2 dialects use the SMB2_GLOBAL_CAP_ENCRYPTION flag.
 	 * SMB 3.1.1 uses the cipher_type field.
 	 */
-	return (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) ||
+	return (conn->vals->req_capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) ||
 	    conn->cipher_type;
 }
 
@@ -1210,7 +1210,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		rc = -EINVAL;
 		goto err_out;
 	}
-	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	rsp->Capabilities = cpu_to_le32(conn->vals->req_capabilities);
 
 	/* For stats */
 	conn->connection_type = conn->dialect;
@@ -3474,7 +3474,7 @@ int smb2_open(struct ksmbd_work *work)
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
-	     !(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
+	     !(conn->vals->req_capabilities & SMB2_GLOBAL_CAP_LEASING))) {
 		if (share_ret < 0 && !S_ISDIR(file_inode(fp->filp)->i_mode)) {
 			rc = share_ret;
 			goto err_out1;
@@ -7977,7 +7977,7 @@ static int fsctl_validate_negotiate_info(struct ksmbd_conn *conn,
 		goto err_out;
 	}
 
-	neg_rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	neg_rsp->Capabilities = cpu_to_le32(conn->vals->req_capabilities);
 	memset(neg_rsp->Guid, 0, SMB2_CLIENT_GUID_SIZE);
 	neg_rsp->SecurityMode = cpu_to_le16(conn->srv_sec_mode);
 	neg_rsp->Dialect = cpu_to_le16(conn->dialect);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 863716207a0d..dac783b46545 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -338,35 +338,6 @@ struct file_id_full_dir_info {
 	char FileName[];
 } __packed; /* level 0x105 FF rsp data */
 
-struct smb_version_values {
-	char		*version_string;
-	__u16		protocol_id;
-	__le16		lock_cmd;
-	__u32		capabilities;
-	__u32		max_read_size;
-	__u32		max_write_size;
-	__u32		max_trans_size;
-	__u32		max_credits;
-	__u32		large_lock_type;
-	__u32		exclusive_lock_type;
-	__u32		shared_lock_type;
-	__u32		unlock_lock_type;
-	size_t		header_size;
-	size_t		max_header_size;
-	size_t		read_rsp_size;
-	unsigned int	cap_unix;
-	unsigned int	cap_nt_find;
-	unsigned int	cap_large_files;
-	__u16		signing_enabled;
-	__u16		signing_required;
-	size_t		create_lease_size;
-	size_t		create_durable_size;
-	size_t		create_durable_v2_size;
-	size_t		create_mxac_size;
-	size_t		create_disk_id_size;
-	size_t		create_posix_size;
-};
-
 struct filesystem_posix_info {
 	/* For undefined recommended transfer size return -1 in that field */
 	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
-- 
2.43.0


