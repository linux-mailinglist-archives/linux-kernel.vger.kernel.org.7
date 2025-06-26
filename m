Return-Path: <linux-kernel+bounces-705235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E725AEA735
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A2F5607EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA22F533B;
	Thu, 26 Jun 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RggdGqiA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC92F49FA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966848; cv=none; b=aH1PMQqNisj/zXdQOtJldHDt+2ObqYLgmW2pmzjF6s9VcSlAyckqweP3TiBb4baNZKwbzkjzwALSmRPUZkWu0T3au4IjzEQYoyp46cIP8lux1wtjyARcygqwS10dx6823wdlPWuo7TOpZGzaanNJS+c6kuzT46LZwnHTiFi/J7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966848; c=relaxed/simple;
	bh=dM9I99bqjM9rdGoo0uOuC6Ud0JHcGJfH4Mjr85h64Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkDacWp3X8Qvf76sIlpL8R/b6a4vsHIKj0lP8KhDkZc2vpVW1EdyEe/32lP4IacWTLGwy0iJRLRuSNdzs6M73B7f4OF9Gq0/aGDw/U6ZA53oTMu+SS9APaBh8R8KOrOaPXp7hCPj3X35s9LJHdvfJNcs4Ho+2pWZSuo7gDo3InY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RggdGqiA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bbfe9e864so211732a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750966844; x=1751571644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi0zyP0lhLzXRnA/JuxxkK7pzdS3ZWCjFq9wZFiffhA=;
        b=RggdGqiAFpmJtIZk8VbeI8gJQQHyGnnrqmfPduLsBx3KshgWmD/haCBqPp/j6NWURB
         tz1V39tfhpYNjkMPBtOuJl195hn7Qn7Ijjt/Qg62W9D5ZCtxVg20H/kbj1cXhGQgEncx
         vDw/vYO1gkkrtt5JUeCJ/SlEvSWaVdgRxrGyqPkb6w+OAtWO25OT6xeoiStx7/AKFGpO
         yI1kSXWbvsQs2ydwWJl74RxTKpEqaTQ5dzEsCrjhI0fYMIPyayeZVg7/yeQuJjHamTaC
         g8YTXhAYq60ARsN0a4UseYL1iaooWYRiV1QDh8VGyU85oZx5zlwIaPHPS8yDY5B30exb
         z2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750966844; x=1751571644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi0zyP0lhLzXRnA/JuxxkK7pzdS3ZWCjFq9wZFiffhA=;
        b=ShMNCKmpuCPwCQGFTckpJi0ovkeyn2FvFgO/hEEioRAcOMGlY4CJ4VEwThA8OYDfTW
         wAt4RiGB9jnffw/3LhIkpL0XlRIPkQmmUbwToyuezd9er6TDl3ubwsHoVUtI02uxQyco
         QjzrQWEUr7BDniHDOhWaY/OXQrKNjs1sSBdIE8gCWsFUASPSYcxbYk29DjtUMpAMtnek
         Xgdb+cBccpGm0SxDOyJyJ1q0h6pKh3pe8ZNY1XxMCdtk7ag2atMxLlN05W64l9x+xt1K
         sQRtS0MfSAjwNi5tCGEziOLzvDQHnpJPfJPE3rkip2uOx0n7Qwy7OiKnMIAxGrAq4mK7
         xA7w==
X-Forwarded-Encrypted: i=1; AJvYcCXTbstRcqi6F7c6BE2B033lQoGI+5BGprvuyrSR3IKdLkFHpm64/DHtzRYZIrCB/kPfZZxe2psVoWlwIN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbL9bpVkUmtaEWmG1IKEvVV2ZNW+Ygi2IUv8tsDqrTCtoQvhi
	pYbFYI/ChITs5JA6WgP5ooCh5AXbKO+Jqp5ltpDeDxjhbLmu5uzcYLZDnc2YgeiPtPU=
X-Gm-Gg: ASbGncsQOQTHHzzChsaaRKyDNb0XZ+08I6PP07XhjigGhJXyedBDbcgchqd4qJ4KH6E
	RBLDHc/l0Y1fTjR2CohCV45M4OgO4Of+hBQLAGwAA7s+JSKB1clnQ0qOffmekWS9+mGazK+zRPJ
	k0h819EvIxBw4zxBWHmy62xy4kDzW/7m3qphUvSIF0HE2lEjdHytofv+Xu8zC0p0kpFVwLW/PBt
	e0RhZDwYgXRs83z7stBsPLKy43aG1pPGBTcBTiIkyCD+Jd8OEuAFL6XBfNr5LZjaYh7SrQurMk2
	yU7GUglK/RCzmf0mhHw9Zj0yOELKzBzzvWjotQ8Plp1sGQ==
