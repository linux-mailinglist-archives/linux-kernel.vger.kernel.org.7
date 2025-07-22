Return-Path: <linux-kernel+bounces-740135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 127AFB0D068
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D3D188B70A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97528B408;
	Tue, 22 Jul 2025 03:40:00 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D61E377F;
	Tue, 22 Jul 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155600; cv=none; b=uRabKMFsUlVDGBKUg5N3+F4+aSa/Vftt6SsafTh7dSevPMolAcia2sDRG7wOMGdui37nigCxmREB8tmfH3RU8tZDQxtYsYw0qBAJYA78dI5x5dF15Z0GzIzcGntQ3La78GQeFoK2j7heewAIUnaBlcF4gklCd+hYLhpigOn/I0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155600; c=relaxed/simple;
	bh=CvelI9zXSMjW54GHbS7XiMPu4D8m9MuULB9676cVDHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsJYZG7hFM5vjLOYDZA2DYT+HvyW++oHKSINUX+0zv9WwqKHQrxb6cumgVS2uzW0kynaKLAH5DdUhbuctqyC8N6g8pEvE46doWEqG/lBkiulevqtPVoOPEomOsMDSShaF/raGYYO+F384ati/iIr3ESuaNVQZIxEH4TTRGkbOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1753155523t60719c4b
X-QQ-Originating-IP: rGKK2gBVdzPN5TgvQBUmot4Rr8VPOlaWYRddqIOqpEU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 11:38:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8527283144807688706
Date: Tue, 22 Jul 2025 11:38:41 +0800
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
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <146B634370ED44A0+20250722033841.GB96891@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NnKWXRC3r3tSeHicja5ZfNcjnZcnve0sztjrifvan22m7o1FV36dOuoH
	LMpxZCscL/oaASBTAt6dV9zj1+EbTLd8KTg4cu+iJ6gBf5PY+oA/EXfRMYZsjJiGzReW9UT
	9bt2PundAKe9zy5GCh6O4sb25ofs3MYq9vgPfRNHTKW2rhabfL+iWp9NEV9CfrKbKV6gWYm
	eqKxeDCeua/PZcbJEnn/SjZZo+2pGqKCRPQvpm5pAwLAK3MLf1d4gN7g+w0QSmHw518egmf
	rsgIXykUXUQ0Eh0xTDxWM/K+UtXKnaM0E7CRlsjcg8NchFmnO+biOABo295MiAa/64bfnZB
	ajVCUYkW7hlHP25UXjEBnE1XM3YZ0i+e6bLD7YMeYJ/YQWNrU+Ja4gst92GSvQNCKFC2l1T
	KIdyEJEnrmv9GVaDHz3jd4BaTWfYnQNBxMBD1qPHM/aKeAqIsHCE/cC48LAF2UfpMKqyOOS
	tkB6Bf767SEWBMHyNyIiUlq6V1wehX2eLMP80znDgYkLHGiEPPuO4CImpVLC6JqzJa/ZudF
	fO7QEOihVUKBRlIcjlF+LCS+gUGv9ObxfARwA+REyPbTyK0klrNEwIPeswIkElvcY0A/g9j
	eLxDiR1duxVJ0oBKYvIAW3xHEybZCYnvt9B5OZOhngchv7JIp521NOIb3ZTMN97LR7RLTPR
	NGO3vPadNr4Xd1KZY3UtndaoxrrQpEAFIWVeO/5nv/Wmy1bZHqxE6DpvWHuXnHbXxh3hVmb
	PRP5uZCOjND9J+FjQuj5yjfG0H+54SaaFFBdNzWgg3Np06v0XCFYyBOcDxXwf8aLNR9r8tu
	hZe+N+csh00Buojfn1owJ6jBwBpdFsEIDre8ntn4Zqd6omRy5Lgpjh8SNgBx8Fylvf/Mpc7
	6PoetLzFhUQwv0ESrkgATGBnr3gULX0KUEStt2t3XO8y7D8GC39P7DjWk1heS1rLbgKNjky
	OuN20M4+TwiddE0b5VoWzdwzVSiX6XO575wOUTbedlQslFIIce1JHI7qjOvir+KkSqWs9Nm
	HdFViDKg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 04:55:02PM +0200, Andrew Lunn wrote:
> > +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> > @@ -61,6 +61,7 @@ Contents:
> >     wangxun/txgbevf
> >     wangxun/ngbe
> >     wangxun/ngbevf
> > +   mucse/rnpgbe
> 
> This list is sorted. Please keep with the order.
> 
> Sorting happens all other the kernel. Please keep an eye out of it,
> and ensure you insert into the correct location.
> 

Got it, I will fix this.

> > +++ b/drivers/net/ethernet/Kconfig
> > @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
> >  source "drivers/net/ethernet/wiznet/Kconfig"
> >  source "drivers/net/ethernet/xilinx/Kconfig"
> >  source "drivers/net/ethernet/xircom/Kconfig"
> > +source "drivers/net/ethernet/mucse/Kconfig"
> 
> Another sorted list.
> 

Got it.

> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/string.h>
> > +#include <linux/etherdevice.h>
> 
> It is also reasonably normal to sort includes.
> 

Got it, I will also check all other files. But what rules should be
followed? General to specific?

> > +static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > +{
> > +	struct mucse *mucse = NULL;
> > +	struct net_device *netdev;
> > +	static int bd_number;
> > +
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> 
> If you only have one queue, you might as well use alloc_etherdev().
> 

Ok, I got it.

> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	mucse = netdev_priv(netdev);
> > +	mucse->netdev = netdev;
> > +	mucse->pdev = pdev;
> > +	mucse->bd_number = bd_number++;
> > +	snprintf(mucse->name, sizeof(netdev->name), "%s%d",
> > +		 rnpgbe_driver_name, mucse->bd_number);
> 
> That looks wrong. The point of the n in snprintf is to stop you
> overwriting the end of the destination buffer. Hence you should be
> passing the length of the destination buffer, not the source buffer.
> 
> I've not looked at how mucse->name is used, but why do you need yet
> another name for the device? There is pdev->dev->name, and soon there
> will be netdev->name. Having yet another name just makes it confusing.
> 
> 	Andrew
> 

Yes, 'sizeof(netdev->name)' is wrong. Actually, mucse->name is not used,
I should remove it.

thanks for your feedback.



