Return-Path: <linux-kernel+bounces-781314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C76B310EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F715659BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811022EA49B;
	Fri, 22 Aug 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPLcFWmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE5296BA3;
	Fri, 22 Aug 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849511; cv=none; b=DXBvFYlr/AmTQTW0JNT/uQV6uU1Rqirl1NGQT8JIxlpdYLpKhbkvpMy1jyA1unOX479ZkjGAz3SZkOeSw9B7fiaOdgULzfQDkKH3yodlVXS+oUMAORSUgJmdF0+a3eTVNUy7hj8O4w+IaW2ctgWiI6TyeYk0NDbJqhbF5WTdM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849511; c=relaxed/simple;
	bh=Ic6PVseco7YUJ8wYEstg8CtOnWLOrVI1ECZNeO34Qes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwMQopwIglZ+J3yd/iLhoH0s3w/wlJDjxmdrIgbzjmqI1ppvPxLhlTnzBipPr1wRhkYR3Wb6EFT/+lKtFKOwK9p4ryShD642FJF3PdwaQyt2m8ZfALK4Bc9+9yP7agHPluyOkLgaby4/OGutg04MpBBRpji7VlLOC9H+FWC+a/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPLcFWmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC6CC4CEF1;
	Fri, 22 Aug 2025 07:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755849511;
	bh=Ic6PVseco7YUJ8wYEstg8CtOnWLOrVI1ECZNeO34Qes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPLcFWmIxPLVNhqJEwBoSDp0zB/gcFblbe5q+Tlg1+pt/QzDARCXJWMFBaen/AtnA
	 O6dBLrX0xnPHYsztCxM3D8clirEE0srRySAengcBC+F2S8aLnIBnrnXnUMJP325ivh
	 8o89BJf9hxbfhWZb4CKD/E5sb2C1jR6lafoV6YSmFL9peYz/pvgw4b8TCn4COQvZfg
	 MarhT5PatESobSxWIhMKy9XplyXaQBVdjlWrdWPvAq1dbcCfd7rnTIMRjeRPwpUMqr
	 f04lwgKQwgC+ayxHdwmwKljauAZITXP4mnyS4OPwGPmV7hxHhWqSGcMCnCFbOJzSKH
	 wHM2BTiGlgiFA==
Date: Fri, 22 Aug 2025 09:58:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Message-ID: <20250822-notorious-lively-wren-c4540a@kuoka>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <20250822021217.1598-2-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822021217.1598-2-jjian.zhou@mediatek.com>

On Fri, Aug 22, 2025 at 10:12:08AM +0800, Jjian Zhou wrote:
> The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
> messages through 64 32-bit wide registers. It has 32 interrupt vectors in
> either direction for signalling purposes.
> 
> This adds a binding for Mediatek VCP mailbox.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  .../mailbox/mediatek,mt8196-vcp-mbox.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


