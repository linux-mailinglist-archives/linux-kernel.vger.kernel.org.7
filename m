Return-Path: <linux-kernel+bounces-775192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A2B2BC58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B42C172809
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C831A071;
	Tue, 19 Aug 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvvhuIFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3731A057;
	Tue, 19 Aug 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593964; cv=none; b=jOVvPn15MkDNMbQ0OzPo2Ja5zoa5rs3MkhtlxS04ZECr3ISPPY1Zey0rLJWewfYLoHv8KLTQpHh/YuzuBYwoz47qLguiOzzNDVi7fGiJdOYhsNzRy+Bpvgp/4NmhFrq9z0XI5KpphpvO3pVKZu3O4qIMDuMCGZKqSgf20BhnVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593964; c=relaxed/simple;
	bh=MfjojgOFDwiM1zX4EA/ds0PNRRDPb+ud6YetYr8ZTt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l59W/4HpsTh+nveg4nFXxkY09b+31ishSxnl2ImusWzxO8I6UYWjkPDT93ie1UnktVftY5grxkOO0lKbRbNd0+TLdmFbHn+Ti4mTCW8lOISdyu9NMNNVgr/m38yYqCY4B0jFxs/eV26Xkid/IK6BBK1kOc0/J8+0Pbz5UpMO0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvvhuIFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B5BC116B1;
	Tue, 19 Aug 2025 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755593964;
	bh=MfjojgOFDwiM1zX4EA/ds0PNRRDPb+ud6YetYr8ZTt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvvhuIFc7P2JeuLAigWCk4tgtjo8dK5A87aENxte6eGO/D21pbR1DRzJpq9YHAzrk
	 hpMHX2okYSq+b6UCZMNRmkvtb1arVHEEpSA/HtiznF2adZNxq9zrVpI18ViSGE51pM
	 vF0IZLYrxUT/FR/JTOlcHpq2Q77aoScCNTLn6C2t2tmtBlBpuX5yAsa4z/fWlQWBAq
	 J1ZseB0WX+obRuM1lhFkRyN5Iks0dZ5OT0ua4Ju5Ga2jgjPICo93DHRe94LxY51YAG
	 bfMvdiH1O1Q23oedVBj4PdhPjj5yrVJN+GxrhN0W4zc/OBZgj+EdvEfky7ZlOy8RWM
	 u+3X38PiffDbw==
Date: Tue, 19 Aug 2025 10:59:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: memory-controllers: add StarFive
 JH7110 SoC DMC
Message-ID: <20250819-roaring-mutant-fox-a05caf@kuoka>
References: <20250815073739.79241-1-e@freeshell.de>
 <20250815073739.79241-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815073739.79241-2-e@freeshell.de>

On Fri, Aug 15, 2025 at 12:37:21AM -0700, E Shattow wrote:
> +
> +title: StarFive JH7110 DMC
> +
> +maintainers:
> +  - E Shattow <e@freeshell.de>
> +
> +description:
> +  JH7110 DDR external memory interface LPDDR4/DDR4/DDR3/LPDDR3 32-bit at 2133Mbps (up to 2800Mbps).

Please wrap at 80 (see Linux Coding style)

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: starfive,jh7110-dmc
> +
> +  reg:
> +    items:
> +      - description: controller registers
> +      - description: phy registers
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pll1_out

pll

(this is name of input, not name of clock)

Best regards,
Krzysztof


