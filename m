Return-Path: <linux-kernel+bounces-858067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E40BE8C40
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3CB54F6C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D0345759;
	Fri, 17 Oct 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OZLlvrtQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C39345725
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706758; cv=none; b=tMLTXhEBhVbxOWLQcZtlS9HOetUesnzLAUOQrRmd8UD3mSgCa5DHrW4h152OgDUZ19HUNaH7mxoBgeObt+dX+IneNj56xy2Zug1I++TVP4oTvd43gTfUfKWr2LI7xT3C5Jb2a+HAuupQiHl69euKZ31wrKB9Tb6SNyXx1dmOYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706758; c=relaxed/simple;
	bh=il1Ot0Asi4kOvf4qxSymZfawgjQgquPTcwkAH10ViOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjHo9SUzD79qy6eF7cEaHebVy1w5qXu5zqeBCGny1ecSwQ3H1IiqnjPDz/2qYKlwFrf6wsnpE59P6V8Fbi777S4Xu1HyEt5GaatHzXHLnDc3xgYcllZMrNe8zZV9IjCqx1Anez0BMlLRZziIOmEYp8R2pF/gkGiQBO8UIgLz4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OZLlvrtQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5c18993b73so329105766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1760706755; x=1761311555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8drcKWNAi+zMP2KK5ndN4M8ywLJ52BdkCEh7QRMWbE=;
        b=OZLlvrtQrj280JKWvO45KZJw6nH8bSUtaNiiybS2fxaya8yPdeoI9dCh/hPeFJE39k
         Q0BDYCCbP+BZN9VY+uU9bx2e+uLLX7YP4wdy4/f24Ov3+sWvsDimGvmL6kITqGX78FYV
         vA6bkC95TlriacwtyCL8kWPYeRB6eHDPqi2tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706755; x=1761311555;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8drcKWNAi+zMP2KK5ndN4M8ywLJ52BdkCEh7QRMWbE=;
        b=XvOTjiAPMmFKN3mR/AB8pxz4+scm2x1DIypBHZXbQUvXrnGu0KgwaGlFp0nMz+JqDs
         FJi/L02eU5zAEyb6CcgQmAt/wLhHODO/nbR8XBz34XtsAe1WMCP+hP0c6wqET/u47fG6
         j58KqqSgn85whc3t+OfbprsSiwuAotbYg9Wy+rPRX7wE8zS2NBrPOZBQxEUpE7GGeKEZ
         yHApvmTx8+mLXph+yPVDgm/cyyCMuiAlU05eRx5iiDKdkbVz0tH+3W122fcsh+WmHnWJ
         fdqmLXsqositXe+4bDL77lO9khpCEK0KHcHLMXpqd9roPfGUSXyd7CG0yqk8G1GCt/22
         v+NA==
X-Forwarded-Encrypted: i=1; AJvYcCXUtApl6TatuGIf6DFr1/7TnAD3k1ZLHaWVDbBR7B/WdcixcSQnDJlbR/Tm0LkcXWEOjFj6nynilvgXZQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NW5hKI56ngBZLZscIR7QHkrsb5JtV2MBXcxuT8QIhXDymjXk
	QxRj5rE3831K2wTFpYIdzDpxkBakFeZMHr+Na6iK5NDqQODDP/uwNBPol30dd6vlK0Q=
X-Gm-Gg: ASbGncsSnmnZ6F/waTbml+VhLEPBOGKNTReT+jpHwdekURBRtef2inuSyk1NKO2SL/W
	h2ejyt040sOH2BOOJ56nGSJAQDSpu1jc6E6yktqYdP6z8PF35FRYS/M8QsvR57AUKV5mTygDX4y
	3Q6o4YBRqgLrKkOdq8q2a+lwgQvwWR48hL/d8TC2nDiwpGhxWIghXPAUaERY4eGCJEHnWLhWCRs
	EUGmWUNR5uHkOT2RwxE4YJitgJdpUJp0dgispvj3T4LOxFvoOGFaaUQqU8kLqXVY0uEUFGBM9dd
	xeMIdcC9v6LJnWWUdVidqR9u4OelRqQqZjXqHSR6Yrt5eJEfkbYQSdSaJLC+pBZ3ZCLHlkeQ5dZ
	9/+WVgfUj0JTd0DwyiyxTmC5u+2RETLYkwAp9nK89GFyRkgKHweyZA5BEIXSNOBJ7dDb3G5XNX1
	T846bgULoF56ltetp+Sn5KFFsQhhist0r4
