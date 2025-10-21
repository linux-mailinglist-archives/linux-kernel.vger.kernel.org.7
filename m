Return-Path: <linux-kernel+bounces-862387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3407BF5246
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A0462221
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F92E3387;
	Tue, 21 Oct 2025 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FM7/+tP+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F155291C13
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033823; cv=none; b=PcRaMWhh7HlECFnYdEOfhq9tBOamTvviuTAvtc3h1rinEoVGD2ONINt31qTndIDLvcblUY6NN/prlwPvOF/ceX2hLvcnNxHWxi0w3thqS0VEEDvhCBJK3igba66ULZ+eS9GPN/RfSSkj4dIyZbDof8gVCbBOTKOUMQ6sc1XDojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033823; c=relaxed/simple;
	bh=6Mv7HAoZABWuGvs2JyOm9HSzUH3AHVBCynCtVRwyJAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3503fvq5DYcsRPLhysUG5PcQkKXOjGoLJQDm8nE3isiHvA9QFjJgl7Mhq+weZpMDxkrPaHNRpCRTIIyJ7Kxsvloi9xgqU5jTzBcGhZMhlg+K6i/I7l/ZOycymlfvrQIpeL4UW9hx/FJTBHOwrMIkzpjBjps1GUrTRnOHXQY6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=FM7/+tP+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1182908666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761033820; x=1761638620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eZOCk0G+WIeYYVlPWpiKCZVOUjneoPQzsl6dTiB4tA=;
        b=FM7/+tP+EKbj+UA6g5fOHhfJreNzSMKP+JpMgOF/U8IigPesS5v5MNxSr8D3y+6g5w
         5tdueylmRsGBZoY21maiZU/f9Ne79UfV10jgyKgQf+n7N7aZ70nUsyGQCYQaJc1G+pB4
         PhnwE76FSFbhl7JJCkVlCL/CEBkGPf+DNktxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033820; x=1761638620;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eZOCk0G+WIeYYVlPWpiKCZVOUjneoPQzsl6dTiB4tA=;
        b=eobWhlvIIk+oAWEC3+82fzb2eo3ANLyuugFezzWCthmxUAXjY+nFmQJ2m/NcOhlw7/
         4/TvlTzB18O2+WStHan8pvtiWoKmr2YC6rVN+0oqZWcjsf4VNrPfSRu9KLqBvUvT/tpr
         i0VjAuTr6SywIoFnF8tbntD8x4nUPTDqmMcK4PKJ045g5AFUigKVQIOlOHz3pH5MpnPb
         T2TL5y3rEDCK5+ulXwcqUdNESPEF/QwWxKBXplcp19u47kU2vDP9Nob7q88VmUEWjM91
         te98BZoJYX4Y0QilpTuIIgQiOSQmtLMpiiOtZ5WllQrZ07UBVdRhMahQB3T2+OdzoGns
         iYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zJCQgbtSImhN9h3eVkTlwH3HdJPXYdZwGWT6/5iSW0JlzjuCgX+GXFg0oC8QtHpaj4kUvkntO9pIcO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5P0lv8iidcAxk/WR7yVw296/7yBpPic6tG8ii/6avXI9SmrYZ
	iMoRt/X4axtye+W9UgAl/s2FBJCP9jp1hOYpnnKKNGF4U32IfXqaaOkv2hMUwUbw3SM=
X-Gm-Gg: ASbGnctL5bHooLiyFLRMSa0h+jhrujxL4kFMqyAlsGuMXugXrBzXhAu8ojm0mNN+NAO
	7QMV6hSg+VAix4xc9BsYugBFPJFMPVtBRxJy7kc40MjhTEbYqCU/f+aXCohPoe0Di2ztwnOEJYH
	JKHraOviUa3s5QUTGh46H4ikCiRJAciitSy9/epbR5Wga/PLVBhVzsxUXwwBJKGWs9UGAkMIW63
	tNWOMu3pklNTMxIpZx7MJEIZoxgnt49ly9iVPRpH9+IJW6JuFaaFMNTCnByKKPzKRz0iuQWBzzI
	VSYQSklv00Glh3wje9gkidHc8l00wmxynXo5cc2kF0tigRTbJCfxt40sVAm/Vx4pJEuExwC5bD+
	v2xVwaaMs1AALcb7A2DwJTrwka5RlO5XfEeJj3ClhKBAbx1JSPO6qR4tei4AwwJbwV2Yx4ixK/M
	gx9qsollSmPks=
X-Google-Smtp-Source: AGHT+IEbmSLB+yRFZ86qxeD7wG4TxM9uG6ayZpPpFTz88clAHcJph5RIG47VQ/I34aUFg3RPcxflIg==
X-Received: by 2002:a17:906:fe41:b0:b04:aadd:b8d7 with SMTP id a640c23a62f3a-b6471d48347mr1967108166b.13.1761033819926;
        Tue, 21 Oct 2025 01:03:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm992513566b.31.2025.10.21.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:03:39 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:03:37 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
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
Message-ID: <aPc-Wad85lQWbqfa@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923053001.2678596-3-shengjiu.wang@nxp.com>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Tue, Sep 23, 2025 at 01:29:56PM +0800, Shengjiu Wang wrote:
> The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
> in HDMI and DisplayPort to describe the audio stream, but hardware device
> may need to reorder the IEC958 bits for internal transmission, so need
> these standard bits definitions for IEC958 subframe format.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Would be good to get a formal ack from alsa maintainers before merging
through drm, just to be sure.

Thanks, Sima

> ---
>  include/sound/asoundef.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
> index 09b2c3dffb30..c4a929d4fd51 100644
> --- a/include/sound/asoundef.h
> +++ b/include/sound/asoundef.h
> @@ -12,6 +12,15 @@
>   *        Digital audio interface					    *
>   *                                                                          *
>   ****************************************************************************/
> +/* IEC958 subframe format */
> +#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xfU)
> +#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xfU << 4)
> +#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffffU << 4)
> +#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffffU << 8)
> +#define IEC958_SUBFRAME_VALIDITY	(0x1U << 28)
> +#define IEC958_SUBFRAME_USER_DATA	(0x1U << 29)
> +#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1U << 30)
> +#define IEC958_SUBFRAME_PARITY		(0x1U << 31)
>  
>  /* AES/IEC958 channel status bits */
>  #define IEC958_AES0_PROFESSIONAL	(1<<0)	/* 0 = consumer, 1 = professional */
> -- 
> 2.34.1
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

