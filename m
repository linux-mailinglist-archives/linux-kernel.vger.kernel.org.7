Return-Path: <linux-kernel+bounces-834090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63321BA3D53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B3D189B5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB4B2F90CC;
	Fri, 26 Sep 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bAxUBVms"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68B2F60C0;
	Fri, 26 Sep 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892451; cv=none; b=D74WGLhGR5hSDprg0H2FaDnR8XXFDxKsJJFx8XpI3wN+UTWa4xaCt5SVMisOdCKkH+qyoK1RqChNewu0UjPDQr/spNvNHALZpH3NTscmKmhg3sh+bBxRsCVP3Jd5SNyc/xMqAJos5A7CEdYmcQZTkwnry5c0COdavWSUodnKhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892451; c=relaxed/simple;
	bh=QFy5Xugv7IuXmF7OnZ3unWRPjWRRxUAInaLATPWisLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caLIVpYlbNTeqLaSkVSoYH0EsX0+ovAalMn5ypEQYmQCRAXDFZrQOuX0YyKAj0MbcBhRN5pDC0hkF2WR6nmXMBm5XikbIB+hj84IRE7antv+VvSbjpnQ9QlaVuaPoytNeBzt2VZK00m6WcQ1e3lBUFLpr0wp1PiARkcSH2S0qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bAxUBVms; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kvU6KD7Ak/321B2u+fHBnh40uEfH4ng9JZ8nC2TDsf0=; b=bAxUBVmsN253AhMCtPQUHqMIq+
	QGk3woA5i14j6ZrLUoOzYYFzdnqQnmpMo/GKyccGGnv01zquk9TOyvQQeNGR+yVcs9l/5+ibX2SjH
	AAw+jHRo/K961zgv5jmm2OgLlSQjsgPiwYTbjpFD4GAP7k5cnPb/WbCOMeR7s8jdTMak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v28Gt-009Z4n-OX; Fri, 26 Sep 2025 15:13:59 +0200
Date: Fri, 26 Sep 2025 15:13:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>,
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>,
	basharath <basharath@couthit.com>, afd <afd@ti.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>,
	srk <srk@ti.com>, rogerq <rogerq@ti.com>,
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Subject: Re: [PATCH net-next 0/3] RSTP SWITCH support for PRU-ICSSM Ethernet
 driver
Message-ID: <383e4a23-447e-4024-8dc9-fc52ea209025@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com>
 <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch>
 <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local>

> No, this patch-set applies to both STP and RSTP. The driver and firmware
> responds to the port-state transitions and FDB operations through the
> standard Linux switchdev/bridge interfaces, with no STP/RSTP related
> logic executed in driver/firmware.
> 
> We referred to RSTP in the commit message as it is our primary use case
> and it implies support for STP as well.

I would not say RSTP implied STP, because the higher level
implementation is very different. You need to know the low level
details to understand they use the same driver API.

Please generalise the commit messages, mention STP as well as RSTP.

Thanks
	Andrew