X-Google-Smtp-Source: AGHT+IEMtwbVyTQnnInJbTsw7KR4oYloKA7FU2ZIGPqsvz+QRaG+CGdXd8qcNMVx7WoYarGXqRzumQ==
X-Received: by 2002:a17:906:b04:b0:b64:97ef:a636 with SMTP id a640c23a62f3a-b6497efa657mr264996066b.31.1760706754548;
        Fri, 17 Oct 2025 06:12:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45ad2fsm818093466b.35.2025.10.17.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:12:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:12:31 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
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
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <aPJAvzROMCnFwRJc@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Maxime Ripard <mripard@kernel.org>,
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
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <zvqtehg66dbrrdmik6ylo2kdk74umfzo5hbfkizwsb352nlyqv@jgouvmbfwa4x>
 <20250923-rigorous-tamarin-of-cookies-2f1a25@penduick>
 <hd7gjmsbxjfaffxaxvnafzlq6rf625nxqfmcrllnndl6yigtaq@o6vaotpu55by>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hd7gjmsbxjfaffxaxvnafzlq6rf625nxqfmcrllnndl6yigtaq@o6vaotpu55by>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 23, 2025 at 01:30:43PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 23, 2025 at 11:45:49AM +0200, Maxime Ripard wrote:
> > On Mon, Sep 15, 2025 at 09:40:57PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, Sep 02, 2025 at 10:32:38AM +0200, Maxime Ripard wrote:
> > > > In order to enable drivers to fill their initial state from the hardware
> > > > state, we need to provide an alternative atomic_reset helper.
> > > > 
> > > > This helper relies on each state having its own atomic_state_readout()
> > > > hooks. Each component will thus be able to fill the initial state based
> > > > on what they can figure out from the hardware.
> > > > 
> > > > It also allocates a dummy drm_atomic_state to glue the whole thing
> > > > together so atomic_state_readout implementations can still figure out
> > > > the state of other related entities.
> > > > 
> > > > Link: https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5Ra8CxPvJ=9BwmvfU-O0gg@mail.gmail.com/
> > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/drm_atomic_helper.c | 382 ++++++++++++++++++++++++++++++++++++
> > > >  drivers/gpu/drm/drm_mode_config.c   |   1 +
> > > >  include/drm/drm_atomic_helper.h     |   1 +
> > > >  include/drm/drm_bridge.h            |  21 ++
> > > >  include/drm/drm_connector.h         |  26 +++
> > > >  include/drm/drm_crtc.h              |  19 ++
> > > >  include/drm/drm_plane.h             |  27 +++
> > > >  7 files changed, 477 insertions(+)
> > > > 
> > > > +	drm_for_each_encoder(encoder, dev) {
> > > > +		struct drm_connector_state *enc_conn_state;
> > > > +		struct drm_crtc_state *enc_crtc_state;
> > > > +		struct drm_bridge *bridge;
> > > > +
> > > > +		/*
> > > > +		 * It works a bit differently for bridges. Because they are
> > > > +		 * using a drm_private_state, and because
> > > > +		 * drm_atomic_private_obj_init() asks for its initial state when
> > > > +		 * initializing, instead of doing it later on through a reset
> > > > +		 * call like the other entities, we can't have reset xor
> > > > +		 * readout.
> > > 
> > > Would it make sense to unify the way the bridges / priv_obj handle the
> > > state with the rest of the object types?
> > 
> > I would be all for it, but I think this is pretty much the same
> > conversation we had in my recent bridge improvement series. Aren't
> > bridges not assumed to have atomic support and thus we can't really do
> > something better here?
> > 
> > Or should we move all bridges to be atomic?
> 
> I think I had something smaller on my mind: make drm_private_obj /
> drm_bride provide the initial state during the reset call, like all
> other entities.

Yeah something like that crossed my mind too.
-Sima
-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

