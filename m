Return-Path: <linux-kernel+bounces-758132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82301B1CB68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A2316D83F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A5290D8E;
	Wed,  6 Aug 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HtZOn+GY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456E5CDF1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502448; cv=pass; b=Fzx3m/nq/LOwOWAlFZ/8zFHKJV+N5vUh45yxke3tJNtJ6ESFDICgUxGjSzexK8e7mrrZscJ2hbqlO1zvd3yeaIn4N99doU2wx2Ks5Np9hRIVoPknGGiRS5ypl/rVJwjmMT3ebUusw63gCFXDW66w+nzCaMxJgeXOrnj8A3yG2rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502448; c=relaxed/simple;
	bh=PEOGVHK7OD9q+pK+s5sOREkjTYbUei4afvBOf+sivJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdD/+z++mw2XyFH1FGHd4+XCaCq1OynLJZGYuJRF+S8iPccRJka04bPW/jbBmq54D88ZXsYmIo/FTOer8mo1FsAi6i8fYqS81pH1UrcbWwHhCCRY+gnX6JlB+UsqYjJH4WDv2EMMvzVEewng9wEel9UWE8n8vpa7uWocLcfMSHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=HtZOn+GY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754502422; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KLMAIdvUqfa70pBe05YhQm0mRjjFqmsVztFulhEresiqWJ4rrMbEWWcqaTwPrkP9pFRPVSEEgtIAIT+Z5+WpamWuM8oj0/bAj9QWhBCZrGMQ88yFKdwRiOQbJ6I5eSp1ui+2yiuvT09ljasI9G9QjHYyUVotqfWTzGRaLH4UeoU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754502422; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0rZH6ywPZCM11FRS5p1tLtZwrwgINsb0Kn0e8UzL74c=; 
	b=UZ2SF0ZlbQcf/8BH+xwd0uaUd6+RwYuqe59KbxjLw+GXvygyWneDYcmv1J4vnaY/s+8eq3WhQMpg4G7doyGy0NBvXyhNkicRJ3txguMNnNyHLo/YVn7cAGsJAjiiLh4k0A8YIEAFaZdDagNglaWARtrAwrw9oAY/RVOiCZ53Lio=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754502422;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=0rZH6ywPZCM11FRS5p1tLtZwrwgINsb0Kn0e8UzL74c=;
	b=HtZOn+GYpHIbsd/zRkznGTO4gM6QocfzqpTCEiiJWalTQ2ulmuFQIwFXQyOhfRhq
	WRVN521S19F+BwJZOToSRNpGXYUaGgTjF/8NPoSmViPLhuMOeOqBW1UWXL8Fqz16ml6
	/3Qq513ln9aSszn9C/9MKK82OCWjvExaDGwZzEeo=
Received: by mx.zohomail.com with SMTPS id 1754502421337713.6481254788936;
	Wed, 6 Aug 2025 10:47:01 -0700 (PDT)
Date: Wed, 6 Aug 2025 18:46:56 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/panfrost: Print RSS for tiler heap BO's in debugfs
 GEMS file
Message-ID: <j7x47m2hpo3fgatuoryefkuqk7ijv32ztc63kxfjgud2ng3u3b@yipnrnby5cuz>
References: <20250731173534.3494324-1-adrian.larumbe@collabora.com>
 <CAPj87rPrGX2c3RQKJ6NxGYWbzbNp-9zCC=twCN4OLcD4aXcuHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rPrGX2c3RQKJ6NxGYWbzbNp-9zCC=twCN4OLcD4aXcuHg@mail.gmail.com>

On 06.08.2025 16:19, Daniel Stone wrote:
Hi Adrián,

On Thu, 31 Jul 2025 at 18:36, Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
> > @@ -432,7 +432,8 @@ static void panfrost_gem_debugfs_bo_print(struct panfrost_gem_object *bo,
> >         if (!refcount)
> >                 return;
> >
> > -       resident_size = bo->base.pages ? bo->base.base.size : 0;
> > +       resident_size = bo->base.pages ?
> > +               (bo->is_heap ? bo->heap_rss_size : bo->base.base.size) : 0;
>
> Just use panfrost_gem_rss() here, though you'll need to make it non-static.

It's still within the same compilation unit (panfrost_gem.c) so it can remain static.

>
> With that:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
>
> Cheers,
> Daniel

Adrian Larumbe

