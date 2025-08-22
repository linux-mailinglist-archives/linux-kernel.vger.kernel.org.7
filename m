Return-Path: <linux-kernel+bounces-781149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE55B30E29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3BE7B64A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF62737E6;
	Fri, 22 Aug 2025 05:39:20 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF521B905
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841159; cv=none; b=jp1MTawit13b/IyAl6oIFgu5qprpCeoSoi6uy2iLJVXDM2gU4MZ037UpEt0rEOFF0UXnIi4Arwsrkt/ID+g0D+3Vy2B3QN3MiJQDzzfeR1B8bYhpU5y2wzW4CvjR0TQCKUBmP436IBUh+hRl5p63ibT8262xl+zIbVFhEHZOjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841159; c=relaxed/simple;
	bh=P2OpMo8zKi5PbanOBvN3xsHsrhiGUSU6OkaETt+j7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjlJ8NGEv3G+CE34U7Gpxi0HTV6dhOmXxLV/3OPdHiEiSQLaLJr6jARy3HAd4KHxi3Q5/8312w/sKGCLzRkXMFXqiOhAFrC99r06IsxG2SLajmCmNnaIQ/P4drOBAsFITh/Cf/oWM9WyBuKB5QHD5ADDMfBLnfoDkDxmfE70JZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1755841062t97b53618
X-QQ-Originating-IP: hLpCTsEsbb/JUu8v3fMtu47Yfigv2mhcD7vKjgfus30=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:37:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14988215101374177968
Date: Fri, 22 Aug 2025 13:37:40 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NkyHzehpHY4/p015tQd+MfKU8oyKBqzerGBljdxgwKrUvlLZD8dVc2HP
	AP1zm5KTB7u91kCigRyp51QnUGkca9Unu+Gg4iKw+uSwxLsNSfOHmogKlvcOJ3OsnIgczwh
	SsFQZHBnGJKkXfV6cfqBkZAf+XEuhaRYEeSLT9XHwuf57NwDkz2/1UCYayFUqUiYE/eX38q
	oI4+ZL5EiIN5aXkMcxTJKJyiqZFBRq2IYfFz+I16VI7bR2k2JcPvFNSsBz1tt6ZjJ7sNt0I
	rNgSUxJVVNK8nI8bC3PGPCuAg113kqCdv5giyqCN7uSLusk84xMfNJfhrfEsnUenbohFHUx
	ikmpa5/FP54bGAheSAQYvoCj0J4yX3g4PHrBAF2YiE+ufydWrhFNaI3QqCXBEX9mxe8+MIt
	wzS7KtIiS4YLtrN+dtnlzlng0aO3gZnXdvnPYRJq2AB+KAtrqHewi7/UW2lBgrjj/EEhSbh
	i+/NKcEyuzIxzjCApF2WHedVez/c9oolR3SqleAY52UOio6eio8QBnaqHrQ8C8JHdGMDoAQ
	p0QXnYDA/SwVgecpMZl7qbVjSK15lp/VMl/p9Ivquhonk1EhV398hsDKrF4BnQBHa/xQ+fZ
	ChrsWRzRHwnRzOjtmAE4kqrmc9kTk8owzl93ujltKrTwgYYkM33gVgavLyD3UTESsEGwE05
	6P9ws3xS7YpXtsNKhncN3dOTfaEIEiIGQCb0P7icuNQX67cEFgHsqwotCx1njE/0QrSv1Vf
	+UXEWI7/0S/HonmKZnffEuOyciGH50qIv/ASOgNfvN1lNfR/3XeWCa2B7vVqKA2Y9mmjpno
	m+hTwflDOSs/xqRyw+FgDTGWjCMhmcXDsfOtoU2oq+LSyGI0JNIpf+5p+5YB5NoiK2yvpI9
	3EV9N8oJs9FO0qut+5R0+OUqsCg59RxfLyrY9HcVe19kNS6UJ1bA94IInjPyc4HPFpq5CuR
	TCojIrIQvh3WhK6XosDmldMZRWTzgmz3CECtxeixynF0jV+D48QWQGhx7Z1z6DnfBH+0fnT
	Po8YSJk/RdASq9/Up/
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:49:44AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 22/08/25 8:04 am, Dong Yibo wrote:
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to get capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +       struct hw_abilities ability = {};
> > +       int try_cnt = 3;
> > +       int err = -EIO;
> Here too you no need to assign -EIO as it is updated in the while.
> 
> Best regards,
> Parthiban V
> > +
> > +       while (try_cnt--) {
> > +               err = mucse_fw_get_capability(hw, &ability);
> > +               if (err)
> > +                       continue;
> > +               hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > +               return 0;
> > +       }
> > +       return err;
> > +}
> > +

err is updated because 'try_cnt = 3'. But to the code logic itself, it should
not leave err uninitialized since no guarantee that codes 'whthin while'
run at least once. Right?

Thanks for your feedback.


