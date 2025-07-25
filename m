Return-Path: <linux-kernel+bounces-746284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C99B124E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0977B8D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37924DD01;
	Fri, 25 Jul 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxp9UEfE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBBB1E766F;
	Fri, 25 Jul 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473032; cv=none; b=mqRDdgAy2tanAV6ZT8HP8i5ZVpN3PRXYVb4xjU7050uG4Z8HGDEg0JBI72rvt0v7yQ8ZE4wQ5Mc1PzpCjijUIryK+hbEoLPhfKN66HC1LaRHTKG3uKUezV4eiqkTau2e0i+YLZIQeB835nnlZnaNGbmlPYvAAVU8yh18M0Sfrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473032; c=relaxed/simple;
	bh=6lY6UGRDx8pQqm2Sb2XSSnUUQnx59WVl3IMojaG/Ruw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1HrZdhDiIZaWbaiPJF8h94H9S7NfK8e89lzLcYkEBO/D3Bvg7JvMfdDCT5UHsDoWrUMWJivQYbigxZH0gH+UURjTskh72We++GQwkURpBhdtYcYDUWyt0I957bMrd2qpZi8GKqrH0kqugzjJBoVHgZ/PPAJjXs+CzN8Ao3/6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxp9UEfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA87C4CEE7;
	Fri, 25 Jul 2025 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473032;
	bh=6lY6UGRDx8pQqm2Sb2XSSnUUQnx59WVl3IMojaG/Ruw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oxp9UEfET5NaqA86+frV0GpYesrm5a6+Y91ObXxbH/l3ZMs8itaYumIF4kJ262fui
	 f2JZ7SK43n7wt6+w7fB6MND3aDzqMst07G5/AmDUVIusijI0gwZFKPS04db+yGZ5z/
	 C1Bum5jGv372JMKCMeSVyzfYbUEkIwTVbpmjB4qUM3hm1y2RSGGZjGHfkq8S8Z7IR0
	 0bCYDOArJfhVtXL723YvFzRR2U32j+hXNLIRPYe02YwpnMkkaVs/P2RPcPt5DssKor
	 3BPb7ZjZvWk08y9FE71kJUgyYZPR8N2AlauH73m3hFUzaRGj3q/LyLoGfJa0PPOMSj
	 j1QAIkSAe23cg==
Date: Fri, 25 Jul 2025 14:50:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Will Deacon <will@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH 02/12] dt-bindings: display: st,stm32-ltdc: add
 access-controllers property
Message-ID: <175347303098.1735273.16989682825723022280.robh@kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-2-a59848e62cf9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-drm-misc-next-v1-2-a59848e62cf9@foss.st.com>


On Fri, 25 Jul 2025 12:03:54 +0200, Raphael Gallais-Pou wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then check
> the peripheral accesses before allowing its device to probe.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


