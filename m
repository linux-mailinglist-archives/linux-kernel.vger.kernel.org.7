Return-Path: <linux-kernel+bounces-852002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465EBD7ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A135B426257
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A843D30F538;
	Tue, 14 Oct 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="syHbo50/"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECD30DEAA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427043; cv=none; b=pCerhCvzSSaMqPo9CQc3dLzU+e4CnP26jjeU7AQDLntB4OVnh6TWAPPztCxrNnBkWD7IQRHPC7YKMNRd6RGqJap/GyiG9o4RYljR875KE6vnbLTj40GlkeHJid4X+FOCnTvVaMUglqxHGB7LDDuOGoicJPW1iIUVJ+LodpbDhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427043; c=relaxed/simple;
	bh=9HFwudJ35eQC7DM+YM0J+EEops91L9kfN+PkBQyF7N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k91GMbYYZgbyzstQ5FZm/g475l5EhgjCq6M9nMCq6UPl2h5hnSIYq4LJnPrjQzGm+pr2+0yJHAwXUdDEGf3JhCMMNHBQTaCsqaXXnEdVSYlDSVsSd4A6HT6h0mRCrNCeHc1Axi1dWNfibJL35StOpYS7qXribysx1z3CzgA5DOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=syHbo50/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760427035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJx9OM6K3Tjk+UgGFD1P31Hm1RjNojZcGpumQCw+2b4=;
	b=syHbo50/fsvXmgri/YsuLc/ZL7bvZRv6vlqZGoPhpDfSsaqvzsbrVU8lSaYEm2aMmaW1iy
	zHTLB16EK2u7YgBGw8ltdz9UBuQ8SGM+sGU6v+fW7bEctkImsAT+wKWZ1Ulsyut+AQaFLH
	c00pGDUAg1HHJuvAihVKfKGxKfe8g9Q=
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
Subject: [PATCH v3 16/22] smb: move FILE_SYSTEM_DEVICE_INFO to common/cifspdu.h
Date: Tue, 14 Oct 2025 15:28:50 +0800
Message-ID: <20251014072856.3004683-6-chenxiaosong.chenxiaosong@linux.dev>
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

Rename "struct filesystem_device_info" to "FILE_SYSTEM_DEVICE_INFO",
then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifspdu.h    | 5 -----
 fs/smb/common/cifspdu.h    | 6 ++++++
 fs/smb/server/smb2pdu.c    | 4 ++--
 fs/smb/server/smb_common.h | 5 -----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index a6f7e168961e..17255d7a4615 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1929,11 +1929,6 @@ typedef struct {
 #define FILE_PORTABLE_DEVICE			0x00004000
 #define FILE_DEVICE_ALLOW_APPCONTAINER_TRAVERSAL 0x00020000
 
-typedef struct {
-	__le32 DeviceType;
-	__le32 DeviceCharacteristics;
-} __attribute__((packed)) FILE_SYSTEM_DEVICE_INFO; /* device info level 0x104 */
-
 /* minimum includes first three fields, and empty FS Name */
 #define MIN_FS_ATTR_INFO_SIZE 12
 
diff --git a/fs/smb/common/cifspdu.h b/fs/smb/common/cifspdu.h
index 560900617be7..055c6577b4e9 100644
--- a/fs/smb/common/cifspdu.h
+++ b/fs/smb/common/cifspdu.h
@@ -321,6 +321,12 @@ typedef struct server_negotiate_rsp {
 	__le16 ByteCount;
 } __attribute__((packed)) SERVER_NEGOTIATE_RSP;
 
+/* See MS-CIFS 2.2.8.2.5 */
+typedef struct {
+	__le32 DeviceType;
+	__le32 DeviceCharacteristics;
+} __attribute__((packed)) FILE_SYSTEM_DEVICE_INFO; /* device info level 0x104 */
+
 /* List of FileSystemAttributes - see 2.5.1 of MS-FSCC */
 #define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
 #define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a05b04799c0d..41167e7cca77 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5469,9 +5469,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	switch (fsinfoclass) {
 	case FS_DEVICE_INFORMATION:
 	{
-		struct filesystem_device_info *info;
+		FILE_SYSTEM_DEVICE_INFO *info;
 
-		info = (struct filesystem_device_info *)rsp->Buffer;
+		info = (FILE_SYSTEM_DEVICE_INFO *)rsp->Buffer;
 
 		info->DeviceType = cpu_to_le32(FILE_DEVICE_DISK);
 		info->DeviceCharacteristics =
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 016ec93e6df4..86d18a8badff 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -56,11 +56,6 @@
 		FILE_EXECUTE | FILE_DELETE_CHILD | \
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
-struct filesystem_device_info {
-	__le32 DeviceType;
-	__le32 DeviceCharacteristics;
-} __packed; /* device info level 0x104 */
-
 struct filesystem_vol_info {
 	__le64 VolumeCreationTime;
 	__le32 SerialNumber;
-- 
2.43.0


