Return-Path: <linux-kernel+bounces-754400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E833B193D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FF8167620
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9E2586C9;
	Sun,  3 Aug 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="jizwrHwB"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC771EE7D5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219969; cv=none; b=k/rL1+g5OnAe1m2XWIVTgjT6/HesvXRgQQZyVh4GLixfOrdTNaf3rQRTu1uLJeoyTrMe9bHaTBHb71zRMVkIcWKNEuutA65gfWjVcwUu5zF3uRebdKMIrTimxLAKDI3GlxW+jqEgTzVRuX/Y6M4Z7EiPEgs2eYOwsor+omBGpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219969; c=relaxed/simple;
	bh=JEIqAaeSSTe4zb2P158wF7vNe9WridvvCtdLwz+gNKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iHSt5heAYUyt+g2FKAaQdUBiAopGEi6alQaq0jsmjGVPktoT1U05BSHNLzgDrBmiH4Jbre7PMagKuGMHV0N2+JDdWCKJ1gS4NPD96RJq0GWuMGjOIYYRh0dx628YgCJ4Pbzm6RFE7SDPl3qh+s//1zDZo+jYaMSw1tNuRdaD38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=jizwrHwB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7075bcdbb0fso14947906d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219967; x=1754824767; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Cqe+T/w1aqF8D4toCcW3enb5tvbSckuBh2Yh9OKkf4=;
        b=jizwrHwBdrcICSeLRDNjYsx8UDbejCY/9t8mgzWLaETplrZ0DXyL/LFIR/Mg4x5DpO
         5fQ8hJ5zo9ePSX5yDMyJ5TQ7HkLBCQH86gDCB+2hjgH2yOmx01R66JHpohimhUUUYJTD
         XVKTICMQPT0n4IH+drMBrFvCL5nyfDLzJP6ewgq16W4PFEyBJLC/NKkrx5uzxPwAY0X8
         gd/OKiMTW8ZlN6qQq9b73+TtfPOGwUFhETKBAVzQ9rZG/AvWIFZ3ajJHaBVf4Ks73dco
         EVU3m/VfEz5Vja9j/lXdkr1e1dnq+z05vcRtn0ZWhRYp8TbV1/xquR4vObgFuK8zgoYE
         CiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219967; x=1754824767;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cqe+T/w1aqF8D4toCcW3enb5tvbSckuBh2Yh9OKkf4=;
        b=gZXmPoiBRiacyIygm7gK9sXUtj3RVw+EgTWx6LTrSnpNMcl5ypkEFYRZvn+pdwRRrP
         8OZjhqIKsFUHQ50jxhIP4NBRZxkTLz0kyc8dHhmiwq4JSeUxYAHwS3ONxTC5hKEXA9C8
         GiT7nmCew8Qd1VecRL1GYwmtq9dal3k0dtnJ9J730sQo6X0i6p6X4PnkxR/ftxymkNx/
         a+trKfLhLNKWoPSjuiV6PEZkgPvqlr/hLEGEc1Xm0McrEtIl+C12p2rWNIAJfG5QtJqD
         KxPkYGt7GBCWVYkRtGqaJykV/4atTCjk5HNAv4RRMri6EXmR3uU2bXx/Sxll1n+iPe3f
         VtuQ==
X-Gm-Message-State: AOJu0Yx6c4Klud7l8IKx1zC0bHusYvUgYbmPOsn6dZLpShJwf0ylpFaT
	dEgbSWXJkwLyQ60QlnofMobI3AJNq9j05F69OVjp+44RY2pdYBav+gu+oM8XK9iPstM/mkXiqaH
	mV0grUrlhUgCPMClEpGLcGYTmIDCHqhvglMcWCZRL2iHiGsHYAxa65ME=
X-Gm-Gg: ASbGncslxbSILsCBbXIwOQD/GPI/5D/dmZeMZar/bNeQO0loIkFWHNjLvSSPju72f5i
	PKCqbA6AveheI8cu5dQ8PhNRMy1T2lvVWK/bL9/hxJzq4lpM3mlFvphu1ljr3//zJ/6jvLCP2Nl
	5av1IQTI6EZueRQRgcMXUzUhX7wFauw9JJrAcTxfFCx0t1C5Dk927o5kCm9hMnOOvCVaw1VQ46G
	twNaSNJ/A==
