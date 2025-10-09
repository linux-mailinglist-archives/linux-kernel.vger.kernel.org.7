Return-Path: <linux-kernel+bounces-847321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8141BCA85E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17F9B4FCD00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682325A333;
	Thu,  9 Oct 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdLgH3Bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF8231A21;
	Thu,  9 Oct 2025 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033080; cv=none; b=E3zDtSMLJ8LNavoatQ3DZ8I9RxgwXCE/Qpm++1iOc6zDExGIu8PtkWNT+5y2Cs2cY+l/h4+OLu/dSV3DPVWgN7nmcjqOG+b7yx368Fck4Fj6lroNoHU0l1wvgQnXOeGQn5GBww/PhPNjvc71aYmSD/Z84Y5zygLD0Q8CwLFwNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033080; c=relaxed/simple;
	bh=pUktu/XMfXsy/eSkVcdI+gYii0wE1oveGYK2smdz49M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpz3bKkH4MHDt+TS5nDn/nzJMZNBJKqiKJk1eZZncYLUiqRAQIpbkMaNneZPoDFdQfvRGR2AkrzeZXIEFOF7oEMMFUYcV/3pp65T+SSNF7dkz8MF5dN2u9EBFfFh+lu2G0p3C7VI3F0kxPNTrtoi7T7AlG781MSK35urKYDcrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdLgH3Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEC8C4CEE7;
	Thu,  9 Oct 2025 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760033080;
	bh=pUktu/XMfXsy/eSkVcdI+gYii0wE1oveGYK2smdz49M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdLgH3BbksVEA9FZD0slE7fnR4aQ+SIahZQhyf/UBaMADqDNp4h217AYisXOEn1bo
	 pSXw2iwE5RNjnB6DYpBsvcA+RkB0OftqXrI8/M2hIs9XxBpln/URmbmAxFnFkD3tlc
	 WH0P0P7hUjDh6LRU6DQkJ4bzaMtdgJpphW+PAu1gN2ZzPE8CEb+df0ft+NMrYZlmT8
	 +cbcvv9nBM5Thy2QBSxnPRHg09/q+et2oJ0DvC9kqc+IOFm2AYhcxGG2MwVSE57+r5
	 HpGDAshhuWamgqbHIDKIf1nfy5qRXfGJCf11AmVu0GSE0SfDfYp6XdIQFAlz5NtzOx
	 lZt/cTrnJ3hMg==
Date: Thu, 9 Oct 2025 13:04:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 02/19] dt-bindings: clock: Add Amlogic A4 PLL clock
 controller
Message-ID: <176003307797.2941718.3816797856531029196.robh@kernel.org>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <20250930-a4_a5_add_clock_driver-v1-2-a9acf7951589@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-2-a9acf7951589@amlogic.com>


On Tue, 30 Sep 2025 17:37:15 +0800, Chuan Liu wrote:
> Add the PLL clock controller dt-bindings for Amlogic A4 SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a4-pll-clkc.yaml        | 61 ++++++++++++++++++++++
>  include/dt-bindings/clock/amlogic,a4-pll-clkc.h    | 15 ++++++
>  2 files changed, 76 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


