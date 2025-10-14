Return-Path: <linux-kernel+bounces-852172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBABD8590
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF05D3AFA53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73002E36F3;
	Tue, 14 Oct 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9vuxpvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23E2BEFE0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432674; cv=none; b=OTL5ARVSCGhKJtV+uMUwWSEhbIYJ93622dH02Fpv+m9b+WJ0K447vpucjiCYnRtvglC99ZI+d/l2Z8PM50wHkxMVadvfPhpdscXCwgM3mf7/lORvB9lFpGHF4Iz6INf+utgxD8ZOFpJAWwx7GdvlKZEiRd/r7UfPTNpoLX6qOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432674; c=relaxed/simple;
	bh=PpS3obPpYFzyM3HttVIzr5hHM6LNfDIMljGghw8AgMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGPlBvVsj6NbS4E+gJYNCRmgRxpdTODc774uy8UDbK/XHbiFXHNLaoPLs/5meKAwO/tZfmsge500t4mUtwF6vPRy4g48J6nGrauRe3Illjzbv5/xkWNs7gnDySu9uXZKHdDp/h1ts/bnAJs7qoaK/ZzIiMcg82PB5oI4KnF4b70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9vuxpvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9712C4CEE7;
	Tue, 14 Oct 2025 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432673;
	bh=PpS3obPpYFzyM3HttVIzr5hHM6LNfDIMljGghw8AgMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9vuxpvxLDZt9CKW7MiqlKy04407MI91Bn6kTe/t4Fr/ZzrAU3oXGSdrpctMiZf+1
	 7YRsJyxwHU2heixTSh2/gan8js3AhFcAWV/3f8Lg+TSkC5EjavTHQbvGwpsQ7m7P4/
	 i9JN+KPzo/x0n8MOL1KfDDNtpl7X3uar/7ZIrIn2+skanzV+Q1xMnUS5ab6cOQclsw
	 jYkNkO9N+qWrmjXgY0ClKR7g0JpNA3m2P0tiSiDF044pj8Ax5vnirZG5psqtFBXCK9
	 MWSkHz9pCJF6hoCfSxC73ljWP6ow4ElvK1rFTWZv/u4OPYu6P9r/PdChD2KWC4sEJr
	 YH2DYUs+dJMYw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8axM-000000001jT-19b7;
	Tue, 14 Oct 2025 11:04:32 +0200
Date: Tue, 14 Oct 2025 11:04:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] irqchip: Pass platform device to platform drivers
Message-ID: <aO4SIP0Q9aHIPeut@hovoldconsulting.com>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-12-johan@kernel.org>
 <7618ec1b-6e3c-4d29-8435-cc5269bdb9df@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7618ec1b-6e3c-4d29-8435-cc5269bdb9df@suse.de>

Hi Stan,

On Tue, Oct 14, 2025 at 11:52:40AM +0300, Stanimir Varbanov wrote:
> On 10/13/25 12:46 PM, Johan Hovold wrote:

> > +typedef int (*platform_irq_probe_t)(struct platform_device *, struct device_node *);
> > +
> >  /* Undefined on purpose */
> >  extern of_irq_init_cb_t typecheck_irq_init_cb;
> 
> This is not used anymore?
> 
> > +extern platform_irq_probe_t typecheck_irq_probe;
> >  
> >  #define typecheck_irq_init_cb(fn)					\
> >  	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
> 
> ditto

These are still used by IRQCHIP_DECLARE() (i.e. non-platform OF irqchip
drivers).

Johan

