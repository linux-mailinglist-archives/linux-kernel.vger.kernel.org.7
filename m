Return-Path: <linux-kernel+bounces-813322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51CB54389
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B2178112
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246462BCF6A;
	Fri, 12 Sep 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2uUG2di"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533C199FB2;
	Fri, 12 Sep 2025 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660985; cv=none; b=ZfBVGFLbfm4JS2SVtikJXYp7lAhaLwWS6TDGfTOuA7xN0Mq5Ma2cfO9u0Noqgvb5cz2LhT2lMJQC4iL+pj29FES/0xU1B7C5otPItsNwoYmMCmi8qV9l5kVbneZNvos3Dno2Mm82IIYgPnzhjH9x1VGLdAeAjAdwVnu6HqRKSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660985; c=relaxed/simple;
	bh=4AlYbUZqbeoGnHZ92DdTmZ5FEV+tYiDs7FOZ8YpY29U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGjpXbn8kivCM7L1izf44e1yMJgO4M27CQnCGtSeW2dUrWuKSHJ/WyejDfwAFDBb7ftyyPm7c1hlUHZWA3caAfD6mkKa3gdsELDOKXz59npLIWBO4ulM1lTvQjFo+T/J0ggdKju7qPVd6n+812SEuaJBu0I3LaAJyWWf/gGRF2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2uUG2di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBEC4CEF4;
	Fri, 12 Sep 2025 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757660984;
	bh=4AlYbUZqbeoGnHZ92DdTmZ5FEV+tYiDs7FOZ8YpY29U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2uUG2diI3Zm5h84JEAUPN/VYN+T1o384EdT5mjkNcnGKKElEiA+X75BxRaieiVLH
	 nzXpIAK0bfxjhBqku0zTNcL4s9mf07zhnV4dlawdAkmcueJKwOu4ql/yW+f08huXjd
	 YSJyc/43tlOEORw99ZXvBsitrmzxArTfvGWxCXh7XQOrTBDPlcwZa0EbDEvpS+udRx
	 lBevJk/fJQcgLlpk5jYmzHK9zn9Y6xUtL29OHgrj1ZWEixm238y/kh0jz7psdpf0bW
	 OSvCwXcoLUjV3FZLE0gC+KkWgQBWN7wfNbgFxJIEF/YIQ4N375yKrwibeGXbWe+Paf
	 PMCzca9hZg2kQ==
Date: Fri, 12 Sep 2025 09:09:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] dt-bindings: display: imx: Add i.MX94 DCIF
Message-ID: <20250912-astonishing-bipedal-raccoon-4a9c67@kuoka>
References: <20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com>
 <20250911-dcif-upstreaming-v5-4-a1e8dab8ae40@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-dcif-upstreaming-v5-4-a1e8dab8ae40@oss.nxp.com>

On Thu, Sep 11, 2025 at 02:37:04PM +0300, Laurentiu Palcu wrote:
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx94-dcif.yaml       | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


