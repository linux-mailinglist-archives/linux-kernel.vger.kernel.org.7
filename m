Return-Path: <linux-kernel+bounces-758758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE054B1D38A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F7E3B7101
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97323F42A;
	Thu,  7 Aug 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRRjPl7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA20234963;
	Thu,  7 Aug 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552532; cv=none; b=sM9rbNJm0mMVQUzzLxtAkWgRIjNz8sHVgHddw+OaJ8hzHkTQ6tNMCnMF86BEMsfpMKCSkyeEQgeJXKtq//DRGmbnZioRyOkY15KzD0EwO15vkQuXPIq078QFb7dS9Xz0TRpLJMqOy09JjG5k7lKZar/DOHD9pEX7VjBe863ST+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552532; c=relaxed/simple;
	bh=837mQHXOHMq1NakvNPj7uXsEJJUJV1kK1b2YQLagO/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAWnunmHOGrTdCZeJrF1NF//Vc9+C290pThYQluLRxKG6ArzjOqbvbQY0paWva9DfM350m1dlXR6bBTT63vROgZpEy/k8kQOVGKNcwHtgBhhqZfN0mfOW5U6YsyteyUOSToy050UZIB/lAYkAq08wcriNZPT95Tj/ScJHvIyIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRRjPl7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C7C4CEEB;
	Thu,  7 Aug 2025 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754552531;
	bh=837mQHXOHMq1NakvNPj7uXsEJJUJV1kK1b2YQLagO/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRRjPl7KUmf+n7lotlGsrBKmvZzqt937kebxj2Cl95QtuzsnwiwW4il4ULH9hFRiu
	 pd31xCi7/Whq7M99ma/GXUUi1DG9YpCLLPTcTcDfQrjvw5eQ6JxqH/gR3PIl3GbGB/
	 oRuf+QVMHfi3LfVsgsuQO51mmVH61uajU5pVVF4YBPRA310dWEM8SMPXmu+azNU2pn
	 IgHrESr4SFeNczYmiyY7nOjw535GmxaYItRyQMBWeitBK5TWUMhffZhcaoxUREsUk1
	 Fg4ggog+8LZREaZ3SDzevERfXvP+605UbAZwTHRHMRJwVs0jg4jUBx9YXj43tpzWV6
	 kBGIHq48LDoAw==
Date: Thu, 7 Aug 2025 09:42:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: rockchip,pcie3-phy: add
 optional differential phy clocks
Message-ID: <20250807-amphibian-fanatic-muskrat-b1365b@kuoka>
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
 <20250806133824.525871-2-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806133824.525871-2-rick.wertenbroek@gmail.com>

On Wed, Aug 06, 2025 at 03:38:21PM +0200, Rick Wertenbroek wrote:
> Both PHYs can use an alternate reference differential clock, add the clocks

I do not see any changes in rockchip,rk3588-pcie3-phy, so your "both" is
either incorrect or ambiguous.

...

> to the DT bindings
> 
  
>    data-lanes:
>      description: which lanes (by position) should be mapped to which
> @@ -82,10 +82,15 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          maxItems: 1
> +          minItems: 1
> +          maxItems: 5
>          clock-names:
>            items:
>              - const: pclk
> +            - const: phy0_ref_alt_p
> +            - const: phy0_ref_alt_m
> +            - const: phy1_ref_alt_p
> +            - const: phy1_ref_alt_m

These are different clock inputs?

>      else:
>        properties:
>          clocks:

You need to update the example as well.

> -- 
> 2.25.1
> 

