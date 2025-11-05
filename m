Return-Path: <linux-kernel+bounces-887420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269CC38305
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69FDA4F0D20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B692F12DF;
	Wed,  5 Nov 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="F0y7+4sY"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653E2F12B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381568; cv=none; b=i64YmIx3+zABTcVrSPt/ywcFJ4LebMip4O2mnVmdPUEvplutUFueiWwuWd1+oSV8FGI5worFFZ/+beruRW4lZCf2BNbhxMYapKATe9+qHnZZ0ZJ8G0V7fqI639xE6F2Wl3NcewGq9Pg5eoOUiKNWzxqez+77jo8mzldr6LiBJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381568; c=relaxed/simple;
	bh=fb292zlEezfUJ98xZheff1VZ14Z92RUCuFi12mvIEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0cMjo4EWh1Kf1/4nuZcw3rZ530hxVS94Sl2Fe4ShRfshEfnHP5DGJR+F9SGZrCRXBvy0EFBLxeCUPW2a7I/0glD5gAduVrXPLm8/Oi6HYiN6YcmSU8LzKS98tJ06clUyrcmOxlZO8AtLwLYrc9w8VzBME42Vw3f7ZY+fcUiQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=F0y7+4sY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed65fa5e50so1664701cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762381564; x=1762986364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPJXVCzpkSpBdBb83PCDJUzRglYtIsatm0yX8U+Anzo=;
        b=F0y7+4sY7E0va3BoJv99e5X9wOsJxNzUOcI9EEBo0vrXOd+4KSgP1gsoXOCPgJQ1ae
         /zxmT8tkWEX6EOfXKtHMODP0Y1r4yUxwMgnM8A1VZ6/jw4puM2gEAn+ryxXERJlYY4mm
         4KwfIEJTI5OvUBpsI/YuxqpvSrluBpdokhpPsq4hnwMm94uoVdnXSwpXM+RDcra0Yu60
         cUMmFJ+EUKQAl4eV1acxdiFh0K6w4pwQFd3Qhh8tJ8t/z6Ju6Ni1rCDy6HxJ2PFxjDjq
         Tm2m4uSwLEGEZCBWIjnQRjr2o6sOHardn7C+cETrp7rzKOFMsm9vN6z1+JatlTBql+Hp
         qk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381564; x=1762986364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPJXVCzpkSpBdBb83PCDJUzRglYtIsatm0yX8U+Anzo=;
        b=eHly1p36wSP9GWIy4L1L7yAKixJbufU7gw69uAQ5dDRpqG7ORb4P4vU2jTI7LMhUoF
         E5BC6C5YbclaAp1f4SidIjpCwuN0j86Dcs0/UveQ9g75BxmevuM519CZy93OBWuvlnHW
         QMyNqcLsfdnyOD71B14xve2UwJGuTBBXASVWGm/9/e5gniJDWhLXhj7+02pvt9jEdKJZ
         nydomvt8IyEEcu64+QcEFRadhyw9HjxKkftMGvhsNQHNtxOWFOXKckKpP2yq4o5aHNMs
         28CrWvIvO4pxMAiYCT6uzpNsaElUL2haWex+gf1pcxcL7JgPUwdGIWAcVHxy1yLe/lZC
         /Hgg==
X-Forwarded-Encrypted: i=1; AJvYcCU30tRpoN+60Gp74e+H7/wYmiUVpdTItgSjqGJBRCb9exCWCdXMZkn6iLYNOER/HwKPez9sC/Zz6ek/vHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvQMWcZUlWDc5N2om0cGuNGBfUWhyjYtApvDb4s53DE/vlVW2
	ayB2zw3//paZHUXqpU4XL4pLCo67PuXM8F1tEpJRSruop9JiPAT8UTsU7Ze9lNnehPw=
