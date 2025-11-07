Return-Path: <linux-kernel+bounces-889916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D2C3ED3D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1C3ADFB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F930E85D;
	Fri,  7 Nov 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIH4cW3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550B2C11CF;
	Fri,  7 Nov 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502072; cv=none; b=SWEM/jqiHu+rtfIO5r6s4wO2cAyIsYWjWnUXtUN7wTCLXfFLdqd9T86sYnedGDZmE/ghkEZI83bseXSZhud0Ae6jZwjrREFCnPndM2xpynb4tHdTHreeO83TtDtXTeZTAXFqKb3sGlF963wtpJGmRFujdq6EAxWhBh19JaCX8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502072; c=relaxed/simple;
	bh=3t8OmQN+HWYwvBz12hbfBvBSJ0jdJVm7jFSV6g0Km68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxkEH2cUgj+NG+BY8aY4D9ILEy5ZuF7FWp9wiy1EyjBLkloYEVNWnt0W/igaRYKCV/SEkKCPUFNm7gxFOEnXpF6OPiFQEb855oGG5meVdupk2IVh6eqMPIDHEfcPhYxo72fQG3tPeSrueA7EqVG+HC/6AdhYYekMhSgOpL+lgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIH4cW3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82EAC116C6;
	Fri,  7 Nov 2025 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502072;
	bh=3t8OmQN+HWYwvBz12hbfBvBSJ0jdJVm7jFSV6g0Km68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIH4cW3M/RQ8AdoJIJenlu9nKammXIewaPCtUDKifyrThHEXQ5kSlXxi2GPaClpZR
	 jGykLAz3i530vApg7DV/VcBCCHArXeSWdN8xIeTBy8gdoyZVQirlaQBoNhW3gwIZKV
	 S+eYCI+vxJlSUacb5MojnsnSYSJOr5Hs7fSkT/+35r/zINWl1Mh9GlYFl+2IHfYLXz
	 eCYEqtpNNFEj3PHG3R+VboKSowfbKxLvUHUUPurABTZTg/Xk2jmFE01WhYb2J2gsVR
	 dvjO1AxDgcOyzZmzxtdCqFkEC7rK26FyYAWlUxIe7PUBU/6v+ecxH7FuFLcQwrMQ8x
	 ASUUGtzDbOsKg==
Date: Fri, 7 Nov 2025 08:54:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, louis.chauvet@bootlin.com, 
	aradhya.bhatia@linux.dev, devarsht@ti.com, praneeth@ti.com, h-shenoy@ti.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: display: ti,am65x-dss: Add
 clk property for data edge synchronization
Message-ID: <20251107-amaranth-platypus-from-betelgeuse-7673b9@kuoka>
References: <20251106141227.899054-1-s-jain1@ti.com>
 <20251106141227.899054-2-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106141227.899054-2-s-jain1@ti.com>

On Thu, Nov 06, 2025 at 07:42:23PM +0530, Swamil Jain wrote:
> From: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> The dt-bindings for the display, specifically ti,am65x-dss, need to
> include a clock property for data edge synchronization. The current

clock properties are called "clocks". Please rephrase commit msg or use
proper clocks to indicate you access here a clock (if that's the case).

> implementation does not correctly apply the data edge sampling property.

Where is "data edge sampling property"? I do not see it in this binding.

> 
> To address this, synchronization of writes to two different registers is

How this binding achieves that "synchronization"? What are you even
describing here?

> required: one in the TIDSS IP (which is already described in the tidss
> node) and one is in the Memory Mapped Control Register Modules.
> 
> As the Memory Mapped Control Register Modules is located in a different

And now another therm - MMCR...

This commit msg is barely parseable - language is correct but it is a
mix of completely wrong terms.

In case you used LLM to write this - don't. Ever.

> IP, we need to use a phandle to write values in its registers.
> 
> Fixes: ad2ac9dc9426 ("drm/tidss: Add support for AM625 DSS")
> Fixes: 5cc5ea7b6d7b ("drm/tidss: Add support for AM62A7 DSS")

You still did not describe the actual bug being fixed here.

> Cc: stable@vger.kernel.org

Best regards,
Krzysztof


