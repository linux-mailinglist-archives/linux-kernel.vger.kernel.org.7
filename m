Return-Path: <linux-kernel+bounces-740832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC31B0D9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4BFAA66A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9B2E9742;
	Tue, 22 Jul 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4Cb+XCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9962D1F61
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187683; cv=none; b=Nm0rMqyFIeVzdIxiCHztSGZ4qP+I2eSMEcDyPHmm9g+bYASm+mPJOMTIqQxPcR7n0Llwxovz7jmLkUVhA4XdXx25Jm32be4vren8J4xfbvs3cd/qVxl+mRsso8bZxCDr8mLh8ARX9lPJMWpPj/xbeaEGedT6wj7Di2kzr71bUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187683; c=relaxed/simple;
	bh=a70tJ26fYKY4q6tpubfdXTZO+/PdkIHK1Zjw5PmgqU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcg5wdaxlmG3hHsart7pRJd5BncIa5flgJ7HzpYVtBLanE0yEjG4Kp59KE80kUCUvMlZ8SGtVHLcgA6JACY9zRNIXnQe40bj3nO6gt0rDfNaXu5hm/dEL/pz7E+p3IR9/quGq/7zWHa6pTfkdyiz13SWurR9ip2tq162twoyIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4Cb+XCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFB6C4CEEB;
	Tue, 22 Jul 2025 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753187682;
	bh=a70tJ26fYKY4q6tpubfdXTZO+/PdkIHK1Zjw5PmgqU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4Cb+XCJQVrf0JzVqRTC+Il6MWtUoddr+J9pbIYV84xcAARh7s2FHk4aoD4v8046T
	 aPleOJ5NiCD6+8Qq7FxcomIZ+a1WMoVocD2ItQpkel+Rh5z4IpRr/loKzYI5YZWobO
	 SI67AXvozJMV0D0X6JXCG52VUnWatgtWYF5o7KCraK8wyoexgdehalIvbFKRXo5MOe
	 0jIUF4G1RpXas3Lau8UqDCuD3Aiu0nyqfE01GrsjWkIsSvGMEWkpbQLcrjPUPKvU66
	 h/sL96eTLpKwHC5D9h84CGm5A6hC6wOjfgzAdCAM9AsfRdSn1v2ymnmESTiLWEgIZG
	 jh9r23oCUvCAg==
Date: Tue, 22 Jul 2025 18:04:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-snps-pcie3: add support for
 rockchip,phy-ref-use-pad
Message-ID: <aH-FXrb-qvF3ffv1@vaman>
References: <20250715105820.4037272-1-rick.wertenbroek@gmail.com>
 <5a7f47a7-c81e-4f70-9391-0dd1e3aa9f65@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7f47a7-c81e-4f70-9391-0dd1e3aa9f65@kernel.org>

On 16-07-25, 08:18, Damien Le Moal wrote:
> On 7/15/25 19:58, Rick Wertenbroek wrote:

> > &pcie30phy {
> >         rockchip,rx-common-refclk-mode = <0 0 1 1>;
> >         rockchip,phy-ref-use-pad = <0 1>;
> >         clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>, <&cru CLK_PHY0_REF_ALT_P>,
> >                          <&cru CLK_PHY0_REF_ALT_M>, <&cru CLK_PHY1_REF_ALT_P>,
> >                          <&cru CLK_PHY1_REF_ALT_M>;
> >         clock-names = "pclk", "phy0_ref_alt_p",
> >                               "phy0_ref_alt_m", "phy1_ref_alt_p",
> >                               "phy1_ref_alt_m";
> > };
> > ---
> > 
> 
> This looks OK to me, but don't you need to also update the dt-bindings yaml to
> document this new "phy-ref-use-pad" property ?

Absolutely, without update to binding this is a no-go

-- 
~Vinod

