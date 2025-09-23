Return-Path: <linux-kernel+bounces-829121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6DB9654F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8221893169
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11178231C91;
	Tue, 23 Sep 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U7bTVO4k"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544577E105
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638256; cv=none; b=QtKWi5jf073W5BuewXU5ELrubei0cF6SUbyFA2o6P4krqYZpGq2cmtK2ZrAXedZ0yoVIPOkgSD1G8HwDna0XouODqIMl2oYApLhgK8WDsd/M0wPLEqbrLLjgRSu1rJ1Dikfdp3N7pE+JP2AIjQE5n3AxvFHpvHbJbML4wDzpMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638256; c=relaxed/simple;
	bh=ii1yBZfzr5XAbkH9gYhRzHJnpG6GM5PNn2gR+ygqg1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC7wvEh8CxiccHk7aJZ8d8Bm9Sas14az/cffnnxyvvqaQYLrchlopaFS5nbuheS06XWxubL7uNa+I2PDvpsqK7V6YckOc8sth52RsjuAdwdB214ERs4t7axk0viHNvsWkKP/8nHYtEdNlzngJwAmcF6e0s12N9lQrWhOp/mVA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U7bTVO4k; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-633bca5451cso1949350d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758638253; x=1759243053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utNQQqbrP26idrrirG5tFnz3mQu8N8BuujOARL7p3YA=;
        b=U7bTVO4kz+A/IsC72vaAnX3zybMrDxrmvOnc8zUTIm0G4rY520mHJWc1smf9P75C3E
         7V00C07MHDu1KslMYSOAbiM2MqtNF1/QQt33fRb121q9sPX2ZowSMtAzka4WE8iyDjOh
         L0wADyluWfN3wW3RI16Qtu2kIOF7XyLOvKuYLeYbbwNapKwM0hMD/kgP/NmY97+9mKgm
         phFBSy2jwh7TvCML8H46vMCF+AW57aBAwiCVPVnchkAhHQI7abTSqmF/m7KDnriDNmJ+
         aA16ZICvT79/IeByhjXal0Xih8TSfHvA+HQNomB0O/S876Te+JqNap4qirLNMznsjMY+
         jz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638253; x=1759243053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utNQQqbrP26idrrirG5tFnz3mQu8N8BuujOARL7p3YA=;
        b=jlPwDCyd+1VIAuxkRaNRFvVIBVPXMYVsrTGN+LUuWYEqetfQNEVXaLuz9LpvE1Haw8
         /2CMp93C2X4NSMQY9hgmUuzEhc+fJyv4JnLT2xkOlmEVDRFtk12xeGnr0opMD5zkPddK
         aQYbJNJiHR9K4BQajEmLRR/1Ng/om7lbTLV/YdOafFjLstOXEutygFYZtBoU1JK8/pV8
         MmDDalrKBhOBpgEreiQ7Gq1OJDKMgOB5suSoc13CKE3G/rFV+zT3Ei5kNGrBtD9Sy3wg
         RR7uykVhQY+08mR5zbFwDQf74Y2/p8Sj9PN9VbNNFtOR8Z1wD4npIhx2iD4j09BUssAL
         xRig==
X-Forwarded-Encrypted: i=1; AJvYcCWcubncLyHDh9uN930HUTap0DWaxyrUr7hJQE/VF82DvSBajUuGXi7+GNuvkqU2cpW84ueeCeYu/U3kJsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIITJH/+nzxRYPYmwDo8U6hS01Gu0U8jl2ZTxu2jhYTx9Kok5
	7dBsrTiXEgkR6ZbnbvUXD41qc1tt1VEHbzrSl181T62F1zPHLCAjlOcpP5NQqhv8cdw=
