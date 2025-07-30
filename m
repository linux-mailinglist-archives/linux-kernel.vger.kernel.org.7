Return-Path: <linux-kernel+bounces-751423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C87B1697B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DF618C7853
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FD238C35;
	Wed, 30 Jul 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0kK/w41"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F9212FB7;
	Wed, 30 Jul 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919536; cv=none; b=aCdnp6+Ib+6P/x/Vx41bpMPVaSFGizHfjYVLTw7scikfBOLJBcevbtbsvstAB2Vd8ofWtAhQ1ztmpXqRRjwpZHJlX4vOA2T4fIT1MredCuoNwI/seo7F88FNOlA4MIKM5v7bz22KkkPflMs/Rt8ZDGnLwRbX1/+TAcuJ1tz5GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919536; c=relaxed/simple;
	bh=zsGUwtWCHJliIuhsWXlAWg6lQCzm+yw+rRaXzComjqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE6N65upoxgyxI8nYDm0QOviEM9wjH1SoefueuM8Vy+IweSDzzCO8aYKZ6CTpudrRuS5ZZxODJlxGJoSvbO5yx+t1yyiNuovpmHnDKQ4qhFclY9BXDDnDs5XyWQVCcCFNljIziTtLZ+zNKgy6vZIxcxBHkhmj0wbPMAVyGcX+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0kK/w41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB4C4CEE3;
	Wed, 30 Jul 2025 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753919535;
	bh=zsGUwtWCHJliIuhsWXlAWg6lQCzm+yw+rRaXzComjqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0kK/w41Ne0scmqL6sqW8WL13YI3UWEFHP3kTvruANn8XbjZnEeBs7XQ2F/nX5d4D
	 FE0vg1+I863qTxROe55DrDf7SNpTcc7rBw9AzfBERoC1vVbIXy00c3fDGR4rtChUBr
	 8xmC+SB8E/u13/19Li2IKc/2yt0qviOBtz4cLNDAteh7XbXCqGMaljagK15Gbi0EIl
	 gvSXhZvDdu7n4YyqkYdGLtCDWz3gmZrSK7yJ70sJrv/eV/8FLo55Oy+biIlW/LEg3u
	 rTkX0ee0n3A1aYC5YrMhLKm1NLn1giBiW2MHGFjLzKsT5nR8itoYixpvaRvMU/kdZU
	 ok/jbTT9CUD0g==
Date: Wed, 30 Jul 2025 18:52:14 -0500
From: Rob Herring <robh@kernel.org>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: add env-size property for u-boot
 env layout
Message-ID: <20250730235214.GA1907865-robh@kernel.org>
References: <OSBPR01MB1670FF3930C3B1736E7EFC23BC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB16702D6947772E526F64D63CBC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB16702D6947772E526F64D63CBC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>

On Wed, Jul 30, 2025 at 09:17:47PM +0800, Shiji Yang wrote:
> This newly introduced property allows users to declare the size of
> the environment storage area.

Why do you need it to be less than the partition size? They commit msg 
needs to explain that.

The partition size for fixed partitions in particular are purely a DT 
construct. No reason the partition size can't always be the env size.

> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> index 56a8f55d4..e0b65a53e 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> @@ -46,6 +46,12 @@ properties:
>      type: object
>      description: Command to use for automatic booting
>  
> +  env-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the environment storage area in bytes. If this property
> +      is not defined, the default size is the partition size.
> +
>    ethaddr:
>      type: object
>      description: Ethernet interfaces base MAC address.
> @@ -85,6 +91,7 @@ examples:
>          env: partition@40000 {
>              compatible = "u-boot,env";
>              reg = <0x40000 0x10000>;
> +            env-size = <0x1000>;
>  
>              mac: ethaddr {
>                  #nvmem-cell-cells = <1>;
> -- 
> 2.50.0
> 

