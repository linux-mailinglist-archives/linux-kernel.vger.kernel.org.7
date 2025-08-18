Return-Path: <linux-kernel+bounces-774537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2113B2B3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C026E1896E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630127AC4D;
	Mon, 18 Aug 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dohpnvq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C51E25F2;
	Mon, 18 Aug 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555007; cv=none; b=NcRxD0helI+pJQ2LgQh06dfUIR1nAqMlqLMFNSY+Fr6V1rY7x6I/cEpOFGgbm/gYegU5hGQGqQ8/05reeRJaHULN7iQoZK1bnjDVLtJfMEQC9xV3AYhHvxX8J9zIiQnDnfKtFFkQMTTw6hLef4X8KH5AkDezEO3vmzoBzgoFq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555007; c=relaxed/simple;
	bh=xj3JxOXQyWu37kJaLPQqWy86cPH8xawvdDtVq3Ay34o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq0+aqYbqOeDjLGBPNVJtouEVP3aCzVhAb9kkMiB2l37NvwV+wysmQC+XiFxiFXwZKm1Jz+kS3hYgThFqj01/InZsQxIX+eSqtKQDDGwqm2+GmLRYJ7G3+C97+wQXmjkk28/JobwHdbXW4VAHMLzz8kji8XjeIUmAcVySxy0M5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dohpnvq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5069AC4CEEB;
	Mon, 18 Aug 2025 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755555006;
	bh=xj3JxOXQyWu37kJaLPQqWy86cPH8xawvdDtVq3Ay34o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dohpnvq9ouhIqIN48XC6yPAtnj1Jhn5Bwfz5MrFpEaMb9xpOTAaZ4O4aR4Asqokfb
	 xDjl+y9nGnQanpAMsYRmhcUtJzA1qXd8dZsG/RaoTo6or/Z/6bl+3Tv3rqcADUqZto
	 +783ODkgwviLXxoskf9ZYVIi4moAI/mQskz2IULpdyhd/uQ10y7owTHNbVXAgArmWQ
	 wIK0dPuMXd0ru5tdl691HFVFygW0cQ0E9AHd6M6fYoyYrHzfmd/DyWpOXyPgkxqW+w
	 7/zDXhfnewFwJSrSa25aLYp7/+EpNjxYxBs3eUac+O36cXyPNGNiBzqp+WKe9HRvMQ
	 zY4DsLBvpaXbQ==
Date: Mon, 18 Aug 2025 15:10:04 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: thead: th1520-ap: allow gate cascade and fix
 padctrl0
Message-ID: <aKOkvK2UHxLP0LNA@x1>
References: <20250816084445.2582692-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816084445.2582692-1-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 04:44:43PM +0800, Icenowy Zheng wrote:
> Current ccu_gate implementation does not easily allow gates to be clock
> parents because of the waste of struct clk_hw in struct ccu_gate;
> however it's found that the padctrl0 apb clock gate seems to be
> downstream of perisys-apb4-hclk, gating the latter w/o gating the former
> makes the padctrl0 registers inaccessible too.
> 
> Fix this by refactor ccu_gate code, mimicing what Yao Zi did on
> ccu_mux; and then assign perisys-apb4-hclk as parent of padctrl0 bus
> gate.
> 
> Icenowy Zheng (2):
>   clk: thead: th1520-ap: describe gate clocks with clk_gate
>   clk: thead: th1520-ap: fix parent of padctrl0 clock
> 
>  drivers/clk/thead/clk-th1520-ap.c | 386 +++++++++++++++---------------
>  1 file changed, 189 insertions(+), 197 deletions(-)
> 
> -- 
> 2.50.1

Thank you, I've applied this to thead-clk-for-next [1]:

9e99b992c887 clk: thead: th1520-ap: fix parent of padctrl0 clock
aaa75cbd5d4f clk: thead: th1520-ap: describe gate clocks with clk_gate

-Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=thead-clk-for-next

