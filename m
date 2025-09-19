Return-Path: <linux-kernel+bounces-824908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86165B8A726
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9151B1C83A35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBAE31E0ED;
	Fri, 19 Sep 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJN5yQZM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218231C583
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297353; cv=none; b=p7yWTkDTeNu4fFIL4s41PzHRfl99VfEpY8owC0xCwEJWhZkPVYv7BIATcPACPZ39520clv8UG2cpZOq762IOmtvotuNkBTBwGjU6gxmAQqScmSSk5i+EKdSgwGOtoXcsUv9Sjto7FOQCMo4kBKqOMEfQmIo0TCehJHhGaNLHBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297353; c=relaxed/simple;
	bh=u1c6nCIa+ln/6nkb438PUoWQZcIf7juEYcKr7Yqz1hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knMs60clUUFCgMJqXrnbIQBHLyQsCmleunrzxjJ2jfk20JQphPz6INQiHX3gAwdmUCa99t2PBaM7Khf2qOm9KUEDMDd884gLA2FuKsColT+k4BfghRp5x4Whlz38yQ9qV+huc2ZZEsqU3T6JFyc5Z5oF1GjFGVUFR+RUV7edb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJN5yQZM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dde353b47so12362905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297350; x=1758902150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhZDrVrImTATkIwPwVSPaOLUpr64DrnZU8w+ycyCg88=;
        b=zJN5yQZMN2vC0/I+GKAMjxFTyF9oRfEZY5BX4wwP6x/wl9P0/rMB0VLRob6goZuNRK
         lNigmVhAHjWVaIhGY1y1YAOV7Cdj6BPcvUgIVhphjNqK3eGBB6e3+JiR9v29hZ8KXdIE
         Ngjq7d2AhUtA1y+KBvDGQH8CEme4uJN5bbP1l4ppDariOEMIJUn9yuuewvHw2g7Cr7Bk
         RUDRvd2guWK5VjRq1fK9nGq3FmAaa/DONYWGKDHzG2zxJuQJ5c/szQV/leYVFHic7zVN
         UbSHNlc4qADnHxLxUfgL/Dl/iOvdJucWfaJVbOLpWmiQRiZe8GBXSUQme4O2Q3TGP0Pj
         u/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297350; x=1758902150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhZDrVrImTATkIwPwVSPaOLUpr64DrnZU8w+ycyCg88=;
        b=aB5Ite5exPUSInzy7nBq9+ox5/3/SZaH86efoKrCWKusb6E9/N7lSbTfrVu/DiLOLm
         hEscM8sKEPlJqJyV879X8agXc1ve03dESoTcWfsxhFKtYqHnqqP8nPRgbOrBpj28dY4C
         TH+G58cO30A1rCefRzX9AeENLikoNf0bbe9iSSBs5LOJACIAx7fT8avg1XffokqaiC9p
         wXQxzdNoaHjdsA+bkUTfRH3sokhNRx8Mu7V9l5OpZhsna+C/vTS53mvJbyaFVSJ1XhcP
         z0NHjwDGQpwza9vO3FOXjrC/Yp4C1SEz+VvfpJFIwffFjtBg5g+Vrx/LTxAsU3db4IdP
         ce5w==
X-Forwarded-Encrypted: i=1; AJvYcCX8rVyGQxkzPbSW+j5L0gypDGTuJUDLPKkFBE7YLEnB3p2uWrR+10bkqPyOaxTfMMuIF08NUhq/+zOA3t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WoybDA8e7W7lMuGHMEh1UzjHlhueZd89HM4MBbOldu1mCv7/
	lQM6qN8eaZ8iXdZiKOBwxxLSNr/CUrEx3ceQvg51YGDDIq2m5lfx9qcfHLx6IKC/3bw=
X-Gm-Gg: ASbGnctktc3BZrRn3W5s80rIW8xV1b4xSFOc3ge3wcygOvyx5av3ulgiV8QYgB+kcfD
	30kJQl9m4xfTaHhsCWJ2gGtKZwdyNF+Rx/Swa5tJPWwwMxTv9w/jhoBFBR8LmMcfO6B1zoVBqIK
	0k5kXktdX0CrCOlwoK9CL3r3+pOv2mBQM1AJBGGAOZbLOBFaeAX5tRy3kzl3HmPPF1KooovGNsc
	EYV9Yw/K6SOXCp9aH6fMJ5xvXXyh6WYpg1y35gz4R6S2eTalyCuyJpBudxiz3ZOPY7ccLxjTgT2
	Rf9SxNzMzpyupDdnqvii4fBYyW+CijDpS9l/P8t6t3WIxZ60HJJnjeax7iPbQy4xl0tkIdMZAsu
	XtT0+tExYMmftbTg1XqUjzdPdHOARUXO1D5ta0uRKLg8qjnwVAaTA/LL3EW7kJYTEu7WTM3veu7
	zOGg==
X-Google-Smtp-Source: AGHT+IEl+5i/c6BvX7hOfCLASA8xl2fHCvuhOjlzavUKXNsTQAa1+nFKeMdI1YW8d1Qlc7m1YSon4A==
X-Received: by 2002:a05:600c:548e:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-467f205a5a1mr35666935e9.22.1758297349484;
        Fri, 19 Sep 2025 08:55:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee07411f4dsm8371825f8f.26.2025.09.19.08.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:55:48 -0700 (PDT)
Message-ID: <20f38803-ea03-49e5-ada1-9998eb815f84@linaro.org>
Date: Fri, 19 Sep 2025 17:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: rockchip: shut up GRF warning
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 19:40, Sebastian Reichel wrote:
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org
> - Add patch droping extra newlines in older chip info structures (Heiko)
> - Add patch updating DT bindings to make GRF either mandatory or unallowed (Heiko, Robin)
> - Update previous patch to only differntiate between mandatory and no GRF (Heiko, Robin)
> - Update struct documentation (kernel test robot)
> - Do not collect Tested-by from Diederik, as too much changed in this version
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Applied, patch 1,2

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

