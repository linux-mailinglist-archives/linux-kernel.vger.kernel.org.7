Return-Path: <linux-kernel+bounces-730677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261BCB04801
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186453BD940
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B796E204C1A;
	Mon, 14 Jul 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kTnxe6Hk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD71662E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522040; cv=none; b=UwE1zIWasSk83UUF+8Z2QsFgwDabrgh8jVNP06pTxwVXQEYOBcBLYQXiekjFDJija4GDef6Mek85DlxAFgYIutzJKeqyL6HLL+/U88DWyWRfAt/Oo1fJuhwk9ebSm8+g52Dg2EO+iFr5zZsN+9i0Egu3RICQpb9nlftUYZkSABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522040; c=relaxed/simple;
	bh=BLdMujJcsYQmdisLe92MyF6cvQ0+4KXuQTw1VF0Ah4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlDpctUF4Q7XKpKMLUyle4SCzyDenN0hNFBnXO1aX6B+nRoCzHaUqtA6dUCDwBk9OZQGAhcSPxBSUEAXz5YhWjvaXTnvWjPg0bZARObvqbZ+ZFqfhOU3JluaMAKecIml9HWdB6dIsDZVqo03KXYphbFLM3UqKtIr39FcqkBW0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kTnxe6Hk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235a3dd4f0dso30586745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752522033; x=1753126833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEniyjVNgLZ7A/xokzs1kJjeCJ9pKk7c1wIFnkTmCLg=;
        b=kTnxe6HkbwHHXr2PW5e9Rk6MwGih66Jyfu1Boe5y4Eb/+9cO3aodO7OpNrUbf9+qni
         Qk/Qrkhya0U9PE0ajAfljwZBaW8GVtTgTiPxbkrDvzDuV3fNt5lgINtXGSzNB56Hlpkz
         HJScnxHlqcPIP5lEBSvZUnIsAJlIuNm51ssNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522033; x=1753126833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEniyjVNgLZ7A/xokzs1kJjeCJ9pKk7c1wIFnkTmCLg=;
        b=jbmCDhJoYC2LW7NmfMYXz8EWh76noZWnLo/TocC1wHSLHVveUu2AD5G3qgkr3rNv9w
         +jUkXdhmlYkdgZfLuCt3lv4vXpCb7qR2Q8v/d9ezCJXZytAMAgo4mFLYAABu4tbXfSpL
         ufKreeToFnxfAbYZfN+ow1f0NhobQy3OZsZJKLTPETJ1RXgpLuBkKRf5M2rbsmNmRKPs
         SrVcrnrJNWhb6orBcrpJs9duEY94qGlJUVsIp+mgos2yODxwuppHeI/0pRKUrutarDYV
         HxlQLDexMwcTD31q3j/azUo6JV4tA44rBNcCIXvXLjqA2GNFabdxEuUsc5GJJzp7VB56
         KABQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNLcqvh2W9jCYbvDsWuOAkrjmcgVBfy8gxlso70iuhNT4UXXf3aYTPTWbY3Gth24K4iwrl10cxz1E2FyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5K6OXIaZiTpbzhzaxQdOv+R25t/sIuj/JX64SDE9P8Eu+U2d
	A6NLpAfOP9h57mgKG91RyQY4zc+xexuqiVJqhB5z/FL4e0Quyegb4NtBMhBaZo6hKNEnD5T5g/1
	QxnY=
