Return-Path: <linux-kernel+bounces-749606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F66B15074
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5167C5467BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F3296147;
	Tue, 29 Jul 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0qEOTKs"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2C293C7D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804219; cv=none; b=UIipr9i5ZPlWSmyEJdy+pXeTVmqP+FXicqovJfFG7HrPOHqKVH3btJc0SdFMhU3Ja9Z2Bt9PZaxSPi2DbN+AclUXnl+3hmvSoPEetHDId7xs6nEJLOi2NbFGupQWV+YJAX/51YPJveSjYbthbmzDZVTEPJoOgYdnyuL1UoCwE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804219; c=relaxed/simple;
	bh=3MQGEggsiUVrrgFI2G8aeSVLgPSN6VW/Rm2vcPBZys8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxjehdymjJHbPMXSyLxArSIU+81VtSlg5RaZltnT+RA/6owTexkg+FGk1/ZB7ylbjfGCrfmBj3InU5lM+bz2s7mEyZDtHelaS2SpMmdGxiX2GUPPq2bxrWpNhJj4YRauJjIIEb1mbVmi2UIEbMufnRKHxgZq0WxvHwRHiUtIKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L0qEOTKs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76858e9e48aso2003446b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753804214; x=1754409014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRr//l+WljJZJqCKmuGr3DoCPPP+3a2R/rHAUaoNxRA=;
        b=L0qEOTKsGkStJ0xkoyCdEWABjy42dpnQkJJ3OwZf0owJygmVefrV0vPrzHhYSmfr33
         GNJgEFLyCWKtYMpx05B9qU2xPCuV8xXitg78/Z4w+LkxyfebWCpsgzUwLBK3uyVYxyRr
         8qN/tTSyFsg+89AhDSKs3QA5pQdH4fvrxmN5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753804214; x=1754409014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRr//l+WljJZJqCKmuGr3DoCPPP+3a2R/rHAUaoNxRA=;
        b=OPHox/qlosyOjzrc9Sk/tBML3vVaTpi9K1m2o/t7o7bFExAZJ5ei8OI3Kw3RKuVkkT
         ViORySBr2uiAO3Ev6B5RHHepzE/8LndrJhUdEcMJhuJWe9sPg4eWW6Q/wE1bc53hgFdW
         2ZJCCCKxQI0xzW+/iCkYfc+ZoacurVQu4rZcie1m/oi6chcO35HYuS5N1iEBu025LYgc
         jCOCFT9SkE65o6hoPMXxJHNWMVxxnNqmOlaVrKmv3tw320ln44LiVbFrGJ2T1i92NWD8
         sGeXpxUEmiik9NPoAVUxIVwT4f42Zcf9pFr76utLN8LCsF9FXfFhB9nEeTiq21xTUJPe
         Q+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTGg8eP/tYKOOZ+uFHkYqwLKDk5IODe2ZGBCENhnI+7w6yn9kA6Wsw8VRznHiuyMr0T+39fGQ/voONpBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l0uaX/NtjsFGD8eJgR+4Bj+anZBu+G5C5IrgIGtWX3dIaE0O
	QXGaRymmMYbxdM+YAsr0ex51w/Rf2wzmXM0/HiXHlEJEf42JRNXC2neZiUuU5t/7UnIrWYVGyA2
	wf54=
X-Gm-Gg: ASbGncuHxGqzHxoLQDJ5tUOiiY10sj+xlhJpA4kNT3LLf/knjY2t0P4amPnA+Y+Haqt
	B0D8FY/rjgFtyAEcxWQLSUiPkltryBOTlZidpHqtYenhj2ttH2Gsk27u/n6AQgK4wOjp4JDUqyp
	M8MeM4vesVwBEUqFN4O1tHYJaNMZ+acFglmR8MAmM6z1HE9P2zmBQy2GjtcIzDXrWArbIIMNamP
	/wGlE17lDLStDOeLArg2OWKrtK+CZQK1NfoQGtYZmEKwq0oUWgJ1W4O62kCJ8PzLEfIAneaadl2
	EZuWBYl84xu3TOYkGNoMRB/jX4oo960snpLkK/X0axTHrvzbIswPoDeIpb2YTn3SBUFLqNJT+6G
	ok05KQUTB3xxQZkqSbJu6l3LGQqDArBCqFKjh7JAgxauZHUjV9yzwmRjJYAyKFg==
X-Google-Smtp-Source: AGHT+IHfcWuZMpj3abo1VdBGwI+QrkC1eZy7/snBCdba2OGROGq/xaGH1T1A2faqjh5bF7naP7AB9Q==
X-Received: by 2002:a05:6a00:2183:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-76ab309af51mr165730b3a.18.1753804213637;
        Tue, 29 Jul 2025 08:50:13 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b0911sm7877778b3a.124.2025.07.29.08.50.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:50:11 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so2189697a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:50:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2tAOSBRoVhJNB9ZavokZdX6/nznXOuU83M4lnRuMq+JIzEE5eP3Su6BZCCd+7XT+AAHOaNHsKsgF2cPk=@vger.kernel.org
X-Received: by 2002:a17:90b:35c7:b0:311:eb85:96f0 with SMTP id
 98e67ed59e1d1-31e77a1b44bmr22317060a91.29.1753804209750; Tue, 29 Jul 2025
 08:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727165846.38186-1-alex.vinarskis@gmail.com> <20250727165846.38186-4-alex.vinarskis@gmail.com>
In-Reply-To: <20250727165846.38186-4-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 08:49:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
X-Gm-Features: Ac12FXx7-_hf5KJUuN4rJ_U3AGgXay6N1FUZnlxj0Vi-OfESDXBTZN7_sEezRhc
Message-ID: <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel-edp: Add BOE NV140WUM-N64
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 27, 2025 at 9:58=E2=80=AFAM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
> eg. Asus Zenbook A14 UX3407QA.
>
> The raw edid of the panel is:
> 00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
> 10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
> 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8
>
> 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> 88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
> 5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
> 2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
> 40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
> 00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 9a56e208cbdd..b334926e96ed 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unkn=
own"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT11=
6WHM-N44"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e50_p2e80, =
"NV140WUM-N64"),

Since this is a "guess" timing without any datasheet, I'd be more
comfortable picking the most conservative of the "cousin" timings. Can
you re-send with "delay_200_500_e200" instead?

-Doug

