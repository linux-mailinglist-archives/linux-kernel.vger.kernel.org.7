Return-Path: <linux-kernel+bounces-848050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB3BCC5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A38835512F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC3271A7B;
	Fri, 10 Oct 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bk6+g3YK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265526E6F8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088707; cv=none; b=pqchx6Lv7T8ewQshCsOchdLbjh7Qj9cyHXXgocvlr1b1XwUbRFGAGDdj88uf3GcctyhbcCy9d2wwrKAECTv3yzfpohaJudEXJh49IJbHawEBhKxduix7intFv08JOCkkL2lu/ophHCpcLwacXIEpu/ANGzrk6Msr5hJKQ9OuUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088707; c=relaxed/simple;
	bh=9SG9MfMh9cU3sLQ9N+U2VcoFk/gaHuh7G5vb2XTyEsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcsTrysxxILo3QOypf69xcd9yG6pe9x22+ogYm/y6nBU87uQjx9SlrSoVSLYM5lUAmjfAqcXNdP/flCqHU/v/yMCSXZ7sirqsIR+8I07yf8crAVElgfsEg52PBLxX4BUkQwaBetPU/+yOrg1ctew/XM7jeZuu8mxdh+BfVQ8Yog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bk6+g3YK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760088703;
	bh=9SG9MfMh9cU3sLQ9N+U2VcoFk/gaHuh7G5vb2XTyEsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bk6+g3YKfbe0t+0IWYGKF7sMSEPeW2pRNi6aNJh5j8QHcsixq/vpVM3b4XSYCNnr5
	 Q+iKwa477RT7u3XN5ErSzt2Zm+7knrLtxjv75CRW303r6sQh6pNmofkVMwbdOzFe+j
	 mY5u9axHe5C9k54pZJnJD6UXLRk608gyyFic4/yKl5DzzWzli8vJFd2rRy4pe4OZ5X
	 eWZKutGmGce3vZBkXmct1BZU78OYa7LywO1EBAJ/haGERXIsN3TKCh5KmO4A4uLma3
	 CkR+SouiJQEP+Km5NrbcNSiircUSzGm+iIUtDJ4G8YovaMpRuZSjRZ2ZWLgF9ABwb3
	 yrrRvJH+vKqdQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F6DC17E013C;
	Fri, 10 Oct 2025 11:31:43 +0200 (CEST)
Date: Fri, 10 Oct 2025 11:31:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 prabhu.sundararaj@nxp.com, simona@ffwll.ch, steven.price@arm.com,
 tzimmermann@suse.de, xianzhong.li@nxp.com
Subject: Re: [PATCH] drm/panthor: attach the driver's multiple power domains
Message-ID: <20251010113138.719d431f@fedora>
In-Reply-To: <aOjOjFVGb8MLjvYI@oss.nxp.com>
References: <20251009140039.101189-1-jiyu.yang@oss.nxp.com>
	<20251009160820.74f04ead@fedora>
	<20251009160929.1b36b9ea@fedora>
	<aOfPaQWIVzMaWlSl@oss.nxp.com>
	<20251009172320.6a2cbf55@fedora>
	<aOjOjFVGb8MLjvYI@oss.nxp.com>
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

Hello Rain,

On Fri, 10 Oct 2025 17:14:52 +0800
Rain Yang <jiyu.yang@oss.nxp.com> wrote:

