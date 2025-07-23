Return-Path: <linux-kernel+bounces-742106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC7B0ED40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FC01C82E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095A12797B1;
	Wed, 23 Jul 2025 08:32:23 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D417B50F;
	Wed, 23 Jul 2025 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259542; cv=none; b=ZT5n0ARrIoM/heV53sOzuecHF22qyYzauXxSaxB3VIg2oKw8aJBtHDCcIi+ISmoLzfhDtGArNIPDPUjvmaaHITIqyqFfTGji74oRl0fDR802EkDwlLd2nvFz1lr0ByowIMo7mphH9hTTvquE5W/w+VhL0+XzdJd4dxfqLA/6x6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259542; c=relaxed/simple;
	bh=NGX/Za1eE2sxLgY4fg3e0t9tLET9CgIcMUf/lAtkPdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsjSKfPenG9vKYFrPdWX9UL8dgdirpeVrIEfzrwGCc+FVhGpGWfoT8tgFyuzBM15h99EIPIsKcVBiyDPaIpNICulMoziqcJC8tD08KoSNPW1wZ7LV03elWPkIOqJbyPlkrB46v79mdXAMVwemmeflWyWkpOHzuZy+H/d7JOvOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id A14371C025E;
	Wed, 23 Jul 2025 10:32:16 +0200 (CEST)
X-Spam-Level: 
Date: Wed, 23 Jul 2025 10:32:11 +0200
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/15] drm: sprd: add clock gating support
Message-ID: <aICeC5lSSW0qR7oh@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-10-054276ec213d@abscue.de>
 <20250723-resourceful-intrepid-beaver-cbeada@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723-resourceful-intrepid-beaver-cbeada@houat>

Hi Maxime,

On Wed, Jul 23, 2025 at 09:00:28AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Jul 22, 2025 at 04:41:12PM +0200, Otto Pflüger wrote:
> > Enable the DPU and DSI clocks specified in the device tree.
> > Disable the DSI clock when it is not needed.
> > 
> > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> > ---
> >  drivers/gpu/drm/sprd/sprd_dpu.c | 7 +++++++
> >  drivers/gpu/drm/sprd/sprd_dpu.h | 1 +
> >  drivers/gpu/drm/sprd/sprd_dsi.c | 9 +++++++++
> >  drivers/gpu/drm/sprd/sprd_dsi.h | 4 +++-
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> > index 0d9eb778794d92418b39f8535d94abde3566de43..9d274600e6a80bdfc435f6c6eff77c9dd71cb38c 100644
> > --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> > +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2020 Unisoc Inc.
> >   */
> >  
> > +#include <linux/clk.h>
> >  #include <linux/component.h>
> >  #include <linux/delay.h>
> >  #include <linux/dma-buf.h>
> > @@ -794,6 +795,12 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
> >  	if (ctx->irq < 0)
> >  		return ctx->irq;
> >  
> > +	ctx->clk = devm_clk_get_optional_enabled(dev, "core");
> > +	if (IS_ERR(ctx->clk)) {
> > +		dev_err(dev, "failed to get DPU core clock\n");
> > +		return PTR_ERR(ctx->clk);
> > +	}
> > +
> >  	/* disable and clear interrupts before register dpu IRQ. */
> >  	writel(0x00, ctx->base + REG_DPU_INT_EN);
> >  	writel(0xff, ctx->base + REG_DPU_INT_CLR);
> > diff --git a/drivers/gpu/drm/sprd/sprd_dpu.h b/drivers/gpu/drm/sprd/sprd_dpu.h
> > index 157a78f24dc18b071602552ea9d005af66525263..d48b922de580a8a4bf07c4610c431d3321f7b810 100644
> > --- a/drivers/gpu/drm/sprd/sprd_dpu.h
> > +++ b/drivers/gpu/drm/sprd/sprd_dpu.h
> > @@ -44,6 +44,7 @@ enum {
> >   */
> >  struct dpu_context {
> >  	void __iomem *base;
> > +	struct clk *clk;
> >  	int irq;
> >  	u8 if_type;
> >  	struct videomode vm;
> > diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
> > index e01d1d28fe579644ec2e0c83ec9170269932adfe..2af4273a6c73185084290c9d14b8ac18914d514b 100644
> > --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> > +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> > @@ -828,6 +828,8 @@ static void sprd_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> >  	struct sprd_dsi *dsi = bridge_to_dsi(bridge);
> >  	struct dsi_context *ctx = &dsi->ctx;
> >  
> > +	clk_prepare_enable(ctx->clk);
> > +
> >  	if (ctx->enabled) {
> >  		drm_warn(dsi->drm, "dsi is initialized\n");
> >  		return;
> > @@ -875,6 +877,8 @@ static void sprd_dsi_bridge_post_disable(struct drm_bridge *bridge)
> >  	sprd_dphy_fini(ctx);
> >  	sprd_dsi_fini(ctx);
> >  
> > +	clk_disable_unprepare(ctx->clk);
> > +
> >  	ctx->enabled = false;
> >  }
> 
> I'm a bit confused. Why do you need to enable / disable that clock in
> pre_enable / post_disable, if you already enabled it at probe?

These are two different clocks. DPU uses devm_clk_get_optional_enabled,
while DSI uses devm_clk_get_optional and enables/disables it when
needed. Ideally both clocks should be disabled when not needed, but this
will be implemented later.

Best regards,
Otto Pflüger

