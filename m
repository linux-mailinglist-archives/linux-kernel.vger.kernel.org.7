Return-Path: <linux-kernel+bounces-793523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59513B3D4B1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32103B91BD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F4271451;
	Sun, 31 Aug 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbQNM7jg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179724676D;
	Sun, 31 Aug 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756664589; cv=none; b=YdycwcoYdWVHqIBj8/fHbfTokeIp3IJM7KJhFQFMHc0yDuJE4vMRhRzeePrsDSX68vkaGsTJxPgOK3BtAm9HvetgPNfv6S889sKt3ai9zDlwC6auFu2TX2Yw/fS1Tt8NbtBdya3WPtUbgHkm8aChRVrT84PZIHiGYFXaBtouOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756664589; c=relaxed/simple;
	bh=LE/s0xTjGqERQm+oRr6TmGSio6PkYKZF+Zhb64b9oaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgjspBIwHnLo3APkbuzeqMsukLg2QOjsTI6WrVXznE2Hhgj+/9Qo5ZoDsd5qfMDRQ3jrW1Fa1tNzPpwHS1y/GeFW87VIvj5AAXAyonTqDuUSndRMWaHnU5PxAATMHsKbcRqvRzAz/akQnOH84QcFVf+0euUYdL1M/8/mC2NtrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbQNM7jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD5EC4CEF6;
	Sun, 31 Aug 2025 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756664589;
	bh=LE/s0xTjGqERQm+oRr6TmGSio6PkYKZF+Zhb64b9oaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rbQNM7jgZsYAAqJOg5AXGdlP0k75F1es+bk51qcSRgX3ICqeRPuOeA5nAq83wHv+5
	 NEMxMfbiU3ndsSjKTyXg1dMhTjRh7kjJrZke0vzjO9U/mAjtpeLcgZWDApb9K04yjl
	 NzUHLHvws0C14nH0BuDsxfwrzeEKW6aaXcKVj3p1GYCtGZL9zLJJqOqK1AGxhmGg09
	 oBTUnDGZfn38xT2zEnv2PN2zvvuKnvFBs7o2BVNgCYXq9Lt0vMRDcMPDpdPhok9mIN
	 Y5HQIDJbGB3UoIZtShnY/UxM6qXyvXDx8A2GiHY6lU9gOV5HSxt7oVOHBCGVnSNEJV
	 cccuaR6WtP7Vw==
Message-ID: <09e1a345-21d5-4ff7-831c-755e00898a45@kernel.org>
Date: Sun, 31 Aug 2025 20:23:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
 <20250829-t8015-spmi-v3-1-58b15ee2c825@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250829-t8015-spmi-v3-1-58b15ee2c825@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.25 10:47, Nick Chan wrote:
> The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
> existing driver for t8103's spmi so add their compatibles.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Sven Peter <sven@kernel.org>

Please drops those tags if you make a significant change like you did 
here between v2 and v3.

> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

[...]

> @@ -27,7 +30,6 @@ properties:
>                 - apple,t6000-spmi
>                 - apple,t8112-spmi
>             - const: apple,spmi
> -

Why are you removing the blank line here?


Sven



