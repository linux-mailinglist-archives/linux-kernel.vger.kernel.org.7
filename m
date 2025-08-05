Return-Path: <linux-kernel+bounces-756796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFBB1B959
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C661D18A1737
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22052957B6;
	Tue,  5 Aug 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="osBfD8UV"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A0283FEE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414865; cv=none; b=NFlc3FlqdVxvhAskShRsil/qyAUCawCkzC5NoQVwRgItXR5eotd8YkA96UfPP3BRc5bYJDWMEKm1UtPJWrAf84d5g39wmG/hTMVHitn5fr908iJXhE0/yvwE8Ybp7Bd2v0KzhKqjKZjkbYSGMmfSuO+W8NaTW9+GiXxvAY7SrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414865; c=relaxed/simple;
	bh=ksPy7bPW/9nCkZK2o4mLxIR2SoHOhV5fATid0kfvACw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofueKspFSCz0EF4a3qZsaevobadABIHpWzw709uMZlRA6reEoBWuSlLfDMqmac4iVTF96taqf+h1vsQKM+FQdyVPTpTNcXn1ZRIVy2hoyNC22bs0BMLJmOit5ikvNu2qrU3FYovigW2s7xGXY7BFiK7VrL4NVIlPSrk0eN/Ax6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=osBfD8UV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e809baeef7so163180485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754414862; x=1755019662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WjDqUy71lV/WUAYYIZFC/brYVFN0tl6XNylwIvC8u88=;
        b=osBfD8UVzBrChf9dkjM4UhG721ESlaD2FTVO9XucIS2Rnrk9f7SZDt+KxXUN+bYf4h
         hYj5axfbh2kAtVqThWiB0O+g3WeiWrRXqrkje/mRrLNlFx3JHCBbC0Kl+mcMOezNIwrg
         emrCzZ4EyJ+kSILFrxzOL9sf+1V+DJdl4uKMpmOknKE4QecqlxIP/LoSRe/HTYIEhN7Q
         sWJl49lm8tVl7824J/iK89TcjCWZC4WtmnJXklOMynvg2PcPLXwgwqRr8GKxD59o2G8g
         9bZukzFikh/mz1YggtfvM4rH1c5YuWpklM1QhmAu9S2SJku4MJ0v5Pok9W3AAfML0UZd
         qb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414862; x=1755019662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjDqUy71lV/WUAYYIZFC/brYVFN0tl6XNylwIvC8u88=;
        b=YEeW37ZV7Clgra/0sZvVYiqn9pQa353E1qg7FmiYtA/qGin8aJyBRumdK7mai43NvX
         2Nka2uBMlqgHwJl83qVq14XR5O8ObVazTPsjoO3scZ3yO5PW36wttS9EJfTaXcBKwx9Z
         XbzKDdzOknxBSVKbNeJsIupbnQMhvmmyE5FtylI/oXCLkQGQ4FzG8iCp5jnrKpDNoUP9
         Z0mtdifXWQW9qFZZAIIUR/iCenIQlX8HXvWbJANX0FZPXoiXWC6g5PDTS/gU68XRmh51
         zXiNQ4q0UnhhQxzbYcPTbt91N6sKdRygHWDRW9O5Ms7jBAkXk2OSki2s8CMUEutb4xpG
         872w==
X-Forwarded-Encrypted: i=1; AJvYcCV4PN5Hgp7QA1B0eycLGE2tci0NI+x8kjCHbo6wZfbOtaaE1tlKuttjrKGUojTCkp2McQhWyC2z2ARTO4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvssOVWN6g5DsVPOHuDlIXayOXs8dFBTqeLV2JWPVmvSrPPsOM
	BYFvgY+l7Rv1BYNfjNIwzIpfzXdHfc53HL3ODV4VPaKlYbCYuntmb/xM6CEsSvbNFCc=
X-Gm-Gg: ASbGnct0UjWADSQvwWs4VGISxw6nBs0m60STjg2pvKE5P5+hlloK9HzoW4bGYvAu1X2
	X22GYqO/JaFu3xXJ45xbgmh78mkm1bEx8nR5VvSyPyziQj/n3IoWFNUGNWl/sx+y1l+48Fvaj4u
	LZSCDRkB+Be92diMsiMr8VaByR/SdYexeRmdHRGG/br0Y+GZE0OtLHrZ8y/FDVw0ssXrPOo5936
	Ekd4nomlXtFKaSTDRQeMjkDJDrJQkM2PBFJR91ZMkmjA0NXYJiswgiSEBdGw318gH27PSvM07LJ
	NuoZ+GaxB2CvR36xxr1rzJDVaCck/eU6y7Z7Nmt06ll2lV9nqtTnaFLY6ibk7GzUupv1Hi04kjs
	XxZ5ggo2zo/79KvlInTwm50dbbvIHo9LZl0frJgo2Z6uyiDmWDt+MKGBVhfGWC4s51FHr
X-Google-Smtp-Source: AGHT+IHy7XpO/6qEYngCoahXnCYpu69oHlagjnUCUPJ2Su1NtW9vipMRvRP+Dn6+sPrF7WNA3FiTmA==
X-Received: by 2002:a05:620a:a203:b0:7e3:2c33:6d9f with SMTP id af79cd13be357-7e814dad6abmr7669585a.31.1754414862403;
        Tue, 05 Aug 2025 10:27:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e806ad969dsm201306385a.78.2025.08.05.10.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 10:27:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujLRt-00000001ZRN-0PWO;
	Tue, 05 Aug 2025 14:27:41 -0300
Date: Tue, 5 Aug 2025 14:27:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250805172741.GX26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5acy9a8ih6.fsf@kernel.org>

On Tue, Aug 05, 2025 at 10:37:01AM +0530, Aneesh Kumar K.V wrote:
> > To me it is an unfortunate PCI specification wrinkle that writing to the
> > command register drops the device from RUN to ERROR. So you can LOCK
> > without setting BME, but then no DMA.
> 
> This is only w.r.t clearing BME isn't ?
>
> According to section 11.2.6 DSM Tracking and Handling of Locked TDI Configurations
> 
> Clearing any of the following bits causes the TDI hosted
> by the Function to transition to ERROR:
> 
> • Memory Space Enable
> • Bus Master Enable

Oh that's nice, yeah!

> Which implies the flow described in the cover-letter where driver enable the BME works?
> However clearing BME may be problematic? I did have a FIXME!!/comment in [1]
> 
> vfio_pci_core_close_device():
> 
> #if 0
> 	/*
> 	 * destroy vdevice which involves tsm unbind before we disable pci disable
> 	 * A MSE/BME clear will transition the device to error state.
> 	 */
> 	if (core_vdev->iommufd_device)
> 		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
> #endif
> 
> 	vfio_pci_core_disable(vdev);

Here is where I feel the VMM should be trapping this and NOPing it, or
failing that the guest PCI Core should NOP it.

With the ideal version being the TSM and VMM would be able to block
the iommu as a functional stand in for BME.

> Currently, we destroy (TSM unbind) the vdevice after calling
> vfio_pci_core_disable(), which means BME is cleared before unbinding,
> and the TDI transitions to the ERROR state.

I don't think this ordering is deliberate, we can destroy the vdevice
much earlier??

Jason

