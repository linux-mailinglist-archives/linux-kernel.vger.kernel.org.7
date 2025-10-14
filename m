Return-Path: <linux-kernel+bounces-851979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C29BD7DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B9C423812
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4130EF91;
	Tue, 14 Oct 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hqgY7aCv"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FF30ACF6;
	Tue, 14 Oct 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426483; cv=none; b=q2eVA8s8vk94+FGsJib5QM3e7KKqtSbg6PvcC2DgDSmbtTltFWTnvvbfZLnrDKLm1J3duRFH9CBkH6OJFvO4GWVyWMCgnJ904mOKx2KfNl1CwqhNblsMgv6ScNQ6LD1iY1r4pIeJM0XJqdSYpaDs1AeOG9lPRwdG1MTmivOGH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426483; c=relaxed/simple;
	bh=0KgLZcXT4B3Scyh0m2B3Vu+42f5ubEonkl6VlhlEx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx3PAKANI42tdblVNR5Jcz/LeLemZvf0d8jzX9CbARVIoY9IUtZ80o/k1SLMvP+RwkeBCCyB7/lTnUKSQQEqmAUIsR1lATL2LmOAJjym4WQJllmkjR8w3Rd/S52DoeKc3XjK1YipxFUnUbzYVmPDe6bJvpLt0vqqo2fki1htDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hqgY7aCv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760426479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c7nrLn66kCGvG7yTikXa4X342jlvF4mSKi/vVjbx9k=;
	b=hqgY7aCvImibOvyuTWn8CFv/imvJNkPsJ1XqjpJEMsKs9dFWx9JL/GkVc32JJ5W2/te6c8
	DDary5I3WH8Qaz+QlafMllFK7yw1j71VpxvpS/dp4hKFbjHVxW6zQD5F8YEmiMQ28gzOqU
	iKe3IHujALGEmYpLyR1pg5FbmMhzMgs=
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
Subject: [PATCH v3 06/22] smb: move SMB1_PROTO_NUMBER to common/cifsglob.h
Date: Tue, 14 Oct 2025 15:19:01 +0800
Message-ID: <20251014071917.3004573-7-chenxiaosong.chenxiaosong@linux.dev>
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

Replace the constant of client with SMB1_PROTO_NUMBER, then move the
macro definition from server/smb_common.h to common/cifsglob.h.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/smb/client/misc.c       | 2 +-
 fs/smb/common/cifsglob.h   | 2 ++
 fs/smb/server/smb_common.h | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index dda6dece802a..68607b7a68ca 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -318,7 +318,7 @@ static int
 check_smb_hdr(struct smb_hdr *smb)
 {
 	/* does it have the right SMB "signature" ? */
-	if (*(__le32 *) smb->Protocol != cpu_to_le32(0x424d53ff)) {
+	if (*(__le32 *) smb->Protocol != SMB1_PROTO_NUMBER) {
 		cifs_dbg(VFS, "Bad protocol string signature header 0x%x\n",
 			 *(unsigned int *)smb->Protocol);
 		return 1;
diff --git a/fs/smb/common/cifsglob.h b/fs/smb/common/cifsglob.h
index 371160fec1cd..5928d35c7f30 100644
--- a/fs/smb/common/cifsglob.h
+++ b/fs/smb/common/cifsglob.h
@@ -9,6 +9,8 @@
 #ifndef _COMMON_CIFS_GLOB_H
 #define _COMMON_CIFS_GLOB_H
 
+#define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
+
 struct smb_version_values {
 	char		*version_string;
 	__u16		protocol_id;
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 9c0db206624b..6d427dbed5fd 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -151,7 +151,6 @@
 		FILE_EXECUTE | FILE_DELETE_CHILD | \
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
-#define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
 #define SMB_COM_NEGOTIATE		0x72
 #define SMB1_CLIENT_GUID_SIZE		(16)
 
-- 
2.43.0


