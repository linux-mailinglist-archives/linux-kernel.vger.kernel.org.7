Return-Path: <linux-kernel+bounces-870970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D9EC0C1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9237218A23FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3602DCBFA;
	Mon, 27 Oct 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYffRcEV"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0D2DCBE6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549851; cv=none; b=QrtOiw1+/myNPfc0Wpnzgnh+8w3e6ai5ZUNCOfvcN++z3ZwHg5ADepLMUSMD5vAXattrqUtxy+dN+TQ+cmsBrCmVgcpT9noAaY6/EcpKE8C4/rioW7CSLservPDooCRw5NKIAJ8daPAWidAypjJycgMP8rKcRATR0Vy0LvGDuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549851; c=relaxed/simple;
	bh=mcRqZQTJUPiqU4u79mytixdsUIZDpfyQY+9yHxjsEAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geXoR795hNhP7a+vVAlzQsIFqplEfZ9lSNYf3atAFYqb0IdF7nM1C1o+viV1v7iVis8EYPeO1AuY6WAISRq9CboTzKNWLO6710dhVImkHMeWXnrV7Obj2sED92mHa43vcHs0SX+275TqZUzEuvKzyjBb+NrUp2Cbl1vG8aF6z1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYffRcEV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761549846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEClrBGHbbTS6rtEDLXzbO/0ts574gn/BdpdOKBZnEY=;
	b=pYffRcEVIzPWWyLg7EmhA1ksRfJ5aESL7GfnoRJJMWOy5gRi65Qo3d32yXzhnN7YK3LrAA
	8ujBhtUOW8D/xZKdKDdJv98/GjZjq2RF1GX/NqegmJKQV0jWF5HpEvODzQHBIUmDosecSs
	kz0q1OheQ3sol4jF8RfAyVHSIm6J/0s=
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
Subject: [PATCH v4 24/24] smb: move some duplicate definitions to common/smb2pdu.h
Date: Mon, 27 Oct 2025 15:22:06 +0800
Message-ID: <20251027072206.3468578-10-chenxiaosong.chenxiaosong@linux.dev>
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

