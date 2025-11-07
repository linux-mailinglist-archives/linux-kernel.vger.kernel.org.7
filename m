Return-Path: <linux-kernel+bounces-890045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D447EC3F23C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E9B188E325
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC602D876B;
	Fri,  7 Nov 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gLti3+pi"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAD2BDC03
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507433; cv=none; b=mV6fHk7TnWCYOVzY1wdm7PCmB1Q1sLIOgJHDj94XAOm1CBlWtymH4Fl3jbgPy1fypZsdgpUZSVsFqyf4M7NPLSzbzYGKBw1suRSSoTarRb3DvbPOs5SgmNeQjprgWYbUxvqK0IBKJLH38LQvnp7TQfQND6eDtJTFpYeMooElXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507433; c=relaxed/simple;
	bh=k/i/Wu1HPmOKq4PDi4yywjLAHiF74coVwwDp1hXMDpM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEkExP/WdItQ4UkfzH8ZfqXkGppU+6Y1jNMADUEHMPHXgOPZcXC0SGM1p4AfytJ2uJgtTaJrX8RKfG17lV+FbQoLfX4c07MHQqHVo8jad6uJk+KJWfkic2voPFT3m+ERY3ycY8edAtlbv6NrMdN/pIpkGqzg0lgIULxQlegbl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gLti3+pi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7042e50899so82899166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762507430; x=1763112230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LacQSXGw7TbWuQyoWzY6N7WYy+KmingdHmAdQBcwPC0=;
        b=gLti3+pi0Gzk5jPU3yZGJFeB0bUJ4ksmSBql++f61gZ2lU2FrVF8FT0LLYABuh1Npt
         7h1f9OziA/xSax68dbqzX9ju9UCl2+inomCaRka+OvM2lJ50z4yrF1RT4Vphj3j0cdxc
         GqSoXSYyPNXbg1ctfwzdbIsPRwvmeICnKF9LPPzOVITE2g16oM+FsmXJI1H3xWExDqA4
         zQH1d5IeCDa/sC05e8+84TwJ8gShxzU9fL2QmLp2/ZxLekHxEi8ErfTdzyUejW/i5qUO
         YXW1v0a7COmWNRZemZzcn41P7xtEXcEs1znEEtf6cVDpYXtVgPcnyvRR5D3QiYW+oibi
         iyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507430; x=1763112230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LacQSXGw7TbWuQyoWzY6N7WYy+KmingdHmAdQBcwPC0=;
        b=j0opVFC6zaZ0CpBHDI4IHDIPUBDYZD039gR1LJoxv/tbDOlIEwp/bLAZtf4Bt+BrOK
         cELr8Bj28/ribJng5gTxnSjOd8/9gvUyWzzCzWAY8KehgvU2e0PFKNID93tdY5WSI46+
         1I96/ID1FmiErjMoA0/HbAHhHeHrkGxFRHZ1BFLZQQ0a76sOJtgRx3YDEzvDYSkjjz7K
         u8jyaHRC+aErfcnkzeq/fVb6hm+Ti5URHNmgRmBAFVHEmIWQEiJgQLLuPI+HishdK7Vs
         F8GKv0tckkywsw3rvNuUL2/tvxtDgzgHKXaP5N++m2LTYyYsY2dhJ/6jOurUgK0mt0En
         WBYA==
X-Forwarded-Encrypted: i=1; AJvYcCVq+YcfK73vcPkE5QxFBMY9Ah6TE13iRGhKNdO3T0QeHIDjPkNYoTd8lTPZuGjDRLTLz9qRWnAx6WLOwVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQLWgzLs8OSzsHHijwtIg9kMnmEj+sILWgnnmTS7sWK1aFRuQ
	uh2eF1tY5qL2afaTVNHQVLwrZ11fF5YACSvOg5rd07GHXjeLyA+ge2bjQP19trU3+2k=
X-Gm-Gg: ASbGncsr1FeeukMAhOsvoPXrOivUIzTpRVhRKuY+jCDr6O4gy5RDmAOzAHevV+t8gas
	S3mcujJx0ObKWFiGwoHvKStdEsktwK5eDuBc5vfc+MQu7u9aT8krW7RfmQviz0siqn2SyG1hSBe
	1cwQqHi70CvzEBdRJ5UdVbHJYWk9v/wJ2zSOc0AUPeeqIDbAymLwi6OrIsbleN2j2UNImDyvhAB
	MRGPYeHJTpV7U3TotQLD5P5z6bRSRVeQJAuMIZAsu2icVlGRuVVhk9ns9zCkhGS2qB+P2femrh2
	N1NQm/jJdknJY1NghwS4ulfGLMG+O6Ow3I/WHXp4SJ4Mr8AAdIKxNhZuIYjb7vJxsCXjZilHiDs
	ontVjH4bv6joue7A97Pt06Djvaz6EHXRnB6kQsibQZbltULdztLIwpkuzFQpZy5bnR7fyhSp/i4
	hy3lhl2IRIauyWrbpN8RQUz+rudGVO0szibAeXqEA1RPHCF9LyjdtqEHW8
