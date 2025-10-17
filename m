Return-Path: <linux-kernel+bounces-857615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A7BE7429
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640D86219E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D52D0C9A;
	Fri, 17 Oct 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAstrqe5"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AE2D0627
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690867; cv=none; b=YXpRdkOTZuRC+vbE1NQYzrmJS7HiPiPwui+4PONyAgSVsfCV/tHVPu3H4pI9/2ueTKSz8157V48WnkjhPjP4CDj2BLDl0RwbTEeQOmp0Acw1HlJtR9t6e0gMOqpij517vt4H5WeGL3WUaUgQFKCZ5fTyQ/5HKB9D6pgJOijgFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690867; c=relaxed/simple;
	bh=J5jDEy6dWJfTdezTDyrpSiK9Q8q9P9729q0PqTXGExw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/P5niA6lG//B3XiJP+9pPQLgc2QQ/MyVMhptu15PhitpptCJvdLXnM1V7S5xNESoywhrfGre3njaecWDIU7Cf6S4uog4C0X761wLWwHjiP5lgp78dqKh7nUT1Qx+cMvVK/2xKIK522izraPKN5Br6yJ0wWSf2k/Ku+1vvWnC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAstrqe5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760690863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHBOYirulXGWUGklwoehPzY2gRDp6I8e8rVR26YDppo=;
	b=xAstrqe5Lgs/P5vHfrAgiKg78f4uTFQd7ZQpEfZaoKPAZS0k0/CzAl+dt/ybOYAMnbdwQ2
	UxFTVO8cqBqeRliJVcRDBMqSnMHov4nZ9f14MtRaFiaLqsEL8mRrWhGJ+deGLaTZVv61bi
	HVYmgFBY0PLHeNPZ4Paa8lJs5TyZM6g=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 3/6] smb/server: fix return value of smb2_query_dir()
Date: Fri, 17 Oct 2025 16:46:07 +0800
Message-ID: <20251017084610.3085644-4-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

__process_request() will not print error messages if smb2_query_dir()
always returns 0.

Fix this by returning the correct value at the end of function.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c040df0a2073..dabc3a49bd15 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4560,7 +4560,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	smb2_set_err_rsp(work);
 	ksmbd_fd_put(work, dir_fp);
 	ksmbd_revert_fsids(work);
-	return 0;
+	return rc;
 }
 
 /**
-- 
2.43.0


