Return-Path: <linux-kernel+bounces-845117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD822BC38F3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DF19E16CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CD2F1FE6;
	Wed,  8 Oct 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="43HKo5xB"
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DD2EBB80
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908481; cv=pass; b=awLwobjpG8fy9I6FOMvNJ2cYJs6H8F2eIQazet1BWrCPuIa1akojIbLELnvL+tTYXvImlrqOV/UIi0AfdOQjv2KHNHzslZtH0FCWFb7RcHGdbp6lx+Zv3Z1kpO2q4UBTlwll4L16PBkeaOLD3gCYeDJMOxdQxIlM8Dg8Juxwoak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908481; c=relaxed/simple;
	bh=UnfEl6eABXibxD9MAwlt62uo81pW10g2nmAQ/ptt77A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DmldBsG2FzLPBGnID3ljR+fMAkCFKIH6RHl+7wVnpL7lh60Jgu9UllqrANzRUiYepoM8+XiLnBtGXKViMKlcPmW0Csp69CtHwY30vIhmRxyAduV5ASsuUzxD6L6sgxYEF5xJ/KzXAQaaR+Hx91tEbmuOycSAvdpCiqQoQgFOfzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=43HKo5xB; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-33.compute.hwclouds-dns.com [119.8.240.33])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 5987RFgN2013116
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 15:27:22 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1759908445; cv=none;
	b=c+ouuHC1NO32X1JJOhAfPfX6k5XQde3p7p+8oNbGiQHfnYq5WPtWyzyjj+7yh5Wig8E2Dg7XRCRJzFGZfHl9m7NbkiM98rRl+7Wo3cX8lJ+7KQMQ7+foeT4tVXeBaEeXDfZcN48WcLxlAJMhW4soEsj85p4H9f11lutrhBDehns=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1759908445; c=relaxed/relaxed;
	bh=1d+fJPm6FAmG/otg2kfvoAFrk4yXq4+Potk4oSH+KSs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=IfUN5OWwhGa+eOTLxT+rxnHxr3EoU/U+hmLrYL63ReFmjcqDWxLBwVDYIaQMxI19CVDHgfovzqK0XfkoiIV7+XhpY9UZIcKqs3oh5mYm7/KgvXGb1mSYZy5o/OjohYNAWifoCdi+Gk+/IebUCLwjRE4rGPGsRlwOMFb0TuX2akc=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1759908445;
	bh=1d+fJPm6FAmG/otg2kfvoAFrk4yXq4+Potk4oSH+KSs=;
	h=Date:From:To:Cc:Subject:From;
	b=43HKo5xBJrsMu6WAVuqJmrtMbv5JQ26vixFRQyLXUm4CzdyYosvg0gHfzdw+xkzcv
	 qBRlp+XcCCqvmIC9KDviPkXhMfCgw8hzwgrVU5T1DoKLFr9DocnLVwp3dhM1YBWjBD
	 AxbLaEYiLyNEulEphFSO4/kzmvh95s2EF2L0KmrM=
Date: Wed, 8 Oct 2025 15:27:09 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <aOYSTX5EA_nRoIY_@osx.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In `i3c_master_register`, a possible refcount inconsistency has been
identified, causing possible resource leak.

Function `of_node_get` increases the refcount of `parent->of_node`. If 
function `i3c_bus_init` fails, the function returns immediately without
a corresponding decrease, resulting in an inconsistent refcounter.

In this patch, an extra goto label is added to ensure the balance of
refcount when `i3c_bus_init` fails.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 drivers/i3c/master.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d946db75d..9f4fe98d2 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2885,7 +2885,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	ret = i3c_bus_init(i3cbus, master->dev.of_node);
 	if (ret)
-		return ret;
+		goto err_put_of_node;
 
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
@@ -2973,6 +2973,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 err_put_dev:
 	put_device(&master->dev);
 
+err_put_of_node:
+	of_node_put(master->dev.of_node);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i3c_master_register);
-- 
2.39.5 (Apple Git-154)


