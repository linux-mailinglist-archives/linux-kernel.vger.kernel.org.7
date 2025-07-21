Return-Path: <linux-kernel+bounces-738843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE9B0BE08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B1D17BF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44172264AB;
	Mon, 21 Jul 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvxrz/oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB1E555;
	Mon, 21 Jul 2025 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084091; cv=none; b=sljosAYPu1XxxdgdD95fhboTSv0fvHgzDA3zi615AuCCF7xUbbnJh40iXDNmADqlveqge2qZdFxWBeyoke0fOpY6q1Z8234GhRgCKLJjgGfJR3rdYY8crcFaCmRlYNQ0g4/QKWhi7cI4p9utIv6k/g7M/OMQ4yth2mU0VIF3Cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084091; c=relaxed/simple;
	bh=Yr2TAYBwVrywxclokIQQQXS7VDbp//K2qfzHen68C5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIpQNkUyLHSQ5u9PzCQzPjmaUrVYAVjtXpbXpNqSQoIzjgkC6XlcxvkFwoI+rBFGyfylZzm+bWFyNCFByC9VrjZQggYunsICuhYix3nxd5zgiphpp09D1RDOeMie9Zk5PpZ7TJ00IGh7usuijuxv+ERXsej+w3QDF4O37hOrh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvxrz/oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AD1C4CEED;
	Mon, 21 Jul 2025 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753084090;
	bh=Yr2TAYBwVrywxclokIQQQXS7VDbp//K2qfzHen68C5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvxrz/ocTISY/RULSoMQJVnWYi8VUnTEb5m2CcEY/fe1tyReBYLJv3YCT8zW5gYCi
	 wfqn6rRzKGh2iyM0QSh2pgWRZtKwtvVFKWMxMlh6laO8PlxIbukTvGM/bn7Swa3Mrr
	 eDoWL3HY6lNoBHfiIYJQOX9KFIB0mr7YR9DxewIDoP20K+E6itZCUe+JecZ5lPqE2n
	 xSn+FSHsoZmVFyQC3tx72lmJ1u1bwacdzxADTr2wZtp9TsXJxmwYY/7UEFmBMLZCHe
	 rNoxyT5oXkylAbOs6WV8nqwxWX3s/U30v4oiDgM2ShT92CakQ4Tm85HqHdalh/QFFV
	 2mwKk+1AkBMQg==
Date: Mon, 21 Jul 2025 09:48:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Message-ID: <20250721-vagabond-hidden-kangaroo-de93c2@kuoka>
References: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
 <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>

On Sun, Jul 20, 2025 at 05:31:54PM +0530, Kaustabh Chakraborty wrote:
> Document the Synaptics TDDI (Touch/Display Integration) panel hardware.
> Along with the MIPI-DSI panel, these devices also have an in-built LED
> backlight device and a touchscreen, all packed together in a single chip.
> 
> Also, add compatibles for supported panels - TD4101 and TD4300. Both
> have the '-panel' suffix so as to remove any ambiguity between the panel
> and touchscreen chips.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../display/panel/synaptics,td4300-panel.yaml      | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


