Return-Path: <linux-kernel+bounces-727232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DAB016D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9661CA0BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33E1F3FC8;
	Fri, 11 Jul 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaKvlyOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76F18DF6E;
	Fri, 11 Jul 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223937; cv=none; b=c0D6kfLDqH/OKPeS0jN1UeAqTYNcCGdU3c0xf6Sq5afzbZ6v1nmggv7Jw3bBbi4duB3rO1MZT0R9YMKay6T86sor0jSGCsvQlnXsZmGyYfG0y7CrFdhMn2vWA+XDfV6QwOxrih+rJtRwTgf48dvYHlrcuZgiGnHA+k0O0IzmlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223937; c=relaxed/simple;
	bh=aF+JJEZsequpHm+YtISush4RgOCy6i5U0IrNZGWxTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7d6S0JpgnW+5wnE5nQzfUkiTUJt/7+KEOnU7y3OSQnj9OaMxCh9IICUOLkBb1dVu3DCbV8GAbPq6DmTBYUu6s6oTMpfuCq9IQ5Ywv+Ts/5UH05kFvg6OTwPBBLVWsNSwenndLlGB+LgUxZ5E8uKyzWrwXIo9TS+j1JGJqqqCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaKvlyOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF37C4CEED;
	Fri, 11 Jul 2025 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752223936;
	bh=aF+JJEZsequpHm+YtISush4RgOCy6i5U0IrNZGWxTnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaKvlyOglpBFvzsRfEvLY6I3+fF0FHnGZTK5n6yuk/bg8DCaKFBekxMMrxdp5IBGB
	 fwQX53KyGSnL8Ye1cgY5dUhaGx/TaDKOt+HmorActcomy9lGgzbWi9ca8PkFGq/AJX
	 P+2MNI2mkBjXd7kfN8mDExxziQ9uQFxczWf+7VBh6SV2Xk7ASIWtzXh47KLImImvw6
	 /VN7fYVz9RfrY1pUZKApj62nuPOouEdDbcBMfsnaq3TsscHARkaNK6PCtc5tI28zJf
	 Usc4vJEx+6Ci3oB9a95+xnpWzPLB6tERsgOYu9Q1qCyl0NQaQ1uO+tCfroVvmV86dp
	 lvdoXo53URgZA==
Date: Fri, 11 Jul 2025 01:52:15 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: thead: th1520-ap: Correctly refer the parent
 of c910-i0
Message-ID: <aHDQv81WqlYzzpL4@x1>
References: <20250710092135.61049-1-ziyao@disroot.org>
 <20250710092135.61049-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710092135.61049-3-ziyao@disroot.org>

On Thu, Jul 10, 2025 at 09:21:35AM +0000, Yao Zi wrote:
> The correct parent of c910, c910-i0, is registered with
> devm_clk_hw_register_mux_parent_data_table(), which creates a clk_hw
> structure from scratch. But it's assigned as c910's parent by
> referring &c910_i0_clk.common.hw, confusing the CCF since this clk_hw
> structure is never registered.
> 
> Refer c910-i0 by its name instead to avoid turning c910 into an orphan
> clock.
> 
> Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 42feb4bb6329..41ed72b1a915 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -427,7 +427,7 @@ static struct ccu_mux c910_i0_clk = {
>  };
>  
>  static const struct clk_parent_data c910_parents[] = {
> -	{ .hw = &c910_i0_clk.common.hw },
> +	{ .index = -1, .name = "c910-i0" },

Thanks for the patch. Unfortunately, I chatted with Stephen about this
on irc and we need to avoid using strings in clk_parent_data. I'm trying
to see how to correctly assign the pointer in the c910_parents[] after
c910_io_clk has been registered.

Thanks,
Drew