X-Gm-Gg: ASbGncvK7WY27gPjTCbWY2Uu6dhYWvy91ozpb4UtUmSvGowoiMHQEk/joRfshuod/K3
	YIt8t7xj7lSz7WBmwUZ7hxvR5Ywn7faKVpyCHqiIMnLUq/UcggS5zqazFB7+wcYk6W4pc9qxzZv
	EyT+iKyv/YVXliNCD2JObgO5WeDMXohXP8EP2XI90HGI11N5iYK69KNrX8NzXkkqpNG2OColsEB
	RXJR0pKzQ6m7t3u+bOeLe0VOgkRwsHkD7ecfiaCu8EQVIqXVQ8DIKEqg6PECV34gVYBpIWeOeO0
	y8tl3SuuH+Od0mkRUFDMbkTBHFRmXZCXvbo2zvlIqkJpObrfPp7dEaQKStzksYFoJK3VokW53tM
	KwWHzJ507MStqHW04OIQVfVFAfS/IAt4igJEvYuiEuFGL+UhhGotMKgaLtoKMR1+2X24frXtHuZ
	TYo+Btn5B6x85sIHhpcid0wte473Gw3nlnfjrRN8qd49Il/7Yn+Aie1KovIQ8=
X-Google-Smtp-Source: AGHT+IGKAyeJ9TLov73WaqTicHNOCiHYLdqb1f+w5zGiAKDCTJ0LO7K9L9cNEmuqoRqNds35jwnbgA==
X-Received: by 2002:a05:622a:d0a:b0:4ed:7f5a:c6d8 with SMTP id d75a77b69052e-4ed7f5ad803mr24070971cf.41.1762381564451;
        Wed, 05 Nov 2025 14:26:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828f5b32sm6116936d6.16.2025.11.05.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:26:03 -0800 (PST)
Date: Wed, 5 Nov 2025 17:26:01 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> > 
> > [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> > [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> > 
> > Probe order issue when CXL drivers are built-in maybe?
> > 
> 

moving it back but leaving the function seemed to work for me, i don't
know what the implication of this is though (i.e. it's unclear to me
why you moved it from point a to point b in the first place).

(only tested this on QEMU)
---

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index ff6add88b6ae..2caa90fa4bf2 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -12,8 +12,10 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o

 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
+cxl_pci-y := pci.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 2937d0ddcce2..fa1d4aed28b9 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -21,4 +21,3 @@ cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
 cxl_core-$(CONFIG_CXL_RAS) += ras.o
 cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
-cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a7a0838c8f23..7c287b4fa699 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -223,13 +223,4 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif

-#ifdef CONFIG_CXL_PCI
-bool cxl_pci_drv_bound(struct pci_dev *pdev);
-int cxl_pci_driver_init(void);
-void cxl_pci_driver_exit(void);
-#else
-static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
-static inline int cxl_pci_driver_init(void) { return 0; }
-static inline void cxl_pci_driver_exit(void) { }
-#endif
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d19ebf052d76..ca02ad58fc57 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2520,8 +2520,6 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;

-	cxl_pci_driver_init();
-
 	return 0;

 err_ras:
@@ -2537,7 +2535,6 @@ static __init int cxl_core_init(void)

 static void cxl_core_exit(void)
 {
-	cxl_pci_driver_exit();
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 97e6c187e048..a2660d64c6eb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -941,4 +941,10 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
 #endif

+#ifdef CONFIG_CXL_PCI
+bool cxl_pci_drv_bound(struct pci_dev *pdev);
+#else
+static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
+#endif
+
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/pci.c
similarity index 99%
rename from drivers/cxl/core/pci_drv.c
rename to drivers/cxl/pci.c
index bc3c959f7eb6..e6d741e15ac2 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/pci.c
@@ -1189,7 +1189,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);

-int __init cxl_pci_driver_init(void)
+static int __init cxl_pci_driver_init(void)
 {
 	int rc;

@@ -1204,9 +1204,15 @@ int __init cxl_pci_driver_init(void)
 	return rc;
 }

-void cxl_pci_driver_exit(void)
+static void cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
+MODULE_DESCRIPTION("CXL: PCI manageability");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");

