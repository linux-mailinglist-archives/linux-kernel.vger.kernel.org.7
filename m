Return-Path: <linux-kernel+bounces-738522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F102CB0B996
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60CD1897D43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DD126C03;
	Mon, 21 Jul 2025 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/m9Am/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17A566A;
	Mon, 21 Jul 2025 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058317; cv=none; b=VKHUkjtqX28e0WBLcBryOaFat4/U1Ksr61de8fNO6u2G43Qc2tWs0ba2hVrB9p3F4sunP7Z2/b0moIpJjVmbGytQo3aZXjspy2Q+AvXnM3RHwXiAamnRYyGkFhvHZwHM+hxyoMkUAwY9eIUW/EgSGO7k38vJxWxXoVpFgQeazzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058317; c=relaxed/simple;
	bh=Tf3veUjimfIrNBpa8FYBGwb11HSRv9V/XjM50JJfINE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKHRLb+AH/QgplwBSyAXUNsqZLrg3laGiikexFnVYm4O4oU6jAwsgrbmEpTqVohf+Stda+F6rERNW4H5/ZtCa5mLeac1e3hFP7QGNZdcSiwhDePmUMaPuYJkizjSdC9udNN8U4Ghz1VRPkJ0t+7svMWkk5/hQscz7fsM3866gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/m9Am/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA9EC4CEE7;
	Mon, 21 Jul 2025 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753058317;
	bh=Tf3veUjimfIrNBpa8FYBGwb11HSRv9V/XjM50JJfINE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/m9Am/wlwUZrdJa9onrY5EKqAlsQgK3CiPzEX8C8BMn20SN3v06B2y7zcJ2kIqR6
	 re12Di5OWXvjIGcb9flGzaBv77HUkyrRO185HbWOA2kAEcwlIbuzmQOD2BaJAfEmUJ
	 wliG4HIMT51phluonM+oV5I/t4yGlMbqIgUijWbVpC4pWQxvpjOvkfed+Zwmvh28wh
	 QuXmxTmOQq036zcPsTb+2Nw8Hy1HZMdbKxSShn3c6lP6qYRiX7xYkP12lEoTaED8en
	 Ce4B58ZCRgwyoa5E1V1Ite7yIWX0X+bBw0wkDgFxSRH503uKVaV5fS4Z4kmov9yjW5
	 sPJ7oNa9yefAg==
Date: Sun, 20 Jul 2025 19:38:36 -0500
From: Rob Herring <robh@kernel.org>
To: Nick <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add Shanghai
 FourSemi Semiconductor Co.,Ltd
Message-ID: <20250721003836.GA3147252-robh@kernel.org>
References: <20250718121221.76957-1-nick.li@foursemi.com>
 <20250718121221.76957-2-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718121221.76957-2-nick.li@foursemi.com>

On Fri, Jul 18, 2025 at 08:12:18PM +0800, Nick wrote:
> From: Nick Li <nick.li@foursemi.com>
> 
> Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
> Link: https://en.foursemi.com/
> 
> Signed-off-by: Nick Li <nick.li@foursemi.com>

You are missing Krzysztof's Reviewed-by.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

