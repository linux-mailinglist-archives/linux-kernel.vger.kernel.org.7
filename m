Return-Path: <linux-kernel+bounces-872446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78640C112E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD0F56363D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1FE31E0F7;
	Mon, 27 Oct 2025 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5HlgI0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E12BDC13;
	Mon, 27 Oct 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593618; cv=none; b=DeVjv/LkyRDbF/mM9m6T9DyekOh8EHjuXHDLeaFmSJm5WhtnttKjiWbO1lGplzIIj8E6Kgnsda7YAVfpMcYNzYCQwLpMvw+g5Dkhjxp5gwesRSUMA8FAobMNSF78OTMN9YV2XEj+YP9aWSPuvPsxSo5YcgN/XfT9HngRD0/NfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593618; c=relaxed/simple;
	bh=uPve+l7+cJjOEfzkb8Q0gunZrnDYl+FrJHFKM+t/nqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tisNdS7gDN8G51kqYx2wL7TT3VXKlbUDl4r12pB2ea1UK8L1ioasxICxUDPtuYVVwJ67q5uxAjRG5ryhwmPzuf89ptqToSp2ifgupb+jN3oZgvY08XW8N5PV5uK8vBbUFpF6i2HGO5dWHDDpqBVfGTm6tcEnGo+vWsCW51wuGLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5HlgI0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61E8C4CEFD;
	Mon, 27 Oct 2025 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593618;
	bh=uPve+l7+cJjOEfzkb8Q0gunZrnDYl+FrJHFKM+t/nqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5HlgI0mM54pKfQ021GKCv4Dk2osy/WkbrTx1weBaulJibkE20dhmQoF/jAh2n6Il
	 EESQtP0S5rsKorEnXTKHI/d3WUZaZDsLJjiEtZIUmGTTtIOmvyG5QuFYiXzNHbX/56
	 1iMWdpVr2Q5DZvyxTTnpa7CthCbkoB3pvgnY7OeF39p4v6iv4hA4KRUm5gERl/ce7C
	 TlpA2dbApby0cWE/IhRhpkhIupvqAm7pVa1WaFWdWJ3dyM6gIZD47+AWdpZCOTRIXM
	 +Hx4Hc05Jo7L7/mviaz4Nnht2RqWRoujac+6cXjXi3xgU9gCj6+McbIpeTDfSamfcz
	 vWGMWfJhA5Uhw==
Date: Mon, 27 Oct 2025 14:33:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Message-ID: <176159361376.1460089.7581284266775192820.robh@kernel.org>
References: <20251026150358.1078453-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026150358.1078453-1-coiaprant@gmail.com>


On Sun, 26 Oct 2025 23:03:56 +0800, Coia Prant wrote:
> Add NineTripod to the vendor prefixes.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


