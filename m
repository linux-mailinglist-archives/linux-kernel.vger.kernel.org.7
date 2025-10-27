Return-Path: <linux-kernel+bounces-870968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB5C0C1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECCC64EFCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA562E0923;
	Mon, 27 Oct 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F6haeWJk"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D82DE6F5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549842; cv=none; b=XesyBwe0kXsezePln2iXgLtDE1k4LgWsoqPR4OMtb9HA1ypiVmz03nKHEyt4N14q5vQTji7RdpLEmUYtKQkttUIwpEtVx6QRgnL3MDCbyAOGm8iyCowxJ0OC4xluV3/tfy2MHCZ15NJylsSjtWuZ58mEPOBdOOMCgwP5eMB3ZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549842; c=relaxed/simple;
	bh=1wP+8RqUhm5f9trzFZDZKEGkSzwUgvOQuGC/J+j2ZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obiDhmf4jZbKEYQTfdx+mbMbwH4Q5YlCG/ckrTzUtl4LNL9sl8BeK7uH/XetCtfmuYZAMTty/Y4lXg3vQwCnLrqK59Z1z/h7sJdMsXEnYeG+9w7ngN7ZCC5ifk9mFpoqBFQmBSPd/lqv5l3TgBdmYdLn56VmJFaiviQS2alFfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F6haeWJk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761549839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAg7H6k3Ss/PPdDpVyO/MSrA/oYwNacKlenw9To0wfA=;
	b=F6haeWJkxjscoYdsqUHf5NTZ5sXmh3r1Pq/Uap4STTA5nBhNWy/w/mrV0pol5r8DjvqcyJ
	VAd/ILenbMDAHYc0pzUDEGLzon4YaGpa0ThJf5gjEEs0QWNOAjCGshVfLoRAy0+46PFubO
	h8syXAJh7iO+MoRUqL3HaTOfmT6fnmo=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v4 22/24] smb: move copychunk definitions to common/smb2pdu.h
Date: Mon, 27 Oct 2025 15:22:04 +0800
Message-ID: <20251027072206.3468578-8-chenxiaosong.chenxiaosong@linux.dev>
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

From: ZhangGuoDong <zhangguodong@kylinos.cn>

Rename 3 places:

  - copychunk_ioctl -> copychunk_ioctl_req
  - copychunk -> srv_copychunk
  - server: ResumeKey -> SourceKeyU64

Merge the struct members of the server and the client, then move duplicate
definitions to common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
---
 fs/smb/client/cifspdu.h |  8 --------
 fs/smb/client/smb2ops.c |  6 +++---
 fs/smb/client/smb2pdu.h | 24 ------------------------
 fs/smb/common/smb2pdu.h | 29 +++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.c |  4 ++--
 fs/smb/server/smb2pdu.h | 20 --------------------
 6 files changed, 34 insertions(+), 57 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 55aaae6dbc86..157dbc344540 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1030,14 +1030,6 @@ typedef struct smb_com_ntransact_rsp {
 	/* parms and data follow */
 } __attribute__((packed)) NTRANSACT_RSP;
 
