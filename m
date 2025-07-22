Return-Path: <linux-kernel+bounces-740689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C4B0D7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6883A8FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975542BEFE4;
	Tue, 22 Jul 2025 11:10:52 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9F1EC018;
	Tue, 22 Jul 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182652; cv=none; b=okc407V9xLmDcZG7hbHKuJAvCzt7T1mjiW9ipQDr6tkyDV3LrQOWGvAhebv388olaRAW/F8yH8ajCFmKUTLU27EFxN4ky17LTPRITno8rpK7hAppeSxf1bj3z3GiPyV4wMnVW5QU9WOgg49hp37ZXmoBMzHtGsQtm8JpKROH8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182652; c=relaxed/simple;
	bh=V01CpwPhoYRMkgTbnuw9OB2Maccg5FkbrxzKPuX1L7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmVCPhUBqggKc8OO1O2BNoWM80sewefycMQeWLVC1EN9u8XkAr4AnGcT6O5GsR5OeE8dLgSj/VEa0KBdHAnlAxrH6huBU78dWDuBU50k2yjCQB9nfvRkJGXiAarILwG1tYvSZ6rbl3Afw+bNQ5GJHHcqCMqkEiaYQpce+23v/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1753182582t50d83c8d
X-QQ-Originating-IP: qS7gnAFAEUU6fV4kYj+XcTJ/fX7x++qnIxygmFN6+r4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 19:09:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10533247899007251616
Date: Tue, 22 Jul 2025 19:09:39 +0800
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
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <CE56210DD2A0C069+20250722110939.GB125862@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
 <b4233af1-7143-402b-a45c-379c39edf274@linux.dev>
 <911D202AA380FB7F+20250722095159.GA120552@nic-Precision-5820-Tower>
 <fc0d3fa9-67a8-4ac7-a213-283e2971227d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0d3fa9-67a8-4ac7-a213-283e2971227d@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NhIN2Vt8iz3RXZ6M6bnQabcBjnKOW+zAXGuyaiRs4q5utkloErK+dbf2
	RPwhlPq9fXjhobVwkBuTYbws/e/WVcS8EBO32kH3tLoNFxc/Zm3z7IitfMfNyoQ0yHjZlXa
	jXfwCGLszc9a9AFgGVl1oMzXZR/Wy+HAx+xmwpIDBRN6M7MJWdkXrERqbR3fkGSdxneNDMA
	LvXDvXefdOqrPxJrXBexEtrhJiEBdxrUrQFeZJM0OFHa531D8M+U8lgUQ1KytPVRxCZlUK4
	I/OSgVLC7fivPoBvhYxDeNIbASi7GTgkJKIwoIM1hOLnegpACiWrUaio5LE8LR6G3WippBO
	v0/U43fp3gqixRVV/2q2ppiL9AfUnp8zu/9coHIFja9UGgsGBZazVeqLMB+YV40f5JsZELb
	BpGbGtl3sXN12gD8Ejrj4ctj5nbJ5x1PaxMUnFuKqinptDl/fpwRxk8HdA+t8T8DZYw9hiT
	PVTT3+xkpeABRrG5aEHst6o4W3sW4OmD4lxfhJNR4Dj7rczTUUdsb5VW22S/rTTviyBaCrq
	JKcIqBmQ7PKjv+CjKVso5fireDUYxYAXjm3yy4pEJCmgv38DgM7S+jVCvxUfh8E14WiHy7O
	TUN7cr3PTI5u5Fwriwf5KH6D70WIlRbwpxBK59V5bg1R04Af5WDm2LahVZYFUcJIcIO6wgy
	T4YKG2GPg42yOzsTrtS26/CvEeiq/udbzZHuSe5CfGnPzozutVkgSFqmgaXNk1kJJQi5VIA
	Aj8ykuGgDccBpg8Di6OcfTOfJuCFf6S32klSpySRVuz89tb5j/WuUOwskR5wMVbZqWlGLCk
	0u6m9Ic5csJwNvNW8kvRJRQYc35xQOw478aemLVnkqt2eOscWvndNp04TvyTn0stnUmZ0vc
	vj7V4t6e2jiLvWuQRU7bX1FbPeFGq0kaD58qm8ztuobvmxhIMkFCURXV2b9+ONwX9yxhrr0
	HAYjn29DaDR54s6UMDagHJ4mZVSw2vpLGINwCaAo0voBoonVM1VEt3iAtwBbpYM4JXjLXSa
	k5ZiBDaD6/EbuG0YMywkb0e22aC9C2RAHatPZmIUfvfwOrGU79m++OaYuU46E=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 11:26:44AM +0100, Vadim Fedorenko wrote:
