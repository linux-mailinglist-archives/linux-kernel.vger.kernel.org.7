Return-Path: <linux-kernel+bounces-849586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16BBD0740
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8C754EF4A2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6AF2EF64D;
	Sun, 12 Oct 2025 16:21:03 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456292ECEBB;
	Sun, 12 Oct 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286048; cv=none; b=oUMELi0ioQ/pU3aSWCmywjkkdXVeIxTbWMjEiLm/XJFvKnfKRca6QEreb+CKVpIwBbmbDhjanFQYCA+ZxQjGBFTn4PG1bUzTXApmqI8OK963ucFngwWm4tMnYXbqtvpY2xcByiPkHE38p3M0vGX7zVIStfORpm+ERNxsSzVES1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286048; c=relaxed/simple;
	bh=0jipzrpcnVOgT74CwCWD0FKFQxM2RdUoPYok6jhANYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWUOLcjdil99zJSZ3c/HbVkYI4wNRYlO9Jt2aQfqDRpWJOa5wQqUVHVL6gv5eUDaGH7PGl5/PQlU3PZl4mtb6GUGHTKgT4zet4CJrm8ZXsXf/ksiwSK43812Qwmwodoc01HsokTzsfh+Rts7lG6FpvH5wtQUmCo4uThlbr2iTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: esmtpgz15t1760285921t31108ae1
X-QQ-Originating-IP: /joD++aPpOUE1sdnsIT1MkzbK+3JtYBf542pSq0M4Rw=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Oct 2025 00:18:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9083543551103487012
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
Subject: [PATCH v2 13/22] smb: move file access permission bits definitions to common/cifspdu.h
Date: Mon, 13 Oct 2025 00:17:40 +0800
Message-ID: <B4EA08F518242A2F+20251012161749.2994033-14-chenxiaosong@chenxiaosong.com>
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
X-QQ-XMAILINFO: MSOp5WiNUVk6U0NPFkETIDrxNEsayJT3buHUFSvbkJId/+hJmq88RSD4
	qqUImy9TBMf1Onn1WA4PupN1/yRfYRcaQ/QbeAlWSqas3S50Ah74fUEz+soluCXcEg24gWI
	bOpR31HgiXucYMOROgzQsU/zlPMFRwfgjGYweCx8U1G64hC2+Nnf1FxoVlYm/K6K6Vi5ea2
	a87vWjFvmOP7Or1exUpJbvszGoBGoLkEz3fdcxtevrUlpCbxOat//ryCKMNMU9Y7O8P4I2A
	TqYQkrHBttbiKREFhh6lAgNoo4VXudxfEzGAB77B8fH9bB1u0js6eZvLmiGcGEkDfSN1JZJ
	ucZox1u9XraoM4bLhlwQb4DO7OcLNNRXyDD4o98xgTZLQNSNetxH9WuGb8bPYD3XAS1SA91
	AQmpGZkTFjOo0WqxPSnWUzuaYfVyCh3oXrF8yPdzAGjGCsFhI78ghbAjLbwZqlEWsPoQWIM
	+zH8c84SEn63vY9j434M57hRlHpXdZ5V4ZKQ544uIO9LC2eGnnzySn3ymw8n9Alg7IEE4ah
	dKpbBohLJOfq3QB+n21AMzUx2/769C3mObjpU3p5VSiQjdLjOY3V3FZ1WCYp3AqUpUumbbd
	JfHkwxbRUN/mH5qRjIn+amCFS+Yux59tzW6/BahpjlfhEMkBrTXq20gb1Z5bE6eAg6nF9pT
	s8z+gpBwn1256lDtLpW8V4QNvFzibD8wYBsMyGHxDVeFwI5FakD9J3g9xRMJ9h0FyFVw71I
	DbH1VraZcUHFNuTh03TC7nNUbH9N2kFzubH9dUdreX6cJFADG4H7unO7Hd2dtwDFXpdk+wJ
	6aMU+UZ1tbD5dyZkjHeLVRzdXdY3cEccLZme0ehOmBkuk4z6I1d3w/Z5k46mbSbE/JxqHW/
	y8c3A6WRGlgcrx+QIGXEc+9JGnrGuS16KNr7NwLXLmfn9fzGAq4BBZ8cs1VV78X1DExLH8I
	4ZLNCZs3NawGEIdXk5PBBoqACslNPVPpHE7ZKCwts4+JMrP/elI1yZB1jkWRVVF5Ar1OMEu
	BMmxjpvCvjs8GeiGHL6OzOFWC6VygImoWknmBYfb2WB5rfrIcZlLFE8ThVM6xQeNh02KgEM
	VIW8+WLtdx/
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

