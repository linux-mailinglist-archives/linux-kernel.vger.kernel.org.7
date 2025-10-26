Return-Path: <linux-kernel+bounces-870653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91541C0B5EF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 509364EC233
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEE52FE586;
	Sun, 26 Oct 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoLWbW05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2425A2A5;
	Sun, 26 Oct 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517806; cv=none; b=KDM2efJcLB2Rv7OwDev1JM1Yslqg4WJ40Ki/XWI+ZXKQ0C1IwZGczpC2VM88NzEMGTEu/zDovzOPQ2WsMSRwKe5uovV/AsMb40ofzCz9mxlV8h++s7+178OaaR89wcdTqjnmoDemIu7fgkGdNwbZ53GsVHzJw7rD+8RlcYRQI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517806; c=relaxed/simple;
	bh=eUaUCjQL2k6wS3OJDAZjVm1LxinVF4MQDIbMPIkZImo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anxAG8jKrJSu9OuIBYClrQsP8E2dVngtbMIgL7aklgQmbtagZTW2EyFui1/tRGjCqdwre4AanF9AiMa4odwqp/gNZIZ6z1d5MOihDiSyUH6yJKZg79hTiBgR3RunhNXeVQ3ThU/syaInlxL9/+ZYh1ticZ+KaMleI/00yntAp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoLWbW05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA4CC4CEE7;
	Sun, 26 Oct 2025 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761517803;
	bh=eUaUCjQL2k6wS3OJDAZjVm1LxinVF4MQDIbMPIkZImo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoLWbW05zU4pIUwztfJ+tTgW645Adsd1hDY2/nXoeTqEix25ASz63Imd3WS5Lnymn
	 EzNwnXxnQk9S2vPGYfw80AewxsdqJl1O4nPpdH84AqH5WoJt3LCUGP5eDRysUyBhfk
	 MD18a53LC0LIlCiXfQhvYjgfywOdUCFsjAWfvv6m1hM3nTMxY3kVb1HVBwFM6DL2vH
	 q/wELZgw152e1ywIGcL8YEC7YkDhD4Xmr7B0KKERJWYEtTMJmGEXNyf9ZSmtzxLNKx
	 JKGrYXQg+kE75mSSACHPkw1ockaAWz30fws7JkLAri775EBhrc/xaPlnYPSYKfMKFt
	 vYUp0sM3IWcgQ==
Date: Sun, 26 Oct 2025 17:30:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jascha Sundaresan <flizarthanon@gmail.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] nvmem: layouts: u-boot-env: add optional "env-size"
 property
Message-ID: <176151779689.3048651.370574318472729306.robh@kernel.org>
References: <20251022230740.200742-1-flizarthanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022230740.200742-1-flizarthanon@gmail.com>


On Thu, 23 Oct 2025 03:07:41 +0400, Jascha Sundaresan wrote:
> Some devices reserve a larger NVMEM region for the U-Boot environment
> than the actual environment data length used by U-Boot itself. The CRC32
> in the U-Boot header is calculated over the smaller data length, causing
> CRC validation to fail when Linux reads the full partition.
> 
> Allow an optional device tree property "env-size" to specify the
> environment data size to use for CRC computation.
> 
> v2: add missing $ref line to DT binding
> 
> Signed-off-by: Jascha Sundaresan <flizarthanon@gmail.com>
> ---
> Changes in v2:
>  - Added missing "$ref" line to schema for env-size
>  - Confirmed dt_binding_check passes
> 
>  .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 +++++++
>  drivers/nvmem/layouts/u-boot-env.c                         | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


