Return-Path: <linux-kernel+bounces-778889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6372B2EC76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119551CC4D94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C32E11C3;
	Thu, 21 Aug 2025 03:53:01 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114F217F24;
	Thu, 21 Aug 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748380; cv=none; b=oXz5YvESgt487d0COMpp4flg+pV6B3toaZyXR0Q0rDWyTIGAXMU926IOrqcryMw+bry21pUstYMlfritsfIVyJFe7fTrG0+92OaoHynL9yNPwF9fOj/AEN78u75v842AfNSSI3cfhMGoWo4TvrnlZstbhV9mVREr0Qt4iK3OiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748380; c=relaxed/simple;
	bh=c+dzYgwegckKBE8DwdjCoqLZMH/ed06q6NOgQtARQeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k52BHopfl49BafcFGRwToNEP0/TvqwrLtqyAzl6yvi5qC0J0RE2GDoeQ9LpJdkAxKs4SG9Fya0pKR215NdUGuOShbSYhN/EjSu52S+ruU8wq/YMhxi4wtK+EZAPAS6Q5abEs39ce+Y5cs2p+Ozmi5yHjtJ7FOPq9Beu73o8leDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1755748320t06463bcc
X-QQ-Originating-IP: BnGfIoXIObhF7yKbto78D0xs0V9ppX65sKZt2uAFk+o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:51:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4102684638845518998
Date: Thu, 21 Aug 2025 11:51:58 +0800
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
Message-ID: <135DA1E6DB034659+20250821035158.GC1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
 <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
 <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>
 <f0c9aee0-0e57-429e-8918-d91bf307018e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c9aee0-0e57-429e-8918-d91bf307018e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ni5aFAKuSzLJcv5aOOhV+g1tJGB+bZ4wf363XGQ4BA2ydw33KoAv7o7H
	J2W6AjWdMSxnga/+VY7nm3XDk8OngZ3XfnJU955pE/lupI0sxOa5Ms2h9uRuesPehmFrLii
	QDnqZFyrwNB93821oqB5hjl2hHrC5cuUKfWxUcvsq0WieGR8VdhKRxnZA4yUhbsH5aUtM0S
	8bXkGCjs9PqVpJGS/RYdIyapDNm63r+HMJX3dV10lzlkRU7p/ewVyGDzUo+5cW29ErHNVB9
	TKIUuwtTAxFVBsDnin73zZNMmG6Z0oiWgIcnKBFEHtjlQw91B/UdPeKNzqdVVeuCo5sX5nU
	tj6sJ/M6Nmd3oqY9gTrHAppTF+oV95l8daLFj+30dLGyppWbEr4MRSExXJrGd0lr30rcFRx
	3hRWK90PnoLq7ltMTty1i45Td7Q4UuajBY/58iIG8Me8Cmu/69wzTqUyQu0sX7lj9ZHFeMa
	rhfmMhpr0k+9nMvfH9eQtx4Zd4YKwlMiaQeiIXw6rfcElCV7akNlg7mFBDs7oyfXutOxg49
	XIsiV7dWP8FSMu7jCGIbHZ9UR8Kifc0ua2K39O7HepFH2NgKWAxt6wjCImT882XEmUsWvvA
	3oUa6tTIGEs3pLdhYsX93T2oEBKwNPSHmgovi9bHhdDnLg6qCfg5Jpisc5EXr/aGsJorfP5
	B3DqltAjM2v+NOrDcTkwDR607SHX84INuYGU0X67n2LINnkX1iVmaDlM5/4vqb+rxEJ9adZ
	/UZEF8VUTT746PqDi+leUTSw06KDpEQ21GFL/I67fzPXtB9x0lCdcyWIGi/9u9blKK9q8a9
	QltbZ7E0zP20JeSxKHEA2X+aGALGHm5hxjOn9i+fn/5v9BW0uIapozqdElpDzRQExjhU7o8
	kS6u1EXfhpQKyqcT4uhJ2lwqi1MD9r4dUggsN2wM4+mZIBpYzKnt1YAX1K3pbxZxQnGLEDl
	8B61Fgt5WGi40TVslQfZJPC4xHJCYiaHYWkspGabwjurQnK7no4f/pGRHM1G301y7wOtI9k
	Qej+cctK/l6V1sTR8nz7iHhggUjIFmjDiVEtP6mSmRQ0RH1kc565+mY+yAAyQ=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Thu, Aug 21, 2025 at 05:06:50AM +0200, Andrew Lunn wrote:
> On Thu, Aug 21, 2025 at 09:44:11AM +0800, Yibo Dong wrote:
> > On Wed, Aug 20, 2025 at 10:23:44PM +0200, Andrew Lunn wrote:
> > > > +/**
> > > > + * mucse_mbx_get_ack - Read ack from reg
> > > > + * @mbx: pointer to the MBX structure
> > > > + * @reg: register to read
> > > > + *
> > > > + * @return: the ack value
> > > > + **/
> > > > +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> > > > +{
> > > > +	return (mbx_data_rd32(mbx, reg) >> 16);
> > > > +}
> > > 
> > > > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	u16 hw_fw_ack;
> > > > +
> > > > +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > > 
> > > > +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	int size_inwords = size / 4;
> > > > +	u32 ctrl_reg;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> > > > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	for (i = 0; i < size_inwords; i++)
> > > > +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> > > > +
> > > > +	/* flush msg and acks as we are overwriting the message buffer */
> > > > +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > > 
> > > It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
> > > to mucse_mbx_get_ack()? Please look at your other getters and setters.
> > > 
> > 
> > 'mucse_mbx_get_ack' is always at MBX_FW2PF_COUNTER now, just for pf-fw mbx. 
> > But, in the future, there will be pf-vf mbx with different input.
> > Should I move 'MBX_FW2PF_COUNTER' to function 'mucse_mbx_get_ack', and
> > update the function when I add vf relative code in the future?
> 
> Maybe add mucse_mbx_get_pf_ack() so you can later add
> mucse_mbx_get_vf_ack()?
> 
> The problem is, our crystal ball about what will come next is not very
> good. So we review the code we see now, and make comments about it
> now. You can add comments explaining why something is the way it is
> because in the future it needs to be more generic to handle additional
> use cases, etc. Or explain in the commit message.
> 
> 	Andrew
> 

Got it, I will move MBX_FW2PF_COUNTER to mucse_mbx_get_ack and rename
the fucntion. And add new function later.

Thanks for your feedback.


Thanks for your feedback.