X-Google-Smtp-Source: AGHT+IEsYVBfqLRZXizUOunREMSsJk6JMVGmiEF90edDyS4wLX4c3Ncf8ou/Y+kyS4pvWL6h/0lOPQ==
X-Received: by 2002:a05:6402:3585:b0:60c:3c9b:4862 with SMTP id 4fb4d7f45d1cf-60c88e394b2mr90760a12.7.1750966843715;
        Thu, 26 Jun 2025 12:40:43 -0700 (PDT)
Received: from mordecai.tesarici.cz ([213.235.133.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c83208aa2sm400637a12.74.2025.06.26.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:40:43 -0700 (PDT)
Date: Thu, 26 Jun 2025 21:40:38 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
 <john.g.garry@oracle.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <20250626214038.2d005bb5@mordecai.tesarici.cz>
In-Reply-To: <0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-8-ptesarik@suse.com>
	<aFynHWAYtKPFT55P@archie.me>
	<20250626070602.3d42b607@mordecai.tesarici.cz>
	<bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
	<20250626154818.46b0cfb1@mordecai.tesarici.cz>
	<0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 17:45:18 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 26/06/2025 2:48 pm, Petr Tesarik wrote:
> > On Thu, 26 Jun 2025 10:58:00 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> On 2025-06-26 6:06 am, Petr Tesarik wrote:  
> >>> On Thu, 26 Jun 2025 08:49:17 +0700
> >>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >>>      
> >>>> On Tue, Jun 24, 2025 at 03:39:22PM +0200, Petr Tesarik wrote:  
> >>>>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> >>>>> index cd432996949c..65132ec88104 100644
> >>>>> --- a/Documentation/core-api/dma-api.rst
> >>>>> +++ b/Documentation/core-api/dma-api.rst
> >>>>> @@ -210,18 +210,12 @@ DMA_BIDIRECTIONAL	direction isn't known
> >>>>>    	this API should be obtained from sources which guarantee it to be
> >>>>>    	physically contiguous (like kmalloc).
> >>>>>    
> >>>>> -	Further, the DMA address of the memory must be within the dma_mask of
> >>>>> -	the device.  To ensure that the memory allocated by kmalloc is within
> >>>>> -	the dma_mask, the driver may specify various platform-dependent flags
> >>>>> -	to restrict the DMA address range of the allocation (e.g., on x86,
> >>>>> -	GFP_DMA guarantees to be within the first 16MB of available DMA
> >>>>> -	addresses, as required by ISA devices).
> >>>>> -
> >>>>> -	Note also that the above constraints on physical contiguity and
> >>>>> -	dma_mask may not apply if the platform has an IOMMU (a device which
> >>>>> -	maps an I/O DMA address to a physical memory address).  However, to be
> >>>>> -	portable, device driver writers may *not* assume that such an IOMMU
> >>>>> -	exists.
> >>>>> +	Mapping may also fail if the memory is not within the DMA mask of the
> >>>>> +	device.  However, this constraint does not apply if the platform has
> >>>>> +	an IOMMU (a device which maps an I/O DMA address to a physical memory
> >>>>> +	address), or the kernel is configured with SWIOTLB (bounce buffers).
> >>>>> +	It is reasonable to assume that at least one of these mechanisms
> >>>>> +	allows streaming DMA to any physical address.  
> >>>
> >>> Now I realize this last sentence may be contentious...  
> >>
> >> The whole paragraph is wrong as written, not least because it is
> >> conflating two separate things: "any physical address" is objectively
> >> untrue, since SWIOTLB can only bounce from buffers within by the
> >> kernel's linear/direct map, i.e. not highmem, not random memory
> >> carveouts, and and definitely not PAs which are not RAM at all.  
> > 
> > I see, saying "any" was indeed too strong.
> >   
> >> Secondly, even if the source buffer *is* bounceable/mappable, there is
> >> still no guarantee at all that it can actually be made to appear at a
> >> DMA address within an arbitrary DMA mask. We aim for a general
> >> expectation that 32-bit DMA masks should be well-supported (but still
> >> not 100% guaranteed), but anything smaller can absolutely still have a
> >> high chance of failing, e.g. due to the SWIOTLB buffer being allocated
> >> too high or limited IOVA space.  
> > 
> > Of course this cannot be guaranteed. The function may always fail and
> > return DMA_MAPPING_ERROR. No doubts about it.
> >   
> >>> @Marek, @Robin Do you agree that device drivers should not be concerned
> >>> about the physical address of a buffer passed to the streaming DMA API?
> >>>
> >>> I mean, are there any real-world systems with:
> >>>     * some RAM that is not DMA-addressable,
> >>>     * no IOMMU,
> >>>     * CONFIG_SWIOTLB is not set?  
> >>
> >> Yes, almost certainly, because "DMA-addressable" depends on individual
> >> devices. You can't stop a user from sticking, say, a Broadcom 43xx WiFi
> >> card into a PCI slot on an i.MX6 board with 2GB of RAM that *starts*
> >> just above its 31-bit DMA capability. People are still using AMD Seattle
> >> machines, where even though arm64 does have SWIOTLB it's essentially
> >> useless since RAM starts up around 40 bits IIRC (and although they do
> >> also have SMMUs for PCI, older firmware didn't advertise them).  
> > 
> > Some of these scenarios can never work properly because of hardware
> > limitations. There's nothing software can do about a bus master which
> > cannot address any RAM in the machine. I'm not trying to claim that an
> > operating system kernel can do magic and square the circle. If that's
> > how it sounded, then my wording needs to be improved.
> > 
> > IIUC the expected audience of this document are device driver authors.
> > They want a clear guidance on how they should allocate buffers for the
> > streaming DMA API. Now, it is my understanding that device drivers
> > should *not* have to care about the physical location of a buffer
> > passed to the streaming DMA API.
> > 
> > Even if a bus master implements less than 32 address bits in hardware,
> > I'm convinced that device drivers should not have to examine the system
> > to check if an IOMMU is available and try to guess whether a buffer
> > must be bounced, and how exactly the bounce buffer should be allocated.  
> 
> It's never been suggested that drivers should do that; indeed trying to 
> poke into and second-guess the DMA API implementation is generally even 
> less OK than making blind assumptions about what it might do. The 
> overall message here is essentially "if you want to do streaming DMA 
> then you may need to be wary of where your memory comes from." We can't 
> just throw that out and say "Yeah it's fine now, whatever you do the API 
> will deal with it" because that simply isn't true as a general 
> statement; drivers dealing with limited DMA masks *do* still need to be 
> concerned with GFP_DMA (or even GFP_DMA32 might still be advisable in 
> certain cases) if they want to have an appreciable chance of success. 
> All that's different these days is that notion of "limited" generally 
> meaning "32 bits or smaller".

We're on the same page then. I'm going to make a better explanation of
how things work and what is expected from DMA API users.

Thank you very much for your feedback! I'm sure it will be greatly
appreciated by future generations of device driver authors.

> > If we can agree on this, I can iron out the details for a v2 of this
> > patch series.
> >   
> >>> FWIW if _I_ received a bug report that a device driver fails to submit
> >>> I/O on such a system, I would politely explain the reporter that their
> >>> kernel is misconfigured, and they should enable CONFIG_SWIOTLB.  
> >>
> >> It's not really that simple. SWIOTLB, ZONE_DMA, etc. require platform
> >> support, which end users can't just turn on if it's not there to begin with.  
> > 
> > I know this very well. As you may not be aware, my ultimate goal is to
> > get rid of ZONE_DMA and instead enhance the buddy allocator to allow
> > allocations within an arbitrary physical address range, which will not
> > rely on platform support. But that's another story; for now, let's just
> > agree on how the DMA API is supposed to work.  
> 
> Indeed that might actually end up pushing things in the opposite 
> direction, at least in some cases. Right now, a driver with, say, a 
> 40-bit DMA mask is usually better off not special-casing DMA buffers, 
> and just making plain GFP_KERNEL allocations for everything (on the 
> assumption that 64-bit systems with masses of memory *should* have 
> SWIOTLB to cover things in the worst case), vs. artificially 
> constraining its DMA buffers to GFP_DMA32 and having to deal with 
> allocation failure more often. However with a more precise and flexible 
> allocator, there's then a much stronger incentive for such drivers to 
> explicitly mark *every* allocation that may be used for DMA, in order to 
> get the optimal behaviour.

I have a different opinion. Most buffers that are passed to the
streaming DMA API are I/O data (data read from/written to disk, or
received from/sent to network). For the write/send case, these pages
were previously allocated by user space, and at that point the kernel
had no clue that they would be later used for device I/O.

For example, consider this user-space sequence:

	buffer = malloc(BUFFER_SIZE);
	fill_in_data(buffer);
	res = write(fd, buffer, BUFFER_SIZE);

The write(2) syscall will try to do zero copy, and that's how the
buffer address is passed down to a device driver. If the buffer is not
directly accessible by the device, its content must be copied to a
different physical location. That should be done by SWIOTLB, not the
device driver. Last chance to chose a better placement for the buffer
was at malloc(3) time, but at that time the device driver was not
involved at all. Er, yes, we may want to provide an ioctl to allocate
a suitable buffer for a target device. I think DRM even had such an
ioctl once and then removed it, because it was not used in any released
userspace code...

In short, the device driver has no control of how these buffers were
allocated, and it's not fair to expect anything from the driver.

Sure, there are also control data structures, e.g. Tx/Rx rings, but
they are typically allocated during device initialization (or ndo_open)
using the coherent DMA API and reused for all subsequent I/O.

In summary, yes, it would be great if we could reduce bouncing, but
most of that work has already been done, and there's little left for
improvement. So, why am I working on a PAR (Physical Address Range)
Allocator? Certainly not to help users of the streaming DMA API. No,
but it should help dynamic SWIOTLB when the primary SWIOTLB is
allocated in an unsuitable physical location.

Petr T

