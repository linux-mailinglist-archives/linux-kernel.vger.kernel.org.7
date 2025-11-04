Return-Path: <linux-kernel+bounces-885392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14AC32C74
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892674E817A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B62D8DB8;
	Tue,  4 Nov 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ah8Miwb9"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B643147
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284438; cv=none; b=GPPMHmKUzee4MmISszXe+bnIjeV3UGEcWWAzDeqOPXoTAIn8glzHd/dDO6F2d6CV8W7n7EpEbYZvrnHY9JtoaKYsgEBpJqbMlFC0rvKMRe+unvGySxh8ZbMC/FvmWfLHfdzur8pgOCeWl7hrOJuoViYVoaB6SOEdBGyD6wayuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284438; c=relaxed/simple;
	bh=ERQVrbBCQIPe4MLibTpmxNghzimhnud2fzegQLVewpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1VVU3eiqO7UR+WR71SbPv6Id2Ll7g6aBhRCTDjp6vd1boykgMVo042/H5Kq0VJMykdNcmr8LT9V76ouBu0+SFJr2tYKmJ5RAyEbWWd3nSQpWp7kGEwqFMV8lohJ8TU5ZgUrwoNBDGJ5HoOpTSiINMI/xXeTjtvcd0x8dfcwZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ah8Miwb9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8801f4e308dso53684506d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762284435; x=1762889235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUs2AdnuvvFczrN0XtEi+7TYEAruGEb9Cu+wb9VP03U=;
        b=Ah8Miwb98PBPZa9TlsLGk1Gm0gaRsYQf+f7ILGvO4khgzWXNJ0AqzV/ArrgDGClKsV
         w8hZs5RgVEmD3roEXkRcFDqA5fkdjRuPXCLuH1eCAc0Hel1AZj+Umtx6A6SW4k8Mxas9
         2D2ykWkHMZ+H6mwRE2OwRu45cBa+2cWPY3J6xNHWZADVH4S8/GIpccCeXM5DO92RUL/B
         f6AJvii6GKfe4749vw8PA2ZZBy5EtJWCk/xIMdKgHV6zZ0iroMJI82HY6edG/DUKSnVy
         ngopOSW21aQLJt5X9MNi3sqJGvHRA2qmjCaSay2wP6UxDugkAfh6vDlsib3gI/CyQQDb
         sbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284435; x=1762889235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUs2AdnuvvFczrN0XtEi+7TYEAruGEb9Cu+wb9VP03U=;
        b=VJekP88YSZ2+vlS7QvqK2okLO+QsWAIu2mA+KCvIqnZtNODSIqIYbWsBgIdEU3dVb5
         AoKUdUbMK7rD9Xs8GifkTbZ14yVcPkKLEV4HS03lZ9j9BU5tQuIEYeQWWETwyF6uN1qT
         sRmt92i4w/StIKvqjz2Obk1Vb918D7IS9pnCe5ARr1YNl72M2oInYenmCAWZjA2LDWJ/
         0VlczIHAT55IfNY8ANrhYd6UCI+38YDDLFbIUNZYSW8wtpXXOoA188996CQoMJJaTX0a
         LVpnrj550LklqJ87uaC6HoMy2Cugrj1ETVQNlXvtU6jONRtBam99gvNEjJ8kD7Uxix7S
         z96A==
X-Forwarded-Encrypted: i=1; AJvYcCU9vzX4srxbBkvriQpWwk+K8PgeG936RfqC//qg6vxkErmvKhUEEJjSyTn4hy24/ls/T4gD9wSDeRIsMmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDafFAR8rZ+fTxOdf1oe9mVRFq+62aSRXoXx1iFvjk0KzBDwXb
	HgBiEeLqEUhi1t5qoP4nOFytNoF6PCBOSDVwmy/VIMACVJS5YN3UFo30kF/3lsTTN8E=
X-Gm-Gg: ASbGncsVVGcmIGEEaLP5T4ScYsiVDQ1mk2y7B2e+PNAZEYgwY6YIrjgglUREku78r3I
	RSljnMc2+Z/vAKXGB79ZMGFf1anCs7BSDGR8/rOfAkjCQtZA3HOY7h4e12XOIa+Etx1Lo1FmaTu
	blsi3BL6z61Hog75aREdRsh/jA2WTewoMkeuJNCQ4XqMcGDqkiXiYpU3OALgYj5g4p1l3Rs+VVS
	uy+sUM8yiKs7riv5Gt0vGM+F1WLN6/rxelmjxVWwJfUix7ju9lerKohR4lxV/RPNq8yRd2UWRCB
	gzMZzuzuhZ/5+ix01KR9qkU33gemQ72WjvK+M4NQ2ZTeJLgPmeWF4Jyz9s175Kl6zOW1O61wE04
	dftN9BaVMf+YJO2Z7px85vGV8U0VX8aNsm70cdi+pWjhZtt0CquXdNoZr5IyvDxmwWF/tyR20v3
	qm8rmybAM1opY0ZVcA79ypIpENlrn8TaSkG9eNRf+89RlLfHUUqjRU+iv9
X-Google-Smtp-Source: AGHT+IG0dhBeAR5RX27f2wfJWdOR7juDgLSbyDVJXq4BJqtIZIC/EimxFvt08yglge630ermzohXtg==
X-Received: by 2002:a05:622a:2d3:b0:4ed:18d5:2140 with SMTP id d75a77b69052e-4ed7262c198mr10018791cf.66.1762284435447;
        Tue, 04 Nov 2025 11:27:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5faf6038sm22412071cf.11.2025.11.04.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:27:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGMgU-000000073Cx-1Hyp;
	Tue, 04 Nov 2025 15:27:14 -0400
Date: Tue, 4 Nov 2025 15:27:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
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
Message-ID: <20251104192714.GK1204670@ziepe.ca>
References: <20251030203135.337696-1-michal.winiarski@intel.com>
 <20251030203135.337696-28-michal.winiarski@intel.com>
 <cj3ohepcobrqmam5upr5nc6jbvb6wuhkv4akw2lm5g3rms7foo@4snkr5sui32w>
 <xewec63623hktutmcnmrvuuq4wsmd5nvih5ptm7ovdlcjcgii2@lruzhh5raltm>
 <3y2rsj2r27htdisspmulaoufy74w3rs7eramz4fezwcs6j5xuh@jzjrjasasryz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3y2rsj2r27htdisspmulaoufy74w3rs7eramz4fezwcs6j5xuh@jzjrjasasryz>

On Tue, Nov 04, 2025 at 11:41:53AM -0600, Lucas De Marchi wrote:

> > > > +#define INTEL_VGA_VFIO_DEVICE(_id, _info) { \
> > > > +	PCI_DEVICE(PCI_VENDOR_ID_INTEL, (_id)), \
> > > > +	.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff << 16, \
> > > > +	.driver_data = (kernel_ulong_t)(_info), \
> > > > +	.override_only = PCI_ID_F_VFIO_DRIVER_OVERRIDE, \
> > > 
> > > why do we need this and can't use PCI_DRIVER_OVERRIDE_DEVICE_VFIO()
> > > directly? Note that there are GPUs that wouldn't match the display class
> > > above.
> > > 
> > > 	edb660ad79ff ("drm/intel/pciids: Add match on vendor/id only")
> > > 	5e0de2dfbc1b ("drm/xe/cri: Add CRI platform definition")
> > > 
> > > Lucas De Marchi
> > > 
> > 
> > I'll define it on xe-vfio-pci side and use
> 
> but no matter where it's defined, why do you need it to match on the
> class? The vid/devid should be sufficient.

+1

Jason

