Return-Path: <linux-kernel+bounces-818345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CFB5904F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852A61B274A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1E2EB853;
	Tue, 16 Sep 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4+w3xvT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2802EA49C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010904; cv=none; b=knPuxWNzj5f3RyJaW65crZYKwn/OhTmBtBuMcQ4FIDHjdGwYHLjYKaNjWI1UasW/kq6XryR/PQgFy/G0YmvGGcElmhebFAbqUNPgEmkFYaeLhyGjHvwiYDGWRsUxnxLU368+cIK2e6Dp46Evdc6yEj2uoYmr4o9RjByZwEH4omc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010904; c=relaxed/simple;
	bh=KqbA0WSViw/fVd76NMhaeHHf8p8kF5dAyIDHRRkZY8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLWJWQAwqvF0u4HtOq8hheEq61SdBAcdb2W/ylkxwNP/ew/0NcNquFxEDano+eP79Eu4CeVTdHOiFiNeQYGpJXT5ZI7q1ESnMcfV4yQLZo+wZtmm0BmAvQWxODvFLdfQKieiDXQ6xsbQTIoHGpc+IGTICRUhMaOjmsZeYJvHecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4+w3xvT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32db3d5f20aso4413190a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758010902; x=1758615702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I621x9QACwnsqEWtRQMfgrL9A04jGtrlDrBPDiOwIjA=;
        b=f4+w3xvTKp4JJB5SK06xCFsTdOP4MVHkhhxoACO8372jWID35jelO6gc6gb7Vz8bT9
         yCIR/MSoyyi4vlIV5//kueq1XBbc88oWSN2mL9eTCaEexB8ipZr3MthHdvEnekMnOy2Q
         nPREqxsfE4MMRtgZTCjJXUafSIU+cQS+3jdGdbiMFIgT0eT93/2itSiTempLbo0Y0Ug9
         k41or7RqZonmuVdNWG6XN7+7ItDqk33F2bZx93da4l8eLwGPBtNObzHt6Ybwkp5p27Qv
         +cI22HrVHpDGtvkYqMw4YywNuv3bJ65FFija14ab0KM552I9RdnloZrHP+3bR+mnGB25
         BoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010902; x=1758615702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I621x9QACwnsqEWtRQMfgrL9A04jGtrlDrBPDiOwIjA=;
        b=J+58utZQiAJQ6fuMzzlH+8ARo/obcMtDYJxUw+5aynAd3O3D45JLQlrwYdVVOdK5rf
         zfZnhGWAVjbk+2j5tl/gs4C3Zqipl9RnYPyG8H1DLfo9tgs1m7GWqnGj7ZxlWyc7rAEf
         3J4HRuFLDJJB0WKMr4ilr9azNi/wzHmrlRNKDgPnqsKYS2KwFWpTt9aHVIfUsw5NxY9S
         V/xu0cWGuZj718bw3dR/9jcYTz/B9R67IyD4iO4ux8M5ssS027o8huw04tZsKsJeRyZc
         Ix7EHWNsmKeDeSL8vHNQysiWpoQ3NSM7KqUGiLRKq+YUeG4i8fKBk+BDKRz0dx2qit7k
         BdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVPVeXZqVmfs/vvKy/bCnWPe7cmezfW8IkcFDWZQrRf3vSP6SLPKM2b8g5gM6D/4Yp1+dFMCvO/Dl1e5VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxup6NZib5f+AacjTzVmpJ64IOa7qTgkq8vAppPYSbncmNC/dfQ
	24YGgc8sSnSJW6yHYZeJVzNb/9e8tf/JA7o6CWdW7UfZd/QgaBQKgCFhJYln7xtGG8bDEtvKoDi
	Kqb0G7w==
X-Google-Smtp-Source: AGHT+IHmk1MDtIN07ez2FLbYyMNZcJFwEG2Tscu6eNO05ncxE//LK7cDAiARPiu9CqlmSuy+JGa3YS07U3Y=
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:325:5e4e:4bd4])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51d1:b0:32e:7270:94a1
 with SMTP id 98e67ed59e1d1-32e72709694mr8334878a91.17.1758010901762; Tue, 16
 Sep 2025 01:21:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:21:33 +0800
In-Reply-To: <20250916-ready-v1-0-4997bf277548@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916-ready-v1-0-4997bf277548@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758010894; l=1880;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=KqbA0WSViw/fVd76NMhaeHHf8p8kF5dAyIDHRRkZY8Q=; b=s0Jiw3j5/HMGZaKpmRY7Gl8dJEQasTRNS0qen6WZeXkstOb7kARChj7e3cfvTMHj4dvR1Mile
 bHcWL5R4xaLCg4G8u4mVRFu80yAdsD9Q9h6bo0UXW8NfwTjfQD7l7OC
X-Mailer: b4 0.14.2
Message-ID: <20250916-ready-v1-2-4997bf277548@google.com>
Subject: [PATCH 2/6] usb: gadget: Introduce free_usb_request helper
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Brownell <dbrownell@users.sourceforge.net>, Nam Cao <namcao@linutronix.de>, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Prashanth K <prashanth.k@oss.qualcomm.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, John Keeping <jkeeping@inmusicbrands.com>, 
	Roy Luo <royluo@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce the free_usb_request() function that frees both the request's
buffer and the request itself.

This function serves as the cleanup callback for DEFINE_FREE() to enable
automatic, scope-based cleanup for usb_request pointers.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 include/linux/usb/gadget.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f20794760887314d81a070755c8908c6ac4ed90..3aaf19e775580b19cbb2b30d8df8a282945edfa0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -293,6 +294,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * free_usb_request - frees a usb_request object and its buffer
+ * @req: the request being freed
+ *
+ * This helper function frees both the request's buffer and the request object
+ * itself by calling usb_ep_free_request(). Its signature is designed to be used
+ * with DEFINE_FREE() to enable automatic, scope-based cleanup for usb_request
+ * pointers.
+ */
+static inline void free_usb_request(struct usb_request *req)
+{
+	if (!req)
+		return;
+
+	kfree(req->buf);
+	usb_ep_free_request(req->ep, req);
+}
+
+DEFINE_FREE(free_usb_request, struct usb_request *, free_usb_request(_T))
+
+/*-------------------------------------------------------------------------*/
+
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
 #define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */

-- 
2.51.0.384.g4c02a37b29-goog


