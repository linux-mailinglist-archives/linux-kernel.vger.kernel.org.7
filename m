Return-Path: <linux-kernel+bounces-858072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F65BE8C98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4722F4E6178
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47534DCFF;
	Fri, 17 Oct 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NRGgT9Rd"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DF32ABFF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707170; cv=none; b=Sufv4PE2bZkTg7rAEt7f2pb+Ek1ZXHpAVwbCdXqPmFbK2jR5t1KjuaH+4yMm0S48GUS7GjAhDB4ZrEfiN06PLZvyUYbmtMadfguD+lvcjl0h1zavf1Kx6wOo+JrMoeDsiU9Ft4TLqe0pWPRVCgKxmR35KdHgeUZYZ0yxsZAGfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707170; c=relaxed/simple;
	bh=P+H5RElLDJEkmrUIc1XvLeO5VEpS1h+eN9vO4n+EAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChLE+sCp1A1174+/UNCWhWsPVwn+ryp5Sjl/WsVhqSKbhTyFIudswv5xzrFo72XLSE6Jcff7OF+2hLXmKiEcYlSp1DOegFMgz8Kd1k8OOnK6rubvGQkJD2U7lr5kknwLr6UpwaeNGgixpV/olmu23Z/OgYm9AdKtUHM/C+aVJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=NRGgT9Rd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so191428a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1760707167; x=1761311967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjGy9FZ+rKEjrnntHU4EtXwsShUyCILycOc13M5bggE=;
        b=NRGgT9RdxxQS0BVaapjgvs2/fmVGW7oaYIhAmo+otxlUI2SkFIk7xkz+ZmVfbaC73W
         gthH1/WpfggAXZvXm4Z1fo5h3OJOXt4EhTXRSxAq5du3Tx6/eUn9RdHBVihu7qpcMdtC
         rzkBW2H1SDPdmeCjcRS76UtYEFa/3vSPm8cW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707167; x=1761311967;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjGy9FZ+rKEjrnntHU4EtXwsShUyCILycOc13M5bggE=;
        b=fQyJHkHgxj2Zvs8VD1LWshIyd9obqbkMnPPUyBboNiu/nQ7KiXlHWwwWD3PZUKp+Dq
         mrNfy59W2Ma5JEiT/uzsVfKRoB7k5kc4sWHpOhxzArIn1Y46tkQLTumFFO2wof6wa7rY
         89j+KUY+9UY00Kkw5m+sycwZL+HKigllctwzpBJEdhqJQ77vGCd265UcURybl4fMnX3z
         Z0/IkS3LzrZAimgj4sAkny6FrGtPjJHoqo4bnW7YjHqWrKlUxV/WuVOU1PKn8ZrNmxR6
         WocW8XH+B3yVBgIt1pKChWmApd4HKe1jFn50JPefId5NqIwabj7hKz3NGKoOrglvgbgx
         8xHw==
X-Forwarded-Encrypted: i=1; AJvYcCXGIepwL8GIbAWtrA8BsDFhtbpj+pLiWF61jeUH02xjRUCTm1mI0hpM8URRIv1L5+i9IZZmijv8NxOXCuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEg+wJZRtpVttnkoJ+wfsYCstal3v3ZJHV1SIk4ORrL9OhUPrg
	86iIOqGvQrJ6GDjrjYyR6zpOXjL9/YQBF+6XmQKcjxqZSqya2y3/Ky/obUbFSQ2ZyuE=
