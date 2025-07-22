Return-Path: <linux-kernel+bounces-740315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA7B0D2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6B3A517B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C52C3242;
	Tue, 22 Jul 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQRGtc2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5AF2C3254;
	Tue, 22 Jul 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168776; cv=none; b=ZnmofboPlnswhtxc4mSlK4wXELcCkbVe94/HnyR/Fu5sk0bGuUPtuUC2rNlc02nW+76DU//VIeRZBAhRrF6DPWWuXS8GNgs2Qnwc78WMAV37BFWyhkVtQ+R7pBjx1VRzE2NMg6LU4cJHeD+j+AS3SKb9rX//rgKbGdYSH4CzT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168776; c=relaxed/simple;
	bh=6AgzjhBZxA3wEqcXfXHf90mqgnB60GOi2YIsHje5XqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxhgXS/r524nnMM9wstATg9xORlPzWaT1sW+gSyA3lOlXBar2jRWGCTbqHycs3WBTrWbM9vp6YX0QyaO7C1M62A02g6nyclqrZHTichzc/I+IHnT9/lQVSpHjaOACnhvV9IMPymzGbU8k7JUUqffA+u937b2PHvcx7L0YO3SW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQRGtc2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8300C4CEEB;
	Tue, 22 Jul 2025 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753168776;
	bh=6AgzjhBZxA3wEqcXfXHf90mqgnB60GOi2YIsHje5XqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQRGtc2A+jcXZ+jiKUu3KUdQL2TgUEQKNuEmGtlIGvKGw1rmPkiNMcCTvewcahhHN
	 tJk2rRkVl+Zz1j4PdYX2PAvkl5oysQ/nkCKOXxFU1pom7zUp+zCa50T9aycvTO6R+z
	 fDzsYdpwBB70PQaqXsFoWjDqppVQNDFPeb6Uvop3PhG5cB49SJEF/1ibkCXCQ4ryw/
	 EIVEQQXcvV4XYtvmX8Chxhy/g3eZoB36XPzLKt2+DLd+eYr3I1O35dyACfZhcPvf8m
	 AVatrVdWRZXoLef4eIcCcUFKGpO4qpNl37IeU6iZHdkiljZ6InRW9zvRyJUt7yei0t
	 aaS/gaELh+S9w==
Date: Tue, 22 Jul 2025 09:19:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: display: sprd: adapt for UMS9230
 support
Message-ID: <20250722-imported-origami-cat-dbfaad@kuoka>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
 <9966b9e4-399b-4446-81e4-15daf9acbff7@kernel.org>
 <aHz1Z94swDewvriQ@abscue.de>
 <40fd4502-71d5-435e-83f2-2df933c0467b@kernel.org>
 <aH0o3HlyPci3-7DK@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aH0o3HlyPci3-7DK@abscue.de>

On Sun, Jul 20, 2025 at 07:35:24PM +0200, Otto Pfl=C3=BCger wrote:
> On Sun, Jul 20, 2025 at 05:38:02PM +0200, Krzysztof Kozlowski wrote:
> > >=20
> > > The clocks should be the same on sharkl3 (sc9863a) and ums9230, but
> > > the existing bindings don't really make sense here or are incomplete.
> > > AFAIK there is no SoC in which this display controller is directly
> > > connected to the PLL as shown in the example. The DSI controller is
> >=20
> > This is not the PLL. Gate either. You are looking from wrong side - how
> > clock is generated.
> >=20
> > You describe here CLOCK INPUT.
> >=20
> > > connected to a clock gate. The DPU actually does have two clocks, both
> > > of which are clock muxes that allow selecting different frequencies a=
nd
> > > one of which is behind a clock gate. I can add the second clock for t=
he
> > > DPU if needed.
> > >=20
> > > Since nothing seems to be using these bindings at the moment, would it
> > > be okay to drop the old clock names that refer to specific frequencie=
s?
> >=20
> > It is still completely irrelevant whether these are muxes. Dropping
> > existing properties is ABI change, but anyway first figure out what is
> > here really.
>=20
> I was trying to point out that the existing clock names are incorrect
> because they refer to a specific source that is not necessarily used
> for these clocks, instead of giving a name for the clock input.

OK, if the old name refers to the same clock input as in your new
device, you can deprecate old case in the binding.

>=20
> For the DPU, would "core" and "dpi" be more appropriate as clock names?
> DPI refers to the interface used internally between the DPU and the DSI
> controller.

Sounds fine.

>=20
> For the DSI controller, it seems that the clock is actually an APB bus
> clock needed for accessing the control registers. Again, it is not
> required to be connected to a 96MHz clock source as the name used in the
> binding suggests. Would something like "apb_clk" or "pclk" be more
> descriptive?

Yeah, both are correct. I think pclk is preferred.

Best regards,
Krzysztof


