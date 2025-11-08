Return-Path: <linux-kernel+bounces-891239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6418C42398
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3D2E4E7B94
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD729E11A;
	Sat,  8 Nov 2025 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jFT+GXF0"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4C23EA9E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762564307; cv=none; b=gC2+jqlSe6x0+ng6kMnjJzxX/MLzWFCqJQc7pUovqbpNA92HLIBBh+q4Mk24Pc1AAyn/Fx8Az7on+jOwjBt8ZsZ7iNBHp83MP/mc2/BbAbLJ01bgSnsMFhG7pe8bm/HGWG3SZDHrwiyy4tEuvPdety0/nYJmzyI08kjnxoLVp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762564307; c=relaxed/simple;
	bh=fzToj5dDPDmAgKJ79e6bVD2SIFNhDcqaLH7py0Vyc8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVg1gxiyfea5OHY/dTx8d6RmPZoT77q7MEE0iugfnWs5KjN/PR/hZxOdoMvO/QFih6mGLqYnLAax+UfRTZ4XPlgq2GUIlCge29gYxNQJWzrsIsAmVfA9/bzGjhj/xz+TiCRULtOpUWcn8o7tyOTYrzWqJZIEM7y1HWPVnDfvCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jFT+GXF0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89ed2ee35bbso175679385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762564304; x=1763169104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf4zf8TV/EOP/YsPQoWXgFR8ZzXqCqkCmbhECODLpcg=;
        b=jFT+GXF0CpdtJrydLYTd4j+TkbbofbBb0L3gHvvgKP1z3bWdaUNh7b3WZovYGfAQGA
         bO9daBysl285+ZAKw4xkCWzdHMdUGTmTaV/NFpcc/0RAC3u4wM6b269/E+reffQaBpvj
         D94vFN7ukwinB40M8/XNqX7tmcjMA6/X/CU6MEi8A6qLZxUsVRmf71r5gYvNIgjIoYpm
         Z5JYm1q0aEIvWRNNLySAVb7h13oHYL7we3+Fr6oe3KUFYqRTixlla6Rp4qDkoKuAu9nI
         Fpj1VCwIIMm778IBgKW3n3nBRzTfmADe9KOxafKX4k7FJia5UiTBqryCVD2KDtDpw4/o
         ifJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762564304; x=1763169104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf4zf8TV/EOP/YsPQoWXgFR8ZzXqCqkCmbhECODLpcg=;
        b=Zzvt2vECrmpWtyg4SA2ryPNLZR1kzReEEQk0W/nYdr6GU5YhOi1n5opYC/+SG3OM/O
         YnYPILk9GXmQWHrI2bQAyHHEh06xxj1TwAZHl14xubcGIB25vwiWkRjFCNkq/6jbMk6m
         bD19EUBRELWce0b9AJ9dkSC1aNcgdS0YOmiNoyunJibJuc1mL6B9X9W/y81amrDhBCy+
         5eKtnUbJqGB2j6d1f4BBi7UmVxXxoPqc7uvAq4vLrZWC3XSyAXglfCIhlzcSYXR/XNvh
         LpTfRrtJMm3jT4/gJzfJ09YX/0fh79lB/liPPvAiMpB7ej0cgBg59qExmA4qwTPWKn7O
         KWUw==
X-Forwarded-Encrypted: i=1; AJvYcCXrhwliPIq5/De6ahpB+NzSD4wzIrp2i9wJX9n20N1vrAp6XVWcKd9kx/vmSQm8MhwFPiSa1au8oqIs7wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzt53vlwlrtacXQF5jZgJv/lMiX4KIP7hVej8Cjetry4ZcUz2
	0rJ5WVMysKFlquonj0SjIUTtRamFoCaMBKvuF2SXptuQoLgE6PEODyQrii9zZt2+kYI=
