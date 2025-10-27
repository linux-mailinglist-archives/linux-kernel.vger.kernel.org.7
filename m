Return-Path: <linux-kernel+bounces-872089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A6C0F3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD4750234B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4561FF1C7;
	Mon, 27 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EngibcDH"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A533115AE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581786; cv=none; b=ng3BpzcICAoVxC6Sj6EG8btSaC/7zK27B6pC70bSiCo3/hne8B9+PZqYjgv2M8tltfOv9hZBSnfKXcENtsGZJu2GqcsS+AL+Uw0ZehnU5V3Ro5kg+qpQZq3rLbZ5/OXQ+CjpletsGg0hNHWzWLF/jEELEvPXiKA0OKdowQ26im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581786; c=relaxed/simple;
	bh=3wCGtKGfEfUVDnBC8C5bVc0OXhTWmTJ9owWx+LYZ9Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHU0IHAN1K07HgaPoCqyqTqv/0v8c1H89ElCgKGShkHn6RmIOHzqhGuD6weB6FnwxTHEYpwtsKcHfXIHxcuNBYVgm3a5S/8cbJcopARFgMj7L+p50eOmN1Eg+QuqtaFe33uhG1Kp4nacJEGwgmhiPhekX6cmN4a2h7i5HPSoXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EngibcDH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso3664610a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761581784; x=1762186584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C5nkX5sn1K4bEz3EiVINhEQsJt21mryoGeQgXdKq0c=;
        b=EngibcDH6Zs6Q2xvaGX3VSpLkfSpf8vVMFxY8eDc3elPTLtpR/MWs3VNLnMNO5MN5x
         GE5lx25FUsCIwRCtMIzczHG1AdNCxX/V97LyvsJq4LXXM1c3sVQndetj6aULkcYGk/99
         j32o0F1ooqEO2CtK7zjsdA2bIPhxWIeyTy+akzTGA6Wd49c5/SjIcLoPe4F2ce86DM05
         m/84nENiQG1tAso2aXjkTA7wh43nHHBy070E1hpXoYO4gBxoohZUlCWXsgRXMgtq5zH0
         NV1cVK75usvi1/j1aZgyUiWuPN094AJXr2fNmyTFEpMy2WiGDv1VRR0jMdGlqtUzElCh
         H4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581784; x=1762186584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+C5nkX5sn1K4bEz3EiVINhEQsJt21mryoGeQgXdKq0c=;
        b=MC3oLI+QkSLs0RE6hVaY8WYdrhu140Q/BlornI/Vp+C0dk/qnSJfTWokiU0OMOVgUd
         aEGPA0Vob3WZGRgDlu5d1WK1uvffETQg+/5vg8RIvnq+s2JvtEEMkXMFpLs1E+H/0j+c
         CPTlCvNRRzysAA/71DvxJTxrBiGM8N9gjAM9EZUnE4RVbBdLTAcTGQrSTiztSrQJOLko
         teJMvvT+GI1wq0W5TqBqpQfy/1neJt/oIoy9WxPdzKfDrDnnlUY8kqXYr+cC0MAvyVhT
         bQ0POmnflWSxykvFPGvnreozqYOXAJY5G2NzNZWVAdczdFRIT6zofREjxZHfmZsVigv8
         akUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngUbAaBs/ym2//SANo0eCrWct0JMyzC17EQpJeyKezKmwySSJhkwBg/b/259q6nZJb0bi9SKnmlv1+R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96bJ3y4fexpaUirDzsmBAFaDM0HerwbNLcX8tBp2of8Su9Tng
	CNWB9rmoOBzTn8e+aGpaCVk4N34gpDVheyOOUXfRXU+5xXekfCKnfLZwiJXrisCbIUo=
