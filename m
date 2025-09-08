Return-Path: <linux-kernel+bounces-806703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C9B49AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99153B7EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1542D978A;
	Mon,  8 Sep 2025 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TH/zpbdl"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5827E1D5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362419; cv=none; b=eccG4lKeTRq1RRiJ2fwdevb+chlgdnVkhp8Leh9w/VqfHYQot8KQVqH6A3Z3HFjOEd8LmmnXaOI0zrWxPDVuGtTNt7+WfUVRad7DjPvBeoWKasBu6nnuFoYaskQsTbnEmWRjAgu5CBWrxrFmrOW3+6NU9f9hXAlTU+dWJtEJqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362419; c=relaxed/simple;
	bh=ixBNCkTq2ID52WZRqpl1jDAEqUp8UaXL8U9Yw7g44uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYWlE7DlBu+SpW540FZe1zejCE9vEZvHKkLUqpoSMLqIhvvt4J9yiU2kbDQMPMQDrc6ySWW6Z9P7tFwwo5OYe6utQ+nVgDqiBOStf8QqahMueOT+UhNFpmR/Yam5CvRivfvnAqYlJuusX6xj8yWQ7jEE61cAuBVGIhB0JjXuNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TH/zpbdl; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757362414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jVx5Hx0di7rnpcJRTZ0XoFVVYLKUYgjeddNGKkMgkvM=;
	b=TH/zpbdlQS8Xhc0v4xl9pej9K/4GVK6gQRDPUeDApfbtwtYYtK4IbGDVRnAPCjox7hMs0t
	oZau/W3G8fBDxl3qI7DMalt+NM2pFcC3G3HDDGIhnOHoO85uuhKzvS1Ylf+gUe3CYUqDOZ
	Uraj2CVGNyryMyuxRgCXMzRhxCWjJyE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Mon,  8 Sep 2025 22:12:29 +0200
Message-ID: <20250908201229.440105-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify sgx_ioc_enclave_create().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 66f1efa16fbb..e99fc38f1273 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -164,15 +164,11 @@ static long sgx_ioc_enclave_create(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&create_arg, arg, sizeof(create_arg)))
 		return -EFAULT;
 
-	secs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!secs)
-		return -ENOMEM;
-
-	if (copy_from_user(secs, (void __user *)create_arg.src, PAGE_SIZE))
-		ret = -EFAULT;
-	else
-		ret = sgx_encl_create(encl, secs);
+	secs = memdup_user((void __user *)create_arg.src, PAGE_SIZE);
+	if (IS_ERR(secs))
+		return PTR_ERR(secs);
 
+	ret = sgx_encl_create(encl, secs);
 	kfree(secs);
 	return ret;
 }
-- 
2.51.0


