Return-Path: <linux-kernel+bounces-888302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632EC3A6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7635C342800
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25C308F32;
	Thu,  6 Nov 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WxjmaBSa"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838E3090F7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426914; cv=none; b=RxsnQoOXHsBXcF1BHYxYlIjRa+NrHZ1evkx3EnaueHMbqdNAF5ssMcSkWvX5FfuYrwGlbesPB1tavt9CZjuugf7AnEkgO224wcQBWGwz/vmK318lqBxz+LvCANFohLXhu9QM+ssPtU24sJY3RY/1jOodDSNptdaGPJn5xnwYNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426914; c=relaxed/simple;
	bh=GbxjtuR3nbV5uSBcJDoBUPQ5UbSMcQxiLL+HqRkQbpM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjhUtcRamhI6APYteMdSAQIwT9YJuukQSZktAE59P3SfPbH+ew8NZtiQV+DBuA9P2YWD7J5mWKZQoR45bpnJlKg5aAmiYC+0FocVtPIHNgX+Edesbo+Y/d4eeCxXTi8JvrXU16A1YDKNJFHPAjp9qgX8s/ybX41tEZeMHLoJohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WxjmaBSa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso112778066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762426910; x=1763031710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tuc3d7QnSdL0UpfWr8xV1dwP8gyHIFirvdKYeuITd3w=;
        b=WxjmaBSaSHUpEZETgxFMYlFUu0rYhHd2KejWka0Omem1dNcWwJV+beLF2DTvxcRt28
         S+YQeh9G7Wvo3MEEJCVatvp499goA/arepCku7h8TSSMUSIo64hCALzXEeUK9R8QHMDc
         Ex0rwzmQnt35gDDrg2ACfjB3HgeLtlSl7Xt/HF9RKS5+P6QqXLeneWf4wWdZymOYl5G0
         MBUBHWz29mZc47JlqMW1TqZHGBk5fuDV2IYnpS6IEvUsh6bziIM6UIKYAycUuyF8Vnh2
         AKrfA6gHEoZ7fDLGmRp7yYD7xHM+0aP1R38xBLPojr73PBfrAdmezEe4lKKt8DUBJgbD
         psqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426910; x=1763031710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tuc3d7QnSdL0UpfWr8xV1dwP8gyHIFirvdKYeuITd3w=;
        b=pgQc5Qm7nkGDLQ1r/O7wGLh8G+JDgf06uMQVUov27UPcJKPFxQpLSutzv2CRlXlA+y
         2WCi6aWRaAhrVzBi1oPo+lagNuu/2pNwZdDqFz8rIMLYkMwlUbFYvD+g89TT3DeqhHr3
         p+2wPh/NFb8Dr9lz0a1lPFfWogBSakRBjWsQhEUHUPQ0s6X1swTLhfukyjKqSfBpxUbc
         +K9DmZ4BS6TI6lq13+RWZLjr/Ke4Xe1Yy2O7mX8pl1sNI0nbiCE3LvpZiySeGG0OD2St
         6pGl22YloJ1l3UMD3qJkPZpTMTIY3qk7JOoqSimmkMsOfcVOdc+OD+x5jrmZ8g/Ml/VZ
         GR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNYLPHomjrjLvqhBT6p5tNxXUiFp8F6O/Gf7cPqAZfezrSVWxpGaxF7EqAzEGF/Y4WeYpVx8gT4kF2xIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYqiLRciqnUQ9SjN2EGHIfbDhzujR/+Hrh/d2HNm3rxJvSXZl
	pWYJUG3pMdHgyTOj6NaYHbEhsie8wcB2hTOsjdfoyHFVXpEaUZP/KJkHZRZL9qRalWo=
X-Gm-Gg: ASbGnctcojpAyZogg91sEGhY2ezrF/Bt3iZZpJVmfybAFMIg5wEt4Cg5vT30KI4pacR
	GprDUFCgCuWlU+cN6qpIIJ5vEvb6ikQ/7tWZUvkbQUJcPBaoZ85fKpx2E5YyJ+EyWCmp63hcL0/
	YK8I8jRpWp9tVcBP/qH/XIgEIxmK7aa4R2bWVUJIc+TuNjs8c14NT46dIFOqxrcTJ+rZq+iUn/S
	loH9n8toy1OIXY18gVcN8LRZqJWNNwXJ70wTtoaFdT7IN1639rHqov4WesD7rX1FH7ZWQRkhwx3
	aoG8vrLggf8Lev6HwZ1JSuqNQp9lztD3aqdVEaFlukqao2KbTVgpexFUd8ku12zPRyJSJJiyT5/
	y4bGx2SX3TR9yNhk7fniaD6yF/BLJBYtsweJo6Fx47yXKhNr73ui8E/4jrJUQvApWkaBtW1f0e7
	QwtuYSSPJgdZig64gNRQBHa4Kjg7vJt1rtjQpkByk+
