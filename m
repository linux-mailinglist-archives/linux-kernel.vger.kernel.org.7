Return-Path: <linux-kernel+bounces-858066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DEDBE8C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935853BB113
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0E345757;
	Fri, 17 Oct 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lcPMMhno"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C602367CF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706733; cv=none; b=Xvc+DT3MKrYJ8gGXV/09AOr6JtQUbJOjscvUhgU8FnWzoILKi78EGfwkDAnhknXI/GSsFA38CRnMOMqecM4LMhbVotWJhtJefhY/nWF285hfSE+NcWcmIw9gPie6J9GBg897wAsUoroGISXduFN85IupbepSRIM9SfwmqY+8PD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706733; c=relaxed/simple;
	bh=DcCVFpv5NfN6ZYhPhB9FiAuXyL5j+JFX5x0hEZ804Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epx9dk7N1e5eJvBIsvre0h9zLmr1Rq8/ajLpGEe7wgSBDZS0c8MRyzk//yWTmr1ut0VPnPE7Xe0YDfqyZ7d9iWds19R43e0T4tYYlQga3RWLE7IBq7FsY7gssBC8Ec1zayQCOFG3KBdKOJkVcC2kDB+OwTliPU03J883OPYbvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lcPMMhno; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b48d8deaef9so370418566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1760706729; x=1761311529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgUY5Sh0rfJq1KKqF6+/Wc6CUelq32S/uGrkwA/yIwI=;
        b=lcPMMhnovUrLq32NlYQ4B5HRTefU62hyqakRyZjanh+p2eKiu6+LrDP2uBTP/qPojn
         Ms4PnhDoAmoI+QBSatRFsH379w4rZeKxg3T8QLJZojCIxicO3nwxSS6zkQDrKOfwOIA2
         1UIxiTQFYJ4Vz24rC7K1N+/VIvXkSMvHSNWFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706729; x=1761311529;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgUY5Sh0rfJq1KKqF6+/Wc6CUelq32S/uGrkwA/yIwI=;
        b=tk/EnADCq105151m4aSWK85Yu0DZL/F4Bxw/MlGndL1dlS8kWzYRoR/jDsljG9sPs/
         qm2gzXFKV9J1fsZe5Ft5wJjkXwtjdwiIAdnMJA1ohC4G0NbcCmwkwnArLfKts7ARl7Cu
         ZyGSIx4ytbgSPt035Qwk9wWSsuR3vBv7C3M1T2nkGw7IXBhnxIL+oBHWHJv97N3iaOzn
         Mv+oujVPf0Dp73MkjePuALBJULkgjLW2x/6jlqB+egaTUxkHapx/RpKO71mIPl2pqnRd
         ibGMtSfgVsvFbXhMlMJ1/2xUcbJZvCtdPYEfe0IgM3cQZJMBWMjeJMRGrAmbfSrxo58S
         2i1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Zr2VrLzcAv1zBwuk5L3rzm+Upg9zaAO4CoCbCGh1nYzqx3YYa6CTktEgKiuZ8hIAijrsRWUxDdEHiKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoq1CzxILcaeXWi6k3s9NWESh1gnqtb0Zu1j1p+zB8fj9PgjNE
	0Q/GE5aqOLP4v9my9bXnQ7nT0HUIvFq1GLTS0D+VE2gfNtVBJPD/yblMZHHMmE+qtbk=
X-Gm-Gg: ASbGncu/siJon8ssTfgnr8tFw0xR6ql9iywdDqkfCjujrgZMpl2LACZHmrkeDHvYuAT
	4+2d9dPe57Z/nLeMdkJ5Yi/WyISK6Vxt1yDmN1lKS8IYa+H3bKgVBUFCtb+qiSC7BLEOjs4QiZp
	ZcQ2cUFRhL1kA0xpWVG4QCDsLO/zZNzJHQ0UWF307u2FXO/S0h2e53jSb0GeaclYHgUu8tpa4Et
	YgpU/yW46bhwc3br09V0hIy6mYiegeLGzHzKbnc/wDLNsQaYW5vmhzn1m2I6zUEO5AHdKw5YJGX
	xXzwE40JS67MHUNWwH0gwdF0t2y7+X0ZUrNJYh8hRV/rkVzpg9tR6QRHpb0T+cQ1G81gzY5MGN5
	W1H97cClthilqXWJqlqYInylWvo6iOxkXSElUpLAN4PoAJ4BSJAxkbhgkFrjfHiztsSuF/JEBFG
	2urkDSmj6l7zfW0d2oy5xugQ==
X-Google-Smtp-Source: AGHT+IEKJKBY+0fizVvFsqzngTvfJFKfmdqtA2X0XMv1Ygn3W4CU5xTRfa+7CtVte/CnbEhrkIy3mQ==
X-Received: by 2002:a17:907:7282:b0:b2a:e961:6e13 with SMTP id a640c23a62f3a-b6473950334mr382724966b.34.1760706729216;
        Fri, 17 Oct 2025 06:12:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb5132sm807933566b.54.2025.10.17.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:12:07 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:11:56 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: Re: [PATCH 00/29] drm: Implement state readout support
Message-ID: <aPJAnPWneXod2REH@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
 <abd349f5-48eb-4646-aca3-d70dd9f4bff0@suse.de>
 <20250923-spry-aloof-bullfrog-4febcc@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-spry-aloof-bullfrog-4febcc@penduick>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 23, 2025 at 11:15:55AM +0200, Maxime Ripard wrote:
> Hi Thomas,
> 
> On Tue, Sep 02, 2025 at 04:13:21PM +0200, Thomas Zimmermann wrote:
> > Hi Maxime,
> > 
> > there are a number of patches in this series that can be merged immediately,
> > and likely should.
> 
> Ack, I'll do a first pass to apply the preliminary patches if (or when)
> they get reviewed.
> 
> > Is the state-compare code really necessary? Doing this separately might ease
> > the review.
> 
> My understanding was that Sima wanted to be part of it, but I guess we
> can introduce it later on if she agrees.

Yeah I think without readout state comparison fastboot is nigh impossible
to validate and keep working. For merging splitting things sounds fine,
but for enabling in production I'd be very vary to ship this without.

I think a module option for developers and testing would be good here to
make this happen: -1/default means you only get fastboot when the entire
driver (including all bridges) support both state readout and comparison,
and then you can override that with 0/1. And this should be a tainting
module option I think.
-Sima
-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

