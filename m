Return-Path: <linux-kernel+bounces-740269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43DB0D20F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918A11C21665
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B4289E15;
	Tue, 22 Jul 2025 06:50:00 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA71922ED;
	Tue, 22 Jul 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166999; cv=none; b=fMT1nxp4Pw7lJJ9g5+1j7FU5rX9IIwAYj4ql4JRoYyMwBs0L5L/Ln5LcBRJx/Efut9jrX+YxJVe5OQvCkrrFrQ3aB5jKlD9uNp3yVFC6MMgEN1Clql4kYxiJcMcrwZ02l+kInaDv++y4mlZduGAR4rW0r3Pkf1JnDZ/BG0fW83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166999; c=relaxed/simple;
	bh=iSbkyPzqN1Hj0CXey8Fx8nw1cT+ihZBX/aPel5YT3EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI9JlbFlopYtVayLRmtzrDTfZiyXyWE0MqTdJa+qy3r7K+3qNmehMCh3Z3MJPg57L5ihVsekrPOHCsu1RrOYBmGfXo6g0CbftuuwHBf/uOBGvDwxXAW97OOic8C/fCS58Q4nTwqOUV7fhz6n7BGZTD+5nU7tImw3tjln42uPsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1753166917tae364b87
X-QQ-Originating-IP: mKK12zRgZoLI2Gza1yGjMKaEIk8SuogXIs16fAZRlJs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:48:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14186350718973111170
Date: Tue, 22 Jul 2025 14:48:35 +0800
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
Subject: Re: [PATCH v2 12/15] net: rnpgbe: Add link up handler
Message-ID: <689C469EE0E578FA+20250722064835.GD99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-13-dong100@mucse.com>
 <a77ef7df-537b-49f7-a455-c23295fddbd5@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77ef7df-537b-49f7-a455-c23295fddbd5@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MhHYuF7Otq+oyd6j8FmAWNOz82ieesuJMrDI4IKIKcRgq+Sxdno/vVkI
	HMwOyz9hzUl6Wuinscj4WTS2/hbdqHlSokG29vSKHy58eNG2pyf/Mz1VKT1HsEZeBZkqMBT
	7J7G4z2ALocABzNXn262mg0Zsb7ANBXU2Zuymx4KRtqA2lO/mSgL+WP50ExlEF+wa018AII
	MaNBtbPEE6QsTITS/Ev4w3cbSj8QtzMbZrvfKcOXBKQPeotR9KSl0TXPr144++DtURFqPUM
	HXBHCJ/5EhNH97/WS8fHTuyjiev2RdNunAhF2C+styzFBC3QqOwf2v9OZmh+EfPFQsU8569
	UNGB7Gz/OU38B0dMcYaYtQB5dY8E1TVX73aFmS3SKLWKXKRbdbXob1xiz4W4AMku/U9PVXu
	TJYZqSrf1tIzS4otK1IjIZZhU9Niij55jbUOkllRyXvfC/Y0cYkHYzUpNIi26P2a6rvNX1F
	RhRac4NVzt5napIqjTtfygJRvgB2JbkEpCJQe89Ru69glmsOfx05CyoBt6bA8QCtp1AbBNs
	jWJP3uwxhsjzUtQVHwV9/Gjo9t4jh8G8RV2NqYLCUokcN+zTLIZC9wEu16x33F0mG9KksQu
	kaPcqLxROHaAH+jGVxTJ2EyPi9cHP8padCUmvHXp32WXR1AHFHHrFlvL46HCNoNdzZwpg/G
	b+3uLBS0JN9eLrvusBb4+90NxRihV9YT/k1w++hVfHA+l3tYa1uEzET+GQXfvBB0MV1HJmk
	UsF+Wf4+ka7KX89IhxHIEhl4WCuwGVI9aWEZ+sjNpxbkWWWDIewZHy1QGFuF3GHBuisrSJv
	eMr0+N7mBvftM9txKZndj8/rCAvx/GxlllSmRupHY/SIELdR43fUlyczB60cBdiOdD0keGq
	o5NUoK0EAU/AFVkQFvSEr2n8tzr1zLblZglJHZUoJ0tJ6wyGGld7j9BY22sFCoAKAJmTyhT
	CmKOAHHC23IZA1KEnlMYNIJJV1Cs6LfD18TlVqOzfqQt14aYWCF4mSik5GtJ8RJjHUIc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 05:47:09PM +0200, Andrew Lunn wrote:
> On Mon, Jul 21, 2025 at 07:32:35PM +0800, Dong Yibo wrote:
> > Initialize link status handler
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  53 +++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  26 +++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |   7 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 139 +++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 187 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   7 +
> >  7 files changed, 420 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 624e0eec562a..b241740d9cc5 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -26,6 +26,15 @@ enum rnpgbe_hw_type {
> >  	rnpgbe_hw_unknow
> >  };
> >  
> > +enum speed_enum {
> > +	speed_10,
> > +	speed_100,
> > +	speed_1000,
> > +	speed_10000,
> > +	speed_25000,
> > +	speed_40000,
> 
> Patch 1/X says:
> 
> +config MGBE
> +       tristate "Mucse(R) 1GbE PCI Express adapters support"
> +       depends on PCI
> +       select PAGE_POOL
> +       help
> +         This driver supports Mucse(R) 1GbE PCI Express family of
> +         adapters.
> 
> This is a 1G NIC, so you can remove 10G, 25G and 40G from there. They
> are pointless.
> 
> 	Andrew
> 

Got it, I will fix this.
Thanks for your feedback.



