Return-Path: <linux-kernel+bounces-740243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35833B0D1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4A51AA5B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D828C2B2;
	Tue, 22 Jul 2025 06:22:37 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20128A705;
	Tue, 22 Jul 2025 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165356; cv=none; b=WqyemZZagFq1SpzdT/bYQ15ULX2zZntIYzQBONyGAP/DM3hVNHDkPcJkSbSXUfEXF76q1NTic5/5OW9Dq+OUVFXgdibWHczuUQiR29QOKk+JfwrSE5iLCXnPw6993i+1M2Qx1iz6eKCO7DEFL8O95gqwg3sZP2/hhBvu69r+M1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165356; c=relaxed/simple;
	bh=bm/0DewNWhRUjoUqr0+r7OAExtR9mkSYTE/5p7SKNtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTds+5tXvf58OSS6fMvuOG9/EKIQMKm7NpqNcx0NhZxUQn8EmawiB7tPAtxZI0ZDTJEdBVduQEf3y4ySzLnInkDJvTSaiZJel9pPU1+Qs2zkk+1WKXbas+Fn5kNAd/6RzDNqXKsn4YDp9yhFmeHKAdpQ1WzT6T7bTK6Nvp4uhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1753165282t2f934e90
X-QQ-Originating-IP: Srug0ruEEZGlFgQJ0LPW05zAj9t45SjKes719PTSLlM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:21:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10154226307366438883
Date: Tue, 22 Jul 2025 14:21:20 +0800
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
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <8E12C5B26514F60A+20250722062120.GB99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
 <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NoSKVpKsmOWesV+FnIEmHdSWLr2JY8qJuGN9uen2GwisVj8PTh13maXl
	IJOHnwzhzXr6o+Pqoqtcm8+oTnutUaBPM6tvNW4nOpUDctanYpJx4bdJXMxXrDBzNjqyxK6
	h52xxqHxJvOqi6/aAhd3tKPVmQQ4PymfepwuwZJ++c5OSSvfTuGF0DKB/pvG9ZaqTh/iqlK
	YDPRynBXlQuX9LVoGw1qGrLfOq4214wQnG1Zmr7x3n6fu6CBrIabiBhNxiJQHX0xU6Gwf/P
	6gdr4VyWTx+8zicrWdLCIbnT0xz/qv44atP7kUDuFuQFSVHm6sp/86Ax4iLM2a2KNgU0Nuy
	iFVmDDdwggvEW4/vsNRrcq2RYJ+/LsWGj2RK6tCYpHHP1kWYmjEuWwBfrXtbddr8eAUKndy
	EjfHjowGBPuSkWSx31TiswEN1i8fpZrP+hKhms2EXCfyJJEpj99WvdhFKQt4LymwGTVjc+D
	OY59jOby2JL46AUlO7JaapIrTQJjmrNYcfKTs7O/Fwur3tGKuMrCqo2Ax2Is2cyv2azalGz
	3Dl8a0Ixmctm58bfljTKszH/SNE9sem28uWiCsq+7QQgUN+H7vDCiNpyVgoJCEGuVilzQ2w
	NBF/V+Koeb7aNbqamxgkHjnq9bH+GW+soFF9ZHZmnVS40awdr2/FN9VKDlWkZF1rf5o1HQM
	nwYgZBERB8A5m6eg3FUUCZ3gndBUxPeUJywNubACQmcYfXQkFNrX+WyyoL3GgRBnXjpBjlW
	EuUTLIqj8GkoLwpY7iTOqtMaKTu+DmSEOqUEMFtCpNVBHCFB7tFZtdBZo5Va1J5VcJQNzeB
	Uqb4irTCXIL7L80HVVFAxJxC5YBRW5fdeVy2tkS2daihE9iErz+wRAYAvKMzDOpYv+Fn58I
	IQKSraKUg6l73mWYgnhs6jZDFgCk8C4Bxfz5KKU7Sc+H3/GQqnqkObvNXdaBeSoV5LNvjkL
	HYN6d6bMT4E/sBlPjFlK1NpXTjjizyrwQGrhBQiGTepc7xBEjI3NGeg2+nuQE4hVWrGmL3B
	TYaZbOUg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 05:25:12PM +0200, Andrew Lunn wrote:
> > +struct mii_regs {
> > +	unsigned int addr; /* MII Address */
> > +	unsigned int data; /* MII Data */
> > +	unsigned int addr_shift; /* MII address shift */
> > +	unsigned int reg_shift; /* MII reg shift */
> > +	unsigned int addr_mask; /* MII address mask */
> > +	unsigned int reg_mask; /* MII reg mask */
> > +	unsigned int clk_csr_shift;
> > +	unsigned int clk_csr_mask;
> > +};
> 
> So MII interests me, being the MDIO/PHY maintainer....
> 
> You have introduced this without any user, which is not good, so i
> cannot see how it is actually used. It is better to introduce
> structures in the patch which makes use of them.
> 
> Please add this only when you add the mdiobus driver, so i can see how
> it is used. Please look at the other structures you have here. Please
> add them as they are actually used.
> 

