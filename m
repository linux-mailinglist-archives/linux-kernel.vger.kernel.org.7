Return-Path: <linux-kernel+bounces-743720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242ADB1026D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615381C83031
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E727055F;
	Thu, 24 Jul 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ1RJw1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4426D4E1;
	Thu, 24 Jul 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343667; cv=none; b=un8uVV9/izFjQqVaBVviQmkKPASkBGtE0i5sokIAu5gL/jVgK7B+cEYCZTEy3nT9NmStmagjYfhnh6vt9D3pdyhkwMI/fuNahUWN5Jl0Zn4vgxfOSG7jur5xRCs3YfSuoOsk2PPHjYmuPc8L3xWbrp/bvEkToo3wH2N5x0NGQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343667; c=relaxed/simple;
	bh=i2i4FvAvcuu68l81dS/YVmY3OFVFW2LN9O82CoVKe7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKjhySs7ClWSlHwt5/bu27k3/Us8ICPogChOk0elxmAo0wE9ajLFpUvWKT8TguxzZVAO8VjsQj162CZiTi8n9D2w8rogo2WNIdbQeyA7FMQK395s5G0esTTKLxbM7rIZWALMV2fjZqXExN/c91Q4MWEy1lobV/iRQ0zBnbTTGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ1RJw1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17996C4CEED;
	Thu, 24 Jul 2025 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753343666;
	bh=i2i4FvAvcuu68l81dS/YVmY3OFVFW2LN9O82CoVKe7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ1RJw1jj5vQdH0uQDIh+j8DzG4WT0pzw1BFCODaK/ai5Be+TDcZckKWh6m7BRM0X
	 Qc0N6jpaWb3Wp65fn5U8Fy1XO6H4Uexv+t5Z9AeZs0M1+6hzF9Ylb+z9LeDT8Ws/rN
	 mr8nkjmOgTlmFkOhMemTJ0VOjd0I7ylq92bPH+8q0ao28yYivPvYLpfRwDgQqFrvP/
	 7/jCbKR6hNfiLqmNh6DRmPgSYOqTEsWq7FYERfSrDMQmtSMWIoh3WL3K7VB6JgaJxb
	 wWau+MTJmlC1y0iWM2ky+Zwcru9Lc4oqIZxNneD2pcRcqIQ8BRtyxUt/1/c1Otvg1W
	 hzyyArKWXSZNA==
Date: Thu, 24 Jul 2025 09:54:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b
 board
Message-ID: <20250724-sweet-radiant-stoat-10d86d@kuoka>
References: <20250723222350.200094-1-donalds@nvidia.com>
 <20250723222350.200094-2-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723222350.200094-2-donalds@nvidia.com>

On Wed, Jul 23, 2025 at 03:23:49PM -0700, Donald Shannon wrote:
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 456dbf7b5ec8..624581db2330 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -99,6 +99,7 @@ properties:
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> +              - nvidia,gb200-ut30b
>                - nvidia,gb200nvl-bmc
>                - qcom,dc-scm-v1-bmc
>                - quanta,s6q-bmc
> -- 
> 2.43.0
> 

