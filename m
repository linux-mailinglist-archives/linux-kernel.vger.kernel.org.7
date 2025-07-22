Return-Path: <linux-kernel+bounces-740049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DCB0CF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADEB1AA5DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2C189B80;
	Tue, 22 Jul 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="huHajcKc";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="wgJqGZBM"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84686D17;
	Tue, 22 Jul 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147363; cv=none; b=rOa7QZ7TmF0097zXDMdTdRKNuv5tC0jPjJ9wGvq2hk+75YBlDRsIg2usx85BCBXobnQmxtcNhHpP/IT6KbRlpX27AuLUlsbK5qsQHTPNwLRxRjpVu8ka1XxZbigBfboKa/SGc95MVX5AW7/4g5NLOzvexHa4EgHp95thoNUDzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147363; c=relaxed/simple;
	bh=EY7ok2pqfxBJbKCKYKEiVz7SgLQ58DjtTaUal/8LobY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHKx4p1Y2VRJ7NDqmW4Bvdpo4hg/U5YI6prtO5k8dOLn1PoWYHN5lEdJ4uys7LKr0pSYMNs0IXMFFDrcZQgY5b2wpUyvv94bvVNFVdXKln6Gtdwg6QDLqigaCaqypdfEBmcCuhRcGXdAv1fLtnk0Q/6Rac+ySYSYWKPBGish4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=huHajcKc; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=wgJqGZBM; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id E3C1312FB42B;
	Mon, 21 Jul 2025 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1753146178; bh=EY7ok2pqfxBJbKCKYKEiVz7SgLQ58DjtTaUal/8LobY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huHajcKcVf0JO7BF/aTB4JZNS68kbeIswtO0pLah4JsDd91aD8to+xPXH1s+8ppL0
	 Qb4M70RAfoA+aAcBosR9DutrX7iRLV9eEZmMx0Yxlf+RzU7tkHpWWcLa3+Yt60xKXf
	 FJjWdVAfvEjfCFUmWfIYzS8w2v1gcUkaMRF/+av8gnzEVx0b9y+wzZ4rUprnXFJfYa
	 Hrot1RPjrdXdJHU2DzTkzvqU6/tTm1gBWplYVBjS6rFvS2wWfE5iIR2z75yiZcA4q2
	 LjerUWJErk+wifOoupRYnY3d9aazGoZVE/SXl/bCo4NUrIvU+cJc2ndb4g2XODWPRg
	 uQQy54Lrmv/sg==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtJ0SlhhwE5J; Mon, 21 Jul 2025 18:02:54 -0700 (PDT)
Received: from ketchup (unknown [117.171.64.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id BA8A212FB405;
	Mon, 21 Jul 2025 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1753146174; bh=EY7ok2pqfxBJbKCKYKEiVz7SgLQ58DjtTaUal/8LobY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wgJqGZBM8kn437TuW3Ur0ouaNXpgPGF9aviI22AC1XS8pksglo7CSpJ1jSoo0ozkM
	 86Z55J0U75IZ7FKzdMF25pTX9KkpuLW0OF9J4hQBwaYFnbk1IvOB/dc2k2qqHUQPC9
	 dH1GLNVVq3dp1HF4jo1SiXzEyaukzk/oJqo3In2cuXUQyBaKP9XNfrSE7sbhczYOSP
	 ASnUPPQ3s8K2zRtNPznMvWto5DRrfilS31WHQNb9ihGkfZQ9Lf7Fx3F6tNYoCql6UG
	 +v1a89i80omG9joEhjsXpklfarC8url7K8ih0wbLzWCKU0wCA8HzF9ylWIYh3eT/F+
	 m3w1c6V27hpQQ==
Date: Tue, 22 Jul 2025 01:02:43 +0000
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
Subject: Re: [PATCH] clk: spacemit: fix error handling in
 ccu_pll_set_rate/_round_rate
Message-ID: <aH7jM_q3y85o2Daf@ketchup>
References: <aH6OC1aV6IcQnoSC@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH6OC1aV6IcQnoSC@bhairav-test.ee.iitb.ac.in>

On Tue, Jul 22, 2025 at 12:29:23AM +0530, Akhilesh Patil wrote:
> Initialize best_entry pointer with NULL in ccu_pll_lookup_best_rate()
> to avoid returning garbage value when function fails to assign it
> a valid rate entry.

This doesn't sound very reasonable to me. Looking through
ccu_pll_lookup_best_rate(),

	static const struct ccu_pll_rate_tbl *
	ccu_pll_lookup_best_rate(struct ccu_pll *pll, unsigned long rate)
	{
	        struct ccu_pll_config *config = &pll->config;
	        const struct ccu_pll_rate_tbl *best_entry;
	        unsigned long best_delta = ULONG_MAX;
	        int i;

	        for (i = 0; i < config->tbl_num; i++) {
	                const struct ccu_pll_rate_tbl *entry = &config->rate_tbl[i];
	                unsigned long delta = abs_diff(entry->rate, rate);

	                if (delta < best_delta) {
	                        best_delta = delta;
	                        best_entry = entry;
	                }
	        }

	        return best_entry;
	}

best_entry is assigned as long as there's one entry fits the delta
better. Since best_delta is set to ULONG_MAX, any entry with non-zero
rates fits the required rate "better" at start of the loop. As long as
we have at least one non-zero entry defined for the PLL, best_entry is
always initialized and ccu_pll_lookup_best_rate() cannot return an
invalid pointer. And all existing PLLs do define at least one entry.

> Avoid passing invalid rate entry reference to
> ccu_pll_update_param by adding appropriate error handling in
> ccu_pll_set_rate and ccu_pll_round_rate.
> Address the effects of uninitialized pointer as reported
> by smatch and coverity static code analysis tools.
> 
> Addresses-Coverity-ID: 1649164
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202505111057.ejK2J56K-lkp@intel.com/

Thus this looks like a false-positive to me.

> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Regards,
Haylen Chu

> ---
>  drivers/clk/spacemit/ccu_pll.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> index 4427dcfbbb97..3fc6a30f98b7 100644
> --- a/drivers/clk/spacemit/ccu_pll.c
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -21,7 +21,7 @@ static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *p
>  							       unsigned long rate)
>  {
>  	struct ccu_pll_config *config = &pll->config;
> -	const struct ccu_pll_rate_tbl *best_entry;
> +	const struct ccu_pll_rate_tbl *best_entry = NULL;
>  	unsigned long best_delta = ULONG_MAX;
>  	int i;
>  
> @@ -107,6 +107,10 @@ static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	const struct ccu_pll_rate_tbl *entry;
>  
>  	entry = ccu_pll_lookup_best_rate(pll, rate);
> +
> +	if (!entry)
> +		return -EINVAL;
> +
>  	ccu_pll_update_param(pll, entry);
>  
>  	return 0;
> @@ -129,8 +133,11 @@ static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  			       unsigned long *prate)
>  {
>  	struct ccu_pll *pll = hw_to_ccu_pll(hw);
> +	const struct ccu_pll_rate_tbl *entry;
> +
> +	entry = ccu_pll_lookup_best_rate(pll, rate);
>  
> -	return ccu_pll_lookup_best_rate(pll, rate)->rate;
> +	return entry ? entry->rate : 0;
>  }
>  
>  static int ccu_pll_init(struct clk_hw *hw)
> -- 
> 2.34.1
> 

