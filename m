Return-Path: <linux-kernel+bounces-742340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCDB0F02A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A83AA5B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBE526C3BE;
	Wed, 23 Jul 2025 10:43:49 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9C23A9B0;
	Wed, 23 Jul 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267429; cv=none; b=UL4gzYaKQ/sQvRvCXY6836vOHHSBl7oiuJeOEdK1Y/gT1hgo/xk7wCC2+xN11JoVvZNmvHAl1UJTthCJt7CQgsoagICinievr/JjGheMqOm3Igkop/qqhGlmzz3g0P/1h+kbgbYByJitYq/ISl/zsIDDJTgd+oRRIftIPj8C3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267429; c=relaxed/simple;
	bh=CeNRvuvwYWoVJB5M5UHDRPJgLHidL2E1QaHeWDWNRNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnUYrnvXh46847FZ09E8hCwOP1IoaHM02QQr2Ighvp/iHwpRUuNi1CIFTDHvOyUOu3PgiDoxzWUw79KAMhjIt+0M6jdtVZMddN5LfhTbTKTBnLO3dzBCmQEElRwXdBlWkQF+aM2eEmkrGl0U0EZs74dKkyE179cvpRV8V6ykhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1753267343tbb65405f
X-QQ-Originating-IP: AMID40wbO4UnU89sYl62AWFs9G0YVjfeRYNVQgQgS8o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 18:42:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3337543533688690038
Date: Wed, 23 Jul 2025 18:42:20 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: MD Danish Anwar <danishanwar@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
Message-ID: <A7AE3E9B4297A2FA+20250723104220.GA981103@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
 <49D59FF93211A147+20250722113541.GA126730@nic-Precision-5820-Tower>
 <b51950c8-ce79-4b0b-af5c-bb788af33620@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51950c8-ce79-4b0b-af5c-bb788af33620@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MUtpDbzatTjwCtUQqgK5n1YzfGhnrSFgUELS1GUnZHOYYPiNWmhcFrce
	dXiYxx7swpHE6ep5yjxlO9emlwisg7N9iXKLBOupwtDm0en8ZjZSHqzKEcdgvoivXvwm5vK
	9549va6cb/OUc5nDobebt7PS5ERVaj/yzOkuYCzzaK5MiJX57Jf/rlkW1K8+LOWcU37Wzxh
	FOdSiwbmCNi5EbAkDPQ4GNduxAWbZyup1GqLJMkhnVyZHdy+Cggfxve12kNTEGffwJU8RAm
	TUpvHW0qs2cDnmhZI922mG0OSVlXVbzWeFcN1UjELVx7GPSTRYPfGu6iWb016yEkjconyxm
	nTGmcdPXIhD7o4+hXQzjC3jvJbDmVbTOZtpkpUAeRsKgZPttygKs0ZzBGtKOdUr6K2E5TCe
	sBvkPkGjJMCIFwruo3hDXpcZjQCt8R1MBHL1+VYisGFJGZbTqZGnK4Xx0eJoqIkMth7bXDf
	Bdz37SS+Tr/IW19ZsjY4l/VKlK26be8HNaxfNnnWSat/N3x7To0NCKPfyPUV25SBY0iUZKM
	jarCK3s711oMsYfC6AbywfiHtSZA0GFvyH+jGMvIbYNoivy5kbC3NwEqqDOvqoAvP4n8NId
	CtgY/uPW5uu1Cl/BgjvxgAqCTKWZNUxskOCFyI7pxltuWGtGA7pD3m82P+eu362/cDE8IHW
	hF325DOYSgw9JFlEpQTGBOzlPQEahjOBXxQzNDS/6LCLYRb6wLMohcJS2zofJiAR8mlAdRF
	Tl2SOWXDZv+UPZP/16DugYxYLDap1kdjbQZN3irxu0JXqFMM4+pn1wSJ4B0w4fCGQ25sMyn
	Z6cNS/I49lWZF10yg/gNSe12J4rVooA+Gp8ZtK9n1p9E5kKWq6c0kyhrGi1Oky43fKd1De1
	a+HvLg4iabtncSadAz6jm9pd4OK9lSWx1qD056aI1hOeibly5BrBhgtG8a/o5XiN/W+gmK1
	Zelh2Sgc1h6aykGkwjUpPZjsAmtnnWfy6lb8WIPIP9QTVk1F93EmMN5E5oLxo9bzkp/ujzA
	fd9s6zxiqFPMClXrevHiSpJanq0aRtnf29c4JHMevxw5I3wyPf
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 05:07:08PM +0200, Andrew Lunn wrote:
> > A series patches can be accepted without achieving the basic tx/rx
> > functions for a network card? If so, I can split this.
> 
> Think about the very minimum to make it useful. Maybe only support
> PF. Throw out all VF support. You don't need statistics, ethtool,
> devlink etc. They can all be added later.
> 
> 	Andrew
> 

Ok, I'll try to minmum it.

Thanks for your feedback.

