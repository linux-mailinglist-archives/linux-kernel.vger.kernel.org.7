Return-Path: <linux-kernel+bounces-871413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC7C0D2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A0C3A9B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B262F7ADB;
	Mon, 27 Oct 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YFnS2ywz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D49220694
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565014; cv=none; b=NqxPuu6Jdks8BPEorF1ksHaLdv1s8p1Mqx8EHNf0NrE/I8rimYjJEWCWSJqE+DrJaQt5R6BCDacGq+InMt9taa5ePK8KdvXHjVKNwOKwXuX839nLkVZdL28ZcyaEbOZCr1X4RsJ1XWQgg2MkkPEcGDnXqSzsOVPEcBeJOQPpIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565014; c=relaxed/simple;
	bh=584a4V7A0teLQbtFCVuKn+vPFu3wI1RrRXSg8EXz918=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzdapnli/cEwzF+12n9HhFWYfDW0C/ciIlOqIXa5gOTBNJl0F1hZQY724uIcdXvXiWMpzxGtr7bhVUeBdsnVoZ0FQwKmNpprTpIGIQgl2rACRuEPHsokYp77JqPdA7iXs3JOSKdP2qNWW/cFBPVapc3lL9qiH1gL0lNVf7X5p1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YFnS2ywz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761565010;
	bh=584a4V7A0teLQbtFCVuKn+vPFu3wI1RrRXSg8EXz918=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFnS2ywzK4DX+IP7buG2LbhGiT6MlHEBQhplynbXE9ygylUVRdDGAXahpLpfIblb6
	 fZQ8vYBeELDsG9bEdNcvmHx7cexv9oovNrH2jc64ZJbJwxccKHE6R5viiFaur2jKMZ
	 DMNH0SpyOXwQiPtfgsMQluBXYv1Vpf4mz1o1k9PkoDqQMnn/ZRSUkaHkHSbo/wcIDr
	 sBAqpNeWi+MjkqrMb+utNalPIOh18epJ4eEit/BZXwDnzyYAtixCSjHjEX7Jp2SMbP
	 W1jaUinWdEt1nug+zB7qtQJqe4pY+17aOLgVUhM1pd5tkpdm+3YMkPNOytZX4f9bjf
	 MG6H/6QnScAsw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0331917E10F4;
	Mon, 27 Oct 2025 12:36:49 +0100 (CET)
Date: Mon, 27 Oct 2025 12:36:45 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] drm/panthor: Introduce panthor_pwr API and power
 control framework
Message-ID: <20251027123645.7f3879ba@fedora>
In-Reply-To: <4cea5fa2-83da-4620-aa4a-97a6378f62f8@arm.com>
References: <20251024202117.3241292-1-karunika.choo@arm.com>
	<20251024202117.3241292-4-karunika.choo@arm.com>
	<20251026091310.4046f061@fedora>
	<4cea5fa2-83da-4620-aa4a-97a6378f62f8@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 10:36:13 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> On 26/10/2025 08:13, Boris Brezillon wrote:
> > On Fri, 24 Oct 2025 21:21:12 +0100
> > Karunika Choo <karunika.choo@arm.com> wrote:  
> >> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> >> index 092962db5ccd..09aef34a6ce7 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> >> @@ -192,3 +192,8 @@ int panthor_hw_init(struct panthor_device *ptdev)
> >>
> >>  	return 0;
> >>  }
> >> +
> >> +bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
> >> +{
> >> +	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
> >> +}
> >> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> >> index 2665d6dde2e3..4c71f27d1c0b 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> >> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> >> @@ -32,4 +32,6 @@ struct panthor_hw {
> >>
> >>  int panthor_hw_init(struct panthor_device *ptdev);
> >>
> >> +bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev);  
> > 
> > Let's make this a static inline function so the compiler can inline its
> > content at compile time.
> >   
> 
> I wonder if making it static inline is a good idea. We will need to move
> this function into panthor_device.h to be able to do so as we need to
> access the panthor_device structure. Would this still be desirable?

Can't we just include panthor_device.h from panthor_hw.h instead? As
far as I can tell, panthor_device.h doesn't include panthor_hw.h, so we
should be fine.

