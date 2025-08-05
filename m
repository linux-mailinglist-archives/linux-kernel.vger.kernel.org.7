Return-Path: <linux-kernel+bounces-756854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7EAB1BA66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B62624836
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E3299AAB;
	Tue,  5 Aug 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hMlNCJEm"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265A29993B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419343; cv=none; b=DF8hDDtFIQZCw7DNG8JfSL6GnrPFBzt5VmG12/Lc4Gz+AZ+0cYWWUIa7519AdnPcHGtC2d4HbdlzLzy2hu/zYYRm4QGx4SDFj/dxDpAcDU2rSO9yXkI6vrMKbHYsFdnelJqSAAMNeTGLAn5NfSeGqDTxHmL8bzgXmGpq74BYy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419343; c=relaxed/simple;
	bh=P46mtJ0gCpHpBEjbtuFgOf8BIfh7RrO1hxnNGIV0+78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH55adoUziTNIaIppZd9qgoQABDIKoESAVpOD4uElNTi+/0mF1cLYwr5CC1Y78Pfj1yJlwPpRGFJ1YhhWPYjUTHmCYmEDcEbL20C5EqIyc9s05+r7Vvkh/Y0dpeepw1n33FlAoH/1z2+hr1O9EHXr1RFLTzhxlFtl8UxUYC0cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hMlNCJEm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e6696eb47bso631114985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754419341; x=1755024141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7XB7GrHToBPhXF/Sktcv3tgOaDMdGgdpINsfi2+cJw=;
        b=hMlNCJEmvaEqVCrsynGZIbJlY+vrzldjFrEOTnECjnwIhdDMwdmtPaviVV3N8mZ9ks
         3boGYBnyDigJ6gCw2KbmyKia1zt5E9kfHq6561LbYlpptw26sAGpn7dz4gJzzoy3MSnX
         EfqD4HcfgZEkE/uiPaVkkay8X11+3YXJkRGfI9wqtYTJgvuyznUYJgZ3A2SSmM2IJO8R
         zRpAzuRRvqZiM2XH0sbWYSLqJlAktF768nbUOBWI+JcN7ZANiYU7ggpDVFM1dHpQBUJ/
         OZOCrh5gsvSVq3D0o7dEdUAZKLo8zq1qgCEjgyNXTzi9Ic0vv9rFjkMeg4HcbLzq54QA
         ODXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419341; x=1755024141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XB7GrHToBPhXF/Sktcv3tgOaDMdGgdpINsfi2+cJw=;
        b=e9AsGhetemtiMzhu/WGsM/ua/axqNcUGC0+8zFAyaZHPYvb1i6upbOFhDcKKOJUyNE
         zicUpEL/ppNRKSfx4bmcZMX4Jf9nTEeRNyf+6HWUXmyco4r1sZsBqr+Fx2HAK+KPhjT/
         y/Ok0tNo9rAzlJx21qZxuooT5ZS5KowU3ESPucfzcTTQ8JFFPqLx2MkmVGgDIIrAjcVz
         dwHZ+T5KrRpBopQ/UMdvSKJJjWNk/oKECm6DYG96HPIv2dbZg6nkrY4upTmj6V/kkyU3
         EP7REsiCh4MFZBcCTaESKYjFl2XpRkXcEcn7nPpI4fyZbRCdFmk3l2Ip/VjFjF8u7Lcq
         Bdgw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHyHW+AOmMWErzMpdiqApzlE9ujDlr9+lAm5yo8tPfK5hN9CykBbdqtQsgyd4ijK2dAa9URgYqbGmadw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26RE8UZ6hfz3XWUpwBr+U1hqUiM0dx1BDcOCiUSs82RpZyo8l
	O/0isd/Gvpx2UNq2k8zlg7bU1xb353wBNh34k682CJj/iM5VXR39uU1Td//Zy7iONIE=
