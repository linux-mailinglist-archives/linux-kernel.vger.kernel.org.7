Return-Path: <linux-kernel+bounces-778870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FDB2EC41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4725A821E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6325D1FC;
	Thu, 21 Aug 2025 03:44:36 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3A1A2C0B;
	Thu, 21 Aug 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747876; cv=none; b=GfJuCueAmon7RHGYGY94BT/WNA7Znh3AR4bL4O5nKwmYaPGxaI6ljwPC8S3mvRL8/AWtHGqg/3lbMWZU+c+Wo0i98EaS6J1qoExz2WegS9koXJml01HMIVdCypEsCUSfeBOKWiqUlYH4J2rNX6R50xu01h19GyzosvdeYXXBbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747876; c=relaxed/simple;
	bh=RyXJIjGQgBc3po6jjxW8jkV5efFNpfWOL8tbG5Mu6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjpaMavw5AjkMzl7HIlhfHj5TWBRIfVOzGNp6CGGkRe0ZI3aTtL8pGizXxNUvMUjfZoagCPcEVxqrEGSWKg9sRPg65upQK3LHhWmQcNGjcc1zCAM0oZrVwjWc1WFkBp/uTmbJIoiaBdQRtoI74fQjLO3mRNDBSYa7cZfjSlOmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1755747812t3cdede6a
X-QQ-Originating-IP: /PIIUZV9tLa4lzulq/S6d4ZgXhpMQyylT/75u3kv3Hs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:43:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17795680503353605927
Date: Thu, 21 Aug 2025 11:43:31 +0800
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
Subject: Re: [PATCH v5 5/5] net: rnpgbe: Add register_netdev
Message-ID: <7F14A04FE9C40F1A+20250821034331.GB1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-6-dong100@mucse.com>
 <c37ee9e7-53de-4c21-b0cb-4cfb0936bc1e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37ee9e7-53de-4c21-b0cb-4cfb0936bc1e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N1GwrkiB7FDZQmygpdP7EBd9LEZPjkl6RclOexlIjBJqFnRM0dfFYdqK
	hiG/17M1CV3rhVEpnNYyR9rQGt+TpbBH9KYM1Y26VOn0jhGaVxj1UlB9Wa+wcf/mgHT4fXy
	2LOzDtYBpOjgzEPQg9SBP9cci+YSxCeIhZJFUVzBuzReob0ciiauHb9As/qcUtbaIBUEuGt
	5samx0uPif+I2ZT9mqEROzCjmzW2fRukOMqsNydAvvO0O+vi56fErNZmtL30b1NjJI+voAC
	3e8X/uwe/XBPsAwtN12ZSTrzHG0S/8NKqUZErtlG7nIe2HzRumqh7VXuP1h/TEM15+ryYOS
	LAkuEPbz9ZAvQcU809w7BT4yU1SMfPXBhsKPtte/mhu59ZX3IowTCU6HFUOhfnDJcDKh+v9
	Rh0hnLRJe+/LJjyywnwKmJG+v4AHrpcx2jrYuYICOCUpvK39QFkM/kuaaEFpSxdUCwNf5zm
	GayNLkw+9tHvvxQE07z/984wez5vFg5rnKjTLihZyPIRl87DYzL27cdqKINCXSf6YdpRl/+
	SzsaVnhXMP+S2xl6fJCoV80L1s3VMpcxTez3DWJWt3b22/J07qnqJ7Pa20fG7ggffJAiL18
	6dBOxTePLVTQd9fOEcLWCPBy/psYd2SDNc7QMZEnqZtmKgixc7nPqJejC5Ngb65YeTJwU5B
	cAAPzSLlAci9Q2FFG6WxImrkwQ2ggCiTmB/OZPMMar4PLqm9+yK5g8ybLDPyo6y8Li+pAsD
	fHQMB3ZGef5I860OuDGhLIF623Kyk6bAZ974hI/uBIcvgqpgwi2kRbUrA7x37o5pdGA/vXf
	BSG38NoCHu7shajnBYnWRO5XDMafKUK/EcnLvPE7J1kkKJ5A3BFyR2/0Z3a1JaJfXobRcKV
	esT7YfN0fRFc/DgR3kbI0DoiFaWwDFp91a9BCPrYzAuig+OCKpFAYzltQhXoBrz5rQMaFAW
	pDY1vvP3mL79EHD5jAuRmfHg4q68O4mwtx4VUIVx87goxd6MJQ5/fSsKtNJyo5UOHxfhiE5
	0EhZhwJcg141XjKXYiUym5DUsHS6wstUhy3puyK++/XEwuovHk
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:42:47PM +0200, Andrew Lunn wrote:
> > +static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> > +				    u8 *mac_addr)
> > +{
> > +	struct device *dev = &hw->pdev->dev;
> > +
> > +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port) ||
> > +	    !is_valid_ether_addr(mac_addr)) {
> > +		dev_err(dev, "Failed to get valid MAC from FW\n");
> > +		return -EINVAL;
> 
> I _think_ mucse_fw_get_macaddr() can return -EINTR, because deep down,
> it has a call to mutex_lock_interruptible(). If that happens, you
> should not return iEINVAL, it is not an invalid value, its just an
> interrupted system call.
> 
> This is what i'm talking about needing careful review...
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 
> 

Ok, Maybe like This?
Just return function return if mucse_fw_get_macaddr failed, and return
-EINVAL if not a valid mac.

static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
				    u8 *mac_addr)
{
	struct device *dev = &hw->pdev->dev;
	int ret;

	ret = mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port); 
	if (ret) {
		dev_err(dev, "Failed to get MAC from FW\n");
		return ret;
	}

	if (!is_valid_ether_addr(mac_addr)) {
		dev_err(dev, "MAC from FW is not valid\n");
		return -EINVAL;
	}

	return 0;
}

Thanks for your feedback.


