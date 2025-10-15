Return-Path: <linux-kernel+bounces-854884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B034ABDFACA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4119C6AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162433439F;
	Wed, 15 Oct 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="Ck2vHOV2"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECC2F1FDB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546028; cv=none; b=OPG/nkiyvpV61Yvq0wU4frTlnF2i+hqq6MnWqDTT6S5LY0xeenjw9ABCd2HQ0mp2ftHfxJmDz/3hJ0xda/R23coQe4khO6Sh+/w/H+f+1NdhGPMRbnFGeHe1JJ70Z9d3c5YzXPm9dSOCb0HjAXliWZLoH6XR8vM60a+30SnZmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546028; c=relaxed/simple;
	bh=DnwqSKuHK+UhT9f4pyZKDSdcl8ExmzhgzV9tYX3pjp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bShRxqLPSt2FThFNFbJ4H/l8SdWGfwKb6z0sgoJsoJ4sSeGgA189GkMdrZ0bCxqhxtXtqiCKrSF4Zj27b71VacyWrWItOV0DTDwwARLfjs4qELhJzSRhV+Z8X8P82l9VeHHzRzR/jt7tLVMiQV7gwq478+qiJGRrGrbTPHmicFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=Ck2vHOV2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8572d7b2457so233574885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1760546025; x=1761150825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TVB0JF51SZtYqzdiOCW6IylhkwcFhWMNKiMPXUv89E=;
        b=Ck2vHOV2IIF1xu1SvDIf1b9Q94xu6q9bFbFW9A++6PtpdWpSp2f/Qx7qP/lNDWC4X6
         z/B7Sr6MG/6U6HA5sXZsYNi/Suv8UfPHN1fjVdeJFFHA/PPUI283qIgPM0YlqhuJNzJ6
         Wb5Znn8UeIuU7xYKR0BJJ4Moa6IV4TyprvOpeXZd9/GjZ/wqlUPZTVX6D+mSWCxuCixV
         L+tRqssgwmHzqxWvz4P0PNMi/Gs11GpkMNeQpQr0FatZEbDtv4XgbWl3iH7A9RRGC0ZZ
         FuWkGiFZRGbtPVeWwd3NbKioJoSnQ6V9eU2GGJ7+0JWhmZXJgFjcdRqEBbsUHGNW5Pba
         qYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546025; x=1761150825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TVB0JF51SZtYqzdiOCW6IylhkwcFhWMNKiMPXUv89E=;
        b=TxdenY08d9btVVgjuk4dF8+oHYGjcfG3Y9wuHWMSTuxSDBspyJ4K53ZjPwIRxiapbe
         zCD9j8clT5tmJcHUPmyqabiSEGIp33knRm8SPgO9ichaXtz6q8kdbcImFh16JJu31xfe
         3V2T4W6DklwU+x5R1vg7ifv3n83A+1I115WT4GUN+pWsCPBDztbYQ4Ru/GBSvClKZbzL
         CpZQceo1Sfmdi5RlNAZluSMp/jnukKLi1l6SWQTvz2qY1AQhP+svcf0Cy+AOht2Dpnle
         2MxoCyMvoVv/8Yzu7uGErJA1srcBOLJ5HEkhvj1jd6IaYyLX2GTf8CEsFPnOm851FyYt
         byDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwZADqztGYs8+fja/V3nCU/8OCEAEUGrjMqEOxAbTyDOp5MJANGYVuBQd9yfhmEnHmm2Bjf/R/MhRafo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBPcYV/7FbahEkwHcPAc4SpNkWMeDLqAomgDW0GbGlrnA8uuf
	hO5cTBjUwXqOtunbD5EjZY7hFFVUdLR8SIgqtJ0CUBofwi7NuNQO/LCrvr46zqre4urxzbIVjq7
	uacEWhPVbw+3CvQWFhFtjuSMlMmQEMDrOD6mgsMFfMg==
X-Gm-Gg: ASbGncsfFoknCfKxvVm1rOnjACrftnv2e0n4aOd3g2lKuiyua11r8Sqdyz/iu+MPcq2
	sCM8kHMqOKXP4Vf9s0xdDIqJTMpdhuORTLen2th0IEalHXGZ3sAnqfa43GQpgjaCK9jcdipn9kP
	mME8URRA6FBwmRU6FD4wpRjI/syQ7a91xQvROfH045Ro8vXxeNYFi7jEsxGaXLhUYYTNXoCazqR
	zRtQX+DWFXdHlWhc6NIat8=
X-Google-Smtp-Source: AGHT+IEWLzmTAJuFvcRpHnhLL3oSxt5DVoapSEF3DOsu9jpTcS07RnjUwC01/MbeqWj+sQer43+GACQfNyCtsVTrhDM=
X-Received: by 2002:a05:620a:17a5:b0:827:937c:2c2e with SMTP id
 af79cd13be357-88f11537a62mr99337985a.30.1760546025481; Wed, 15 Oct 2025
 09:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <20250903-rk3588-hdmi-cec-v4-2-fa25163c4b08@collabora.com> <2753758.X9hSmTKtgW@diego>
In-Reply-To: <2753758.X9hSmTKtgW@diego>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 17:33:34 +0100
X-Gm-Features: AS18NWCJkFE5KF2FTR_JnzlOKDLW2oUBf1S94gJ5rVRW2DgSbekEAuXHzCMSdZw
Message-ID: <CAPj87rPqNw8BH7FCEAQONZWxTY+eUAE9DeWVTyJoTbN7mv=RfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] drm/bridge: dw-hdmi-qp: Fixup timer base setup
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 16:44, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> Am Mittwoch, 3. September 2025, 20:51:00 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Cristian Ciocaltea:
> > Currently the TIMER_BASE_CONFIG0 register gets initialized to a fixed
> > value as initially found in vendor driver code supporting the RK3588
> > SoC.  As a matter of fact the value matches the rate of the HDMI TX
> > reference clock, which is roughly 428.57 MHz.
> >
> > However, on RK3576 SoC that rate is slightly lower, i.e. 396.00 MHz, an=
d
> > the incorrect register configuration breaks CEC functionality.
> >
> > Set the timer base according to the actual reference clock rate that
> > shall be provided by the platform driver.  Otherwise fallback to the
> > vendor default.
> >
> > While at it, also drop the unnecessary empty lines in
> > dw_hdmi_qp_init_hw().
> >
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> This _does_ look ok to me, but as that touches the main bridge, could
> we get a 2nd set of eyes?

Sure can.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

