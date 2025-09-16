Return-Path: <linux-kernel+bounces-818496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84116B59287
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F63AEA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D1D29B8DD;
	Tue, 16 Sep 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAo9gEVJ"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF171274FDE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015797; cv=none; b=nIimVwtVocJTDB5yBb2FU2x3a073ojwp/XwjKdET+baHiEKyar12XTyaBk4B1g6gcFMzKnF0nzeX8Sz8ruUDCzmr+FXb3DV9GUReSM1Xq2tgynVJOvr8WShpWSKWZda0LjQNKftJmtjzVv9N3ClGQ6Nb9Fljw+nblTsaSqWhh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015797; c=relaxed/simple;
	bh=6xbawwmBoJ+wZI7xS6DVzS80oa3hVLAsUDbr1E7VfLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTKflt75zabPlLSUODnSu+wg4Hp/ZnTmMUR+OMMJWKYXd3UR0lUFgjWF5vzsqaVc+8A3OcxbC65ovmzg20QReQ+Mnbjgv8fsbRMfXTpopKcV2e+iJMAYD0h7WaYxZ09D09tB6aPAIy76exM6ZaarvswS+3QwvVA+z/lz2YnKVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAo9gEVJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso3826725276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015793; x=1758620593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xbawwmBoJ+wZI7xS6DVzS80oa3hVLAsUDbr1E7VfLM=;
        b=ZAo9gEVJQB2epSqxvyp623DU+7DpTM7yMPaT0x1aUtSRVF4s0731wSj9CDmPhZMMH0
         kUfa9JKYZVOirN7r1EeEH/a2viDosi9ai+KEYVVJ87pl98o2wI5tgrzIfYXcEuCOm6sx
         N6+IKOV/ctsCd0P+UGO5XLbffeTL/KiHq8ZGbF60I6+nLf+PBcTQaNgfr+JMrLSWv0s9
         N+F+sLgb8UrTPBBs653nh+lngjxzEMAbWfr8/K2u/0wKFUPrhQfvHcqNdsGIwEhuRiOu
         so4zqEMwrvwPfojAL59kXEUpyab5QW5BA5oOqGeTYattPraK5P8YK9sEg88GFQnZaVUj
         60xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015793; x=1758620593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xbawwmBoJ+wZI7xS6DVzS80oa3hVLAsUDbr1E7VfLM=;
        b=gjs5iCbfqD6K+6rELjhO1lp53Icn/qUHKGHmoWw8rhoK+akKGvuVNuhZsc7MleLjPr
         GNti04jnH00025DexbsvWNFqmVW16G670+pe2gOaecxkWCk9U25etAZFxiZfcEqrymlJ
         6qctpjQzXF/P2ZcLu81r3Vx1WKwRFob9tIjEecsRXhkQk024CUmQrSLh16p9ko02C/9W
         CRzKMqyiLmimw0T4kZJufurwQ+Ix0zfUXL4gYNdc1ebeJvmtwE5t/5NYMUovHoJ4SwwX
         yz6kmYlpFGK3ovb8Q6bloH7Ace6mcdv7v6P/Lb21HrLHPasdhV83YfWzMMRkmcFogazl
         0ApA==
X-Forwarded-Encrypted: i=1; AJvYcCX7oFOu/ufjQ3eds5K1ZAzmc4JGtN0WpP0aUW0Qb2NT5oi2hrd/MpK1UjGaiVg3pvLwhP8HUxFyB55hSPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbydFmv1z9vbWq0SN50deLHI5ZmmXpDl8ovOa/v2DO+ffnAYeh
	2C4WpAQgM3Vf6mXDO50osdOaB8IgqRUIoTe2NijeX5Zi88Yg1TNEAcrrbqJznfm38JSy9D7TFV+
	yvX/A/RJoxEF+rUZzOf20v7BnymaytRQ=
X-Gm-Gg: ASbGncvW5hp05VPYCpNq1Ur4f+5bGaSrjRSR1V0L2H6eVFAKCHTdpHC/S0VDqoy6QdY
	foJ/+k7blcO5kgF2cKOK13NZdDi/cILi6RqVBjWj9XlWwnKCjpDGX7hGG9SD89zDxpLFRSXxDik
	je6IOncFac2/3fTfIoTqNZUEn7mJ8+5aN3zWbd8JxDE0u+taPoRz/Jzgzuz8zfdDee0oS646v6b
	5kEwkWN7BoSLcSjF2MSN1dy7IG3qo8=
X-Google-Smtp-Source: AGHT+IHV/RX93XAmuJF2uL0N4vvl4pBykKHWOWIaKMzu4BBoHbE2JJaflos/7YY6pTURHoTpA1UgbNRwBPMZjCyfZfM=
X-Received: by 2002:a05:690c:7088:b0:723:b16a:ce6 with SMTP id
 00721157ae682-730659be315mr116536247b3.50.1758015793437; Tue, 16 Sep 2025
 02:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com> <20250916-flexspi-dts-v1-1-61567f969165@nxp.com>
In-Reply-To: <20250916-flexspi-dts-v1-1-61567f969165@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Sep 2025 06:42:54 -0300
X-Gm-Features: AS18NWBOYsyflacEeUU1SMpoaGg-Ie2TjGzWnHyRp3ZhqTvzAQSB9G1WINvKAyg
Message-ID: <CAOMZO5CTrGA19npaW+u0=V0nUV0nAqoH+p75L06yR28DVBGfYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: correct the flexspi compatible string to
 match with yaml
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Haibo Chen <haibo.chen@nxp.com> wro=
te:
>
> According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
> imx93/imx95 should use it's own compatible string and back compatible
> with imx8mm.

Nitpick: "fallback compatible"

