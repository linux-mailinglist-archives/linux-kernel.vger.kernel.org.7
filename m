Return-Path: <linux-kernel+bounces-857866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C6BE81BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AE7425447
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D83191BE;
	Fri, 17 Oct 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o88TdpTN"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90443176EF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698039; cv=none; b=fJnG5JnlBPWLUgqVnxi4HZZEcUiq2H+qe736keuYWnmorIj46IKWGd1k3XXU6izJYPe961aZYJDSGl2K7UzZ9C9Xq7/uD5M0hpLA8SWl1xh5Dwil7z9q3cDnYo4SpRwoLENVlJgKr59NZTcffKCU+2Uu9Pu8F5lfqAOhD8s3jIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698039; c=relaxed/simple;
	bh=SsjGT9r6HTcpAf+hm/ib3M0giSRUy6czGOiO/GTMoEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy5WbdI9ZTCi0bZXJO/iPsheReDdkVXNwVMZ8ujFWcaAjq1LwnWbG5h+0L8XwpbP5rERDjpVoVz+i7sgTTWbiChfUTzbzXMa6seBHZfS/Y0MwnFFjXpxirdSb66Zt/1gR2agaXXLCEmHuEgicJG+1+zHgxSEFuel09LxftwNVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o88TdpTN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZYpSan4Xtg7ipurLAFtn4+9Ilq4Ux2WxUZkDOjKwiw=;
	b=o88TdpTN4hfthhPIvkcfwedosu8vdQLJKse3L54R5aKjmm/TCC+BxMA8s/VTFThpJ6nIxD
	LV4X/Q6P5FIAVwhYjsU2mma82X6fSsWJGnUMJupc9D2qJYx5rD/Jx7MDu7CUel77lZK3XM
	5syoOZyZh0SzzeSJEfn9Wp7DKrdkZ+g=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 2/6] smb/server: fix return value of smb2_notify()
Date: Fri, 17 Oct 2025 18:46:08 +0800
Message-ID: <20251017104613.3094031-3-chenxiaosong.chenxiaosong@linux.dev>
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

smb2_notify() should return error code when an error occurs,
__process_request() will print the error messages.

I may implement the SMB2 CHANGE_NOTIFY response (see MS-SMB2 2.2.36)
in the future.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f80a3dbb2d4e..5b5f25a2eb8a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8787,7 +8787,7 @@ int smb2_oplock_break(struct ksmbd_work *work)
  * smb2_notify() - handler for smb2 notify request
  * @work:   smb work containing notify command buffer
  *
- * Return:      0
+ * Return:      0 on success, otherwise error
  */
 int smb2_notify(struct ksmbd_work *work)
 {
@@ -8801,12 +8801,12 @@ int smb2_notify(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off && req->hdr.NextCommand) {
 		rsp->hdr.Status = STATUS_INTERNAL_ERROR;
 		smb2_set_err_rsp(work);
-		return 0;
+		return -EIO;
 	}
 
 	smb2_set_err_rsp(work);
 	rsp->hdr.Status = STATUS_NOT_IMPLEMENTED;
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 /**
-- 
2.43.0


