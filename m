Return-Path: <linux-kernel+bounces-768379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E0B26046
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CBF7BB001
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B72E7173;
	Thu, 14 Aug 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEhar6bM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAF21D3CC;
	Thu, 14 Aug 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162530; cv=none; b=agDOxevnEQbfjavn10+EkUMpTnehkbAqcv4o1CoLFz15LepzaScY5oSX/oIPh/BSHe9t3EWBQEvcvLTW/9jl3E4R5kibQoHDTLSMcO9lnCi7n4tVFU9zc6VJPyZ3kqyj1CpN2Lf0Xgc+x/WkofEyGxu0Oyhj77bvOdR/yQtzybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162530; c=relaxed/simple;
	bh=SrgIKHyQzZsNRjZjaedpryVUikg6Qu1TuEDXZ4F66GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpO73C2Cq04YBwrQZR/VJnS0cGKSqCVJVXe5utcU+dJZvVZHhFEUCaSBJOwBsq+U6s3u/uFFN74/VYc7kxYTyla+gX79LicjCrUgIo9mqGNaL4Vb1CWBMiqSsfusd9lhaQkmZlG2DSj3hl3KQJE5uZxXTWGCY7zt6heB6qR/lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEhar6bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441AFC4CEED;
	Thu, 14 Aug 2025 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162529;
	bh=SrgIKHyQzZsNRjZjaedpryVUikg6Qu1TuEDXZ4F66GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEhar6bMklvfkyPidpHaCkPhVHC2IBI1dey6oRukc416ApLx9OQoXpnokam4Iu3IO
	 3EhE8j6+HI4tbeLxI0Jo5xc4UpYECb8jj0Xa0GKvLoUxlR6d8ueXSFChmDOuF/7H/e
	 iFVDPVV3Y53BKP6ribAcTfPkS/Lf/9N63cEIYz7ZaZQIYG6iXdk6SPhQI2OT8cjEDV
	 Krs1Zlt5macbMAGdvULwB1vLxE3+8jZehLY42zDEHBoE1XxG4FVWmE/WWqdriKWj+6
	 DSAmRogyfDzfzNltXHf4B5+cT89ZfHionEfAof148q7RynLlADN8wBpD/T8pLCZKwi
	 0JqK1RQh7lJvw==
Date: Thu, 14 Aug 2025 11:08:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] dt-bindings: display: st: add new compatible to
 LTDC device
Message-ID: <20250814-resolute-lime-raven-de4fa5@kuoka>
References: <20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com>
 <20250812-drm-misc-next-v2-1-132fd84463d7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812-drm-misc-next-v2-1-132fd84463d7@foss.st.com>

On Tue, Aug 12, 2025 at 03:48:58PM +0200, Raphael Gallais-Pou wrote:
> +else:
> +  properties:
> +    clocks:
> +      maxItems: 4

minItems instead

> +    clock-names:
> +      maxItems: 4

minItems instead

> +
>  additionalProperties: false

Best regards,
Krzysztof


