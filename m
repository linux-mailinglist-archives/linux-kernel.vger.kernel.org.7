Return-Path: <linux-kernel+bounces-739247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92432B0C3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF7E4E3465
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848862D3A6D;
	Mon, 21 Jul 2025 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TaILfvtu"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3129B8D2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099705; cv=none; b=LKvZatibYWFhH+u/tjiSzBDDrsq85MqH/0JSqK2pt80kCf3rNNR5w/m+X5mbM4ffryxteHfHORRNQUVwNz7HGszYA+cUO0tW3mszE5L+58uMzwB8bIiYMlPScgAIRGU/wXzRkU5Tmz1ZWapwqVegOZ2WY0ULpxh18SBOVk/3OGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099705; c=relaxed/simple;
	bh=PKt0mTjmvvvkepwsCUMzvM+RF3tsj0b4ozWzqNpeB3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjW8wrYavber6wL/E8tu1nRwfrFcTHvSpYssymJnJcB6X0JopBEey5jOq57M3VF1CZTxneb5+XO3zl9uPRPy7Ag2P3ywF8ftBLyET3xkFlfLvEyY41vjfp8CTwe5MYjTqXpN+0BBXiuXot40uktG/ZzF9FC9AfTlDDBMzMg33UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TaILfvtu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Jul 2025 20:08:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753099692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CiyT1LW8S2cprjOA7fuHy478wU5+FE3KPTv6t/QXyg=;
	b=TaILfvtul8thQUWdU4h/uwNOkqNqAJ/O9St/9Gyyvw2qOPqG6+/08lRNgo4p+1iEBqMIb1
	jn0o+aou5/+r7/hOr3YnGuvvCGps0mC/HxKpt+TIfKVEPPKGNa9RNZn318dsUI+9JMtAiX
	24dr4T43X39mGq5d4DvYRTxpoTHFBPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ze Huang <huang.ze@linux.dev>
To: Alex Elder <elder@ieee.org>, Ze Huang <huang.ze@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: dwc3: add generic driver to support flattened
Message-ID: <aH4tpgVPbf9DOzSe@monica.localdomain>
References: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
 <20250712-dwc3_generic-v6-2-cc87737cc936@linux.dev>
 <d2e9a521-568e-433d-a59b-9b98138ace2b@ieee.org>
 <aHyN3-uoHofF8Hg3@monica.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHyN3-uoHofF8Hg3@monica.localdomain>
X-Migadu-Flow: FLOW_OUT

On Sun, Jul 20, 2025 at 02:34:07PM +0800, Ze Huang wrote:
> On Tue, Jul 15, 2025 at 03:50:54PM -0500, Alex Elder wrote:
> > On 7/12/25 2:49 AM, Ze Huang wrote:
> > > To support flattened dwc3 dt model and drop the glue layer, introduce the
> > > `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
> > > and offers an alternative to the existing glue driver `dwc3-of-simple`.
> > 
> > I'm not familiar with dwc-of-simple.c, and won't comment on
> > how this differs from that (or does not).
> > 
> > Given you're implementing an alternative though, can you explain
> > in a little more detail what's different between the two?  Why
> > would someone choose to use this driver rather than the other one?
> 
> They are basically the same.
> 
> dwc-generic use a plain dt node while dwc-of-simple will nest the dwc3
> node as its child.
> 
> Both will use dwc3_core_probe() to finish the probe process. But now we
> can simplify the process by just calling it, instead of calling
> of_platform_populate() and create another snps,dwc3 device driver.

[...]

> > > +	ret = reset_control_assert(dwc3->resets);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to assert resets\n");
> > > +
> > > +	ret = devm_add_action_or_reset(dev, dwc3_generic_reset_control_assert, dwc3->resets);
> > > +	if (ret)
> > > +		return ret;
> > 
> > The re-assert shouldn't be set up unless the deassert below
> > succeeds.
> > 
> 
> Will move behind the deassert.
> 
> > > +	usleep_range(10, 1000);
> > 
> > This seems like a large range.  You could just do msleep(1);
> > Also, can you add a comment explaining why a delay is needed,
> > and why 1 millisecond is the right amount of time to sleep?
> > 
> 
> I will check the range with spacemit and reply soon.
> 

the resets are asynchronous with no strict timing. But to be safe, each
reset should stay active for at least 1 µs. I’ll switch to a udelay(2)
and add comment accordingly.

> > > +	ret = reset_control_deassert(dwc3->resets);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to deassert resets\n");
> > > +
> > > +	ret = devm_clk_bulk_get_all(dwc3->dev, &dwc3->clks);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> > 
> > Call devm_clk_bulk_get_all_enabled() instead of doing the two
> > steps separately here.
> > 
> 
> Will do, thanks.
> 
> > 					-Alex