X-Gm-Gg: ASbGncvVhpXxUo51q35meAUBja/28i/5AYRk9t5s8gYt/mBKqllriPQYr9ExSJuOXXD
	zwIoYcDdKA9lGxGWWz92SVZEVaEb9Gco+r4TZvOGZ6y7i30Wkv8J7QGsAVg8pxRjIIuzNpyt6x5
	aTGIrAs7Sy8Fco7s7B04Z6tdX2RhOV27ukeecuZM3gg9FSnLtSM1B3xoUXfNvTlW39RTAmU5vym
	qNEUW/elPlBhYcWECoDY0bUQJucPpEaEFKLAPLWZEuFFKBZzYJA7aMFML0KD4v9NwJVYPx5nqkh
	JfwX3kT7T8F7zow6+UsAKaQt2FgiSKX8YxiJOZaLYj0uegdgEDpi5qYNlYK97tT7HmE/PTQqOHe
	cikKjPIedC+dpvykGHUWDNWF5IJrKjSOuXOqbJthRQQsYfADqQop5H+je2lk1PHrfKR40reB9po
	0TlPBkH5z8RY9hQ3X2S9stpKQ+jHNbjsOuZ2ZdPbOq8po+
X-Google-Smtp-Source: AGHT+IEvo0w9nrmzLwC61hMvEr51HQII0JiZ9ihmX2g/MOfxFywkHmUnTCvOH6rmdOxXEsaaHDwS4A==
X-Received: by 2002:a17:903:18d:b0:269:936c:88da with SMTP id d9443c01a7336-294cb671783mr4897625ad.41.1761581783862;
        Mon, 27 Oct 2025 09:16:23 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm85701305ad.55.2025.10.27.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:16:23 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Tue, 28 Oct 2025 00:16:17 +0800
Message-Id: <20251027161617.4020-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
References: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 27, 2025 at 13:30:17 +0100, Jörg Rödel wrote:
> > To preserve PCIe performance, ACS is enabled only when
> > AMD IOMMU is not disabled.
> > 
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> >  drivers/iommu/amd/init.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index f2991c11867c..38e8c38c5f10 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
> >  	}
> >  
> >  out:
> > -	/* Make sure ACS will be enabled during PCI probe */
> > -	pci_request_acs();
> > +	if (!amd_iommu_disabled) {
> > +		/* Make sure ACS will be enabled during PCI probe */
> > +		pci_request_acs();
> > +	}

> Instead of checking amd_iommu_disabled here it is better to move the
> pci_request_acs() call to early_amd_iommu_init(). This function is only called
> when amd_iommu_disabled is false and runs still before PCI probing.

A previous attempt (https://lore.kernel.org/all/20250928065817.1279-1-guojinhui.liam@bytedance.com/)
fails when interrupt-remapping is disabled via CONFIG_IRQ_REMAP=n or intremap=off.

With interrupt remapping off, early_amd_iommu_init() is deferred to rootfs_initcall(pci_iommu_init),
which runs after subsys_initcall(acpi_init) and therefore after pci_enable_acs().

Keep pci_request_acs() in detect_ivrs() to set pci_acs_enable before any PCI device is added,
regardless of the interrupt-remap setting.

PCI devices probe
---
subsys_initcall(acpi_init);
 acpi_scan_init()
  acpi_bus_scan()
   acpi_bus_attach()
    acpi_scan_attach_handler()
     handler->attach()
      acpi_pci_root_add()
       pci_acpi_scan_root()
        acpi_pci_root_create()
         pci_scan_child_bus()
          pci_scan_child_bus_extend()
           pci_scan_slot()
            pci_scan_single_device()
             pci_device_add()
              pci_init_capabilities()
               pci_acs_init()
                pci_enable_acs()

AMD IOMMU initialize
---
rootfs_initcall(pci_iommu_init);
 x86_init.iommu.iommu_init()
  amd_iommu_init()
   iommu_go_to_state(IOMMU_INITIALIZED)
    state_next()
     early_amd_iommu_init()

Regards,
Jinhui