X-Gm-Gg: ASbGncsaEpHk655O3VsTqIBgxrVmwEe0PL/Z96RJSYSNIPmCFKMDRAPecjOJyDT7AT4
	rsMSTrkDpqdgNbmeWNnwGCj77gtyoHn0lW5SbpyhbVzDXM6fL0/4TYelUxLyajQ26HCFRfVmVgv
	euRMnOpw17hY4/6b+qtnzazyPvrlhjWz37j9fPdXQQK4APaWG/3EQrKpqPCJ3mx2C5lAnMXe1Kc
	zYTuERMoeLrNwyrKvyIhVQYZWqA6IrSog+z/QSFgCeNZ4QDtU9xWV99sd/BV1rUTM1S3KfrUyVY
	UyWjXDaqQ4Zd4XJnQejFA6GLEploqZOKs/DUJd+5k4ocQC3JAuZQuhG+4MEbkijNo6AEC83mqHl
	SkOyhwzLSEzagj/Bm5HX17PYg
X-Google-Smtp-Source: AGHT+IHeqNbXj2cbwtsFZh/rWKxPR18F6VpXKZlRUUIrCTojwS6cSA2iuN5fMmUzLR1S4qkiXUoGiQ==
X-Received: by 2002:a05:690e:2512:20b0:605:f6ea:1261 with SMTP id 956f58d0204a3-636046fe14cmr2120960d50.23.1758638252833;
        Tue, 23 Sep 2025 07:37:32 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7438ac593ebsm28158097b3.55.2025.09.23.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:32 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:37:31 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-de370be816db3ec12b3ae5d4@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecrx4guz.ffs@tglx>

On Tue, Sep 23, 2025 at 12:12:52PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 22 2025 at 20:56, Jason Gunthorpe wrote:
> > On Mon, Sep 22, 2025 at 04:20:43PM -0500, Andrew Jones wrote:
> >> > It has to do with each PCI BDF having a unique set of
> >> > validation/mapping tables for MSIs that are granular to the interrupt
> >> > number.
> >> 
> >> Interrupt numbers (MSI data) aren't used by the RISC-V IOMMU in any way.
> >
> > Interrupt number is a Linux concept, HW decodes the addr/data pair and
> > delivers it to some Linux interrupt. Linux doesn't care how the HW
> > treats the addr/data pair, it can ignore data if it wants.
> 
> Let me explain this a bit deeper.
> 
> As you said, the interrupt number is a pure kernel software construct,
> which is mapped to a hardware interrupt source.
> 
> The interrupt domain, which is associated to a hardware interrupt
> source, creates the mapping and supplies the resulting configuration to
> the hardware, so that the hardware is able to raise an interrupt in the
> CPU.
> 
> In case of MSI, this configuration is the MSI message (address,
> data). That's composed by the domain according to the requirements of
> the underlying CPU hardware resource. This underlying hardware resource
> can be the CPUs interrupt controller itself or some intermediary
> hardware entity.
> 
> The kernel reflects this in the interrupt domain hierarchy. The simplest
> case for MSI is:
> 
>      [ CPU domain ] --- [ MSI domain ] -- device
> 
> The flow is as follows:
> 
>    device driver allocates an MSI interrupt in the MSI domain
> 
>    MSI domain allocates an interrupt in the CPU domain
> 
>    CPU domain allocates an interrupt vector and composes the
>    address/data pair. If @data is written to @address, the interrupt is
>    raised in the CPU
> 
>    MSI domain converts the address/data pair into device format and
>    writes it into the device.
> 
>    When the device fires an interrupt it writes @data to @address, which
>    raises the interrupt in the CPU at the allocated CPU vector.  That
>    vector is then translated to the Linux interrupt number in the
>    interrupt handling entry code by looking it up in the CPU domain.
> 
> With a remapping domain intermediary this looks like this:
> 
>      [ CPU domain ] --- [ Remap domain] --- [ MSI domain ] -- device
>  
>    device driver allocates an MSI interrupt in the MSI domain
> 
>    MSI domain allocates an interrupt in the Remap domain
> 
>    Remap domain allocates a resource in the remap space, e.g. an entry
>    in the remap translation table and then allocates an interrupt in the
>    CPU domain.
> 
>    CPU domain allocates an interrupt vector and composes the
>    address/data pair. If @data is written to @address, the interrupt is
>    raised in the CPU
> 
>    Remap domain converts the CPU address/data pair to remap table format
>    and writes it to the alloacted entry in that table. It then composes
>    a new address/data pair, which points at the remap table entry.
> 
>    MSI domain converts the remap address/data pair into device format
>    and writes it into the device.
> 
>    So when the device fires an interrupt it writes @data to @address,
>    which triggers the remap unit. The remap unit validates that the
>    address/data pair is valid for the device and if so it writes the CPU
>    address/data pair, which raises the interrupt in the CPU at the
>    allocated vector. That vector is then translated to the Linux
>    interrupt number in the interrupt handling entry code by looking it
>    up in the CPU domain.
> 
> So from a kernel POV, the address/data pairs are just opaque
> configuration values, which are written into the remap table and the
> device. Whether the content of @data is relevant or not, is a hardware
> implementation detail. That implementation detail is only relevant for
> the interrupt domain code, which handle a specific part of the
> hierarchy.
> 
> The MSI domain does not need to know anything about the content and the
> meaning of @address and @data. It just cares about converting that into
> the device specific storage format.
> 
> The Remap domain does not need to know anything about the content and
> the meaning of the CPU domain provided @address and @data. It just cares
> about converting that into the remap table specific format.
> 
> The hardware entities do not know about the Linux interrupt number at
> all. That relationship is purely software managed as a mapping from the
> allocated CPU vector to the Linux interrupt number.
> 
> Hope that helps.
>

