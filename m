Return-Path: <linux-kernel+bounces-769889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70761B274C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC217AA266A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AF19D8A8;
	Fri, 15 Aug 2025 01:33:01 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49332DF58;
	Fri, 15 Aug 2025 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221580; cv=none; b=bUhMAU4kqTNKqKOy2WKE/DlxMSHMrIS3OMyzk8tQNqil9ilaAKgNoPzOezXT+HeeITT13fOpfywswFWgRhPYQODY+uT7FGShn4Tp1IW4LaB1oOgtpU+Gr+NWF5u0Xl976wJlgS8j2ol+K93mPDKi/d3S8NzUbC46be53hilgWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221580; c=relaxed/simple;
	bh=9sKiNJfyjngAIgU9d5CWTxV4AUcI11DOY+yK5q41XhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjpB95X6wEPWOyMFd/nN9QzVwGlB5J2x9Cx5weyzaocHJB3/Bp6xeZUmiA3y8Q3dKJix+pPiJ8z2ACcWazI1WXg/164Hlz4NTw3qgQ/uroPDIWhN36b9LYkQlhl/49q6BwU52nH44lXiAd5mOu1TxX/U+Z/FFz9eRT5wY0XcSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1755221515t7af4e635
X-QQ-Originating-IP: JF5mJYe+rP14nNyYmSDK6SVBxUoGK8zGerfLiLi6wCg=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 09:31:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6925513884918620857
Date: Fri, 15 Aug 2025 09:31:53 +0800
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
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <D19BDA0A798B918F+20250815013153.GA1129045@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
 <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M+BwzFJ2m+rnFO8XPUs/UM7x8JATF7aIdVc60fX6XBiq8LQ74Paab5Hj
	7LGaUEI2tdrNfqVXkh+TTitDcJyQT7yTg4gGo95OA9oFtXYSgOoOEsN14YS1Am+4J2OrLt3
	4YsiB5O5tEVQUXXahJfk6+f9oE8hkYRh/m7oqluVPY0UAszHHjE3R1NFo8N7Y94uQmx/2XY
	l3dW0hcjnusgn9qo6QIniNF7zmU3wmzkUfTipcEcSdR+ojZLQNsVRvm9YDP1/WGzi2dGYt6
	sdzrTMPzUXi3c1C9uDE4baCymOXqQjste8oj26nACI/xOijlF2dYkRjluJVZzxGrmY3FBB3
	V1pq48sGHXLtlD5vKJBAC6oWzYrYU5+TNy7v4YHyBHlfq/YedSPp/85gebturdO1QYwzMfA
	FaihqnOhoQyV+PPPn5btGbvhFYJqrjajGcjYb4vS6lNTaW3vyaknU9ZjL2A2BlFe6mW57JC
	IsSe4e+zoMsWi8NFJftsvZrgM1TR0XVSIlHfQfqV6jYHHJAf3rkRnB+MTXQf3iIW9CGQQMM
	xVtK+AMSUIKiY87F7J+KgS6sIW6OyrBf+vYcEo5AFIOe2Ep+/7wsgmiqNgGSIJiHV/TtW7D
	PbvgpWtnM7u/5s/v4O6zGJJzkaObIo4RH5NwmzyjYJgGN4e6iMQW3+4DOTQ0AB9pUTxZAJP
	YwNuWhrkYoNhTftQn9BQVqvdMPLKIP6KVPWnlZ/RncOnadwTZdJydwKYeB8AW7kbAE5e3ja
	W1NAE1lEAQkxSAZFnt7HFMKARiIFCrUa1AewTr26AlR5Jol/AVHMrY8/poffb3d+buvZmo6
	Qq3cfzBCBwBxq5wDo+kqcOlXS0HalTJ5r4e0ff6r1ERFqmGWoUGzukFmQJ1uNBpu5YdCIbE
	Otu/CxR7gxE8Ps8mvxukPBQ9LbiC8scWEyGiPHNfbSpB0y71zUxmTxSCalJcNTAzwh9jO+b
	5H7YeP0P+NdlRtxqoE8SHVNjuS+fjbyAdcIArNk5AmP1Iyv0sQs3HNpHuFWyq9P8mY/2rac
	D8n0Almw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 01:55:42AM +0200, Andrew Lunn wrote:
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	/* limit read size */
> > +	min(size, mbx->size);
> > +	return mbx->ops->read(hw, msg, size);
> 
> As well as the obvious bug pointed out by others, isn't this condition
> actually indicating a bug somewhere else? If size is bigger than
> mbx->size, the caller is broken. You probably want a dev_err() here,
> and return -EINVAL, so you get a hint something else is broken
> somewhere.
> 
> 	Andrew
> 

Ok, the caller is broken when size is bigger than mbx->size. I will use
dev_err here in v5 since I had sent v4 before this mail.
By the way, how long should I wait before sending the new version? If it
is too frequent, it might cause reviewers to check old versions and miss
feedback, link what happened with this mail. And if it is too long, it
is easy to miss the 'open window'....

Thanks for your feedback.


