Return-Path: <linux-kernel+bounces-772683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64692B29611
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D21C1895B03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A11E9B2D;
	Mon, 18 Aug 2025 01:22:20 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3B19F11F;
	Mon, 18 Aug 2025 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480140; cv=none; b=HwOO9WxMYv5FuDds4/UvNw7LEBw+eRKveb+4KbN2nyVBJmht92hm2ExtGDPjsqXH7SebStHQBwpLEZRJOB3EHRzr5TCoQXz2bzxfJelXOSloJqykQaGzflFqKY/p7jdLE0LPYCtHqly3A7ceW8czcUpklrQhUhHII+gE+hT7qcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480140; c=relaxed/simple;
	bh=fOQpiaXSWhdRBx87IMV+h6Ad7W+80WZ4ofnOSc8GllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHMRgmMpIoe6GeXkRAAWVGM4Nsqpgp33/gI3nTE9WOo/7GxQzgKmtRGEKOmyue7N80h0NRCr4VdWV9pQo4OHC2ET/vkUBqeabeIUsmTbVMGSQWjN78MDys5lP6y7/EXJDs4X16w4W1fzaBfR7dRGqRCi8o4VpW/IbCBMB0xsCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755480073tfa152b0d
X-QQ-Originating-IP: J4zOZYfdEVPwo6f9K36pp7u0T/5DQRVYSlsV84VpeYA=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 09:21:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11348850142159916151
Date: Mon, 18 Aug 2025 09:21:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
Message-ID: <BE62E79A10943B82+20250818012111.GB1370135@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
 <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>
 <b669db06-83f8-447c-8081-7ef6ae9d2aba@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b669db06-83f8-447c-8081-7ef6ae9d2aba@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nu7meyJZV74IsyGuftRR0bOmDEN3j3m110NG+jF4G2lD+YJOvvVtjZCJ
	HFlgqWklw2e0BKNJNGfzByKRxSN0xWptm26sBN7X9RHPp4JB/afeVVtxL/ebuUcdhV+NO6D
	VM8C46XzTXEQRWcl0qkiu/fG48NMAeavd5gQNAFCz2Z1hB+bQtwXxaiDp1WkxtPeEmtc0lx
	yl4dZGsI1QMNaGyjZ1edAmxTtzdeyEdKHJ/bcYZIkNp3JqO+nb8WLcHXqkbFqzhtIU7RqO3
	3Foj2FTiGVYijQQltBEFG6qGouS5lwHZ6FnXSYbtG8+g/J2CLI0lQwHA4RkXTAqi/D97pjO
	hJF5fThml9kNXjJyB0lbgiLfhA193Am6AGMoLCxzIZVL0fsMmQ5cyJPKhsk8n/z9fNtJZvr
	5a2op0ERBJq62hcVFizeHTSQHcEsWknKWY/5agwvMsnxfuHQIHQFZUSLiA5ovoPJ73NVdu0
	J7ue+rLL46eMEUXJeCHmeybqVjXb9A+P4Xp/NX/ZI27fdp8tFHTZl7L9ELl+GRbM6pAO04d
	I+/cNHB3J3qzNd6/K3Az3YziCWolss2he9mDozgX48uq52+/1C7RsOCe0rdjuHnFETpB7JY
	1qzRV4EnJm7LFafedEuip6uknhfcQFyRfQ3+lzE0mFfR11wkUbIlEvSX26FGBCOat05GAFv
	t+PQcaSDPT2Stxl9SVTKl23pydP4lhbR2DkSpg6/pRRdtVVh+sS81f/lU/0fe3EpQ5OQStC
	ow/QOXHXtCIzT4ZnQ1eIciAh0WLAt95BAFPUx9izqVGEN0PJ3d6rxjJdCbOmy9zhrU5/8Nm
	TzPrluUNW23+vLd1fsx3c4wIIRc5kiu9qH5h/ekHXMDGk58kNS7r9YiI2+4bEyAnvzUAECh
	3IK4Z8TFlaqxTEX0FXhZL6D12kN4ovQa1ZAswxx5m5eDyV1TMd/kJz3SOQ/5JSwESmFaLcc
	x6bGk0WfB8lMouFpoQITpXTrfWOgryFIIlRaWYpjW6eD5Q4TCWyBPlnYYwYxj/mjcVRYlsN
	zOLMH2dg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 08:06:35PM +0200, Andrew Lunn wrote:
> > > > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_dma_info *dma = &hw->dma;
> > > > +	int err;
> > > > +
> > > > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > > > +	err = mucse_mbx_fw_reset_phy(hw);
> > > > +	if (err)
> > > > +		return err;
> > > > +	/* Store the permanent mac address */
> > > > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
> > > 
> > > What do this hw->flags add to the driver? Why is it here?
> > > 
> > 
> > It is used to init 'permanent addr' only once.
> > rnpgbe_reset_hw_ops maybe called when netdev down or hw hang, no need
> > try to get 'permanent addr' more times.
> 
> It normally costs ~0 to ask the firmware something. So it is generally
> simpler to just ask it. If the firmware is dead, you should not really
> care, the RPC should timeout, ETIMEDOUT will get returned to user
> space, and likely everything else will fail anyway.
>  

Ok, I will remove 'M_FLAGS_INIT_MAC_ADDRESS', and ask the firmware when
the function is called.

> > > >  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> > > >  {
> > > >  	struct mucse *mucse = pci_get_drvdata(pdev);
> > > > +	struct mucse_hw *hw = &mucse->hw;
> > > >  	struct net_device *netdev;
> > > >  
> > > >  	if (!mucse)
> > > >  		return;
> > > >  	netdev = mucse->netdev;
> > > > +	if (netdev->reg_state == NETREG_REGISTERED)
> > > > +		unregister_netdev(netdev);
> > > 
> > > Is that possible?
> > > 
> > 
> > Maybe probe failed before register_netdev? Then rmmod the driver.
> 
> Functions like this come in pairs. There is some sort of setup
> function, and a corresponding teardown function. probe/remove,
> open/close. In Linux, if the first fails, the second is never called.
> 
> 	Andrew
> 

Got it, 'if (netdev->reg_state == NETREG_REGISTERED)' will be removed.

Thansk for you feedback.


