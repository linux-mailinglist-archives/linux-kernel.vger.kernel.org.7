Return-Path: <linux-kernel+bounces-899680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC737C58964
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189704F7673
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFB347BC3;
	Thu, 13 Nov 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFhRljHR"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488A346A0F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048392; cv=none; b=j/IA5m1Ie2k/7WuOd3plGELCK/Itpxt8o6kADLW6pvygeELJOH38JNM+CEP4iHPmMFnjTKouCpUF0dwTZ43H/WiNFIs3bsuyAvEPUBvgXRBfpAgu0bKAxq/RTHyzOS3oZ8gC2JIZAi1qURtXGJjMzUj9JzHDVowIFuOsKQmyXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048392; c=relaxed/simple;
	bh=IAwkvPGN1J6/ndtGV/PbZPfm2JVOjdVPyim6gdQtW9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJoHxPzMSdCjv0xdTta+316+SO+Fp623RMCeEJeQb7+TzXMbyCMVbj27SpKDk0/ikTj7AGhwaSirjRz+DMtDReYxHVEaVFptVFrg6bI7I/lIlucAsKs3/XTwK1SDCgcu1SaPDyv5/G6tPR9fp+k0j0E9vzLlHhlvFU8uqOWCd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFhRljHR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763048388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gE+3sRbPyHtFVg+iv45yjGoy/qm9/uVMyd8LB7zMmwc=;
	b=QFhRljHRmtIGs223E59VPERVczvN2nHQAZk8qZV5OgPZgVtwzjez+vinkcRX9sBdKFUyOi
	gsIxw0nqty75c4NLgYc08QFgtLph1EoUtBEBKtxgXPPVXeIqxGAJZRVcR6SgCShaRzxSbR
	c+wLs+NVMI97YHz8Tha5UIAk6ExPYYg=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] rpmsg: char: Remove put_device() in rpmsg_eptdev_add()
Date: Thu, 13 Nov 2025 23:39:07 +0800
Message-Id: <20251113153909.3789-2-dawei.li@linux.dev>
In-Reply-To: <20251113153909.3789-1-dawei.li@linux.dev>
References: <20251113153909.3789-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

put_device() is called on error path of rpmsg_eptdev_add() to cleanup
resource attached to eptdev->dev, unfortunately it's bogus cause
dev->release() is not set yet.

When a struct device instance is destroyed, driver core framework checks
the possible release() callback from candidates below:
- struct device::release()
- dev->type->release()
- dev->class->dev_release()

Rpmsg eptdev owns none of them so WARN() will complaint the absence of
release():

[  159.112182] ------------[ cut here ]------------
[  159.112188] Device '(null)' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[  159.112205] WARNING: CPU: 2 PID: 1975 at drivers/base/core.c:2567 device_release+0x7a/0x90

Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 drivers/rpmsg/rpmsg_char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 34b35ea74aab..1b8297b373f0 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -494,7 +494,6 @@ static int rpmsg_eptdev_add(struct rpmsg_eptdev *eptdev,
 	if (cdev)
 		ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
 free_eptdev:
-	put_device(dev);
 	kfree(eptdev);
 
 	return ret;
-- 
2.25.1