X-Google-Smtp-Source: AGHT+IFCQJv6UYwjxjMv3JAt25/eCd7XQsg6/s3HCkyOXBqI/r6GScWjfdTpeMGjB8fTUJElhSDVKA==
X-Received: by 2002:a17:907:2da3:b0:b6d:95b3:5881 with SMTP id a640c23a62f3a-b72654ddb19mr745015066b.33.1762426910372;
        Thu, 06 Nov 2025 03:01:50 -0800 (PST)
Received: from localhost (host-79-51-28-73.retail.telecomitalia.it. [79.51.28.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862697sm1560546a12.25.2025.11.06.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:01:49 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 6 Nov 2025 12:04:07 +0100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>, herve.codina@bootlin.com
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aQyApy8lcadd-1se@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
 <20251106002345.GA1934302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106002345.GA1934302@bhelgaas>

[+cc Herve]

Hi Bjorn,

On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:
> [+cc Lizhi]
> 
> On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:
> > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > is generated if no 'of_root' node is defined.
> > 
> > On DT-based systems, this cannot happen as a root DT node is
> > always present. On ACPI-based systems, this is not a true error
> > because a DT is not used.
> > 
> > Downgrade the pr_err() to pr_info() and reword the message text
> > to be less context specific.
> 
> of_pci_make_host_bridge_node() is called in the very generic
> pci_register_host_bridge() path.  Does that mean every boot of a
> kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> this message?

This is the case, indeed. That's why downgrading to info seems sensible.

> 
> This message seems like something that will generate user questions.
> Or is this really an error, and we were supposed to have created
> of_root somewhere but it failed?  If so, I would expect a message
> where the of_root creation failed.

Not really an error per se: on ACPI system we usually don't have DT, so
this message just warns you that there will be no pci nodes created on it.
Which, again, should be of no importance on ACPI.

The only scenario in which this message is actually an error would be on
ACPI system that use DT as a complement to make runtime overlay work,
i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
more a PoC that something really widespread and currntly the overlay
approach is in stand-by anyway (meaning no one will use it unless some
major changes will be made to make it work). But there may be other
situations in which this scenario could arise, I'm thinking about Bootlin's
LAN966x driver which also uses runtime overlay to describe thw hw.
On ACPI system the root DT node is not created because unflatten_device_tree()
is not called.
One possible (easy) solution would be calling unflatten_device_tree() also
in case IS_ENABLED(PCI_DYNAMIC_OF_NODES), but this of course requires some
investigation against side effects.
In this case the roto DT node is always created (on both ACPI and non ACPI
systems) and the info message will not be printed.

> 
> I guess I'm confused about what the point of this message is.  If it's
> just a hint that loading an overlay in the future will fail, I assume
> we would emit a message at that time, connected with the user action
> of trying to load the overlay.

For a functional standpoint, it basically is, if we neglect the fact that
you won't have PCI nodes described in the DT, of course, which I guess it's
just informationali (but I may be mistaken on this point). Loading an overlay
in the future will fail anyway so no need to take further action there. Plus,
the systems on which this could happen (ACPI system + runtime overlay) would
be probably rare, if ever exist.

> 
> What badness would ensue if we downgraded this message even further
> and removed it completely?

As stated above, I would expect no major issue but other opinions
would be very welcome. 

Many thanks,
Andrea

> 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> > CHANGES in V2:
> > 
> > * message text reworded to be less context specific (Bjorn)
> > ---
> >  drivers/pci/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 3579265f1198..872c36b195e3 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> >  
> >  	/* Check if there is a DT root node to attach the created node */
> >  	if (!of_root) {
> > -		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> > +		pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
> >  		return;
> >  	}
> >  
> > -- 
> > 2.35.3
> > 

