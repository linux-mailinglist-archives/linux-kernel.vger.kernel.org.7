Return-Path: <linux-kernel+bounces-770285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F6B2795E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D0EA0475E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE52C0F95;
	Fri, 15 Aug 2025 06:45:43 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8D22C3240;
	Fri, 15 Aug 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240343; cv=none; b=q0mn46d1aZkpz8HSKq/duB9TTzC+6WguvtNTUTZUtJQuLW4vtHTkvlmx4GCjRxkdILTD2BBVzR0yuqwMieK+8yLiT4yBFZfebjsIVDJGIo7PqyXYB6C4z1U9YVGvcfC1DMPJm+YlcN+x+p3liJ3EoMAdCz7JC9A/FE/JM/F9N3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240343; c=relaxed/simple;
	bh=tEYwNdWsfaPWhqRUsz8dOddZWJIw9qXs0jEIMUzQHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h12ZEgVXbJH5deUzDpkDhYA6KNaSqwD8evVLyWgMxFWF6t+A2kV0sR8XTRQngVVizrw9cKGf9Pko+0cfzuWyyMd24o3dPZSUjkhY+tJ3onTSTQ6fdlAfo2gqXwsHXRB98Ydwy0JXuynx09yMF6EzS14EW70k/O3FXu0KHtDUCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755240284t3a0337c4
X-QQ-Originating-IP: 4PXFKC6B5UuvqH9rvC/iz4N+iXgh6lVYJYQxy9vEjCc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 14:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8016404537619868178
Date: Fri, 15 Aug 2025 14:44:41 +0800
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
Message-ID: <CFAA902406A8215F+20250815064441.GB1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-6-dong100@mucse.com>
 <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099a6006-02e4-44f0-ae47-7de14cc58a12@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NfCiKUdyqwvY1p6EZlxf1G2ylesouvYupwV+u6lXixLM87RhXco1e+Yx
	QPEEKLAe+GqRGiRq+YljQmzQJzDQ7N/410Wg2EaSDS+WYe+e2u41TkSVrR2PJJa7Ztb0OuY
	W9Kar0w1d7QeZtnLOC7DPKJPCMNC9ArEF1EBJL/7w6+JFC4WYFHoX9Ovp2oDt0L9m28QaZI
	4TNMGUKfpuLtn4ji6/98B76E3MOIybqbGoZSv5HyXr4kGuodnqzLbMVDRDLIAc0b9z6/2lv
	tSYJErLjXBf9GeE31/ss62b3XjtrZFTZzNAKqGWq6BM7C1aH29lDxmmfRXlRU7nvm3lQYdj
	RVC6oBmroMIx/ry8QjerwKNXAvoupnTvBDnIk4rZEekT7TFKorZdfKHHNWmN3CtqdvLIyAx
	QXIHf+3uLejiOWNZZI991S8ZfSqeL8fNHfsBgFcSUt6U4XrxayZ+sQi1sCOf5etwlvXsIzL
	cowDIlx75itt/ypDyODhOYefgSDlDvwD4c1ZkHtAaLj6d4TgFzDXklRgkwPW6A1IUGQ27at
	9KkLeMNOSh45AoV6i8PWMeW5k93S4gQR+nKE20CbksAvEsKcLotO1JH/7/jYeywxF+3QPtu
	+rTSOosa2jAkMo6F50+UzpwUP3BwXOrvjgI9Bg8v2eFvfxjAo1Cyjab6RMIdcDY3/eLfN34
	esjKRS3KFccSMnmLBjkPlJLfj4uFbvzavWnVAWt/MGj7bx/wNF6W9vlnDbZkWug/w99c/4p
	3vb3y14aRJC326JTQaUeqH8FK+bW3a9VVRdTDAfdswHBUMK57PzQgJeRDqMv+mMlkIkzoUe
	JZaMy9rXRqzzzz/UvoOYF5CVOu57mSSUPvhMTsP2bz0Wz8DwzONxVFofxXJtDzIggU1ehcW
	mbrU4sEvl4nLm2KgF56Rrx+t1d6MJKskTp8yMVYOhTwHx6TnvML+0qv3vqDRnvFO7tKACCR
	PwDq4voqmFkb13CH8WYaB8sVtJYSpAmO9ch1e4RCG75SH63bVGgbAP4IQHidJ9uWX2F9ufG
	A/UJX70289OFhtORK1VosPocl8eqgUpmiRueuP1ZaDSWJBsFUhn03fYxKAFzc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:42:05AM +0200, Andrew Lunn wrote:
> > +struct mucse_hw_operations {
> > +	int (*reset_hw)(struct mucse_hw *hw);
> > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > +};
> 
> Again, there is only one instance of this. Will there be more?
> 

It is one instance now, but maybe more hw in the furture.
I want to keep this...

> > + * rnpgbe_get_permanent_mac - Get permanent mac
> > + * @hw: hw information structure
> > + * @mac_addr: pointer to store mac
> > + *
> > + * rnpgbe_get_permanent_mac tries to get mac from hw.
> > + * It use eth_random_addr if failed.
> > + **/
> > +static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> > +				     u8 *mac_addr)
> > +{
> > +	struct device *dev = &hw->pdev->dev;
> > +
> > +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane) ||
> > +	    !is_valid_ether_addr(mac_addr)) {
> > +		dev_warn(dev, "Failed to get valid MAC from FW, using random\n");
> > +		eth_random_addr(mac_addr);
> > +	}
> 
> With a function named rnpgbe_get_permanent_mac(), i would not expect
> it to return a random MAC address. If there is no permanent MAC
> address, return -EINVAL, and let the caller does with the error.
> 

Ok, I will update this.

> > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > +{
> > +	struct mucse_dma_info *dma = &hw->dma;
> > +	int err;
> > +
> > +	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > +	err = mucse_mbx_fw_reset_phy(hw);
> > +	if (err)
> > +		return err;
> > +	/* Store the permanent mac address */
> > +	if (!(hw->flags & M_FLAGS_INIT_MAC_ADDRESS))
> 
> What do this hw->flags add to the driver? Why is it here?
> 

It is used to init 'permanent addr' only once.
rnpgbe_reset_hw_ops maybe called when netdev down or hw hang, no need
try to get 'permanent addr' more times.

> >  static void rnpgbe_rm_adapter(struct pci_dev *pdev)
> >  {
> >  	struct mucse *mucse = pci_get_drvdata(pdev);
> > +	struct mucse_hw *hw = &mucse->hw;
> >  	struct net_device *netdev;
> >  
> >  	if (!mucse)
> >  		return;
> >  	netdev = mucse->netdev;
> > +	if (netdev->reg_state == NETREG_REGISTERED)
> > +		unregister_netdev(netdev);
> 
> Is that possible?
> 

Maybe probe failed before register_netdev? Then rmmod the driver.

> >  	mucse->netdev = NULL;
> > +	hw->ops->driver_status(hw, false, mucse_driver_insmod);
> >  	free_netdev(netdev);
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> 

