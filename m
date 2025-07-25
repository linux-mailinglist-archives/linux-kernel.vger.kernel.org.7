Return-Path: <linux-kernel+bounces-745601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68DB11C10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1E2B40854
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E82E9EA7;
	Fri, 25 Jul 2025 10:13:39 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D922E9721;
	Fri, 25 Jul 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438419; cv=none; b=I/2a+5uMtPYQmfkA1Bo92YQrtijI0zUZaEsKONVyzS2htBW8NG94TclcuPIopkk/UZVNuqRrpOy0g19n1X6PXoWCD++tFveeK4vEVGJCGjlQFXcWrn9e+VXwaa3txwT7ZtkOgZEcgbbHN/2vgUY+gkII/DXnYYqeCK3qAL2eRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438419; c=relaxed/simple;
	bh=kRroiVwN8VC5mjdK3a+UEFHGD7+4HV0iLUxuCRe43nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShXaIQm0evKGiMy4pGDCvCRO1OF+pFrCH4EufE3MnOzO/LwwHQx6jMiEXdNkh5cR74DMwYOexLYLpGgQXTBUyIzfU7uUzHBPCjLT1Nc/P6hFWDa800qttWrytsm6BaVRaqDzND8MANmeR70F1/3h9wNGgKR2neypvg9xdl1LQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz1t1753438310t6f10c101
X-QQ-Originating-IP: hrXMJrjX1v5SmrXvU/RFaoTkBlV+D++VqopZO1o9Pdc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 25 Jul 2025 18:11:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17354701733030372774
Date: Fri, 25 Jul 2025 18:11:47 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <B257A91F74F6FCCD+20250725101147.GA365950@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <20250722113542.GG2459@horms.kernel.org>
 <78BE2D403125AFDD+20250723030705.GB169181@nic-Precision-5820-Tower>
 <7d191bc9-98cf-4122-8343-7aa5f741d16c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d191bc9-98cf-4122-8343-7aa5f741d16c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mdc3TkmnJyI/+YOumia0fMkiIQ3IF+TcSl1ZjGBSlfohOREivgBA9soq
	BT55KohU0cCwMVq1Hn5qrRJr+4DgKhv1P1LOGDV8HZJAOMk5RNOtp2vM8yFo5gLUBsqJrsW
	58UoWXTEHFkHA6lalgrxmtpyY0WnzGy2YUGxTnfqNE+QFCGTBk4Vez7sobeA3J/IYYs4VlG
	hy+87ZyXv/gRALtHjJ90WIXhyXBWReu9WXUdHZbasITtNjp7ytjlrjdcF7EEGqfd87sx4iT
	cumEjRi0QaWDKcl5HzVQmDiiAPCmpvPGM9+0DNWzryeRwqYiWzhvR86txTBlnZHdVmtknro
	Xp7aUfQZlVqo/T6rbhg514LZ2AnMa/iCPWhPsnMnz6oQdQJw3RTJnSzFdIx7IHu4FuoP0Pd
	Y1GF+13lG4rGXY9tuZ0IfdHw5QNCVLzWKzWYSyFoub3op3ziVdG+It/dNAZiR64dMS3MBCK
	n1Ctljuurrs9jGuOTp2NyM8R2hCHOwIJMIDMeVRodbil9BtZ1+8z7hsKP6L7VGWRJTgqmde
	lmUCjMSyqIHyii/7yIzD5zHWKPVs0MLIPhWLqOS/JS/3x9MV6AYk3MxucOzqGOoB9SI429C
	PxksrIQ4EMTbsmjcBNSAGFnHYFet0elNnQy58iqZeAkRE4MRgPQ6hVjwXAW4S2pSjmsdHq/
	XQnKM1eXDh3H6PZy91kJpooj27sGQam6bSrfAtFco2yLCvrr0i1Jntfr0zspiiJMMTLfkFq
	nVedLPPkVq3DuWvCS6P5p+MRwm9sFr1O4BiXfabf/INxDTIT91cCaf13sa+WtHIYTGV7ym3
	7TPQCjDUBc4DeI2DtEmijT+xC6q0fJtm1waYRrPTDOtBkZmCTp4pz21NzHoUupf8+pEKGsy
	uCZx77NoHBZHGRihV3bIgekKFW1vTdBurhG5Nd4QkGrJPB2U8tdPv+yD2CQoBMa33GbI8mB
	u3dsQRan5oJSUof4AyuQS02eveW+vrXk0KLeJveJuQdYwyHJcXqzyDVv2SfMqGH1aQxW755
	x8VRkfE5ZRB2B6O+BSRMTuu7NI3y7kboGq32KRGg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Jul 23, 2025 at 04:38:00PM +0200, Andrew Lunn wrote:
> > > Flagged by W=1 builds with Clang 20.1.8, and Smatch.
> > > 
> > > > +}
> > > 
> > > ...
> > > 
> > 
> > Got it, I will fix this.
> > Maybe my clang (10.0.0) is too old, I will update it and 
> > try W=1 again.
> 
> 10.0.0 was released 24 Mar 2020. That is a five year old compiler!
> 
> Try something a bit more modern.
> 
> 	Andrew
> 

Ok, I have update it, and got the warning.

Thanks for your feedback.

