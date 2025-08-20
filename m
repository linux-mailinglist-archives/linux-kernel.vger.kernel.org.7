Return-Path: <linux-kernel+bounces-778448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E42B2E5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662407B62FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690E26F2B2;
	Wed, 20 Aug 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7rJGYtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44A19258E;
	Wed, 20 Aug 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719425; cv=none; b=rDpFrGJOR0jMSGQU9hjFL8akrKeAdpkYCqyTXCyB4VBSFzBzWn7m7xgEIu3TqfwosD5Vhhb83o46xIQ1yxP/Kn97Ghq12U8CRNblD+uLutC93QAij1i/YGM1rnVbF/43h2NDdwKljp5cpCpapsaft2b531c8/uiDN1ZZLWNBaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719425; c=relaxed/simple;
	bh=r6iMraPBVq5HmxH03yv8e99Hl28kngFijjT/l9Wk/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov72Snzl9mHG7YO/sAAvSEw0zP48mrdHFhEkxj3YMkHRg1vU7TA0+B/4bi011SS8qEEh/PcifGfKkqpA+7t2EfeAf8cYNIxwZtnChmMzdyWGLOzVuqaU/wAezQbZmB989J3S62GqTSi1thEaBbf8ELniY9zV7QZXi/I/blV95p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7rJGYtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCA6C4CEE7;
	Wed, 20 Aug 2025 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719425;
	bh=r6iMraPBVq5HmxH03yv8e99Hl28kngFijjT/l9Wk/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7rJGYtqy4Jyk0nL3dJOj5ImUnjo2/2cJgD28i3bUAPRcWu8D+4bIunMIBc+CerA8
	 9+bmE88oxKZFlv7m/6wCy9oMRKJvO7bpqkUIEwSX6o1cMFywBTwBnEpBWuRuJSqMV5
	 O9XYfeT9d9h9BAcRRdR1MvtKiDdzS+VSAsnmBSn7DBQUo9rYjIAegX5nGuLcJWHnZG
	 MJ1PO9q2sezEy6VOAjWcnIwxPEkNZNzmbTSs5bENe0yN5PZSP1eM3O+XwnGTe/563G
	 6u9sYqMo4BS+gP13KARTJu49AseyiWmz6QQWjsT4Jd8V0Uen9SKuPf3ddzsxudNcI1
	 xpNxfRuqG646A==
Date: Wed, 20 Aug 2025 14:50:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: mfd: x-powers,axp152: Document
 AXP318W
Message-ID: <175571942429.591415.10096383115657282059.robh@kernel.org>
References: <20250813235330.24263-1-andre.przywara@arm.com>
 <20250813235330.24263-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813235330.24263-2-andre.przywara@arm.com>


On Thu, 14 Aug 2025 00:53:28 +0100, Andre Przywara wrote:
> The X-Powers AXP318W is a PMIC used on some newer Allwinner devices.
> Among a large number of both DCDC and LDO regulators it features the usual
> ADC/IRQ/power key parts.
> Like other recent PMICs, it lacks the DC/DC converter PWM frequency control
> register, that rate is fixed here (1.5MHz on DCDC1, 3 MHz on the others).
> 
> Add the new compatible string, and add that to the list of PMICs without
> the PWM frequency property.
> Also add more input supply properties, for the two more DCDC convertes,
> and also for the split ALDO supply.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/mfd/x-powers,axp152.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