Yes, you are right, I should add the structures when they are actually
used. I will improve it.

> > +struct mucse_hw {
> > +	void *back;
> > +	u8 pfvfnum;
> > +	u8 pfvfnum_system;
> > +	u8 __iomem *hw_addr;
> > +	u8 __iomem *ring_msix_base;
> 
> I spotted this somewhere else. A u8 __iomem * is odd. Why is this not
> a void *? ioremap() returns a void __iomem *, and all the readb(),
> readw(), readX() functions expect a void * __iomem. So this looks odd.
> 

Got it, I will change it. I just consider the wrong cast before. Sorry
for not check this define error.

> > +#define m_rd_reg(reg) readl(reg)
> > +#define m_wr_reg(reg, val) writel((val), reg)
> 
> Please don't wrap standard functions like this. Everybody knows what
> readl() does. Nobody has any idea what m_rd_reg() does! You are just
> making your driver harder to understand and maintain.
> 

Got it.

> > +	mac->mii.addr = RNPGBE_MII_ADDR;
> > +	mac->mii.data = RNPGBE_MII_DATA;
> > +	mac->mii.addr_shift = 11;
> > +	mac->mii.addr_mask = 0x0000F800;
> 
> GENMASK()? If you are using these helpers correctly, you probably
> don't need the _shift members.
> 
> > +	mac->mii.reg_shift = 6;
> > +	mac->mii.reg_mask = 0x000007C0;
> > +	mac->mii.clk_csr_shift = 2;
> > +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > +	mac->clk_csr = 0x02; /* csr 25M */
> > +	/* hw fixed phy_addr */
> > +	mac->phy_addr = 0x11;
> 
> That is suspicious. But until i see the PHY handling code, it is hard
> to say.
> 

Those code should move to the patch which really use it.

> > +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	/* get invariants based from n500 */
> > +	rnpgbe_get_invariants_n500(hw);
> > +
> > +	/* update msix base */
> > +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> > +	/* update mbx offset */
> > +	mbx->vf2pf_mbox_vec_base = 0x29200;
> > +	mbx->fw2pf_mbox_vec = 0x29400;
> > +	mbx->pf_vf_shm_base = 0x29900;
> > +	mbx->mbx_mem_size = 64;
> > +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> > +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> > +	mbx->pf_vf_mbox_mask_hi = 0;
> > +	mbx->fw_pf_shm_base = 0x2d900;
> > +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> > +	mbx->fw_pf_mbox_mask = 0x2eb00;
> > +	mbx->fw_vf_share_ram = 0x2b900;
> > +	mbx->share_size = 512;
> > +	/* update hw feature */
> > +	hw->feature_flags |= M_HW_FEATURE_EEE;
> > +	hw->usecstocount = 62;
> 
> This variant does not have an MDIO bus?
> 

Some hw capabilies, such as queue numbers and hardware module 
reg-offset(dma_base_addr, eth_base_addr ..) in this function. Don't
have an MDIO bus now.

> > +#define RNPGBE_RING_BASE (0x1000)
> > +#define RNPGBE_MAC_BASE (0x20000)
> > +#define RNPGBE_ETH_BASE (0x10000)
> 
> Please drop all the () on plain constants. You only need () when it is
> an expression.
> 

Got it, I will fix this.

> > +			      const struct rnpgbe_info *ii)
> 
> I don't really see how the variable name ii has anything to do with
> rnpgbe_info. I know naming is hard, but why not call it info?
> 
> 

Got it, ii is unclear, I will use info instead.

> >  {
> >  	struct mucse *mucse = NULL;
> > +	struct mucse_hw *hw = NULL;
> > +	u8 __iomem *hw_addr = NULL;
> >  	struct net_device *netdev;
> >  	static int bd_number;
> > +	u32 dma_version = 0;
> > +	int err = 0;
> > +	u32 queues;
> >  
> > -	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> > +	queues = ii->total_queue_pair_cnts;
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> 
> I pointed out this before. Try to avoid changing code added in
> previous patches. I just wasted time looking up what the function is
> called which allocates a single queue, and writing a review comment.
> 
> Waiting reviewers time is a good way to get less/slower reviews.
> 
> 	Andrew
> 

Yes, I got it before, and I really tried to improve my code.
But this is really hard to avoid here. 'queues' is from ii->total_queue_pair_cnts
which is added in patch2. Maybe I should move the alloc_etherdev_mq to
patch2, never use it in patch1? And this conditon can improve.

thanks for your feedback.


