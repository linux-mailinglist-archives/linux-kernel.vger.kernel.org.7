Return-Path: <linux-kernel+bounces-741613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC3B0E69F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95401895D61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74E286887;
	Tue, 22 Jul 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8CPlhSG"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37623E226
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224345; cv=none; b=LvM+SK49m/d6VQ/dqaDa5yQi6XDON2Iay/FjErBE3klRymT5Bz8MKvPLl8F7/i9foPOclxxFYazruXE4yl4D930y3mDmkqVwvE9fc5n0thmZqhVUG37MemzNymuQIXNG/OaQYwVa+gB0BCVUPa60FrqXWpI083gPyIbZqzYVtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224345; c=relaxed/simple;
	bh=go5ka/zq7NZn2JVFhJyLaiuZo7xSpPf0c30OSfI+afw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mI8NmYxTUVpwZbh3ljulG9dXAx5y7OAfoHXU2CBOK+MvIEORLbV7AyFzcHCxXhAD3Yv5MYkDDuFayCkhoDdDcfUNzrbwtAGAmh/XhWxsTAc17khAlwwNhi3yjyWys+duP6LnZJ7nZM+lXPq2Su/f0Kq+E/kkwhETmEYSonCbIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8CPlhSG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7600271f3e9so343367b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753224342; x=1753829142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4xSauVvnguIX8N8z8c8ZGAwLmiqeQy2c4j2Fs1hDjU=;
        b=O8CPlhSGXNhG7SQ5BgMNEnr1QViOSsgQ6ua8NFuJEc6EdVErqmTVpqHqe/PlNXbowg
         9IJs29FG80e4rnb+3M3SwYUF7Pcz5VrAFqR6FNUj1uyCJo2swwUcW/fLn8A9pzR2purE
         sFPZ7+uvnhJzMeHWequp3my2T+Mk4G14xg64Rmu48gfLmeUYHxzbwHZJxkppXqIg6bdF
         ZEMUJF6nxU7VjPX1nzI8sSpiZTUpR0HPzHRI9cqphKdOF2e4pl8aXpqFyk6O/1hDExst
         mfVolSKZnqgKgg1GEY90sXWAV77emnEGxSTb8gnQ75rfGMbbdIhEFdC/RGliJc9yxNyw
         l8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224342; x=1753829142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4xSauVvnguIX8N8z8c8ZGAwLmiqeQy2c4j2Fs1hDjU=;
        b=nJ2HuV5t+7NKiguyY6mVA+r5nClWERadARMdkxBqBdzJtAJ/xHXIqxCVsC9XsQ5Shw
         UmIG2LL4qqPX+VWgFM280GXZETKM4rxNOBpnPArLLcOE0rQV3Xj8kr+M3YQt2E5Pe6kt
         pMpkAz2laYVI/INhvGX6AGoLuisRoucqoH1VrHrn0QE01CmrBeMz/4469Tx5sXrGLmJL
         468s4VWVd6wEumzuV4TTGW/ytA2nPYBd0LFJvEd6GAm6xjn5yllArR7RnRdY5ak0s9Pe
         9/2JBWmU2zaDjnBth7rHNP/T+4U8nhRGzXT9Mk+gQ+kTAjqzqPp5DlzMK4w3h8FtST9w
         8cHw==
X-Forwarded-Encrypted: i=1; AJvYcCUuEnJp7/RJ49BecyRbkrX+/XtQYe+PkwVKd9l9P40VemFhRJKxeSM8NZ0VMiQI0jA2HLY40g7lhwdeWjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvaPjm6C06Q0FDHSpe17rlojzJkQH/Lau33HqvjbL/4lJbkA7
	8bgxAWuE1c7g0bFVz7M7HXcZ3txdPZ0BB6zRTs4UZPuj7bzDtf55H5RZ
X-Gm-Gg: ASbGncvP7hsdQI4xfZwGL5tN9RoqQwXplV6K3ADXxY0F2AuxYZ4cXy7hV0LTLzn0sF8
	sAyzdzjkD3BsxcZ1Hugf4qhBKathW4A0F9+oNt2PbvNUf/OJUl+Sse6oiLJEbsUDc/OhXuSP/Ff
	8eB4zYNlzZ1jQMT3dBLOWBoC7M1mWTVWZV4eIBu1hgoR5RGZZboQBKVr76iE1Cmz1cUlDa0ut5m
	Xnbl+RNMYBDcRF4p7ikrth1u3pIiGlYzLqeAohQj9Ab3Nx9g3JK9dybm+b6k4eKA/eMfB1aZUWL
	BICjHZ+16mOT4+vCEMr9gYlK+QoJaPH6JDZWB3XHyqimXZUB33cjPg6p35gDmmKl9FUDzWY1H5S
	/mHonG7HLryw/4c3U/tjzfQ==
X-Google-Smtp-Source: AGHT+IE3iXyl9prEKWjW+q2lEfn92s/jbphxYF75MzCWqW68us0QTguwWWTaXNC5H/uG4HUzhL1Pdg==
X-Received: by 2002:a05:6a00:3e14:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-7604d1dfe52mr777143b3a.7.1753224341678;
        Tue, 22 Jul 2025 15:45:41 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759c89cfb3dsm8221605b3a.34.2025.07.22.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:45:41 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Affinity setting problem for emulated MSI on PLIC
Date: Wed, 23 Jul 2025 06:45:11 +0800
Message-ID: <20250722224513.22125-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SG2044 and SG2042 has a msi controller that converts the PLIC interrupt
to a MSI one. It works at the most case, but failed when probing NVME.
The driver complains "nvme nvme0: I/O tag XXX (XXX) QID XX timeout,
completion polled". After some test, I found this is caused by some
broken interrupt, which is disable on the underlying PLIC chip after
setting affinity. As the MSI chip does not have a enable function,
irq_startup only calls irq_unmask. This make the underlying interrupt
at PLIC is not enabled.

I have done a hack by changing the mask/unmask to disable/enable and
setting MSI_FLAG_PCI_MSI_MASK_PARENT to solve this and it works.
But I wonder whether there is something better to solve this problem?
(The hack I have done is at the end of mail)

Regards,
Inochi

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index bcfddc51bc6a..ea5bf6fb6711 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -94,6 +94,20 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
 };

+/*
+ * As PLIC can only apply affinity when enabling, so always call enable
+ * when unmasking interrupt.
+ */
+static void sg2044_msi_irq_mask(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+}
+
+static void sg2044_msi_irq_unmask(struct irq_data *d)
+{
+	irq_chip_enable_parent(d);
+}
+
 static void sg2044_msi_irq_ack(struct irq_data *d)
 {
 	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
@@ -115,8 +129,8 @@ static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *m
 static struct irq_chip sg2044_msi_middle_irq_chip = {
 	.name			= "SG2044 MSI",
 	.irq_ack		= sg2044_msi_irq_ack,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_mask		= sg2044_msi_irq_mask,
+	.irq_unmask		= sg2044_msi_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
@@ -201,7 +215,8 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 };

 #define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				   MSI_FLAG_USE_DEF_CHIP_OPS)
+				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				   MSI_FLAG_PCI_MSI_MASK_PARENT)

 #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				    MSI_FLAG_PCI_MSIX)
--
2.50.1


