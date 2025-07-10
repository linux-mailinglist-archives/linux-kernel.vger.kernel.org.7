Return-Path: <linux-kernel+bounces-726580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62BB00EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219561CA7FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF62BE7A6;
	Thu, 10 Jul 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf9eYWS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F02206B5;
	Thu, 10 Jul 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187460; cv=none; b=sSBPOzSQiCDHnSVVkmtXxiSZNV57cl6oBm48L9wuOf7oRKObTQpzxyGb1yG7dZ5lzWCB81E5DsZh2Lyw/OVY7dX+AX4DM0A1GgnYyXoT64PIblHMA/+FX+dA1MPNOlxpVvNagQeRkGWFaIhbw5thsA2K9dFpNWQqN3UjIBq5BC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187460; c=relaxed/simple;
	bh=7EopwvmySjxfKj3rSFZExXEG9T17wjD8V0Kers5MMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Xjwwrc1AvkvaHLVHax63lot41TL3g+Q/pM1KafLyYz8ZSk9qs47dvJ/ilI+MG5O8I2msZ8ZU/H0xBQz7iWkzBM83xeCVb9Z83RpAKDGZ0+iNfbE3wrpMWxbHjwg8h9HXVDpeTOAKTIulaE7zwvWAhXOdWUG0y0ddgPh164wVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf9eYWS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07201C4CEE3;
	Thu, 10 Jul 2025 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752187460;
	bh=7EopwvmySjxfKj3rSFZExXEG9T17wjD8V0Kers5MMHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cf9eYWS+mcbatZOPdiHF6ujMtwDg0M5I7L/R3FfHGA60YifNM5gcPb0uhJCavaa02
	 DE0IVCVDnX/TmAs5M1W2ngdblvDfcib3IPe5MRc1QYqaDC1VVm5wZ6Oh2vavoV4B2G
	 /eF5+J934uCQGR+N/kQoqu2xubVVp0oSwePoEbk9yI1y3SLdXeW4S3qOloDKmLd2f3
	 HsexP6mOpeLwDUXOFW8beqBReAaWFRA1eABolM18qo85iyi2iI/8BosOCsKe1zlyne
	 VwlorjIGut+V7tlGxRqRzSWZrcvZrWJDib76I5EvVR11iaij//oVwazZ9lTkhJ0QGX
	 73RSVA5w7L8jA==
Date: Thu, 10 Jul 2025 17:44:19 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: submitting-patches: Avoid 'schema' in subject
 and add an example
Message-ID: <20250710224419.GA10902-robh@kernel.org>
References: <20250710085814.21810-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710085814.21810-2-krzysztof.kozlowski@linaro.org>

On Thu, Jul 10, 2025 at 10:58:15AM +0200, Krzysztof Kozlowski wrote:
> Subjects should avoid also 'schema' keyword, because all bindings are
> supposed to be in DT schema format.  Effectively people get confused
> that subject should not contain anything else than device name after the
> prefix, so add a recommended example.

However, conversions should because if you say don't say schema, then 
people will say YAML which I don't prefer. I prefer "convert foo to DT 
schema" as lots of things are YAML and only 1 thing is "DT schema".

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index f3e23e69a638..bf32b784cb82 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -21,8 +21,12 @@ I. For patch submitters
>         "<binding dir>: dt-bindings: ..."
>  
>       The 80 characters of the subject are precious. It is recommended to not
> -     use "Documentation" or "doc" because that is implied. All bindings are
> -     docs. Repeating "binding" again should also be avoided.
> +     use "Documentation", "doc" or "schema" because that is implied. All
> +     bindings are docs and all new bindings are supposed to be in Devicetree
> +     schema format.  Repeating "binding" again should also be avoided, so for
> +     a new device it is often enough for example::
> +
> +       "dt-bindings: iio: adc: Add ROHM BD79100G"
>  
>    2) DT binding files are written in DT schema format using json-schema
>       vocabulary and YAML file format. The DT binding files must pass validation
> -- 
> 2.43.0
> 

