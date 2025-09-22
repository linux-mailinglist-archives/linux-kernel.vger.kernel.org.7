Return-Path: <linux-kernel+bounces-827663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84351B92591
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434A12A412E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5A3128D6;
	Mon, 22 Sep 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ojmwYfqU"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB01312801;
	Mon, 22 Sep 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560825; cv=none; b=fY1X/Wpmj4Y82Ta3g3I8/jDdDEbLWRwxWe32502fWlkYZhLHjsSC+Jek8f7SuNBPPRgFUuvAG+uJFcGgGDbI7JFWj0kYlsw1BE2PFZOfXNXqku/gljlh9AyzIQtePYB4aJOqsph40pooPtELUuaNBmeva4iOWWUdH+Y8SH5l/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560825; c=relaxed/simple;
	bh=vQJRsj0jxkKp+AedBogVahhGsvxI0h+wyN653B4zDZ0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JsXWVCAvBJRKxV+UJZGKjat68HtgzmyX2U9Y7VP+iLw/BE/qwDckSPBZMGxIfHajRPUJML9DzXeNyQ2eIawvOqltVKKycwNf1WrrY0Y6GOkNHSq69PpHwYP6fQwfFH5304nP6UddtLpW2XsA5OoOPHsN39jIWe8mcxZWx4565+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ojmwYfqU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758560815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Czn2vrlolGeYQImejpAr7KFt5Sj149E/ZMwKdYUmdVs=;
	b=ojmwYfqUYRslwx9vrc6Vkc9cUh/s/av1mcLNGO7ucF+zTT6OESF9DAe4ez6x51V0FNbB8g
	rb6oZyjIhxCHPiwYlPVGDXkkGQepwQkUvB97umvVL6TEstsXVV8fzAy1Ort9Kw66MF8gsS
	PGua7faiaSFvowWcas8HN9eRAZKd96TpBXV+qyzcJ7N8ovITJESRy7PFG4q4i5y5TiGhJa
	13W4iqoAwtNTah8wRhtOGhUUgBlraXiOKiF9rQPECYD64Zk8WzpIpnLQ1+LmS2Jm4eCUMq
	4p4IMsgCeGHzGV0WUcRSVv2ObP7f+VG8rpXqhAq7wPTkRqAx9cE5dtPMONmhnQ==
Date: Mon, 22 Sep 2025 19:06:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Ondrej
 Jirman <megi@xff.cz>, "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
Message-ID: <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Rudraksha,

On 2025-09-21 23:05, Rudraksha Gupta via B4 Relay wrote:
> Throughout the years, many have contributed to the Pinephone Pro (ppp)
> development. Unfortunately, these patches are scattered around various
> repositories in different states.

Thanks for submitting these patches.  However, please expand the patch
descriptions, because their current forms are too terse and, as such,
simply not acceptable.  This applies to all patches in this series.

I'm also under impression that you're submitting these patches upstream
blindly and without researching the rules that apply well enough, which
may not be the best possible approach.

Finally, please refrain yourself from sending multiple versions of the
same patch series in the same day.  Doing so makes reviewing the patches
unnecessarily hard.

> I will be attempting to upstream these patches. I will start off with 
> the
> following small series:
> - Add light/proximity sensor support
>   - 
> https://codeberg.org/megi/linux/commit/f171bc7013bc7ad3de9af817bfbcbfa548ebe01c
> - Add accelerometer sensor support
>   - 
> https://codeberg.org/megi/linux/commit/b0bb7633e073a6760fa213b8c4a78ea2e73c7bf1
> - Add magnetometer sensor support
>   - 
> https://codeberg.org/megi/linux/commit/2f7e67f451f16eaf15b81aa1dbdf126d54927d35
> - Add mount-matrix for magnetometer
>   - 
> https://codeberg.org/megi/linux/commit/d7cd2eab931e32fa94408a96d73b4e6c0616107a
> - Fix voltage threshold for volume down key
>   - 
> https://codeberg.org/megi/linux/commit/7c496a5cc27ed4e38b740f36c2d8b2c62f80ae54
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
> Changes in v3:
> - change magnetometer mount matrix
> - update volume button threshold
> - Link to v2:
> https://lore.kernel.org/r/20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com
> 
> Changes in v2:
> - remove usb-typec node in dts from light/proximity sensor patch
> - Link to v1:
> https://lore.kernel.org/r/20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com
> 
> ---
> Leonardo G. Trombetta (1):
>       arm64: dts: rk3399-pinephone-pro: Add mount-matrix for 
> magnetometer
> 
> Ondrej Jirman (4):
>       arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor 
> support
>       arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor 
> support
>       arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
>       arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for 
> volume keys
> 
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 42 
> ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

