Return-Path: <linux-kernel+bounces-782450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A263B32074
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563C27AB1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8530393DED;
	Fri, 22 Aug 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfZEfi65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C344286D76;
	Fri, 22 Aug 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879998; cv=none; b=c/Y14xWOAULOt5ten679V4z766Mk6J9k2HGN7IYQynBdzygVqoSoIwjiWOffrHTH4jwNUZU0b31zM+nj8FWTb8cOqApzK8y2ekL4GIvyiG3k8XwXMDTY3rQsl6Y8Zt/eA3JwMMaSy8ehlDwitc1yzPqezET57PZ9yqy3JLrzLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879998; c=relaxed/simple;
	bh=gqeBbcxNavI1L2mbvgc6p1M/POMGsZs1Pur53RdU1zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY2SJK2jNbMWajO2hJvpmF9etJvzuf/PtrIY0TafviRTGN6uv0lH8IdaQVEomq98Zt0jTNNPUaRB3thwFxEAfrORItQDATch06NS4+b6jbAgRaz7ETH3IS3yLOztAoyc2EbcUC8Alop+8rszdcEOCjh2LilWvPUor5QYa8PoSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfZEfi65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C6C4CEED;
	Fri, 22 Aug 2025 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879996;
	bh=gqeBbcxNavI1L2mbvgc6p1M/POMGsZs1Pur53RdU1zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfZEfi65V81DWiABQvuX9GVUFfEBh5DX1N//+22SzsOvF7mKscQvJktc1iiW1+kkk
	 2r24TzHuOfqhYjwgWu+p8B7ghwOtlV2pwR0Kr6JJ3BRYWLBskO13LZcQ78Ff27Y1Om
	 63pPAPFFO3kD7cZLG+ST8G6mujcjXfAPSMPVdFJuy7/Y4U6wvTOulLvWSZy3zqfinv
	 Duzw6UxrqEgevFlDHG3bQ3LW53Hmsk1dv2+bqpjuGz9rhj5DdNNR2YnHIbO1Q3221f
	 NTL70yCogjD6O1IvAk5+RnhAXucniMeW6SvWioa2sBeGMMjYKMEuZa7nVLeRge7JSh
	 ARMfUAJ/aUG8w==
Date: Fri, 22 Aug 2025 11:26:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Simona Vetter <simona@ffwll.ch>, Fabio Estevam <festevam@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: arm: fsl: add compatible for Skov
 i.MX8MP variant
Message-ID: <175587999529.3977942.15581850893122892977.robh@kernel.org>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
 <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-4-b492ef807d12@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-4-b492ef807d12@pengutronix.de>


On Thu, 21 Aug 2025 09:55:31 +0200, Steffen Trumtrar wrote:
> In preparation for adding a new device tree variant with a different
> panel, describe the DT compatible in the binding.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


