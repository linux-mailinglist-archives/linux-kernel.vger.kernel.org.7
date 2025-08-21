Return-Path: <linux-kernel+bounces-778811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950BEB2EB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63F2587757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146625A33F;
	Thu, 21 Aug 2025 02:50:27 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B5257444;
	Thu, 21 Aug 2025 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744627; cv=none; b=D4SOjHQkEHd93RnMUVz0gK0CVNU92wabZRHtCIG3cc9YwIuFTqMr4TDwauEq0XIeLDyZzKNnXbC+QETs7+oppXElRdugUVs4G1pGHA6OGEtYk9nY9xq+RqSBUyNGpX8Vq2O28XMojvvqY2W542LLX4gv7K7Sq/T4A1Lnbg8MVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744627; c=relaxed/simple;
	bh=PxgeMwMuKv1sf/Jw8hoEPPd+SqpGsYOFkotxhNq7MrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB4VgClVeW9mQSta3UXogO/Tv0wKnrvEB/QdSFGLrhbHhlKrUqp89j/ASobFN3/+69SKwanLrOF50oFy7EM42S+YDWOzG9fTptL+xAUw77hNi19/ia+IL2akFF1UTSjJUb8bRDTpCixBUVg4sPSvYCgRod8t8apkZdLZ3WPxl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1755744557ta3696645
X-QQ-Originating-IP: IRI4JVT8dnqpFasF7EfI29Fv/GrSs4XUrjhwgvGABck=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:49:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16182991720817672807
Date: Thu, 21 Aug 2025 10:49:16 +0800
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
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtJoEQFRGvIz+NzKHcymgitHH9mkdki7M6BU+/P44iTr3hUY+HJLcPIQ
	Dtkee77cDJu2Raw6kfel34D72s5CBCDnn0vsyaAuEJh23CCCD4LX/oqXb1Oh2maWfiMvFU/
	wCzU03PPOf25vyCtxy3eXZ5qa3S16t9QTVFKZRPHFqAbrJHuqR/DEFqahscvBoC22YLSXM5
	tZQg72Suy+DQ9X8HUIqUZqeGHxnaoBKyG2rkmS6F9DR3lYTqP62yRtgpEBu2G0VNDm0T78Q
	j1Q4COSX+sSHUrh3Axrym0u7OkWtXqx10DkQbGTxUQ6sFP9/wYXmJcPtfPuSjFMKqTKtU6S
	e1lA8QtLq7mlik5dmeO5MzR5O3LxyHuIE3P5YkkaioyAlASxbm2thusV3O6DF3JjWAWHVbA
	k1qAwraswiEB2CKVWZh/jngTDF+Id+WYKsRP5jryZ+AUbPwQ12wDWe8aQ7Qj18xkoJt3itM
	NG5bjbpIVYHcmrz7+Pg9G7sKamkN8r9n1OY6joEU0KkScvFZOcICRdwX0zUInAQkfKTjB8C
	k/T6E1Csz6Knhwvtdx3qSMpThv/cCpQoOx9tZ8jd9D4+/fbobFLFskwPK/Ch7CjuhCPyK30
	1j33SO18r3CP8PmeN0ZOsLw+a0AGjdiBjj05drW1bUhRidUjdG7iNVp4u/LYTq8M9hok116
	Uokdugnmt0u+AfiTHn0FrQEYMKowfWaHPjCMdAMzq9jrhgyUyg4GcV5BlZUVWX9iB68cbEy
	IcrTuKRrOLPZB6VnrPdBXXslxbl1sAUfXPdW+RYhEAUraNi75YQc9YEq+9Y7bTqnBYBS27u
	xVzpOWdeiqjfdt6QcDsZOnCM9PavQzFo8Rnt9L7kuovD0FJvhcIwgFx1LnLtjCERzZnRk/D
	N8EUQ+AdDJjxLStQcuz/cOFJqNOrzNwdN80Mi5KMkA7PfmazaCdpamoeBAld+R+YvoAKFBH
	5Av3H6BhoyvYELBuSJI/z6kisKje9fcT0VK9wQakDKB1OXcdtyXFH9q8glyY1ZHqmLXz9iF
	LXm9e/wrQkhnGOdcfxDQCPntkjRFg=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:37:01PM +0200, Andrew Lunn wrote:
> > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > +				 struct mbx_fw_cmd_req *req,
> > +				 struct mbx_req_cookie *cookie)
> > +{
> > +	int len = le16_to_cpu(req->datalen);
> > +	int err;
> > +
> > +	cookie->errcode = 0;
> > +	cookie->done = 0;
> > +	init_waitqueue_head(&cookie->wait);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_mbx(hw, (u32 *)req, len);
> > +	if (err)
> > +		goto out;
> > +	err = wait_event_timeout(cookie->wait,
> > +				 cookie->done == 1,
> > +				 cookie->timeout_jiffies);
> > +
> > +	if (!err)
> > +		err = -ETIMEDOUT;
> > +	else
> > +		err = 0;
> > +	if (!err && cookie->errcode)
> > +		err = cookie->errcode;
> > +out:
> > +	mutex_unlock(&hw->mbx.lock);
> > +	return err;
> 
> What is your design with respect to mutex_lock_interruptible() and
> then calling wait_event_timeout() which will ignore signals?
> 
> Is your intention that you can always ^C the driver, and it will clean
> up whatever it was doing and return -EINTR? Such unwinding can be
> tricky and needs careful review. Before i do that, i just want to make
> sure this is your intention, and you yourself have carefully reviewed
> the code.
> 
>    Andrew
> 
> 

'mucse_mbx_fw_post_req' is designed can be called by 'cat /sys/xxx', So I used
xx_interruptible() before.
The design sequence is:
write_mbx with cookie ------> fw ----> dirver_irq_handler(call wake_up)
			|                |
			V                V
	   wait_event_xxxx  ------------------->  free(cookie)

But if ^C just after 'wait_event_interruptible_timeout', cookie will
be free before fw really response, a crash will happen.
cookie pointer is in mbx.req, and fw response with no change.

write_mbx with cookie ------> fw ---------> dirver_irq_handler(call wake_up)
			|                          |
			V                          V
	   wait_event_xxxx  --->  free(cookie)   crash with freed cookie
			     |
			     v
			    ^C

So I use goto retry if -ERESTARTSYS with wait_event_interruptible_timeout.
And it is the same with wait_event_timeout.
If ^C in mutex_lock_interruptible, it is safe return since no write to
fw and no response from fw.

