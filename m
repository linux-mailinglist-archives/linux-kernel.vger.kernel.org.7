Return-Path: <linux-kernel+bounces-850170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C6BD2225
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC783C065B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C92FB612;
	Mon, 13 Oct 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZQp3ta/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDB2F90CC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345228; cv=none; b=pvfwJ17H/cRDg4SBFqJx/aM2V0lU9+Yq9NJmICdG+CWS0/ojeDQGNp4LeqmcRxsDynv4w9U6aIFyrtuLrVu2BIznWpT7M9mf54uerpt43uMdw0EuzBHQ85P0l2dRpBHr+MyaJHXeMzOq1uHErOBHbfEMtRLIPBf+N9KYUUJmhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345228; c=relaxed/simple;
	bh=6le6OQ8epL+jMQ5N4bnB/5a2+J6M0RilzV7rzr9sKXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4aaUDAAYOaJFAxqV1KzRR8++WyIKvbDTeDNWkZQVctGiVC1h92Ko2QgUAZccLcCLylqAjPMHSp+srAQqPRL0XqVtq1UVwwlT3qEYBXFt30lKO5rOFj/CGj7M8zcuwiUt5YDan8k3MAooV8PjeqpEkcC0yxy+n2L8jwLRK5uvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZQp3ta/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3119184b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345224; x=1760950024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=mZQp3ta/w+jpSTGgaPSYSj4A2YLyC5b7HH2THkgk9Vs2T6szxs33EBMXwT8eTCpjkk
         b9WRfQi6eQhdkJihDqHkz05ASZisiJlnplUkHqWk4yEQ7UqGCSofORFdPIbyV7YDFmGN
         nkBGlJEE5DJYb/H5JD3xuFBFzejqKZLvSt2SulQwShs4zIXqxqil68F0nLGCKV5l7mqr
         /N42SEB0bO+CTDSq3hLY1zqV/bUCLvZE8tbY2t58FO0NvMXCpFUoMd8bppeFjKStOVJ6
         i3VUfcbJcbylDIH5E4lxqLkc+Vhiza4MspoHBMfEgN9pJSBo0pFc91pl+QznWxaTZAGW
         jiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345224; x=1760950024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=r0LN/T/Pz2i2NFEyKTT1zkdAUl9mxZzgKzg1HamhrzxCgpy53dS9x6dWal22oAGXNR
         hVIBpDEEkiYwirjKeoXfaKuHwjOoyCXPlR5Eu8kraEfInDumqgPWHHDYvAXlVhruEhOP
         MmnzJ40tYjflX5rZunxH741YAb/uFrETpt28vEi8Y1Qsx8Lo7eem7bgAnU7xNgOrGGir
         CL7HCm02rUWX9F5xr89rMks6Ux4fylTVP6iipXVFvITId00PMbYyGRJaR62CMtRZzhgy
         VRzJ8jV9kkieUNWd295t68dI2ghuClUYxfutGk2HfUQqLAwJYj9WEf3y/IuwmkHqDlos
         SYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVO/IfbOirJDsmSdI0Olcux07C8YAAZOe6BCeGnOWWHrF6x7xm1nKnmPBcLtVn1UuoUDNIxtOW3cxNW7uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSMtk/dV6e6NuJEuApfl0F9rxkTh+BX+0Z/6aR82VTPglY9Tc
	ERWDmB4nEuAMU5Wd2LqV8ODQBx4Umzmc0izE5e5bjBnNpqv5j7luqMnS
X-Gm-Gg: ASbGncs2FEnNtnVNUZA+BYHPbKiPP3DGa7yYHfKk+ev7AXNS7sI8tXo3tfhp4oG9ODK
	Wl4vjatkZPYy/TJ/S/TSo9kvOcvM+TtU6qgxD6xQaqTzjdqKvoFYYgP9U5BbUxSKB4zkzrvOTUs
	dNNGRdZs0SLcCV61Hm0AQWzRKdXb51ibOAEvKd8rOyGZdTq3BqkwguSFpnmqVw3pov/xj/U5q2d
	KGJ7qwdmfZpwrdPGtbpAv7wurNGHHq+56qz74v5yN4J4W1aUGJENSs8OJgO1zGVFMUyxFLxR/po
	pRnUAHOHIj6fvr44j+gpWvPJJpfn9GaFcdEi6nWXo14QRWWmBRxRjbj9FguZRIj4gXQU2j8D5pO
	Y02Yv+nFTN317DciXPqnfPTlLE9AmD6UZRVbBB9Lf5OxpnsKQ9Y0=
X-Google-Smtp-Source: AGHT+IF7w1EIeSODUr5AIUsDNw48vbrBIgBhYBiRRyhl8w2rgyXTNwbHm6KkbxbA5Bn+oLw+XAdTJw==
X-Received: by 2002:a17:902:e550:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290272c0a06mr273302795ad.31.1760345224148;
        Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034de9febsm127921165ad.7.2025.10.13.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:47:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:46:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>

