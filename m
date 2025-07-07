Return-Path: <linux-kernel+bounces-720141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C3AFB787
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE84A4A2E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496D1E5215;
	Mon,  7 Jul 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pt1s2GCW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A91DF271
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902564; cv=none; b=d91wjsOve27tApfCuH5N7hIbdFBA9wCkdQ130d6IIihaha/AH+pOAjSP406/rSg2a+6Y+Hgiok/uPXZylA6FTd0lS8M1oLaB1ZEdAMGjuO5JOLnpjySAZdhKxaKCu31mVAfaNU7CrVz7D7wZUZKNvE1y37N4DpMHMWKs+LomYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902564; c=relaxed/simple;
	bh=WyB4Uxje2L7Q1fJYUE13OWmnR/q/Nxc7UtQxjd5OYOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iz+5uLpG23Vol18NBzl2HL9Z/0YoO0NB2dqcOryuS4hT7gGSdnHUmZaU4/rYj6C+cVCARnDGoFNpaYL8WXhWsYKDxtvUG4fKQs9zVY9PtYs7oXkEahSzShnXDne+10q+iC0K0Y3bX5fvAiTsoAc49AR/PLxvii2j2bwrnhncVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pt1s2GCW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso2473113f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751902560; x=1752507360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krhFSts2Ny4KtwzLCGZ3q9qsBqTby6hrGjVeTlezd7o=;
        b=pt1s2GCWaUPujkJ6r/Yh80KwVxEuW3B9KkisJS/T3Yjg7rgj5l+PkGuA5QK/nU9veD
         Tj1zmiEl09zaOG8QPjhrzCmSf9RTz6EwfJtMnZpi8T7JfxGwVTuPbiQi9bPlBKHdb4cJ
         H6wP5BmcvIACjlvk0JIIfM0KNaZpcC/u3XY0o11fOevFn0aOavA+z+NJRBKe3f0ln9lg
         6f56mIA6heETWIbptuWDXxR9dGQIyPtLhMMIzV51pxr5Vl6I3nF5XgwxR4hjgItHkVI3
         5XxIDqqH1HVy5jHl2PcfxBPOYBRFahqyjE0XJndRjCk+bIkCRRRzgr0S0PlFx6E46Cui
         BDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902560; x=1752507360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krhFSts2Ny4KtwzLCGZ3q9qsBqTby6hrGjVeTlezd7o=;
        b=bAmfEqCcggga9HSOAcr4447cJbYorU6NwfIGuUUwYoWjT2pipkPYKmkTMaF6XD2tRp
         8J4CUkmCaVi/Fg3VLznbR1Xkk4XY03BoBZ8DoqykjB/z0JzJ/TymVZBKkOnLFPkLDWxw
         rwx3YvZ/IHCpqvQa154yuqZ0wA6De/GizvzDlE3GL+QfuLrHl7X/n2dPhLShoepztlyf
         BG5/k7IlcYiiI8glMSwvlpqUKBAQrqPxWxYNcvqTPjdsHRjmvEgzMGeOPpPkOMJk2ImD
         HCpB7qkwerhHxHCnhJ5BYG2BtyNUtrywaKGH9ah2vmIKjVOxvakeB8HbrIvlkBlVAei3
         eSyQ==
X-Gm-Message-State: AOJu0YyCQ77wZibNoHrp5ShLJWyPCrXcVQuoHIrPcBYWYC9ZBrCP6+8p
	0Bbb8YxEgCVB3EGHHzzoZ2pvLEVTyXpIK6P7GBrKptiHywJlC/FOquuw+TVy0/CdvYA=
X-Gm-Gg: ASbGnct8GKdxapOjcvC48qhwtoj9Eh7VMMjFOegyLy15w+6UoezHFqBvO2t9dseDxH2
	xGgIB09iD4PBGCFXXqyHAUxTuXbzCWzuZA6mFGcTJoNLD/AHf5Ze90SpPVZ8mkcWGnOKntUPEsf
	lfQs7TWbMjkPl+OnG+JDGtM7b7VYy1NJuODunveZedHOac/lAbm/m9c6/v67fT+fnE4F4QeEzgn
	6nQnQvRkSWc9xH7wltHTGvUAHCt53H8lu+AEnv2oNSS56cXcmu55/cFwSl0Fr/O0X3lJ/IVHluw
	IsLZPL7KfEXMDZuOX4mBcW7DDvYZTaxGuD0+2QvrezUpqICkDK8XDW05Dw9iuN7QTUKNoGajNaV
	g
X-Google-Smtp-Source: AGHT+IHgGoCbSgy1IfUjK41jBubHWfqMXcWrfJyrbNDfMrkOQPZqQJ3xInRzN/3XX6mg8lF8YgcYsg==
X-Received: by 2002:a05:6000:400b:b0:3ab:27f9:e4f with SMTP id ffacd0b85a97d-3b497031623mr11893080f8f.35.1751902559976;
        Mon, 07 Jul 2025 08:35:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:43f7:96cc:da3f:e6bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm10409968f8f.7.2025.07.07.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:35:59 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 07 Jul 2025 17:35:57 +0200
Subject: [PATCH 1/2] kernel: irq: msi: Export symbols for TI SCI INTA MSI
 module compilation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-timsi-v1-1-80ae43b2c550@baylibre.com>
References: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
In-Reply-To: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Export MSI domain management functions to allow the TI SCI INTA MSI
driver to be compiled as a module. The following symbols are now
available for module use:

- msi_domain_insert_msi_desc
- msi_domain_free_msi_descs_range
- msi_setup_device_data
- msi_create_irq_domain
- msi_domain_alloc_irqs_all_locked

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 kernel/irq/msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9febe797a5f6..4af232b6796b 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -163,6 +163,7 @@ int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 
 	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
+EXPORT_SYMBOL_GPL(msi_domain_insert_msi_desc);
 
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 {
@@ -235,6 +236,7 @@ void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
 
 	msi_domain_free_descs(dev, &ctrl);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_msi_descs_range);
 
 /**
  * msi_domain_add_simple_msi_descs - Allocate and initialize MSI descriptors
@@ -342,6 +344,7 @@ int msi_setup_device_data(struct device *dev)
 	devres_add(dev, md);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(msi_setup_device_data);
 
 /**
  * __msi_lock_descs - Lock the MSI descriptor storage of a device
@@ -910,6 +913,7 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	return __msi_create_irq_domain(fwnode, info, 0, parent);
 }
+EXPORT_SYMBOL_GPL(msi_create_irq_domain);
 
 /**
  * msi_create_parent_irq_domain - Create an MSI-parent interrupt domain
@@ -1472,6 +1476,7 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
+EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_all_locked);
 
 static struct msi_map __msi_domain_alloc_irq_at(struct device *dev, unsigned int domid,
 						unsigned int index,

-- 
2.34.1


