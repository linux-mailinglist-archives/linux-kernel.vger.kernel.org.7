Return-Path: <linux-kernel+bounces-652929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA697ABB237
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 00:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF61D1895113
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DF20B1F5;
	Sun, 18 May 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lI76qVLB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27109EEDE;
	Sun, 18 May 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747607379; cv=none; b=vDV08Q0fGhXPGAJw7+JN8JTLd8yNqz5z2Ul+FKr4N7zjUcNNxastVnp4jSCViW9HjhG373qc6ZgBsw8tcP+N8Txezp2skBE1FJgPU5nnfH6BzZCboDOHAKZTQUeFiNwc/IQCfHDsgiqeLK1DYRIJS/E7Eagj93dI1EYIlTR59qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747607379; c=relaxed/simple;
	bh=2In0kHnAfg+5SVb75arQZ7lTg/Kk+fg+MxcShokzEDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFLSY/BjJYjIYwn5K2TnA5TXqGXbz5+05eKPxzGOiQWtnGuUD6L+/PDI4/Fc2y5EVQqxCnzR8WCDGDljCU9iFjm6F91yjtspu0MJw4PV6/YJHf+DwExKyAH9anujcbodp5lSNDnDwzxRpNghGAPZ1lkZ0MU6K9I1kS32f0LOFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lI76qVLB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=blXc+PjhMWMuKNRHhUtWKzj+Q8nTMGDMyNfdw8YIkLM=; b=lI76qVLBt+qbaDXhSkIv8PnYgh
	5/wZ3XME2zoDGCP0Y/+Ln54XIRFvlkj2qj0u/U2VFcDwtpJeQyO8+nGtDvu4jVyW6g+kc5YAqYO8l
	CVW5C2AzUWFZ6Dko9+e6sCRSg+odYFMn5YYaVfxhRWfQMGwYZ1QszBoyTDZF745HgaF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGmVS-00CwlM-HJ; Mon, 19 May 2025 00:29:18 +0200
Date: Mon, 19 May 2025 00:29:18 +0200
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
Subject: Re: [PATCH net-next v4 2/2] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <e915e555-acb5-41c5-951a-935f21f357c7@lunn.ch>
References: <20250516102327.2014531-1-SkyLake.Huang@mediatek.com>
 <20250516102327.2014531-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516102327.2014531-3-SkyLake.Huang@mediatek.com>

On Fri, May 16, 2025 at 06:23:27PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware and add appropriate time delay to make sure
> that firmware works stably. The firmware loading procedure takes
> about 11ms in this driver.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

