Return-Path: <linux-kernel+bounces-876490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99EC1BCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7544F588AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E32E8DE3;
	Wed, 29 Oct 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dXiPVvjG"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F642C11E2;
	Wed, 29 Oct 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750866; cv=none; b=GwWHd2iJro8AFpHadvm9Q+0Fd3JEoT+kUEaokY308L1CQ3oK6IVYOk1gTHWyeTCeICVvep2tlcq6Lp2/eN5JuR4Rophqd+xv3xZUrOqK5sz+rxbDmiMyI+faN0AS2PhIMwghkVUs6iWEfXTGhQ1l4XZQiJChfme7OTJOMIHzz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750866; c=relaxed/simple;
	bh=Un1263Y3t/Nka3u0iyTUOo72BpVIJVxFmdi8tdLbhK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6m8FneTE91nf7kB8trZVPobqp2jwUHb3UA8Fm2SHUMsj9VjLzHtl/EKJ604W7AtvZhA63FwZ/icXBeGHabnHm1eIrRfgE76jEf0m75T1R9dzcNYOT1dIcrCOOajlIQN2TxKa01565mxGgdcY73HkASMcR8bpN+mD20E5uQPad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dXiPVvjG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2726D25746;
	Wed, 29 Oct 2025 16:14:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8G9h0oREbF2K; Wed, 29 Oct 2025 16:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761750854; bh=Un1263Y3t/Nka3u0iyTUOo72BpVIJVxFmdi8tdLbhK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXiPVvjG4PegWw59QZbcyAN4cY6mmMlz60Ip2wVjreAYmKclVc1RyCIJb5+6vG7tL
	 o2dysstrnuIRKHOhSFr7yQDsJ44TlLI7GXJpF4nz5PgdAo4SDKRVWwD1WK+ud+AHhz
	 O9sPOnKqe3xEiyyHh7ls+AJPdhSpeX5wjLf3SgQYYiEo3MZDpG4I01rKjvkTi7Bey1
	 Yi3NxDzRpr2YwcdfmmwMADUgMNu3Y2F7bxuHrRKSZ/HPUkZyj2EKvZRo7hfK7Mzqva
	 MEbMHhbMJsRhJljA99pCaPv5JOzXPOlUXB9CqXYCot0e5Y8lWJS+qlPLco4X72B86d
	 yiedeL0ygHJdA==
Date: Wed, 29 Oct 2025 15:13:46 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
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
Message-ID: <aQIvH4jbj9Ifd7Av@pie>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-4-ziyao@disroot.org>
 <aQIOgbUf2IHoWCf2@gen8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIOgbUf2IHoWCf2@gen8>

On Wed, Oct 29, 2025 at 12:54:25PM +0000, Drew Fustini wrote:
> On Tue, Oct 14, 2025 at 01:10:30PM +0000, Yao Zi wrote:
> > TH1520 SoC is divided into several subsystems, shipping distinct reset
> > controllers with similar control logic. Let's make reset signal mapping
> > a data structure specific to one compatible to prepare for introduction
> > of more reset controllers in the future.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/reset/reset-th1520.c | 42 +++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> > index 14d964a9c6b6..2b65a95ed021 100644
> > --- a/drivers/reset/reset-th1520.c
> > +++ b/drivers/reset/reset-th1520.c
> [snip]
> > @@ -138,22 +147,31 @@ static int th1520_reset_probe(struct platform_device *pdev)
> >  	if (IS_ERR(priv->map))
> >  		return PTR_ERR(priv->map);
> >  
> > -	/* Initialize GPU resets to asserted state */
> > -	ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
> > -				 TH1520_GPU_RST_CFG_MASK, 0);
> > -	if (ret)
> > -		return ret;
> > +	if (of_device_is_compatible(dev->of_node, "thead,th1520-reset")) {
> 
> Is there a reason that there is a now a conditional check for the
> compatible here?

Yes, this regmap operation is for initializing GPU resets and thus
modifies TH1520_GPU_RST_CFG, which only applies for the VO reset
controller (with compatible "thead,th1520-reset") but not others, or
other unrelated resets could be unexpectedly asserted.

> Thanks,
> Drew

Regards,
Yao Zi

