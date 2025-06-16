Return-Path: <linux-kernel+bounces-688722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADDADB63D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CBE1890466
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F3286427;
	Mon, 16 Jun 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3s6TluD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680A286428
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090074; cv=none; b=K8457MG4qFTbYHUiQkpENlt12qMb2KX+v+fNPyGRc27hqfs9EwNBx0IDRh6VOqr74jLUYc5rFBtbHwWSE8ZmmrSJIc8ygUnsNSaoaN3hZGKQiwpgCQchaAiadTJStIDd+8rIp2Gl6m7xho13x0sb6oZVrZGFDAQrHsnvtLKSG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090074; c=relaxed/simple;
	bh=ZA6S9shc1QEX3PEyqUllB6Vi85lndLEG0kzkNo7/Ypk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIZ2f202gf6lsiy7zi67+fhOg2x7BHYZdegv01v1tx9glE6shVLHGdFGopjKn06l0c3Po++SicNBugab1eIllf2N+P3gYlZ5AaxkJdwKmW3/GJSEouGBgO6xhWC+VpRcq7X/4WM7iF1pTt9yDPt0WBDHgz6mzectv4KgejN0Bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3s6TluD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so39892535e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090071; x=1750694871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=a3s6TluDxHNO9L6Ppp/c5qLuQ4qi+zVkatDACSrjNQzGMPwNIgOmn/VZz8jg1qfjXc
         BXFJ/8N3NKzS9QTT4nmSoT6jHT8VAyO/w0KHLiCMrtl39msoo62nrIVEmchKwR3QEjWZ
         1IuZmKD370XRIdCKBo/ZDWMmy0perrx80w4XGqsxz9zHhe8YHzKUP/7SiX8pvaGaf/FO
         x1n0z6eE1gbJO1eGX7b8hPD0TA5eGqHlIIq678MhQg2B8ooQP4iyRqY/wiBl0ykvTbNl
         R+AMxoNHEjQmhKEUpIRBvx9k6hSvApOkL4mNSwA68tU6g2guvBbQUBHK4zlXYGsLQ3gD
         xJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090071; x=1750694871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=TFgTRuApFgqINcGrC9hQiuWngPoWX/vDZtyZDE4TgXuInMPZcpykcn+BrOYkydqbMr
         tboADYefZkfroAO04xGIktoOV4eReOoBU08EUbtH0/UHUCGDOYDeiX+PbyB+ULHURfMq
         Kaujd+YA/3eiIuWjEd0GWvqoQ2TCHsPTYb04YZKr8ZadjaRVjYI1tSracTHxEhryM7PG
         qUa/j1tHHWi7csLsIQZzUEV/SqJOK+hepXJitabgKq6hDKxSQXcfdpzUAkAn3G54IW3k
         5ABLXgPGLfSQ4pMMKsstC4WwKUScmR4G/R4y8g+uPK6S7WzOw94qs6cBQYcj890ry+Pr
         dF8A==
X-Forwarded-Encrypted: i=1; AJvYcCWJyd65CxBn+D00INMNPmXW7r8lFMTaIO9j4FLveXq7Mmv6TO73L2kCfccGDXqtZZcadZrwP3d7DWynM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKbsEBJ7zSUyh2ph9KMNIiRo6YYPvuTAt2O4jdMUQONedz7FB
	uuhh+jWr9X6bkZHk7eaYuBbHWorLgC1hUZegCfytliswb1lKTVI2WAOjn8sxp2PMEnw=
X-Gm-Gg: ASbGncsJWbuuTODlM30JbzTPzxmVR0TwtHnJESFBzFWlYgUZFUPnltfBJvhw4CcBRJG
	FRnQUFBWk9Ogm86IhhPewGBpzI1fho3VvdCUBABOtduxhQithpaY6cpLE3utq0YHExuAXSrrNdn
	IZSoyJV79dMonb0kGVpN7wCvI64ZQXVPa563+MRkiTYIQ64gN9TeW9xvI4pQWF4viuwYUCuvLLN
	yjwI6R8dclEgpZ+LUqK7UzZOsB1fXhkvzmN32jhXomM+o3+Dhq+mdUyKqK5fLY868OG4hpg+bRB
	XYMxes9mnOw2kI7kbm04pmEMQRQSscI0YruqadQ2Vh6KCU6ncwuE2GbnesDgpDKkhLyn0k/p6wa
	ohs3aNEh1Hcqv7Q==
