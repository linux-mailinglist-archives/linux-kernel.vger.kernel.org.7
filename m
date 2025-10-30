Return-Path: <linux-kernel+bounces-878183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C77C1FF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67C3234AFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F082D6605;
	Thu, 30 Oct 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqwvNwZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72F2BD5BF;
	Thu, 30 Oct 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826687; cv=none; b=gWhyCgYApW1XYo/mvErtWZ/43QXj2BlK+GMMYmkfmbhv59/rZe16Xp0g88ZjHTKtUOd9kj5YZME4sFwleXrvbq5l3bFnPjLESIYmpE13Udo8ou2AmTRNUYR39YbkXbHk71piJKv7ozS1379Q4LHo6TL50gaIUskTnfqM3966cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826687; c=relaxed/simple;
	bh=c/5NhRaDMZ/kbf4ALWp9C3bkG4NzH2gCZR2gh2BS+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jljr+d8amLThR7jFEp90n9bCzYdnwq2Mq0cJ9wTp+6ICFiFh5iQqcj+Zn79DUDZjfcGsxRaKP0KfKceQoMD31Hc75WGW8nCHQKaiB+O/mc0Z3+nFakfEE/nBNpAZ8GffU7WyAXd9jIVU63i5H3qdaypcBfUL1Dhj+D7egqBj/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqwvNwZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDE6C4CEF1;
	Thu, 30 Oct 2025 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761826686;
	bh=c/5NhRaDMZ/kbf4ALWp9C3bkG4NzH2gCZR2gh2BS+5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqwvNwZ6OXvD0PLLo9oKFlOauS0KB9w85q0SZ3Xda7sQevCZ+PF82wJOLsJwYVa8J
	 1876w8uLPUw/grmthVZBX1OwHBWnWfh/zmDlS2ZyeNUGt17A6GXXqYHgyC01Wg4nP9
	 lyC1pnN2cdKNa069kddROOPKTXz8sdfvgbqsp2K5m5AbGGI5cMnoBqIk7nkTXWGD7B
	 qHg3KdbmcIwJKg+nCcKhbU70mhjWFFaHX+gynoFm2YmmwmXNcwEZLAY7PdGfXh+Brl
	 udhaAHnl3jScbhaAQdPhAsXaix37XODTzGa5lfTJa6icjLK7SVb1kCjZgZhgvxT/XD
	 pzVl8j7N89Y0w==
Date: Thu, 30 Oct 2025 12:17:58 +0000
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, Fu Wei <wefu@redhat.com>
Subject: Re: [PATCH v3 3/5] reset: th1520: Prepare for supporting multiple
 controllers
Message-ID: <aQNXdmH_sA6hgOKC@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-4-ziyao@disroot.org>
 <aQIOgbUf2IHoWCf2@gen8>
 <aQIvH4jbj9Ifd7Av@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIvH4jbj9Ifd7Av@pie>

On Wed, Oct 29, 2025 at 03:13:46PM +0000, Yao Zi wrote:
> On Wed, Oct 29, 2025 at 12:54:25PM +0000, Drew Fustini wrote:
> > On Tue, Oct 14, 2025 at 01:10:30PM +0000, Yao Zi wrote:
> > > TH1520 SoC is divided into several subsystems, shipping distinct reset
> > > controllers with similar control logic. Let's make reset signal mapping
> > > a data structure specific to one compatible to prepare for introduction
> > > of more reset controllers in the future.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  drivers/reset/reset-th1520.c | 42 +++++++++++++++++++++++++-----------
> > >  1 file changed, 30 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> > > index 14d964a9c6b6..2b65a95ed021 100644
> > > --- a/drivers/reset/reset-th1520.c
> > > +++ b/drivers/reset/reset-th1520.c
> > [snip]
> > > @@ -138,22 +147,31 @@ static int th1520_reset_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(priv->map))
> > >  		return PTR_ERR(priv->map);
> > >  
> > > -	/* Initialize GPU resets to asserted state */
> > > -	ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
> > > -				 TH1520_GPU_RST_CFG_MASK, 0);
> > > -	if (ret)
> > > -		return ret;
> > > +	if (of_device_is_compatible(dev->of_node, "thead,th1520-reset")) {
> > 
> > Is there a reason that there is a now a conditional check for the
> > compatible here?
> 
> Yes, this regmap operation is for initializing GPU resets and thus
> modifies TH1520_GPU_RST_CFG, which only applies for the VO reset
> controller (with compatible "thead,th1520-reset") but not others, or
> other unrelated resets could be unexpectedly asserted.

Thanks for the explanation.

Reviewed-by: Drew Fustini <fustini@kernel.org>

