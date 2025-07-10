Return-Path: <linux-kernel+bounces-726476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6557B00D75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C913567644
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8C2FD88B;
	Thu, 10 Jul 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw0Po9jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BB288C0A;
	Thu, 10 Jul 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181208; cv=none; b=LoFwcXZ+eF5T34wAlNop2Wek3hgZDzMuLHcdPB8x2kRzFKxA8JbmPcHMAay3R7CupbEF8VnSmCCQjYDhXooMhyhxMT8eZNHyWjqEYVSBMwXonwGdrU28BF6jZfA8BA2lojA9Ys3cE5TNLZ2Ogoi5a+n+N/sJ/uLEDDKu8lsEH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181208; c=relaxed/simple;
	bh=MewW7/+o8jjvZCCPAiXzkcATxmHODd29D85iDo4C6/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esHzv+/lYcMIJkW9ET0JP/UHCGR+bHEBcXABLYMIY7cV/keqFMojHQLUq5Fdo7pq/oqqdRvYRKJ7OdJ4mXTRa+YnM2J1gYGDlBUoEVL4zfMycn3ygvtfcoc67lRlZg7mSmIja8eGSa3cVLayMJ21CK1N6myHTE9yR62rkvwu0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw0Po9jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4CC4CEE3;
	Thu, 10 Jul 2025 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752181208;
	bh=MewW7/+o8jjvZCCPAiXzkcATxmHODd29D85iDo4C6/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cw0Po9jzlMUjPqWpMGa3JmmBs8qRn4ccQxsczXqp7qgR6aRRsHF+DE2bSDEwQQBP4
	 I0b0G/fSn3B7wsgm9pMdPjLO/IZc1SbO2D81ch1852sxjhGtQuUK5/+8r9JvFllG0s
	 Z7OYhhl15781l/ITp0MO26j7ZK6Sc7q5bmjdkQPM6yegffImghltyi/rJg/57P542s
	 ABRuHxHyoWse9e/GL2hh4AjgDy0mxvD0NAd2MBekD8PfWFupXjR7Z4NRsGWVh9uGL6
	 QxY+PWYQXib4cQNtLPsI24Hdwb1dkhsXRIZaZcmb3x67rQLmcG8v8erktQz/1oP3vs
	 baVNbw2mfKzrw==
Date: Thu, 10 Jul 2025 14:00:06 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: thead: th1520-ap: Correctly refer the parent
 of osc_12m
Message-ID: <aHAp1q9tLy465gnO@x1>
References: <20250710092135.61049-1-ziyao@disroot.org>
 <20250710092135.61049-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710092135.61049-2-ziyao@disroot.org>

On Thu, Jul 10, 2025 at 09:21:34AM +0000, Yao Zi wrote:
> The "osc_12m" fixed factor clock refers the external oscillator by
> setting clk_parent_data.fw_name to osc_24m, which is obviously wrong
> since no clock-names property is allowed for compatible
> thead,th1520-clk-ap.
> 
> Refer the oscillator as parent by index instead.
> 
> Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index ebfb1d59401d..42feb4bb6329 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -582,7 +582,14 @@ static const struct clk_parent_data peri2sys_apb_pclk_pd[] = {
>  	{ .hw = &peri2sys_apb_pclk.common.hw }
>  };
>  
> -static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc_12m", "osc_24m", 2, 1, 0);
> +static struct clk_fixed_factor osc12m_clk = {
> +	.div		= 2,
> +	.mult		= 1,
> +	.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc_12m",
> +						   osc_24m_clk,
> +						   &clk_fixed_factor_ops,
> +						   0),
> +};
>  
>  static const char * const out_parents[] = { "osc_24m", "osc_12m" };
>  
> -- 
> 2.50.0

Reviewed-by: Drew Fustini <fustini@kernel.org>

Thanks for fixing this. osc_12m now appears under osc_24m in
clk_summary.

Drew

