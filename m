Return-Path: <linux-kernel+bounces-740505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670DB0D50B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E481C244FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDD2D97A9;
	Tue, 22 Jul 2025 08:56:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F792D9497
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174561; cv=none; b=fzI4iUAneK1Fdlp5uYsAxaUWc+42JqE4D+blsi7PeaSohFNahxTwIkNe21G4XkT2PCnu5wK0jPiOYmHSlUZbfr2SnD1OhbfvfuS/BXHVVWb9JCAhJku/q3RXwHRCP3cgb5eNptlCZX0lVB+9sG4SMotq5DdOMYnI++eNh87unMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174561; c=relaxed/simple;
	bh=s0J+ssL0OGtRm/HV9JGbxizeCnhuuijegazWnFBNyQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVGa8yGHmGk7cHQ+XDqhh0nH5sVMvd67Cb9si/+ZSsoYlKGIm1vqsEuaz/qWlhDMbDjdEXO7NgjAhChLUq3wHsSCTzh6KP/5ulGuCHkKHJH9i0hFtt25NbxlYX0IXGWsCe0eihe9cqKUhtZsAvEFn9ZWyGTG8w6+WDYADaOB8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9702D152B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:55:53 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1E5B3F66E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:55:58 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:55:46 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Erik Faye-Lund <erik.faye-lund@collabora.com>
Cc: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
	nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/panthor: Add support for Mali-G710, Mali-G510
 and Mali-G310
Message-ID: <aH9SEno547vpIJxy@e110455-lin.cambridge.arm.com>
References: <20250721111344.1610250-1-karunika.choo@arm.com>
 <20250721111344.1610250-4-karunika.choo@arm.com>
 <abc0eae5319ed14409c88baab3160b7aed2061b2.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abc0eae5319ed14409c88baab3160b7aed2061b2.camel@collabora.com>

On Tue, Jul 22, 2025 at 10:29:21AM +0200, Erik Faye-Lund wrote:
> On Mon, 2025-07-21 at 12:13 +0100, Karunika Choo wrote:
> > This patch adds GPU model name and FW binary support for Mali-G710,
> > Mali-G510, and Mali-G310.
> > 
> > Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 2 ++
> >  drivers/gpu/drm/panthor/panthor_hw.c | 6 ++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c
> > b/drivers/gpu/drm/panthor/panthor_fw.c
> > index 36f1034839c2..b7b454d16f12 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1402,3 +1402,5 @@ int panthor_fw_init(struct panthor_device
> > *ptdev)
> >  }
> >  
> >  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
> > +MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
> > +MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
> 
> This isn't a problem with this series per-se, but these (as well as the
> ones you're adding in later commits here) are all missing from here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/arm/mali
> 
> Any plans on upstreaming these so people without DDK access can
> actually try these patches?

If you want to try the patches the cover letter has the link for the binaries.
Once we're happy with the patches I will send a pull request to linux-firmware for the binaries.

Best regards,
Liviu

> 
> > diff --git a/drivers/gpu/drm/panthor/panthor_hw.c
> > b/drivers/gpu/drm/panthor/panthor_hw.c
> > index f39010c0ca86..7f138974d43b 100644
> > --- a/drivers/gpu/drm/panthor/panthor_hw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> > @@ -15,8 +15,14 @@ static char *get_gpu_model_name(struct
> > panthor_device *ptdev)
> >  						GPU_PROD_MAJOR(gpu_i
> > d));
> >  
> >  	switch (product_id) {
> > +	case GPU_PROD_ID_MAKE(10, 2):
> > +		return "Mali-G710";
> >  	case GPU_PROD_ID_MAKE(10, 7):
> >  		return "Mali-G610";
> > +	case GPU_PROD_ID_MAKE(10, 3):
> > +		return "Mali-G510";
> > +	case GPU_PROD_ID_MAKE(10, 4):
> > +		return "Mali-G310";
> >  	}
> >  
> >  	return "(Unknown Mali GPU)";

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