X-Gm-Gg: ASbGncvAE271/9xaVqSt5sibXkaSK4WlLDNWg0Hn9YtpeHgrjvgwvCEnNo3WRCEpqp2
	osuIeScakCmYq0+vkzshifchx1+88hDLzPxWhVlXO1WPvW+vGpmsVbJ7cmE557jEoFWwHxkssGR
	IB3aE63iU62h1tq0/ag8C/f/d3GFgs1ZLLdNjVLz1WUqKFLV/XnvJQpylHxq5y+OK+dida/0ATn
	coVqzIgQU1iT1KCPKwP/Qtc7AQNhdeno93PXuDQ6mOWSOpLLF2F49WKiD5SsH8/4Y5aIkOS5p0R
	egm+5OjeztDnDPL8rdTZdM88E+hFMSzEsS4Wd8oc3/nrNU8vF3hsLAyEdPC8osg+932HMhE6h4I
	WfBMOymLhMh6x+PXxa7XqCJG5OcLcYE4EzW0uXFFV+iDOAZuYoqv8clt4rk7GA3pR/26U9vbAIA
	/59NnLPJE8gidu/eNzET7EUw==
X-Google-Smtp-Source: AGHT+IF7xNCCKtq8yrDup53uFHw15lFv/JcHO9zr7mifpvlVmxJCIL5ZwW7/XX61lvzCkalWE2LFdg==
X-Received: by 2002:a17:907:74e:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b6475e09c31mr453693466b.33.1760707166624;
        Fri, 17 Oct 2025 06:19:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb9e7a23dsm818970666b.23.2025.10.17.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:19:25 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:19:23 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/29] drm/encoder: Create get_current_crtc hook
Message-ID: <aPJCW7MfmuxwkL59@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-16-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-16-14ad5315da3f@kernel.org>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 02, 2025 at 10:32:44AM +0200, Maxime Ripard wrote:
> In order for drivers to implement drm_connectors atomic_state_readout
> hooks, they need to query the hardware and lookup the CRTC to set
> drm_connector_state.crtc.
> 
> It should be easy enough for drivers that are tightly integrated from
> the CRTC to the connectors, but if the driver uses bridges, there's no
> coupling between the CRTC and encoder, and the bridge driver.
> 
> The only thing the bridge has access to is the encoder, but the
> relationship between a CRTC and an encoder isn't a fixed mapping at the
> framework level, and thus the bridge can't deduce which CRTC is feeding
> its encoder.
> 
> Thus, let's create a new hook for encoders to implement to return the
> CRTC they are currently connected to.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_encoder.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index 977a9381c8ba943b4d3e021635ea14856df8a17d..7abb5e35ac950c941b56fc311a52789bbc427df6 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -86,10 +86,23 @@ struct drm_encoder_funcs {
>  	 * @debugfs_init:
>  	 *
>  	 * Allows encoders to create encoder-specific debugfs files.
>  	 */
>  	void (*debugfs_init)(struct drm_encoder *encoder, struct dentry *root);
> +
> +	/**
> +	 * @get_current_crtc:

Bit a bikeshed, but crossed my mind reading this: I think some kind of
prefix for all the state-readout/comparison related stuff and maybe even
putting all the new helpers into a new c/h files would be good. That way
we have a nice place for a DOC: section and people have a better chance of
understanding what they can ignore. Might still be good to put a standard
one-sentence explainer here that this is part of the state
readout/fastboot support and maybe link to the main helper function for
that.

For the prefix I'm lacking good ideas, but maybe asro for atomic state
readout? It's at least unique (to my knowledge), unlike all the other
shorthands I could come up with (like atomic fast boot and afb). Spelling
it out is way too long unfortunately.

Oh also, since this is part of the optional helpers it should be in
drm_encoder_helper_funcs, only uabi interfaces should be put into these
here. This also applies to all the other hooks.
-Sima


> +	 *
> +	 * This optional hook is used during initialization to read out
> +	 * the initial state by connectors that support atomic state
> +	 * hardware readout.
> +	 *
> +	 * Returns:
> +	 *
> +	 * The CRTC currently associated with the encoder if enabled, NULL otherwise.
> +	 */
> +	struct drm_crtc *(*get_current_crtc)(struct drm_encoder *encoder);
>  };
>  
>  /**
>   * struct drm_encoder - central DRM encoder structure
>   * @dev: parent DRM device
> 
> -- 
> 2.50.1
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