There are only 2 different definitions between the client and server:

  - SET_FILE_READ_RIGHTS
  - SET_FILE_WRITE_RIGHTS

Perhaps in the future we can change them to be the same.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifsacl.c    |   4 +-
 fs/smb/client/cifspdu.h    | 112 ---------------------------------
 fs/smb/common/cifspdu.h    | 123 ++++++++++++++++++++++++++++++++++++-
 fs/smb/common/smb2pdu.h    |   6 --
 fs/smb/server/smb_common.h |  55 -----------------
 fs/smb/server/smbacl.c     |   2 +-
 6 files changed, 125 insertions(+), 177 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 63b3b1290bed..ef12ae0fddb3 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -655,9 +655,9 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	   is this but we have cleared all the bits sans RWX for
 	   either user or group or other as per bits_to_use */
 	if (mode & S_IRUGO)
-		*pace_flags |= SET_FILE_READ_RIGHTS;
+		*pace_flags |= CLIENT_SET_FILE_READ_RIGHTS;
 	if (mode & S_IWUGO)
-		*pace_flags |= SET_FILE_WRITE_RIGHTS;
+		*pace_flags |= CLIENT_SET_FILE_WRITE_RIGHTS;
 	if (mode & S_IXUGO)
 		*pace_flags |= SET_FILE_EXEC_RIGHTS;
 
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 9f42b0469d1a..a0883b1fda16 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -116,118 +116,6 @@
 #define SMBOPEN_OTRUNC        0x0002
 #define SMBOPEN_OAPPEND       0x0001
 
