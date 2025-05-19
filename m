Return-Path: <linux-kernel+bounces-652930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF3ABB239
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 00:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99E71895E59
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260A20C030;
	Sun, 18 May 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TPhk9FKQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415AEEDE;
	Sun, 18 May 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747607399; cv=none; b=kSV5FO6pEcbvjZ95V+BQjOYhocjHvDS/wGmo6NXMrKu+IfYUkxMFrQ4DB9xGRIrAipmJnG6XUzSCuwyOuFwPuPPId5IhESgtcpDWnPS1UPwlHOavKYsXe7Yd9t6S2EknqJkXBda7zGsns/H5a2x6aGm3q+ZWw4RaFbI5mpX9sgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747607399; c=relaxed/simple;
	bh=/LDLrFd/qRB5TDaSbEks0Y7UGi5ZYJroSg6b/oozF7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0INRmh7esBf87FfqfoucGj8xzy9ndQhDttL8+s9P2u6bwap3PhPIW9wBq7yLsj2aXHIbRJDTQwrzSx6Bh9y5QhHg7hN+GK/b/KVX4fsygw9MsvlckAZORXJYRa1tjaemObF1ofiPDCEE0LD5S5R5gJTZsusTT0ND+olRrY7D6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TPhk9FKQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LUyR0Gqfod1ZUhFSOfGOtDGNy5URQgdGLeuFUS65lZs=; b=TPhk9FKQLGRcZ7CBwjL+2ijL/A
	R3emg6Sc2H0qslPpVk1LMkzFuJM5fHTG12dSBIFQp5VHNy3zfpZTnaWouBph3jT0W2sb0NVq1z4vW
	IhfUkWzqOOdVRKbpfZ5vDdU5so24AYG2PGEFz8LTqzuOg9+mesYwAx3//n9XTnuR5XHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGmVu-00CwmK-Jy; Mon, 19 May 2025 00:29:46 +0200
Date: Mon, 19 May 2025 00:29:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v4 1/2] net: phy: mediatek: Sort config and file
 names in Kconfig and Makefile
Message-ID: <d38c3678-92f8-4a5e-a1ae-a205e44d99f4@lunn.ch>
References: <20250516102327.2014531-1-SkyLake.Huang@mediatek.com>
 <20250516102327.2014531-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516102327.2014531-2-SkyLake.Huang@mediatek.com>

On Fri, May 16, 2025 at 06:23:26PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Sort config and file names in Kconfig and Makefile in
> drivers/net/phy/mediatek/ in alphabetical order.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

