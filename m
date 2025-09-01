Return-Path: <linux-kernel+bounces-795353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B8B3F07B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C04F4E2F42
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05835279DDA;
	Mon,  1 Sep 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnX6XK/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55431277CB4;
	Mon,  1 Sep 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762176; cv=none; b=aTYA7CBgVY4kmDDfjbJBb+1TC9vTLHjBYxPc1uA02tJJVFK0ZCWOyZpXdha6CGYkvlsWGNvo5sygNwJHA19Zhlw+eoW3S3baieeEqkoMpiNxk9HQrZMJWT/N/ZAJnLn3MpZTkopgN7Os4jyor9aDF0/kHQDS6BtNXxH+I1V9MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762176; c=relaxed/simple;
	bh=ZGsW6Cp4Ck4odWBXZ5+9TBl7XqmtalvaRxUlMKXaYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfsJV4LKT1NbX5dFbsYPXYWawggN7M+iN69YmxD5kdzBlXFnz3fBPbiEfs2zGf08o2OQL/XQ1DVEAyh5pFcQPvGchkVKXck/MBJT6oU2ZRZoZITBeDFm3sW9cVehA0HyJChKMu4/Ouapfh0xsbmybxdNFXMuDhqxZKZUSLv/erQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnX6XK/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774FDC4CEF0;
	Mon,  1 Sep 2025 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756762175;
	bh=ZGsW6Cp4Ck4odWBXZ5+9TBl7XqmtalvaRxUlMKXaYDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnX6XK/kJwr4KXTTulE927esfbGKIfTFa9LMyQOAnCxQe4R3CLqISXTaig0QMwmNh
	 OvnPUQUHKKNzkm3VHCsAlS4Q7Etp5UjxS3MKpqyif8YWPfWBfXeFoJylWxKCnC49uE
	 nKm1qCf4FWpoDJkRSdIxB1zkWBlgQZA7tWjPUg+bW1+ecvwVfKZAYqMh/ltU1QeXzB
	 FaqfaLtnMa/peObR9YdewZYGWengxAvZrAfB7WOTFUtivGSLikE5OHv4gEPDwsnoUB
	 /aP2qYLucTSbEbhKomRcfmhYau/FN27iU39gRqiMXGkDa3r0FVdKAWsNWKoIpboTzY
	 8xD7XBi1yP5Dw==
Date: Mon, 1 Sep 2025 16:29:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: clock: sun55i-a523-ccu: Add missing NPU
 module clock
Message-ID: <175676217387.375469.10664750906350656739.robh@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
 <20250830170901.1996227-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830170901.1996227-2-wens@kernel.org>


On Sun, 31 Aug 2025 01:08:54 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The main clock controller on the A523/T527 has the NPU's module clock.
> It was missing from the original submission, likely because that was
> based on the A523 user manual; the A523 is marketed without the NPU.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  include/dt-bindings/clock/sun55i-a523-ccu.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