On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > Mainline fails to boot - 6.17.1 works fine.
> > > Same kernel on an older laptop without any nvme works just fine.
> > > 
> > > It seems to get stuck enumerating disks within the initramfs
> > > created by
> > > dracut.
> > > 
> > > ,,,
> > > 
> > > Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> > > partitioned:
> > > 
> > >     # lsblk -f
> > >     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE%
> > > MOUNTPOINTS    
> > >     sr0
> > >     nvme0n1
> > >     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
> > >     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
> > >     └─nvme0n1p3 crypto_LUKS 2                          
> > >       └─home    btrfs             home  1.3T    26% /opt
> > >                                                    
> > > /home             
> > > 
> > > 
> > > 
> > > Will try do bisect over the weekend.
> > 
> > That'd be great, because there's really not much to glean from this
> > bug
> > report.
> 
> Bisect landed here. (cc linux-pci@vger.kernel.org)
> Hopefully it is helpful, even though I don't see MSI in lspci output
> (which is provided below).
> 
> gene
> 
> 
> 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains
> 
>     As the RISC-V PLIC cannot apply affinity settings without invoking
>     irq_enable(), it will make the interrupt unavailble when used as an
>     underlying interrupt chip for the MSI controller.
> 
>     Implement the irq_startup() and irq_shutdown() callbacks for the
> PCI MSI
>     and MSI-X templates.
> 
>     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent
> startup
>     and shutdown functions are invoked. That allows the interrupt on
> the parent
>     chip to be enabled if the interrupt has not been enabled during
>     allocation. This is necessary for MSI controllers which use PLIC as
>     underlying parent interrupt chip.
> 
>     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
>     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> inochiama@gmail.com
> 
>  drivers/pci/msi/irqdomain.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 54 insertions(+)
> 
> 
> ----------------------------------------- lspci output ----------------
> In case helpful here's lspci output:
> 
> 0000:00:00.0 Host bridge: Intel Corporation Raptor Lake-P/U 4p+8e cores
> Host Bridge/DRAM Controller
> 0000:00:02.0 VGA compatible controller: Intel Corporation Raptor Lake-P
> [Iris Xe Graphics] (rev 04)
> 0000:00:04.0 Signal processing controller: Intel Corporation Raptor
> Lake Dynamic Platform and Thermal Framework Processor Participant
> 0000:00:05.0 Multimedia controller: Intel Corporation Raptor Lake IPU
> 0000:00:06.0 System peripheral: Intel Corporation RST VMD Managed
> Controller
> 0000:00:07.0 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #0
> 0000:00:07.2 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #2
> 0000:00:08.0 System peripheral: Intel Corporation GNA Scoring
> Accelerator module
> 0000:00:0a.0 Signal processing controller: Intel Corporation Raptor
> Lake Crashlog and Telemetry (rev 01)
> 0000:00:0d.0 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 USB Controller
> 0000:00:0d.2 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #0
> 0000:00:0d.3 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #1
> 0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management
> Device NVMe RAID Controller Intel Corporation
> 0000:00:12.0 Serial controller: Intel Corporation Alder Lake-P
> Integrated Sensor Hub (rev 01)
> 0000:00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2
> xHCI Host Controller (rev 01)
> 0000:00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM
> (rev 01)
> 0000:00:14.3 Network controller: Intel Corporation Raptor Lake PCH CNVi
> WiFi (rev 01)
> 0000:00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #0 (rev 01)
> 0000:00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #1 (rev 01)
> 0000:00:16.0 Communication controller: Intel Corporation Alder Lake PCH
> HECI Controller (rev 01)
> 0000:00:1e.0 Communication controller: Intel Corporation Alder Lake PCH
> UART #0 (rev 01)
> 0000:00:1e.3 Serial bus controller: Intel Corporation Alder Lake SPI
> Controller (rev 01)
> 0000:00:1f.0 ISA bridge: Intel Corporation Raptor Lake LPC/eSPI
> Controller (rev 01)
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Raptor
> Lake-P/U/H cAVS (rev 01)
> 0000:00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host
> Controller (rev 01)
> 0000:00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH
> SPI Controller (rev 01)
> 0000:01:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:04.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 10000:e0:06.0 PCI bridge: Intel Corporation Raptor Lake PCIe 4.0
> Graphics Port
> 10000:e1:00.0 Non-Volatile memory controller: SK hynix Platinum
> P41/PC801 NVMe Solid State Drive
> 
> 
> -- 
> Gene

I think this is caused by VMD device, which I have a temporary solution
here [1]. Since I have no idea about how VMD works, I hope if anyone
can help to convert this as an formal fix.

[1] https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t/

Regards,
Inochi

