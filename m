Return-Path: <linux-kernel+bounces-863108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC48BF7084
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F14E8B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FC32D6E67;
	Tue, 21 Oct 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOkxskzi"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774B283C83
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056518; cv=none; b=KGVKuIF/mBdg20UK57kGd3TE/lCW8KKsYbXmAoxDQUBAP9jTe5gjhFcBVhnwrk5JPcJWAbw4FOPColpWmucyVyspxsbOMhxgOY9ZEZh/1dOIyyOp52cIquyNBn/X2iQ6jaAN1mDeJh+Ih9kNOsipL+IY35vD3ssbTUGdXz5r1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056518; c=relaxed/simple;
	bh=6K+Ya9AoUD4PI0lKdjjQSEvFS7cWapIsir5GAcL14js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLUmFiHMTVSNh5rqFGyvrztpIyQ9i+zA2Z/fmDOJP1ME/+1v+7R/6lMSe047N8cOhUm3mjb/JZwKsPoHtZA0BZ46n858uud5dUieHdnR/ZOCsFT+/naKqkQ4A1uzEtYkipk0lz1v/y5aRfaFkauwIQmt9x05LinSIpJNtmoJpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOkxskzi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so2669185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761056515; x=1761661315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2UPlKlBMRgDPmUCzuIFXxKg63hxPHeMGbfNf2loeFc=;
        b=xOkxskzioce3lQEoalZkrzKD3R5XHVi9qE97WB+cR5KCdBzQix/MGRly7XXG+BFZ+h
         vtBWPZUH04AZayOkK9XJkIcnpC85DjGiPCdpPJsL/zFQMaYREAOtM9mBYOhicr+eHK6u
         BPEdJ1OfQkXFF/D2FaVAqe703dc98Jg+ejmaLRO82GOecoPIu8V0XSlDZu5DNEiypA6D
         Ey/BmKV8ZeD8Veg63etcwX1rzoQh83F0JwLwIXhq5ZpzbzMDVhi1UCPR/UxdOq5Ka/VK
         fLuCSO3A7cHvN5wdE4h2ZqLOWxle9w/tor4BSoPSbpiiL6f6nfgwkT4wZOTt0cGjTAQT
         DSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056515; x=1761661315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2UPlKlBMRgDPmUCzuIFXxKg63hxPHeMGbfNf2loeFc=;
        b=obPW+FM4BDc8AlgLfp8lAsJCIgMYOHayDUZMIueHG3MZmJ0hckO8uBSVjdmFxvtnnq
         rH7MIznpV46IBmETjAa5mqE5EjIWeux9kgnBeP18MurewD17X43/DP/w9xYXJUXEuQRi
         jZN3hC+raPpPhA2h+yFt6tdAluAXOsy0GYDBCd2VeUhbO9ZdfJdJ1DOgN+OauGt4a1Mz
         XuGc2WkTFDEiLQ4WivUKSl12hHUhpSX77QPOZWZlmDXZWGOSglL9rPXCKXHNHxFyQwbt
         1C0mpJif8LsMNStEy4TE0IDXytt1XlZknXZZ1Cl42dm8aiUA3bZU8JJfcdyEdJGNv8+O
         dp5w==
X-Forwarded-Encrypted: i=1; AJvYcCUCz87Jn8duzEJEABQ0fWiLb+KY7faT/gsosYuRFHClFRZSp3o9a4imTfFjwNoDgdEO3UY+GFlYVji74TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEi5DzypHPbh4Q7vp9qBnbv4X6v8PdGia55cIEoJfZyQaRP3v
	ODfKhLj3Sh8QWm7bPao2LzVLalKOGmXovNQ7jBU6bVUJsl02izIvvoI4APaRTB5Zyqg=
X-Gm-Gg: ASbGncsQyw8iJklKuXSNDf5DnkgeC3GfA22g2JCMsqm4ygkb3Js5N5KYb+ziUv0Y+iT
	NCjJlKr+rZUz/bMM891wG1oisJ3oNNPpyPmzYDukDsymmm3h00kKDPWNwsdXa7YuLkD1CY3jClf
	n0PR2ZXz5wgAIT8LDVk/WfV+d1z/KbE7rVNagLYUUY5Kzwfz2YUrTeLUfXGYnYQtKEaCrQQQ9Xp
	GPMLFuJlGRQuY61RfLOjUwsCaYh5u6TGnRe8DMd3ZL2lJo46KkLr+jRVU/z3wmBRsVTOkoERidK
	FuYU7Nucw+JGLgPbxUIYe07Bib3QsgZkzXmZviXAagxF7AO2EiEfg9rVaLL7plJhN/THT13B14Y
	am6+uXElZ8hRPvH8eA3dVWqT7JU6hMEOuAw9uC9IsIIJwqQYiXZTmsQgVlDo5xVTIGJ2rgRu3
X-Google-Smtp-Source: AGHT+IFgUwtFyMQzVFuUZ9DJK1ExlofFZ2ywTH/htMIthIxsBbbqiw9fs64De3rLyJVpj6OFqtdPYw==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr133669265e9.33.1761056514836;
        Tue, 21 Oct 2025 07:21:54 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm229301885e9.0.2025.10.21.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:21:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:21:51 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 07/10] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <yyllvqn2i5mqyetf4c5c3k5xyrz2yfxwbkun22zhx6poumt7dn@k2pt6rcemfdf>
References: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
 <20251021083219.17382-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021083219.17382-8-angelogioacchino.delregno@collabora.com>

On 25-10-21 10:32:16, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate an USB Repeater device, used to
> convert between eUSB2 and USB 2.0 signaling levels, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for EUSB2
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

