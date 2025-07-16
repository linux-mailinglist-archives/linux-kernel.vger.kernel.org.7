Return-Path: <linux-kernel+bounces-734221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE423B07E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B60A1C4310A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03C29AAE9;
	Wed, 16 Jul 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZGsa/Yl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C47288CA3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696464; cv=none; b=cIdwHP/1mF4LPTRVK+0YPjxWL10Cve8HE5trTQt43P3KapvIr2/Aq+pCBsSkOniI0BjGpHirotPFHFt/HuKOT+coH/o8Nc4EBD5CwkyjEpom7UvBVHa8AYY7T6NOTFy5KEJmLFKfHgYhPnWkr72iI7tvgKOevIllc10Mc7WXQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696464; c=relaxed/simple;
	bh=UyObCUxqurjaJRCqHz6OFmXVEXDt0+EZaGsft1tLBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afJ0z4q7FMBb0WfTzwdB5JnvNa9qgvuUgogmB650TDASVeluqwIJVuRPMfn/a8qs+wLov7TmcAmRLIGq0xW0QqA4jy5vhAYJXRh9nnTyINfCGCrLQRMGzRonK9up6ovIrDoAI5sxXxVLFWpuXQIEyat/R3FvpG425nxCLVjvAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZGsa/Yl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so878715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752696461; x=1753301261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w1WLlTjW19FslTaCwhT5zGrQ10SG2D6EnCZ8yjnDcW8=;
        b=uZGsa/Yl19gN5iE/CuA/d9MJhEIsLPsdjyNxnDH6fP8yS4s6a202lffTStbm5Ln+qc
         vwZtwp0Df80bh7ztCoBoNqx6GmiGwcIv140JoDSeV8/644dHhTz4CkHgHRd7BIF7Cttg
         9/fjhz+C+4qSnJQ+37OWi88wuQv3Mvjs5hKLAVjHBOAb68IgZvpL78weCnYNEvNbzxq6
         7JbHnnBrmR/9tOcl8ibkr6RlErKjp4fbWxGmpiuEuIOKX0/OeKsPfo+IXMvU8C+gfOdy
         jhfqGrnY6zKYwO/xg2YwFQgN/yefewcgwAF2HyIcMIqqtrQYXH7XZdtXAXQyW0VLvGcG
         DDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696461; x=1753301261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1WLlTjW19FslTaCwhT5zGrQ10SG2D6EnCZ8yjnDcW8=;
        b=ATLUQHDsEEKckNTBES0fF+jt2uhWoQnbELT6PQqb+dnjERRall0qkvnm4ctP3f44qC
         8mFCqHxMUO11McRzvdk5Cj3EiaS4Tzb2nWpLwk1Bz093z1/K0TEIzX6xRU/lA/74FSFR
         1EEZyh9XGDnm/7glObUTEZmYBAoGQ8Np8p29AXnOLlmoWPLxPPeU6izjVablAgDFhtEG
         xxJzq++4McxZu1Bt0RJ40u4vPB+LeWbcrelMnCr97w64LXPIG1/twoceN+u+/XgLOE2S
         EmQJpfq6e0zflaWOfc3DJku7OqXG3rdkKEd1SE/oGHM7h+5caUi3yYOxuOzn8L0CPd4o
         eymA==
X-Forwarded-Encrypted: i=1; AJvYcCU0DA0YvakUELY4svtJBncVnIK3NkD1hnD9Mi7uL8jCIUid8UCS6y8+kayxiEdqJGB8MidinYolOFqkdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUI0ltn51HDpt0ILWVzbGhJw9Fb29W8j0NFQo1Yhc/ynY37mr
	6z875XFPxCBUEEi3fWezBd/K2qHMgLfs/d1AVs3qDZAZ2b0WJtzF0eOtCgYTMmhAhag=
X-Gm-Gg: ASbGncuE+xXY4VX/ukpZqcnKBtTYOZxv0B9RGvy4Vm+DtxuDNWcnH7kIha9QsTfpj0f
	cinEMlkC2PYGZLCo/8N3Mtp4oxdUGOr7iRAixaLG9v3LzF8wCSpP5RLoPkH9UeEUUjLqY4e/7xh
	VGtcHwM8nByy/VORGu1mwSWUieGBouUUfHVDUl/Dyo6oNK+pCHfWe90k7n2Ux0ItL+ESsNEt/Er
	tBK0Gfx7bRXNMrmq9ajirWDz5hg2CgP0B6F8SbdaoA/4fo7w1WSzXMyfFB46kpdojuCeRmuV8wO
	BdlRWxXjKbqQhM8NUE9ofPm0SrnIAwcRTDkAUlyODqD2HimRMa+cik32g+H/optGDjlhQE0dOGl
	U1tvX/x3Qh8CGmP5k1PM+QR3RoY70J96PTbRkjSU56mMr/4qUBPtrB6K/t4B7
X-Google-Smtp-Source: AGHT+IHT3o4sXi1laaCHvSW/aSr0v5yQgUvC+MexriUEjp2oVZFYKTPhi2Nt0Gx2Dn49BxLlEmtWJg==
X-Received: by 2002:a05:600c:5187:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-4562e2749bamr35356605e9.21.1752696460699;
        Wed, 16 Jul 2025 13:07:40 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1647sm18630864f8f.1.2025.07.16.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:07:40 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:07:38 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	Ye Zhang <ye.zhang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/7] RK3576 thermal sensor support, including OTP trim
 adjustments
Message-ID: <aHgGiojM3nnNg8Bk@mai.linaro.org>
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>

On Fri, Apr 25, 2025 at 09:34:34PM +0200, Nicolas Frattaroli wrote:
> This series adds support for the RK3576's thermal sensor.
> 
> The sensor has six channels, providing measurements for the package
> temperature, the temperature of the big cores, the temperature of the
> little cores, and the GPU, NPU and DDR controller.
> 
> In addition to adding support for the sensor itself, the series also
> adds support for reading thermal trim values out of the device tree.
> Most of this functionality is not specific to this SoC, but needed to be
> implemented to make the sensors a little more accurate in order to
> investigate whether the TRM swapped GPU and DDR or downstream swapped
> GPU and DDR in terms of channel IDs, as downstream disagrees with what's
> in the TRM, and the difference is so small and hard to pin down with
> testing that the constant offset between the two sensors was a little
> annoying for me to deal with.
> 
> I ended up going with the channel assignment the TRM lists, as I see the
> DDR sensor get a larger deviation from baseline temperatures during memory
> stress tests (stress-ng --memrate 8 --memrate-flush) than what the TRM
> claims is the GPU sensor but downstream claims is the DDR sensor. Input
> from Rockchip engineers on whether the TRM is right or wrong welcome.
> 
> The trim functionality is only used by RK3576 at the moment. Code to
> handle other SoCs can rely on the shared otp reading and perhaps even
> the IP revision specific function, but may need its own IP revision
> specific functions added as well. Absent trim functionality in other
> SoCs should not interfere with the modified common code paths.
> 
> Patch 1 is a cleanup patch for the rockchip thermal driver, where a
> function was confusingly named.
> 
> Patch 2 adds the RK3576 compatible to the bindings.
> 
> Patch 3 adds support for this SoC's thermal chip to the driver. It is a
> port of the downstream commit adding support for this.
> 
> Patch 4 adds some documentation for imminent additional functionality to
> the binding, namely the trim value stuff.
> 
> Patch 5 adds support for reading these OTP values in the
> rockchip_thermal driver, and makes use of them. The code is mostly new
> upstream code written by me, using downstream code as reference.

Applied patches 1-5

Thanks
  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

