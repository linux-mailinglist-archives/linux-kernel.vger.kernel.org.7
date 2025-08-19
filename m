Return-Path: <linux-kernel+bounces-775927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE28B2C68E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CC5168D96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2D1EDA0F;
	Tue, 19 Aug 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmfdVUEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72C16DEB1;
	Tue, 19 Aug 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612057; cv=none; b=oIOENjBF5ecvRDszuUf3/M1wwZqAmSU9AlCgaUEkTGlIgIKDp9AYhQRxJ4nLHlxdDaA1jFlrpBbqqZMmw2VBks4ap3g22OVjZTC+VYxvoFFq9L+m2iHwBXaVXvMfb5JgDmidBc8T4CLqI044QZwKVAMbU1GRAYL0RmYcZ5yzIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612057; c=relaxed/simple;
	bh=v2bxLEdMiFhvVeDk2VKDc+laagxhg9z8Eu0qAxJIl7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdM+QBM9HGopl86yPbZR433q0C5s3zpT0wlXG5GmaO8O29HdJYaX/VpylnsYiBGnhcvdwiFCwPhzh2O+WNnNuPo09CaIQ4NF1S85KpC//SuX1MJKN65bp5K9Z8V3IzPZkeqp6pSkOjrjbDITINY9QgcUg06AdVaBnr+PO0KM5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmfdVUEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE42C113CF;
	Tue, 19 Aug 2025 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755612056;
	bh=v2bxLEdMiFhvVeDk2VKDc+laagxhg9z8Eu0qAxJIl7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmfdVUErvstxofMsyj58so3K6FN/i+YTaRTO5Jdsk3hoE2/J5nLYCgWa5YidwvM4C
	 seymARtPPdkn19XQuu0a6MCL/ACSKM/nJ4AQebb3Y1AjoGyWigt817XVq1bscEqDYy
	 1HxbrMmEo4xctC7SEyMD45hTgTqPqFXC/tJOqF9c90gvqt+cs+1LLW6y1Li8SknSVE
	 QoE2tS8VIeu7K6Z+EJrTxXtGPVE6AArjv7RqSBYWde89QA21Pqo9zquBJ81Nf1t9fl
	 45e7niWw65Fg3s/gvJwnSr7GTG9j+XmhnQuYGvjkels+cBANGm6iQlZP+lBKBd6KZa
	 gdrZN8G/Bay+A==
Date: Tue, 19 Aug 2025 09:00:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: David Airlie <airlied@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: st: add new compatible to
 LTDC device
Message-ID: <175561205474.128167.15765669735400801632.robh@kernel.org>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>


On Tue, 19 Aug 2025 11:15:54 +0200, Raphael Gallais-Pou wrote:
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> it is incompatible with existing IPs.
> 
> Add the new name to the list of compatible string.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 30 ++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


