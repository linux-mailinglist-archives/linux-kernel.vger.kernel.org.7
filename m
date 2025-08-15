Return-Path: <linux-kernel+bounces-770054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A9B2764F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4463BE9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24529B777;
	Fri, 15 Aug 2025 02:44:16 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99D29ACD1;
	Fri, 15 Aug 2025 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225856; cv=none; b=tt22ViuojHMLim0/pFFNtcSAY7pIK8erG2hF5rT+Hyq1Bz6NgIyPtRnjvrWbkM23kBH7bpGwC1kDyK7aJ/6Yt6fjwN4FNvlG83ACDAyyGMkWiU+Dzhn18sQbnbf+0/+xdm/puj/8iuGauuGl+Wqu+l/Qsaf3uRnpPkcDL8YP2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225856; c=relaxed/simple;
	bh=C+nv8PjvjRT5VVseg8mFqHqLGLycXA0mcxiRZuNVllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roYNNnmHwwHT5prkJcNk9gv9qrplDL2Mi1lOv5B25OVSC5yG06J6hmYVs5GezQsr1veztVnJ5J0yPPhD3HIYtAOC8rbvBT4yXrCqjRHgqw+vUSf40VE2ehp/5z6RKGNSn24RxAU+j9WzzNYa3/HyXYcYiZiyqulfkelu36l2TWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1755225785t18a98fe0
X-QQ-Originating-IP: qZWec32v0f2IQWBPzJqvPtOzV3dv+pEGwUf5SLtvS68=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:43:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2926667803765780674
Date: Fri, 15 Aug 2025 10:43:02 +0800
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
Message-ID: <497996B7269F1229+20250815024302.GC1137415@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-4-dong100@mucse.com>
 <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MBun5VhikmqxOknxadMkRYFgh3iA9R62QtHUMW7W2T0TCccgUBIz25Rm
	WHcLGgFEMM0vR3XKNscCvV4zK4v6iEip1mloBcwGqK86rzdloQ1vVj+b1xArepmkEf9ynUW
	ZOMK9XIDql9zRpnRpA3YAHGvhCcL48MN8BKG8qbN+4TSsfPgQsUR3vv5yMPECaZ34x+rwGO
	MgQRtIgUIISmERV2EiVXx9/o5KZnEyyDy2r2IXG/pCWsAqPkYUJWzDPCtCj2B9q9uSJgSBi
	Z6zfXjTzPCEpzIkI8cEdH1AOSK9gFYDyakLWUTBcwROEwslBB2eVxTyStjEsHaKmhF+ODnE
	XM88BBEoTRt06UxBPeAskq4b3gSR3aa4+Ts+f4p99aGpur4XTmX1GZ7yp9MfFn8mQHxb7Oq
	3zlGQWdW360iMGrYiwIZ0DMLYGKaXMfYvWHLAaRgy6Y1rtKOWy/VwX0xYYOyMaRnD+/V2za
	m5C8UIuTY0SUHmEYHSobAA0aUvwLHhs2q/DD9o8UyGq8RMHZqAwW5InRoL7K8jmJamKGiY+
	VYfFdzIZIcKtDtRNbADphOHMakTRCv/GnQNIS0Rd1eLkCg+lu7AWFeRZKRyUR5YDfAZiqrO
	hul+ZMsR4rdAgVxpFk83+8QyE6medOqDc2lo/nfutKv9V850VpUsWaxGRuNVvRchCH1HSon
	ozmnyQ/9UP4Sd15l8DB/rIrrnzQDb/P+uAbMuOJzAnN1eVlOVYcz2HaFoGju4hrOc6/F3ZN
	eAw3gBgHkUviQ0CL0R7xy37xlbxVpHFNA/TAIqSxF1P16ynpVtr9m8+KVtrmMJdWqDb+pBT
	vc971plkHDuy16swCU+cZvlOM1jGvAAdygK09QkvX8bk9udrlJN/npeuxvMS0fNbWYTz0qK
	2MNbYkwPwmpgKAre4xKwfeyqPhw8bPhYRMw8OT6CKaLGSZopElX7o2qJdeIINPTrHIoPIVp
	UScySX5iVb6++hHNF5/lsmrl8EkezMbmJqMbWxLLBpC2l7+4/PSX9KNS8Nd3cWm4+ZO5KTa
	6wcKHQAHsOz1KRcfFgPfEZu34Ou6cr6HuEeBJxdUgF4Z0UJrSYphdPXZ6LFNosKkLUjA6+Y
	OxW7xYg7grCktSgHvvSha4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 04:13:52AM +0200, Andrew Lunn wrote:
> > +const struct mucse_mbx_operations mucse_mbx_ops_generic = {
> > +	.init_params = mucse_init_mbx_params_pf,
> > +	.read = mucse_read_mbx_pf,
> > +	.write = mucse_write_mbx_pf,
> > +	.read_posted = mucse_read_posted_mbx,
> > +	.write_posted = mucse_write_posted_mbx,
> > +	.check_for_msg = mucse_check_for_msg_pf,
> > +	.check_for_ack = mucse_check_for_ack_pf,
> > +	.configure = mucse_mbx_configure_pf,
> > +};
> 
> As far as i can see, this is the only instance of
> mucse_mbx_operations. Will there be other instances of this structure?
> 
> 	Andrew
> 

Yes, It is the only instance. Not other instances at all.
Is there any improvement?

Thanks for your feedback.


