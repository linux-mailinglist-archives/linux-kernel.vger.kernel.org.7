Return-Path: <linux-kernel+bounces-746476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BCB12725
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800F117222F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887C25C81F;
	Fri, 25 Jul 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brFLpn25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6232356BA;
	Fri, 25 Jul 2025 23:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485214; cv=none; b=kb6VOLrJqpN0ZXT5yyWlIv9UFPMYO3fZarlhpGIhtDMnwo/HC3uKwtv9uDPDTIeLC5ONm0LmIBuYejMLtJX/oWiyWT0m419o2GXB/YtH/YoQSTI6Y1DjH1IHU9sjwjtRLoHvrhN7HjVE3BAvN3DOKZHkhqcc80tCWL3euMNhFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485214; c=relaxed/simple;
	bh=VMiBf86La07uA71P69SSBu20dwv5wdLYeyIG8LPdO70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkzGnVRuRekdumpmVeGA9IwLvx2decJGBxnzbVzeHhtrQggJoL/yvilGoKUTvvdgLCJcEaKg2SsbzghqeAT4HAF+jt5mvyFXJoVZ6JjLOzk8T6YT5LexLqa2gCVt+xME48ONHW83PL1JXnVb0egdodghGR1RbrqpntysUjeCHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brFLpn25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD4FC4CEE7;
	Fri, 25 Jul 2025 23:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485213;
	bh=VMiBf86La07uA71P69SSBu20dwv5wdLYeyIG8LPdO70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brFLpn258nANeZsjscyVyQJusRSEG8geEd5eNw1r1wso0K29DzqE7kx3DpwOh/4Mc
	 VraZWUIoYbB3WEIfA+A348iMoQls7kQZyA0MVuEpHbXWS7BXIQiRiI2Mop6SE/I/lb
	 Kqou3ucr7wg16H1RnzuP8NGWrBWdaQSTGf9WZSpqM1p2weoU+AdyQp0KWUs09tsaA9
	 n3Jqxwx4eE/HvCAS4arwOslerz84LgIUPnLwV1UKWjC36KAHlBbCocmddYepo+PnGm
	 MV+EvCI1xuX1hF6klmYBAhNF97fxbq+tNXhWIpUiE05dI5eFq9SpL6ogPBdCz+1blG
	 qgNx/kSu65tcQ==
Date: Fri, 25 Jul 2025 18:13:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Drew Fustini <drew@beagleboard.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/4] dt-bindings: riscv: starfive: add
 milkv,marscm-emmc
Message-ID: <175348521234.2010243.14522984982875660106.robh@kernel.org>
References: <20250724094912.253723-1-e@freeshell.de>
 <20250724094912.253723-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724094912.253723-2-e@freeshell.de>


On Thu, 24 Jul 2025 02:48:44 -0700, E Shattow wrote:
> Add "milkv,marscm-emmc" as a StarFive JH7110 SoC-based system-on-module.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


