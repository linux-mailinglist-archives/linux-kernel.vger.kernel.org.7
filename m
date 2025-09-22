Return-Path: <linux-kernel+bounces-827526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E88B91FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AF188EAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9592EAD15;
	Mon, 22 Sep 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkwlHwUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054242EAB84;
	Mon, 22 Sep 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555308; cv=none; b=u/UwJH7RfQa8rO1Auw/Y2lPtyUtFrmJBdtNNxtG6h7u1KLhQvtwN1M8ZjqOsstwfIX+49R7yLDtILPavdhTBEfxLEwpEnfyaeDI1YXC2Uhl2F4uTR5zwcyVq7Fz8mzfy3dD+JHlgfT9JYoZpDovsmec70aULLtzHL0wZIw/q93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555308; c=relaxed/simple;
	bh=x+yYvHNSmvcVv77y7miMWOue4Y5ydSD0q1FOqvto+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZya6aY/kRVzSdpwG9ppZrZTGJO6HzfIorXihO0U4LEY1eyfE8tSzP89003nyi94dy8y48J83giCQUvY6G+X52E/3AQM9e1f/r+YbYLnYwF5BchpdBI5RyPyqfi72Dkhvm22YCTNKBL5upmRVGJETXGJEIckO+V5vjIlUnMV5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkwlHwUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90F7C4CEF0;
	Mon, 22 Sep 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555307;
	bh=x+yYvHNSmvcVv77y7miMWOue4Y5ydSD0q1FOqvto+BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkwlHwUeGfUX+TMrhULRFwNoHl6PV8x2p5ll3AUw9muVYXM3EVfaPzwhbCJmSv0jx
	 58JbizFTSriYXEYXWs1NosL6tdMX8USyTdpNngtyeXV/rHPH8uMme7P7eJ5P5flO+I
	 g7oViGh4Vwoy3FKxRwZU4Eis9PM4WYovd8iPFOteLNK4EzJGO3yDbyMv1Nw4t3l04p
	 OuN5VZf+vs18BeOv1ouPzFzHaHRfljcjHs+ttPApFRKzvb+C05pjSCIyv4L1JErC9d
	 vR3YPJPNuMVqSOYWvQan8HbIG2w8AV2e7sCpJUOc66jrTByYZm3b2vNwkH1IXgT4xc
	 G7xaRcRxfmE5g==
Date: Mon, 22 Sep 2025 10:35:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: timer: exynos4210-mct: Add
 samsung,exynos8890-mct compatible
Message-ID: <175855530446.4181224.17537732098135113411.robh@kernel.org>
References: <20250914132339.2623006-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914132339.2623006-1-ivo.ivanov.ivanov1@gmail.com>


On Sun, 14 Sep 2025 16:23:39 +0300, Ivaylo Ivanov wrote:
> Just like most Samsung Exynos SoCs, exynos8890 has functionally the same
> multicore timer.
> 
> Add a dedicated samsung,exynos8890-mct compatible to the dt-schema for
> representing the MCT timer of exynos8890.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


