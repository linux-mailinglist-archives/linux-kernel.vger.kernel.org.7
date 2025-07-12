Return-Path: <linux-kernel+bounces-728454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD9B0285C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF11C4008F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0C70823;
	Sat, 12 Jul 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CTQjscM8"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C772F43;
	Sat, 12 Jul 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280765; cv=none; b=EhX7lnAL+dtIm+qLUw/p8+qhJN56pJeiSg6F255qbvJgG+I108+Fv+wIjDHpNjBQEpak887m/MN9CiiCyRmYx1J6OmwfW/LubHq6ZqRi7csCHL1ZEsJfUeLLcrvBGFbiB42dYI3FaNpVcS9Dze6RCfQNhXdOgToHMxnJ/WM/9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280765; c=relaxed/simple;
	bh=2uVl7Jvt7/k3szvxIdckbwyBUW1Ah4/1BZwU4PoRXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+I2oouH/UKiXM8Ibh8SreQqAOCQ3xpBzxl6NtXZ6YT+6pLXG8j7lqLVNAVGAfismlY0jAx6oBggAjVZm1eLbvJXnyxVidw7FDN+d7qtXOQyzrTVI+IVd8BB5LdVnYjFmLcS9cRsJ58g8GqB7OcXmvnuHQ4sjKxU4H7jiclZ0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CTQjscM8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B51AD25E98;
	Sat, 12 Jul 2025 02:39:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvgAh5k0tLQJ; Sat, 12 Jul 2025 02:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752280752; bh=2uVl7Jvt7/k3szvxIdckbwyBUW1Ah4/1BZwU4PoRXeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CTQjscM8BNKA3GC6R/AXLuyXE7H5Faqtfne5VJn9JIs4g3H4sfqvKfQMlCdIIAMff
	 X46bydD4raVYVMaAduo4ZxoP7YjyZ3pc9pz8GCbjFACQRPUr1NNpIEEgpY8pHWnWvy
	 3dyKjBlsWleprqixoiHOwtdfE0t5BulGse9bUTRYtJgsV7+SgEME5Frt5Wx6HRSEzC
	 UJOEa6L432XU9tYuNQcqYjjoCXiaqoEnXAgnGhaqDmd1G2T5s5QJm38CsepTzixA2n
	 KGYdb0Ej0KcZ72fEnS0dannl/4zzjrSRnpr6NFhxaf0t+ayibyozHORjnHFed9zJJU
	 0lH/oJNraOd5A==
Date: Sat, 12 Jul 2025 00:39:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: thead: th1520-ap: Correctly refer the parent
 of c910-i0
Message-ID: <aHGupCeNsA-Q31kh@pie>
References: <20250710092135.61049-1-ziyao@disroot.org>
 <20250710092135.61049-3-ziyao@disroot.org>
 <aHDQv81WqlYzzpL4@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDQv81WqlYzzpL4@x1>

On Fri, Jul 11, 2025 at 01:52:15AM -0700, Drew Fustini wrote:
> On Thu, Jul 10, 2025 at 09:21:35AM +0000, Yao Zi wrote:
> > The correct parent of c910, c910-i0, is registered with
> > devm_clk_hw_register_mux_parent_data_table(), which creates a clk_hw
> > structure from scratch. But it's assigned as c910's parent by
> > referring &c910_i0_clk.common.hw, confusing the CCF since this clk_hw
> > structure is never registered.
> > 
> > Refer c910-i0 by its name instead to avoid turning c910 into an orphan
> > clock.
> > 
> > Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/clk/thead/clk-th1520-ap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> > index 42feb4bb6329..41ed72b1a915 100644
> > --- a/drivers/clk/thead/clk-th1520-ap.c
> > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > @@ -427,7 +427,7 @@ static struct ccu_mux c910_i0_clk = {
> >  };
> >  
> >  static const struct clk_parent_data c910_parents[] = {
> > -	{ .hw = &c910_i0_clk.common.hw },
> > +	{ .index = -1, .name = "c910-i0" },
> 
> Thanks for the patch. Unfortunately, I chatted with Stephen about this
> on irc and we need to avoid using strings in clk_parent_data. I'm trying
> to see how to correctly assign the pointer in the c910_parents[] after
> c910_io_clk has been registered.

If we stop using *_register_mux() for all the muxes, the problem should
go away: the key cause is that *_register_mux() always allocates a new
clk_mux structure, which in turn contains a new clk_hw structure.

We could avoid the ccu_mux structure, instead defining clk_muxes
directly and register them with devm_clk_hw_register(), for example,

	static struct clk_mux c910_i0_clk = {
		.reg		= 0x100,
		.mask		= BIT(0),
		.shift		= 1,
		.hw.init	= CLK_HW_INIT_PARENT_DATA("c910-i0",
							  c910_i0_parents,
							  &clk_mux_ops,
							  0),
	};

	c910_i0_clk.reg += base;
	ret = devm_clk_hw_register(dev, &c910_i0_clk.hw);

(not tested, just for demostration)

Now no new clk_hw structure is created and we could refer to muxes by
its hw member when defining other clocks.

> Thanks,
> Drew

Regards,
Yao Zi

