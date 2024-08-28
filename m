Return-Path: <linux-kernel+bounces-843927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66DBC09C7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F3D188D144
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE552D374A;
	Tue,  7 Oct 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o9LGNexC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017082D3228
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825419; cv=none; b=dSTdknYGDoXbfORmyNIti27Dr+LEGkK/16ybISe+u+XGLkto+wJPPLgKb3ibmpVPdBDU81V5ITVO7D9jadBFeiEZti0xcxomMHMlG67DoLttZRojY68cqIwLafRHScmsrCLacp5F5C4r1h4Y+qNv+QLRSwDvGAgOzVY0Y59GZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825419; c=relaxed/simple;
	bh=eGt8cEzUOUnC8smyg5wsy0R9ZyB5SWf7wZVjyoxAkn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuECqFsylfdygK7RexvXcYwul65u9LgZXT6T9zLbJRBUpa97rp+HMqeAWj/H9TRD1o1UesGeHIrdKwvOoK3yidggRq84qK1IVerj2+0NLcV2NMiZCDv6BBY21Rtb0h3ucRLw28JWpbbdHSuxYV61k2fW2iFhzKnX8QS3xixqNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o9LGNexC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759825416;
	bh=eGt8cEzUOUnC8smyg5wsy0R9ZyB5SWf7wZVjyoxAkn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o9LGNexCyQx4dW/lglAuDC1dXXWO+D8PiuXaY8juL42ZrUZ1xGP7CAyK0DwRaG3z0
	 lVux3wg6jxkEEd51JEDWuhZ7Oo2dKsHZWYKlIN4pv1WSFz60lmbbKUcYUk7ItJCJ2g
	 hlOlplTGcvQM/BUC+qvBtG9MZpcWzLJa7D3wXfMJZUYnmslINsFv3JEUPw+9lyRMr8
	 LChIA80gRZsrqP1L7d3eFmLR1M+lhpSNcQRx5ox1uCLoE4aNa8zqZuBILjYunqGEoq
	 ku0fU+Z8AxPh6Jm5zLpasSbuk4FNVUiwgZojM7CVRLJH/g9P3kk7qicDBzz01eqLLD
	 cm77lHT5nm2Jg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9831417E0A28;
	Tue,  7 Oct 2025 10:23:35 +0200 (CEST)
Date: Wed, 28 Aug 2024 19:27:43 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Christopher Healy <healych@amazon.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <20240828192743.55e3107f@collabora.com>
In-Reply-To: <20240828180703.4510a4e2@collabora.com>
References: <20240807153553.142325-2-mary.guillemard@collabora.com>
	<327a3440-8d01-4787-83be-a00fbbe0b593@arm.com>
	<20240828140929.5c602436@collabora.com>
	<c38324e4-055f-44b5-beb4-6b3e6b860e69@arm.com>
	<20240828180703.4510a4e2@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZM-MESSAGEID: 1724866063694134900

On Wed, 28 Aug 2024 18:07:03 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 28 Aug 2024 14:22:51 +0100
> Mihail Atanassov <mihail.atanassov@arm.com> wrote:
> 
> > Hi Boris,
> > 
> > On 28/08/2024 13:09, Boris Brezillon wrote:  
> > > Hi Mihail,
> > > 
> > > On Thu, 8 Aug 2024 12:41:05 +0300
> > > Mihail Atanassov <mihail.atanassov@arm.com> wrote:
> > >     
> > >>>
> > >>> +/** + * struct drm_panthor_timestamp_info - Timestamp information +
> > >>> * + * Structure grouping all queryable information relating to the
> > >>> GPU timestamp. + */ +struct drm_panthor_timestamp_info { +	/**
> > >>> @timestamp_frequency: The frequency of the timestamp timer. */ +
> > >>> __u64 timestamp_frequency; + +	/** @current_timestamp: The current
> > >>> timestamp. */ +	__u64 current_timestamp;    
> > >>
> > >> As it stands, this query has nothing to do with the actual GPU so
> > >> doesn't really belong here.
> > >>
> > >> It'd be more valuable, and can maybe give better calibration results
> > >> than querying the system timestamp separately in userspace, if you
> > >> reported all of:
> > >>    * the system timer value
> > >>    * the system timer frequency
> > >>    * the GPU timer value
> > >>    * the GPU timer frequency (because it _could_ be different in some
> > >> systems)    
> > > 
> > > Duh, I wish this wasn't the case and all SoC vendors went for the
> > > arch-timer which guarantees the consistency of the timestamp on the GPU
> > > and CPU. But let's say this is a case we need to support, wouldn't it
> > > be more useful to do the CPU/GPU calibration kernel side (basically at
> > > init/resume time) and then expose the formula describing the
> > > relationship between those 2 things:
> > > 
> > > CPU_time = GPU_time * GPU_to_CPU_mul / GPU_to_CPU_div +
> > > 	   GPU_to_CPU_offset;
> > >     
> > 
> > TIMESTAMP_OFFSET should indeed be set by the kernel (on resume). But I 
> > don't think we need to post M/D+offset to userspace. The 2 Frequencies + 
> > the scalar offset are the raw sources, and userspace can work back from 
> > there.  
> 
> Sure. No matter how you express the relationship, my point was, if the
> calibration is supposed to happen in the kernel at resume time,
> returning both the CPU/GPU time in DEV_QUERY_TIMESTAMP to make sure the
> sampling is close enough that they actually represent the same
> timestamp might not be needed, because you can easily convert from one
> domain to the other.

I think it makes more sense after reading [1] :-). This being said, the
maxDeviation is here to account for any latency that might exists
between each domain sampling, so I'd be tempted to read the CPU
monotonic time through the regular syscalls rather than add it to the
DEV_QUERY_TIMESTAMP ioctl.

[1]https://docs.vulkan.org/features/latest/features/proposals/VK_EXT_calibrated_timestamps.html

