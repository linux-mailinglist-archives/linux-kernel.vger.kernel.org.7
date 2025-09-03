Return-Path: <linux-kernel+bounces-797514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3660B4116F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FC57003C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CD1C8629;
	Wed,  3 Sep 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BBF2+QYn"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAB1B040B;
	Wed,  3 Sep 2025 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860288; cv=none; b=eVhXJoNbonlVRrH0A73cAnGlDaUuTLJin/blyH9DsHRE4PVS6tZd/BOUsdpSjcPnRo0nfjzooANjCgq8K1tibRaDoG6euYcI4XYrp1l95eBnlf/T1NDOwIg4yDZLNfa9rb7TfXllwB0IXy07WEgDgcySKwOYe75xR8RfGTR/+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860288; c=relaxed/simple;
	bh=4Q4jmlqtVkdofhfxPNeavNd3XW/TzX0LexA49k5UNd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlIIYOcfxFZt24DSRmY3svHQ7CMos5WUzw8gVkdGLeaieMF4+PMuZ/7ZNC9JwLx+kkG26JFV5ShjtVD3N0V8p+81M4rSZlbquuVSNvgU8SddgEGGItd5yT1zsrULm7us0j2jbP1PfDlHYSJ+OXgk0eSptylmB+21UoU7g5N4vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BBF2+QYn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7009422C2E;
	Wed,  3 Sep 2025 02:44:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tin-IeOjfvhF; Wed,  3 Sep 2025 02:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756860284; bh=4Q4jmlqtVkdofhfxPNeavNd3XW/TzX0LexA49k5UNd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBF2+QYn9rM9g4zL2ykVvXd9eo/5cigkNzYW3wl1pxUCDk3/SxXnpOkjbSAtyNklx
	 RBICKIMH8l1QLb9aswytIQwDfGqeI44qsV8OrA1xhGHl49LhHFkse/jU6mHQrgNbUw
	 FL2wKts8nX/kqAIvt4qd/u3Nd8PtnUzKDu0CAq/JoxySWq/NvRzS1eyNP8FaTjQydd
	 uOJ1ux4BzxF/k4OKzhYh0yA6FrIcTS1C4l6B2tssJ6iSoW/DQ2gQq897HIhxf3g0Fx
	 MGM3g4yToe0+Xq6vCoFO/e/+sAVI6kQMMrTkN1qMJk+tpO3svR2ZQ2jvcQ8w+BwZSj
	 FjUO2SNUBFTTQ==
Date: Wed, 3 Sep 2025 00:44:25 +0000
From: Yao Zi <ziyao@disroot.org>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, fustini@kernel.org,
	gaohan@iscas.ac.cn, rabenda.cn@gmail.com,
	linux-kernel@vger.kernel.org, palmer@dabbelt.com, guoren@kernel.org,
	p.zabel@pengutronix.de, paul.walmsley@sifive.com,
	m.wilczynski@samsung.com, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, wefu@redhat.com
Subject: Re: [PATCH 3/4] reset: th1520: Support reset controllers in more
 subsystems
Message-ID: <aLePaQSMLgiGsbf_@pie>
References: <20250901042320.22865-4-ziyao@disroot.org>
 <AM7P189MB100965809B3DE48A90A15415E306A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7P189MB100965809B3DE48A90A15415E306A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>

On Tue, Sep 02, 2025 at 04:15:08PM +0200, Maud Spierings wrote:
> Hi Yao,
> 
> > Introduce reset controllers for AP, MISC, VI, VP and DSP subsystems and
> > add their reset signal mappings.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> 
> /* snip */
> 
> >  static const struct of_device_id th1520_reset_match[] = {
> > +	{ .compatible = "thead,th1520-reset-ap", .data = &th1520_ap_reset_data },
> > +	{ .compatible = "thead,th1520-reset-misc", .data = &th1520_misc_reset_data },
> > +	{ .compatible = "thead,th1520-reset-vi", .data = &th1520_vi_reset_data },
> >  	{ .compatible = "thead,th1520-reset", .data = &th1520_reset_data },
> > +	{ .compatible = "thead,th1520-reset-vp", .data = &th1520_vp_reset_data },
> > +	{ .compatible = "thead,th1520-reset-dsp", .data = &th1520_dsp_reset_data },
> 
> I believe these should be alphabetically sorted on compatible name.

This is sorted according to the order they appear in the TRM, but yeah
sorting them alphabetically makes more sense. I'll do this in v2.

Thanks,
Yao Zi

> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, th1520_reset_match);
> > -- 
> > 2.50.1
> 
> Kind regards,
> Maud
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