-/*
- * These are the file access permission bits defined in CIFS for the
- * NTCreateAndX as well as the level 0x107
- * TRANS2_QUERY_PATH_INFORMATION API.  The level 0x107, SMB_QUERY_FILE_ALL_INFO
- * responds with the AccessFlags.
- * The AccessFlags specifies the access permissions a caller has to the
- * file and can have any suitable combination of the following values:
- */
-
-#define FILE_READ_DATA        0x00000001  /* Data can be read from the file   */
-					  /* or directory child entries can   */
-					  /* be listed together with the      */
-					  /* associated child attributes      */
-					  /* (so the FILE_READ_ATTRIBUTES on  */
-					  /* the child entry is not needed)   */
-#define FILE_WRITE_DATA       0x00000002  /* Data can be written to the file  */
-					  /* or new file can be created in    */
-					  /* the directory                    */
-#define FILE_APPEND_DATA      0x00000004  /* Data can be appended to the file */
-					  /* (for non-local files over SMB it */
-					  /* is same as FILE_WRITE_DATA)      */
-					  /* or new subdirectory can be       */
-					  /* created in the directory         */
-#define FILE_READ_EA          0x00000008  /* Extended attributes associated   */
-					  /* with the file can be read        */
-#define FILE_WRITE_EA         0x00000010  /* Extended attributes associated   */
-					  /* with the file can be written     */
-#define FILE_EXECUTE          0x00000020  /*Data can be read into memory from */
-					  /* the file using system paging I/O */
-					  /* for executing the file / script  */
-					  /* or right to traverse directory   */
-					  /* (but by default all users have   */
-					  /* directory bypass traverse        */
-					  /* privilege and do not need this   */
-					  /* permission on directories at all)*/
-#define FILE_DELETE_CHILD     0x00000040  /* Child entry can be deleted from  */
-					  /* the directory (so the DELETE on  */
-					  /* the child entry is not needed)   */
-#define FILE_READ_ATTRIBUTES  0x00000080  /* Attributes associated with the   */
-					  /* file or directory can be read    */
-#define FILE_WRITE_ATTRIBUTES 0x00000100  /* Attributes associated with the   */
-					  /* file or directory can be written */
-#define DELETE                0x00010000  /* The file or dir can be deleted   */
-#define READ_CONTROL          0x00020000  /* The discretionary access control */
-					  /* list and ownership associated    */
-					  /* with the file or dir can be read */
-#define WRITE_DAC             0x00040000  /* The discretionary access control */
-					  /* list associated with the file or */
-					  /* directory can be written         */
-#define WRITE_OWNER           0x00080000  /* Ownership information associated */
-					  /* with the file/dir can be written */
-#define SYNCHRONIZE           0x00100000  /* The file handle can waited on to */
-					  /* synchronize with the completion  */
-					  /* of an input/output request       */
-#define SYSTEM_SECURITY       0x01000000  /* The system access control list   */
-					  /* associated with the file or      */
-					  /* directory can be read or written */
-					  /* (cannot be in DACL, can in SACL) */
-#define MAXIMUM_ALLOWED       0x02000000  /* Maximal subset of GENERIC_ALL    */
-					  /* permissions which can be granted */
-					  /* (cannot be in DACL nor SACL)     */
-#define GENERIC_ALL           0x10000000  /* Same as: GENERIC_EXECUTE |       */
-					  /*          GENERIC_WRITE |         */
-					  /*          GENERIC_READ |          */
-					  /*          FILE_DELETE_CHILD |     */
-					  /*          DELETE |                */
-					  /*          WRITE_DAC |             */
-					  /*          WRITE_OWNER             */
-					  /* So GENERIC_ALL contains all bits */
-					  /* mentioned above except these two */
-					  /* SYSTEM_SECURITY  MAXIMUM_ALLOWED */
-#define GENERIC_EXECUTE       0x20000000  /* Same as: FILE_EXECUTE |          */
-					  /*          FILE_READ_ATTRIBUTES |  */
-					  /*          READ_CONTROL |          */
-					  /*          SYNCHRONIZE             */
-#define GENERIC_WRITE         0x40000000  /* Same as: FILE_WRITE_DATA |       */
-					  /*          FILE_APPEND_DATA |      */
-					  /*          FILE_WRITE_EA |         */
-					  /*          FILE_WRITE_ATTRIBUTES | */
-					  /*          READ_CONTROL |          */
-					  /*          SYNCHRONIZE             */
-#define GENERIC_READ          0x80000000  /* Same as: FILE_READ_DATA |        */
-					  /*          FILE_READ_EA |          */
-					  /*          FILE_READ_ATTRIBUTES |  */
-					  /*          READ_CONTROL |          */
-					  /*          SYNCHRONIZE             */
-
-#define FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_READ_ATTRIBUTES)
-#define FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
-				| FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES)
-#define FILE_EXEC_RIGHTS (FILE_EXECUTE)
-
-#define SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_WRITE_EA \
-				| FILE_READ_ATTRIBUTES \
-				| FILE_WRITE_ATTRIBUTES \
-				| DELETE | READ_CONTROL | WRITE_DAC \
-				| WRITE_OWNER | SYNCHRONIZE)
-#define SET_FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
-				| FILE_READ_EA | FILE_WRITE_EA \
-				| FILE_READ_ATTRIBUTES \
-				| FILE_WRITE_ATTRIBUTES \
-				| DELETE | READ_CONTROL | WRITE_DAC \
-				| WRITE_OWNER | SYNCHRONIZE)
-#define SET_FILE_EXEC_RIGHTS (FILE_READ_EA | FILE_WRITE_EA | FILE_EXECUTE \
-				| FILE_READ_ATTRIBUTES \
-				| FILE_WRITE_ATTRIBUTES \
-				| DELETE | READ_CONTROL | WRITE_DAC \
-				| WRITE_OWNER | SYNCHRONIZE)
-
-#define SET_MINIMUM_RIGHTS (FILE_READ_EA | FILE_READ_ATTRIBUTES \
-				| READ_CONTROL | SYNCHRONIZE)
-
 /*
  * Invalid readdir handle
  */
