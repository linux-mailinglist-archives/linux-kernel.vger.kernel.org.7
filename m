Return-Path: <linux-kernel+bounces-736486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A8B09D77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EFD5A1B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0D29290A;
	Fri, 18 Jul 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCWKQrxw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B163220F2B;
	Fri, 18 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826367; cv=none; b=fZroOCs+tVD6vgS/R7d0w7MhaKpNjigNy8ISdeLlPZZcfeDTm24Td4yTIZYPJnStkfSmgF6ioKxNsLmJbDd0UtaDr9OURq214KC8lvuwew9ZWxDrGzv1AnF54Ssi0SzB70csaGiXboyn9pim1NDdEqYLP0yiL5hrmeDbXl4VjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826367; c=relaxed/simple;
	bh=nPyCE4EJ89fmwm9m6eHxfXIrYOe/RLqv1W0KQKVxAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhMB90t2vObjqWFZNj9iHEt1dvyWhqd5rDrVJY+Fr8e3nxFZMHb5L9qIZQfQORn4UsvA9zW+sGS3yvhqa3oQqJ6dnLmtg6/mjPj5WJnhXHpHylNM8/aFFw5vPv085t/QRghOuCl2y9p/hfxN+tvfC5mogxw8TGiq0HMR3IHLyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCWKQrxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87FC4CEED;
	Fri, 18 Jul 2025 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752826366;
	bh=nPyCE4EJ89fmwm9m6eHxfXIrYOe/RLqv1W0KQKVxAu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCWKQrxw4hIODjx81BJaPQA1xlN9NoK/jrwxR0cWdL8KNYM8LvVSrFrn33nkd6z6F
	 yj7aPIuc0tbkZ+I91hx+UPI1sg+lArTAf4dxbhvCaMdOwUciDadpm5IazwRPXtbXVh
	 ujM4oMGWxrzFa88FYYol01kUuVnL32p8DXs8dIktVYtxiM+5UWRay6CVKfDSW8tXiQ
	 WaRICnboRxwj/j5jxN7Ij+p5IHtu4Dz4ltalgTPV4dTzztudxnEG05IBUbSuH+s0d3
	 aePvPs1xX8y3JHI1Pf4mJlvhkZi1Fw6msIumCYut5LKIpzMGk3cEmjOOuU8ZQBLGGb
	 66Zdz9jt6mORQ==
Date: Fri, 18 Jul 2025 10:12:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Yubing Zhang <yubing.zhang@rock-chips.com>, 
	Frank Wang <frank.wang@rock-chips.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Amit Sunil Dhamne <amitsd@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
	Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support
 for DisplayPort
Message-ID: <20250718-serious-earwig-of-current-18fad5@kuoka>
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-6-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718062619.99-6-kernel@airkyi.com>

On Fri, Jul 18, 2025 at 02:26:19PM +0800, Chaoyi Chen wrote:
> +&i2c4 {
> +	i2c-scl-rising-time-ns = <475>;
> +	i2c-scl-falling-time-ns = <26>;
> +	status = "okay";
> +
> +	usbc0: typec-portc@22 {
> +		compatible = "fcs,fusb302";

Look at your binding - it said you don't have fcs,fusb302 - but directly
port plugged to the PHY...

Plus this looks like the switch. I don't think you really addressed
previous comments. Please give it a time.

Best regards,
Krzysztof


