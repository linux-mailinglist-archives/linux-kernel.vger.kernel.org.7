Return-Path: <linux-kernel+bounces-893340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A5C471D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2E94E63DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF1312817;
	Mon, 10 Nov 2025 14:13:01 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061230F7F7;
	Mon, 10 Nov 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783980; cv=none; b=LlwezB/BfefYsCli21Bq62lk76hu2ebGOCFaTkdEM6Hs6WCVcwLJjUm3jbnQjCvk0Y9KVoDR7CV6KYPH8PYmO9i2Fv9pIozCFFhR7BZjZn6THZdwo66H/I0lFgfyIuVVJR9vCcVzXsJ2lkjPEu0zNd4a/fcAvsQiPgEpA2F53NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783980; c=relaxed/simple;
	bh=mUxnKWfHnamB59du9JsNEMnLieM8UVFH9uYtuv4nAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQaU6vq8JIkmB7AZVosciMNTTP9Ict/c+cYFbg0hmhEjzUHYe8zDCDewZuEZGGJAkXMZdvSTk/usY3JDX7P1hryWxvIpXlRhADIRBdPEWt2NEFro1m33+oR3ZeYu4RBkUWYs5pAhnXb+bAkKmyjLtVuS1HKTK5c5F9dzcVl+Vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 895DF340E1E;
	Mon, 10 Nov 2025 14:12:58 +0000 (UTC)
Date: Mon, 10 Nov 2025 22:12:51 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Encrow Thorne <jyc0019@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix comment typo
Message-ID: <20251110141251-GYD1651402@gentoo.org>
References: <20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com>
 <20251029223337-GYA1549833@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029223337-GYA1549833@gentoo.org>

Hi Encrow,

On 06:33 Thu 30 Oct     , Yixun Lan wrote:
> Hi Encrow,
> 
> On 00:05 Wed 29 Oct     , Encrow Thorne wrote:
> > ccumix.h was copied from ccudiv.h and the comment after #endif was not
> > updated.
> > 
> > This patch fixes the incorrect comment to match the filename.
> 
> Just describe in imperative mode, see
> (since this is trivial, I could amend it before apply the patch,
> so no need to resend)
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> 
I have no other clock patch queued this cycle, so how about you respin a v2
then let's ping Stephen directly for inclusion?

for commit message, I'd suggest simply as below (short/clean, also enough):

Fix incorrect comment to match the filename.

> > 
> > Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> > ---
> >  drivers/clk/spacemit/ccu_mix.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > index 54d40cd39b27..c406508e3504 100644
> > --- a/drivers/clk/spacemit/ccu_mix.h
> > +++ b/drivers/clk/spacemit/ccu_mix.h
> > @@ -220,4 +220,4 @@ extern const struct clk_ops spacemit_ccu_div_gate_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_div_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> > -#endif /* _CCU_DIV_H_ */
> > +#endif /* _CCU_MIX_H_ */
> > 
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4
> > 
> > Best regards,
> > -- 
> > Encrow Thorne <jyc0019@gmail.com>
> > 
> 
> -- 
> Yixun Lan (dlan)
> 

-- 
Yixun Lan (dlan)