diff --git a/fs/smb/common/cifspdu.h b/fs/smb/common/cifspdu.h
index ca16741b5947..59e5425cdc8d 100644
--- a/fs/smb/common/cifspdu.h
+++ b/fs/smb/common/cifspdu.h
@@ -77,7 +77,128 @@
 #define SMBFLG2_UNICODE cpu_to_le16(0x8000)
 
 /*
- * File Attribute flags
+ * These are the file access permission bits defined in CIFS for the
+ * NTCreateAndX as well as the level 0x107
+ * TRANS2_QUERY_PATH_INFORMATION API.  The level 0x107, SMB_QUERY_FILE_ALL_INFO
+ * responds with the AccessFlags.
+ * The AccessFlags specifies the access permissions a caller has to the
+ * file and can have any suitable combination of the following values:
+ */
+
+#define FILE_READ_DATA        0x00000001  /* Data can be read from the file   */
+					  /* or directory child entries can   */
+					  /* be listed together with the      */
+					  /* associated child attributes      */
+					  /* (so the FILE_READ_ATTRIBUTES on  */
+					  /* the child entry is not needed)   */
+#define FILE_WRITE_DATA       0x00000002  /* Data can be written to the file  */
+					  /* or new file can be created in    */
+					  /* the directory                    */
+#define FILE_APPEND_DATA      0x00000004  /* Data can be appended to the file */
+					  /* (for non-local files over SMB it */
+					  /* is same as FILE_WRITE_DATA)      */
+					  /* or new subdirectory can be       */
+					  /* created in the directory         */
+#define FILE_READ_EA          0x00000008  /* Extended attributes associated   */
+					  /* with the file can be read        */
+#define FILE_WRITE_EA         0x00000010  /* Extended attributes associated   */
+					  /* with the file can be written     */
+#define FILE_EXECUTE          0x00000020  /*Data can be read into memory from */
+					  /* the file using system paging I/O */
+					  /* for executing the file / script  */
+					  /* or right to traverse directory   */
+					  /* (but by default all users have   */
+					  /* directory bypass traverse        */
+					  /* privilege and do not need this   */
+					  /* permission on directories at all)*/
+#define FILE_DELETE_CHILD     0x00000040  /* Child entry can be deleted from  */
+					  /* the directory (so the DELETE on  */
+					  /* the child entry is not needed)   */
+#define FILE_READ_ATTRIBUTES  0x00000080  /* Attributes associated with the   */
+					  /* file or directory can be read    */
+#define FILE_WRITE_ATTRIBUTES 0x00000100  /* Attributes associated with the   */
+					  /* file or directory can be written */
+#define DELETE                0x00010000  /* The file or dir can be deleted   */
+#define READ_CONTROL          0x00020000  /* The discretionary access control */
+					  /* list and ownership associated    */
+					  /* with the file or dir can be read */
+#define WRITE_DAC             0x00040000  /* The discretionary access control */
+					  /* list associated with the file or */
+					  /* directory can be written         */
+#define WRITE_OWNER           0x00080000  /* Ownership information associated */
+					  /* with the file/dir can be written */
+#define SYNCHRONIZE           0x00100000  /* The file handle can waited on to */
+					  /* synchronize with the completion  */
+					  /* of an input/output request       */
+#define SYSTEM_SECURITY       0x01000000  /* The system access control list   */
+					  /* associated with the file or      */
+					  /* directory can be read or written */
+					  /* (cannot be in DACL, can in SACL) */
+#define MAXIMUM_ALLOWED       0x02000000  /* Maximal subset of GENERIC_ALL    */
+					  /* permissions which can be granted */
+					  /* (cannot be in DACL nor SACL)     */
+#define GENERIC_ALL           0x10000000  /* Same as: GENERIC_EXECUTE |       */
+					  /*          GENERIC_WRITE |         */
+					  /*          GENERIC_READ |          */
+					  /*          FILE_DELETE_CHILD |     */
+					  /*          DELETE |                */
+					  /*          WRITE_DAC |             */
+					  /*          WRITE_OWNER             */
+					  /* So GENERIC_ALL contains all bits */
+					  /* mentioned above except these two */
+					  /* SYSTEM_SECURITY  MAXIMUM_ALLOWED */
+#define GENERIC_EXECUTE       0x20000000  /* Same as: FILE_EXECUTE |          */
+					  /*          FILE_READ_ATTRIBUTES |  */
+					  /*          READ_CONTROL |          */
+					  /*          SYNCHRONIZE             */
+#define GENERIC_WRITE         0x40000000  /* Same as: FILE_WRITE_DATA |       */
+					  /*          FILE_APPEND_DATA |      */
+					  /*          FILE_WRITE_EA |         */
+					  /*          FILE_WRITE_ATTRIBUTES | */
+					  /*          READ_CONTROL |          */
+					  /*          SYNCHRONIZE             */
+#define GENERIC_READ          0x80000000  /* Same as: FILE_READ_DATA |        */
+					  /*          FILE_READ_EA |          */
+					  /*          FILE_READ_ATTRIBUTES |  */
+					  /*          READ_CONTROL |          */
+					  /*          SYNCHRONIZE             */
+
+#define FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_READ_ATTRIBUTES)
+#define FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
+				| FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES)
+#define FILE_EXEC_RIGHTS (FILE_EXECUTE)
+
+#define CLIENT_SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_WRITE_EA \
+				| FILE_READ_ATTRIBUTES \
+				| FILE_WRITE_ATTRIBUTES \
+				| DELETE | READ_CONTROL | WRITE_DAC \
+				| WRITE_OWNER | SYNCHRONIZE)
+#define SERVER_SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
+				| FILE_READ_ATTRIBUTES \
+				| DELETE | READ_CONTROL | WRITE_DAC \
+				| WRITE_OWNER | SYNCHRONIZE)
+#define CLIENT_SET_FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
+				| FILE_READ_EA | FILE_WRITE_EA \
+				| FILE_READ_ATTRIBUTES \
+				| FILE_WRITE_ATTRIBUTES \
+				| DELETE | READ_CONTROL | WRITE_DAC \
+				| WRITE_OWNER | SYNCHRONIZE)
+#define SERVER_SET_FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
+				| FILE_WRITE_EA \
+				| FILE_DELETE_CHILD \
+				| FILE_WRITE_ATTRIBUTES \
+				| DELETE | READ_CONTROL | WRITE_DAC \
+				| WRITE_OWNER | SYNCHRONIZE)
+#define SET_FILE_EXEC_RIGHTS (FILE_READ_EA | FILE_WRITE_EA | FILE_EXECUTE \
+				| FILE_READ_ATTRIBUTES \
+				| FILE_WRITE_ATTRIBUTES \
+				| DELETE | READ_CONTROL | WRITE_DAC \
+				| WRITE_OWNER | SYNCHRONIZE)
+#define SET_MINIMUM_RIGHTS (FILE_READ_EA | FILE_READ_ATTRIBUTES \
+				| READ_CONTROL | SYNCHRONIZE)
+
+/*
+ * File Attribute flags - see MS-SMB 2.2.1.4.1
  */
 #define ATTR_READONLY  0x0001
 #define ATTR_HIDDEN    0x0002
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index f5c8c72b8959..40689c11e97a 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1149,12 +1149,6 @@ struct smb2_server_client_notification {
 #define FILE_OVERWRITE_IF_LE		cpu_to_le32(0x00000005)
 #define FILE_CREATE_MASK_LE             cpu_to_le32(0x00000007)
 
-#define FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
-			| FILE_READ_ATTRIBUTES)
-#define FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
-			| FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES)
-#define FILE_EXEC_RIGHTS (FILE_EXECUTE)
-
 /* CreateOptions Flags */
 #define FILE_DIRECTORY_FILE_LE		cpu_to_le32(0x00000001)
 /* same as #define CREATE_NOT_FILE_LE	cpu_to_le32(0x00000001) */
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index a326809f7765..90015cd8fe4e 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -37,61 +37,6 @@
 #define F_CREATED	2
 #define F_OVERWRITTEN	3
 