X-Google-Smtp-Source: AGHT+IFi+fpxy9purLfTBg++sUcxlN2Azn7yKLv30XH2N7uE0nRjNLH/v6fkpMZZkJGpfSiMDkd+Ig==
X-Received: by 2002:a17:906:c103:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b72c08e0249mr225878566b.4.1762507429649;
        Fri, 07 Nov 2025 01:23:49 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbd8csm196766666b.24.2025.11.07.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:23:49 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 7 Nov 2025 10:26:07 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aQ27L_95tgaj1qT1@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
 <20251106002345.GA1934302@bhelgaas>
 <aQyApy8lcadd-1se@apocalypse>
 <20251106131854.0f0aa8b7@bootlin.com>
 <aQy9C8315Gu5F5No@apocalypse>
 <20251106182708.03cfb6c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106182708.03cfb6c6@bootlin.com>

Hi Herve,

On 18:27 Thu 06 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> + CC Rob
> 
> On Thu, 6 Nov 2025 16:21:47 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > Hi Herve,
> > 
> > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > Hi, Andrea, Bjorn,
> > > 
> > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > >   
> > > > [+cc Herve]
> > > > 
> > > > Hi Bjorn,
> > > > 
> > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:  
> > > > > [+cc Lizhi]
> > > > > 
> > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:    
> > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > > > > > is generated if no 'of_root' node is defined.
> > > > > > 
> > > > > > On DT-based systems, this cannot happen as a root DT node is
> > > > > > always present. On ACPI-based systems, this is not a true error
> > > > > > because a DT is not used.
> > > > > > 
> > > > > > Downgrade the pr_err() to pr_info() and reword the message text
> > > > > > to be less context specific.    
> > > > > 
> > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > pci_register_host_bridge() path.  Does that mean every boot of a
> > > > > kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> > > > > this message?    
> > > > 
> > > > This is the case, indeed. That's why downgrading to info seems sensible.
> > > >   
> > > > > 
> > > > > This message seems like something that will generate user questions.
> > > > > Or is this really an error, and we were supposed to have created
> > > > > of_root somewhere but it failed?  If so, I would expect a message
> > > > > where the of_root creation failed.    
> > > > 
> > > > Not really an error per se: on ACPI system we usually don't have DT, so
> > > > this message just warns you that there will be no pci nodes created on it.
> > > > Which, again, should be of no importance on ACPI.  
> > > 
> > > I my last understanding, all architecture (even x86) have the DT root node
> > > set. This node is empty on architectures that don't use DT to describe
> > > hardware at boot (ACPI for instance).  
> > 
> > This does not seem to be the case for all arch, see below.
> > 
> > > 
> > > This DT node is needed for PCI board that will be described by a DT overlay.
> > > LAN966x for instance.
> > > 
> > > On v6.18-rc1 kernel, I successfully used my LAN966x board on a ACPI system.
> > > This means that of_root DT node was present on my system.
> > >   
> > > > 
> > > > The only scenario in which this message is actually an error would be on
> > > > ACPI system that use DT as a complement to make runtime overlay work,  
> > > 
> > > It is an error also if you use a PCI board that needs PCI DT nodes
> > > (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.  
> > 
> > Yes, I was referring exactly to that.
> > 
> > >   
> > > > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
> > > > more a PoC that something really widespread and currntly the overlay
> > > > approach is in stand-by anyway (meaning no one will use it unless some
> > > > major changes will be made to make it work). But there may be other
> > > > situations in which this scenario could arise, I'm thinking about Bootlin's
> > > > LAN966x driver which also uses runtime overlay to describe thw hw.
> > > > On ACPI system the root DT node is not created because unflatten_device_tree()
> > > > is not called.  
> > > 
> > > I am not so sure.
> > > My LAN966x board is working on a x86 ACPI system.  
> > 
> > Indeed it depends on the architecture. On x86 an empty DT node is created,
> > provided you have CONFIG_OF_EARLY_FLATTREE defined (which I guess you have,
> > even if it's not in default config).
> 
> Indeed, I have CONFIG_OF_EARLY_FLATTREE = y.
> 
> > 
> > On arm64, ACPI and DT are mutually exclusive, unless the DT is basically empty
> > (i.e. only root node and chosen node). The DT root node is not automatically
> > created if not provided at boot, though. This reinforces my idea of providing
> > the only root node DT on arm as well, but I'm not entirely sure about 
> > possible side effects.
> > 
> 
> Isn't it possible to have the same kind of operations on ARM64 ACPI and on x86?
> 
> In order to have CONFIG_PCI_DYNAMIC_OF_NODES working on ACPI, we need a DT
> node, even empty.

That's a good point and it's what I'm proposing, indeed. Maybe it may worth just
standardizing that across all platforms, if it is possible. But let's get there
step by step, and arm64 could be a good starting point. If there is an empty DT
on x86 I think it would be logical to do the same on arm. But the if guard that calls
unflatten_device_tree() only if acpi is disabled makes me wonder if there is some
rationale behind it that I'm not aware of, that's why I'm asking if anyone knows
of any possible side effects. Maybe Rob could give guidance...

> 
> ARM64 ACPI without an empty DT node means that no PCI boards using a DT
> description will work on this system.

Indeed.

Regards,
Andrea

> 
> Best regards,
> Hervé