X-Google-Smtp-Source: AGHT+IFm2XOGvEu+c2Vt4oKDTOhDYuX0Zc67/qbAzwRfpRIo4JlzBUdpBKcXvIOmlDkGO4s2VlIKAQ==
X-Received: by 2002:a05:600c:3ba2:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4533ca79d19mr100567515e9.3.1750090071100;
        Mon, 16 Jun 2025 09:07:51 -0700 (PDT)
Received: from myrica (92.40.185.180.threembb.co.uk. [92.40.185.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b19b32sm11602270f8f.67.2025.06.16.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:07:50 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:07:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devel@spectrum-os.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	eric.auger@redhat.com
Subject: Re: Virtio interrupt remapping
Message-ID: <20250616160735.GA5171@myrica>
References: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>
 <20250613181345.GA1350149@myrica>
 <6b661c62-c322-4f2b-8e4a-da1d5c5e48a1@gmail.com>
 <877c1ed9o7.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c1ed9o7.fsf@alyssa.is>

[+Eric]

On Sat, Jun 14, 2025 at 10:11:52AM +0200, Alyssa Ross wrote:
> Demi Marie Obenour <demiobenour@gmail.com> writes:
> 
> > On 6/13/25 14:13, Jean-Philippe Brucker wrote:
> >> Hi,
> >> 
> >> On Fri, Jun 13, 2025 at 01:08:07PM -0400, Demi Marie Obenour wrote:
> >>> I’m working on virtio-IOMMU interrupt remapping for Spectrum OS [1],
> >>> and am running into a problem.  All of the current interrupt remapping
> >>> drivers use __init code during initialization, and I’m not sure how to
> >>> plumb the struct virtio_device * into the IOMMU initialization code.
> >>>
> >>> What is the proper way to do this, where “proper” means that it doesn’t
> >>> do something disgusting like “stuff the virtio device in a global
> >>> variable”?
> >> 
> >> I'm not familiar at all with interrupt remapping, but I suspect a major
> >> hurdle will be device probing order: the PCI subsystem probes the
> >> virtio-pci transport device relatively late during boot, and the virtio
> >> driver probes the virtio-iommu device afterwards, at which point we can
> >> call viommu_probe() and inspect the device features and config.  This can
> >> be quite late in userspace if virtio and virtio-iommu get loaded as
> >> modules (which distros tend to do).> 
> >> The way we know to hold off initializing dependent devices before the
> >> IOMMU is ready is by reading the firmware tables. In devicetree the
> >> "msi-parent" and "msi-map" properties point to the interrupt remapping
> >> device, so by reading those Linux knows to wait for the probe of the
> >> remapping device before setting up those endpoints. The ACPI VIOT
> >> describes this topology as well, although at the moment it does not have
> >> separate graphs for MMU and interrupts, like devicetree does (could
> >> probably be added to the spec if needed, but I'm guessing the topologies
> >> may be the same for a VM).  If the interrupt infrastructure supports
> >> probe deferral, then that's probably the way to go.
> >
> > I don't see any examples of probe deferral in the codebase.

I think the flow with VIOT is roughly:

 // Scan an endpoint
 pci_bus_add_device()
  device_attach()
   driver_probe_device()
    really_probe()
     dev->bus->dma_configure()
      pci_dma_configure()
       acpi_dma_configure()
        acpi_iommu_configure_id()
         viot_iommu_configure()
	  viot_dev_iommu_init()
	   acpi_iommu_fwspec_init()
	    iommu_fwspec_init()
	     driver_deferred_probe_check_state()
	     iommu ready ? 0 : -EPROBE_DEFER

So if the IOMMU isn't available at this point, base/dd.c adds the device
to the deferred probe list, to be retried later. Later:

 // Scan the IOMMU
 ...
  virtio_dev_probe()
   viommu_probe()
    iommu_device_register()
     add to iommu_device_list
     iommu->ready = true

I believe after this probe completes, base/dd.c checks if dependent
devices can now be probed:

 driver_bound()
  driver_deferred_probe_trigger()

That should all be working and you don't need to add anything. The
question is whether the interrupt core supports starting the setup of
interrupt remapping in viommu_probe(), or if it needs to know of the
IOMMU's config and features earlier during boot. Even if the viommu driver
is builtin, those info may not be available early enough since they
require PCI and virtio probe.

> > Would it instead be possible to require virtio-iommu (and thus virtio)
> > to be built-in rather than modules?
> 
> It's certainly possible to have an optional feature in the kernel that
> depends on a module being built in where it otherwise wouldn't have to be.

Agree, no problem requiring this as a first step, but the IOMMU probe
might still not be early enough. 

Thanks,
Jean

