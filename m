Return-Path: <linux-kernel+bounces-791281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92018B3B492
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CBB202767
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543927B334;
	Fri, 29 Aug 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvfiFxAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFC2773DA;
	Fri, 29 Aug 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453413; cv=none; b=d9DYozuR6do39rRQOJws2B0362iZIayszjgSalo3rpeMGfbjND9Tlv0spscMmoEK7Ggq1JQ7BmVi3z2fW2OBUja312byKD9dDgYX7W7YcFtDBBjYA9EVautfHJYIDMyxU7A5FDJ58eARacO/7cp+SdFKoX0BW1gnItxTNP2OEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453413; c=relaxed/simple;
	bh=UK2uW67ec5x+08v6vV2jlWqCPKcZr8vv4roBxG38sHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZY17VA+NP1y7D4ft6vjMxvlKoNBbZkGCoHydIo/CB1Mwd3PPDam3mq7A/zNNO5gJuxlm3xaiQO2p4Ghfz154VpNbkPSv8AFVFwwzGBuAWeKOdTu2gBi1WQ08D5Y1mxNh/9Ef0RQ0jgWvNUGeZBL/AFhwmbR/tl6bw3WvB1NWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvfiFxAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DD7C4CEF0;
	Fri, 29 Aug 2025 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453413;
	bh=UK2uW67ec5x+08v6vV2jlWqCPKcZr8vv4roBxG38sHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvfiFxAYJ7gJJr1nu2uBXoz8U6xai4fMXhrg3dEmLBMVEOQoB6cW3wn5loGt4Qshd
	 6bWokTKBP4rPg7MtN9FpXLwasYeTPN47LIhv8Fq6vxwCifTxj1/1SK1RvCUSArLq91
	 0rxOHkKL4FG7FCqYwz0qbw+WG7zfePy3um0+POPsmbNMG7Yjzg6CyY7l3Fhwxpir8I
	 fYPX18UOLiIPNwQKkVTHtY2jXaPsBQERnV8PZK3cDjvSwiDSuFGR3GCpCZUWdCZEM4
	 5dvqQvwnV/Twy+m0AnrwwqGGB2URxnDt3dqBaNxVOyodeuGAv3/JbbsF5tEr32C/ec
	 EWl0YbIXEoc9w==
Date: Fri, 29 Aug 2025 09:43:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com, 
	13916275206@139.com, alsa-devel@alsa-project.org, shenghao-ding@ti.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com, 
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com, 
	chinkaiting@google.com
Subject: Re: [PATCH v3 2/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825
 support
Message-ID: <20250829-turquoise-jackdaw-of-joy-cc91fc@kuoka>
References: <20250825034039.9713-1-baojun.xu@ti.com>
 <20250825034039.9713-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825034039.9713-2-baojun.xu@ti.com>

On Mon, Aug 25, 2025 at 11:40:39AM +0800, Baojun Xu wrote:
>  allOf:
>    - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas2020
> +              - ti,tas2118
> +              - ti,tas2120
> +              - ti,tas2320
> +    then:
> +      properties:
> +        reg:
> +          description:
> +            I2C address, in multiple-AMP case, all the i2c address
> +            aggregate as one Audio Device to support multiple audio slots.

I don't think you resolved Rob's comment.

> +          maxItems: 4
> +          items:
> +            minimum: 0x48
> +            maximum: 0x4b

Also, fix finally order of patches so docs go before the user (see
submitting patches in DT dir).

Best regards,
Krzysztof


