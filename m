Return-Path: <linux-kernel+bounces-869893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650DC08F1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A154D4E8144
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6B2F39BF;
	Sat, 25 Oct 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYtvyw25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F52F39B5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388418; cv=none; b=a+9NJeph1+YNB6/wQc+cU8WAI+/v+DHDjbB+j9AxIVW7hFhczcZpMLfoIJHwbUxiTuSPX4T3tOUD263tlcX7FXBUN4ZXLZNuTw5owmRfScDBH90CMeuCwAiGaP5Xuk1YOZQinljXIR6tvvbpz2A1tY+WVSCUfhkrgznhLbegam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388418; c=relaxed/simple;
	bh=3S4hLJ3Zo8nESZ4LULisyLqzKe3p2Uf5id0T6DOa+io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBWQmyXXxgsczXJOEtIz0UnmcRWBi0Tsq82ZYcUME/yNN9Ayw/7tNwUyBNSw1tcLlATLDSUJJkZSeNhgGDtgRLqKm5fCjfDrN/yFMO91noK1NMH7KfLgiPsBzVZ4ISLhgNyGosotOioNOJ/yhzIXd1TtwgfzLbAp/RlYY6LBnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYtvyw25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED77C4CEF5;
	Sat, 25 Oct 2025 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761388417;
	bh=3S4hLJ3Zo8nESZ4LULisyLqzKe3p2Uf5id0T6DOa+io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYtvyw25qdMYjvQRE3xeiHzWckPeD7qqeF1XsPyUzKZ3IRe1eOpr1oxP7Lb2d3Uts
	 uvq3HJv5rjNzjJO3WT64j4H8PEqIP0rCdr3Kz3V4czJlnqOC26kRh2pcErtFrpeVyr
	 BRb4DsQWWAEvQpTxU5f5BF69kuXJg6OUfTrclGDvnZJGrluLhGKrA0495qIADFNmyI
	 ZNUBjuRjOfnCDoEcYKPr1PMyBMDuC8gO5rtwdmyNZ+y/mlx3R10najBqUGji3IyUkb
	 LBu0zBmYkNcCXrE4q4CFIa3rLmeaIRCMBNH4Ls9sWh1DsEQuasSR69oxE3tIOCIKVa
	 Lh1mdX4vUZNDw==
Date: Sat, 25 Oct 2025 11:33:32 +0100
From: Lee Jones <lee@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9055: Fix missing regmap_del_irq_chip() in error
 path
Message-ID: <20251025103332.GA7775@google.com>
References: <20251010011737.1078-1-vulab@iscas.ac.cn>
 <b2836421-c7b5-442b-a208-5cd3efdafa4b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2836421-c7b5-442b-a208-5cd3efdafa4b@wanadoo.fr>

On Fri, 10 Oct 2025, Christophe JAILLET wrote:

> Le 10/10/2025 à 03:17, Haotian Zhang a écrit :
> > When da9055_device_init() fails after regmap_add_irq_chip()
> > succeeds but mfd_add_devices() fails, the error handling path
> > only calls mfd_remove_devices() but forgets to call
> > regmap_del_irq_chip(). This results in a resource leak.
> > 
> > Fix this by adding regmap_del_irq_chip() to the error path so
> > that resources are released properly.
> > 
> > Fixes: 2896434cf272 ("mfd: DA9055 core driver")
> > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > ---
> >   drivers/mfd/da9055-core.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
> > index 1f727ef60d63..8c989b74f924 100644
> > --- a/drivers/mfd/da9055-core.c
> > +++ b/drivers/mfd/da9055-core.c
> > @@ -388,6 +388,7 @@ int da9055_device_init(struct da9055 *da9055)
> >   err:
> >   	mfd_remove_devices(da9055->dev);
> 
> I don't think that mfd_remove_devices() is needed here. Looks harmless, but
> should mfd_add_devices() fail, this clean-up is already done (see [1]).
> 
> CJ
> 
> [1]:
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/mfd/mfd-core.c#L337

Agree.  I look forward to your patch.

-- 
Lee Jones [李琼斯]

