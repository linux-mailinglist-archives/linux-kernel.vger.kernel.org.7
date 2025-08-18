Return-Path: <linux-kernel+bounces-774538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EEB2B3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4904E1E58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02DF27C866;
	Mon, 18 Aug 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQhSfeWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DE27BF93;
	Mon, 18 Aug 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555010; cv=none; b=WpIMAHHGpDUmslHrVtw2vMyhPcXpLxmKgYR1+RNMetmX8dIj6Q0hXX4mQVezXkGJM9JjYVUWwoi3NjzW/S3B//79QEuFpMo5Vdo409QWVSVPP1Hemz2FQUWzCwaTHTHdhpqkNI9WBvOLbdsbpkToL1VuCp5+gaROJS9ExCLf4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555010; c=relaxed/simple;
	bh=Bnndge+CdaMWA2w0cdjnSJFewFl8QufFzBkVOdHPlqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouIWIa84SypmXo7h6rE90qHNurOkUd9/CFdf8SrEg1jODq/AZhdKhqyVUCz4awE0Q4ynG++mK5YVnzWBkI1iWlYlF83oUM9NBgVJiM3NOih4MG/c7heyEZMYFrmLzW2b/tcd1bek6lOfPWi+6dhhPEYHomAzystLR4RC9D1aQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQhSfeWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F0C116C6;
	Mon, 18 Aug 2025 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755555009;
	bh=Bnndge+CdaMWA2w0cdjnSJFewFl8QufFzBkVOdHPlqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQhSfeWvke9+s1pOY6ybbkJqgIdSS7Pg3jgxD7sShQx7c0lnHcfCkk/vHRX8ctRS6
	 Gy3XtPf0fGGIj25RMVs1WulRbJ6pE2j85ZMHSY3oJ4fGmynzgDhiVp/okuLzaM7rvY
	 KQOxD+WyPvoWf3KcOhO6rt489BEDN6CrTXdGzKO3QMcsTyn6D7Zb2gko7oTsnDrK+E
	 m16Xy8sKq9+hoREFKdU72en8FbRfL/MtgDoRdgO6/mIE40v3botYmwu9OWyCrWPKvi
	 7jJj4FYhETw/h59fA2eCrG4UeD48ToQkl6TMZ1QdvVpN3lw9BjZRoe1NW8Bteh1fvF
	 3dv4yUEOO6JSw==
Date: Mon, 18 Aug 2025 15:10:08 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: thead: Changes to TH1520 clock driver for
 disp
Message-ID: <aKOkwIqKi1QqSo8K@x1>
References: <20250816091113.2596048-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816091113.2596048-1-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 05:11:09PM +0800, Icenowy Zheng wrote:
> This patchset is my changes to the TH1520 clock driver, mainly for
> supporting the display controller.
> 
> The first patch is previously a dependency of this patchset before v3,
> but a rebase operation in v3 changed it and it's now pulled into this
> patchset.
> 
> The 2nd and 3rd ones are functionality additions, with the first one
> adding support for enabling/disabling PLLs (for DPU PLL) and the second
> one adding support for changing DPU dividers.
> 
> The 4th one is to address hang issues met when testing the DPU driver
> w/o clk_ignore_unused command line option.
> 
> The patchset is rebased atop the padctrl0 parent fix patchset (which
> contains refactor of ccu_gate) at [1] in v3.
> 
> [1] https://lore.kernel.org/linux-riscv/20250816084445.2582692-1-uwu@icenowy.me/
> 
> Icenowy Zheng (3):
>   clk: thead: add support for enabling/disabling PLLs
>   clk: thead: support changing DPU pixel clock rate
>   clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL
> 
> Michal Wilczynski (1):
>   clk: thead: Correct parent for DPU pixel clocks
> 
>  drivers/clk/thead/clk-th1520-ap.c | 153 +++++++++++++++++++++++-------
>  1 file changed, 121 insertions(+), 32 deletions(-)
> 
> -- 
> 2.50.1
> 

Thank you, I've applied this to thead-clk-for-next [1]:

c567bc5fc68c clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL
8fede7ff692c clk: thead: support changing DPU pixel clock rate
56a48c1833aa clk: thead: add support for enabling/disabling PLLs
c51a37ffea38 clk: thead: Correct parent for DPU pixel clocks

-Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=thead-clk-for-next

