Return-Path: <linux-kernel+bounces-870965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FBC0C1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5939A18A21EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41012DF151;
	Mon, 27 Oct 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mV0WhK7z"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A82DECC5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549834; cv=none; b=HTeiNT/KKHMk9qbDXN3lOy9FhIbpZpHphl8q/tVwAOpEvigzDm8hUwDwQ53GC4EdS9NBJxhJ5BzslZFp3nGs72Tp/SN+X0m3zQDNNIqC4PL3qIgEa24vYu3p/BdSYN3CMB9WrHEnE3PpFjnxgJ6mbczefis/AJCYozyxt5u7eMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549834; c=relaxed/simple;
	bh=2cwLv8TQ1dJs+hofuNacu8Hqx8cEP/7afy++WYSDUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvSaRgO9GyDrFh7UKWDVs4Cgh/JZEZNwyl1Am6Qa40KTNniHI8l0zmWHdqff3HB/tYzPbzm+iCUEwOs06DCLenlSibKfIbzu1gnmAwEBg/5BbkEB855A3D4UGALrEmU/bw55t/5PiFEQaFSG0Gv58LIR8CkU29ZkX0bl+2OddYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mV0WhK7z; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761549830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hETu/EvsR4jurFpJ1W5lgbOlX0XPtsuGByTEGVYIq9o=;
	b=mV0WhK7zKFyRYYZVd3n3yjik3JdKafjqeDlgJs3jzJFJr9WRGweYyopnXYZJX+hWVoNrKh
	nu/7adpsHDw/SHYqUlEpaXwLVgUNCY1v7ExodDc19ns1KW5oiK8pe3l7wzL7oL//p/VBXG
	0XePm3SCSNnzM2iSktxtmvbYFtuTO0o=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v4 19/24] smb/server: remove create_durable_reconn_req
Date: Mon, 27 Oct 2025 15:22:01 +0800
Message-ID: <20251027072206.3468578-5-chenxiaosong.chenxiaosong@linux.dev>
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

The fields in struct create_durable_reconn_req and struct create_durable
are exactly the same.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c |  6 +++---
 fs/smb/server/smb2pdu.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6b3503c7bfaa..3e8344fa163b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2766,7 +2766,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 		}
 		case DURABLE_RECONN:
 		{
-			struct create_durable_reconn_req *recon;
+			struct create_durable *recon;
 
 			if (dh_info->type == DURABLE_RECONN_V2 ||
 			    dh_info->type == DURABLE_REQ_V2) {
@@ -2776,12 +2776,12 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 
 			if (le16_to_cpu(context->DataOffset) +
 				le32_to_cpu(context->DataLength) <
-			    sizeof(struct create_durable_reconn_req)) {
+			    sizeof(struct create_durable)) {
 				err = -EINVAL;
 				goto out;
 			}
 
-			recon = (struct create_durable_reconn_req *)context;
+			recon = (struct create_durable *)context;
 			persistent_id = recon->Data.Fid.PersistentFileId;
 			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
 			if (!dh_info->fp) {
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 099e9f20812b..6c8102d5cea5 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -68,18 +68,6 @@ struct preauth_integrity_info {
 
 #define DURABLE_HANDLE_MAX_TIMEOUT	300000
 
-struct create_durable_reconn_req {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	union {
-		__u8  Reserved[16];
-		struct {
-			__u64 PersistentFileId;
-			__u64 VolatileFileId;
-		} Fid;
-	} Data;
-} __packed;
-
 struct create_alloc_size_req {
 	struct create_context_hdr ccontext;
 	__u8   Name[8];
-- 
2.43.0


