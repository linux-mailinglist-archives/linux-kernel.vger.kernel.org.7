Return-Path: <linux-kernel+bounces-764116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C17B21E38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2D19047CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03A2E284E;
	Tue, 12 Aug 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbR/eZ0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BE2E090B;
	Tue, 12 Aug 2025 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979814; cv=none; b=h1qpwP+IynVMkDUIDLLJrhf9qqeCkBlm4R1C6KKLZVtQ2PeG4KV6kJtUjc2nyw14l3vfk2nG1NViNM+zGiF40ASrFctZg4QGNNS1vE39o/vmN6WDJPgP1Vlxn2jd8uYzd6xfLygqf/AkSnwoB8uoNHo/IX/SWbG1GL3rm7SFsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979814; c=relaxed/simple;
	bh=+k1CSGuOSQu6VaDbQe3Z/6qqFzAm2XnBn6VGpEr2LGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA0qMl4yvEJl88jucj5TQnHgBbglOdcZOb7cceBUOe3bGQotvQfRfsSl9HaVvsM4J1ACOpqtVOTwQ0hQil0YWjDeYxdPTM7nIU9UzmwBzkA6RMAjzcIkeDGhOZHKRRnOgtUCXPTokf7bm0k1wKuGH28poIb3IWunvY3Zg0qii/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbR/eZ0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075A0C4CEF9;
	Tue, 12 Aug 2025 06:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754979814;
	bh=+k1CSGuOSQu6VaDbQe3Z/6qqFzAm2XnBn6VGpEr2LGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbR/eZ0+RhRtHn0wn4PERYKfBeN0hr5I6DGe7Q9aXpRR6LF9/Uuu15H6A1PG7YNEH
	 LrZnYys28OD/oGh0vXAD7vjr5AbxcYD2jlswFbFWUeH2Jatvunt3Rk2UTJAyPpIrt+
	 a1WhzZ/DU2rZ4kSa02BJXh3FnBYXX7aRLhyylpFpdj7HqXT6z5xckESqxur8qgpDdV
	 ONFLjHTe/Oan6a39MJkc7Q9LUP9vUtck2qkNGQMoGGvyK/DsnYIATWASWqFtJ83rx4
	 j0uyg9pkYVB2lB2pJb9ioa3Ules/l6OEZ2Cp7j+o3FuaJ6rWkBvzwtU5pfaS5uxysl
	 Te2p0G24SbSrg==
Date: Mon, 11 Aug 2025 23:23:32 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: thead: th1520-ap: set all AXI clocks to
 CLK_IS_CRITICAL
Message-ID: <aJrd5EaI9pdSvD5/@x1>
References: <20250812054258.1968351-1-uwu@icenowy.me>
 <20250812054258.1968351-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812054258.1968351-4-uwu@icenowy.me>

On Tue, Aug 12, 2025 at 01:42:57PM +0800, Icenowy Zheng wrote:
> The AXI crossbar of TH1520 has no proper timeout handling, which means
> gating AXI clocks can easily lead to bus timeout and thus system hang.
> 
> Set all AXI clock gates to CLK_IS_CRITICAL. All these clock gates are
> ungated by default on system reset.
> 
> In addition, convert all current CLK_IGNORE_UNUSED usage to
> CLK_IS_CRITICAL to prevent unwanted clock gating.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 42 ++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 20 deletions(-)

Thanks for working on the display controller. I'll review the series but
I wanted to point out a simple error first:

>  static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
>  static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), 0);
> +static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), CLK_IS_CRITICAL);
> +static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), CLK_IS_CRITICAL);

The compiler complains about redefinition of npu_axi_clk and cpu2vp_clk.
I've fixed it up by removing the old lines with '0' flags, but I'm
noting in case there is another revision.

Thanks,
Drew

