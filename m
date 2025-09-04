Return-Path: <linux-kernel+bounces-801231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98569B44273
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC8A0094A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD24224234;
	Thu,  4 Sep 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw8efOoS"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71E3B1AB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002550; cv=none; b=tnlWkUYFKHKV7AzmIzJHkaqjaL0/PhINUtJVUWNSI2VQSBfWjMA4PS37njr7Hnth2qXEDfEXAcVW3zTd/S4L5dGT+zrzX816ng9ConvxOIk5W6R70CDA33n06eH5pSWzjsLxwnnwcwI42vRzI7iEsX5plQGS7JGYjg4Qs2+7puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002550; c=relaxed/simple;
	bh=vze/ZlwTd5ppR7XiRhFX6wHetjbPSzhXTCHbwjcjWzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtxTEaHhT/+MkJrkN0xrnFnUxHISENhMEu0RIwEjZM1trdqhQRMsyF1vDLVlsaaUXZhl4K3R5xiUt5rMqktG48PmVruX7ur06KGY2K1UwQKM6edqeKgNzrtK+gPPpFDY+K8w2iRNLwIK80iOVCweNB2vHPK0E5CMGHIixVbEeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gw8efOoS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-724b9ba77d5so14829587b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757002547; x=1757607347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uo0RISLwmkgLCYh2IN11pINVWBVogTF0MXL6fRzX8kM=;
        b=gw8efOoSP0x2Bgv8VWhapuQ/gqlnXnPhm+T83NCk1694qd1QYa1Cnxw+75t1NgmQNc
         3Z5IGc1ANFKPVBH5IfrANYp98vENSbhF11/yPTji9x6X/lcZV3bpTXYM0/JN5zSmFmvU
         zlxdpdhgkG9OxN7aLRHHv5wwGxyaY4kMrk1gMLG9ZTs6fUPifcOdfL6KbVpgEU76JnDY
         tZrB5tq0kP4fRJLX+KXtpv2KgnVNEud4e3QIjsJayG6RIm9XBXZ+w3wJHgpd2bRalN/W
         qOpv0ibOv1N/3CbtnTx8SyhQTMzLCT5YtrdOwNYog1FsTdJKdxF2ZVoq0giPwYOIBcK8
         0N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002547; x=1757607347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo0RISLwmkgLCYh2IN11pINVWBVogTF0MXL6fRzX8kM=;
        b=oFrggmkjcMKZzvC8khYoilHS2NRnrkq23EubV+loL3Lbg+2Vxu/yBRfw99RlYxcBkO
         MeL8t5L42OE+JNFsatjhZTLSIoy8ji3Mv0CLw+fixiDG0+QlhYp4s3CGo+JgHOFkY9NO
         ibezgX1YGRMAEXWQ8BMgu5uJcfB6geZdoFGj2spUrSvf8xZQhQ7HB8WGSvJ9PYFaUw0K
         ZMN4N2lYHIbUhD2vEtQomggWmk5WzkjujfTaGm36ovnUpJAOofZMF4AlwvWSgkrvh1Ig
         zL2cKnXssemVCPfJ+5ew1lVLD27sFSbyLOXym/Xb4yd0bomFypxv0Ahr5m0dt/HraCDR
         tuBw==
X-Forwarded-Encrypted: i=1; AJvYcCW8hHfF9+cGQt58YjJh2+gyqaUMUH3qkyuLXCPHK8A9ddpt5QSBn0dJTxpTIKYri4vzQfYHAIevRArke1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAsuABM63ot7qvBpq12QVxCqLj72O8nzxr5LSno9px0RUlWQR
	aw/dQwda5DdVaYXP7C9KBxiuXl2KNMAP7Wm3VhbSsoxhAk7acj5cljBePmJSBbgu8BP2yyDoZnC
	pMsTslXJ0jnwmbySis41kU3juFB0DU6SnnupdzJgrqQ==
X-Gm-Gg: ASbGncuLBIt6OXvqEvj4HD4OwIyOgVBxmkAS0K+s4ztVInlySIhfBNws40Ng+TWDE+g
	cIzAxLHDX2HT0O6o9B7W3Yzdi7etNgQzOlmLyP7CBwO5Rp9WaJU0e5voBcQ73cHIK5YPUfY0ia7
	Q4k4U53eIEtrSum3cjVXWyXRtV88uuvF5Z6mvppn0RHzM5M+Ml4SofMAPu7p2ZkQru+QVGRTzEk
	grOMhap
X-Google-Smtp-Source: AGHT+IGSXAOQmOoToso0IfgUWvRUsTdb+WXo9AwnFjKjAqk7EZwQu7nr5DaxVSxNz2rwNfbQNvsp9DSe55yaj+5joiM=
X-Received: by 2002:a05:690c:3602:b0:71f:efa8:587a with SMTP id
 00721157ae682-7227656b2e1mr198475327b3.44.1757002546924; Thu, 04 Sep 2025
 09:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
 <20250822-pm-s6-s7-s7d-v1-1-82e3f3aff327@amlogic.com> <cce649b1-511b-4895-84be-2c85e748cfa8@kernel.org>
In-Reply-To: <cce649b1-511b-4895-84be-2c85e748cfa8@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 18:15:10 +0200
X-Gm-Features: Ac12FXzPPHOEhHKW5z-O62jRJm47PZ-fsc3O4NGHgJmoH8G2XEru5vbAJkJqx1g
Message-ID: <CAPDyKFrE8CafoKDkdHQKf=yxJjNcJUu9vFrpAASQYXhtUg6cVA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: add Amlogic S6 S7 S7D power domains
To: xianwei.zhao@amlogic.com, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "hongyu.chen1" <hongyu.chen1@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 13:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 22/08/2025 07:39, Xianwei Zhao via B4 Relay wrote:
> > From: "hongyu.chen1" <hongyu.chen1@amlogic.com>
> >
> > Add devicetree binding document and related header file for
> > Amlogic S6 S7 S7D secure power domains.
> >
> > Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > ---
> >  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  3 +++
> >  include/dt-bindings/power/amlogic,s6-pwrc.h        | 29 ++++++++++++++++++++++
> >  include/dt-bindings/power/amlogic,s7-pwrc.h        | 20 +++++++++++++++
> >  include/dt-bindings/power/amlogic,s7d-pwrc.h       | 27 ++++++++++++++++++++
> >  4 files changed, 79 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > index 15d74138baa3..12b71688dd34 100644
> > --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > @@ -24,6 +24,9 @@ properties:
> >        - amlogic,a5-pwrc
> >        - amlogic,c3-pwrc
> >        - amlogic,t7-pwrc
> > +      - amlogic,s6-pwrc
> > +      - amlogic,s7-pwrc
> > +      - amlogic,s7d-pwrc
>
>
> If there is going to be new version:
> Please keep alphabetical order.

I have just applied this, so please send a fixup patch on-top.

Kind regards
Uffe

