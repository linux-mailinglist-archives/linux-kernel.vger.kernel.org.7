Return-Path: <linux-kernel+bounces-888825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A097BC3BFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84AB34E142B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC611265CA7;
	Thu,  6 Nov 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SLMgFlxp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF125CC74
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442373; cv=none; b=MklElCLngQZJDuYcNOrHr4uwZXMICN/busLZ2UZ2r1h4gGH5bp6tCkxaIxg/nI7h7e5CpBrXGQNbdBzlBzt+yzlTGSKGir4TLUNG6uPWI/wFLz63oHb2cAPxYkir/8K0OSru6bulwKvUMDPdv3jMEC/QBtBtJ9/DWcLQ+qc9950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442373; c=relaxed/simple;
	bh=Aa5Xo4J+Buptf2JMM+dhoeIBF/jSlOgeBhYaCZqpbrc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9spiOR6fJssbEq1sKGSct5TrV3qD+Qxf0Ia2HzJjnQGrfFPwM/phzOi7ekLEbZwugQ4x+KrahRQwg3kyCE+ma6sb7XwZ7RAgSXiGR8Blixma2A0wULyKEEI4PNlqwsILtRTllGZYjzMzqHlEIICv/8+yG5QYi6g6ug/M5NuS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SLMgFlxp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso231479966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762442369; x=1763047169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytwnsk3wOeTiiKjdBrk4qjAr4W+PVb89uePn5gd4Fek=;
        b=SLMgFlxpLQ+w0M/ttnSDSQ6NSNdXHUvn9K92xkLZqkThIRFGFLnSZNkuEUiGOcEgV3
         MPzoXDBPOQ7DRdfDGa14fQNvzq5iHzd4dhlRL3f4muerTLmC+77ZHigQVwC1earwh8dx
         tB0Aq4571LY9RzRq7b0krb+CsuUJULfDOqZt6ZAKCcnBhN9gJFN0YJZmx2jc4LWr/PqR
         Iuw3LMuNW2iaJ6mxLH+k6DBNdLdjsu4ENGDYgyT6t46yJnHtp0uqgqvcbU3ZF/8l1p3p
         XIK7I/RL3hbu9GsQzEyb/L2zK+OMzJcnkl2nOhT+GitOmaKsY7MRrfw9F8gA7vbJRKXN
         FP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442369; x=1763047169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytwnsk3wOeTiiKjdBrk4qjAr4W+PVb89uePn5gd4Fek=;
        b=SgGpwApK0rvM+RxUQOvdl3wdNPyue/uit6lRAMkwh0kyP2wBmJ9uFKQiPITGkKNFpA
         7n3GOCO2qANNtm0dFPVp8u5vxn90YvKLMOH64QjD7Lzuoy0bpNwaaPkKthDx5Lcpuopo
         eSCGLc4r2wEB77ho2mwQTWKN5mCWRcWSBaehCS/vicm2FzkjRlTUq2tOigGBUNDD9F7B
         WN7GXFxUzj2G5FQGxWRo5PrHKWxid0aOBcm5kF09S7Zz6fdO1H4bJraOigDYlPR8drkI
         BzFX74u1Tb7JAWyYEDrUtt90eP1v0XxzaMhTftrbMBYdfPdw6tczQIC1WpZ2+/j5xqEl
         uGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUempshIjO/yPYfiKX8EFiknXhcjnt7cH+n9/qMQXiuVgtBztmCdaddXpDwt86ZL4Gk5S4c/qH2Bl7qKL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GEP6INzHqAZcofI0sODxao8LJH/NVJkFQJAlqP9/Kkh96rtk
	dgSB8ZGksHGUlvsfkm5nCVu30JDnIdyZ0997NzumQjscCujhqvmMCld1qPsA/GIs4c8=
X-Gm-Gg: ASbGnctc68HyJqi0Tg1L3jaM6UkK+wUuHfr7QOJ283ZpUsa8Al61ucbQ1HxKfFgSEP8
	jyDcx4Kdcbua1CZgPysL3ZE5JEdX7A14TAVUpqxuHRwyE8+KgmzW679gOgircFmBvoWOMz4edlq
	TV1kDIA2/zkMLpThbM569uPvAcDL1g3EqGDeXeACsAZe5RqfDionPak9yFn9QQKenYvspDXryS5
	3IellaCAAIsqVpXNj9wazaJxKOcUhkIdRO5RxkTM5juDL4hx2dTvJuwfwq7LRZXsc8oV+x//h8P
	nbbY5HUDZzpWxYjJ3WJpKKviYX8JCVM/mIbzKDo2Xq54pGhKvgAcmax5BoF1YMh8CaVme1ynOH+
	q8a7Tf8lC1JMFakk8xQqLdoP/GQG8fgNW4byqGrbnFJy9yEVpDYMMNQ4f91BewqEFi2zJm1bMII
	BZyqSJ6HxVN3G3YlE/DiAkzi73TdDNHnIMvatGahyJ
