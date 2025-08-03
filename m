Return-Path: <linux-kernel+bounces-754459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95410B19488
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413EC1892975
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B61D86DC;
	Sun,  3 Aug 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdDhpMmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B123AD;
	Sun,  3 Aug 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240061; cv=none; b=fY/tvLWFz7nCK4fn2fwf4AOySLkQikiCwRrrHeahDhvFrzAVvAKhOkzSyoJ5pFGHsMbevDZ1Dkro4i33z25XTsloPRfcB26AepiZvztuKHXTekvC+a7CQbIdLLLd78WhMRqj+Q2tsHDXWYlOyec2FSfSr7L4xoJPWhljkBg3eZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240061; c=relaxed/simple;
	bh=MBm7ZsvVwbCPe3opDnhyrGNHaw8Vwe/UA3+xsVo/aKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuJyj4wmqyLsRIaapLVP/mhEQMEQlVcO8BTe2npwdIR5B8zIiYSnFR8IHW2DYjU4/6ToN54Lsoj332bSRHxqT6ZvIIFIguk4KZ5FyLN4/lVV5QXB5cgpr3BU0Dx7lLP3D1eoVDhs4GpNGnbaS2NhPA6mIdLnTIkeN+yRWy8s0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdDhpMmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DE5C4CEEB;
	Sun,  3 Aug 2025 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754240060;
	bh=MBm7ZsvVwbCPe3opDnhyrGNHaw8Vwe/UA3+xsVo/aKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdDhpMmIBqHp/G+ox1idH2muGXJGz0SMy4auV88TnspXhNfNr8irsr93brC0357u4
	 tATQ0Cr7K90a/M/BfCie3lPRdIVKN3ef62MaswJkucUS3/s2eyQ87o6RVJ+DZvSaMd
	 6XaPVzYUWuiyyaDFaWCoohod5TbcwpyvfELGrwWsqYTc/tPKn6ajQiFyhO5B5cayWX
	 iw30lFWDtNNihKYaQF3WOokaBIVGxc7Hrw83I+k00A7/r2os9c96hu1Hn5pf08M7uB
	 gqllGe54KV1dlv7I1k4hubz/JRnvLVGlCaNmhWOikyGtO+pXQNcI6onxQzSXTXPp+6
	 Xt5ymue6tTxag==
Date: Sun, 3 Aug 2025 11:54:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kevin Tang <kevin3.tang@gmail.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, David Airlie <airlied@gmail.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Kevin Tang <kevin.tang@unisoc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 02/16] dt-bindings: display: sprd: use more
 descriptive clock names
Message-ID: <175424005938.523766.7181495703090197785.robh@kernel.org>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
 <20250731-ums9230-drm-v3-2-06d4f57c4b08@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731-ums9230-drm-v3-2-06d4f57c4b08@abscue.de>


On Thu, 31 Jul 2025 17:51:15 +0200, Otto Pflüger wrote:
> Introduce new clock names that actually describe what the clock input is
> used for instead of referring to a specific clock source.
> 
> The new clock input names are based on information from clock drivers
> such as drivers/clk/sprd/ums512-clk.c. The 128M clock appears to be
> CLK_DISPC0_DPI, the clock used for the DPI output from the DPU, while
> the 384M clock is CLK_DISPC0, the actual DPU core clock. The DSI
> controller's 96M clock is most likely CLK_DSI_APB, the APB clock used
> for accessing its control registers.
> 
> Since it seems possible to configure different frequencies for these
> clocks, the old bindings do not even accurately describe the hardware.
> Deprecate the old clock names.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 17 +++++++++++------
>  .../bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 11 ++++++++---
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


