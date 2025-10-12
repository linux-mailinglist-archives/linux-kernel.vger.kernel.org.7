Return-Path: <linux-kernel+bounces-849577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28EBD06F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3280D3BF102
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5152EE60B;
	Sun, 12 Oct 2025 16:19:29 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F262EC0BC;
	Sun, 12 Oct 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285961; cv=none; b=Bq2aWOAte1E1JE7xNpMCHppbQ6DYu9YCH97pKa/s2P1r2x73tyt4B57e4H4Ham4VI+gUI4b8LH4s24+DiaBtNEWZHeT8wcH8SixVMKpVVJlcKDRs3j4QxUezhoYt4qp7f1IFwOsL0W4Bz00N7l0Kw1/md4LhKQHLtCXz8avTGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285961; c=relaxed/simple;
	bh=oteY2DB6t8StVBkclNm0ZCXNfCcJGBmqqtuWOd8wqCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDR/IqqzUn0E4bUwp4nMDSUfh97qyCFsVuGuFZpuN6d3TqZgO0gIleZp/eJoU0CLKB6rBM+pMFjVZo5Xm1GD0HKNn0jGXcEFKHxNxIH0fonysIqIsPv9BC45wPkWNLf0O9N2VswgMpEGqfHD+PVZLzS1sqiVeoYtwH4Iq8xGGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: esmtpgz15t1760285912t29474fab
X-QQ-Originating-IP: GWAN70WUYEKW1xQjq+p8VERurzYHevhwA81fnCclqjQ=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Oct 2025 00:18:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11669508414891320173
From: chenxiaosong@chenxiaosong.com
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
	zhangguodong@kylinos.cn
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 09/22] smb: move copychunk definitions to common/smb2pdu.h
Date: Mon, 13 Oct 2025 00:17:36 +0800
Message-ID: <45EC3C7FE8122B2C+20251012161749.2994033-10-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012161749.2994033-1-chenxiaosong@chenxiaosong.com>
References: <20251012161749.2994033-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mbx0tgFTjpCkxpVSIIcjDPRJEAR3EbukuDMfp0bVkssY3ij3IUK+MLzt
	we/HFlnGQaa5dQ/fNCpVdU0MLr8cuZKVUW2qQL9mtrRyR7KmOVfDA+VLiJPB3hgzJnKHlBe
	TNwx7aWZVqK563VPi8w27MLly4k2+ntVo6ufj9rFNZCfWEe0I9KfkitE27RKa6nXKLtFD8r
	fCUv5MkZr1J3qsr1m3cQxN6sBrOk8pot3+LHBdnAX2slbd/HaIZm/kpw0TNGPST1lxOHxOn
	2+BpWIzfHT/LAL+eXa1+NZOnX3dRodOIafg/ygoa/AXss3D08y23zCIx2ew7oDwBm2hoSKo
	+fywJq8Sl/2R+dQQk2vpihou+ai0v3WsXjOBwwFpfZiLW19I4uMhaGf8wMxRviK31AJZOxs
	Bklk1LBUFB9b53ghz/oYf66lOuHvXOkmh+43Dx6INYKCaHEcShH2mR/hxad8lRD3YSrcmoS
	n7I/8ifyNmEyr0c2f/aRyp50JgncFCvId4r/NsLVomkqAetITTWH+6T4m5ISHUBNVELnKIe
	JEJoRY0bgGVpOqS1nUtHwMvwy/XjptNsSVsLGmfVcs1sTHRGZ5eBJ8hP3JkusDHvLHC7GMD
	bE4f+Y/mg0DIL17/o4KZoqD/tC0ryUixAwijMm+v2nHMrLihhdMgE+P4i5j1SHaKD1Qo8zj
	OJwlzhi8J1CGfYnCHlVpp1DNa8qXhDrxDnk8/t5OzbpvGww7ggH46QZCZjU8zx27Kvt8lUt
	/xtoymDrwF5MHukjvCRjb3s7SjUnMMINOWpNbg2wFH5bHGCvJHk1spG8xP/zb08oKR+ZYuu
	Kp5SWCzomp/QKpKOMwl4PosOV5eNMZS42Oa+d9IgL+yRg9+AlwOzmFoj8KDmvqqHVmN/ezq
	ywswdxe3uZAmfIbqtRtLXGVlpKcrAdtUaEiop6lA0PKf+xjqnflOChTz6AnMMlIfMn1///a
	a+XpHPJJAQy6afRDIzonC+zTqWJ4U3UEmG4w2cVRxD+0eLocJgW7GgiG1+0DUIzSWJd5z5m
	KwzRxwzrWrvAX85ox6KN9eNuBKiPXSoizxJyKw2jXWuV6scm2O
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

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
index d9cf7db0ac35..c86a329e5822 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1323,14 +1323,6 @@ typedef struct smb_com_ntransact_rsp {
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
index e90ca77d2ac7..ea9709d81851 100644
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
index 0be63c00f848..9b5880e60a4e 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -191,36 +191,12 @@ struct crt_sd_ctxt {
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
index b01114108d23..857e6a577e84 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1392,6 +1392,35 @@ struct smb2_ioctl_req {
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
index dd6f1375a833..846cca45195b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7757,11 +7757,11 @@ static int fsctl_copychunk(struct ksmbd_work *work,
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
index 5a76b706ccd9..eecd1f1f5505 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -157,26 +157,6 @@ struct resume_key_ioctl_rsp {
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


