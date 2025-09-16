Return-Path: <linux-kernel+bounces-818349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E15B59058
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3097B074F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2C2ED153;
	Tue, 16 Sep 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qw/2MVXX"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9402EC54D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010913; cv=none; b=Z49gNv+Xfr4jffsULb5wxTnnzE/B5v6AxHSrqKAouOMMmmy4BqFcI+hkCOKTVWzOeLcmzAvnZLiHhOUnxUPtVgkaJ9L6OqfMUHJomrJa7BRlg1TcTpMs48BEAzGISfYI5lN4xtc5Eq9asSt4o6VDq0IuwIv4n2fvlN3umrar1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010913; c=relaxed/simple;
	bh=gO8LFeI/+o03WnmBv2jX8TdardPbXLXtsEzXuYiKjDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NL88xQ9A1ixavpEQox48Go1KN6s6adRGi7u3ebr887D6TvHy/PwO/fvE3AZ8B2uBf91D8lOBOnu25tdlgZRVYxwzFNq/KY1eTjyeweiFfDQkcN8a0xl14gddNkBd/7lKoRQ2tA+kzWEQ8BRHJsTMgUo1BHbhf059MREsyN/cTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qw/2MVXX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54d6a67b5fso1104872a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758010911; x=1758615711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxxZMuabP77fzCNAu6ns7uDcQNnrGMEiu1qaNMAlJKc=;
        b=Qw/2MVXXI4+U6khxxzHHNmLOaqzkTxbAdCjpel7k/4+Odgp4eCZ192aLpxnfUdBB53
         +ufeaQlgOPWrBer3aE/9zKI2AWVaYoi3I5KO0VliADNcw3bHrlZCVhwyaN6NNd0eIdrA
         1vekEKsUs9bQgq3sPU8SKxi1flXhm0TbYY+G9z7LZXGUD4ib7VzDcakl/zWgZNSSUFx8
         gVJAvjk/V7hGOn2kECnbfkaBfwdsGfN65jLo/xAl9vkzE9ZPiLRe1hBIQ47PdBiVT5W0
         oQvzGKyYrIXcEGtrQ2GUBoX/hCeVVz5Ty2wV2Ju7mDx2iMbLCVMTo0oPoFX9vzqMgtCr
         4JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010911; x=1758615711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxxZMuabP77fzCNAu6ns7uDcQNnrGMEiu1qaNMAlJKc=;
        b=xT7j6AfH5GC+vMs9Py7gbe315sz/rCt8MAHvDl0GmfwAP8go3d4o2d6lQmIPNtb8cc
         zONyoPc2sdoKlJGHkks5E0i8hh2vFJc/7tQrQYPN2hWpk4N7MCnWDsVW8bShQ7mW7iZU
         hhpt/E3QAHSWloYjmOwlel5v7Kp/Dx1us00wMJIMXTa/xZv0JjmBJXtIWHghe0jYhTYz
         0m4x77eICkqAyJEsLNuzr0juDoDLXWPfyTazuBcZVsA77FxBYSsesqsdJpNLe6HwbMLT
         0gD6+64a6I4FJ6jmG7oJ9NBgnjn8ot04hyZcD7XQnlao79ff4Ek1KFPtWGlxdytJlGlM
         tj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF8/yNIsVHL4Gdtbqn/dh2WDYGxvzkKkWO3e0FoN3OZXA/CHulPlMhfnFgFXSaZd9yeiENooEBxjyTAPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwKckmQgSIr0KRFwnyIoQCRvL8eYx3pJl6aLqeZC5z/Z+U7yn
	9liKgUBOWkf/rvUpM/AcY5+vYHWU3W7/TlC/9WaPyJ/eNg+qJNGx0lyJmTYRbw1uGCXPuCJllZ3
	IRIGsZA==
X-Google-Smtp-Source: AGHT+IGbsEvJwYuHYiLrlamCcZiyi2o8aJOya7PXQ67510ZXAeyToGMNv1NeiH3Jj1DGtKcTVwFq9nL8Lcc=
X-Received: from pgct18.prod.google.com ([2002:a05:6a02:5292:b0:b4b:1913:2421])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4fa7:b0:262:4ec2:aa7a
 with SMTP id adf61e73a8af0-2624ec2fdbbmr10607264637.27.1758010911136; Tue, 16
 Sep 2025 01:21:51 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:21:37 +0800
