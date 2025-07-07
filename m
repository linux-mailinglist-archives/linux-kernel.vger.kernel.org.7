Return-Path: <linux-kernel+bounces-719799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D5AFB2C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FC7A9C10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF873299AB5;
	Mon,  7 Jul 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wEL90RUB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E84EB38;
	Mon,  7 Jul 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889659; cv=none; b=oIsHS4ZEoQRpmyOu8JOdt1AQo1k2GQqoieL1Vdk2wKplDpFK4eBBxVj28P4aqLmjdUFtTd6NEYifr2qYLRoIJhiQvN/2l+lyU0I1bqpfpZG10lNdv8LbKq8QsUCIqi3ohZhL+6ptQpLtRyTJ1X82iovDCwB76Qfyz4bFQyXDLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889659; c=relaxed/simple;
	bh=P95bcMQU7ZPJZKZhLDXLyZrEYnchtk24M7xzCIyhGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTBeKm9aWkpNTQ7v4k7KDGU/bieCh1uiPn2KvbMqf3CBz5ehdStmV8nk/I769WizCsXBI4Q7IfNOgOqixcCZhLpH4+b4uXbi3Q6dlu0olAC3CyrB48JPvqswKxYzopuzsK0Hjoky6HsQn+9qbuuBfWGW32phJ7x6QM9HbGq1+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wEL90RUB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q+5AuUFTHWtlPlVeriGBMAZdNv3i5ihbtFUnvkIaFUI=; b=wEL90RUBpGaKK5y6QFqfX7IriG
	oPoY/JS7G6uRRY8C/1LFAOBLiHjJCKlheHs6mJkHDOUUhzAXrW9gkh7AKiyTc+MRlDWttGVOHwHx/
	ILc8cp8PlVawigpXOS1ISxhCsN/CVye+trXo4TnFkJLsHfHvOK/synbvKdMvAjBZENl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uYkW8-000i1l-Pb; Mon, 07 Jul 2025 14:00:16 +0200
Date: Mon, 7 Jul 2025 14:00:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <f8a69fa5-cc3d-4968-8b19-0bdb27e1e917@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-4-dong100@mucse.com>
 <80644ec1-a313-403a-82dd-62eb551442d3@lunn.ch>
 <9C6FCA38E28D6768+20250707063955.GA162739@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C6FCA38E28D6768+20250707063955.GA162739@nic-Precision-5820-Tower>

On Mon, Jul 07, 2025 at 02:39:55PM +0800, Yibo Dong wrote:
> On Fri, Jul 04, 2025 at 08:13:19PM +0200, Andrew Lunn wrote:
> > >  #define MBX_FEATURE_WRITE_DELAY BIT(1)
> > >  	u32 mbx_feature;
> > >  	/* cm3 <-> pf mbx */
> > > -	u32 cpu_pf_shm_base;
> > > -	u32 pf2cpu_mbox_ctrl;
> > > -	u32 pf2cpu_mbox_mask;
> > > -	u32 cpu_pf_mbox_mask;
> > > -	u32 cpu2pf_mbox_vec;
> > > +	u32 fw_pf_shm_base;
> > > +	u32 pf2fw_mbox_ctrl;
> > > +	u32 pf2fw_mbox_mask;
> > > +	u32 fw_pf_mbox_mask;
> > > +	u32 fw2pf_mbox_vec;
> > 
> > Why is a patch adding a new feature deleting code?
> > 
> Not delete code, 'cpu' here means controller in the chip, not host.
> So, I just rename 'cpu' to 'fw' to avoid confusion.

So, so let me rephrase my point. Why was it not called fw_foo right
from the beginning? You are making the code harder to review by doing
stuff like this. And your code is going to need a lot of review and
revisions because its quality if low if you ask me.

	Andrew

