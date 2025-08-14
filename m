Return-Path: <linux-kernel+bounces-767805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F6B2594D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F57189BDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633C238143;
	Thu, 14 Aug 2025 01:54:04 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E11E5B9A;
	Thu, 14 Aug 2025 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136444; cv=none; b=Hg9r2KdKU9pE1ThCcfOzyxKznXZWuLp6QanGoGru027md46B54OnIT2cH+9O7MDpgPN4D4LK6jNvIeEiwUeKS6LkbS61AeMQFtYhKiSAIENFVMECkkIGos8kRpkjjcLCF/2Nl49Lc6AVWFzN9L28snuZUJHhoYUnsFSa9gDjHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136444; c=relaxed/simple;
	bh=XSvxllJ+lsccOnQGUAPGojsawqgYcBwz9/3gzuvQHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8bGK8m0sxXTZ9b04/rmKnpTeW4EKU68ZFjom+lpNQCav8KhCzwcSSKm5gb0hJPCWefNl9S41KEjdLvs2kCMT0JmPvyx94qY9vAdrtZldjI/lOTGwnPLDZizscZq9uXY5W8ZVwRdnsm4dAgdKbAB6NULyLzgUDd4bS+K8e8iDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1755136366t8d6f46ef
X-QQ-Originating-IP: eiGpyvKsWFLtyjrJNqrg67GlKWrqZZMWVLv9hkrZXpY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 09:52:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10519244942744142129
Date: Thu, 14 Aug 2025 09:52:44 +0800
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
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
Message-ID: <463679C4547B6274+20250814015244.GA1031326@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
 <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
 <B41E833713021188+20250813090405.GC965498@nic-Precision-5820-Tower>
 <354593d1-2504-407e-98fb-235fcaf61d87@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354593d1-2504-407e-98fb-235fcaf61d87@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NvjhxCSDgXICo3l+jSnna08kl9ad9o1xOmuX/fPtmOGHtXZnyjPKpfiO
	wX9Y4ScAPPEpoyqOp95jftmS2ezIeozsjhVSN0xgRiZNVyrTH/Gu86HAGPrnxzTkWDCLAv+
	9ci2lmLGO4ZspJRYW9VwUYRR2dM+PZQ2aHTA6Ij1suKuvF97DfjIUSEgEnLMb7wHjNHmHsC
	KBXXZNIGSLDcKk63ubvkt6IT3TpdjzBRfvM0EiNws9vNMpFRBElYLrdt7NdrJ7dv5fQQPMO
	JdTQnPE3kpoFR1l784pvdtwHz9+N6HFnGAs6o9l3azbc1VpYk9fxAdVwYUePQihFPpUMqq2
	Rb8RhDpCy1erPlZirCWp0QYWLFDKUxjzqOOwp5dmHLhuRhUx+88iWyjTNhsS4wUl8G7mEzD
	AIttHLfSv5NHfewXw3LfU5U4oVhgFgDmCc9ar48BdR6U2z0ApS2mdpap/NNHchLyePAEX6y
	6gSc7gc8Afcejfl5iIiiCppvHgbAlrZ8V9xK9jz/4ZV3uFVsFKN0gy/U2RtZBfgwNHMba/U
	u3oxkbaIn2rg1CWUMmYYX+FAvLIUtj7L8Jw1M14R+nyffKMp7il14WoLtGCXj4p3ymqyVj5
	BJuGkBlmST22242p5s3H+5d1LAaCDHKgs6VpwpjCGI6mykKJo0pjts695Q5HgMpriZVJ7zr
	ouk+9xDSzj7hZCKfTFSfdkwtCW4C4DWDmK2X4SIUh6v0vC6CDxF3HbA+Li36PUtuOoKR4J1
	vskhF+9WRdOtfyWO/YcXM9m4uA/5WoFg3Al7N5i2c6+x0WZaUDtMbsxDTrwAV96sW7xE/uu
	QqQLHV7y79A7fKxEUSwu0CG6xEV3L0HNbOZWvvxx7w8u3NBYkH/SxdJ133Sy2MsWYHL2OrY
	kptkpMYHMGd15YF4iAjb+btCp8xCIEnw0yiNvxexeQV9/2jIuem24ocjKo5YiSZJ0gGd2P5
	HNSesNw76veZ3N8hnczlc82hu834bVMvAynPTITkpYD9X9tTvh/SNrI8U
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:50:34PM +0100, Vadim Fedorenko wrote:
> On 13/08/2025 10:04, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 04:32:00PM +0100, Vadim Fedorenko wrote:
> > > On 12/08/2025 10:39, Dong Yibo wrote:
> > > > Initialize get mac from hw, register the netdev.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
> > > >    4 files changed, 172 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > index 6cb14b79cbfe..644b8c85c29d 100644
> > > > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > @@ -6,6 +6,7 @@
> > > >    #include <linux/types.h>
> > > >    #include <linux/mutex.h>
> > > > +#include <linux/netdevice.h>
> > > >    extern const struct rnpgbe_info rnpgbe_n500_info;
> > > >    extern const struct rnpgbe_info rnpgbe_n210_info;
> > > > @@ -86,6 +87,18 @@ struct mucse_mbx_info {
> > > >    	u32 fw2pf_mbox_vec;
> > > >    };
> > > > +struct mucse_hw_operations {
> > > > +	int (*init_hw)(struct mucse_hw *hw);
> > > > +	int (*reset_hw)(struct mucse_hw *hw);
> > > > +	void (*start_hw)(struct mucse_hw *hw);
> > > > +	void (*init_rx_addrs)(struct mucse_hw *hw);
> > > > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > > > +};
> > > > +
> > > > +enum {
> > > > +	mucse_driver_insmod,
> > > > +};
> > > > +
> > > >    struct mucse_hw {
> > > >    	void *back;
> > > >    	u8 pfvfnum;
> > > > @@ -96,12 +109,18 @@ struct mucse_hw {
> > > >    	u32 axi_mhz;
> > > >    	u32 bd_uid;
> > > >    	enum rnpgbe_hw_type hw_type;
> > > > +	const struct mucse_hw_operations *ops;
> > > >    	struct mucse_dma_info dma;
> > > >    	struct mucse_eth_info eth;
> > > >    	struct mucse_mac_info mac;
> > > >    	struct mucse_mbx_info mbx;
> > > > +	u32 flags;
> > > > +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
> > > >    	u32 driver_version;
> > > >    	u16 usecstocount;
> > > > +	int lane;
> > > > +	u8 addr[ETH_ALEN];
> > > > +	u8 perm_addr[ETH_ALEN];
> > > 
> > > why do you need both addresses if you have this info already in netdev?
> > > 
> > 
> > 'perm_addr' is address from firmware (fixed, can't be changed by user).
> > 'addr' is the current netdev address (It is Initialized the same with
> > 'perm_addr', but can be changed by user)
> > Maybe I should add 'addr' in the patch which support ndo_set_mac_address?
> 
> But why do you need 'addr' at all? Current netdev address can be
> retrieved from netdev, why do you need to store it within driver's
> structure?
> 
> 

Ok, I will remove addr and use netdev->dev_addr if driver use it.


