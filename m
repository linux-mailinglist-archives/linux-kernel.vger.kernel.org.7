Return-Path: <linux-kernel+bounces-742317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72BB0EFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1145445DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3563290BA2;
	Wed, 23 Jul 2025 10:29:09 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD69290D81;
	Wed, 23 Jul 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266549; cv=none; b=BgiCdFNWR6HRqGTeB88K/V3nnhNk9Hgp39mCk8tij79mNIGkrnESfFaos81ObPOdcov6vSX9DJmoT1yUlMHDyhyry6WC9WphACTmH9V/atEWNMebKVx+bH8RlicMpgDyOr59RZW5ZziFO41vLWDiO0TQe6ecuz75kFRxmdFn8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266549; c=relaxed/simple;
	bh=Y2hBbsRsSjb0//xxcUnnqm+dx2pboI7dZeXSdkFfqjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtNlPBMuUszlWn62n34jaevC9OvQYwqcaVF6K2y76vPk9s2XhVd7UDoWEx9/uwCNsfK21L96brNmhnfsDhz179WTM4PAg5c0rP0ydujIIuhHCVATJzwd310FLBIgUSuk5kDcop9ejHcWpx9hX91/i8eGncM7FggqANrC+kGx8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1753266484t705774a7
X-QQ-Originating-IP: 5vaOYJs96fmAx4dCayhfdSYZKhupt7js6Gtv9Q2cBvI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 18:28:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14126020564848538954
Date: Wed, 23 Jul 2025 18:27:57 +0800
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
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <C01D5678EB05D185+20250723102757.GA672677@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
 <D81C71402E58DF29+20250722064530.GC99399@nic-Precision-5820-Tower>
 <942d3782-16af-4b20-9480-9bdf2d6a1222@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942d3782-16af-4b20-9480-9bdf2d6a1222@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmIUUz9KGMMd/33id8JVeJojtjHisL9G7pRUASH/ZnOkNy5XonOVuYTu
	vN1WMgQYqiwzlbfbn6fpUPNMHo4MnGAFQIFCnxhMjzNTer+f5zW6Xvg+0CYriaOHXZyP1+6
	IkM+z6bZXOAIHVwxZ2Yi/c+gcmPdkFl1JXMrnr9xkARxN2a8tSnDBulLgqxBIiC4QX5rT2Z
	FH/fS09kK2rc36Ug+bIYOWVNPpc6GjpHJcaapGxbGAGz3v3AJICs2zjxSmBYMR2neBxu8xR
	7d8ps87N5Xqqs7O8iZ3lwX9NuhnLdE5GxDiq3he7QMuOD88J98CtrWMSmIQB+jwpfBRE4iJ
	7SvHeL5H92zbQokeGBEj9F6LsMAnIMrkJAk4svOuMXqtg6tPpRf8pVYL/wYPqbxLHPsR4rR
	QA6v2RTOhsT9w2DK/e7oU1dvzCNmatP2dr8f1+/pLV5hwF2rAVJGVcPgfJpgITPXQOT4NGD
	C/ie0/LVXtIM5zU/NBT3BbxEIbx2tQlfpY78ptKWxreBGe3apLopDAdX29HxU8Rzkrs0fPK
	NMo9Dn4797FVgj8m9JnOLaVkmEu5US/6zK2nwk2yakYtcJciw20VsUGYKMv2cUy5/x1EIxg
	BDwpmXiGpmO3R9bKWbzcNYgHGtMM6d4IHECjn+Yt3A5kGdSfDgSUYmxagp7YLSIsMNaNN6I
	2cKwArVpx7dhVrbFv5cKNrFWzTba8xc/qvkzE653P0kN3PLLieOwg70WCU6UVItP4m7Xvjf
	QWo5bxHmclpQ2g3oyMmn8RZFeMjRmMHFd/HrHceYXpY/+HWHYl3WROp22RHBf/70exdVShq
	ap8V2WYwDPIpvm8DoaWDT6VzwCalpc2YoQdjgtCojLwc/PZsBn1Ifhdqg/Z+yhT/4wbeWFf
	Pg7Xu53lQsjrY0DGjS4aYqU7p2Z2gXButFyUtT4734CseAgxUlSeGPSGK694+DkzWaH4qF+
	UXIfBDxBbmkYcF2VilTGzWqAbqzT93+r4VCx/S2b3+rw095KEKkYFQgF8qUPrFx+cxGs=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 03:50:01PM +0200, Andrew Lunn wrote:
> On Tue, Jul 22, 2025 at 02:45:30PM +0800, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 05:43:41PM +0200, Andrew Lunn wrote:
> > > >  #define MAX_VF_NUM (8)
> > > 
> > > > +	hw->max_vfs = 7;
> > > 
> > > ???
> > 
> > This is mistake, max vfs is 7. 8 is '7 vfs + 1 pf'.
> 
> So it seems like you need to add a new #define for MAX_FUNCS_NUM, and
> set MAX_VF_NUM to 7. And then actually use MAX_VP_NUM. When reviewing
> your own code, seeing the number 7, not a define, should of been a
> warning, something is wrong....
> 

Got it, I'll update this.

> > > > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	int try_cnt = 5000, ret;
> > > > +	u32 reg;
> > > > +
> > > > +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > > > +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> > > > +	while (try_cnt-- > 0) {
> > > > +		/* Take ownership of the buffer */
> > > > +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > > > +		/* force write back before check */
> > > > +		wmb();
> > > > +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > > > +			return 0;
> > > > +		udelay(100);
> > > > +	}
> > > > +	return ret;
> > > 
> > > I've not compiled this, but isn't ret uninitialized here? I would also
> > > expect it to return -ETIMEDOUT?
> > > 
> > > 	Andrew
> > > 
> > 
> > Yes, ret is uninitialized. I will fix this.
> 
> Did the compiler give a warning? Code should be warning free. We also
> expect networking code to be W=1 warning free.
> 
> 	Andrew
> 

I can get this warning with 'make CC=clang-16 W=1' now.
I did't make with clang before, I'll add this step for future patches.

Thanks for your feedback.


