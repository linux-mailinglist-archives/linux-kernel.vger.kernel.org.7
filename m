Return-Path: <linux-kernel+bounces-818344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C618BB5904D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82A12A6B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E82DFA39;
	Tue, 16 Sep 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKVIimtw"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E528B3EB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010901; cv=none; b=sR/fovODJ2MN4QZbsO6/w17uucNOnjod8j2ONuahN8iHWcPP2RsqRgzKSohq7joY4U1sXZYCE/WNYyDMdFC8Ol54EdCGkSCCHYGe6y/87uasVIqrx08qehU008PUQ3EHmbTzE413jE/9EAkkOek3VX3x8ZeKWEBKg4bs19bvvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010901; c=relaxed/simple;
	bh=fuR/HXUqnZRqWnGet2GEWHTmMUaAcnq8fYUKv/t8unk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EDGZ8Xz4I0UddTwUctSqIwf3tZ5i4MViQjJBJ3KAYQH5URaIN/sb9RUURf70GmhO3VNcVw78+VBT+c0BAfkhuc6ucF2KxKfM8ZvMIKFtza/2HgiH9uzJTmfKx4rTz6Z3HXAGXigsXjOwboyKEdPkWKtQrTp0WbHQxikXLxxp4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKVIimtw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248d9301475so76814985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758010899; x=1758615699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSapijpv/6eS2x0/D6s99HaO+7NYAKTfmN4io+/7yY=;
        b=pKVIimtwKEXvbSxmMRMIX3AtLbUH6UgBhkQRbLjMOxpJ7g2NA9j3mDpkUaaFh2ELkg
         X/4Sfo0JqFLfDePVRDGhPExt4w9vlISjD8cxUYh2KwyeioVQAHXDPuwksQjLRWgCgSyL
         2yOTTr3M+l1mhvt1AN3CIbJD69NSCH6+EuVXV3UwFWZCPRmdSdsSKrsbAMLnVwNlKMbf
         KXp6mV3QEHJE9qlxGL4rKmF99JNthENTMdnwuITNhixwbY8ZLwEZUmPmPD3MR2/LifUo
         bzE9w6c+ce1tdSw46mKkwNCiAgU9wjeyyyCB4twpan5ReZo/ddn/02PaU5G4lSvH6Hh6
         wK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010899; x=1758615699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSapijpv/6eS2x0/D6s99HaO+7NYAKTfmN4io+/7yY=;
        b=doP9ANHa+kMFCo0z6gMs842ZXHUuARLlLLNetxV3h/chFOBfMwbwdens6yUxF/XMyN
         xaAMptOXN37D+yqwqE12e3DGbvmnWMzVzxFHYdrdGOpnvLEuHF0HIt+CEB8ztGXdlhCJ
         PYGMhgXhBq/+cC1rq1d4Kk8c/dJ+DRyIgpZ036K9rFbn8aVtQt8ltyvJfN6Q4G1qUnta
         OQhVQyOwriyA1i0/9pnMLKuSBamITqrk9EbF5xvCW1UQTq2+2nS1rMk9jhwjWxfdiVFw
         RnkMNFO9c7qKoCq1SXB1q/sQRzAUUFU7D/u6czF7Yl9NlWBrgP12Hw6Wo1lAirvnzegI
         6FHw==
X-Forwarded-Encrypted: i=1; AJvYcCUwTJiQpJH/roW+QZjVL58tCCWQR+rgOoGITqyseACUnysFjejYSQLvylvbQAIXoAtHqeMH1k7Dq2GnuYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhyyHAeNatFYIbRVsMMnSiXu0Tod4Iz6kd5u2m655v0G1G/aD
	oyAw1bmVWT7JmYEq608og+PrBlOwS1wKV98a3U/rGdUtmvUjsZGkJ0tAfMOVP+TCW57mQMauKBk
	pxHQkVA==
X-Google-Smtp-Source: AGHT+IGaZqc2Q4WvhWmuDmDAk6WMZKnhHHrTTt9YQyfshktPNzfQnDqZkHiWjlMD1LvewhzbNxys7IK+ANg=
X-Received: from plnw13.prod.google.com ([2002:a17:902:da4d:b0:25e:8dce:6855])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0d:b0:267:95ad:8cc7
 with SMTP id d9443c01a7336-26795ad8ec0mr84124875ad.54.1758010898317; Tue, 16
 Sep 2025 01:21:38 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:21:32 +0800
In-Reply-To: <20250916-ready-v1-0-4997bf277548@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916-ready-v1-0-4997bf277548@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758010894; l=1994;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=fuR/HXUqnZRqWnGet2GEWHTmMUaAcnq8fYUKv/t8unk=; b=0CJZmIP8dgVWvkzxm1xeVrkWf3hjwzIJfYYWdAue0Lss/T2CMGN3Wk6QQWZolZNX5IWT+mnfr
 CswxKlvCXGdB5jLuirA9yxTqmIgcsi3Mt1+o0eL8/TdXMUPIyErF11e
X-Mailer: b4 0.14.2
Message-ID: <20250916-ready-v1-1-4997bf277548@google.com>
Subject: [PATCH 1/6] usb: gadget: Store endpoint pointer in usb_request
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

Gadget function drivers often have goto-based error handling in their
bind paths, which can be bug-prone. Refactoring these paths to use
__free() scope-based cleanup is desirable, but currently blocked.

The blocker is that usb_ep_free_request(ep, req) requires two
parameters, while the __free() mechanism can only pass a pointer to the
request itself.

Store an endpoint pointer in the struct usb_request. The pointer is
populated centrally in usb_ep_alloc_request() on every successful
allocation, making the request object self-contained.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/udc/core.c | 3 +++
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4228c47f877d097faf987975ac392..e3d63b8fa0f4c17c6d59ab9d2f2c529e98f20d45 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -194,6 +194,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0f28c5512fcb6ccd7a854ae8a66c21aec194c3c7..0f20794760887314d81a070755c8908c6ac4ed90 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -32,6 +32,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -98,6 +99,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;

-- 
2.51.0.384.g4c02a37b29-goog


