Return-Path: <linux-kernel+bounces-797240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BAB40DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA745E0D31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71034F47A;
	Tue,  2 Sep 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SwiRAFAq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0D1C68F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841220; cv=none; b=NmgH6OjEF5AV8cNK0Tdp3uuBho3V9UTpTbUl27CsdYsO+/J13p4y353S0GxsjWsd0PJpo/LpuE9sEbtTQI+vEgNZ1uTmrFzxgaSLenW1nFqu6XhvWmJPZ76A2qKaLjAAbaM0VYQLXzdEXkqFbXSgkkGP1qzHSRDYY8yPlXrEk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841220; c=relaxed/simple;
	bh=J8LNkrfiezQAqyBhHhwpLFw/dcn1bpXtzNnUel98Hlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLoQb+vn0s3cul7nJoEbeok/tFTH8OU49eG5UIxw0Q7gF/bcdB1GTPeCpzfzthugqAaVBk1Fx6/Rq7/TdLpAacmjHrYtEo5yYUXAWHruq9pEiLDuVbTjZRSdZEyyCPuDmM6JagnuMZPShgWS3ZqqdArfLNnX19zQU1mKnUzwus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SwiRAFAq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 57780C6D;
	Tue,  2 Sep 2025 21:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756841149;
	bh=J8LNkrfiezQAqyBhHhwpLFw/dcn1bpXtzNnUel98Hlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwiRAFAqrRavxtKZfgs+MeQA6mcZb+d591ZHk8oEJeDNKyKKrbLcXbUFzaU53/AUc
	 dEqpB8dA0EBUbSYy8iQDX1cCx/SLYltqFKeBz9FjqRzyukRGdhKEuhY2Gb3P/6YB4u
	 l/ikem4dofLn5S0Kl3cGZScngwMw+M/oqmgLUFW4=
Date: Tue, 2 Sep 2025 21:26:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/29] drm/atomic: Fix unused but set warning in
 for_each_old_private_obj_in_state
Message-ID: <20250902192636.GR13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-3-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-3-14ad5315da3f@kernel.org>

Hi Maxime,

Thank you for the patch.

On Tue, Sep 02, 2025 at 10:32:31AM +0200, Maxime Ripard wrote:
> The for_each_old_private_obj_in_state() macro triggers a compiler
> warning if the obj parameter passed to it isn't used in the code block.
> 
> Add a similar workaround than in most other macros.
> 

I'd squash this with the previous patch, and also address the other
similar macros.

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_atomic.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 689a29bdeb4a06672ab6fffecb513d58ff6e07f9..f13f926d21047e42bb9ac692c2dd4b88f2ebd91c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1112,10 +1112,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   */
>  #define for_each_old_private_obj_in_state(__state, obj, old_obj_state, __i) \
>  	for ((__i) = 0; \
>  	     (__i) < (__state)->num_private_objs && \
>  		     ((obj) = (__state)->private_objs[__i].ptr, \
> +		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
>  		      (old_obj_state) = (__state)->private_objs[__i].old_state, 1); \
>  	     (__i)++)
>  
>  /**
>   * for_each_new_private_obj_in_state - iterate over all private objects in an atomic update

-- 
Regards,

Laurent Pinchart

