Return-Path: <linux-kernel+bounces-890139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98EC3F4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05EF3AC3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492D2C1596;
	Fri,  7 Nov 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="StkAOqEQ"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14F1A0BF3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509940; cv=none; b=r462L+sURFe7fsJt2s2kiFJBhW6EUcc0qW8ur0Djg2jqDremzezLMLPlun2Rwf3fggBJLGMzNonYsvwvsRjtCLP/XspTCQy2lQUJpl4tVMJgP28N/SHlTgjOEUAfuQDg8HMhA1s6Ydm6aPC44+158CXTh8k0pkoTcEG41LJKuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509940; c=relaxed/simple;
	bh=CzbhWzzPRA0VPC0U8OE/aM1Rzy7psH7/2sGbAgGckik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqiDnPqjgD/EnkBbCz/HVHx7ZNj3xh8kSSLpQHbnHOb8SxtTdATyagWAmNHl1jPgEgokqitApgy9zUg0lXU6RK7IR6HNEQaMF2kkzyi8AJrnnGrtEeATaXUjrnqpZ8NKaxP5B0FLYn1U3BGCCvfvsTYzlMs5vLdgIFDlHE1+WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=StkAOqEQ; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762509928;
	bh=VTkegRKBWplfZMqxYq1U+U6T9BH0DS2NDSH/ODE771Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=StkAOqEQ/IKtzubbakBHy5eO2e3LuoREWbRM9NvpgvCQHNbGHBHHEiHvPVLIdJbWb
	 MB7cYI6PuBOd6NBdapBi3h0EuF6UiXCKmkkE1ta1W1N0Lbba+t9a9+rJqC1zuaIopJ
	 6DH+g5VsjBwIfpMN/9k1IZibhPGX6cg75TFDwlRU=
X-QQ-mid: zesmtpsz4t1762509925te2c1ed2f
X-QQ-Originating-IP: HeNHNwiRuASLexM+FBE0aMEym+/kX7SFhEyilbzv62Y=
Received: from = ( [183.48.246.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Nov 2025 18:05:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17184048273143584487
EX-QQ-RecipientCnt: 16
Date: Fri, 7 Nov 2025 18:05:22 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Xuyang Dong <dongxuyang@eswincomputing.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: Re: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC
 clock controller
Message-ID: <6C7E97902D2C1367+aQ3EYikxWNtINfyj@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <1abb85b.c11.19a582bcbbc.Coremail.dongxuyang@eswincomputing.com>
 <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
 <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
 <1618037D174FDF5F+aQ2hU1J9oLEKCq25@kernel.org>
 <5a9911a3.d09.19a5d8d32cd.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a9911a3.d09.19a5d8d32cd.Coremail.dongxuyang@eswincomputing.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NNRmIXyIC58hjBAViImVIV9uYh4SCq5p7PEOnwe4MNiXDI0qjlClgY2A
	AayV8DWZJ1gdOKhLCN6hoV66D/0K4Q1vZIUIYn9cOPNXmqUfsXYMYsWskwYetGTfcdOTxIw
	RikXqWPjsIOEbxypW3xCesCwE9ukz0+a4Jam95WgyXak5J/ZxRj8D4Ekcuyvz6y0c/6VIaO
	H+BjZta9PyBZOYOuAFTb/ZgzlaNBI3e3F8D4yn4qOc7I/7y+aBESpAvQMUYR7eFhk5GVRnL
	mP/OYjJIpucOC+9VgT82vpk66+tZjKfUNvbGfxuaOrfXxfcQxMX27yNDvwEYyiDUDHLp0+J
	0kss6S8IziXuVRLHW4/G8RevbDGCrL4tGISGqEan07WBnMYqiPO9KE0AkL2mE6CQvj6N0Cg
	Df87c/lOy3iNyMEdCBaenKG0bUiOhw0CiY2tbnk+d9Op09kjs9YdlCw1p2BtsdbLQGlfTTz
	NciBME+g/Iq4wtgSj8JMISvHDnIpf4ieyQf4+Cvne0tRm/OCP3JG5XlvIkBnxWlw0NhvZpl
	xK8m2MGDyAAiJRLospLK40UMgRZSKbrxxT7qnLk7k60JweCsvIZw5xJrrFLpuCSnvvc5PCc
	X/Ul1RLgGQPUVh2CFQmeJfao2bxxTbNCHSeRKYTMbYEE9iETKoZS2v2mkn8hiBcHt6Pbdvx
	sCRqCLxce6Csm0oS+FAAVfZ9CaH2XQE2/nU29zGET99tiKVuigUAhAo7K7g0R6HS9NghTqc
	SOVl4x74k+8+sCbe3Qb+IcAkuWoRhGfkARolFRXqCb0aYNvMRdrN2kaARZBgsL2GXWZJDW9
	yqs8jay5CbwOQ2PHRTT5T1iq1WiIKRumDRZcsVhlKXJdA2kvFFHr8uj+eTpwdvuP2pdwppg
	9ditQfS0iiCkcnFZqGAtlh0kgC3p2Zi9Hlf9LVM2PSCcz2wNBbTS2xT6RUn3IDIE51Gx/vI
	XuzkctJbkfWtweiU9GLjDgSV0t2vOgtAUvaG/CA63+WX2cQF8UBXasntHPGj7YmwfcChJKm
	RDmXHthin43t049XyVcqmbP6rV1mEyzZ24vYNnYaGmHmsJlP35ypHq7d4fV/h6tkIXLkgsz
	b1lK7fNN4GEXfHHfb/Lo3bdoW4H0bLtEsVw4IBud7wZo0tpigGfquk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Nov 07, 2025 at 05:02:06PM +0800, Xuyang Dong wrote:
> > > > > 
> > > > >   Gentle ping. Looking forward to your reply. Thank you very much!
> > > > 
> > > > Please do not top post.
> > > > 
> > > > You did not add any maintainers of these drivers, so I would not put it
> > > > high on our priority list. 
> > Do you have any plans to become a maintainer? If so, this patch might get
> > reviewed with higher priority. I think that's what Krzysztof meant.
> > 
> >                               - Troy
> 
> Hello Troy,
> 
> Yes, I plan to become the maintainer for this driver. I will add my 
> maintainer information to the MAINTAINERS file in the next patch series. 
> Would that be acceptable?
I think yes.

And if you send next version, please dont't send to this email:
troy.mitchell@linux.dev instead of linux.spacemit.com.

Thanks.

                              - Troy
> 
> Regards,
> Xuyang Dong