-#define FILE_READ_DATA        0x00000001  /* Data can be read from the file   */
-#define FILE_WRITE_DATA       0x00000002  /* Data can be written to the file  */
-#define FILE_APPEND_DATA      0x00000004  /* Data can be appended to the file */
-#define FILE_READ_EA          0x00000008  /* Extended attributes associated   */
-/* with the file can be read        */
-#define FILE_WRITE_EA         0x00000010  /* Extended attributes associated   */
-/* with the file can be written     */
-#define FILE_EXECUTE          0x00000020  /*Data can be read into memory from */
-/* the file using system paging I/O */
-#define FILE_DELETE_CHILD     0x00000040
-#define FILE_READ_ATTRIBUTES  0x00000080  /* Attributes associated with the   */
-/* file can be read                 */
-#define FILE_WRITE_ATTRIBUTES 0x00000100  /* Attributes associated with the   */
-/* file can be written              */
-#define DELETE                0x00010000  /* The file can be deleted          */
-#define READ_CONTROL          0x00020000  /* The access control list and      */
-/* ownership associated with the    */
-/* file can be read                 */
-#define WRITE_DAC             0x00040000  /* The access control list and      */
-/* ownership associated with the    */
-/* file can be written.             */
-#define WRITE_OWNER           0x00080000  /* Ownership information associated */
-/* with the file can be written     */
-#define SYNCHRONIZE           0x00100000  /* The file handle can waited on to */
-/* synchronize with the completion  */
-/* of an input/output request       */
-#define GENERIC_ALL           0x10000000
-#define GENERIC_EXECUTE       0x20000000
-#define GENERIC_WRITE         0x40000000
-#define GENERIC_READ          0x80000000
-/* In summary - Relevant file       */
-/* access flags from CIFS are       */
-/* file_read_data, file_write_data  */
-/* file_execute, file_read_attributes*/
-/* write_dac, and delete.           */
-
-#define SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
-		| FILE_READ_ATTRIBUTES \
-		| DELETE | READ_CONTROL | WRITE_DAC \
-		| WRITE_OWNER | SYNCHRONIZE)
-#define SET_FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
-		| FILE_WRITE_EA \
-		| FILE_DELETE_CHILD \
-		| FILE_WRITE_ATTRIBUTES \
-		| DELETE | READ_CONTROL | WRITE_DAC \
-		| WRITE_OWNER | SYNCHRONIZE)
-#define SET_FILE_EXEC_RIGHTS (FILE_READ_EA | FILE_WRITE_EA | FILE_EXECUTE \
-		| FILE_READ_ATTRIBUTES \
-		| FILE_WRITE_ATTRIBUTES \
-		| DELETE | READ_CONTROL | WRITE_DAC \
-		| WRITE_OWNER | SYNCHRONIZE)
-
-#define SET_MINIMUM_RIGHTS (FILE_READ_EA | FILE_READ_ATTRIBUTES \
-		| READ_CONTROL | SYNCHRONIZE)
-
 /* generic flags for file open */
 #define GENERIC_READ_FLAGS	(READ_CONTROL | FILE_READ_DATA | \
 		FILE_READ_ATTRIBUTES | \
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 5aa7a66334d9..b70ba50f1f10 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -180,7 +180,7 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	 * either user or group or other as per bits_to_use
 	 */
 	if (mode & 0444)
-		*pace_flags |= SET_FILE_READ_RIGHTS;
+		*pace_flags |= SERVER_SET_FILE_READ_RIGHTS;
 	if (mode & 0222)
 		*pace_flags |= FILE_WRITE_RIGHTS;
 	if (mode & 0111)
-- 
2.43.0


