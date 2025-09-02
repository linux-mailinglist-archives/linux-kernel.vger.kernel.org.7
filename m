Return-Path: <linux-kernel+bounces-796812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D52B4079C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B45802FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2F31158C;
	Tue,  2 Sep 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dva9Ou12"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45F31355A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824236; cv=none; b=n1qm3HPpfMoNLBeSWtbPvN2NOlxCLLM3RJMIsZf2eljieXvvVfVyP48DJ4d0fkhljeJrBIp5QW5NsFF8ZavvnHl2d9ER9HNvIR48hlABFgrPrnjL/hlN3UwQIOgIuc0XqoVQMqrNMumnzJnda0SwNGjieazdxrDw7LDxayzs4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824236; c=relaxed/simple;
	bh=xTXQxy5LEUnwn+AUYQL3WwUiGwCnR5BVVqAD2FNTezM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBh7w9CCJyPnM7SaL/8LeRR8NsTkAFuEQZQN0lzmrZfTF2rd1ipa4f69e+6E2FZP6LxcxuWmd/8Prr9mHkwu5x4wscKKYca2B3lGv9KweaBTA5nG4tK8Gt0rDmV2VmqTUhhWWimy3FC8qSjujmTtfVwG2mIU/898mcuvCFsO/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dva9Ou12; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b88bff3ebso16683715e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756824233; x=1757429033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8wzm/mr5xp7tXM1oehlTTQpv32VYRWQAoA0cZh04As=;
        b=Dva9Ou12iZCpijRErkAn+P5X0XHqn1nRF/nbdPY9dS1EbJOAfGLv/2nrsyDIlwHI+N
         sLj56zSh6s3+XDGM30mIMkeoeTeOMf+QUb6MauycVxN0ZS9WT7qx7qxTh3x0P2MY1x8L
         QKSLUf6foG+jCD+ZMIlqDrHF0TrqsczEVV4Z8uatsZfQR8r8ul6HfQLHKQ582V+qsaWZ
         YPYS6E38lUw0ePD95iVnkRJfvicIA47G9v3ewy59UluZPXGIkqThYXe8NokBysRRwjwu
         dKyEsIujgagGTevfRVHZ4hLDa/i34rEhrQmyx4V6CwJlpEVurbKjWzyE8j96jVnyiKO7
         QI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824233; x=1757429033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8wzm/mr5xp7tXM1oehlTTQpv32VYRWQAoA0cZh04As=;
        b=XLlzGn5G+qJDLeH9d8+AfzArCwSbDDmk08/vPfxf2Txluujh5ab2Msya9YR6tbrcPZ
         JMoPxF8pEEaMVUf9tBdghHn59ocxixpLKf/msyTd6GOyC2gUA4xbNIO4nJccYqtVbUVn
         qSH5WL8ESQP0RmLmSrQK7WgHm6V+ZsTzuR/8vW2IAXsLzH7o54/L/o1XqvH+7KCYGqjz
         phqS378DUfhHc8MFwJDk+1eRVw0uONO+jSgdTfQp6DA5jMOOW9aHhnTyKDL7UQ6q4oA8
         y/Z5rpXz8wn99ixXM+C30SDZqEXutRrHd8nEtdKRdfCc+QypGLoyumGVBXqqcsY+PsG5
         nFzA==
X-Gm-Message-State: AOJu0Yz4Dku5lwnI2Rcv/4AkXfCQggr13NBsouMMhjb/ZEpGeWgec+ZO
	MiXgcwT+//kcbRl3eB6CaHQifopqat8yerFl0FwhFjrmhOky7s/62vmbGBlh2s24nkk=
X-Gm-Gg: ASbGncsWADmUMQFGJCWRyawQyd2pBLRQMeqSFbF6yPb5i/ERQ2mhhQLlsV8MgAcNW5I
	NZiXOyfnrYfebj1O9CJl9PKoRodH9ClB6epvIM60YZfI36Xq7EYGZbTL8+FbkNwqzLcryGFHgkV
	leePNnm/zuT09/Vr6+SG2J1HhVf73ZDwn0HCUhfwifeFQjEjIYUnDMKQTfkRlS/D4hhclHUhRQv
	dxaV1mB4JksnDKnos6zO7nCEUQGCOnSUV1BzQmFEQcYOk7/YHdPTFJr4NOFd9yjz39fvXYeVOyC
	DNav4s5MzytWDyK6j8cLxmKI3e/5hsI5A8FAdIGW2i07hKeUKZrwOl2KN2PAAkL01io5CLsDsLe
	6bg9QTpH6DVy6LGEVOmfehNr0kA==
X-Google-Smtp-Source: AGHT+IHRnjnVV4+h89iJA6vomGUrvNgbPO9WKrF6Sr0B7KSXUlhBS820UObNuEt6/CaNgmJwauk31A==
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr74684795e9.27.1756824233151;
        Tue, 02 Sep 2025 07:43:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:5982:3242:38ad:8b12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm209604635e9.22.2025.09.02.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:43:52 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 02 Sep 2025 16:43:49 +0200
Subject: [PATCH RESEND v2 1/2] genirq/msi: Export functions to support TI
 SCI INTA MSI module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-timsi-v2-1-a5bf0f32905b@baylibre.com>
References: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
In-Reply-To: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Export MSI domain management functions to allow the TI SCI INTA MSI
driver to be compiled as a module.

The following functions are now available for module use:

- msi_domain_insert_msi_desc()
- msi_domain_free_msi_descs_range()
- msi_setup_device_data()
- msi_create_irq_domain()
- msi_domain_alloc_irqs_all_locked()

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


