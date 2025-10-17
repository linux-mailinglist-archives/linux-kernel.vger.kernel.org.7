Return-Path: <linux-kernel+bounces-858015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12337BE892C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC9F84EDAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2941312830;
	Fri, 17 Oct 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="k8GMJlor"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F1332EB4;
	Fri, 17 Oct 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703753; cv=pass; b=g4AOBLSEMgoaRnoFE0dWyGoRF9H16/OIkwtxkIOVz5Ons5LhBGfo4THP3CCwtR7AEGRMkUiStif0yDaWoUGj/axfAv+l1bkJH6AbpFeAHyFOry7dlOxI3ezKzdEHKdBCRENVd5aieXfEETxSmrSkO0FrSdE8BY0etWDSVU/zuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703753; c=relaxed/simple;
	bh=DD3xeD3NOA9LRX1XaV2kCPPZjXulQHRLiDrKsQfSY+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQopvzW67iIbuLmeyx5+5PRUVxgKIOAdBFwkslJSz9En/hYiKTnZKNBZdQq3mLTKYlG45jSqS1J51xLWWGa7ln7T16dibnBRXP+bbYjK9C6dfRltTpfd2C4J2tDVWu5M97RTmLvsGzmGH7PDGPU66BJMis/i5DbAkPmrN8X73zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=k8GMJlor; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760703723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UMAmICaP0DmVjcDJq0w9peZBvM7IWGqT6pnW/tElYIgtQjckhuM0F0kgxg+7Uy3HIThBhmQ49GYS+aZL+VbQR7/kph9ctT1stl+SlqT5yCJz+W2j8D2pMeNXXehKek03JjLJtP4gDvVaLL4DaAjEbJnqMFagef4FsyVDaLl0Yg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760703723; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tVS1yjlCPcljk4srWv5SXmg1dIE2H/RRXTrB6Ic2heM=; 
	b=j4OoqGZ5DTFOsmf6cr1Emx6wGIfS4Sgu/rFqEX15FgSMns07IsUr6/PYK5okE9PtdtnZSe4jhQC/Vh2acBYC8HZdkTKNUJaHxCzOoU7Lhne2dbHZV5CaZK5oHGa1jP/79gH6XX22jgM/hNlQ8UMyHaD35+aYMIff/5DtiHBAWrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760703723;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=tVS1yjlCPcljk4srWv5SXmg1dIE2H/RRXTrB6Ic2heM=;
	b=k8GMJlorX+Qdqv2XyU6q9law0BrDuTrEXukxDoN9+17ciGI0tmTwpxw53XC4zKDy
	f4bpf3dvF4HiEO26sKZilcsYfau85A9okjutkAfx9MLsVbyBf7kRQygXWmaAF+Ts190
	QltcMvkdhpDf0r9NAsDMwIDXnB7V96zLzZNFUhAo=
Received: by mx.zohomail.com with SMTPS id 1760703720868631.1429498538683;
	Fri, 17 Oct 2025 05:22:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Brian Masney <bmasney@redhat.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
Date: Fri, 17 Oct 2025 14:21:55 +0200
Message-ID: <3342669.irdbgypaU6@workhorse>
In-Reply-To: <aPFbDl_JKyDay1S5@redhat.com>
References:
 <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
 <20251010-mtk-pll-rpm-v3-1-fb1bd15d734a@collabora.com>
 <aPFbDl_JKyDay1S5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 16 October 2025 22:52:30 Central European Summer Time Brian Masney wrote:
> Hi Nicolas,
> 
> On Fri, Oct 10, 2025 at 10:47:09PM +0200, Nicolas Frattaroli wrote:
> > When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
> > operations, such as setting the rate or switching parents. However,
> > another operation that can and often does touch actual hardware state is
> > recalc_rate, which may also be affected by such a dependency.
> > 
> > Add parent enables/disables where the recalc_rate op is called directly.
> > 
> > Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> > Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/clk/clk.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 85d2f2481acf360f0618a4a382fb51250e9c2fc4..1b0f9d567f48e003497afc98df0c0d2ad244eb90 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1921,7 +1921,14 @@ static unsigned long clk_recalc(struct clk_core *core,
> >  	unsigned long rate = parent_rate;
> >  
> >  	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
> > +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +			clk_core_prepare_enable(core->parent);
> > +
> >  		rate = core->ops->recalc_rate(core->hw, parent_rate);
> > +
> > +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +			clk_core_disable_unprepare(core->parent);
> > +
> >  		clk_pm_runtime_put(core);
> >  	}
> >  	return rate;
> 
> clk_change_rate() has the following code:
> 
> 
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_prepare_enable(parent);
> 
> 	...
> 
>         core->rate = clk_recalc(core, best_parent_rate);
> 
> 	...
> 
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_disable_unprepare(parent);
> 
> clk_change_rate() ultimately is called by various clk_set_rate
> functions. Will that be a problem for the double calls to
> clk_core_prepare_enable()?

I don't see how multiple prepares are a problem as long as they're
balanced.

> 
> Fanning this out to the edge further is going to make the code even
> more complicated. What do you think about moving this to
> clk_core_enable_lock()? I know the set_parent operation has a special
> case that would need to be worked around.

__clk_core_init also needs special code in that case, as it calls the
bare recalc_rate op with no clk_core_enable_lock beforehand. It's also
wrong, in that recalc_rate does not necessitate the clock being on as
far as I'm aware. (if it did, this wouldn't be a problem in the first
place, as enabling it would enable the parent as well). Changing the
semantics of clk_recalc, and therefore clk_get_rate, to also enable
the clock, would be a major change in how the common clock framework
functions.

In my case, the __clk_core_init callback was the one that crashed,
so it really needs to happen there, and I really don't want to
refactor every location where `CLK_OPS_PARENT_ENABLE` is used for
a bugfix just to avoid potentially checking the same flag twice.

Having `CLK_OPS_PARENT_ENABLE` cleaned up such that every clk op
that has potential register access is never directly called by the
clk core except for one place, an accessor function that does both
pmdomain and `CLK_OPS_PARENT_ENABLE` checks, would be nice, e.g.
by keeping the clk_recalc change and then having __clk_core_init
call clk_recalc instead of the recalc op directly. But then the
__clk_core_init logic needs further refactoring as well.

I'm not sure I want to do that in this series, because it's quite
a bit different from just adding the missing check and parent
toggling, and has the chance of me introducing subtle logic bugs
in what is supposed to be a bugfix.

> 
> Brian
> 
> 

Kind regards,
Nicolas Frattaroli