Thanks, Thomas! I always appreciate these types of detailed design
descriptions which certainly help pull all the pieces together.

So, I think I got this right, as Patch4 adds the Remap domain, creating
this hierarchy

name:   IR-PCI-MSIX-0000:00:01.0-12
 size:   0
 mapped: 3
 flags:  0x00000213
            IRQ_DOMAIN_FLAG_HIERARCHY
            IRQ_DOMAIN_NAME_ALLOCATED
            IRQ_DOMAIN_FLAG_MSI
            IRQ_DOMAIN_FLAG_MSI_DEVICE
 parent: IOMMU-IR-0000:00:01.0-17
    name:   IOMMU-IR-0000:00:01.0-17
     size:   0
     mapped: 3
     flags:  0x00000123
                IRQ_DOMAIN_FLAG_HIERARCHY
                IRQ_DOMAIN_NAME_ALLOCATED
                IRQ_DOMAIN_FLAG_ISOLATED_MSI
                IRQ_DOMAIN_FLAG_MSI_PARENT
     parent: :soc:interrupt-controller@28000000-5
        name:   :soc:interrupt-controller@28000000-5
         size:   0
         mapped: 16
         flags:  0x00000103
                    IRQ_DOMAIN_FLAG_HIERARCHY
                    IRQ_DOMAIN_NAME_ALLOCATED
                    IRQ_DOMAIN_FLAG_MSI_PARENT


But, Patch4 only introduces the irqdomain, the functionality is added with
Patch8. Patch8 introduces riscv_iommu_ir_get_msipte_idx_from_target()
which "converts the CPU address/data pair to remap table format". For the
RISC-V IOMMU, the data part of the pair is not used and the address
undergoes a specified translation into an index of the MSI table. For the
non-virt use case we skip the "composes a new address/data pair, which
points at the remap table entry" step since we just forward the original
with an identity mapping. For the virt case we do write a new addr,data
pair (Patch15) since we need to map guest addresses to host addresses (but
data is still just forwarded since the RISC-V IOMMU doesn't support data
remapping). The lack of data remapping is unfortunate, since the part of
the design where "The remap unit validates that the address/data pair is
valid for the device and if so it writes the CPU address/data pair" is
only half true for riscv (since the remap unit always forwards data so we
can't change it in order to implement validation of it). If we can't set
IRQ_DOMAIN_FLAG_ISOLATED_MSI without data validation, then we'll need to
try to fast-track an IOMMU extension for it before we can use VFIO without
having to set allow_unsafe_interrupts.

Thanks,
drew

