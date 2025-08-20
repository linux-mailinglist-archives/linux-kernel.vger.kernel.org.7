Return-Path: <linux-kernel+bounces-778422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35BB2E579
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF2F1C85558
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414F28489F;
	Wed, 20 Aug 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD15oUwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82D284B26;
	Wed, 20 Aug 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716829; cv=none; b=U6QSl+WanJ1KP7H3LJ4Y8gm7xu3JwnWegfptCJvK1wkO07ZkI3l4j+6RynaQnecJViah6wEpntXr1DLv9HgeHKT9uzxZagBRh+3G+xBU766YR1BQH0Iu61n+IGt5p3XjVf9wMuisb62gfVAhjgoVbNKKx4cJXDyFStR1YPRNIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716829; c=relaxed/simple;
	bh=PLodxzCvgqaYbD8M4yslfd7XA3TXl3CKdavXZrRjThM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqHFA211Aw4rwyqEKxrTsDn9ywLkR25mpg56UQ8UFarTGhGx0TFwEF7kXCslhZPqXscUxXQaAsfVAoLXJl45fBdVGWgXLq4sXp2HMkJEkHHJXuktu0W8rUzEFZBJ8fAgeluN/C/W7P5bfcthhi4L5pGYLOMAnmLRoz3RdgpHQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD15oUwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2001C4CEE7;
	Wed, 20 Aug 2025 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716828;
	bh=PLodxzCvgqaYbD8M4yslfd7XA3TXl3CKdavXZrRjThM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hD15oUwaW6gmjcX44pRkEjMfF/K6uiXmGaPRvOHub4nK3iodX7cBdkQoIEUk0S/N4
	 W8GZLUtInWU+x/PpwLwW46YK2vjZ04RTmWzOuB9/T9IGhp5U8D5CH4kJ6xZB4D3hvG
	 fEbYjVCgCM0qySVhbYNw1c/LcOjDgdg2GYNLq45O0zlZFcSovcK5QM7Oc4RYwQlbUu
	 biZ78Fsllhxqdw3/mQ99HGUFshxgbhmm8BNsv9b4DRmPNsqZfwIH07+Ln9PtpyRkSw
	 OqKwbEK0DxqkabkNGKX8ab/wzd4Tq+b9dNEi3bJ01z6z4gvHvPmRIU6xRDNaO0DqgF
	 KaMTYYnThKlaQ==
Date: Wed, 20 Aug 2025 14:07:08 -0500
From: Rob Herring <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: apple: Add t8112 j415 compatible
Message-ID: <20250820190708.GA538860-robh@kernel.org>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
 <20250813-apple-dt-sync-6-17-v1-4-209f15d10aa0@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-4-209f15d10aa0@jannau.net>

On Wed, Aug 13, 2025 at 11:53:36AM +0200, Janne Grunau wrote:
> This adds the "apple,j415" (MacBook Air (15-inch, M2, 2023) to the
> apple,t8112 platform.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index da60e9de1cfbd0151e973c3aafba6d0880fc21aa..3b90b5df60507b245de387de104a4e64f234139a 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -93,6 +93,7 @@ description: |
>  
>    - MacBook Air (M2, 2022)
>    - MacBook Pro (13-inch, M2, 2022)
> +  - MacBook Pro (15-inch, M2, 2023)

s/Pro/Air/?

>    - Mac mini (M2, 2023)
>  
>    And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
> @@ -279,6 +280,7 @@ properties:
>          items:
>            - enum:
>                - apple,j413 # MacBook Air (M2, 2022)
> +              - apple,j415 # MacBook Air (M2, 2023)
>                - apple,j473 # Mac mini (M2, 2023)
>                - apple,j493 # MacBook Pro (13-inch, M2, 2022)
>            - const: apple,t8112
> 
> -- 
> 2.50.1
> 

