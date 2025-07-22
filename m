Return-Path: <linux-kernel+bounces-741137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A3B0E07E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E413B4F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEC26E6E7;
	Tue, 22 Jul 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imnsbKK2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF324C148
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198226; cv=none; b=IxyglbCtvG368wYM7IlSaw4SZdMeAascp3TNBurmr9lU2rYQ/+m7ZcU4u6rcYERiFe/0XN5HV4qoGl23vYcSBAzQSkQe9tpLeJ7i96JD+JbVJAcqMVky6umNHYOSe4OHuFWlU3hgmG3pyN08QzyrAGtRm7HEK6lZRxHHcWEApZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198226; c=relaxed/simple;
	bh=dRrG8HHjNxcAMAXJ52VllnyHLpwY/PoGIHoltvH/KL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll2bqq8avTJUVL76V0rgutrMUS1sYi2qpCqu9ximS/wE8WmER/Abt/oxnJ4jmSGflYfSaSOdQINaQ6eRgTS7xNd/YQlZY+IHfE3u+Su8cCPy2GMiUA3Rtmlmcvb3/6Senvw3PrJuP60UH1DfaRxKDPoH3V/VV1hkEfDhd18thW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=imnsbKK2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23f8df98e41so6422345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753198219; x=1753803019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lonorFHz/PRQJclxUnHKWPN5pEdso/Me+ZrNdy5Tq8A=;
        b=imnsbKK2A+wkAqbBFK6mgnWw35j6ELOr07uoiZAeU1gBt1MazlVKdF7SqGg9uFRmFX
         qW2IJihIz7PZZYMnUcwqLHzpoADqpO3+YeBBlzaleoAiMGJjxJLDRdFY1Q6fsgejgO8c
         OTfXUiGqyurFwayWSKB0IBBr39ZTk55j03uew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198219; x=1753803019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lonorFHz/PRQJclxUnHKWPN5pEdso/Me+ZrNdy5Tq8A=;
        b=Uuuqk/vJF3SpcQZ4ASYQtf5Jdyj/bRyq8xv+gmUvbHjLKvkc/vHE6v8y8z3HuCicqb
         lGjk/+OVvCGGzypKyN07tt2hA8E4JZvaoNWXtR7Ova4dZlK6C6xQVcLqJgslOdu84hGB
         ofIcRIU3rNBXN07LjXpwEvOUMZIvCMpxTTBnHSpjWGO0/VdXdERGj6F5ibxeG1P02gY+
         mNXCybkY3USW2815HZcG+r+O33lzWB50ASuuYvCxTvM2mGkdTtJW3EPJmYG7eS5IOHTQ
         5ymYjQ/vAOqKVSg5KpTXNWUu9nIP0jXqsl1cRK11+hCZN7uty/x60uHONNJWsULissQs
         B6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW67jzVTEVdprZRgzy/z+KToHA43CW6S1yuWgD/XUs8wi+yme8xhcPP+ES3TBTdzViNXTlvGEO5A0yEeak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDbli3LreB67WfhngqNQPsdWjXB1rtQNSo8qqj/FT+nM3pLfg
	uWXXiijJSSWKsPamntwTmDAPyBstf7lBhZ5gRIcSnASjfm2bDu0Mq13vgfSWdiBnSUpogwoGj4/
	UkGg=
X-Gm-Gg: ASbGncsx08RgZ1JQGVbh4l6HkZ2siu+20+uHTN03fZCjjIbSlszxpU81GFmn5u3wD+4
	V5WQM2qemZnHuN0dPfXN/QVymc02eyAtATDkd5FBjxEAvqQMXsD1vzc7/XCoiDSztec+O5TFrs0
	Z4HTyH+4NJS3VwpKiQR8Tr9lAUVE+G2ZY114rM026HdglgBtp/wsHjmh95PSiVAlXQRF17jHpz0
	eOUFUCHFbStEBzRHAMK7FFKSl6ZAyx1yo4dwL8e6L+IRJWOFVYBXZQQawTO5okJFLNhAMviDn6F
	zXX6EAQyVE6sM2l7dnL2XO53wQEMgxg99uLj3pGY87TuREV4VyF/U68z5HoEL0oxLqoxQ0jkxdO
	2KjRnXZaSiHXDsmS9Nf1XjF83m/fujiu6H2WTpn1N6Ev6nKXhHMQqd9geSN6p26Ewsw==
