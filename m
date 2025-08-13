Return-Path: <linux-kernel+bounces-766161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC0B2430B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D40A6856DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E602DEA8C;
	Wed, 13 Aug 2025 07:47:36 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD031519A0;
	Wed, 13 Aug 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071255; cv=none; b=EjY7N+n+9Vc11o2Sz1u/ILAcapiXBjnH89nZarS/ufiUZ32Xs0U2saB1w8C2GHScIMH5Wpzx7fOumjOr+1NQF6EKn1n1dt/yEXBSCwqS/jVmfVNDgaRPu2tr6kv7BrFnDLjGh2jjyo9jmdcTR89PNM80cKOMlvS6F0BJ2L2Uq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071255; c=relaxed/simple;
	bh=5jeiwACZJC//91sUyzWvft1D13hiN2I8Ag/Y/4S2LY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXsjngiGtvtuHUJlpnc3lNLXwHeVW1L9WRTYTwDMM+BdEy9nJW7dshpdpJVQHf4owtvi9ahT4L4JClWt5aLk1Qgk6Tb65JagYErNgMkVqYyjtwAYnDsyh9SQajoEAPG9Mg3wi4OmOm4QSKGN5o3H2I4mzNW2u47X2BnlXvLsrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz15t1755071184tbd45f04d
X-QQ-Originating-IP: D7wXgoZcnfh+Jsc+bkk1zhuO/ETlXGRMU4Iq6dxlGcI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 15:46:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10667824770877014471
Date: Wed, 13 Aug 2025 15:46:22 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <C5DDDB438F5F4EF9+20250813074622.GE944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
 <4f8d678a-8b72-449e-9809-bed912f26e59@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8d678a-8b72-449e-9809-bed912f26e59@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NUR2MO5QdLbj1hPL96v8wPoeC0g8wA3J66OFzQe3kAeAAxtBsHb4MlRK
	ETCD/GkXSIuq2sIJzG1wjSXydu+2opAGM+E8naF2PRTPwNfecbjmkM2nJUVUFf1yqlqn9ng
	S05p2Z/wlzEoH3jZYLFwm8dZSo3e6OyFB3/wWl8sadVik4Qx7GjLgYH3xrYAeF7p0cyTrZL
	axkTqg75aMd2BD4ELlNekP8thFlWkeVLTv7gK3l42ZqXsbrCaEhWkrAUyzvmEYcwl2vq2Wp
	+jIndiSa9VK1Jl7tujQ6XcOUPB5eKIT5iW0z386EEJtG22KUxMRUkUKyeERB1a4Xzt+UEhJ
	Cn5+j5FR0hsSsiuhAWngzYdVDVb22KH0uRygapAUlKsWVcuellKQOvWu9vEPK/r5jwAgimi
	yNEAtq5HwGrsZy9g0HaDFyY24CBQwdzf+uPNo0d/4ijvT0II6lUkLBakqpMkkG2kkZh++FV
	lVkccfBc2gNtr9vOFhru+W5970IJyn7kaaTYbHpT2yhOW5r32OVPx+ijjsswsjO1O3QUHDb
	fzEC240BaXt8/KY3g9+AaWMi9RzKkwnOzQp87t6a6sU0r+7f9aiOqeQNOF2juaCziWN/K2b
	Ur+Du7WO1ox4SPeKrl6/QGSv8E9P0xcZ+3IyXTUY+W5GI7OFrircAyxaiykGmswCZIcIvt9
	+r4lwt1M7SC8QdYk6jXRIGFjoyNQQLGfQzBNEDLf4luwbCtsr+Zi63dUUqBKR0BNH1YBG4h
	xRFddCRF3t+DxPloCFiquwF+Dkmjiz1hO65yCdUSr9wM1YGTwtdVnnCoE2N3by5fedsWQp6
	BCwZhWoqCQrbZ/xLgds3QazOH+kIfwOF0KenEIdComtE1ToZwlON7Wc4CvDplkRbvH6fWGA
	sGdjdN7joXD59792dNxClZcy1qv8TJbzWJe1/n9QbncZf23xmcQabT/tmuJ19XFJmRqrfr4
	qk+FMELSiUcSewEKXEZllUde3l1Fa6wQmZH8rh1mFNXqxlNHkq2teMN0i+ZwrZMo+uRukpz
	9gvu/8SEzHuEA1bS47BEawGglqh8wfFuP85l0tktG04HMNPjygfHetQ6C4u5H1iSHWEqOHk
	Nm3i17vfv7K07nK0LBSN4Q5F6Tob11Ik1bgKRdJKML+
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 10:00:57PM +0530, Anwar, Md Danish wrote:
> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  37 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
> >  6 files changed, 520 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 42c359f459d9..5fc878ada4b1 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -6,4 +6,5 @@
> >  
> >  obj-$(CONFIG_MGBE) += rnpgbe.o
> >  rnpgbe-objs := rnpgbe_main.o\
> > -	       rnpgbe_chip.o
> > +	       rnpgbe_chip.o\
> > +	       rnpgbe_mbx.o
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 0dd3d3cb2a4d..05830bb73d3e 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -5,6 +5,7 @@
> >  #define _RNPGBE_H
> >  
> >  #include <linux/types.h>
> > +#include <linux/mutex.h>
> >  
> >  extern const struct rnpgbe_info rnpgbe_n500_info;
> >  extern const struct rnpgbe_info rnpgbe_n210_info;
> > @@ -40,7 +41,43 @@ struct mucse_mac_info {
> >  	void *back;
> >  };
> >  
> > +struct mucse_hw;
> > +
> > +struct mucse_mbx_operations {
> > +	void (*init_params)(struct mucse_hw *hw);
> > +	int (*read)(struct mucse_hw *hw, u32 *msg,
> > +		    u16 size);
> > +	int (*write)(struct mucse_hw *hw, u32 *msg,
> > +		     u16 size);
> > +	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> > +			   u16 size);
> > +	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> > +			    u16 size);
> > +	int (*check_for_msg)(struct mucse_hw *hw);
> > +	int (*check_for_ack)(struct mucse_hw *hw);
> > +	void (*configure)(struct mucse_hw *hw, int num_vec,
> > +			  bool enable);
> > +};
> > +
> > +struct mucse_mbx_stats {
> > +	u32 msgs_tx;
> > +	u32 msgs_rx;
> > +	u32 acks;
> > +	u32 reqs;
> > +	u32 rsts;
> > +};
> > +
> >  struct mucse_mbx_info {
> > +	const struct mucse_mbx_operations *ops;
> > +	struct mucse_mbx_stats stats;
> > +	u32 timeout;
> > +	u32 usec_delay;
> > +	u16 size;
> > +	u16 fw_req;
> > +	u16 fw_ack;
> > +	/* lock for only one use mbx */
> > +	struct mutex lock;
> > +	bool irq_enabled;
> >  	/* fw <--> pf mbx */
> >  	u32 fw_pf_shm_base;
> >  	u32 pf2fw_mbox_ctrl;
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 20ec67c9391e..16d0a76114b5 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -1,8 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> >  
> > +#include <linux/string.h>
> > +
> >  #include "rnpgbe.h"
> >  #include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> >  
> >  /**
> >   * rnpgbe_init_common - Setup common attribute
> > @@ -23,6 +26,8 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
> >  
> >  	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> >  	mac->back = hw;
> > +
> > +	hw->mbx.ops = &mucse_mbx_ops_generic;
> >  }
> >  
> >  /**
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index fc57258537cf..aee037e3219d 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -7,6 +7,8 @@
> >  #define RNPGBE_RING_BASE 0x1000
> >  #define RNPGBE_MAC_BASE 0x20000
> >  #define RNPGBE_ETH_BASE 0x10000
> > +/**************** DMA Registers ****************************/
> > +#define RNPGBE_DMA_DUMY 0x000c
> >  /**************** CHIP Resource ****************************/
> >  #define RNPGBE_MAX_QUEUES 8
> >  #endif /* _RNPGBE_HW_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > new file mode 100644
> > index 000000000000..1195cf945ad1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > @@ -0,0 +1,443 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_mbx.h"
> > +#include "rnpgbe_hw.h"
> > +
> > +/**
> > + * mucse_read_mbx - Reads a message from the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	/* limit read size */
> > +	min(size, mbx->size);
> > +	return mbx->ops->read(hw, msg, size);
> > +}
> 
> What's the purpose of min() here if you are anyways passing size to read()?
> 
> The min() call needs to be assigned to size, e.g.: size = min(size,
> mbx->size);
> 

