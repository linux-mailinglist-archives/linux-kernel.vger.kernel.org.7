Return-Path: <linux-kernel+bounces-597457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A52A83A12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425C03AFEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 06:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B420487F;
	Thu, 10 Apr 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khKiGgoM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DD2040A8;
	Thu, 10 Apr 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268302; cv=none; b=euIw7UwpbvVQ9LaWLNht+aS/K6o4FAfC3B89SZxcVmgtyMYFGAC4Ts4E1TWoETsPn64/T5FNf3RMoejBIMrm7k0PMelau6iFvvYFBuocUkfiZV9Qd2/bBHGVGj8mxi+QC91iX7YZwEqLQt4EmhB7J678dMNUS1h79rDS5y8Wreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268302; c=relaxed/simple;
	bh=W+EjxpeVVScky8ANFtmNgCyiOFblKlvus+RVoVF6ZF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftx0K3U1LEjSjUErfkeQ3/m7QZyDVqUbt2MA+1wdpEsu3FnNGaaJuzlQceHEuYutMoiOz6QN8fVA4E22KesRo+IywS2kePf5YBRrObik6BtirgQ7un6lCQlVQ4H8wmYg+EjmS/tHPoBs+EMVq0UAhhhU7cbJQXN29lMUnzg2w10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khKiGgoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC65AC4CEDD;
	Thu, 10 Apr 2025 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744268302;
	bh=W+EjxpeVVScky8ANFtmNgCyiOFblKlvus+RVoVF6ZF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khKiGgoMdhXNa4Q70CPeyvi4b3wCMd8N+O2H3+z7Ol88vgsgfxTPIDAxIEsQonDwh
	 sGT7UllzMkwwdS7LYMH+Mzh/q4q8plLOBqgYY5Vav1o13Ol6unC7eK1bfxubJWttg7
	 lJe369QP9Ya169umKfrum8V+a+iCv6hE3xdQ+eG14F1jt403D9Y13V9iRXMjCmuwzP
	 +z2nR4ioD0EIREd0RyMhCESXtzsNK8GBw23kUGd4KZO9dRDSjMZDTkoAPhvE8c88N0
	 z4msUQXu2dhkXyrwmGVIzFPR/1XBh17OybNue+17NBoqzF2mZwUnd9klmdCLMsZZ2a
	 T9AxYUcuzy6NA==
Date: Thu, 10 Apr 2025 08:58:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250410-wonderful-stereotyped-jackal-87fbf5@shite>
References: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
 <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-1-dab85a0a7c2b@tdk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-1-dab85a0a7c2b@tdk.com>

On Wed, Apr 09, 2025 at 05:14:31PM GMT, Jean-Baptiste Maneyrol wrote:
> Add interrupt-names field for specifying interrupt pin configured.
> Chips are supporting 2 interrupt pins, change interrupt to support 2
> entries.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7e4492bbd0278a336587dc5ac04da7153453da29..d4d4e5c3d8562523872a737864610c26c8fccd82 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -39,7 +39,16 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2

Why INT2+INT1 should be valid? Why is this flexible? Commit msg should
explain that, otherwise we expect fixed number of interrupts. Actually
commit msg is here specific - always 2 interrupts, so I do not
understand why 1 is allowed.

Best regards,
Krzysztof


