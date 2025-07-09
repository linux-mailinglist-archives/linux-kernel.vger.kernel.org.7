Return-Path: <linux-kernel+bounces-723332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EBEAFE5E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346B7583392
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907A28D8C8;
	Wed,  9 Jul 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2o4xD1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2028D849;
	Wed,  9 Jul 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057390; cv=none; b=SoEdeWq8lFAb5QEB5DGsF9kH4s6k/nC86vzticCt7Q+Yx3jZvhFYxFZE7Ny0PC6JEE7dqzw5ck+qa2VWZEK/Xvb7lwZdSeNJQeNBkNg3vcj8D2iO573F7orHy/8drjjErapTZXR/MFiZxMC5KMxF9XdQR6Rp+VB6h2ElrhrGWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057390; c=relaxed/simple;
	bh=gi+5G+pLYD4q0Q8BI4jG3meGArBJd7O2WnKjN/ZV8sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzWxEUSskigvkohXFA3vbbUK9hnTMOE3N3MRZBYHzyo1BWapth97ape9Asv3RWmmyG3+WR8lstQQyC/QlbNMJsnIBHprfh6Ws5VwPYSW8yupBRgmlyYoSQy1sSA59sU0MBpYWq1AdIxJqla53Pkt0Zw7pE+s3Jl/3KQoYuBThSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2o4xD1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F4BC4CEEF;
	Wed,  9 Jul 2025 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057389;
	bh=gi+5G+pLYD4q0Q8BI4jG3meGArBJd7O2WnKjN/ZV8sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2o4xD1VWSfuVJLjRg/prdM12vZTaIJwpxwaHJrtPdSN0pRFr8Bbz33sYLng+U22O
	 ux9783l5EEX7MonC/fEodHyZ00mAHdC8CIeN59IO80Y7wpyE0OIwi1diDXFxbZsYjc
	 2oNy/x1cvZA3RHoId+k43HZti9GT5c7+651HrUYbC4EyQCAurx9ruqWjxJPW1Of6XQ
	 8dMlkP2lnhpj9SI3qufhYthq/qlTXqTk9QLjrRfxqbdcWwJg+MtGHHfJVub10STIDK
	 DzStVImS2mg9/wbKTQxGFPwc0qC0mMUiXTAREaMPZwEOLz+gRfdRt/5s5cpw8ivlek
	 EKnMvBuQXTSuQ==
Date: Wed, 9 Jul 2025 12:36:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, like.xy@foxmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Shanghai
 FourSemi Semiconductor Co.,Ltd
Message-ID: <20250709-dramatic-poodle-from-tartarus-23ee12@krzk-bin>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-2-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708112901.25228-2-nick.li@foursemi.com>

On Tue, Jul 08, 2025 at 07:28:58PM +0800, Nick Li wrote:
> Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
> Link: https://en.foursemi.com/
>

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


