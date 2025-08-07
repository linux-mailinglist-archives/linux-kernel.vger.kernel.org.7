Return-Path: <linux-kernel+bounces-758735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DBB1D348
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663173A5DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8423F439;
	Thu,  7 Aug 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RARr7oXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346D23C4FD;
	Thu,  7 Aug 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551618; cv=none; b=nxD1jdE1GO3/BD1uHMZ0ptYEKnKTO0a8VV+0qCQ9xMe1wAKPMWTGQ4WboduQcLIKgT8YR2RUcLUJV4yuqhzAt5ZGBlCHFTMx7LhhcudNbyj/VEY++vVn4jhNuRwYyFkhtBJMaOn4TWfrFdaVYomqR4yLv5AKEjG5RbtlHZX40y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551618; c=relaxed/simple;
	bh=bb7LlDA7OpV7Qv2Xzhoqqi80I/uW8JaOPH4FzntEDfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSyraXSqwzVU0RqBosm/VcSUvEm9h8pg1sWZQh7+RFSMdLXIojJJUn5emeYLsvA1rT/AJ26E8RAwIQoLoytoIGMPohSmr99dds3w5Cy6kJnHKPnDq9qJV8F69bf70uyXBuhO61lpCcY3tfEaMF8sudF6eZoe2bgtLp4ec5ThQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RARr7oXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6275DC4CEED;
	Thu,  7 Aug 2025 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551618;
	bh=bb7LlDA7OpV7Qv2Xzhoqqi80I/uW8JaOPH4FzntEDfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RARr7oXYIsoOmGGKVYK80eGl+V7p9fEMpd6wq8gkvI2QAw3Pdn/Qza1dm4JMuQIrR
	 ckHcFFIbPjSyYXr/bDzKd9wTpftvlrtlWh15XwQH58GQlO6e+zJGVNp3500ZZn5QYD
	 5QneCWxxF3IjJSq5ND/6IsuN9KFsCuZch9rp7IJaEKeFaWa8yXIY41vKuTh9M5iowv
	 ulfCsz9H9JMuN7Rc6ASg0VhV8C/3QfmVDNQteffZ4he+83stLI7XNfGWr4Vd5y9RNR
	 e6HhbcXI/axVm5F+nI+ndKUr629ax2PLvQV26eyZ57qaiXWLKFxTy2cm/t4Tz3sNwv
	 ItroFzgrdWagw==
Date: Thu, 7 Aug 2025 09:26:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Marek Vasut <marex@denx.de>, Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/9] Add support for i.MX94 DCIF
Message-ID: <20250807-psychedelic-vulture-of-valor-d743cc@kuoka>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>

On Wed, Aug 06, 2025 at 06:05:07PM +0300, Laurentiu Palcu wrote:
> Hi,
> 
> This patch-set adds support for the i.MX94 Display Control Interface.
> It depends on Peng Fan's DTS patch [1] that was not yet merged. Also, it
> needs the BLK CTL changes [2] that I spinned off from v2 in a different
> patchset.
> 
> Also, included in the patch-set are a few extra patches that the DCIF
> driver depends on for functioning properly:
>  * 1/9 - 3/9 : add support for i.MX94 to fsl-ldb driver. It also
> 			   contains a patch (2/9) from Liu Ying that was already reviewed
> 			   and was part of another patch-set ([3]), but was never merged;
> 
> v3:
>  * Removed the BLK CTL patches and created a separate patch set [2] for them;
>  * Collected r-b tags for 1/9, 2/9, 3/9 and 9/9;
>  * Removed the DCIF QoS functionality until I find a better way to
>    implement it through syscon. QoS functionality will be added in
>    subsequent patches. Also, used devm_clk_bulk_get_all() and used
>    dev_err_probe() as suggested;
>  * Addressed Frank's and Krzysztof's comments on the DCIF bindings;

What exactly changed? I cannot find v2 of one of the patches, no lore
links here, so with incomplete changelog I say you make it difficult for
me to review it.

Best regards,
Krzysztof


