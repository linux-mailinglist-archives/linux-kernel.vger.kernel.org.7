Return-Path: <linux-kernel+bounces-864830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08767BFBA65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9B264E815B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A433C523;
	Wed, 22 Oct 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OfI7cqOo"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D42FD666
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132839; cv=none; b=SwPdYR8Mq98J20A2Z2CZb8/TzYSr5FQmi6CzCILq55qltk+Ovb36jkKLd9/7juMSDVKbJDZoCX0EQXEPeyLh3uyvPvW+3MCyKwvH0aZk2hc+jaxE+trNvApc5RzgofOxHWEKoZtNU5Lb5Pba2rx0ntmq3biDwjFa1vmpYcTbeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132839; c=relaxed/simple;
	bh=5D2S8gFfpVrKc3T92fAN4H9FX1Y9Iry3sLfgM0BoAU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQz3Ki5iu8kz8NGFUgitWA1Idy/ChCKxVhXg68K+a4HllpRQ7/Ocm++CilMLV31YOY03gYDmfkzQOiHDLlSBSzdnofH5N6U8GBV05pDHjd9jtrtpRcIGp0XNhC1mAPXtjhrS0Lttb4Qpl++ExWygM+GpL4kNqiJIEE0MAu1d4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OfI7cqOo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-890521c116fso780439685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761132836; x=1761737636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzMuyf16b+hUTaqBectyipp8bmob3UCKigy6YT4wr2s=;
        b=OfI7cqOoC6VW6zcaUkh4JaVxWLRrQ4Mv2JJvcA0c58dJM1ahSQuVvPoh28whjgVesn
         FwBZVTL/MPRzrYVxVzdpoiMNIbKiJ62WxQyUTqXeAY2l4bDCqITuAi2vxpxVwsa5qFuj
         79mqA3y8abte2dhUO6LVbWAkg0BZgE9K4rHRd6Hx6pUHkUMGiiWQADsQcK79dyB7zWGK
         Qjn9li/1vQYnT+venKTVrZQPNja7RUZbUOsUNeThuQoLUfj5a58gfBU1wtbw8hjey2V9
         oOgnl45JVqDqfYNUNAgFWcgfYLx2b5GWQrky7Kac7BQ+T9NjWLhIJjlZWAmv8juTXt/9
         eG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132836; x=1761737636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzMuyf16b+hUTaqBectyipp8bmob3UCKigy6YT4wr2s=;
        b=EtHMZqGuFyFhpmiJUldVfu19ZkNIjT7HEteVCLYduMg3n+k3WHe6dDHciCJ0kh+Y0b
         mbbNK0w2m4EMRsGKkCuyCjY8i255Hl69Cb9seTSxxNl3QFcCdWWvrZse1jysBSsYQdg4
         uqVEs3HNel8XMvQq+MLJ34B3wQANdUIBzTPofHfGhbf0Bo0AU7fIJ0mUILQKVK1caNBA
         hUKDKUx3cA4LRqxxpnrtyhKBt0xN2YOHYEnNcDiu6DJwR48nulmYEyWbK8bj1uwwSOyV
         Io8+vEG16ln9ApTvFhet7weYfpt07VWIuYxipS2AQZIKnZD+TamXqcU5X1fLk7B+JuPz
         kvKg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2pvHKYHpQFDdDvFz3bzQCqP1mqUP+4ZCSI5ASz+2z3TnxV1Q+mzVGjDpGvi6H9zWqmwJ7qppjq+El04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOT/K4e0iG+CR2dIAQWKf3Y022HjhKd+a8IY56YBNQRSSY2UpC
	atFSvCmeSdG6m5+qlLkkvHzH5q/zvQgrPv3I6XnyZ4n/3DlbjcvSRD3j6MciC0Dc5O8=
