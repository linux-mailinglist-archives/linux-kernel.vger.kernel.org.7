Return-Path: <linux-kernel+bounces-846923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1CBC970F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520A33E7F14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A162EA16A;
	Thu,  9 Oct 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pk3zf2dv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA872E9759
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018980; cv=none; b=py5CGB8E0ujakPeY4Lf4kVW5gmpO+K/Z7y1D+TGwCbP9yrCXe5BsUVBr4TbluLLhn+pkqvqf8+ZsxZyVOymBaDOy5BwN5TLR9E033bsZQVNN+LQALW2oevjhcHb+2l+FYA/LpRaCir+9zaL1SHzgfrTm8qHPET7c2vOOXVDWvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018980; c=relaxed/simple;
	bh=j3fvdTP5LeV3hmbBm4jbLzzkKOJwia0rD/fyP8CvJbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S00TvoKWtahPHzYFCdLDp/XBih9ze4vb8mzzkTnZtWa3V0OAo8I9BXOHqY9xN3LcozZhM2ImEwBBri0i7KXacHgqQzpiMwxXOUuhefO7RUddTCd6krI6o1yphaEJjCZ2+uXwhTbM4Bad634ZWfPWYIThU3OhglsQRPdxYbNKkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pk3zf2dv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760018975;
	bh=j3fvdTP5LeV3hmbBm4jbLzzkKOJwia0rD/fyP8CvJbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pk3zf2dvmJVX4v86gul22n38Hb7RU1JIbuLBeCVCdw53zlPUbELxfdD32Bnz4XAdC
	 t+msyr8WbCe7xMN9o1o53VA1bRe8zdwWPgECP35N4TZnc0B2WrlEq3KTgzLBjR7VkZ
	 DkTIW9FhujERuTwruc2KL/BJrcVwpJZC99hptzRgoque5eVL6NAbRyAYLc4eo92SmK
	 D/4wBaKSucLHLbULlyQV3z/a0EtmEizcEXt6ocmhj2TS4sLE4psYFXkYNtJxX1mVZh
	 CDneW+VImYTHA0ZjL0VfWXKkxzXNmwxmrD5pChpblql38ciVS7Kkx5AYhWjiUVnuh9
	 QsErMH9tw3BpQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D70C17E038B;
	Thu,  9 Oct 2025 16:09:35 +0200 (CEST)
Date: Thu, 9 Oct 2025 16:09:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, steven.price@arm.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Rain Yang <jiyu.yang@nxp.com>, Prabhu
 Sundararaj <prabhu.sundararaj@nxp.com>
Subject: Re: [PATCH] drm/panthor: attach the driver's multiple power domains
Message-ID: <20251009160929.1b36b9ea@fedora>
In-Reply-To: <20251009160820.74f04ead@fedora>
References: <20251009140039.101189-1-jiyu.yang@oss.nxp.com>
	<20251009160820.74f04ead@fedora>
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

On Thu, 9 Oct 2025 16:08:20 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu,  9 Oct 2025 22:00:39 +0800
> Rain Yang <jiyu.yang@oss.nxp.com> wrote:
> 
> > From: Rain Yang <jiyu.yang@nxp.com>
> > 
> > Some platforms, such as i.MX95, utilize multiple power domains that need
> > to be attached explicitly. This patch ensures that the driver properly
> > attaches all available power domains using devm_pm_domain_attach_list().
> > 
> > Signed-off-by: Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
> > Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.c | 6 ++++++
> >  drivers/gpu/drm/panthor/panthor_device.h | 2 ++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> > index f0b2da5b2b96..6f40d053b16c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.c
> > +++ b/drivers/gpu/drm/panthor/panthor_device.c
> > @@ -218,6 +218,12 @@ int panthor_device_init(struct panthor_device *ptdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = devm_pm_domain_attach_list(ptdev->base.dev, NULL, &ptdev->pd_list);
> > +	if (ret < 0) {
> > +		drm_err(&ptdev->base, "attach power domains failed, ret=%d", ret);
> > +		return ret;
> > +	}
> > +
> >  	ret = panthor_devfreq_init(ptdev);
> >  	if (ret)
> >  		return ret;
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> > index 4fc7cf2aeed5..5ecb541ec67b 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > @@ -196,6 +196,8 @@ struct panthor_device {
> >  		/** @recovery_needed: True when a resume attempt failed. */
> >  		atomic_t recovery_needed;
> >  	} pm;  
> 
> Add a blank line here.
> 
> > +	/** @pm: Power management related data. */

Also, the comment is wrong, and it would probably make sense to move
that to the pm sub-struct since this is PM related.

> > +	struct dev_pm_domain_list  *pd_list;
> >    
> 
> Do we even need to keep the pd_list in panthor_device if we don't do
> anything with it?
> 
> >  	/** @profile_mask: User-set profiling flags for job accounting. */
> >  	u32 profile_mask;  
> 


