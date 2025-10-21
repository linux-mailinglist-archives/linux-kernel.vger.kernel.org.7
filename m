Return-Path: <linux-kernel+bounces-862400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F8BF52FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0744830F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF22ED17C;
	Tue, 21 Oct 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LIvyTk8p"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3432ECE9F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034072; cv=none; b=o54Ca0vcqVnesQi20qDQUdV0BU7owN5GaFd1OXk9w4tgN4u/prcmHGd74Ju9Z/4ObTz06kYG5fo4CpvjmtufiDo62KvU7dtdYvoM8Tt4jyJkuBRAei6oknZjkUA9VCUMIACfzXwqZNA5rUyyU/mrZWbdRmju52zE02aZbPunEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034072; c=relaxed/simple;
	bh=KX8ZO3Auv88cdBaxObOo+VwnKCNwmQ3G5RcSBR8MIUQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu/0KP+70oiUyyoQ82jh4Hey4chkMCNYJKCsWnj30pO0OCKG8RUJOXC/c83qHSDjoY3+twCHFef7rtT46TEiAQ9F8RztWIq+y/MKvwaiH5sbjhAhsfdc1LehyUCQ+eusvRFpaKCTu7xdBJn3VnRUZjtW8DogBbXKg4MkEmVYg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LIvyTk8p; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d262c8528so16858466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761034068; x=1761638868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=llmJhZD012rxZY/wm+1U/bowfeca4YxBvqXnIKJ9gBs=;
        b=LIvyTk8pgvAoxNEbGY16ZAKw5nPNVjj6WRfMIR6EAdOPJWvgg9VtYJuc14ZtO5w+az
         PN9JLE5SrEDe39y2HPx12zt45xDT0la3aUaeaenQ6ABlWt9DepMABd0ffIh+3tG1D0g5
         hN/Uyqmx0zOcyqpuvXxK7nikO5jKnNZv6/iO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034068; x=1761638868;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llmJhZD012rxZY/wm+1U/bowfeca4YxBvqXnIKJ9gBs=;
        b=gtKVIYgD1bpwHofCVqRWAPV98BQaU14hcPUqqP7RUsNHtthxYd5lHzk2A2kYd6DsZe
         +RhLXA36is0JBNmx5cdofMU1D32MI22ZZM/7sUTGuCxOIIQTGPhshYiDNI8IExn8OLo2
         yJt6ud58LTEgkmca95q0KHhkP1F4xzq6bqiKnWHyZhWXm1Q4CnTmqMwDDbhlYe5R4Zx1
         nmbV6Fy99wcsdWS0p+j7p+bSsYwdZoEttwShvwf1DieuH2/X+Pp8LiLtBWrzFs8A7Uk5
         37jVLeEPljeATlQx39empqcUXme2A54TjTBtDMwYoRHSE7+loQKOQ84kwO5qNOAnX6DQ
         WaaA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqrYsq/ED3gT6W4XUN5FvH7veFzVdSxuCCvQkF3Gb1LxNkVm82F4cdjqJ5nUVrXAu/jDNtd6xnrpwHtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaaO7z4t/k1dd9Hkn1b7HuG7v4n5onRg4Kugbw01gFmCNQWEY
	aA4qDP+qJlpKdjeL3COgdKyuNSQQEkGCRWv/kdxwzpNP1mijOLL5CZbvN+e7DuqP120=
X-Gm-Gg: ASbGncuR+zMFMZ0qWtLXOT3/+IcbnhhKCssqGEeTvVspN8kJghdpw9RRPWUCtWlYtl5
	RGgdzBIVBFf7NEwRkN0XJ9yH4PVc/Rk9i/c+Mpwc6LJgwZ3ej0unnt+E9cjuH+BCUyyLglwVIht
	BSyVQib3P+IrGSdy1B3OpYewuCQwXJwZMZYNBcIj14nbQ+kgvog0MtC9FKYn6ACQnpMQ7e3jofn
	cdkn28uJ8V9NCHr0Q5b6qfyZJSW7+1rrZ844W8reIPd4GEy2mgJ3OlroO8Hy1ropi7zyikPLgw1
	ifEIdmJb5tWaZSy+8YU8R/AKhk02PrEkMOZedav5yJ890gJ/zHrcvF8wV7I43/j8/H+W5+hYZhD
	BuybXyMpKxxMDscMA2sjM6isT1VgJeOTrUXZnyNEGc6LcE2oFlQbEMg9so37LQnXBHWlIaap+iz
	T2B/GRuBOWIPiyAjSaWacsNA==
X-Google-Smtp-Source: AGHT+IEGcQ2tB+9FLkcsMzH3Z3OqGyaRZtqOqXHeWD/7JycNzUq8R6JyQRoeUwJtVWAc3tO+BkBXoA==
X-Received: by 2002:a17:907:2d23:b0:b5c:74fb:b618 with SMTP id a640c23a62f3a-b6472c61933mr1959457166b.12.1761034067061;
        Tue, 21 Oct 2025 01:07:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab65d6sm8600484a12.14.2025.10.21.01.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:07:46 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:07:44 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, l.stach@pengutronix.de,
	shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v7 2/7] ALSA: Add definitions for the bits in IEC958
 subframe
Message-ID: <aPc_UBy5-e6HIW9I@phenom.ffwll.local>
Mail-Followup-To: Shengjiu Wang <shengjiu.wang@nxp.com>,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	lumag@kernel.org, dianders@chromium.org,
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, l.stach@pengutronix.de,
	shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
 <20250923053001.2678596-3-shengjiu.wang@nxp.com>
 <aPc-Wad85lQWbqfa@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPc-Wad85lQWbqfa@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Oct 21, 2025 at 10:03:37AM +0200, Simona Vetter wrote:
> On Tue, Sep 23, 2025 at 01:29:56PM +0800, Shengjiu Wang wrote:
> > The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
> > in HDMI and DisplayPort to describe the audio stream, but hardware device
> > may need to reorder the IEC958 bits for internal transmission, so need
> > these standard bits definitions for IEC958 subframe format.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> Would be good to get a formal ack from alsa maintainers before merging
> through drm, just to be sure.

Sorry wasn't fully awake yet, I meant that it should be recorded in the
commit. dim has a check for this stuff now and it fired for your patch.
-Sima

> 
> Thanks, Sima
> 
> > ---
> >  include/sound/asoundef.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
> > index 09b2c3dffb30..c4a929d4fd51 100644
> > --- a/include/sound/asoundef.h
> > +++ b/include/sound/asoundef.h
> > @@ -12,6 +12,15 @@
> >   *        Digital audio interface					    *
> >   *                                                                          *
> >   ****************************************************************************/
> > +/* IEC958 subframe format */
> > +#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xfU)
> > +#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xfU << 4)
> > +#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffffU << 4)
> > +#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffffU << 8)
> > +#define IEC958_SUBFRAME_VALIDITY	(0x1U << 28)
> > +#define IEC958_SUBFRAME_USER_DATA	(0x1U << 29)
> > +#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1U << 30)
> > +#define IEC958_SUBFRAME_PARITY		(0x1U << 31)
> >  
> >  /* AES/IEC958 channel status bits */
> >  #define IEC958_AES0_PROFESSIONAL	(1<<0)	/* 0 = consumer, 1 = professional */
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Simona Vetter
> Software Engineer
> http://blog.ffwll.ch

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

