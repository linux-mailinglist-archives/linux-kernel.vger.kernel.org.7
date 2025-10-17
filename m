Return-Path: <linux-kernel+bounces-857868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7ABE81CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E106E1756
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED831AF1F;
	Fri, 17 Oct 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFONZgnU"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAF3195FC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698043; cv=none; b=oMThyfD9gGxhOLK2oAVgZxMh9qdwiq+K/vPWkTdIq7ouw6NYWxYM1UNBejweC1g+e5FH3VKYb2+vAzNrJqthI7r0XUT/7l1Yi6S0XGBg21Zx9Ymb9vI+yA65sXtQiYuryKz3oXyofmXYGS5dTs09UUfB2WGK6YQ5iKaaqLvND0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698043; c=relaxed/simple;
	bh=q+0zsdyq5lrbkvcHsrd8oeUeJalcLNU3Uz1DgUyInxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVPBAFJD+Cigd3PVTbhtc8BPjey8huBISqTq81XsnJ6PpOdfP5ocM4WxG7emwQlDs5smAQQPGbAnTIa3wsGZIN61ITz71ZOpooayKxsG5/WNmdcHNUluoShtOXuRSd8Elhmfq1MVEasP5mwdSD3FtCzgRZg1krcS/HSIQKOMAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sFONZgnU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etMM8r9NXRpmxE2GxxUG1NPFqiTlE+SOElV3r/BrVvE=;
	b=sFONZgnUcY4dQ48cVW+siAb4UkCv9creoNYlr1vRvF4t9eIQBeiBfGwUniiizk5wNUNrgD
	eOQV4W1/mi8mp/hFsAyIRGZRuCxtNCEM0ns+DzqR5Fb7ihViXXAcEXS56dO36vN3BplBK6
	TmGfriv5noAvOBg9DuFUXQ3o7m2gBuI=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 4/6] smb/server: fix return value of smb2_ioctl()
Date: Fri, 17 Oct 2025 18:46:10 +0800
Message-ID: <20251017104613.3094031-5-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

__process_request() will not print error messages if smb2_ioctl()
always returns 0.

Fix this by returning the correct value at the end of function.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ff264249f405..efd545882ba8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8164,7 +8164,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		id = req->VolatileFileId;
 
 	if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
-		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
@@ -8184,8 +8184,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 	case FSCTL_DFS_GET_REFERRALS:
 	case FSCTL_DFS_GET_REFERRALS_EX:
 		/* Not support DFS yet */
+		ret = -EOPNOTSUPP;
 		rsp->hdr.Status = STATUS_FS_DRIVER_REQUIRED;
-		goto out;
+		goto out2;
 	case FSCTL_CREATE_OR_GET_OBJECT_ID:
 	{
 		struct file_object_buf_type1_ioctl_rsp *obj_buf;
@@ -8475,8 +8476,10 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_BUFFER_TOO_SMALL;
 	else if (ret < 0 || rsp->hdr.Status == 0)
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+
+out2:
 	smb2_set_err_rsp(work);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.43.0