X-Google-Smtp-Source: AGHT+IFlxt+RKoV11hfQ4damOlI9r4S9XDM0r79Gk8lFK/hZdw64TP+NU52653KsFxFZpNe8rAgj9w==
X-Received: by 2002:a17:902:e845:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-23e256b5f6amr335830605ad.20.1753198218987;
        Tue, 22 Jul 2025 08:30:18 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b6032sm79034575ad.86.2025.07.22.08.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:30:16 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso65938815ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:30:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnmPdEfKrTsLhGaQLB2+d+1loiCcOkAOK+Pf7aB0SzsiZ9WdrSwFkfYERr1Uql2r6JHeAU2JmoTNND6nw=@vger.kernel.org
X-Received: by 2002:a17:903:187:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-23e2566aebdmr353462865ad.8.1753198215386; Tue, 22 Jul 2025
 08:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722024512.983313-1-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20250722024512.983313-1-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jul 2025 08:30:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMnQLyDxj0q28OEpfcBOX7Fdnn=VbEHLPTgPDBCPjJLg@mail.gmail.com>
X-Gm-Features: Ac12FXwLlGFsM1matkfYWetnozGyh0S87g1mvbretcxQ3x1IGxTvY3ketxgqOJs
Message-ID: <CAD=FV=UMnQLyDxj0q28OEpfcBOX7Fdnn=VbEHLPTgPDBCPjJLg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add 50ms disable delay for three panels
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 7:45=E2=80=AFPM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> Add 50ms disable delay for NV116WHM-N49, NV122WUM-N41, and MNC207QS1-1
> to satisfy T9+T10 timing.
>
> Fixes: 0547692ac146 ("drm/panel-edp: Add several generic edp panels")
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 09170470b3ef..742a83fa4da1 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1743,6 +1743,14 @@ static const struct panel_delay delay_200_500_e50_=
p2e200 =3D {
>         .prepare_to_enable =3D 200,
>  };
>
> +static const struct panel_delay delay_200_500_e50_d50_p2e200 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 500,
> +       .enable =3D 50,
> +       .disable =3D 50,
> +       .prepare_to_enable =3D 200,
> +};
> +
>  static const struct panel_delay delay_200_500_e80 =3D {
>         .hpd_absent =3D 200,
>         .unprepare =3D 500,
> @@ -1941,13 +1949,13 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116=
WHM-N21"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a1b, &delay_200_500_e50, "NV133=
WUM-N63"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unkn=
own"),
> -       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116=
WHM-N49"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80_d50, "N=
V116WHM-N49"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116=
WHM-N45"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116=
WHM-N4C"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, =
"NV140WUM-N41"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200=
, "NV140FHM-NZ"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140=
QDM-N6A"),
> -       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122=
WUM-N41"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "N=
V122WUM-N41"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV14=
0FHM-T09"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140=
WUM-N6G"),
> @@ -1986,7 +1994,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N=
140HGA-EA1"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N=
160JCE-ELL"),
>
> -       EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200,=
 "MNC207QS1-1"),
> +       EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e=
200, "MNC207QS1-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_p2e200,=
 "MNE007JA1-2"),

Can you send a v2 where you also change the timings for "MNE007JA1-2"
in the same patch? That also means that instead of adding a new timing
for "delay_200_500_e50_d50_p2e200" you can rename/replace the
"delay_200_500_e50_p2e200" since these are the only two users of that
timing.

Specifically it can be noted that when "MNE007JA1-2" was added [1] it
was done by someone without panel docs so they just copied the other
timings. Adding an extra 50ms delay should be safe and is probably
right for that panel as well.

When you do this then your patch will have two "Fixes" tags, one for
the commit you've already identified and one for commit 50625eab3972
("drm/edp-panel: Add panel used by T14s Gen6 Snapdragon").

[1] https://patchwork.freedesktop.org/patch/msgid/20250211014314.94429-1-sr=
e@ring0.de

-Doug