> On 22/07/2025 10:51, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 03:21:23PM +0100, Vadim Fedorenko wrote:
> > > On 21/07/2025 12:32, Dong Yibo wrote:
> > > > Initialize n500/n210 chip bar resource map and
> > > > dma, eth, mbx ... info for future use.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> > > >    drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 138 ++++++++++++++++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 138 ++++++++++++++++++
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  27 ++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  68 ++++++++-
> > > >    5 files changed, 370 insertions(+), 5 deletions(-)
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > > > 
> 
> [...]
> 
> > > > +/**
> > > > + * rnpgbe_get_invariants_n500 - setup for hw info
> > > > + * @hw: hw information structure
> > > > + *
> > > > + * rnpgbe_get_invariants_n500 initializes all private
> > > > + * structure, such as dma, eth, mac and mbx base on
> > > > + * hw->addr for n500
> > > > + **/
> > > > +static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_dma_info *dma = &hw->dma;
> > > > +	struct mucse_eth_info *eth = &hw->eth;
> > > > +	struct mucse_mac_info *mac = &hw->mac;
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +
> > > > +	/* setup msix base */
> > > > +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> > > > +	/* setup dma info */
> > > > +	dma->dma_base_addr = hw->hw_addr;
> > > > +	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
> > > > +	dma->max_tx_queues = RNPGBE_MAX_QUEUES;
> > > > +	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
> > > > +	dma->back = hw;
> > > > +	/* setup eth info */
> > > > +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> > > > +	eth->back = hw;
> > > > +	eth->mc_filter_type = 0;
> > > > +	eth->mcft_size = RNPGBE_MC_TBL_SIZE;
> > > > +	eth->vft_size = RNPGBE_VFT_TBL_SIZE;
> > > > +	eth->num_rar_entries = RNPGBE_RAR_ENTRIES;
> > > > +	/* setup mac info */
> > > > +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> > > > +	mac->back = hw;
> > > > +	/* set mac->mii */
> > > > +	mac->mii.addr = RNPGBE_MII_ADDR;
> > > > +	mac->mii.data = RNPGBE_MII_DATA;
> > > > +	mac->mii.addr_shift = 11;
> > > > +	mac->mii.addr_mask = 0x0000F800;
> > > > +	mac->mii.reg_shift = 6;
> > > > +	mac->mii.reg_mask = 0x000007C0;
> > > > +	mac->mii.clk_csr_shift = 2;
> > > > +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > > > +	mac->clk_csr = 0x02; /* csr 25M */
> > > > +	/* hw fixed phy_addr */
> > > > +	mac->phy_addr = 0x11;
> > > > +
> > > > +	mbx->mbx_feature |= MBX_FEATURE_NO_ZERO;
> > > > +	/* mbx offset */
> > > > +	mbx->vf2pf_mbox_vec_base = 0x28900;
> > > > +	mbx->fw2pf_mbox_vec = 0x28b00;
> > > > +	mbx->pf_vf_shm_base = 0x29000;
> > > > +	mbx->mbx_mem_size = 64;
> > > > +	mbx->pf2vf_mbox_ctrl_base = 0x2a100;
> > > > +	mbx->pf_vf_mbox_mask_lo = 0x2a200;
> > > > +	mbx->pf_vf_mbox_mask_hi = 0;
> > > > +	mbx->fw_pf_shm_base = 0x2d000;
> > > > +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> > > > +	mbx->fw_pf_mbox_mask = 0x2e200;
> > > > +	mbx->fw_vf_share_ram = 0x2b000;
> > > > +	mbx->share_size = 512;
> > > > +
> > > > +	/* setup net feature here */
> > > > +	hw->feature_flags |= M_NET_FEATURE_SG |
> > > > +			     M_NET_FEATURE_TX_CHECKSUM |
> > > > +			     M_NET_FEATURE_RX_CHECKSUM |
> > > > +			     M_NET_FEATURE_TSO |
> > > > +			     M_NET_FEATURE_VLAN_FILTER |
> > > > +			     M_NET_FEATURE_VLAN_OFFLOAD |
> > > > +			     M_NET_FEATURE_RX_NTUPLE_FILTER |
> > > > +			     M_NET_FEATURE_RX_HASH |
> > > > +			     M_NET_FEATURE_USO |
> > > > +			     M_NET_FEATURE_RX_FCS |
> > > > +			     M_NET_FEATURE_STAG_FILTER |
> > > > +			     M_NET_FEATURE_STAG_OFFLOAD;
> > > > +	/* start the default ahz, update later */
> > > > +	hw->usecstocount = 125;
> > > > +}
> > > > +
> > > > +/**
> > > > + * rnpgbe_get_invariants_n210 - setup for hw info
> > > > + * @hw: hw information structure
> > > > + *
> > > > + * rnpgbe_get_invariants_n210 initializes all private
> > > > + * structure, such as dma, eth, mac and mbx base on
> > > > + * hw->addr for n210
> > > > + **/
> > > > +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	/* get invariants based from n500 */
> > > > +	rnpgbe_get_invariants_n500(hw);
> > > 
> > > it's not a good pattern. if you have some configuration that is
> > > shared amoung devices, it's better to create *base() or *common()
> > > helper and call it from each specific initializer. BTW, why do you
> > > name these functions get_invariants*()? They don't get anything, but
> > > rather init/setup configuration values. It's better to rename it
> > > according to the function.
> > > 
> > 
> > I try to devide hardware to dma, eth, mac, mbx modules. Different
> > chips may use the same mbx module with different reg-offset in bar.
> > So I setup reg-offset in get_invariants for each chip. And common code,
> > such as mbx achieve functions with the reg-offset.
> > Ok, I will rename it.
> 
> I fully understand your intention. My point is that calling
> rnpgbe_get_invariants_n500(hw) in rnpgbe_get_invariants_n210() and
> then replace almost half of the values is not a good pattern.
> It's better to have another function to setup values that are the same
> across models, and keep only specifics in *n500() and *n210().
> 