In-Reply-To: <20250916-ready-v1-0-4997bf277548@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916-ready-v1-0-4997bf277548@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758010894; l=6500;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=gO8LFeI/+o03WnmBv2jX8TdardPbXLXtsEzXuYiKjDw=; b=h9Av5nkVOciOUDe9ZC190oUe45UWHEh1s3NwGniTtyVRFhU7wW1qgp7wbx1yWAMhB22kGKqYC
 zbCk9r4Me0KBVvTQs8x6f1f9qegGwsNXZMKB8sqzXFFFzjIYh1uJ3P5
X-Mailer: b4 0.14.2
Message-ID: <20250916-ready-v1-6-4997bf277548@google.com>
Subject: [PATCH 6/6] usb: gadget: f_rndis: Refactor bind path to use __free()
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Brownell <dbrownell@users.sourceforge.net>, Nam Cao <namcao@linutronix.de>, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Prashanth K <prashanth.k@oss.qualcomm.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, John Keeping <jkeeping@inmusicbrands.com>, 
	Roy Luo <royluo@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@kernel.org
Content-Type: text/plain; charset="utf-8"

After an bind/unbind cycle, the rndis->notify_req is left stale. If a
subsequent bind fails, the unified error label attempts to free this
stale request, leading to a NULL pointer dereference when accessing
ep->ops->free_request.

Refactor the error handling in the bind path to use the __free()
automatic cleanup mechanism.

Fixes: 45fe3b8e5342 ("usb ethernet gadget: split RNDIS function")
Cc: stable@kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_rndis.c | 85 +++++++++++++++--------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 7cec19d65fb534364127ed7fb8cf83cf3b04defe..7451e7cb7a8523acc9fefa6088e6b273bea2e616 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -19,6 +19,8 @@
 
 #include <linux/atomic.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_rndis.h"
@@ -662,6 +664,8 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_rndis_opts *rndis_opts;
+	struct usb_os_desc_table        *os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_rndis(c))
 		return -EINVAL;
@@ -669,12 +673,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	rndis_opts = container_of(f->fi, struct f_rndis_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
 	}
 
 	rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
@@ -692,16 +693,14 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		gether_set_gadget(rndis_opts->net, cdev->gadget);
 		status = gether_register_netdev(rndis_opts->net);
 		if (status)
-			goto fail;
+			return status;
 		rndis_opts->bound = true;
 	}
 
 	us = usb_gstrings_attach(cdev, rndis_strings,
 				 ARRAY_SIZE(rndis_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
 	rndis_control_intf.iInterface = us[0].id;
 	rndis_data_intf.iInterface = us[1].id;
 	rndis_iad_descriptor.iFunction = us[2].id;
@@ -709,36 +708,30 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->ctrl_id = status;
 	rndis_iad_descriptor.bFirstInterface = status;
 
 	rndis_control_intf.bInterfaceNumber = status;
 	rndis_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			rndis_iad_descriptor.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->data_id = status;
 
 	rndis_data_intf.bInterfaceNumber = status;
 	rndis_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is, strictly speaking,
@@ -747,21 +740,19 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	rndis->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!rndis->notify_req)
-		goto fail;
-	rndis->notify_req->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!rndis->notify_req->buf)
-		goto fail;
-	rndis->notify_req->length = STATUS_BYTECOUNT;
-	rndis->notify_req->context = rndis;
-	rndis->notify_req->complete = rndis_response_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->length = STATUS_BYTECOUNT;
+	request->context = rndis;
+	request->complete = rndis_response_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +769,7 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, eth_fs_function, eth_hs_function,
 			eth_ss_function, eth_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	rndis->port.open = rndis_open;
 	rndis->port.close = rndis_close;
@@ -789,9 +780,18 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	if (rndis->manufacturer && rndis->vendorID &&
 			rndis_set_param_vendor(rndis->params, rndis->vendorID,
 					       rndis->manufacturer)) {
-		status = -EINVAL;
-		goto fail_free_descs;
+		usb_free_all_descriptors(f);
+		return -EINVAL;
+	}
+
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
+		os_desc_table[0].if_id = rndis_iad_descriptor.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+
 	}
+	rndis->notify_req = no_free_ptr(request);
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -802,21 +802,6 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 			rndis->port.in_ep->name, rndis->port.out_ep->name,
 			rndis->notify->name);
 	return 0;
-
-fail_free_descs:
-	usb_free_all_descriptors(f);
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (rndis->notify_req) {
-		kfree(rndis->notify_req->buf);
-		usb_ep_free_request(rndis->notify, rndis->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 void rndis_borrow_net(struct usb_function_instance *f, struct net_device *net)

-- 
2.51.0.384.g4c02a37b29-goog