X-Gm-Gg: ASbGncsdUUQV9Cn6zexZTmb2vVZhvVAlR/ht1s/j5Ck4d6giwFpP3aVD1QBsQTPtT3L
	as7wiOHLxwiYW5OwcfH6XNpK5GwoipDs8H7+uRuqCvW4TCdHmez4ziGVHRynTl71F7L4cQuAPww
	VDTSoy2BqYFGTrWyitV++XvUEkUgAALtXA20MbzzWdLtgOWi/lQFKK+C9t6/qOzNE44k8a6HSBc
	4KXjhfu71n0WY+zOIOHGNFanC81ZodqKB3gWP04GWXgFMYYDYjuOOe+UhgIGqaeb4ts5jmcjHvd
	EsgcV3ulDJVnEWTHqNtXhQXRu3i5kCIXuTnBqTWd4Syr5IbPJMkvlRra8/RzCRosEfjN8oQfCR5
	sDH9Tw/s1vzPfQWPSjI2/gINpgc4Gh7YWbJR9y7MWAcqIVThdoXuGN6XtqxQvLQU1zDDQ
X-Google-Smtp-Source: AGHT+IFJzYdfGQoh/nIgvuIB92GlB+9KcosE0NpiAsp7dbUcQ9i0SxxUhRh1JZQ7lvAEKF3yp7Ujtg==
X-Received: by 2002:a05:620a:a91a:b0:7e6:30f0:82bd with SMTP id af79cd13be357-7e814dae548mr48217385a.33.1754419340508;
        Tue, 05 Aug 2025 11:42:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f594228sm692985285a.11.2025.08.05.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 11:42:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujMc7-00000001aDl-0KMK;
	Tue, 05 Aug 2025 15:42:19 -0300
Date: Tue, 5 Aug 2025 15:42:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250805184219.GZ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
 <20250805172741.GX26511@ziepe.ca>
 <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Aug 05, 2025 at 11:27:36AM -0700, dan.j.williams@intel.com wrote:
> > > Clearing any of the following bits causes the TDI hosted
> > > by the Function to transition to ERROR:
> > > 
> > > • Memory Space Enable
> > > • Bus Master Enable
> > 
> > Oh that's nice, yeah!
> 
> That is useful, but an unmodified PCI driver is going to make separate
> calls to pci_set_master() and pci_enable_device() so it should still be
> the case that those need to be trapped out of the concern that
> writing back zero for a read-modify-write also trips the error state on
> some device that fails the Robustness Principle.

I hope we don't RMW BME and MSE in some weird way like that :(
 
> > Here is where I feel the VMM should be trapping this and NOPing it, or
> > failing that the guest PCI Core should NOP it.
> 
> At this point (vfio shutdown path) the VMM is committed stopping guest
> operations with the device. So ok not to not NOP in this specific path,
> right?

What I said in my other mail was the the T=1 state should have nothing
to do with driver binding. So unbinding vfio should leave the device
in the RUN state just fine.

> > With the ideal version being the TSM and VMM would be able to block
> > the iommu as a functional stand in for BME.
> 
> The TSM block for BME is the LOCKED or ERROR state. That would be in
> conflict with the proposal that the device stays in the RUN state on
> guest driver unbind.

This is a different thing. Leaving RUN says the OS (especially
userspace) does not trust the device.

Disabling DMA, on explict trusted request from the cVM, is entirely
fine to do inside the T=1 state. PCI made it so the only way to do
this is with the IOMMU, oh well, so be it.

> I feel like either the device stays in RUN state and BME leaks, or the
> device is returned to LOCKED on driver unbind. 

Stay in RUN is my vote. I can't really defend the other choice from a
linux driver model perspective.

> Otherwise a functional stand-in for BME that also keeps the device
> in RUN state feels like a TSM feature request for a "RUN but
> BLOCKED" state.

Yes, and probably not necessary, more of a defence against bugs in
depth kind of request. For Linux we would like it if the device can be
in RUN and have DMA blocked off during all times when no driver is
attached.

Jason

