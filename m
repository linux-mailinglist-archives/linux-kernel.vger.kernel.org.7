Return-Path: <linux-kernel+bounces-734229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A861B07EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34B172623
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871202BEC20;
	Wed, 16 Jul 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDYF+pVe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF215D1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696778; cv=none; b=Cp1BqsP35z7lu5LaKFyHVpRCF9IYFYo0dsG/43+vZVFQ9tnDqCJqw//x4Lg8PjKJFsfUnckMzWDcFV2w1QDn+DevFNhLTHk/DjsaWxF9WlrUykT/AdeJNVc57cY/4PiXolJzMmxZXFeq+g/RYIZjITykrJA3k175c+NR44TEBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696778; c=relaxed/simple;
	bh=NsmOJOd0s+K5m+lRJVe9fgt6mq3NwPo2ltWoeCvR03Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRVWQrCSMvnzG3KwqG2cTsr57bR3EdSiIobJSFvj1v8b3dfa/bfe91AWB/N1D9iDlKF3mtGg4SehMBuPjJHbMvV1mT6Bqh8oIK8Gr/zJALB5fKkWOnHL/eJ6hGeO0ftlWn5uYGC+THuW1/pK3VfIyujLsGPXiFXuDS9Dn7CQoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDYF+pVe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d54214adso1431255e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752696776; x=1753301576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTFRn/aeMp4S+G4FgB+Q2zAiPMprlJMkEEu55rvT0e8=;
        b=uDYF+pVe0ZgNIYc2nM6dQvRGo9V8mfm2CxMVgAzS21+VlYYKeJEdtOlrwPqXYPhuY8
         lHTXRVwOK05JKcz6TINR63Xh6SZGX+vgY6ODKcy8Dz1H2p5d1vH977ToHQNYOS4vN6vU
         J4b8PvDnG5/MmTrMaiHu9gBZKdWMahUd65uJQApuTzERKNvkUFJ3tKKLBhi6Rcn1hM5Z
         xcM1Sv7uAfSO+VxwIbGTXR3ApXbvirkUNkQxfRRr/MRiEqpaQnxtu3r2AQYMRBxYxHiV
         OcF+dh66sorwhoULF6mouxRInMTCVMif/a3fKJK7o5PrM4CTE7MCwTlTerJOXgRtMo78
         Aviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696776; x=1753301576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTFRn/aeMp4S+G4FgB+Q2zAiPMprlJMkEEu55rvT0e8=;
        b=jzRUV2ZUbJH5/jBpwG1/zBiPYgvfWuiEtDxhJ1hFG6ZeopQ7lpUPXRtALYu7suRRYJ
         zKkSJ2/G4B3VoOR736vW1UH1G0ZC5zbkWK3VzYfc8A1PeWvSigyGbI0xTRlukxwhzQE3
         0bNimLADkvfKlg8OG2Z4GlgBaPu2j57g+MjYQbeVREQN9BklqAEIUTC34rcM+YZmdIEa
         o6COna6pfUzRSticSi2SomDYFw0Tmj13QuC8pQKoU6MHC+yg6VSJmc+2+FmeR2llsTL0
         yY/E63WEzihHPfwKT+cLHs3rR4W/Rm29D3ao/36oReO5CTuE7DpctoUqKavzMxaB52ua
         glyA==
X-Forwarded-Encrypted: i=1; AJvYcCVFXji4pWiHAQUhAi8oAPSZsTl8YWo8M6qPqwmUHk48Hv7S+egNaI3HcBMaI+NP/1RK8ZH93E2DieOt9RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ElmGIon4WcEwsI5uh1ovhm5E2c1fIRCLUMbi9TnTgmnjCfhF
	6qpbd+pWETxyjNZf1MHD7c7nfgZemN/fpq1lF8vU8PsYmr+cNdzxWAbBzN5ZHv1UWJw=
X-Gm-Gg: ASbGncvrakGIYiGVps2kJOcl60/UK/JN4D6N4gSwTuqqBZNIseSyN0N/2h05Z/8ZXBx
	aHIrEXYQdGTN/A/0iH/RJtsgPz7soR/AsBfbryaD16AXG5FQk1s0sl+uSts46d8vugYkhcu7UX2
	S88joZmgF1xNZqcQWMTfsfeuMe+SvEEd/0Vw08+cmtvsVSq0thbvflAofXzVplXNfVbJ+9XK+x0
	SVB10Lz0sRF+8tiUXnlJNqULYuebNABvq5ZRKe3egCJBqWnxH1Ez/KPrOyQwbTUMszN4Y/EmU8K
	ooG0bvH0k0PtYPZopYy0FwKJfOa5MtFzpQ+PanP3+vbAJPckd5W7QwKAY0E29xVgwpQDdu6MSev
	9G4VdbOKQ47WDNdK4MlvVkoAz58OFN+HUie4QfMoipystws698c0kR/f6Ea8v
X-Google-Smtp-Source: AGHT+IECjdi+MWNAvcqWs+1OLsKCHSKbh3tJIUEemW3jQjXS2P935Ehl7efgOxAko9BQ18ZlI2cxCw==
X-Received: by 2002:a05:600c:1c12:b0:456:2379:c238 with SMTP id 5b1f17b1804b1-4563532c8eamr1285045e9.17.1752696775581;
        Wed, 16 Jul 2025 13:12:55 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14ce6sm18964814f8f.68.2025.07.16.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:12:54 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:12:53 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ye Zhang <ye.zhang@rock-chips.com>
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim
 adjustments
Message-ID: <aHgHxR1_Gzu8Dwbm@mai.linaro.org>
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>

On Tue, Jun 10, 2025 at 02:32:36PM +0200, Nicolas Frattaroli wrote:
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

Replaced previously applied version V5 with this V6 patches 1-5

Thanks

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

