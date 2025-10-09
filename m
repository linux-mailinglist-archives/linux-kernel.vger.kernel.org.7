Return-Path: <linux-kernel+bounces-847046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A58BC9BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F184334FA44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE871DED57;
	Thu,  9 Oct 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k3igkG6G"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F71DE4C4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023410; cv=none; b=mkn2Q7CothO+do4204TaQ2jp7RP15bewfnPOewDIdepB+Ad07AwvQUdWioMZ8RVP1f2cOTzvH1zbH2/CtC3/vV1xH5gxIUZoTCZZkt1axcjDC1YTOKo+oopavwuUpAflfj/7GBife8nlb+JtAAxijtgTRgZBezc6Cg2gtsT10o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023410; c=relaxed/simple;
	bh=fABUvVjWguE7ZAc9zmpVNOJs87WzajiLPsaFUvRx/YE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l21hHT4UqIsB7bk1OSpPk1RnjOJ1CIaJmS7uspQcKGniZVepghze1LqidhFy/8jbbtxG/IePg/T894F1DPme5x0dOvxH3a8L+UkvpA5nBwmkR+GU6mf/L15VrmKVaeed6lXZ14gA95UoUe+tlqKGToXgYkC8uPvuVobsrlzE/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k3igkG6G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760023405;
	bh=fABUvVjWguE7ZAc9zmpVNOJs87WzajiLPsaFUvRx/YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3igkG6GNAPCtAPJTHo7O59kj7/IKadIvAuGEDLLNwEnaVnvt2GAMveHPvyLkevsd
	 dYv4W+I47pvkIFqp/l/WUrsVokgl/NTG4Qja8Xvpc9r6U3FiwatBdcRmmCI1Bry+OF
	 Ld4J5JtjtYLvm1mWNhXIJO+QsLJg4YhqrP5o1OI2vELYCq5HH+0BNYVU1ZOMKSYNCG
	 cTbrURKVDHDrmc+qBsQ2qVB6pec+nG1wYUk1kIovY/MIvSi4lfpnhoVz82x291SuqW
	 dQC6OxVpBm2RAKikphTMVhyXnYzTAYrr6XN5TRqRZVONlscG8xy1EQt6uAlHuAgo9v
	 3GnePNHjZmSQQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD76F17E108C;
	Thu,  9 Oct 2025 17:23:24 +0200 (CEST)
Date: Thu, 9 Oct 2025 17:23:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 prabhu.sundararaj@nxp.com, simona@ffwll.ch, steven.price@arm.com,
 tzimmermann@suse.de, xianzhong.li@nxp.com
Subject: Re: [PATCH] drm/panthor: attach the driver's multiple power domains
Message-ID: <20251009172320.6a2cbf55@fedora>
In-Reply-To: <aOfPaQWIVzMaWlSl@oss.nxp.com>
References: <20251009140039.101189-1-jiyu.yang@oss.nxp.com>
	<20251009160820.74f04ead@fedora>
	<20251009160929.1b36b9ea@fedora>
	<aOfPaQWIVzMaWlSl@oss.nxp.com>
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

On Thu, 9 Oct 2025 23:06:17 +0800
Rain Yang <jiyu.yang@oss.nxp.com> wrote:

> On Thu, Oct 09, 2025 at 04:09:29PM +0200, Boris Brezillon wrote:
> >On Thu, 9 Oct 2025 16:08:20 +0200
> >Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >  
> >> On Thu,  9 Oct 2025 22:00:39 +0800
> >> Rain Yang <jiyu.yang@oss.nxp.com> wrote:
> >>   
> >> > From: Rain Yang <jiyu.yang@nxp.com>
> >> > 
> >> > Some platforms, such as i.MX95, utilize multiple power domains that need
> >> > to be attached explicitly. This patch ensures that the driver properly
> >> > attaches all available power domains using devm_pm_domain_attach_list().
> >> > 
> >> > Signed-off-by: Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
> >> > Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> >> > ---
> >> >  drivers/gpu/drm/panthor/panthor_device.c | 6 ++++++
> >> >  drivers/gpu/drm/panthor/panthor_device.h | 2 ++
> >> >  2 files changed, 8 insertions(+)
> >> > 
> >> > diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> >> > index f0b2da5b2b96..6f40d053b16c 100644
> >> > --- a/drivers/gpu/drm/panthor/panthor_device.c
> >> > +++ b/drivers/gpu/drm/panthor/panthor_device.c
> >> > @@ -218,6 +218,12 @@ int panthor_device_init(struct panthor_device *ptdev)
> >> >  	if (ret)
> >> >  		return ret;
> >> >  
> >> > +	ret = devm_pm_domain_attach_list(ptdev->base.dev, NULL, &ptdev->pd_list);
> >> > +	if (ret < 0) {
> >> > +		drm_err(&ptdev->base, "attach power domains failed, ret=%d", ret);
> >> > +		return ret;
> >> > +	}
> >> > +
> >> >  	ret = panthor_devfreq_init(ptdev);
> >> >  	if (ret)
> >> >  		return ret;
> >> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> >> > index 4fc7cf2aeed5..5ecb541ec67b 100644
> >> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> >> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> >> > @@ -196,6 +196,8 @@ struct panthor_device {
> >> >  		/** @recovery_needed: True when a resume attempt failed. */
> >> >  		atomic_t recovery_needed;
> >> >  	} pm;    
> >> 
> >> Add a blank line here.
> >>   
> >> > +	/** @pm: Power management related data. */  
> >
> >Also, the comment is wrong, and it would probably make sense to move
> >that to the pm sub-struct since this is PM related.  
> thanks, will fix it next version.
> >  
> >> > +	struct dev_pm_domain_list  *pd_list;
> >> >      
> >> 
> >> Do we even need to keep the pd_list in panthor_device if we don't do
> >> anything with it?  
> The second power domain is typically used for frequency scaling. The driver
> works fine when there's only one single power domain. That said, I will update
> the implementation to attach multiple power domains only when the domain count
> is greater than one.

That's not what I meant. What I mean is that the
panthor_device::pd_list is never used, because the extra power domains
get attached to the struct device directly, and the PM core
automatically enables all PDs on resume and disable them on suspend.
Because it's a devm_ function, you don't need it to detach the pd_list
at ::remove() time either. TLDR; that means you can pass
devm_pm_domain_attach_list() a local pd_list instead of ptdev->pd_list
and you can thus drop panthor_device::pd_list altogether, I think.

If you intend to use the pd_list for manual PD control in panthor in a
follow-up patchset, this should be mentioned in the commit message.

> >>   
> >> >  	/** @profile_mask: User-set profiling flags for job accounting. */
> >> >  	u32 profile_mask;    
> >>   
> >  