X-Google-Smtp-Source: AGHT+IElTJK3T2B/pBMglQ9yfN9Q8ZKlbWxdPFTL+jWx5DVf2QA2OiAOKD3pi2r+rnW2K380nQ7a4w==
X-Received: by 2002:a17:907:6d0c:b0:b71:51b:bd49 with SMTP id a640c23a62f3a-b726560fe1fmr711145666b.46.1762442369329;
        Thu, 06 Nov 2025 07:19:29 -0800 (PST)
Received: from localhost (host-79-51-28-73.retail.telecomitalia.it. [79.51.28.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc8dsm235216266b.17.2025.11.06.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:19:29 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 6 Nov 2025 16:21:47 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aQy9C8315Gu5F5No@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
 <20251106002345.GA1934302@bhelgaas>
 <aQyApy8lcadd-1se@apocalypse>
 <20251106131854.0f0aa8b7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106131854.0f0aa8b7@bootlin.com>

Hi Herve,

On 13:18 Thu 06 Nov     , Herve Codina wrote:
> Hi, Andrea, Bjorn,
> 
> On Thu, 6 Nov 2025 12:04:07 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > [+cc Herve]
> > 
> > Hi Bjorn,
> > 
> > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:
> > > [+cc Lizhi]
> > > 
> > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:  
> > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > > > is generated if no 'of_root' node is defined.
> > > > 
> > > > On DT-based systems, this cannot happen as a root DT node is
> > > > always present. On ACPI-based systems, this is not a true error
> > > > because a DT is not used.
> > > > 
> > > > Downgrade the pr_err() to pr_info() and reword the message text
> > > > to be less context specific.  
> > > 
> > > of_pci_make_host_bridge_node() is called in the very generic
> > > pci_register_host_bridge() path.  Does that mean every boot of a
> > > kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> > > this message?  
> > 
> > This is the case, indeed. That's why downgrading to info seems sensible.
> > 
> > > 
> > > This message seems like something that will generate user questions.
> > > Or is this really an error, and we were supposed to have created
> > > of_root somewhere but it failed?  If so, I would expect a message
> > > where the of_root creation failed.  
> > 
> > Not really an error per se: on ACPI system we usually don't have DT, so
> > this message just warns you that there will be no pci nodes created on it.
> > Which, again, should be of no importance on ACPI.
> 
> I my last understanding, all architecture (even x86) have the DT root node
> set. This node is empty on architectures that don't use DT to describe
> hardware at boot (ACPI for instance).

This does not seem to be the case for all arch, see below.

> 
> This DT node is needed for PCI board that will be described by a DT overlay.
> LAN966x for instance.
> 
> On v6.18-rc1 kernel, I successfully used my LAN966x board on a ACPI system.
> This means that of_root DT node was present on my system.
> 
> > 
> > The only scenario in which this message is actually an error would be on
> > ACPI system that use DT as a complement to make runtime overlay work,
> 
> It is an error also if you use a PCI board that needs PCI DT nodes
> (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.

Yes, I was referring exactly to that.

> 
> > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
> > more a PoC that something really widespread and currntly the overlay
> > approach is in stand-by anyway (meaning no one will use it unless some
> > major changes will be made to make it work). But there may be other
> > situations in which this scenario could arise, I'm thinking about Bootlin's
> > LAN966x driver which also uses runtime overlay to describe thw hw.
> > On ACPI system the root DT node is not created because unflatten_device_tree()
> > is not called.
> 
> I am not so sure.
> My LAN966x board is working on a x86 ACPI system.

Indeed it depends on the architecture. On x86 an empty DT node is created,
provided you have CONFIG_OF_EARLY_FLATTREE defined (which I guess you have,
even if it's not in default config).

On arm64, ACPI and DT are mutually exclusive, unless the DT is basically empty
(i.e. only root node and chosen node). The DT root node is not automatically
created if not provided at boot, though. This reinforces my idea of providing
the only root node DT on arm as well, but I'm not entirely sure about 
possible side effects.

Many thanks,
Andrea

> 
> I think, that if you don't want the kernel log, just set 
>   CONFIG_PCI_DYNAMIC_OF_NODES = n
> 
> With CONFIG_PCI_DYNAMIC_OF_NODES = y, we need to create some nodes
> and if cannot succeed to attach them to a DT tree, it is an error.
> IMHO, pr_err() in that case is legit.
> 
> 
> Best regards,
> Hervé

