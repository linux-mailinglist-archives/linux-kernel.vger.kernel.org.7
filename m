Return-Path: <linux-kernel+bounces-801551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7351B44680
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE25E562198
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD92727F5;
	Thu,  4 Sep 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJImzx5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58A1E7C03;
	Thu,  4 Sep 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014617; cv=none; b=V1EUdfkggK82WE3ydw1G9A2NJxtYURAr1r00bS+Y51hqU9o/MAWlJWmxhW3isF9UYNHzpMaxrWnfvREc4ntR+siE97AOnFDQsmdoL9tQHEbhqj0jHh5tJW/wMZ30kFaw1rCXeOFrE7WNvzVCeg71j+mY7nQK7D0pP0VuaYZnILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014617; c=relaxed/simple;
	bh=TMssmfr6Ux793m0iP09iig4VNiue9TXEr6uOT9wRYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0u1nCsOKUW1u7Xy7sVR+Uuok/4FtZDMYz3NOVH7H33VfuQq9f5LDArKYY+zN41x7mflCrBghCF/l5N7g153wkkgJsQdqhXu/5WntYkAKCeRhcrZIcw6U8AOLajOBbqN8zd8/uvoLzSlHE+aNIqvOkBDPxJxqpgFhkY/+RrkF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJImzx5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D15C4CEF0;
	Thu,  4 Sep 2025 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014616;
	bh=TMssmfr6Ux793m0iP09iig4VNiue9TXEr6uOT9wRYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJImzx5cDuiFeFmQSL8Cyu3xRKCrBD5sWxQ2Le0I56vnWdKFpLMCT9y4LXGoheCjY
	 4QXC73XnTdYebcEo6/pf8gFMHgBckDeHAWJZqcFBUqPxRioOBJ2dgjHTIQOvMSR63/
	 Vj2OYKwyMhFyQKyWSesD1d1jyIJalsxs2MCgcLsH0or3Y4TV+865UTp08IPD22zelf
	 0BnaGNyTHvcENumpYw+yYS7iIbt5ZlgecRkzUL6UeZVlBJIFeA+nalxm8fHJvaVO7b
	 ncJCn3Ii2lUfLgLSoQDYzdV9qlDC3t/LlpqncfplJHQK3SkUqn9zsWdvx7lY7kegTl
	 WcjCbI5grRBuQ==
Date: Thu, 4 Sep 2025 14:34:35 -0500
From: Rob Herring <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joseph Lo <josephl@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: tegra124-dfll: Add property
 to limit frequency
Message-ID: <20250904191702.GA42937-robh@kernel.org>
References: <20250903-tegra210-speedo-v2-0-89e6f86b8942@gmail.com>
 <20250903-tegra210-speedo-v2-1-89e6f86b8942@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-tegra210-speedo-v2-1-89e6f86b8942@gmail.com>

On Wed, Sep 03, 2025 at 02:30:16PM -0500, Aaron Kling wrote:
> The dfll driver generates opp tables based on internal CVB tables
> instead of using dt opp tables. Some devices such as the Jetson Nano
> require limiting the max frequency even further than the corresponding
> CVB table allows in order to maintain thermal limits.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index f7d347385b5775ddd702ecbb9821acfc9d4b9ff2..8a049b684f962f2b06209a47866711b92c15c085 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -70,6 +70,9 @@ Required properties for PWM mode:
>    - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
>    - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
>  
> +Optional properties for limiting frequency:
> +- nvidia,dfll-max-freq: Maximum scaling frequency in hertz.

Use standard unit suffix: nvidia,dfll-max-hz

> +
>  Example for I2C:
>  
>  clock@70110000 {
> 
> -- 
> 2.50.1
> 

