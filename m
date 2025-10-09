Return-Path: <linux-kernel+bounces-847319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDBBCA84A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EF13AF550
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701924EA90;
	Thu,  9 Oct 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owltrz/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F59242D83;
	Thu,  9 Oct 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033059; cv=none; b=S4voV/4n6+xqQJ/wA6IQAyHjkYS/V1LkkMOeq4dfbb7Qj78L5CfJhqr3E3arL7fU+eo+vNNIDeMD6urKVHbLsl4cs06KZjwmEGJOdvEbIZ2FdzwSjtyJuRFiGFujKwlGKNn236HMssMi2t1HyR9ozBNzHe5/T2TY7NWKGTMlTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033059; c=relaxed/simple;
	bh=K+hPseUknflSy4hygWFCRuB5yq+mdBnazdt9i44bmg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLCj7Hhvgz5FBQI3ijsa9xWVZqOaICMc38PLLlG4MFhCnHLfCDUc1r1waQC6up38jtTic4EzVlSgJIVknkCXb45L17zeN3ejT9mDi5ogu6QQAqm7jy9N0u/mEMYVOi0uSBtcup01+WbMTD5DOJ9mOyPygnO8QlLUVHazetVd+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owltrz/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2540C4CEE7;
	Thu,  9 Oct 2025 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760033059;
	bh=K+hPseUknflSy4hygWFCRuB5yq+mdBnazdt9i44bmg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owltrz/GJxZu1UAvwCW/COWHnZAzwxKes5ADduozJqQwtIWbQfzeUUSGQNBY9PTvv
	 D3t23hfmu6nKLeOFLzmiJ1ep4DmWqsT0wAKZk7BwCGttUtZ9RVy8cUvORNrDzbUQAQ
	 kbu0IEyrSU2iaf8cvC41vbL1sJt2zYesbuG+qN4Ye7few39gDSPE98XjjliI7Lt6Gp
	 CSlAZpLhBa1P89chi91jqDURIv8fOpIyOgELRoKRlVNjB0jCC2P/FPSsJVaiX5DK/t
	 0gPtRS4FxCMopn472srDZBzg4vQaf1nMMAQpZe1wP80U8vHhchM5WxKMXaeCsQL4an
	 wbfCcpPQD4yTw==
Date: Thu, 9 Oct 2025 13:04:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 03/19] dt-bindings: clock: Add Amlogic A4 peripherals
 clock controller
Message-ID: <176003305705.2941216.8177451888000768294.robh@kernel.org>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <20250930-a4_a5_add_clock_driver-v1-3-a9acf7951589@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-3-a9acf7951589@amlogic.com>


On Tue, 30 Sep 2025 17:37:16 +0800, Chuan Liu wrote:
> Add the peripherals clock controller dt-bindings for the Amlogic A4
> SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++++++++++++++++++
>  .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++++++++++++++++++++
>  2 files changed, 251 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