-/* See MS-SMB 2.2.7.2.1.1 */
-struct srv_copychunk {
-	__le64 SourceOffset;
-	__le64 DestinationOffset;
-	__le32 CopyLength;
-	__u32  Reserved;
-} __packed;
-
 typedef struct smb_com_transaction_ioctl_req {
 	struct smb_hdr hdr;	/* wct = 23 */
 	__u8 MaxSetupCount;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1b9995ebb895..a2319eef2801 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1524,7 +1524,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 static int
 SMB2_request_res_key(const unsigned int xid, struct cifs_tcon *tcon,
 		     u64 persistent_fid, u64 volatile_fid,
-		     struct copychunk_ioctl *pcchunk)
+		     struct copychunk_ioctl_req *pcchunk)
 {
 	int rc;
 	unsigned int ret_data_len;
@@ -1857,10 +1857,10 @@ smb2_copychunk_range(const unsigned int xid,
 {
 	int rc = 0;
 	unsigned int ret_data_len = 0;
-	struct copychunk_ioctl *cc_req = NULL;
+	struct copychunk_ioctl_req *cc_req = NULL;
 	struct copychunk_ioctl_rsp *cc_rsp = NULL;
 	struct cifs_tcon *tcon;
-	struct copychunk *chunk;
+	struct srv_copychunk *chunk;
 	u32 chunks, chunk_count, chunk_bytes;
 	u32 copy_bytes, copy_bytes_left;
 	u32 chunks_written, bytes_written;
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index a0f73b183c0e..f8aa4bcc5eac 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -158,36 +158,12 @@ struct crt_sd_ctxt {
 	struct smb3_sd sd;
 } __packed;
 
-
-#define COPY_CHUNK_RES_KEY_SIZE	24
 struct resume_key_req {
 	char ResumeKey[COPY_CHUNK_RES_KEY_SIZE];
 	__le32	ContextLength;	/* MBZ */
 	char	Context[];	/* ignored, Windows sets to 4 bytes of zero */
 } __packed;
 
-
-struct copychunk {
-	__le64 SourceOffset;
-	__le64 TargetOffset;
-	__le32 Length;
-	__le32 Reserved;
-} __packed;
-
-/* this goes in the ioctl buffer when doing a copychunk request */
-struct copychunk_ioctl {
-	char SourceKey[COPY_CHUNK_RES_KEY_SIZE];
-	__le32 ChunkCount;
-	__le32 Reserved;
-	struct copychunk Chunks[];
-} __packed;
-
-struct copychunk_ioctl_rsp {
-	__le32 ChunksWritten;
-	__le32 ChunkBytesWritten;
-	__le32 TotalBytesWritten;
-} __packed;
-
 /* See MS-FSCC 2.3.29 and 2.3.30 */
 struct get_retrieval_pointer_count_req {
 	__le64 StartingVcn; /* virtual cluster number (signed) */
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 2b56a17bccdb..319890c6d46b 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1424,6 +1424,35 @@ struct smb2_ioctl_req {
 	__u8   Buffer[];
 } __packed;
 
+/* See MS-SMB2 2.2.31.1.1 */
+struct srv_copychunk {
+	__le64 SourceOffset;
+	__le64 TargetOffset;
+	__le32 Length;
+	__le32 Reserved;
+} __packed;
+
+#define COPY_CHUNK_RES_KEY_SIZE	24
+
+/* See MS-SMB2 2.2.31.1 */
+/* this goes in the ioctl buffer when doing a copychunk request */
+struct copychunk_ioctl_req {
+	union {
+		char SourceKey[COPY_CHUNK_RES_KEY_SIZE];
+		__le64 SourceKeyU64[3];
+	};
+	__le32 ChunkCount;
+	__le32 Reserved;
+	struct srv_copychunk Chunks[] __counted_by_le(ChunkCount);
+} __packed;
+
+/* See MS-SMB2 2.2.32.1 */
+struct copychunk_ioctl_rsp {
+	__le32 ChunksWritten;
+	__le32 ChunkBytesWritten;
+	__le32 TotalBytesWritten;
+} __packed;
+
 struct smb2_ioctl_rsp {
 	struct smb2_hdr hdr;
 	__le16 StructureSize; /* Must be 49 */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c1ea4b747625..44e2cef70f27 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7764,11 +7764,11 @@ static int fsctl_copychunk(struct ksmbd_work *work,
 	}
 
 	src_fp = ksmbd_lookup_foreign_fd(work,
-					 le64_to_cpu(ci_req->ResumeKey[0]));
+					 le64_to_cpu(ci_req->SourceKeyU64[0]));
 	dst_fp = ksmbd_lookup_fd_slow(work, volatile_id, persistent_id);
 	ret = -EINVAL;
 	if (!src_fp ||
-	    src_fp->persistent_id != le64_to_cpu(ci_req->ResumeKey[1])) {
+	    src_fp->persistent_id != le64_to_cpu(ci_req->SourceKeyU64[1])) {
 		rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
 		goto out;
 	}
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index fb4df2860481..ab4359f384b3 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -136,26 +136,6 @@ struct resume_key_ioctl_rsp {
 	__u8 Context[4]; /* ignored, Windows sets to 4 bytes of zero */
 } __packed;
 
-struct srv_copychunk {
-	__le64 SourceOffset;
-	__le64 TargetOffset;
-	__le32 Length;
-	__le32 Reserved;
-} __packed;
-
-struct copychunk_ioctl_req {
-	__le64 ResumeKey[3];
-	__le32 ChunkCount;
-	__le32 Reserved;
-	struct srv_copychunk Chunks[] __counted_by_le(ChunkCount);
-} __packed;
-
-struct copychunk_ioctl_rsp {
-	__le32 ChunksWritten;
-	__le32 ChunkBytesWritten;
-	__le32 TotalBytesWritten;
-} __packed;
-
 struct file_sparse {
 	__u8	SetSparse;
 } __packed;
-- 
2.43.0


