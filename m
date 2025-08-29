Return-Path: <linux-kernel+bounces-791984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B85B3BF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFADFA01F01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5950322C7A;
	Fri, 29 Aug 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="WcJJZrBM"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCE314B82
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480893; cv=none; b=V1j5cEXmo+zOuCTwr8gYvTz4MJv9jPgjQTPC37btFmh65NW7IW31dQtEOn5LFUEpVdUVvGeII5SSmpbuLblqV/N2AZs995WvFn+2nDsXMerNa/9ZC3Ee2+gzS7JG2IOYs7eI31QmYCuIi6aUMXzQHTcyBbXzDZFaQ686U/mCBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480893; c=relaxed/simple;
	bh=9qGTzUnZwA5hWGSzDvo3QOcy9ASgXGkwL37lH0AAk0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCQis/DJVcpKSkXA/dNhByOhJCoXaFvgQRGkzpr7/VIeBKJmRMQRnb/N3PuEh6ZyCLFGZ0vZm9YVP8odCW/XijxIfpqkQ27B0WqHOISDgOuM/FzE4qPAieYbDoQ1j+6y6QjbV859HqA0sLy3Lj5xvcBOisAOt6MJFwd+EMtKuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=WcJJZrBM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f6f367a1f0so264133385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756480890; x=1757085690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2IYwgECH2Vb0kFa6dag8ngSP8oduCmQ/9S3DpTHTLEQ=;
        b=WcJJZrBM/MickWCR2HxmcM8TnQzOoXB3jSChueSUHzvirocZDurwXaDkPsBNajkaoe
         h+o4OZM/0n5aso7xjQZCH5nhBpLwrrD8m4dmxchRgtZ67eVw5AXqjwQMlnqKAy5/Un8y
         4QrqmRy3lYbNdgZyCfJnWZ/8KHqzLg2/ZZ10P8Qc4g7v5HVyUe1RUjZdPRBYyaJqT0jo
         elmVSo5E1la4+QRQdPS3OkUTOHOjfQ7EZKYkGMY1kir/r56P/ydTfi98Fu2D1BducWMD
         Xm+cC4JEZF7ETiCVfOfeFIjl48IXWQk3BSZ9uupj4vxY8Rd24acJwfQv7COY1o6sxka0
         OSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480890; x=1757085690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IYwgECH2Vb0kFa6dag8ngSP8oduCmQ/9S3DpTHTLEQ=;
        b=lex+Zt7tWz8ZpV/Qb3W83akJapAFvt7jkTbZQgIGYUgnuIpi9gMPFIB1rzp2DKSk5Q
         Xw4quKYuZdFSPbXX4tfplORtbP2EnMq4zNaWEUNVKaTdWFbb7GUnKpemANfBdJrICVYu
         xX6LTbAxanLFjeylVI/lcq1M/RXGababYAW5zGZHOVkAP0C1fCLS5WkMwXx++vTRAZnC
         K4pvTKGrVC4YbC1gijQ+rAO1sikIc2lCLbPStmLQDfUWjkmba57A4bDUiASPobn9wqLE
         Fyv5vVGx0euL913vvu2VN4uDW0f2YiaHyNbfEP+NvO1CN5ha+ma2TfhHAOiTfreHdrDe
         YDpg==
X-Forwarded-Encrypted: i=1; AJvYcCX0VL4dd97+B5IyEiVKuGH9YvH2h5FBEFVMHQi+Ug7buS5S2WBo14sADE3ezF1tAiEZXo+BC1+Qjx9501I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEjX/cG/txQL0AkIt0RKzoV13PZAcq1ZMy2ojAjdmNQlI3mPr
	je5Kgt6TiNP/lsoHbjpYyyi981ypk0+iT84ESOrdzmxDTGU/g3zXW7Puw0LzwkZhTVTMOQMB6UW
	HO4ZG3VTR20cSLOaLost7qbAkJt0JbT6M5EGtF6OEKQ==
X-Gm-Gg: ASbGncsHSBgRo3vC0b0ftAHvjzA+57ptg/ffZItmO7xy6XnQHdu1oHJUy2GXt5Wkglo
	ci1s4hYgur9IERRzCjvU3z8GZ3fWSIMDczVSCP71Rxd2nSuy+6z4mI1tBYB7It3Dtwhid7JG8M7
	ec2Qe9cNyDN4aAb/K16uNLOIhv2Vx0PeD0SBUoAjKm0D3NK3h0GCmbK+HqfHdypUJMnIdnFksI1
	XViuF4fxVrxeJHg
X-Google-Smtp-Source: AGHT+IGeGmVh1iUNjv0FS+p5OGgAJSDw8wtHxZUJDzpWlckzaiRoFpBbLnvjd7wozfAnhZJNzyKKXYePs5Pqdj4L88E=
X-Received: by 2002:a05:620a:a10c:b0:7ec:7a3:8376 with SMTP id
 af79cd13be357-7ec07a38426mr2536339485a.30.1756480890408; Fri, 29 Aug 2025
 08:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com> <20250825-rk3588-hdmi-cec-v3-2-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-2-95324fb22592@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:21:18 +0200
X-Gm-Features: Ac12FXytZj_E6GvxXMIzP02g9SBaLQPs3U8ehFPd5hZi21QBz_4X9pHHnSFdqno
Message-ID: <CAPj87rN55DOhWeCU1o0=rOkGbrP4M8v+a6xeB5eboLdCiJ-vzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] drm/bridge: dw-hdmi-qp: Fixup timer base setup
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cristian,

On Mon, 25 Aug 2025 at 10:57, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> @@ -1255,6 +1254,11 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
>                 return ERR_PTR(-ENODEV);
>         }
>
> +       if (!plat_data->ref_clk_rate) {
> +               dev_err(dev, "Missing ref_clk rate\n");
> +               return ERR_PTR(-ENODEV);
> +       }

This introduces another bisect cliff, as the Rockchip integration
isn't added until patch 5/6, meaning together with the previous patch
the driver isn't usable between patches 1-5. It would be most sensible
I think to keep a default until the users have been fixed up. But
maybe a better sequence for this series would be:
* dev_err_probe() cleanup (easy, no dependencies)
* add refclk to plat_data (populated but unused)
* use refclk instead of hardcoded frequency in bridge driver, make it mandatory
* add CEC IRQ to plat_data (populated but unused)
* add CEC support to driver, probably make it not mandatory to provide
CEC IRQ in DT since it doesn't seem required for correct operation?
* enable CEC in defconfig

Cheers,
Daniel

