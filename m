Return-Path: <linux-kernel+bounces-750257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5053B15931
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DC918A60BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF81F76A5;
	Wed, 30 Jul 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJROmsAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C47262D;
	Wed, 30 Jul 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858701; cv=none; b=mDv3S0DlJDe0kjtr4iMo4v6sOH7pexWXLkGVsdVodILRt3fu7u05hsShz3p0ctiSUQB1WqeSzvxSOxvDqqFkQTRugaDpUPGgFbh/u/KWUxB0JUE2SavKwXyYFALfRQQA1L3cC+WJAgpfbaSa1dSaXhbF7pr7hM8SmN15PKacXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858701; c=relaxed/simple;
	bh=GHNJMzDwHia/VawDKRP28HqC/Lt9R5Ms0U30Km18fGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxirT8NTkdKrrx2rpA/Vy2lfg4ANAgmsM2cy/YCiAczGuJu03zHognAcJDcMy5YeKAaHUFzTVk7XpprMVlZcnIMgDtdRZEi5uXmhPBTImLhNAAAzuT6w9uKKD6pTEDptm9pw1kEm8IkvauZw+VyrPQ98vk/SHkcH3yTrbPaKQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJROmsAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243A1C4CEE7;
	Wed, 30 Jul 2025 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753858701;
	bh=GHNJMzDwHia/VawDKRP28HqC/Lt9R5Ms0U30Km18fGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJROmsAnlyyJu0kjxDwgser2yC+n3hiMjZJ8H3L6sG9cmLRjyg6bHBzhGRYmH53zo
	 D8u69619Yr6ASNj7gnLXesZHWVHR+KiOaHPDXdMJv9Zv7MFwZADyoQnwxpV2OLkt30
	 T43LtK1YgvedGFSbZLh9n8QscuvP0d2CZCSdxwZQMgcFoyl8heoRtV7ztJVvE3c+VW
	 yDTN2HML4OydjFXGVS77nFzefavnUbuSkznZp9rTWGZe8592Xu4I8caE6c9NH1N/q3
	 NSEOX1POOcdU96THVgzxGz6hldBXruMBSTjyUcE58FFx0aQcuG2Y9MzigdfQnSmMLj
	 dL0EmUQiXfeCA==
Date: Wed, 30 Jul 2025 08:58:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Erik Beck <xunil@tahomasoft.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: rockchip: add LinkStar-H68k-1432v1
Message-ID: <20250730-striped-free-lionfish-826b70@kuoka>
References: <20250729-linkstar-6-16-rc1-v6-v6-0-92307f465835@tahomasoft.com>
 <20250729-linkstar-6-16-rc1-v6-v6-2-92307f465835@tahomasoft.com>
 <8ef3e1f4-4658-408f-8f46-ee9fc48d7a8d@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ef3e1f4-4658-408f-8f46-ee9fc48d7a8d@kwiboo.se>

On Tue, Jul 29, 2025 at 10:30:35PM +0200, Jonas Karlman wrote:
> > +
> > +		/* Middle inset/recessed button,
> > +		 * marked by clockwise arrow/circle
> > +		 */
> > +
> > +		button-reset {
> > +			label = "button:system:reset";
> > +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_RESTART>;
> > +			debounce-interval = <50>;
> 
> Please order props alphabetically.

Why the least important property - debounce-interval - would be first?
This is not a readable style.

> 
> > +		};
> > +	};
> > +
> > +	gpio-leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&led_white_pin>, <&led_green_pin>,
> > +			<&led_amber_pin>, <&led_blue_pin>;
> 
> And here pinctrl-names comes before the pins, this is my personal
> preferred ordering for pinctrl-* props, I will settle for being
> consistent.

This is not the recommended order. Names always are supposed to follow
the property with actual values.

Best regards,
Krzysztof


