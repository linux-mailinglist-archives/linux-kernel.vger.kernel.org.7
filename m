Return-Path: <linux-kernel+bounces-726531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB1AB00E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6715C3846
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67974290D96;
	Thu, 10 Jul 2025 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCYWk/6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444923FC74;
	Thu, 10 Jul 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184495; cv=none; b=fu3MBwzE9cnh34lVqFKtlPRn5/vs+ZQjC3SazNmH56+s5gAT/CA2a5GMc+ynBptcj18Mjjh0iwoJkUf1bdijRXllTcaVSv3BhDBUAG/FWCVGjShzJIFUOnlME6sN/NRgZD34BJ2YMhJfZ0nw4+MN2IlwQbF3BL4/6b0jg2Zl7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184495; c=relaxed/simple;
	bh=V3B6WW5Mxt5Wd0BcP+hvlPKfFOTtsXtBAisFY/sOAYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAGUgCfNIw1I2DcpkG/z8X45oAZATKc0R4GTW9egA9xP5WUvlwbqZ88oN3HTTuavHzbdnvqWKL95GNf8U1mwTkcf4vyXALsjY9E6IIuw35o7ow9pRK4iMh4c+N1RslCp+zcDRK3aFUhLsDgoPKTKOoLILYhlfakU0QLvV0D1WDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCYWk/6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E217C4CEE3;
	Thu, 10 Jul 2025 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752184495;
	bh=V3B6WW5Mxt5Wd0BcP+hvlPKfFOTtsXtBAisFY/sOAYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCYWk/6HrZ1oEn85BvEcIf7/Dbc+coKMTtkwxyw7niZt8OZMgxLNEt0ziqx+MeQd2
	 Ubp23/TRL8I3DGzTRou2lMAHM9vV6lB7vlCdJFicZsma1wfAJ7HqhLQX5dnG56m9eM
	 0wRLmUPlBHxiVURwBZXXVtGObntHqCsyb5dVb9jGrZtpzuF0t4iUSj8vbVv61t7XFO
	 TAZqVGPmHJyETcqzYef9VgK+0v82GFSI3JjM0S/JH9XsDb8m4d05ZgBGJuWY1qJXGJ
	 G2F7CzY31VgGL9cK8mx8kj1hYt6oWn5xE1cG8DoIY1mhe2RAN0NKemoQwH7l8wtfuf
	 ygRtBA0TD/P4A==
Date: Thu, 10 Jul 2025 16:54:54 -0500
From: Rob Herring <robh@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: reset: add BCM63268 ephy reset
 definitions
Message-ID: <20250710215454.GA4033782-robh@kernel.org>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
 <20250709024740.194520-4-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709024740.194520-4-kylehendrydev@gmail.com>

On Tue, Jul 08, 2025 at 07:47:27PM -0700, Kyle Hendry wrote:
> Add definitions for resets in the ephy control register.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
> index d87a7882782a..676a62c9777b 100644
> --- a/include/dt-bindings/reset/bcm63268-reset.h
> +++ b/include/dt-bindings/reset/bcm63268-reset.h
> @@ -27,4 +27,8 @@
>  #define BCM63268_TRST_HW	30
>  #define BCM63268_TRST_POR	31
>  
> +#define BCM63268_RST_EPHY1 0
> +#define BCM63268_RST_EPHY2 1
> +#define BCM63268_RST_EPHY3 2

These are kind of pointless IMO. The provider is only for the EPHYs and 
your number is just index+1.

Rob

