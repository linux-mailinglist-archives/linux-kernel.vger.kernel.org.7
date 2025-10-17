Return-Path: <linux-kernel+bounces-857867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F16BE81C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90EDB508F25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F331A071;
	Fri, 17 Oct 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOMJ6MMv"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08438319617
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698041; cv=none; b=WT+RoF5am6yjYL/FiFtcd2vtRt6598ye72x5MSSrLcbVUeBoX9Si17ubBE4NCxiQWJYxnMegz8mxeSkCpry+1itsMGO+4IYLOYcONkFyWKbV6fNnaH8fSu3yBJDF5bfDWhBGHNNES9MH1HdpDBSnb3jmE/Rl2utGryxVWd18Olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698041; c=relaxed/simple;
	bh=VqJHVOFZ5DJNwWqt0hUqYv/FSyzj6l3KwrSTbGbdmVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSIdoaULfelD61uV9hMSTT8fWGf6n2Ap1xrLKf+UOMsXrjf4Y767np7rwJJxiIauWgF9fYS5UYOnvslQngioor2cG5K3htSuzaJHsS+ESMK93yVnMq7jpV9mPnvlvQyTbR2Ap0mqF/dqxND8jFcdH+AD4p3MakfB+nUA7LsGu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOMJ6MMv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760698038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5EtpvT+zBTCFB3awZnIjhy/RC7yn8lCbwKpgPvLVjg=;
	b=ZOMJ6MMvGMXc6k1+8GQSSCLZ9aA4IVXq3IWIljq9BWs9J0VwP4/JKtYsspzYjtyG3NoPH8
	77ed11ZBruo1wappBJKpXoDfiKaucI8oI0Kg5BHwIPYphwbuvNLtP59nb1wPpxX8uENwM8
	eWovRUSy5MzlEWErStaLbKkSjFJTgeE=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 3/6] smb/server: fix return value of smb2_query_dir()
Date: Fri, 17 Oct 2025 18:46:09 +0800
Message-ID: <20251017104613.3094031-4-chenxiaosong.chenxiaosong@linux.dev>
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

__process_request() will not print error messages if smb2_query_dir()
always returns 0.

Fix this by returning the correct value at the end of function.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5b5f25a2eb8a..ff264249f405 100644
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


