Return-Path: <linux-kernel+bounces-740044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B0B0CEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEC954328A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7E189902;
	Tue, 22 Jul 2025 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="YpjlIG9X";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="et0UNwGo"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B23156677;
	Tue, 22 Jul 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146525; cv=none; b=blngHyfaEd83rx0rb0Bk6vZDKJgk3znHlc/hkfXyu00HOb4U31RxknUE22jRlZq8Ce/r8+VB3qhNwAcXcXHxHkzxxTineSTfr0XBvyZ+abI7g0OXXmxSc390FJH/9OdEcULVAm+cpcqOxVSQOPlnZWBuw0RSJZ1qs8yOo8Ym8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146525; c=relaxed/simple;
	bh=hzdmz95quMdnRHb2ogS+Jsja1esz0IU+CTYKaAqwBy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ3O+bdlnsW3MtA27PrVAnV6wj6nB95daEq8Q8adBOJ0AnlDWnDd1n/WruNHcNpqLpuVM7lkmyIf/ble0WFOvJHrr+lvmsDcmXvBKAxREFeb4NU6y4XDV93CFb9YZI88ULRewMXn3QJRBwP3GKvXU7O4wqIhLDx91OZiW3mWuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=YpjlIG9X; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=et0UNwGo; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id EC46212FB405;
	Mon, 21 Jul 2025 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1753146522; bh=hzdmz95quMdnRHb2ogS+Jsja1esz0IU+CTYKaAqwBy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpjlIG9X0fYRhCy7fPJxukgUtsATP1cL7cp/jkkFfEypXx4DQ0ZUIuEr7k/FFTBlM
	 y1YxXEBBOwpkk9cacvkm8XRybsyHXzkxiwCOcP5YsyS5pXNAq4iJb7zWl7dAB/V3hb
	 WTuytjfzmKPJwLVREVSkEmH2QEDD4hXC+3kzCe07jLdMEM91by8GptsNhMq2nM4V8w
	 lKrXyTK4AAmkZy85a2SSRowJRloY6lar5ASCefHNuwzqT8Wo0xqkMk5SeAYpotbHfl
	 d3+n5fZR8P3wtwvUOWCs7Kk0sJ6OpotRKY0K9k5/K6BuYtL4ErUl/mL/Ib/ArKGVVq
	 2s9t4ThajmKvA==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLCFKPPPdY6W; Mon, 21 Jul 2025 18:08:39 -0700 (PDT)
Received: from ketchup (unknown [117.171.64.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id A2A2A12FB43F;
	Mon, 21 Jul 2025 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1753146519; bh=hzdmz95quMdnRHb2ogS+Jsja1esz0IU+CTYKaAqwBy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et0UNwGoYlgBCdiG4K4MpGoiHLRWz+FgFR125Mrse1zkZk7CFpTTBqiri2ZzY4fpm
	 GQiRwoXFGAR/R0e2usVbi5884N6XQIV5cK1HzIcA1A2qaprVDYD2cnHhY25u8N0NwS
	 sJ+X4Oj29p/U+BnnrffO499qQIZP9oiT1SWd6Oml2++dGNxc75fSshucIfLbZQz+Sd
	 3XbTrSCo1cZmuDl2cE2zL71A6Gy9bi8yFHQ9MilMiIV0IzUzUonJ4HgzufCrLbwF4p
	 qTcRRyFksV57gP5lc98J8nY0ljbWZLIuiAlqnAMQSU99+OieavZypLHDt7dXHOdWAt
	 7lwgYYyFgS8qQ==
Date: Tue, 22 Jul 2025 01:08:30 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, mturquette@baylibre.com,
	sboyd@kernel.org, dlan@gentoo.org, elder@riscstar.com,
	inochiama@outlook.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heylenay@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	unicornxdotw@foxmail.com, jszhang@kernel.org,
	zhangmeng.kevin@linux.spacemit.com, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] clk: spacemit: ccu_pll: fix error return value in
 recalc_rate callback
Message-ID: <aH7kjkC_YSEi7dFz@ketchup>
References: <aH6P3lChCXhi3pe4@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH6P3lChCXhi3pe4@bhairav-test.ee.iitb.ac.in>

On Tue, Jul 22, 2025 at 12:37:10AM +0530, Akhilesh Patil wrote:
> Return 0 instead of -EINVAL if function ccu_pll_recalc_rate() fails to
> get correct rate entry. Follow .recalc_rate callback documentation
> as mentioned in include/linux/clk-provider.h for error return value.

Nice catch, thanks.

> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Here misses a Fixes tag. With this added,

Reviewed-by: Haylen Chu <heylenay@4d2.org>

> ---
>  drivers/clk/spacemit/ccu_pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> index 4427dcfbbb97..45f540073a65 100644
> --- a/drivers/clk/spacemit/ccu_pll.c
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -122,7 +122,7 @@ static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
>  
>  	WARN_ON_ONCE(!entry);
>  
> -	return entry ? entry->rate : -EINVAL;
> +	return entry ? entry->rate : 0;
>  }
>  
>  static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -- 
> 2.34.1
> 

