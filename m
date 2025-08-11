Return-Path: <linux-kernel+bounces-761983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946AB200BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5AE17C299
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D77285078;
	Mon, 11 Aug 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuRdQsHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1F2D97B4;
	Mon, 11 Aug 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898561; cv=none; b=Frk3HmgNDRv59jcDXuapJsMWxsEwSo5hYogTZr7KWsNkXHC96lqgGMGLoMNlZKGMbemTvbXyQx9YwIpxlUxnqk5Rkv4AxfCXhjVOR5YAW2WxB1+3/3epd050xymZpygrihzK0e3PQoOzZX0B3VzV22/wp/A8TCThBMsIKo+sj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898561; c=relaxed/simple;
	bh=wJOiDdjpV92cFWsEgXBRyCwAM5FN5aB8jQmUBXkj4jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISB+H2D5q3nKxCOevkz2Si6kXmIjso0xT/fqGIDeUQ2LMNvTlfxwZTOnRoNNDD5ja+NoY4qvkYlPl3NPZrdKmPXFWitYXlJIwzS75tNPZDXD/nJXF4Oka/3ng2dxqJcD6LCdfdGkY7o0qT/6hsN19wa5LwekcZG645360t9vj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuRdQsHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2564C4CEED;
	Mon, 11 Aug 2025 07:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898561;
	bh=wJOiDdjpV92cFWsEgXBRyCwAM5FN5aB8jQmUBXkj4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuRdQsHppCCzKTz8G1v+Zj2MCmum7EcEc6lgQWOCiG32wxatxqFjzCls6lr/mdv6H
	 tMNmou2ayFVOa5KNgqj31IsU45YQmtPoPlFx6cY4uwWZHey/AsIECNWWr3UHXfu19u
	 RoJHqxtOzmeFibiyXsdhMs7jCWQXzqUDeff7WbOAuubn+REVI9gCJ3tZ0gQm2NOK2Q
	 Dq95ITr0zo/QZmKrzOn0I7bBrRaO9VUFQr7Zft3a/cj6w2ra5MykBnl9DxIPnRFcle
	 ayOycVi+BwfsYsdgXsXeeBAEPZJPqb8jtB/o9W93YiOCVWu9fpYGaxYVM3VPyuKtkI
	 XRbQAZ6Zomcfw==
Date: Mon, 11 Aug 2025 09:49:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: display: mediatek: ccorr: Add
 support for MT8196
Message-ID: <20250811-brainy-impartial-emu-da8b46@kuoka>
References: <20250808125512.9788-1-jay.liu@mediatek.com>
 <20250808125512.9788-4-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808125512.9788-4-jay.liu@mediatek.com>

On Fri, Aug 08, 2025 at 08:53:58PM +0800, Jay Liu wrote:
> Add a compatible string for the CCORR IP found in the MT8196 SoC.
> Each CCORR IP of this SoC is fully compatible with the ones found
> in MT8192.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


