Return-Path: <linux-kernel+bounces-778787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D2B2EB02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44251CC1EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F5274667;
	Thu, 21 Aug 2025 01:55:51 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330E22156B;
	Thu, 21 Aug 2025 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741351; cv=none; b=eJ0CnmlX52ZoTuDbP2jSkneLzei21wK6zohBW4157CrrM5Qh4QPdcjI+21smV6mjFex+6flxiNS+YPsiZe9G4L13p61FXIkDQQ5rCekzyIRMWAILDn2JJdoxwNxEQF/YHVxdC1f/SWXwPLe7OahigXCu8hzHqPnpWtR5IfgfrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741351; c=relaxed/simple;
	bh=Hjt2XKIqo3+Dd1a74qTezfLIh4/05/HZfR0EMUnHXBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdjY0Vi1MIoI3Exp9TUqA49ZiTDqsNqFUQARggkJiq3LuMI4UkuGEF0D+vYHYgmAJM11d4a1jlLTeVNFBAkVqOFb3WkXXrTw44babYtOqcDq7Q8NTiHG/vgwJrBn/KjgmGjWMCUamfL8kxyv/X/qW3SDfexsHSTNllwXblT+7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1755741264t689e7382
X-QQ-Originating-IP: U0fEyWnwHg6dZLkemjeK4dcZ8M2S6VxDy3X/6ajZ+TY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:54:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3627118193617159813
Date: Thu, 21 Aug 2025 09:54:23 +0800
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
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <B6794BB31A93D48F+20250821015423.GD1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
 <3e5e73f7-bbf5-490c-9cff-24f34d550d24@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5e73f7-bbf5-490c-9cff-24f34d550d24@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OE3tIrIEWSq4puDeqjqCrWWgjxg2349e+OeiqYoiQRRBXzcLB0+8oXeD
	qadmSnrmTyZOquFtDSaLPWuNHB16ioryxlw8ebmPLI1jKhJ3LLG++Ri8bk9jHPfK4+CXChM
	VvXqEacjYfHMqQSPHrSf9arZhF8uZbYdI9k3Yuqih6mH5lurIWz14mZgnskw/iy5lM5RWKx
	1oo5eq+wlTiIlvQydo53CeAGH8QhMPOUIY60rT3gof+KSTamzvwBGr57to8TcXaMwy+HFvJ
	n81ULboQ6EiWXmHs3JmQJWtrfGkdmVHYBVTOJKmJFsOoRCugHbhSWQJqsifn3sri2OFPJfF
	Jz6MMrKBkOTHxCxqP8JlGW1NlDzu8nAvLF1xDHWg/XfS4/JwTzP/t50Q3E0i8heR8gPxUDG
	CzmmjycfjODSD+uNzbtkVWNX2xH7N0XVEOkoOcTaEXHUoWmpjUEIa293H5QagbUBxAhnpD8
	ZUbkF/StJURC3pr44L++6pcg7Z8T5m41puflgVEZbojYeC10pU/07kZSm2f5kwFY8L2Fv9R
	gDfQ2YKDAyexb9SnMxs04cjXflqH2ga+P8Adk8Sr7GYlYyJUKlhCJJPaTsD26UpjiJGwiYy
	EdYcEukXGNJnsiyiACzO5GHKAQMspngt2EEjGYZ2g3sRDKQnYHRxyH9ZZ5rvga9guLCcY+O
	GGOryvzHQ0zF0sUfNSQXo/kV0Ct3uNkb8Q9GpfvwUKVfhj9nfGIsc3/+vLdTCi4BWS+88ZK
	tGLQjxnn5p7Ae9WnTjDAh+JtPGaTFJkANzpG2lQwqk48w4KslDDMrxP8ROJLOKkkhOTO43o
	YPZmqG8KR8B52aPTOE5PmrnKUsMcVftrvsRNhjWqk2VKMYL7jG/OJRSzE7LKXexpWd2m9RP
	2D24lpgCr6xwJQDnr/38L6ZyejX3A02s5wEbG18MGAxpYfgFgplR/3ywwn10AUGfGNXNAit
	4bToR+4Xx4opuo4Uk2c6xrsXIYJV2pAVv7R5RMbhOPSMuJgJ5VVbrAba5Nn2dvaaqpuUySs
	+is4Cb6moPZSUCo1SWs3hbm4kUvPXVOQJOYdX39Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:16:00PM +0200, Andrew Lunn wrote:
> > +const struct rnpgbe_info rnpgbe_n500_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n500,
> > +	.init = &rnpgbe_init_n500,
> > +};
> > +
> > +const struct rnpgbe_info rnpgbe_n210_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n210,
> > +	.init = &rnpgbe_init_n210,
> > +};
> > +
> > +const struct rnpgbe_info rnpgbe_n210L_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n210L,
> > +	.init = &rnpgbe_init_n210,
> > +};
> 
> total_queue_pair_cnts is the same for all three. So it probably does
> not need to be in the structure. You can just use RNPGBE_MAX_QUEUES.
> 
>     Andrew
> 

Got it, I will update it.

> ---
> pw-bot: cr
> 

