Return-Path: <linux-kernel+bounces-737004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71BAB0A688
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B5F1793E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C932DD60F;
	Fri, 18 Jul 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPPMGymw"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2042DCF64
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849886; cv=none; b=ChGzTswCGEFOz6zSbWs3lNjMhAbnZk91ZQ86vtObkHOfQRqPnuNYajJv92Dx+MPmRE9LOKgfQejTELmUrPx792UhuxrjYjGUABEI0TBclKc/NpyU7ZM7oAQNv5hhH72BMFXo/0vvFicEpxgaUJc1U/8uUsanltouAk+KWSIFG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849886; c=relaxed/simple;
	bh=57t08D0XBLsuBYTQTILMObpKWZEYbrXmLfmK6g9BlPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEQoO2G817Jqofo/ys5C/YqMKinIEvEqHcB07lcgaDw21l30c64C4DiWdiCC8bvgoag/wLs/StDImW7smu9LiqX4NHiLBWfyqItzMkCfcbbx2AwKGCXea2cZPkE33CiYMRU0AYFRHfnsYe3h7bg3X8J6J+lOLWCHTVzodldqq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPPMGymw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so16374871cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752849884; x=1753454684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JlY6wrS7xoiZAd1n9VylKL/5klHKuhmeV2q/x+jhjE=;
        b=pPPMGymwc8e4r7k4uixWz7VYtNrmEiCVnyG+fczy3nEPwPa/qOXlkLt1SNpG94Gjw4
         GGRWX426hSxyxk7uP/DtWeLq0YBRuh+poB84TDeqcJp6JNFIxfjkTuUNIPsobxuBEIzy
         3EG/5cxeXjT+xQyrNgXDpn2oczMq7CfP37DF/bHViZXVSEsaSjAwQPmvDLaPUr2N+xsi
         eIHgsBzfm7MpIas9e2ZlIUKXkOIRL1O0X+k5EehkQSlKSVN4KBJJc6X00/aSDWoivsvV
         /mGt5nGl8fH+jCLJ7dCBt+06AuVwFXJ4Y87uYG1VuhNRuqHZLVWOOGXxQEeyFLwHZB/c
         hCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752849884; x=1753454684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JlY6wrS7xoiZAd1n9VylKL/5klHKuhmeV2q/x+jhjE=;
        b=RGS/R8wiCBH3XVgapcZJygMFz9276rFKAcyZvWJ1pBXDouPrZG9vimP9ctXHZ2OxG2
         fcF16StidKH/r/g1D5TpC5q/AToA0TFWb+9Gf0pshsLQ2PcXflIvMdYy1vMabauMLy6y
         TRig8zyAs+DIPJNtxeFsDzWU5nsL9mo4BPKg/kSC8Zr/WR2HsBTU104zNR/mZFj9uXUa
         ClxVKKWuwQGrD5X0lTUnAY0Cn62/oxUuUyavvQ9kbmZIvyiJkqlIqPErOcGrGovyR7xa
         MCk6CTMXaqpvn047gD71bqFgeRkxSyaGUE/VVn98rWnbFqdnPkzvkT0ziQAy7U8Gdggf
         +EgA==
X-Forwarded-Encrypted: i=1; AJvYcCVX3EZM0pQYzjOHdKF53q4dl0PXgQ0t22829SJUPsdNURRAguouVTxUbQABQ0rkTFW9/qZ/vUA1AHArayc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZE7VHki6RphKeWMSHqvFUAmsBYa/md6st7MNo2SYw3tagVkb
	7NcrbWSi/gZZxunr76Ga3dKmyoYn9BR4ZCu6jLj6MylF9Qk0KVU6HEqlkHXiqYgjWwI=
X-Gm-Gg: ASbGncsXXv6d+/fZl30oGR4enoiwqtoXARy4ejpd9v45hfGzOJwmD3Ndy0OJ8u4lAuG
	DsNQi6RRIVtR0wiw/9gD2a9wW7ROCxUMwiKuVWNX6Dodu5gGgdyzhCytdSJVdl0o+wWsaQE2aEQ
	7uHSFXjo9RsNpLH9bYxnlRAUh1BETcl3sz30dCqHyp2BC3BX40n5FnCq7xs/L5HLAo2B2FbN4IU
	zyAMt7pBeRZ2xECU0joidKfj+zKWHjQkW6zKhOt34D4gM6n2F73PCeZYTOIkSUZbvxXCmKGSaMS
	pTTMnPnEkzFjxo1U/fo9QD0o/hjLrbw/0HcmZfO9PZ83pCIk4zGZGrBh2fJ7xfieYhVS3NZWbCa
	2HkM6wkIUimTWv4p+iXJhLiZ9wrfn0LpS7UNqYujhJSCF3EPaAzNOHidII0n4xFv083gmqnsp8k
	ZGkK65mCWD
X-Google-Smtp-Source: AGHT+IEYd5qGIZ9KDhfEstxE616f9xXLY8QoZsrjUpURE5IRjE2GiKRGVckhayOKGta9pjoTuDB7PQ==
X-Received: by 2002:a05:622a:1448:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4ab93d88915mr157868681cf.37.1752849883674;
        Fri, 18 Jul 2025 07:44:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8c04fdsm8211446d6.15.2025.07.18.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:44:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ucmKI-00000009zcK-2UVK;
	Fri, 18 Jul 2025 11:44:42 -0300
Date: Fri, 18 Jul 2025 11:44:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <20250718144442.GG2206214@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpXXKTaqp8FUhmq@casper.infradead.org>

On Fri, Jul 18, 2025 at 03:17:00PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 18, 2025 at 02:51:08PM +0300, Yonatan Maman wrote:
> > +++ b/include/linux/memremap.h
> > @@ -89,6 +89,14 @@ struct dev_pagemap_ops {
> >  	 */
> >  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> >  
> > +	/*
> > +	 * Used for private (un-addressable) device memory only. Return a
> > +	 * corresponding PFN for a page that can be mapped to device
> > +	 * (e.g using dma_map_page)
> > +	 */
> > +	int (*get_dma_pfn_for_device)(struct page *private_page,
> > +				      unsigned long *dma_pfn);
> 
> This makes no sense.  If a page is addressable then it has a PFN.
> If a page is not addressable then it doesn't have a PFN.

The DEVICE_PRIVATE pages have a PFN, but it is not usable for
anything.

This is effectively converting from a DEVICE_PRIVATE page to an actual
DMA'able address of some kind. The DEVICE_PRIVATE is just a non-usable
proxy, like a swap entry, for where the real data is sitting.

Jason


