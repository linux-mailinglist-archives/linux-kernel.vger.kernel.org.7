Return-Path: <linux-kernel+bounces-769819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE64B27410
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471D068709B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198115ECD7;
	Fri, 15 Aug 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8zbGxbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB21547E7;
	Fri, 15 Aug 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217944; cv=none; b=PKYckIu4E7tmU0nDBCPojiC73CfXTxfwTskR/KlSkIF+083IQeXkWBY2H++H1pWdY++bwNJH65F56Yrrj+atYTlxRXSixuxo2IjDuX/EzLzKVuvjQEM29bGgqQfPdk6PO1nqu17A2w4ygZZyQ4eQKZVXEiMIVkfGyj4MJPPuz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217944; c=relaxed/simple;
	bh=137LREHYlf3O0nOm9QpaXT3ohL/dKVWc4fbvyJZAR2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW0jKVYq66lXDmYZ6aYwW2Bkht17BUf0c0QadW97urwjKEG7pcqAgtCBBWkkRKG3WhIHB8tIImJbW6FykGjrrn5QzZOOiwdom1GTJwMFqZI5h1za0cv3awWt5588M5RT0SvLpGu81kabnMsLYrPJ2YRRvcOM5cZo1N92oai8QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8zbGxbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA15EC4CEED;
	Fri, 15 Aug 2025 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755217944;
	bh=137LREHYlf3O0nOm9QpaXT3ohL/dKVWc4fbvyJZAR2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8zbGxbIa1IvVDqW2E6Y08jD3EhIjoEBs0kLOAGBQ5AJpdUDpaxkM6AEgMCp/I+Rf
	 pEu+stkbCruZaRbD17WbvwEU0o6QhiqF1ulkBpFCULNoN+IV0JxslqN6vwxke2wUFr
	 DLs+vdzvTX1clE7UKCHHow8ajxCA78I1gCpHyDYwZmFs03f7m/M0hGNF0/D+beByiz
	 z8u8dsoqiJ8u7eXTxPrbUjy86s/O58Atwp0NmYwfrwhN92pOGUMF2Tn5nHvFqKgFZf
	 zIE+NetzGOfBPVNCv6onQFw9vgyOn9Pb1S+wgVclhGBDg9A0RXfhjYx6tdm25/3bNY
	 JI0SiQ38DytNQ==
Date: Thu, 14 Aug 2025 17:32:22 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: thead: support changing DPU pixel clock rate
Message-ID: <aJ6AFttcM+jUHHQy@x1>
References: <20250813072702.2176993-1-uwu@icenowy.me>
 <20250813072702.2176993-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813072702.2176993-3-uwu@icenowy.me>

On Wed, Aug 13, 2025 at 03:27:01PM +0800, Icenowy Zheng wrote:
> The DPU pixel clock rate corresponds to the required dot clock of the
> display mode, so it needs to be tweakable.
> 
> Add support to change it, by adding generic divider setting code,
> arming the code to the dpu0/dpu1 clocks, and setting the pixel clock
> connected to the DPU (after a gate) to CLK_SET_RATE_PARENT to propagate
> it to the dividers.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> Changes in v2:
> - Dropped round_rate() because of deprecation.
> - Changed the logic of determine_rate() to early return if the divider
>   could be changed.
> 
>  drivers/clk/thead/clk-th1520-ap.c | 64 ++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 0b5458af8c550..b220a8ed22607 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -55,6 +55,7 @@ struct ccu_gate {
>  
>  struct ccu_div {
>  	u32			enable;
> +	u32			div_en;
>  	struct ccu_div_internal	div;
>  	struct ccu_internal	mux;
>  	struct ccu_common	common;
> @@ -198,6 +199,56 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  	return rate;
>  }
>  
> +static int ccu_div_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct ccu_div *cd = hw_to_ccu_div(hw);
> +	unsigned int val;
> +
> +	if (cd->div_en)
> +		return divider_determine_rate(hw, req, NULL,
> +					      cd->div.width, cd->div.flags);
> +
> +	regmap_read(cd->common.map, cd->common.cfg0, &val);
> +	val = val >> cd->div.shift;
> +	val &= GENMASK(cd->div.width - 1, 0);
> +	return divider_ro_determine_rate(hw, req, NULL, cd->div.width,
> +					 cd->div.flags, val);
> +}
> +
> +static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)

This should line up with open parenthesis. Other than that nit:

Reviewed-by: Drew Fustini <fustini@kernel.org>

If no other issues arise on this series, then I can just fix it up when
applying.

Thanks,
Drew

