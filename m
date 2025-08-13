Return-Path: <linux-kernel+bounces-766086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99AB24220
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E6C1B67BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360F2D0C6C;
	Wed, 13 Aug 2025 07:03:13 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A65269D06;
	Wed, 13 Aug 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068592; cv=none; b=ttI4vjRjLo6OsPnhyd5it/+vp4Lg64WHZZ2HkN8+V0djFVwrel1GFy1jsWxULf414fMV9+3toe96taF3CJVG4DpPdUgJ+Jriu0b0CW8bXdnQHIiGPDMpoqalOaO/4FTFfoFub0T8DPaAopnKkli0uVKu2MJN9EUesdoftPFvt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068592; c=relaxed/simple;
	bh=qT9o6CB73jvOc1dAh2L6tM+gnP44Xl7OmT/+Hnyb8RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp0wP6Je/tFV1YB8Ofp7wNZAwv+g3EZ+Jv06z+kIKDr08JJlCnkP4gPfNlRiXHzgHIgWN8L9LSp263rnaBblSOSJnm2BufgQZUlGkHjojB03TD1s+ZCtH7o3Cl0Y2dTEPiHgMQM1JTXHob9uYGVlP6QeoTN4wcnkhFxZfnMYKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz1t1755068517t476d51cb
X-QQ-Originating-IP: MG483g31/GJY9i/Jt+OtReD7Xnxy/u5hqXTI3V5X8b4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 15:01:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8711740590628175254
Date: Wed, 13 Aug 2025 15:01:55 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <7AD2F2D5BC45498D+20250813070155.GC944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-3-dong100@mucse.com>
 <69d797eb-4a17-4d54-a7c0-8409fa8bc066@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d797eb-4a17-4d54-a7c0-8409fa8bc066@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OTubY8CZDgpR0IfudCXDkbrWiv8594/cvI5hOl8zhAPk9KIrdcRNAR2s
	1Mpv6lWaQu1w6i2BUwyuPNrSzNyidhPr298Ee66JnPVmBVTSfs0gHZfEA2nJXP2hMuG3L26
	s+DGjF53Fvf/dk1oNxOPo4pvVemH7dgwo6QD0P9m5tNC8X2zrnwDjPPraahWzRaiYlwK9FL
	dpaVwLjQUl27mp7JRF/DaYgjGtU0aR3AwPYmVBzvLr/NFo/sE8eOx6JqULv2cybyYcVgQkt
	o1hQAt8WbwGkLvhwXoAHQ6Jc7FbWppuVKROILRqSS1ZzY5g5quBXk5bE40y5viQilva8CoP
	z8oWOkHtcQz93RUJSkMS9ZmdoZyr6SekPlmrLFo4RAM4RzEsIXp+8CLJ1r1iCdEHeOIPA3D
	8XCLLkkonrZjDw4+RSksRJybvFQWvYxODpyMjlKrUIVe7GSpGX13l3m+f5JK4TObNBOItCO
	vNqSkL0+W+Bsr9UIQu70zFWd9l7/Yg+9taesZuvYUDrtltC8D3jM8bk8Ul6WXD1i7KXuWtb
	iiDqCsajlSjEOu+1W1M/SEpHGKCG/m6pE8ymQkYHE2L3uE7UJsYp2kZk3nFvtWKza/yUamr
	RJAtV1BIimXv3ICzbk1dwE56fE4BUVl47eeBG8cvltYzRHQKM5ZTYQao8RLI293n3UsXAPl
	xNSe9+c9PyKlPy18TzS9CRhZ3Tl+NBsGsaSvsex1YYp6jX6UxogbRX2xfCZk5VmqLZeLnuW
	LOvgTh9J5cKNRJSyxXw+rTr43OhUYH5qDrmbS5acCzeyRm43VCkmfXR8YADyi3+QVjQZ3tj
	xjqNPx5661XS5c6V+fDHu4w4h9s/8Eng+F277OzcJJ1AnY17+f99dB02Q5d67kdMFFRvjaT
	UbgeXT4/Iw23dxeoe8sPST96T743Dl6DKy1y8wfeIod9ZyJ7yDfZKQUsgdq04fp6cS9SQUb
	NN1q8UZmtHt5Vujtg9NIGc4xawQfoETMZWMRzqgJZFoMppwQ5ZekrHwAxoMh/Stfxys2VAy
	AQOXFJLA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 04:49:33PM +0100, Vadim Fedorenko wrote:
> > +struct mucse_dma_info {
> > +	void __iomem *dma_base_addr;
> > +	void __iomem *dma_ring_addr;
> > +	void *back;
> 
> it might be better to keep the type of back pointer and give it
> a bit more meaningful name ...
> 
> > +	u32 dma_version;
> > +};
> > +
> > +struct mucse_eth_info {
> > +	void __iomem *eth_base_addr;
> > +	void *back;
> 
> .. here ...
> 
> > +};
> > +
> > +struct mucse_mac_info {
> > +	void __iomem *mac_addr;
> > +	void *back;
> 
> and here...
> 
> > +};
> > +
> > +struct mucse_mbx_info {
> > +	/* fw <--> pf mbx */
> > +	u32 fw_pf_shm_base;
> > +	u32 pf2fw_mbox_ctrl;
> > +	u32 pf2fw_mbox_mask;
> > +	u32 fw_pf_mbox_mask;
> > +	u32 fw2pf_mbox_vec;
> > +};
> > +
> > +struct mucse_hw {
> > +	void *back;
> 
> you can also use container_of() as all these structures are embedded and
> simple pointer math can give you proper result.
> 

Got it, I will use container_of(), and remove the '*back' define.
Maybe eth to hw like this:
#define eth_to_hw(eth) container_of(eth, struct rnpgbe_hw, eth)
It is ok?

> > +	void __iomem *hw_addr;
> > +	void __iomem *ring_msix_base;
> > +	struct pci_dev *pdev;
> > +	enum rnpgbe_hw_type hw_type;
> > +	struct mucse_dma_info dma;
> > +	struct mucse_eth_info eth;
> > +	struct mucse_mac_info mac;
> > +	struct mucse_mbx_info mbx;
> > +	u32 driver_version;
> > +	u16 usecstocount;
> > +};
> > +
> >   struct mucse {
> >   	struct net_device *netdev;
> >   	struct pci_dev *pdev;
> > +	struct mucse_hw hw;
> >   	u16 bd_number;
> >   };
> 
> [...]
> 
> > +/**
> > + * rnpgbe_add_adapter - Add netdev for this pci_dev
> > + * @pdev: PCI device information structure
> > + * @info: chip info structure
> > + *
> > + * rnpgbe_add_adapter initializes a netdev for this pci_dev
> > + * structure. Initializes Bar map, private structure, and a
> > + * hardware reset occur.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> > +			      const struct rnpgbe_info *info)
> > +{
> > +	struct net_device *netdev;
> > +	void __iomem *hw_addr;
> > +	static int bd_number;
> 
> it's not clear from the patchset why do you need this static variable...
> 

Ok, bd_number seems no usefull, I will remove it.

> > +	struct mucse *mucse;
> > +	struct mucse_hw *hw;
> > +	u32 dma_version = 0;
> > +	u32 queues;
> > +	int err;
> > +
> > +	queues = info->total_queue_pair_cnts;
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	SET_NETDEV_DEV(netdev, &pdev->dev);
> > +	mucse = netdev_priv(netdev);
> > +	mucse->netdev = netdev;
> > +	mucse->pdev = pdev;
> > +	mucse->bd_number = bd_number++;
> 
> ... but this code is racy by design
> 
> > +	pci_set_drvdata(pdev, mucse);
> > +
> > +	hw = &mucse->hw;
> > +	hw->back = mucse;
> > +	hw->hw_type = info->hw_type;
> > +	hw->pdev = pdev;
> > +
> 

Thanks for your feedback.


