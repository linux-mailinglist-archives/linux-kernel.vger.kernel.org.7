Return-Path: <linux-kernel+bounces-857870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E573BE81D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E381AA36D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FB31D731;
	Fri, 17 Oct 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xs3rWhk4"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A631AF16
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698046; cv=none; b=cRX5QYN8jmp0mkuWm3cqAx6Uxqm7M76/vEb/g/RT3ueYcfaNVJFpT7ClPVUkuNPQRi9WN5HHbe7iVOTwZ6VImOl9FSE0ElEaHmF9rikJo1QWrRifQOBZNsRRLIRUrlyMp3PjbU7P/sgwfJH+2L9/eZZpb5WqAP18uWVJxUTv234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698046; c=relaxed/simple;
	bh=Gh3YgjFcDXtZ7SA8UhKIu3nNpGj/2pFyEh11+vMOhLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMwhEkdZVcoGtfL4mQo5jqUdzwz0qyNeyJGhJQpCY/CiLbpmM/3cfLSy/+gSUqFlMXx4BuGNU22a0fcQMIzDsRB/Kyp7etgZDHsTjxblFStA2I3s0FBoot2+4jAfybw6/HHTC0VBUCU53aMTu81D8ewx+ed1oQugpVkwDPLdYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xs3rWhk4; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrudYtd8ywS576Vt//9nP99kCLAQAPdrXe41FpuXVI8=;
	b=Xs3rWhk4iacmLshPgx0szQBRfAnxQ0DTT80q9Ur28OuNXlCtSCg0H6ZbKtajHUcmMNPZIC
	Ntq/5f9YtNO+0mdwAuedB9DIf5mCLERvB0NptHnvUPg5yBam4ILt/ShqRiWbRVk+8nwcVJ
	9G+qGaK537XDaUf9SDienhwB7j1wskw=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 5/6] smb/server: fix return value of smb2_oplock_break()
Date: Fri, 17 Oct 2025 18:46:11 +0800
Message-ID: <20251017104613.3094031-6-chenxiaosong.chenxiaosong@linux.dev>
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

smb2_oplock_break() should return error code when an error occurs,
__process_request() will print the error messages.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index efd545882ba8..06e4c21ad4a8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8758,7 +8758,7 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
  * smb2_oplock_break() - dispatcher for smb2.0 and 2.1 oplock/lease break
  * @work:	smb work containing oplock/lease break command buffer
  *
- * Return:	0
+ * Return:	0 on success, otherwise error
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
@@ -8781,6 +8781,7 @@ int smb2_oplock_break(struct ksmbd_work *work)
 			    le16_to_cpu(req->StructureSize));
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		smb2_set_err_rsp(work);
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.43.0