X-Google-Smtp-Source: AGHT+IH79hbBNueSlF5JYIs0NnPGvu1eDl8QSOMF0wuYP7PZ6tZU7zZDhIxvohJOgZdaJoq7voHH1e53bSYfSP3+lt8=
X-Received: by 2002:a05:6214:d6a:b0:707:c63e:abf5 with SMTP id
 6a1803df08f44-70936346a27mr91242696d6.49.1754219966617; Sun, 03 Aug 2025
 04:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
 <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
 <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
 <CAEHaoC1mHQp62GMBofGJwKBkjgf8rQr_tUxwESKa7Ehd6_3nWA@mail.gmail.com> <CAEHaoC2JjQ0k4B3T1eK=4OhwTE_JxwgZ5A=nBjheR5Ehspwj7Q@mail.gmail.com>
In-Reply-To: <CAEHaoC2JjQ0k4B3T1eK=4OhwTE_JxwgZ5A=nBjheR5Ehspwj7Q@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:19:15 +0300
X-Gm-Features: Ac12FXxlBbV7sfM_8D5fHaGgujdshUelpXKeJxFm84ezztxpfxBfdMc4uiMweOM
Message-ID: <CAEHaoC1uCJ98JsYt4x2cHwOM6EvLotj5MTNi=1iGSfc3DOD3hA@mail.gmail.com>
Subject: [PATCH 8/8] Large DMA alloc/add min_dma_addr to device struct
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the ninth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Some devices (like NTB or GPU) allow mapping of the system memory to PCIe bars,
allowing to implement PCIe interconnects when devices are connected to more
than one root complex. After one root complex does the mapping, an application
on another root complex can access the memory using the PCIe bar of the device.
Since a typical system memory mapping uses offset translation (between the
device bar address and the DMA address), the device driver needs to know which
contiguous DMA address range is available to satisfy the device needs before it
can set up the mapping offset. After querying the available range, the device
driver can set up the mapping translation and use the top and low DMA address
constraints to ensure that future DMA allocation APIs will allocate DMA
addresses within the selected range.

This patch adds min_dma_addr to the device structure and uses the added field
in alloc_iova_fast() API.

commit 0bebd4d0829b941fc38c1311efa7309c033968e4 (HEAD -> master, github/master)
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 15:29:40 2025 +0300

    Add min_dma_addr to the device structure and use it in
iommu_dma_alloc_iova().

    Devices that map memory windows to PCI bars (for example NTB devices)
    may need this change. This is because such devices may use very large
    memory windows (terabytes in size), and they cannot simply cap the top
    DMA address to the size of the window, since the range [0-window size]
    may not be available. Such devices can find an available DMA region by
    calling iommu_domain_get_lowest_free_address_range(), set up the memory
    window, and request DMA address allocations in the found range by calling
    dma_set_min_dma_addr() and dma_set_mask_and_coherent().

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 414d31347fc2..077d1cd0939d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -810,7 +810,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      * expected address bits are wired up between the device and the IOMMU.
      */
     if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
-        iova = alloc_iova_fast(iovad, iova_len, 0,
+        iova = alloc_iova_fast(iovad, iova_len, dev->min_dma_addr,
                        DMA_BIT_MASK(32) >> shift, false, align);
         if (iova)
             goto done;
@@ -819,7 +819,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
         dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
     }

-    iova = alloc_iova_fast(iovad, iova_len, 0, dma_limit >> shift,
true, align);
+    iova = alloc_iova_fast(iovad, iova_len, dev->min_dma_addr,
dma_limit >> shift, true, align);
 done:
     return (dma_addr_t)iova << shift;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..339c9187b033 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -621,6 +621,7 @@ struct device {
                          64 bit addresses for consistent
                          allocations such descriptors. */
     u64        bus_dma_limit;    /* upstream dma constraint */
+    u64        min_dma_addr;    /* force minimal value for DMA address */
     const struct bus_dma_region *dma_range_map;

     struct device_dma_parameters *dma_parms;
@@ -690,6 +691,8 @@ struct device {
 #endif
 };

+#define dma_set_min_dma_addr(__dev__, __val__) __dev__->min_dma_addr = __val__
+
 /**
  * struct device_link - Device link representation.
  * @supplier: The device on the supplier end of the link.


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------

