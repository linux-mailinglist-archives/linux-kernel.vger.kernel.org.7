Return-Path: <linux-kernel+bounces-617791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3897AA9A5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7200B463816
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F01213E76;
	Thu, 24 Apr 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lCAdj/Ug"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAE20E30F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483668; cv=none; b=ie6bmKi58vri+dLxSmDD/KuX2IWQ5ll5K2HDZD40eZU+jgS5uOtx2i/2D0xNhjM/IAc8QDgxM6S1YINOdYzsyuM2gz9LTNtX3oYA/CyxvImYMQy3YD3ieWNep/4xyOz81VztuMbWhZF1JREyTXjSb02MYBuFARWRW1Krz1eUS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483668; c=relaxed/simple;
	bh=K1O/ZXnuPZvlJKjkZceWhCJx16Ps0pz6fRC0LfxqGpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnNNmz8NorA1yygaCi84lj+U8vkOeqhFsUqw0r4b0cyPFClQs+Npr0BOXRpU4wWpS1AuE0ogP/eRwb7umTOZFVhlTalKaDIIwuGtxZPVuJdprVdYTzJ72dw7qPnj26nxBivdmSDDWIfW9HaXKk4DWuCsX4l+RZ3Tkp2alS1RLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lCAdj/Ug; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so499126f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483664; x=1746088464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=lCAdj/UgOdP/D3dTDwjo0KWIEs95zgh2yH0PG54Ch+k6dEEZoMzLjB5KuArdwGhYMh
         +HqWk+KDLWY9QtZZzIHVqtDFYvlj2rOKAFfJThVL+NFPlQ5L85E9nnwnPii+ArpE14EN
         VcY0/+aabxcKzp8bq/GpdWeCwF+HmuYIePmqYnCmjLH3mxPANdtPybdMhqOdohY+YfQc
         ZTt83P6u2U3V24k5wzuifEg3+Epf9iEd0DunuBqhsVd80CeIe0K0cHnbKqmTf05OwkKE
         WeDooMpzJfEPwkrQBG1JpzUYrMz15G+INFNNSUsjXTxrCzQW2yJeJ6x9uZalGVI1oW9+
         JGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483664; x=1746088464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=a58VW8TmdxY+Oeuw8EfMx8NsKN8pmHYG220+vjqPteUUPYzECkDnnKWNpqtwRoHX2v
         e0fahBqF+iIFgnxI1vZCRjsYSJ2NXtsRhYXcGFNxO8RuJFrN6XiCU9I3H/GkBQQaKLYQ
         7wmeJoOoBfZN0sWyKY53FT/t0F7CYEzU1Okggr0tDL8cbjBJCgJXXmZZdCU5Vaw5QW0W
         B05mlm+qTtV/atIFkoFhIueL5Se2HPR0I4xGU5ai1gYQjYPC1LaO1622zlYcSMFECdeL
         qyMCsoM7/fv2+bZi5LSL78tLsXC5cpint1yt+kSjyKKpPkQXxmM5g3TMjccNQJIMIpiB
         hPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGriUfJwfyfj79bpUhCQV5YP/GCQEkllBqkLt8mkHhwagSZ4z4BYrwIpI8C4BZA1jTgf56I34H2t8ELdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG02h/KqOhxvjaOIcc26ri+Hnl3qKFpIRSMSMjYFVccZ88SkWx
	VyCuDDm3pPW4av4Z6nFG/l2+MM3sNvO4ToH2Gm8NI0A3+v8yK5OB8l7k8HXfh48=
X-Gm-Gg: ASbGncuIW5l+KKnmcYnmsGKtBM8Xd9W9B42zwMerYTl6gdsYhsS90W241XBydJBgLVi
	XLf6a+HByf7dOjkr4YcHD96RNHdrotFEZeL3f8UDeiQIVBgXCDmoKU0ZsZYyjTVwoHjSKhIESEs
	XBuBJrlppiNJWukDx2f7q/2tSbsz49PpH4HMeZmfkQGBOXLCocCDkv9ml8MzuZZ4ATI2NUZsoqf
	hs9MegoXuE4PZZl45f6MNtUVB/BAJ0UFHqOXbV5r+bCWU6Pjg8h6O3NUfAgnVQzXKCQccHUf+68
	q7vvR5JbQvuRoQ4Nk76vYlDhjj9csSFmgTqjHJHQ2W/Vqj/egfzUuw==