Yes, I will fix this error.

> > +
> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> 
> > +
> > +/**
> > + * mucse_mbx_reset - Reset mbx info, sync info from regs
> > + * @hw: pointer to the HW structure
> > + *
> > + * This function reset all mbx variables to default.
> > + **/
> > +static void mucse_mbx_reset(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int v;
> > +
> 
> Variable 'v' should be declared as u32 to match the register read.
> 

Got it, I will fix it.

> > +	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +	hw->mbx.fw_req = v & GENMASK(15, 0);
> > +	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +}
> > +
> > +/**
> > + * mucse_mbx_configure_pf - Configure mbx to use nr_vec interrupt
> > + * @hw: pointer to the HW structure
> > + * @nr_vec: vector number for mbx
> > + * @enable: TRUE for enable, FALSE for disable
> > + *
> > + * This function configure mbx to use interrupt nr_vec.
> > + **/
> > +static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
> > +				   bool enable)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 v;
> > +
> > +	if (enable) {
> > +		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> > +		hw->mbx.fw_req = v & GENMASK(15, 0);
> > +		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> > +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
> > +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> > +	} else {
> > +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
> > +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> > +		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
> > +	}
> > +}
> > +
> > +/**
> > + * mucse_init_mbx_params_pf - Set initial values for pf mailbox
> > + * @hw: pointer to the HW structure
> > + *
> > + * Initializes the hw->mbx struct to correct values for pf mailbox
> > + */
> > +static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->usec_delay = 100;
> > +	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
> 
> Use appropriate constants like USEC_PER_SEC instead of hardcoded values.
> 

Ok, I will update it.

> > +	mbx->stats.msgs_tx = 0;
> > +	mbx->stats.msgs_rx = 0;
> 
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.

