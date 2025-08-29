Return-Path: <linux-kernel+bounces-792022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF259B3BF97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E4A3A382E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248F32C307;
	Fri, 29 Aug 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="KtZZ4AJv"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBE31064E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481774; cv=none; b=DqDZDVgoaZ6sJZubZyxbnRLCX/3wSDkNTL9qz8bVMlDMr6SW2JEyAIyATM2Lh0pbFFm87fLUZUAIaEx0BSz2VwtTkOutjQTrRe8OYzAxWvuomWXhz0/rtWYWuq36LcQqmK4RxT9Xgd7Q6qdm5NB+R4Ed06+ZG9xyEbZGdijqz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481774; c=relaxed/simple;
	bh=Gy1T7+qVdqarKzHKNdaNH9Biaub7PRwVp35/SRAjNP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF9LPcEOksqkD1RAf0l+aybcf33K9Yiy0HMZQxoOdTgdq0CpeaYX4cPgtSVNKbF0wowrii7NZnsAWqIn1C8qlXBZWZ+I89nRAfF6RLgouHeEqM8T+5jPHO2icCfgaJMrW0A+FPEnhLeTLGfW49XrV9GvuVlUrZ2wUf86rsfAiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=KtZZ4AJv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704cdc76so225073285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756481771; x=1757086571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SSy/4QqSxPf2Td+xOiBHnRIJU25HPzBFl3gyWpJBL4=;
        b=KtZZ4AJvswiFxSg1pH71UpwwE+h3roGonXOfURWRBNx3QHfgPuHObEh18Sjh0piXFS
         aACsWag6fGUfWlPzLJMtlZe3TsdiOxBkU1mM8wko4wj7Zb8ZgH47PwatbFOadmqPYeR4
         ElxLco+TOQHRJO3toeT3lC0RhvAUTuVx+oXraNtpR36ApeueqAHRrl+PmtKBfzeIhkPB
         MhZ61BJnevMdPXIPr/bTmwgpmYsh+29qZO6hD7Zxj1q8C/vrBYKTXQJqPi05Rw2d3N36
         4qDWpjpu+2eQ5rIgNL51KUw6g5fISr3KZWSNB+IUSwEYZkBCwvwvR9XvYIxYsh224/fq
         2MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481771; x=1757086571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SSy/4QqSxPf2Td+xOiBHnRIJU25HPzBFl3gyWpJBL4=;
        b=tt0m31OYjOQzy5d1DsQiM63D0hKutxtYLmSISOXAsf5wjfN8IREJrZT0ayJvDd+TXf
         2w8qCtTibtwlvbU0PJ2MbIzri4zVrDhbEJxniY/OyXKL6ZTuBw8PhFtzNhy6V3N3ntYH
         c52kjQyGJH5kAgyrnI6sLBtv2S9O9i09gaU929al6aQf0m0l98QZWROsULlaJQmwBjOR
         cECu6B9z9GMg2durvpmsCfJeGafDPDbkfblEmi/K1FJVw9+CEETZUiGAeVJQg7Y5cD7v
         UA0PCsKYm7D5x+d9DBJMcYxqTaRVLiWAwJFE3DOSos0cQ41+ybu5UKyU+UOI9tqUmyb7
         aBeA==
X-Forwarded-Encrypted: i=1; AJvYcCV9nUfJi9/RfdtIitZ8NIP89B7JDJUT+s+3LJcXlPl8WhagwAHts2AN+IU4ITrD4Suc4OGzdgH+/nU0tlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUgsIen7OT7GV5nz7nMEdLxTK+zhCeyVe08+yKoJIeDK6Rjmh
	eEQP8TRW7ZnHQEzWgsNw3YKvKxkFQFCzZyFHzgFVnbdjdICq05eZnztTjXL0ts4RII5U+B6TbfG
	eh+C5pMSf/iGtjoqs7Id89rLjd4mQNzP/9NXyXoQVZQ==
X-Gm-Gg: ASbGncvVeYGB7E/XqIIeQrz2TJsTFTR7g2uJBcBl+8lWt3owS3RfHpn1N62OA82mcDH
	PKl6b8FeUPtFyLayjdsr3lZWd6BamHf1NuE7SC2kXOrqQNqFgptO5w985HfheOjkpUuelbNOWt0
	3mhFyf+P1W0cLhljc2Bowl7uY10JHbvMQV+1+G3bmT9zz+TDCypPhs6d8GkNlyBZV6uCEOILiTM
	iihZlWZCHn6jg8l
