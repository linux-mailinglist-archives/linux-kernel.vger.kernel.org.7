Return-Path: <linux-kernel+bounces-738357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96CB0B770
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9403C178530
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F08221F0F;
	Sun, 20 Jul 2025 17:35:57 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16173B661;
	Sun, 20 Jul 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032957; cv=none; b=sVJsMGhTyzQ7NGvkhnI2uVLIt7Pfd0JVHoptM2RpGokanz0HtdFMbBlcskebhxxfERi7SsaGremdK7aMLIaMfyCMJZqW3RpTB2/sCccK/SPTxBfZWeWEkOU+u5+TQKSa+y2XfURdngj4PLlLz9E5yBNJLUOwJOUcv2AC9Ny+4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032957; c=relaxed/simple;
	bh=Xl53gsa0NBpvxNdRwVcXtVzlpFZwfVPNNlWbYnyO2kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM59BSy301pONHc4uZo7P7yzBNGs49IPo0QPhu/IubyNVWX6OrscLqYh+dv0wc1gfrxsyI2B+eS1XbnFUtHe+jRn/F0jtGTKulQsee/GddGnIKsikc82C9KyCDmCm6w8voSGW3TvaLzejx1+30qzIRxxbDdq+xmtyCsDlu+Au24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id D3BE11C025E;
	Sun, 20 Jul 2025 19:35:51 +0200 (CEST)
X-Spam-Level: 
Date: Sun, 20 Jul 2025 19:35:24 +0200
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kevin Tang <kevin.tang@unisoc.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: display: sprd: adapt for UMS9230
 support
Message-ID: <aH0o3HlyPci3-7DK@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
 <9966b9e4-399b-4446-81e4-15daf9acbff7@kernel.org>
 <aHz1Z94swDewvriQ@abscue.de>
 <40fd4502-71d5-435e-83f2-2df933c0467b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fd4502-71d5-435e-83f2-2df933c0467b@kernel.org>

On Sun, Jul 20, 2025 at 05:38:02PM +0200, Krzysztof Kozlowski wrote:
> > 
> > The clocks should be the same on sharkl3 (sc9863a) and ums9230, but
> > the existing bindings don't really make sense here or are incomplete.
> > AFAIK there is no SoC in which this display controller is directly
> > connected to the PLL as shown in the example. The DSI controller is
> 
> This is not the PLL. Gate either. You are looking from wrong side - how
> clock is generated.
> 
> You describe here CLOCK INPUT.
> 
> > connected to a clock gate. The DPU actually does have two clocks, both
> > of which are clock muxes that allow selecting different frequencies and
> > one of which is behind a clock gate. I can add the second clock for the
> > DPU if needed.
> > 
> > Since nothing seems to be using these bindings at the moment, would it
> > be okay to drop the old clock names that refer to specific frequencies?
> 
> It is still completely irrelevant whether these are muxes. Dropping
> existing properties is ABI change, but anyway first figure out what is
> here really.

I was trying to point out that the existing clock names are incorrect
because they refer to a specific source that is not necessarily used
for these clocks, instead of giving a name for the clock input.

For the DPU, would "core" and "dpi" be more appropriate as clock names?
DPI refers to the interface used internally between the DPU and the DSI
controller.

For the DSI controller, it seems that the clock is actually an APB bus
clock needed for accessing the control registers. Again, it is not
required to be connected to a 96MHz clock source as the name used in the
binding suggests. Would something like "apb_clk" or "pclk" be more
descriptive?

