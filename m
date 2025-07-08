Return-Path: <linux-kernel+bounces-722315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B228CAFD7D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49C03ADDBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFC2222D7;
	Tue,  8 Jul 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXZXtSc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704B224D7;
	Tue,  8 Jul 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005078; cv=none; b=Xgox8Q9HnTsoSio/H41maQKtZk7OslvZDXCjv5rN8vEZg6Nc8yxs8HSetA7zbpZ3yAZ5HzI+Yl0RvLsTfkUfi2xx2QqyQci0qTU8hdEBE3XCO0G3OVwC1rFqVDEn0uRouvI5xrFTYhRNaPbmtSs00WoZeHfZIrpRGyHlBoJYn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005078; c=relaxed/simple;
	bh=WN1ciI/LBieroqRWpekh0sk9z4c32M5Jn2j2cKXXWbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtLmM6I4LZlR59E8/qEkhOrRphUMtuzoVOg20kRaub2Nd08ZzNfJO78RJiUUQDrgIw5UZU/zAU/IjAtnszjLNnjnvCAoHKMxGLx0FDVVjYFVFU3sdxDHRPOyIpQ01+Us6rW4yq1TH103j3XuFP0iXwCjuc+znkT2xX45ixClMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXZXtSc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74CCC4CEF5;
	Tue,  8 Jul 2025 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752005078;
	bh=WN1ciI/LBieroqRWpekh0sk9z4c32M5Jn2j2cKXXWbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXZXtSc8A4M1kGlmmHXWb8WChesdfRf/CIbbhEXgPJTuajjcvw3s9028JCk25xnxq
	 TYBOSLzvLwMcs//T9t2W31twuSOwleBbh4pUthoRYKRGu0PcSTlx6S+JHYT8tjmoly
	 sor3zkrlM50x2wIGRByPFSb4sBGvWTOIo6AmyRUpM1vbBd43Htwi12+OuQx8MlVBpQ
	 g4BrGONzUhh8OX7AJtkMI9A2b9S1BM7mXzq+Ni3gjTdNgN3NZEooxXVlLAxSDHCK+c
	 z5CTPG6h+9ccQ6MiZTos1Pclvqzk4RUsVjYZcIavkOaDUfAIWkPuLYg/88hESurgjS
	 OCPtOGqgiVfSQ==
Date: Tue, 8 Jul 2025 15:04:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com, quic_jesszhan@quicinc.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, hjc@rock-chips.com,
	mripard@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org,
	neil.armstrong@linaro.org, nicolas.frattaroli@collabora.com,
	linux-arm-kernel@lists.infradead.org, andyshrk@163.com,
	dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
	maarten.lankhorst@linux.intel.com,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 04/13] dt-bindings: vendor-prefixes: Add prefix for
 Shenzhen Bestar Electronic
Message-ID: <175200507614.878155.13962765298111291094.robh@kernel.org>
References: <20250707164906.1445288-1-heiko@sntech.de>
 <20250707164906.1445288-5-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707164906.1445288-5-heiko@sntech.de>


On Mon, 07 Jul 2025 18:48:57 +0200, Heiko Stuebner wrote:
> Add the prefix for Bestar, named in full both on Panelook.com and their
> display datasheets as
>   Shenzhen Bestar Electronic Technology Co., Ltd.
> which produces at least DSI displays and maybe more.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


