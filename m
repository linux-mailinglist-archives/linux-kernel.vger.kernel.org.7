Return-Path: <linux-kernel+bounces-778780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF73B2EAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782611C871A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6D255248;
	Thu, 21 Aug 2025 01:45:44 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770E5FEE6;
	Thu, 21 Aug 2025 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740744; cv=none; b=RljBiRvkMWnIY+bNSGqKxnAn7HwUvCsymscAJtKexbZze/UIDoiWZxn2vV59A46U6m+DFyYCqdLZ/0gHJtTr07ZbOXgxsw/OTOLjqiGXAuVtHEaogmNidKNKcdIjGlNa0KnBCZBFmwDpUs4wUs6KVdRRwI5x8o+Uh2PZUmZCrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740744; c=relaxed/simple;
	bh=/spv7jWo69UbbuIZnbqkbS+7Kk/f7i+A+U1mM8kITus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwz2Cm7bYBjhrbuASHplkm6Ck/dQRw+qOKJ2Q6kO+E6eCWF9VCYGOF0dOrfm61tysUQbXrOKQNJyS37yOfDurhMd19kudaGs5LDcpdx+4g0Gb6h/lIeNVIx0JSjNPvkjcn1jZQ01tbwUcWwirSPZZaP40/aaTIn70uqPIqyFGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755740653t744f92ac
X-QQ-Originating-IP: sSkp9uld1sPBcAjgjwrJDFdHIEDs46stzol3q4J49GU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:44:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11662485468357027338
Date: Thu, 21 Aug 2025 09:44:11 +0800
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
Subject: Re: [PATCH v5 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
 <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nc4Sv39/e83WJDUNsElZp8KdUH0jeXE/sPOeNjm+0sZ/xAW2aIY6Utqj
	bD8E8tE7jmtG3oCw8CqmFW4WWTpYxJntUgesWl/czFrN1uFdNgT+hLJ3/Idkn9Rr7EE2oAf
	lS9lfAKN7wo3e/p/0opR/IUK2QE0kGkbWkO3vBn9tyM1zxFzqtMO5lbki3pl6sVX0Kbf1Cw
	TtrQrvI3Daeey0Ku5zP2HXoDL4UrFbR8VPiygep0I8lqIgbz9hMrMPS4bLmehxx6MV2w8qA
	XOrJSmZl+8vMMVAO1m4rOlnqBMk1iELATjeY2tz6ZWCRV0lVcJPOO7IGATP0+Bm8MDqBlCn
	rXsX5UZTDrnTAvZ6gPm5bAFIP+Y8AJ3vB8f8+qCcRVt6ekbmks6Ymo1MkQ7G92XrmVG3TxZ
	63XbjELWKxCMAJdDVHdE0qfhlNr9/wL+Zq+0GvaOY0oxEhwxPMewNVOGZHl7zMwbv8eikk1
	sovBbNJ18xBtor3jogRhryJn4W5UcXO4Z2mKoHcxfY5B4xjSy0I3Vs5tq/rhkl7aCAWirxa
	N10sUyWviZmlMErVVbpWDxtqlnhfYxl2ZXdoZ7hCqA3cmk8Gq9W6vYVlAtE7yjyg7laz0Uo
	Jpa6WKnQEmY6oI/aFsAW6rnhaRHDa+XJc8AbLZ5zuXlbb1wqmgz3pWWa5lXPjEI13n4fGit
	ONsbRaS9huoA/uzgg2K1eADgiQl4gP/YY4jmc7MNlGWWek7l+XmTAtQYLo3ewy9kV7gYNl8
	lAbO+Uwe4BycVFt7LPLNrZ1l5gWpamt/aH9UwuFHRVN8NOyX3EJhxW2JCZb20AhNBLdXfzu
	clzLy2S2YNpYxJMrsz8kJZ0rjogqzvbeRgCvIGHOKA/MQ6j76sWrwwm0qxJQ4qjHDm7XnRO
	xX00g0NpicOKB8a6dbNBKaveWQGit3KoHSfwTKilciQCOxgfMcnwMsmutEJkchgONcZoQJ9
	LUZFBQUyGglDQ+M0aOU50g2lri7SnVrPCKDQPahsQOhbmIKxQFFCTPU19mpZkeYITVIwnL+
	e6Ssq7M8sU4qXZ5GXk7O4Zl5KlsJI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:23:44PM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_mbx_get_ack - Read ack from reg
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register to read
> > + *
> > + * @return: the ack value
> > + **/
> > +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> > +{
> > +	return (mbx_data_rd32(mbx, reg) >> 16);
> > +}
> 
> > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 hw_fw_ack;
> > +
> > +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> 
> > +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int size_inwords = size / 4;
> > +	u32 ctrl_reg;
> > +	int ret;
> > +	int i;
> > +
> > +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < size_inwords; i++)
> > +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> > +
> > +	/* flush msg and acks as we are overwriting the message buffer */
> > +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> 
> It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
> to mucse_mbx_get_ack()? Please look at your other getters and setters.
> 

'mucse_mbx_get_ack' is always at MBX_FW2PF_COUNTER now, just for pf-fw mbx. 
But, in the future, there will be pf-vf mbx with different input.
Should I move 'MBX_FW2PF_COUNTER' to function 'mucse_mbx_get_ack', and
update the function when I add vf relative code in the future?

> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	return mucse_write_mbx_pf(hw, msg, size);
> > +}
> 
> This function does not do anything useful. Why not call
> mucse_write_mbx_pf() directly?
> 

Yes, I should call it directly. 

> > +/**
> > + * mucse_check_for_msg - Check to see if fw sent us mail
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_msg(struct mucse_hw *hw)
> > +{
> > +	return mucse_check_for_msg_pf(hw);
> > +}
> > +
> > +/**
> > + * mucse_check_for_ack - Check to see if fw sent us ACK
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_ack(struct mucse_hw *hw)
> > +{
> > +	return mucse_check_for_ack_pf(hw);
> > +}
> 
> These as well.

Got it, I will update it.

> 
> 	Andrew
> 

Thanks for your feedback.


