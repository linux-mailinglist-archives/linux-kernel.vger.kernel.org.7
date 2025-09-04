Return-Path: <linux-kernel+bounces-800607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52907B439C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A399D7C284F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFDA2F3607;
	Thu,  4 Sep 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="MagfS2PS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAC2C11D9;
	Thu,  4 Sep 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984841; cv=pass; b=TMdY6Skh9c9+hm1KNeBUPPID+WxOrptaP6ODJlY6wblVuVAWI4iA0uIrq0KfuSLLP6jIUV298bfiVSDvCXeJE5WubSfSzHASoS364/s4MN2DJusygdXhU7pOml6Jff4d+tfADF/47DCds4ZDER3gpoPCKtEb1BJD+7AXsaShHf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984841; c=relaxed/simple;
	bh=W26UsDH0BV/wCKS/lfeO18I0Lj471t9sIJ1iolTpfb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgOswAEQPAPEEsJd5q64iQSkStJH7gFwiTWK3BIQmJV8WOgFsWIGh4mdNs7pxO1bdDP7EXAjMLnJcdGXJ0P4ai8lyJwTmiCuXGzp40J2amC8R7E0GFW1MEqMyN10jM8IRIOWW5qokMsQZ55KD7mJrQNWV8U74ddatZk56pNLjW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=MagfS2PS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756984821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nji4AYju6G0mt3NzQJwL2Rr2cAdxJ+LjeENAFu3XCnU0r+NC5+mUFVDPL+3NPdQ7chGfwt3ArL3AFc6NMksLdIf5DAdQvJT+u02aTrnnwU1gooxeHhWot0KoiRW8EJoPgZtJecjQC4CXjIZEnJUF8BUx0+W0ghXNXrlXsNIxQvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756984821; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/TtV5w9SklmHnKG5J7AZb+JOmSQbgWRInJV7KaTISYs=; 
	b=JRu/0NgFyGoAU63KwvB1aeN+YRnONpizSn53j9oE1FwQsrVXIb67C72fYSroXUNAV29AppNQRuhp7iusYddtQ1EqwOMU4u7HK0YGgauUMf2anG1PIW/TsRxiOQgvotaJGZVHOgMdBenKGX+zWnhgjuK9hGdxRZKdJWja0F9W5sM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756984821;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To:Cc;
	bh=/TtV5w9SklmHnKG5J7AZb+JOmSQbgWRInJV7KaTISYs=;
	b=MagfS2PSOiTr18ZnP+oxdKhZ067YCtKThK4WRuvcx6s3kSqzQRkt3a1qR98VYRu6
	2H2MmEnvNuU+5HIi7O6nXyH7fCUlE8xTYPOQGQ08W+ZBiP5iOGCBmoJnH77kuHr0ipr
	mII6diVyPGXSdzlhhP3AH7tlZh0o/hK6jaqL3MHU=
Received: by mx.zohomail.com with SMTPS id 1756984818875807.4425046459023;
	Thu, 4 Sep 2025 04:20:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [RFC PATCH 0/2] drm/panthor: initial mt8196 support
Date: Thu, 04 Sep 2025 13:20:12 +0200
Message-ID: <5820885.GXAFRqVoOG@workhorse>
In-Reply-To: <20250903225504.542268-1-olvaffe@gmail.com>
References: <20250903225504.542268-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

On Thursday, 4 September 2025 00:55:02 Central European Summer Time Chia-I Wu wrote:
> MediaTek MT8196 has Mali-G925-Immortalis, for which panthor gained
> support recently. But the soc also requires custom ASN hash to be
> enabled. This series introduces panthor_soc_data for per-soc data and
> uses it to enable custom ASN hash on MT8196.
> 
> The clk/regulator provider on MT8196 is GPUEB, whose driver[1] needs to
> be cleaned up and upstreamed separately.

I'm currently working on this, I'm at a functional 800 LoC driver vs the
more than 30k LoC of the downstream... thing. I intend to send it in as
an RFC once the clock stuff lands, and I get some responses wrt to
figuring out what's still missing from linux-next aside from the DT to
get basic boot working so that I don't send in something that I
accidentally shredded during a rebase without noticing.

Cleaning up the downstream driver is a fool's errand, it's like 6?
separate drivers, with lots of global state (and no locking), without
using the common clock framework, and relying on abusing -supply DT
properties to force a certain probe order to make all the race
conditions it would otherwise have turn out fine. A lot of it is
code that seems dead, or wrappers wrapping wrappers that have nothing
to do with how the hardware actually works.

My solution adds a small mailbox driver for the GPUEB, and also adds
a new module that lives in the panthor tree and registers itself with
panthor's devfreq stuff to be a "devfreq provider". The motivation
for making it devfreq instead of a clock+regulator provider is that
the GPUEB seems to have several quite devfreq-like parts to it that
I am not yet using, namely setting a job completion target time and
several methods of limiting performance.

As it stands it can set the OPP, but boosting above 1.43 GHz does
not seem to stick. The boosting stuff may be done by the four or
five other ways it has to set some frequency target.

I'm hoping I can send this in maybe next week or the week after. If
things remain blocked by then it'll be compile-tested in its current
form only and lack some clock stuff.

Kind regards,
Nicolas Frattaroli

> 
> This initial support also lacks support for some hw configs. On some
> configs, panthor is expected to query a mask from efuse to mask out
> unavailable shader cores from ptdev->gpu_info.shader_present. This
> requires extending panthor_soc_data with a callback to read the mask.
> 
> This is an RFC because the dependent drivers are not ready yet. But I
> would like to gather opinions on having panthor_soc_data for
> soc-specific data and having CONFIG_DRM_PANTHOR_SOC_MT8196 for
> soc-specific code.
> 
> [1] https://gitlab.freedesktop.org/olv/kernel/-/commit/170d5fc90f817dc90bde54b32872c59cf5c77779
> 
> Chia-I Wu (2):
>   dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
>   drm/panthor: add initial mt8196 support
> 
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    |  1 +
>  drivers/gpu/drm/panthor/Kconfig               |  6 +++++
>  drivers/gpu/drm/panthor/Makefile              |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.c      |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.h      |  4 +++
>  drivers/gpu/drm/panthor/panthor_drv.c         |  4 +++
>  drivers/gpu/drm/panthor/panthor_gpu.c         | 26 ++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
>  drivers/gpu/drm/panthor/panthor_soc.h         | 26 +++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_soc_mt8196.c  |  9 +++++++
>  10 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_soc.h
>  create mode 100644 drivers/gpu/drm/panthor/panthor_soc_mt8196.c
> 
> 