> On Thu, Oct 09, 2025 at 05:23:20PM +0200, Boris Brezillon wrote:
> >On Thu, 9 Oct 2025 23:06:17 +0800
> >Rain Yang <jiyu.yang@oss.nxp.com> wrote:
> >  
> >> On Thu, Oct 09, 2025 at 04:09:29PM +0200, Boris Brezillon wrote:  
> >> >On Thu, 9 Oct 2025 16:08:20 +0200
> >> >Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >> >    
> >> >> On Thu,  9 Oct 2025 22:00:39 +0800
> >> >> Rain Yang <jiyu.yang@oss.nxp.com> wrote:
> >> >>     
> >> >> > From: Rain Yang <jiyu.yang@nxp.com>
> >> >> > 
> >> >> > Some platforms, such as i.MX95, utilize multiple power domains that need
> >> >> > to be attached explicitly. This patch ensures that the driver properly
> >> >> > attaches all available power domains using devm_pm_domain_attach_list().
> >> >> > 
> >> >> > Signed-off-by: Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
> >> >> > Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> >> >> > ---
> >> >> >  drivers/gpu/drm/panthor/panthor_device.c | 6 ++++++
> >> >> >  drivers/gpu/drm/panthor/panthor_device.h | 2 ++
> >> >> >  2 files changed, 8 insertions(+)
> >> >> > 
> >> >> > diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> >> >> > index f0b2da5b2b96..6f40d053b16c 100644
> >> >> > --- a/drivers/gpu/drm/panthor/panthor_device.c
> >> >> > +++ b/drivers/gpu/drm/panthor/panthor_device.c
> >> >> > @@ -218,6 +218,12 @@ int panthor_device_init(struct panthor_device *ptdev)
> >> >> >  	if (ret)
> >> >> >  		return ret;
> >> >> >  
> >> >> > +	ret = devm_pm_domain_attach_list(ptdev->base.dev, NULL, &ptdev->pd_list);
> >> >> > +	if (ret < 0) {
> >> >> > +		drm_err(&ptdev->base, "attach power domains failed, ret=%d", ret);
> >> >> > +		return ret;
> >> >> > +	}
> >> >> > +
> >> >> >  	ret = panthor_devfreq_init(ptdev);
> >> >> >  	if (ret)
> >> >> >  		return ret;
> >> >> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> >> >> > index 4fc7cf2aeed5..5ecb541ec67b 100644
> >> >> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> >> >> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> >> >> > @@ -196,6 +196,8 @@ struct panthor_device {
> >> >> >  		/** @recovery_needed: True when a resume attempt failed. */
> >> >> >  		atomic_t recovery_needed;
> >> >> >  	} pm;      
> >> >> 
> >> >> Add a blank line here.
> >> >>     
> >> >> > +	/** @pm: Power management related data. */    
> >> >
> >> >Also, the comment is wrong, and it would probably make sense to move
> >> >that to the pm sub-struct since this is PM related.    
> >> thanks, will fix it next version.  
> >> >    
> >> >> > +	struct dev_pm_domain_list  *pd_list;
> >> >> >        
> >> >> 
> >> >> Do we even need to keep the pd_list in panthor_device if we don't do
> >> >> anything with it?    
> >> The second power domain is typically used for frequency scaling. The driver
> >> works fine when there's only one single power domain. That said, I will update
> >> the implementation to attach multiple power domains only when the domain count
> >> is greater than one.  
> >
> >That's not what I meant. What I mean is that the
> >panthor_device::pd_list is never used, because the extra power domains
> >get attached to the struct device directly, and the PM core
> >automatically enables all PDs on resume and disable them on suspend.
> >Because it's a devm_ function, you don't need it to detach the pd_list
> >at ::remove() time either. TLDR; that means you can pass
> >devm_pm_domain_attach_list() a local pd_list instead of ptdev->pd_list
> >and you can thus drop panthor_device::pd_list altogether, I think.
> >
> >If you intend to use the pd_list for manual PD control in panthor in a
> >follow-up patchset, this should be mentioned in the commit message.  
> thanks for your suggestion, pd_list will be allocated by devm_kmalloc.

There's no extra allocation needed. Just do:

	struct dev_pm_domain_list  *pd_list;

	...
	
	ret = devm_pm_domain_attach_list(ptdev->base.dev, NULL, &pd_list);
	if (ret < 0) {
		drm_err(&ptdev->base, "attach power domains failed, ret=%d", ret);
		return ret;
	}

and that's it.

> 
> I have not found a general solution to modify the frequency via SCMI perf
> and OPP framework except the manual PD control, I'd appreciate it if
> there is any idea.

What's the manual PD control you're talking about? I don't see
anything using the pd_list in this patch. Is there another patchset
on top of this one that you haven't posted yet? Dunno if that's of
any help, but this patchset [1] might give you some ideas.

Regards,

Boris

[1]https://lwn.net/Articles/1040831