X-Gm-Gg: ASbGncsytClI4z4rad62bFChZ4rMK83CXzfrLGSdWmb+IA0NalGK6USaTHinPcCGcR8
	U93ro3dyGSxNthgFek61OdexB6siCndSFv3JXhbrS/aINIKAdocYsDxNyMfjVbgXbUur7qTOLfQ
	lljsCM42+bBBj4Jt9vXZN+LaudQCx8NkGz/BKcNQ1e+AYTQrXaUZ551iiwt0GKPvF71unyGMpkM
	40RbVCt+CeTLN3ugXBzFJTQgmYKnJUFNMJAqj3EjkePOOmlQpOHli6jM6nKhmOXSgQSfse8QWQs
	hCGZRHR/6duxQZmE56q3vTqThh3WVCdZ8H2PtXU5MhJDbjOZHRQrc4529alkKJVlx6fH8zhDjFW
	U+kj9YknArNOHy6gBOwBsxXmw/wzYSxXsvf63w50CAzkz8lYfJG2DwEo+4uDM53ITji78XNcylO
	DodqY1Biobtys6iZUbSdpxMEj98XqmMrLmPSzGMaAmb+ovHQ==
X-Google-Smtp-Source: AGHT+IGcoJwXXqdtQtkm+G14JGdvXbaacdM5SDyQ7Xv4vGpp8puPf7A40E+xXVk1VpdF6uCqgx+zZQ==
X-Received: by 2002:a05:620a:4694:b0:891:ef6d:5231 with SMTP id af79cd13be357-891ef6d5476mr1901298585a.49.1761132836585;
        Wed, 22 Oct 2025 04:33:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af3afsm962961585a.36.2025.10.22.04.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:33:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBX6J-000000011YP-0ehF;
	Wed, 22 Oct 2025 08:33:55 -0300
Date: Wed, 22 Oct 2025 08:33:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Laguna <lukasz.laguna@intel.com>
Subject: Re: [PATCH v2 26/26] vfio/xe: Add vendor-specific vfio_pci driver
 for Intel graphics
Message-ID: <20251022113355.GC21554@ziepe.ca>
References: <20251021224133.577765-1-michal.winiarski@intel.com>
 <20251021224133.577765-27-michal.winiarski@intel.com>
 <aPiDwUn-D2_oyx2T@infradead.org>
 <ilv4dmjtei7llmoamwdjb3eb32rowzg6lwpjhdtilouoi6hyop@xnpkhbezzbcv>
 <aPib0tHn1yK9qx2x@infradead.org>
 <4e6ctwhyax2v65mgj3pud5z3vz75yputis6oufju45iptzaypq@zaxo42l23o2r>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e6ctwhyax2v65mgj3pud5z3vz75yputis6oufju45iptzaypq@zaxo42l23o2r>

On Wed, Oct 22, 2025 at 11:12:05AM +0200, Michał Winiarski wrote:
> On Wed, Oct 22, 2025 at 01:54:42AM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 22, 2025 at 10:52:34AM +0200, Michał Winiarski wrote:
> > > On Wed, Oct 22, 2025 at 12:12:01AM -0700, Christoph Hellwig wrote:
> > > > There is absolutely nothing vendor-specific here, it is a device variant
> > > > driver.  In fact in Linux basically nothing is ever vendor specific,
> > > > because vendor is not a concept that does matter in any practical sense
> > > > except for tiny details like the vendor ID as one of the IDs to match
> > > > on in device probing.
> > > > 
> > > > I have no idea why people keep trying to inject this term again and
> > > > again.
> > > 
> > > Hi,
> > > 
> > > The reasoning was that in this case we're matching vendor ID + class
> > > combination to match all Intel GPUs, and not just selected device ID,
> > > but I get your point.
> > 
> > Which sounds like a really bad idea.  Is this going to work on i810
> > devices?  Or the odd parts povervr based parts?
> 
> It's using .override_only = PCI_ID_F_VFIO_DRIVER_OVERRIDE, so it only
> matters if the user was already planning to override the regular driver
> with VFIO one (using driver_override sysfs).
> So if it worked on i810 or other odd parts using regular vfio-pci, it
> would work with xe-vfio-pci, as both are using the same underlying
> functions provided by vfio-pci-core.

I also would rather see you list the actual working PCI IDs :|

Claiming all class devices for a vendor_id is something only DRM
does..

Jason

