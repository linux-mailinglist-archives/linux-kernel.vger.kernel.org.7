Return-Path: <linux-kernel+bounces-743718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA6B10263
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C9E545CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515426F45D;
	Thu, 24 Jul 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVQbuari"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182826E711;
	Thu, 24 Jul 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343653; cv=none; b=Y9eeeaIcm3UZwF+LrFMbMBlsg7nI/yohMeruK4SaFchrlw1BhzyAxJ9uW88XkdywAGBrzgBiDYH+hWDEhijZtkwZHEkxHTFWB8Z2BkyJrNfakRjCpGjsidFlWHdW21rS7XidJGrnqeoIW7MbxF2GxyBAIh7VvvMHES8mHdt+/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343653; c=relaxed/simple;
	bh=fedaKSVKoXWJCia4hWOYvIVKJSIrOlYT8OjCgkSiOmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXPjDrddxHOhds8uO+22a0TOzW4R75JnCaTUumS4EkmNZu6QSp8zyECGlrY/alDPawACeT8gc2PJa9GgAzQVjxzty88hp8Tf57lysaKjKsdVv9J6SWa8VL+Vea/02mYWgrMpr8NLUooDFWJPxHXp5YAttvgN8Ox5A7hQeBRWmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVQbuari; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD5C4CEED;
	Thu, 24 Jul 2025 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753343652;
	bh=fedaKSVKoXWJCia4hWOYvIVKJSIrOlYT8OjCgkSiOmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVQbuariQMeGlvpf5+/GWEx713YyM9MPKM5KQ601HdQVS5vhpB7/mKfwKY9waABvc
	 lzeAJ1a0wBQp4pTGKr8KwYrOnQTeuhl9ljDXfw0lR2Pxlh95HcFNqp5xw1T+85fonQ
	 Ws6dM8jr82IALG7HD+9jqaZDVQGpiFvDdI3tCrzQsudEpLWWFL76MBQDKdoKh3oN4m
	 wIIm8GY6DEcPdii55F3mTnj5Gl2cNmMB5Y9hUK3fAqUdOiFhYp0tnkFxI5uonCfEQP
	 CEXOpMkaUb1kKbyE/V1g/dppXzYaws8KcRDiSDciHZzGefQkMYs46ntPJF2rQ2g5k4
	 sF/nDAWvXTKeQ==
Date: Thu, 24 Jul 2025 09:54:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v7 0/2] Adding device tree and binding for NVIDIA
 GB200-UT3.0b
Message-ID: <20250724-affable-gorgeous-dragon-130ac6@kuoka>
References: <20250723222350.200094-1-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723222350.200094-1-donalds@nvidia.com>

On Wed, Jul 23, 2025 at 03:23:48PM -0700, Donald Shannon wrote:
> Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
> Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.
> 
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
> Changes v1 -> v2:
>   - Changed phy-mode to rgmii-id [Lunn]
>   - Removed redundant max-speed for mac0 [Lunn]
>   - Fixed typo from gb200nvl to gb200 in Makefile
> Changes v2 -> v3:
>  - Fixed whitespace issues [Krzysztof]
>  - Fixed schema validation issues from my end ( there are still issues
>  with the aspeed dtsi file that are not related to this new dts)
>  [Herring]
>  - Reordered to follow style guide [Krzysztof]
>  - Removed redundant status okays
>  - Changed vcc to vdd for the power gating on the gpio expanders
> Changes v3 -> v4:
>   - Added changelog [Krzysztof]
>   - Added nvidia,gb200-ut30b board binding [Krzysztof]
>   - Removed unused imports
>   - Reordered a couple other style guide violations
>   - Added back in a couple needed "status okay"s
> Changes v4 -> v5:
>  - Resumed my patch after a pause
>  - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
>  platform differences
>  - Fixed io expanders that weren't gated by the 3.3V standby regulator
>  - Fixed incorrect interrupt pin for one IO expander
>  - Removed some IO expanders and I2C busses
> Changes v5 -> v6:
>  - Fixed subject line
>  - Added missing gpio-key compatible type to buttons
> Changes v6 -> v7:
>   - Removed Acked-by Krzysztof

Why? You did not even give me chance to respond to your reply.

Best regards,
Krzysztof