X-Google-Smtp-Source: AGHT+IEWqZtwwwHsrf82ewOz9RLbEwp65hDGKMxJaKKPW/S3xt8Z0JtCwy0RHATkKGBiN8Hrm886i7G3V+7iyRzmihw=
X-Received: by 2002:a05:620a:1aa9:b0:7fd:6709:f08d with SMTP id
 af79cd13be357-7fd6709f66emr191563385a.81.1756481770696; Fri, 29 Aug 2025
 08:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com> <20250825-rk3588-10bpc-v2-1-955622d16985@collabora.com>
In-Reply-To: <20250825-rk3588-10bpc-v2-1-955622d16985@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:35:59 +0200
X-Gm-Features: Ac12FXwrZsUUOJf6R_CcGG1_6Xwe2zsAflxp6I-kKbisXKVACpCbORbGe0q1z1k
Message-ID: <CAPj87rNX0vdQquZB7HQDG1rvCCyk=+2wa=isLqgL3_Sx6Y1J=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drm/rockchip: vop2: Check bpc before switching
 DCLK source
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cristian,

On Mon, 25 Aug 2025 at 12:08, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> When making use of the HDMI PHY PLL as a VOP2 DCLK source, it's output
> rate does normally match the mode clock.  But this is only applicable
> for default color depth of 8 bpc.  For higher depths, the output clock
> is further divided by the hardware according to the formula:
>
>   output rate = PHY PLL rate * 8 / bpc

Observing that this results in phy_pll_rate * 8 / 8 == phy_pll_rate
for 8bpc, the formula does actually hold true everywhere.

> @@ -1737,36 +1737,48 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>          * Switch to HDMI PHY PLL as DCLK source for display modes up
>          * to 4K@60Hz, if available, otherwise keep using the system CRU.
>          */
> -       if ((vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) && clock <= VOP2_MAX_DCLK_RATE) {
> -               drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
> -                       struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
> +       if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
> +               unsigned long max_dclk;
>
> -                       if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
> -                               if (!vop2->pll_hdmiphy0)
> -                                       break;
> +               if (vcstate->output_bpc > 8)
> +                       max_dclk = DIV_ROUND_CLOSEST_ULL(VOP2_MAX_DCLK_RATE * 8,
> +                                                        vcstate->output_bpc);
> +               else
> +                       max_dclk = VOP2_MAX_DCLK_RATE;

... so this could just be do the mul+div unconditionally.

> +               if (clock <= max_dclk) {
> +                       drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
> +                               struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
>
> -                               ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
> -                               if (ret < 0)
> -                                       drm_warn(vop2->drm,
> -                                                "Could not switch to HDMI0 PHY PLL: %d\n", ret);
> -                               break;
> -                       }
> +                               if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
> +                                       if (!vop2->pll_hdmiphy0)
> +                                               break;
> +
> +                                       if (!vp->dclk_src)
> +                                               vp->dclk_src = clk_get_parent(vp->dclk);
>
> -                       if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1) {
> -                               if (!vop2->pll_hdmiphy1)
> +                                       ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
> +                                       if (ret < 0)
> +                                               drm_warn(vop2->drm,
> +                                                        "Could not switch to HDMI0 PHY PLL: %d\n",
> +                                                        ret);
>                                         break;
> +                               }
>
> -                               if (!vp->dclk_src)
> -                                       vp->dclk_src = clk_get_parent(vp->dclk);
> +                               if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI1) {
> +                                       if (!vop2->pll_hdmiphy1)
> +                                               break;
>
> -                               ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy1);
> -                               if (ret < 0)
> -                                       drm_warn(vop2->drm,
> -                                                "Could not switch to HDMI1 PHY PLL: %d\n", ret);
> -                               break;
> +                                       if (!vp->dclk_src)
> +                                               vp->dclk_src = clk_get_parent(vp->dclk);
> +
> +                                       ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy1);
> +                                       if (ret < 0)
> +                                               drm_warn(vop2->drm,
> +                                                        "Could not switch to HDMI1 PHY PLL: %d\n",
> +                                                        ret);
> +                                       break;
> +                               }

To be honest, this whole thing is a bit weird, and seems like it could
also be struct clk *new_dclk_parent = (rkencoder->crtc_endpoint_id ==
ROCKCHIP_VOP2_EP_HDMI0) ? vop2->pll_hdmiphy0 : vop2->pll_hdmiphy1? But
it's not your code, I know, and the rest of the clock handling is
pretty messy, so I think this is fine as is.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