In order to maintain the code more easily, move duplicate definitions to
common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
---
 fs/smb/client/smb2pdu.h | 21 ---------------------
 fs/smb/common/smb2pdu.h | 28 ++++++++++++++++++++++++++++
 fs/smb/server/smb2pdu.c |  8 ++++----
 fs/smb/server/smb2pdu.h | 19 -------------------
 4 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 0fcc903fbcd1..78bb99f29d38 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -133,11 +133,6 @@ struct share_redirect_error_context_rsp {
 #define SMB2_LEASE_HANDLE_CACHING_HE	0x02
 #define SMB2_LEASE_WRITE_CACHING_HE	0x04
 
-
-/* See MS-SMB2 2.2.13.2.11 */
-/* Flags */
-#define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
-
 /* See MS-SMB2 2.2.13.2.5 */
 struct crt_twarp_ctxt {
 	struct create_context_hdr ccontext;
@@ -198,22 +193,6 @@ struct network_resiliency_req {
 } __packed;
 /* There is no buffer for the response ie no struct network_resiliency_rsp */
 
-#define RSS_CAPABLE	cpu_to_le32(0x00000001)
-#define RDMA_CAPABLE	cpu_to_le32(0x00000002)
-
-#define INTERNETWORK	cpu_to_le16(0x0002)
-#define INTERNETWORKV6	cpu_to_le16(0x0017)
-
-struct network_interface_info_ioctl_rsp {
-	__le32 Next; /* next interface. zero if this is last one */
-	__le32 IfIndex;
-	__le32 Capability; /* RSS or RDMA Capable */
-	__le32 Reserved;
-	__le64 LinkSpeed;
-	__le16 Family;
-	__u8 Buffer[126];
-} __packed;
-
 #define NO_FILE_ID 0xFFFFFFFFFFFFFFFFULL /* general ioctls to srv not to file */
 
 struct compress_ioctl {
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index c7e64712f856..e781df6ca499 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1284,6 +1284,14 @@ struct create_mxac_req {
 	__le64 Timestamp;
 } __packed;
 
+/*
+ * Flags
+ * See MS-SMB2 2.2.13.2.11
+ *     MS-SMB2 2.2.13.2.12
+ *     MS-SMB2 2.2.14.2.12
+ */
+#define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
+
 /* See MS-SMB2 2.2.13.2.11 */
 struct durable_context_v2_req {
 	__le32 Timeout;
@@ -1493,6 +1501,26 @@ struct smb_sockaddr_in6 {
 	__u8   IPv6Address[16];
 	__be32 ScopeId;
 } __packed;
+ 
+/* See MS-SMB2 2.2.32.5 and MS-SMB2 2.2.32.5.1 */
+#define RSS_CAPABLE	cpu_to_le32(0x00000001)
+#define RDMA_CAPABLE	cpu_to_le32(0x00000002)
+#define INTERNETWORK	cpu_to_le16(0x0002)
+#define INTERNETWORKV6	cpu_to_le16(0x0017)
+struct network_interface_info_ioctl_rsp {
+	__le32 Next; /* next interface. zero if this is last one */
+	__le32 IfIndex;
+	__le32 Capability; /* RSS or RDMA Capable */
+	__le32 Reserved;
+	__le64 LinkSpeed;
+	union {
+		char	SockAddr_Storage[128];
+		struct {
+			__le16 Family;
+			__u8 Buffer[126];
+		};
+	};
+} __packed;
 
 /* this goes in the ioctl buffer when doing FSCTL_SET_ZERO_DATA */
 struct file_zero_data_information {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 96e50dd7d64f..c26fee9c1c51 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7876,9 +7876,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 
 		nii_rsp->Capability = 0;
 		if (netdev->real_num_tx_queues > 1)
-			nii_rsp->Capability |= cpu_to_le32(RSS_CAPABLE);
+			nii_rsp->Capability |= RSS_CAPABLE;
 		if (ksmbd_rdma_capable_netdev(netdev))
-			nii_rsp->Capability |= cpu_to_le32(RDMA_CAPABLE);
+			nii_rsp->Capability |= RDMA_CAPABLE;
 
 		nii_rsp->Next = cpu_to_le32(152);
 		nii_rsp->Reserved = 0;
@@ -7904,7 +7904,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (!ipv4_set) {
 			struct in_device *idev;
 
-			sockaddr_storage->Family = cpu_to_le16(INTERNETWORK);
+			sockaddr_storage->Family = INTERNETWORK;
 			sockaddr_storage->addr4.Port = 0;
 
 			idev = __in_dev_get_rtnl(netdev);
@@ -7920,7 +7920,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 			struct inet6_ifaddr *ifa;
 			__u8 *ipv6_addr = sockaddr_storage->addr6.IPv6Address;
 
-			sockaddr_storage->Family = cpu_to_le16(INTERNETWORKV6);
+			sockaddr_storage->Family = INTERNETWORKV6;
 			sockaddr_storage->addr6.Port = 0;
 			sockaddr_storage->addr6.FlowInfo = 0;
 
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index a6940e971047..66cdc8e4a648 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -83,10 +83,6 @@ struct create_durable_rsp {
 	} Data;
 } __packed;
 
-/* See MS-SMB2 2.2.13.2.11 */
-/* Flags */
-#define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
-
 /* equivalent of the contents of SMB3.1.1 POSIX open context response */
 struct create_posix_rsp {
 	struct create_context_hdr ccontext;
@@ -100,9 +96,6 @@ struct create_posix_rsp {
 
 #define SMB2_0_IOCTL_IS_FSCTL 0x00000001
 
-#define INTERNETWORK	0x0002
-#define INTERNETWORKV6	0x0017
-
 struct sockaddr_storage_rsp {
 	__le16 Family;
 	union {
@@ -111,18 +104,6 @@ struct sockaddr_storage_rsp {
 	};
 } __packed;
 
-#define RSS_CAPABLE	0x00000001
-#define RDMA_CAPABLE	0x00000002
-
-struct network_interface_info_ioctl_rsp {
-	__le32 Next; /* next interface. zero if this is last one */
-	__le32 IfIndex;
-	__le32 Capability; /* RSS or RDMA Capable */
-	__le32 Reserved;
-	__le64 LinkSpeed;
-	char	SockAddr_Storage[128];
-} __packed;
-
 struct file_object_buf_type1_ioctl_rsp {
 	__u8 ObjectId[16];
 	__u8 BirthVolumeId[16];
-- 
2.43.0


