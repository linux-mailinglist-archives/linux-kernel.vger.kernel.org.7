Return-Path: <linux-kernel+bounces-722319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9607AFD7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C911895F25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8423D289;
	Tue,  8 Jul 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfgBvxJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0397464;
	Tue,  8 Jul 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005404; cv=none; b=sBGKxG+jO+88HuOTvvd7qcZifnyhWx2Lr0fk/KawSMtwPVUbve/C13tPsiYpS4EtfFMa5YvLt89eYE18I5s82d+1JrSMNuNAGLeWdxH/DEVC5L3D7fFY1KzrEEH8OikSoNYFb5KtDsA8Or4OlztEOM8YrPPVyBS3WjyJNRKdf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005404; c=relaxed/simple;
	bh=ku8L98emvYfIz4KPutlqA+m9OYjVsmlwLx2UjJrAYKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7zfUckx4exau6eBBCclwcZLXhH+IoHBiuwqihGRJU0GXAcY25PRqbf8N/XFXv7ftqnf3sxT5KzNz6dXba3scw0/AIrPRJ60jGOH7pz0MH20aGVp4/tt48N8LowXoxkTIrdTV/tSELKR/oHm2harqqry2TnozAyELSTz8t8uXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfgBvxJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36164C4CEED;
	Tue,  8 Jul 2025 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752005404;
	bh=ku8L98emvYfIz4KPutlqA+m9OYjVsmlwLx2UjJrAYKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfgBvxJrGxsZR5xYwilNvEoJfRN3Bh0FtmvTXJ3vipPzA7HmlrqkVHD8Wdyf8pyer
	 YqLQlLGQwahwyhNPrFb2a7ku9wh+7fvUUjSEwlyq5rlZdDoaqFJW8LAsf7nzEsY8GO
	 4uKVJqrc9MM16llgqXaNZy3Iz6hpTMma8ykcHTIMnshnweFeoQyW5cB9tFrMhNLXd9
	 NYs4j8xWouuv5h0+weX7gwkS9hU1poagWDZB631nCit1Hpyk6PACUPoh6Qtvb2FRSJ
	 53cNnOotNo/Q8dUqEuTBhZ8yeqe5orammUyInVm6dt5363qKvFh8cN2hEz4VOk84NR
	 ZyhB9kzoKR2LQ==
Date: Tue, 8 Jul 2025 15:10:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: tzimmermann@suse.de, nicolas.frattaroli@collabora.com,
	hjc@rock-chips.com, maarten.lankhorst@linux.intel.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, andyshrk@163.com,
	quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, neil.armstrong@linaro.org,
	andy.yan@rock-chips.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mripard@kernel.org
Subject: Re: [PATCH 08/13] dt-bindings: display: rockchip: Add rk3576 to
 RK3588 DW DSI2 controller schema
Message-ID: <175200540168.891369.12402940753218880108.robh@kernel.org>
References: <20250707164906.1445288-1-heiko@sntech.de>
 <20250707164906.1445288-9-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707164906.1445288-9-heiko@sntech.de>


On Mon, 07 Jul 2025 18:49:01 +0200, Heiko Stuebner wrote:
> The rk3576 controller is based on the same newer Synopsis IP as the one
> found in the rk3588.
> 
> Its external setting bits in the GRF are different though, so it needs
> its own distinct compatible.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


