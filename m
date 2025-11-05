Return-Path: <linux-kernel+bounces-887022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76EC37096
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BA71889D22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560824DD1F;
	Wed,  5 Nov 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fBUZmXyf"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF1246BC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362953; cv=none; b=b0CYS1L/HmAu4lb5wy55VBFoPDDGRDip2H6wX6CD+W89xClzBVnIyCdshMKIngGiOjK85KoxwLRCyehtnLco9Ib2SyDncDzY7b/JC/YYf7SqRk9hwG4fytGKBsjkw/dbAgIO6cl0dgx6Gsci0rN+M57kobQmr9HS1EKGD7gT8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362953; c=relaxed/simple;
	bh=eVKD3bsjyZ0uo5KJ9oROutwHux5K45xSldhubqIwOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsoyZqOKqKBa+7ezIRCOv6FkyaRWkjbHYEqLA9W4XoMSQR4SDoIrMYSlJV0Jnf2UzdgqsVBMPGwj4YYXS27ToYOnY0VAkgiUNUrpy/7peUd99vM7Pfw91OX7lQhvXeu9yDLFogJMRuLiqMmk5A4nZIeKmQK5w+7RJHQ/l2ffL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fBUZmXyf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-81efcad9c90so1468166d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762362950; x=1762967750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waenEKCMjn97yqJgR3j8p8YSw3a8sLLocbZT7haat5A=;
        b=fBUZmXyfecAmBE4EaSf7lOvc4JxFDSMxcSK6xyOcwofdwMQFA6DJ0rUmGqP+jAcFXZ
         ePGPzzSvttGBkBNk701xIQSiLotElDnYnuTSwb7SpKcOnbhTuPpfbJ+l3k3sPNIkvJqI
         DImS9qbxwcysAZJVbSU9nLREyiNZiIi/eVkQkKrEJHAKsT1Mb7XHX6L0eEgCKtGcoRca
         PFHMr7ZGixym5pQJSF776hGVIV9PBKiOh2sHLiLkHZu63VZoMIzYrCG05KiILPTmBeAb
         QuwUqDTIvI59hHkP4v3/ao1Vt09QRsnp9xKsivRtAhu0Rm6Qe+Y0rR90RZpvrt+FdDkm
         3gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362950; x=1762967750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waenEKCMjn97yqJgR3j8p8YSw3a8sLLocbZT7haat5A=;
        b=GW/wNeyjrMZzwehOY4vzoJTNLlHxxmsJlX6igDxqgtMI45eVJQJF0R6evobEkHqjqs
         Iq8zggsZYmaDOQuk7V5gIm/Erkw7CXC5t0u2HUAJNGJrW/ShZ2VaP8oduXOAxlSiti1t
         rjnJA31gRwcOADM4ad6lc+5NzveNcYv0cggwrbC80FwASRRRmPxPpv/m3e17+SIIZs6m
         M8xjEd9ysysjeTzUKZ8+xANUh2+bQ0bdVF8hjtkbgfdtQBAFz/tgKauzRWoQvwZfgd8R
         dST0SM23zN95R36czCnggCJwuFahpvUlwhu+C/XTBaKzS3XCGzqlck569NWxpXHKPc32
         8IbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoNvSgxrEovDyEns52m7eUICj6QNb0AOhL2TQk1NfqvlHMLMR5Oo1DCP/NICRULsZByTK4H6bonnLGBjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhCrSPrZos1NaxpM2tYGjQPHM2dtSWlXomoON9UO8QQnVVwWh
	Vwb3+F7oN80+ewlbB7DAMXqBJwMKK1vrlOnGoU9ehkwhqQX+3xTvwoHFFyargCe/yS0=
X-Gm-Gg: ASbGncvG6LfKJ6TaCcFsupZMN5tjotkSyPuz5VANhMV1hn2dljNxn4upXKr5j5ZAkgH
	qAxf8qcuXaYNFDJE9tZjZilnSvUXkcv0gCGDj1q9vjDG9C/l987zUHzTZiFvlwCjDCIBJq66bn9
	EeJDuLIVUVe/Q5n6jxhif28+sRdhwCbTMFM4phmRXxWU3oWgOKzniwI470toNX8Tn0vU6viFIDI
	Fu7U8xq/tW1ww7GYReZB1KgD/tR1vIKmazHuFApiBBJK9/3OVHJiUWuGcF/3eGVRu9xBETSsPUI
	Q4PKGH+2W/N4wvPNcQO+tAjepbcWmlCLu32N8RJsJ7ivtflWiwwAMECh1FrEkaUDpoNPaiYFD2+
	E31J+mHhKl6rKs3kgguLnb45G/KiOTkk6WFxahr/RPkNX4uIP2hIDs27PbKjTdfcXrrRCxo6OJU
	v+x6YWzInL4+vNWMNCP+qhDWrr4bu2z1Iju3DDUYp5/OE1sw==