X-Gm-Gg: ASbGncu+u/7Zj4wXOQePnfRCmgWtRJy5jIJIGUGwnmEpOzFShGsQONset7B4PnOmiHU
	yhk+Rp+Eixhla2ktCttWDUZ4imJ43J4KirZUexVg3VVEKMy1iOgP5eCLsCo9MIhMTLLsc4y9cv4
	CY163rmlSFmrVL3YJPUG29Zr13kymtZu61zk/zTVjd2rl4MwBa7iGQYjt/LUp6Qsdenoj2XLJh2
	3HL7cOkHCVY9pBnCK/eVRHvzbVUiNh3/QQO69uNvOJlJ3yb54Q7uf+SWWY3bKWIHHdeWiDQiXHG
	9XLYXdmSCUTBmaimndL2iYDpvYijuise6Uq/ers20kI21R8ngCvHk8ZqPiWsaMxZSHckAZYFEed
	wOkierT4KdaK6OeKXuMksn5tAUoMTc0+3VgB4Eue6hm2IoLJOZd6sm6M9/fIg9a39OQ==
X-Google-Smtp-Source: AGHT+IGo8tn20W3Te49asvHMhiVo/YUH6IqN0YlctAVcixFifyDDcMHcWGodD8fUXYXWMlCCsowptA==
X-Received: by 2002:a17:903:46cb:b0:234:9066:c857 with SMTP id d9443c01a7336-23e1b1092cdmr926275ad.21.1752522032941;
        Mon, 14 Jul 2025 12:40:32 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435cb63sm96015565ad.235.2025.07.14.12.40.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 12:40:27 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4370426a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:40:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNDss1WGobJ6xoZYgumoyC+kdE+XzZNmqNfIu3Xq4xV6TgdFSEL0I8fwKttYrVJsYsP/KbLSjTqz0gYC8=@vger.kernel.org
X-Received: by 2002:a17:90b:2247:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-31c4cca46b0mr20433281a91.5.1752522026579; Mon, 14 Jul 2025
 12:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-x13x-touchscreen-lookup-v1-1-a1277f119f92@riscstar.com>
In-Reply-To: <20250701-x13x-touchscreen-lookup-v1-1-a1277f119f92@riscstar.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 12:40:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzjC-+Uz4vpTQf+76uL9_Aad9Zs=qkQKBjadRxUKZgYg@mail.gmail.com>
X-Gm-Features: Ac12FXyGVOxl4TaPz_wHI3nt_YQssoML9lSoXS6OMPQ4CI5qfxsAw4BaSTKq62Y
Message-ID: <CAD=FV=XzjC-+Uz4vpTQf+76uL9_Aad9Zs=qkQKBjadRxUKZgYg@mail.gmail.com>
Subject: Re: [PATCH] drm/edp-panel: Add touchscreen panel used by Lenovo X13s
To: daniel@riscstar.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 1, 2025 at 1:17=E2=80=AFAM <daniel@riscstar.com> wrote:
>
> From: Daniel Thompson <daniel@riscstar.com>
>
> After (checks watch) a little over two years I finally investigated the
> boot warning on my Thinkpad X13s and it was caused by the conservative
> timings warning in panel-edp.c . The X13s was sold with a variety of
> different panel versions; I have the 300 nit multi-touch variant.
>
> I have been unable to secure panel documentation so the I copied the
> timings from NV133WUM-N63.
>
> The raw EDID is:
>
> 00 ff ff ff ff ff ff 00 09 e5 84 0a 00 00 00 00
> 1e 1f 01 04 a5 1d 12 78 03 5c 70 a6 51 4c 9c 26
> 0e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 74 3c 80 a0 70 b0 28 40 30 20
> 36 00 1e b3 10 00 00 1a 00 00 00 fd 00 28 3c 4b
> 4b 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 48 46 0a 20 20 20 20 20 20 00 00 00 fe
> 00 4e 56 31 33 33 57 55 4d 2d 54 30 31 0a 00 51
>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 90e8c154a9788ad40e2101fdf39cbd92f2e0773a..9144de974f1e4abdd1af12613=
238f6f28d98fc41 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1935,6 +1935,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116=
WHM-N49"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116=
WHM-N45"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116=
WHM-N4C"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a84, &delay_200_500_e50, "NV133=
WUM-T01"),

Looks fine, but can you send a v2 with the proper sort ordering? 0xa84
should be before 0xac5, I think...

-Doug

