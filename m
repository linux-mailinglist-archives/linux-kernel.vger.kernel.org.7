Return-Path: <linux-kernel+bounces-728535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E32B029A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47DAA404DB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D191219A9B;
	Sat, 12 Jul 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3lYZiRO"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53F1F4C90
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752305446; cv=none; b=pVhsCon62m8Zs+13zMmOiuKt3O+LvESauYf7i01JMoVxHZwsGTANlddp6jIUlrHZ1GvSuHnfa+/OP/51Ed2IpUd87JsZIu08CWb1+jNIpusfvlPR+1xJP6EpZVJa/GfIV1RjX6nZsy3WLneTAhwA568YrbosSrB/LFhWKhkBGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752305446; c=relaxed/simple;
	bh=sygFKhGR6G3MvpV2c0vaS7COBxzymZG0L9tQiwqMuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPYqpYIsrbF/Lon3GRn10zlUelwds5oEV7xHKzZZxREg9cMMD7mfm+j2f/JtUHeAs85lf0fdOYCF7LzNPoXe2gfq0+GWohU6BkUCDqzsPXpNEK2dHdckXHiI5NbO4U9jNpOiyxPnyOyFTPC7qkvwMNhhpt/W6DhclLCIGM3IxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3lYZiRO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Jul 2025 15:30:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752305433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaZkLh+Xqu7HMq+MNm0aFn7Fz9hf/atCoHwr5DO1YjQ=;
	b=h3lYZiROqjNNRodm3MHnwUWM/aYFfjbbTzhIMKhu/6NufohDMm5m8G+TgRRZXv+xoYMrZQ
	q2ABQVxzsmTduEh+uJg3bo1jo1BSUi+zjmJk7v3zlO9qM8A/8ckrHFNwmp2Fk1hpN5vjui
	mb6Ii/3eBv2sgZiyLLDkERDrv4ApbeE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ze Huang <huang.ze@linux.dev>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Ze Huang <huang.ze@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"spacemit@lists.linux.dev" <spacemit@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] usb: dwc3: add generic driver to support flattened
Message-ID: <aHIPEz_YsKejIP_6@monica.localdomain>
References: <20250705-dwc3_generic-v5-0-9dbc53ea53d2@linux.dev>
 <20250705-dwc3_generic-v5-2-9dbc53ea53d2@linux.dev>
 <20250711233728.cmkhbnmgzacwx7uk@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711233728.cmkhbnmgzacwx7uk@synopsys.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 11:37:32PM +0000, Thinh Nguyen wrote:
> On Sat, Jul 05, 2025, Ze Huang wrote:
> > To support flattened dwc3 dt model and drop the glue layer, introduce the
> > `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
> > and offers an alternative to the existing glue driver `dwc3-of-simple`.
> > 
> > Signed-off-by: Ze Huang <huang.ze@linux.dev>
> > ---
> >  drivers/usb/dwc3/Kconfig             |  11 +++
> >  drivers/usb/dwc3/Makefile            |   1 +
> >  drivers/usb/dwc3/dwc3-generic-plat.c | 182 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 194 insertions(+)
> > 

[...]

> > +static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
> > +	SET_RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
> > +			   dwc3_generic_runtime_idle)
> > +};
> > +
> > +static const struct of_device_id dwc3_generic_of_match[] = {
> > +	{ .compatible = "spacemit,k1-dwc3", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
> > +
> > +static struct platform_driver dwc3_generic_driver = {
> > +	.probe		= dwc3_generic_probe,
> > +	.remove		= dwc3_generic_remove,
> > +	.driver		= {
> > +		.name	= "dwc3-generic-plat",
> > +		.of_match_table = dwc3_generic_of_match,
> > +		.pm	= &dwc3_generic_dev_pm_ops,
> 
> You're still not using the new pm_ptr()/pm_sleep_ptr. The kernel build
> bot will complain about the maybe unused functions.

Thanks for your patience.

I found they are caused by using SET_RUNTIME_PM_OPS and SET_SYSTEM_SLEEP_PM_OPS macros.

I'll replace them with new RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS and wrap the
dwc3_generic_dev_pm_ops with pm_ptr()

> 
> BR,
> Thinh