X-Gm-Gg: ASbGncsDy5uqKT3mtb5/9krkzP1fAGPK/WxZJGkTaKk1GORg34ZeH3ol5P7HpMghivH
	shwVO58CaZYlEtnpNF6hkKYZ5GWwNIvpTZrfB+ictTgmstaAAj+7TNVqutyAuCydSa6RvGWbXSK
	7BufwPcsmDd33iny3kGSQfG+FX1gZ4PrlWH/jfeM4Yszl2/5Il1RXUFxhvBxqpvhzFh6PWBqf/a
	mlXT7300quqozzCvtNarPodYUHGhJkJG/urzMoOicemUNEnhmNMWAq2gvsHQe0/5CD+DjO+sDiC
	RYAq/w5hAp+O4rAbQpo+FWcuCb/ZiQo0l0mJFc6kgaDcgxGeEmVbqY12rAPD1jlsDPvbsf9s9WS
	G8VdBf/ATQ4EjVeFOKXU/gg2hW8YkLq5U9vJZuiOaF9MSGlL6fppdiQbgCwd5SNfjtLlNl1njWf
	eLkH7ALEfabbf+TrQLN/M1tEXz8PYO2fJG6IAIkr0eZVykHG59Kte+vfIt
X-Google-Smtp-Source: AGHT+IHgQm4crSoFbOP6aPyQmLcW59espnioyKWZw+sam6UcNVlWlMqDlHJNn7lZhEfcTWvrH5yFgA==
X-Received: by 2002:a05:620a:209b:b0:8b2:2719:ed33 with SMTP id af79cd13be357-8b257f3c71amr135197285a.46.1762564304210;
        Fri, 07 Nov 2025 17:11:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e615bsm530534085a.19.2025.11.07.17.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 17:11:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHXUV-00000008NdU-17Dq;
	Fri, 07 Nov 2025 21:11:43 -0400
Date: Fri, 7 Nov 2025 21:11:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Winiarski, Michal" <michal.winiarski@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Laguna, Lukasz" <lukasz.laguna@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Brett Creeley <brett.creeley@amd.com>
Subject: Re: [PATCH v4 28/28] vfio/xe: Add device specific vfio_pci driver
 variant for Intel graphics
Message-ID: <20251108011143.GE1859178@ziepe.ca>
References: <20251105151027.540712-1-michal.winiarski@intel.com>
 <20251105151027.540712-29-michal.winiarski@intel.com>
 <BN9PR11MB52766F70E2D8FD19C154CE958CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7dtl5qum4mfgjosj2mkfqu5u5tu7p2roi2et3env4lhrccmiqi@asemffaeeflr>
 <BN9PR11MB52768763573DF22AB978C8228CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251108004754.GD1859178@ziepe.ca>
 <BN9PR11MB52768BF0A4E6FA1B234E33108CC0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768BF0A4E6FA1B234E33108CC0A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Sat, Nov 08, 2025 at 01:05:55AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Saturday, November 8, 2025 8:48 AM
> > 
> > On Fri, Nov 07, 2025 at 03:10:33AM +0000, Tian, Kevin wrote:
> > > > To me, it looks like something generic, that will have impact on any
> > > > device specific driver variant.
> > > > What am I missing?
> > > >
> > > > I wonder if drivers that don't implement the deferred reset trick were
> > > > ever executed with lockdep enabled.
> > > >
> > >
> > > @Jason, @Yishai, @Shameer, @Giovanni, @Brett:
> > >
> > > Sounds it's a right thing to pull back the deferred reset trick into
> > > every driver. anything overlooked?
> > 
> > It does seem like we should probably do something in the core code to
> > help this and remove the duplication.
> 
> from backport p.o.v. it might be easier to first fix each driver 
> independently then remove the duplication in upstream? 

If it hasn't bothered anyone yet I wouldn't stress about backporting..

Maybe those drivers do work for some unknown reason?

Plus it is *really* hard to actually hit this deadlock..

Jason