X-Google-Smtp-Source: AGHT+IHCyKzJ42aHroSUm8dSFe+zZZelO2D51+fPKE0kfSithPmCpekbPV1qFCzXw6Neqmf+66ygKw==
X-Received: by 2002:a05:6000:402a:b0:39a:ca40:7bfb with SMTP id ffacd0b85a97d-3a06cfc603cmr1159155f8f.54.1745483664218;
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:04 +0200
Subject: [PATCH v5 1/2] PCI: endpoint: improve fixed_size bar handling when
 allocating space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-1-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=K1O/ZXnuPZvlJKjkZceWhCJx16Ps0pz6fRC0LfxqGpc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeM6J6+pCgmEwgvc/aDPPGIR4Mg3nyBaNxNK
 M9t502XUfKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jAAKCRDm/A8cN/La
 hauFEACy9VCXN23DaPGmIJvmbM9qPENNPeRyGmzMlpjo9DyMfrnp/xORgiKYBJ/WDqk2ZCTuzb5
 LVUqVG9RH5jxpaeKqIrotYbDMNSlgLhWOuaBQP1T8a+JDJLM4rtQ/0lnJ8yZvdgRKogdt5WwE7+
 zmcccvWz6URwDuAoSOkmv1W0HGXru4wb25nksRsusTUX8d5ysjesdqnKgTraDayvGYPBuSVi2Oq
 ztUkpECUs/l+jC1EvmEqpzGo+VsHdjlCqVbSBJVp5jHPNAAihAuzmZMjTgpW3j/DJqHZ0+pu2We
 SEigB2bd8LKgw8zfgaHExZvR/KG/7I+Ifm+JNn8bLsi3Ed8WKC/MB/pmwZlnLHtoyyXMmiHkjnd
 lS2fcH+Oit21Z5RWOLEcwl6YB00c4HxgCOe0NtL1pomY/L2dcu+jBDMjEJl0yWtdARoNyeDlICw
 f9/m9I7PT9XtYDe+2/xoG7gzFS6FIq4scZJLRqkySW86rzOp6x48T/nPDbVHNmTScIw5nT/6SH3
 Zx/eGdmu+lte3XBuO9UoLGpgSJ/n71ZSROD3IO2/3RlCIKnWqcxALEnRrAGPGqq0m9NyCa4fgXJ
 f2QbU7wciMaErvjDakmZi/IYHo0aq03r4CrlEizF8oh0vB9ggQwsvDOeNLrqFXzP651wIhJNN6p
 42/4zS67gD2wWxg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When trying to allocate space for an endpoint function on a BAR with a
fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
size. This is expected by pci_epc_set_bar().

However, if the fixed_size is smaller that the alignment, the size saved
in the 'struct pci_epf_bar' matches the alignment and it is a problem for
pci_epc_set_bar().

To solve this, continue to allocate space that match the iATU alignment
requirement, saving it as .aligned_size, then save the size that matches
what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 21 ++++++++++++++-------
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..982db6c1fbe77653f6a74a31df5c4e997507d2d8 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
+	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
+	epf_bar[bar].aligned_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -285,12 +286,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
 	}
 
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment requirement.
+	 * In most cases, this will be the same as .size but it might be different
+	 * if, for example, the fixed size of a BAR is smaller than align.
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -301,7 +307,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -310,6 +316,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
+	epf_bar[bar].aligned_size = aligned_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..749cee0bcf2cc0600ad3be1582b0c497c5a21bed 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -121,6 +123,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
+	size_t		aligned_size;
 	enum pci_barno	barno;
 	int		flags;
 };

-- 
2.47.2


