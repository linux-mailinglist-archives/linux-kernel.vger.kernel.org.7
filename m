Return-Path: <linux-kernel+bounces-770367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1CB27A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DB0A25470
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B229B8CF;
	Fri, 15 Aug 2025 07:23:29 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B61B423C;
	Fri, 15 Aug 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242608; cv=none; b=faEtsWBgK2CwDybzwv3f4m1i6ibJrVM9aZSutjackmoc04LkzT6wZPxrP6sCMsRmiPlHEhZpIfBGbQqK1ZFPOLbzL3pnrhxND08C/wJT15YovDIbtU59mdT3S19cvXvbxst44GhGNUm/KpTgx9/e3/me1bld4JwNX3hRFTheNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242608; c=relaxed/simple;
	bh=FGUMLzOhG0N1xTrWjGU43GorMZdiCn98jXecdCwWJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUPM4OWqoSlGC7oI+wp6DmJCSO+uJ+W4eQN9K29AlYK5TeQdGgmQBOItZIHgeL4cJPYmdbI72LcWOl6NUvUZCCH6pzb0wDHL+CEpGPJnRIRy3Nlw+A/fxZXPsNbj6LyEskDhY8gAkn+hXDjTO2SIqhs+qORb8S2GeFCUnQTPMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755242542t88795e43
X-QQ-Originating-IP: QmeCaZXz5zfxX1+I895iAG+f+GvT7685EYRqPTmo+fs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 15:22:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18254593275676516444
Date: Fri, 15 Aug 2025 15:22:20 +0800
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
Subject: Re: [PATCH v4 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <F32413B2F4429255+20250815072220.GD1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-4-dong100@mucse.com>
 <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
 <497996B7269F1229+20250815024302.GC1137415@nic-Precision-5820-Tower>
 <19d66fa8-f42c-4c52-b42b-49994f29e293@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d66fa8-f42c-4c52-b42b-49994f29e293@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ML0WjuuRu+Tq3LzAJAdg8mLQcgxQlsrnRy35tirVVHppam7ZDTlTsgWm
	zM8QP2klntlXl5S0yA8bwDgYVJKkN/MVzwb48kTWue5ULklyfcCpUtRiQ7KYUu07IQsEAKj
	Slk1gaOpOpTKzENOvhV2k2fc+hhuZmrAGJifya+EyJMIfQf4LvvlV9uP4M970fyK2UPh3Gy
	iyhWZFJJY59Wv0auDE/2eVRO/u2h1Jaa49RLwhhswqzzT1oaEiTg87SxgLVg49tH6po0JUX
	Zw7DQOwkrl5jWxxUAzYfgGe++9oOkGLi2+8PaU8lipdtAcnMECaSvvQ7NWXagN1ATHQ3SD7
	sTyQiuni070COYIp4CpUlG7q1EL94403+Tsah/oJecq+1WOI5w+72cb1cwM3xdfOVKQU35R
	4CA82Ie3x/QLk3SxR9QybMn94A+4s2Oz+ODwR7foB2A/BuyUa6wE65wxeoao1v71lobuvhp
	sDb9kwRY0xnr/BJrbYgrDsoVM3j/yhFyTXiYEG6FCFOzrSUGB++quVsgR8EW5+0DpYvPJLw
	cMSBkGrfxd2RyFO8x+0nf9BNE8U3Oj/d5ESDFv+SCO7MopjldLNcZGKH9Y24cO66l2oO75Q
	NtPLmfZNoC+IEIGi+BqixxuS1Q8qCSsUGCHL5NvGPaXmGuuSY65vafsThLA7pMO/kiQgv87
	73fO3WZoFxavu39xj4GLAkUVk/T6lHGr+sZlIZkZOrRme5oLsyS4/X6GPDMfFklzg/1nRsf
	Zr0hiaaJgu9baSZ0qIFH1MfqQJKv8VPcFSHhV9abdc59xx21AVr5zlT/tJZ6ifcueaUms1h
	xxUsk7b7tvt0K7g2wuL4qAKKUCgfUFx4zp+FihZ/MryZw0iHiP6mWoMBOi3nkfLYPK8YHeL
	LO2RwFbYjoRqiVNMCcbR4fLxGZuK2UAdoT1Rz7wR4WTfnhKCH3Xb9s4etWoxTpoMEWehL4E
	LvKpNBDg1Ns3+yakRpkiMIu7uhPTmo6RdzHHkMDWerd5YELT8CgmX7HOoKLxCCiwA+CB2XV
	opSvqmkkThNC9awcKI+I1PQ5oELTn9njF2tGzlOVFUCfwELlHekntcA/eTxIxqq4aD0RSnD
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:59:10AM +0200, Andrew Lunn wrote:
> On Fri, Aug 15, 2025 at 10:43:02AM +0800, Yibo Dong wrote:
> > On Fri, Aug 15, 2025 at 04:13:52AM +0200, Andrew Lunn wrote:
> > > > +const struct mucse_mbx_operations mucse_mbx_ops_generic = {
> > > > +	.init_params = mucse_init_mbx_params_pf,
> > > > +	.read = mucse_read_mbx_pf,
> > > > +	.write = mucse_write_mbx_pf,
> > > > +	.read_posted = mucse_read_posted_mbx,
> > > > +	.write_posted = mucse_write_posted_mbx,
> > > > +	.check_for_msg = mucse_check_for_msg_pf,
> > > > +	.check_for_ack = mucse_check_for_ack_pf,
> > > > +	.configure = mucse_mbx_configure_pf,
> > > > +};
> > > 
> > > As far as i can see, this is the only instance of
> > > mucse_mbx_operations. Will there be other instances of this structure?
> > > 
> > > 	Andrew
> > > 
> > 
> > Yes, It is the only instance. Not other instances at all.
> > Is there any improvement?
> 
> So throw away the abstraction and call the functions directly. Only
> add abstractions if you have some differences to abstract over. Only
> make the driver more complex and harder to understand, if you need to
> make the driver more complex and harder to understand.... KISS.
> 
> 	Andrew
> 

Ok, I will try to call the functions directly.


Thanks for your feedback.


