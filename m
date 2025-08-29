Return-Path: <linux-kernel+bounces-791224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C944B3B3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D40AA00565
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5825F7BF;
	Fri, 29 Aug 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYKrrjM9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C291553A3;
	Fri, 29 Aug 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450124; cv=none; b=WteJOaHKXrHOVvqxLPwMWFFaxepnJLhXhwLLyqX4Ihj4wLXycVSXaHgZjJxbIN7CXVRJksANfBGQFSiXEbtR8Gje0FVk+TKRmVmzWtBIZ47bUKUuNMu24zmnElcFm8EOimOyoEAbniVeWGxoiiYUYle27MxPRf81273WcoLuLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450124; c=relaxed/simple;
	bh=J0rKrdxOhHWwS+mtwdjmhTwdm1+u+noFAQcTkYElpqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um5MVBG/6RiS4Zf0EqMQudzC42sopyz4zvKkb05ptNLPbPJNArACkneAyf0BwoQ+f2MbocLcE2Dv2DCYVGFZEdCj3im2Uxx643ZX4XG/akbOFB4LrEqkSiJ3ltjl5+WtwL/Sfx14w94Xqy0Id+RTjkOiQnxkJS73bE8u/pSR2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYKrrjM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D00C4CEF0;
	Fri, 29 Aug 2025 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756450123;
	bh=J0rKrdxOhHWwS+mtwdjmhTwdm1+u+noFAQcTkYElpqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYKrrjM92oN1VUFRgvdGGp9Hu4bdSz74SMy/6aaX+JLVjwIjJG/EWB9yKZQhT+epD
	 rejPLq+1EPDIEPj9rPyYcq8uQBKHiKNuMXkgEY51lBcF7pQ0mpOdQP9gI/Ip5miQYX
	 5Yn2YQuyrHu3HousmJeHdXt5/BwZf2jd/Y90WeTO48FJWFB/lGj6oFKU7qqyhbUWS2
	 vk4THj86pu0EvVDvOijBv6JjxM+QcNsbh8XTLm+ZXX9kFS82d1Mx4WtXwQWLYAQ3Fd
	 MyYvEhh5PtNnRkoHuFxXph3MLihdStZDNWZt0hFaMdW1XmPKsuUXrQAhCuaZu7ovUz
	 d4W4OMzG3ZRtA==
Date: Fri, 29 Aug 2025 08:48:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Chen <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 03/19] dt-bindings: display: mediatek: add EXDMA yaml
 for MT8196
Message-ID: <20250829-industrious-economic-jacamar-ce264d@kuoka>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
 <20250828080855.3502514-4-paul-pl.chen@mediatek.com>
 <20250829-solemn-herring-of-conversion-ec5b1a@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829-solemn-herring-of-conversion-ec5b1a@kuoka>

On Fri, Aug 29, 2025 at 08:35:23AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Aug 28, 2025 at 04:06:58PM +0800, Paul Chen wrote:
> > From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> > 
> > Add mediatek,exdma.yaml to support EXDMA for MT8196.
> > The MediaTek display overlap extended DMA engine, namely
> > OVL_EXDMA or EXDMA, primarily functions as a DMA engine
> > for reading data from DRAM with various DRAM footprints
> > and data formats.
> > 
> > Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
> > ---
> >  .../bindings/dma/mediatek,exdma.yaml          | 68 +++++++++++++++++++
> 
> 
> Your changelog says NOTHING changed here and this fails tests, so does it
> mean you received that warnings before but you keep sending same broken
> code?
> 
> Last two weeks of contributions from mediatek are absolutely terrible.
> Very poor code, basic in-house reviews not done, basic testing not done.
> 
> I talked about this at OSSE 25 with some friends and got reasons why
> your setup is broken. Well, it's on you.
> 
> I was already raising this with Mediatek, but we are now back to square
> one.
> 
> NAK, because this patch WAS NEVER tested.


And now I found you got EXACTLY the same error at v3, so you just never
tested and ignored OUR test reports.

This is unfortunately an example how you waste reviewers' time.

Best regards,
Krzysztof