X-Google-Smtp-Source: AGHT+IHujecuHKAp19SOjD1ziznvYD8tAwFGOLS3T8YEf0KUSZ8DObLM9JfUqnSghUiTTZ/sscfDOQ==
X-Received: by 2002:a05:6214:2262:b0:880:4690:3bb8 with SMTP id 6a1803df08f44-880710ba284mr52063816d6.18.1762362949784;
        Wed, 05 Nov 2025 09:15:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3ac4fsm551996d6.57.2025.11.05.09.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:15:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGh6p-00000007BtB-1oaJ;
	Wed, 05 Nov 2025 13:15:47 -0400
Date: Wed, 5 Nov 2025 13:15:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Laguna <lukasz.laguna@intel.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 27/28] drm/intel/pciids: Add match with VFIO override
Message-ID: <20251105171547.GP1204670@ziepe.ca>
References: <20251030203135.337696-1-michal.winiarski@intel.com>
 <20251030203135.337696-28-michal.winiarski@intel.com>
 <cj3ohepcobrqmam5upr5nc6jbvb6wuhkv4akw2lm5g3rms7foo@4snkr5sui32w>
 <xewec63623hktutmcnmrvuuq4wsmd5nvih5ptm7ovdlcjcgii2@lruzhh5raltm>
 <3y2rsj2r27htdisspmulaoufy74w3rs7eramz4fezwcs6j5xuh@jzjrjasasryz>
 <20251104192714.GK1204670@ziepe.ca>
 <r5c2d7zcz2xemyo4mlwpzwhiix7vysznp335dqzhx3zumafrs4@62tmcvj4ccao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r5c2d7zcz2xemyo4mlwpzwhiix7vysznp335dqzhx3zumafrs4@62tmcvj4ccao>

On Wed, Nov 05, 2025 at 04:20:33PM +0100, Michał Winiarski wrote:
> On Tue, Nov 04, 2025 at 03:27:14PM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 04, 2025 at 11:41:53AM -0600, Lucas De Marchi wrote:
> > 
> > > > > > +#define INTEL_VGA_VFIO_DEVICE(_id, _info) { \
> > > > > > +	PCI_DEVICE(PCI_VENDOR_ID_INTEL, (_id)), \
> > > > > > +	.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff << 16, \
> > > > > > +	.driver_data = (kernel_ulong_t)(_info), \
> > > > > > +	.override_only = PCI_ID_F_VFIO_DRIVER_OVERRIDE, \
> > > > > 
> > > > > why do we need this and can't use PCI_DRIVER_OVERRIDE_DEVICE_VFIO()
> > > > > directly? Note that there are GPUs that wouldn't match the display class
> > > > > above.
> > > > > 
> > > > > 	edb660ad79ff ("drm/intel/pciids: Add match on vendor/id only")
> > > > > 	5e0de2dfbc1b ("drm/xe/cri: Add CRI platform definition")
> > > > > 
> > > > > Lucas De Marchi
> > > > > 
> > > > 
> > > > I'll define it on xe-vfio-pci side and use
> > > 
> > > but no matter where it's defined, why do you need it to match on the
> > > class? The vid/devid should be sufficient.
> > 
> > +1
> > 
> > Jason
> 
> I don't need to match on class.
> 
> With PCI_DRIVER_OVERRIDE_DEVICE_VFIO it just becomes:
> #define INTEL_PCI_VFIO_DEVICE(_id) { \
> 	PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, (_id)) \
> }
> 
> static const struct pci_device_id xe_vfio_pci_table[] = {
> 	INTEL_PTL_IDS(INTEL_PCI_VFIO_DEVICE),
> 	INTEL_WCL_IDS(INTEL_PCI_VFIO_DEVICE),
> 	INTEL_BMG_IDS(INTEL_PCI_VFIO_DEVICE),
> 	{}
> };
> 
> So, no matching on class, but I still do need a helper macro.

Yes, that looks right to me.

Jason

