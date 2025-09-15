Return-Path: <linux-kernel+bounces-817113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4BB57E21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34502163E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D502FC007;
	Mon, 15 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwBL+zFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DC15E5DC;
	Mon, 15 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944453; cv=none; b=IFiv9LbR8FlhaRwKEZkJi6u6Z75Tm+vYa6RZxKZDx97kBQ3W61GV5sGdbZsuLndsNELNwvlUk2UU9zyodd7k6Rz5M+TybHkPO693h/l5oyXIq2B53LkuakSzu/b5yKWmMxHC9FHkSLQ6Mg1kiRc3WDcYH3hFoJRU6nhE38fn0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944453; c=relaxed/simple;
	bh=qOUJV9eBECePq2CQHjVZBgTwlguw2q8KASxctp0pE/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJxUCKh9THotjstWlx+22iPm0xAmxhUy/H3gVcr9jsGZwGEE4y48LWTVGDP1gagJ3LVO0uCsLBMgLL1e8y2HMAQ7Lxu7hiPu3CHelF53z2u6Fayu2V8VQSCqlSWavbR+39GpmxJDOAEH2/nWIRFVx0QFF3laisRBelL1UAqKPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwBL+zFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E921DC4CEF1;
	Mon, 15 Sep 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944453;
	bh=qOUJV9eBECePq2CQHjVZBgTwlguw2q8KASxctp0pE/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwBL+zFt9/f633HO1XvfxtV3zZGajB/mazzvHBBT+HNRk7H6V2AHiirGzGJYff8IU
	 EqKEddf5besxFLMvhtubsDGeaAX/AD2rTKm+KXnbMvomGvXzlBd40G6wcF04ILWJwZ
	 9snEGSV+HlmU9hX00Ec0076BqM1+imXQs/zMBbY7hi14QuMNhbpcfxpootp58Unv0U
	 CAR3VUlQRsA+cuNrJ08oqBCWMVPdgQCJZeLOxEn71CmcdclUut+70veJUF3c74wO1O
	 b7Hub8rymrT4v+rMFtHgKdhIzXnbjAdhwKpb44fTULws+g1rMPdHmfwedhMpfpB8/a
	 bL4LV+xWUmaSw==
Date: Mon, 15 Sep 2025 08:54:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Neal Gompa <neal@gompa.dev>, devicetree@vger.kernel.org,
	Janne Grunau <j@jannau.net>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sven Peter <sven@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
Message-ID: <175794445094.2731798.8298770564144793280.robh@kernel.org>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
 <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>


On Mon, 15 Sep 2025 09:52:24 +0800, Nick Chan wrote:
> The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
> existing driver for t8103's spmi so add their compatibles.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