Got your point, I will improve it.

> > 
> > > > +
> > > > +	/* update msix base */
> > > > +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> > > > +	/* update mbx offset */
> > > > +	mbx->vf2pf_mbox_vec_base = 0x29200;
> > > > +	mbx->fw2pf_mbox_vec = 0x29400;
> > > > +	mbx->pf_vf_shm_base = 0x29900;
> > > > +	mbx->mbx_mem_size = 64;
> > > > +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> > > > +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> > > > +	mbx->pf_vf_mbox_mask_hi = 0;
> > > > +	mbx->fw_pf_shm_base = 0x2d900;
> > > > +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> > > > +	mbx->fw_pf_mbox_mask = 0x2eb00;
> > > > +	mbx->fw_vf_share_ram = 0x2b900;
> > > > +	mbx->share_size = 512;
> > > > +	/* update hw feature */
> > > > +	hw->feature_flags |= M_HW_FEATURE_EEE;
> > > > +	hw->usecstocount = 62;
> > > > +}
> 
> [...]
> 
> > > > @@ -58,7 +72,54 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > > >    		 rnpgbe_driver_name, mucse->bd_number);
> > > >    	pci_set_drvdata(pdev, mucse);
> > > > +	hw = &mucse->hw;
> > > > +	hw->back = mucse;
> > > > +	hw->hw_type = ii->hw_type;
> > > > +
> > > > +	switch (hw->hw_type) {
> > > > +	case rnpgbe_hw_n500:
> > > > +		/* n500 use bar2 */
> > > > +		hw_addr = devm_ioremap(&pdev->dev,
> > > > +				       pci_resource_start(pdev, 2),
> > > > +				       pci_resource_len(pdev, 2));
> > > > +		if (!hw_addr) {
> > > > +			dev_err(&pdev->dev, "map bar2 failed!\n");
> > > > +			return -EIO;
> > > > +		}
> > > > +
> > > > +		/* get dma version */
> > > > +		dma_version = m_rd_reg(hw_addr);
> > > > +		break;
> > > > +	case rnpgbe_hw_n210:
> > > > +	case rnpgbe_hw_n210L:
> > > > +		/* check bar0 to load firmware */
> > > > +		if (pci_resource_len(pdev, 0) == 0x100000)
> > > > +			return -EIO;
> > > > +		/* n210 use bar2 */
> > > > +		hw_addr = devm_ioremap(&pdev->dev,
> > > > +				       pci_resource_start(pdev, 2),
> > > > +				       pci_resource_len(pdev, 2));
> > > > +		if (!hw_addr) {
> > > > +			dev_err(&pdev->dev, "map bar2 failed!\n");
> > > > +			return -EIO;
> > > > +		}
> > > > +
> > > > +		/* get dma version */
> > > > +		dma_version = m_rd_reg(hw_addr);
> > > > +		break;
> > > > +	default:
> > > > +		err = -EIO;
> > > > +		goto err_free_net;
> > > > +	}
> > > > +	hw->hw_addr = hw_addr;
> > > > +	hw->dma.dma_version = dma_version;
> > > > +	ii->get_invariants(hw);
> > > > +
> > > >    	return 0;
> > > > +
> > > > +err_free_net:
> > > > +	free_netdev(netdev);
> > > > +	return err;
> > > >    }
> > > 
> > > You have err_free_net label, which is used only in really impossible
> > > case of unknown device, while other cases can return directly and
> > > memleak netdev...>>
> > 
> > Yes, It is really impossible case of unknown device. But maybe switch
> > should always has 'default case'? And if in 'default case', nothing To
> > do but free_netdev and return err.
> > Other cases return directly with return 0, and netdev will be freed in
> > rnpgbe_rm_adapter() when rmmod. Sorry, I may not have got the memleak
> > point?
> 
> Both rnpgbe_hw_n500 and rnpgbe_hw_n200 cases have error paths which
> directly return -EIO. In this case netdev is not freed and
> rnpgbe_rm_adapter() will not happen as rnpgbe_add_adapter() didn't
> succeed.
> 
> 

Yes, you are right, memleak may happen here, I will fix it.

Thanks for your feedback.
> > 
> > > >    /**
> > > > @@ -74,6 +135,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > > >     **/
> > > >    static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >    {
> > > > +	const struct rnpgbe_info *ii = rnpgbe_info_tbl[id->driver_data];
> > > >    	int err;
> > > >    	err = pci_enable_device_mem(pdev);
> > > > @@ -97,7 +159,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >    	pci_set_master(pdev);
> > > >    	pci_save_state(pdev);
> > > > -	err = rnpgbe_add_adapter(pdev);
> > > > +	err = rnpgbe_add_adapter(pdev, ii);
> > > >    	if (err)
> > > >    		goto err_regions;
> > > 
> > > 
> > 
> > Thanks for your feedback.
> > 
> 
> 

