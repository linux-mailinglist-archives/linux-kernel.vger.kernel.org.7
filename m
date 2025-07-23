Return-Path: <linux-kernel+bounces-742678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FBB0F543
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141A51754CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2342EF676;
	Wed, 23 Jul 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Au4h0cym"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3311E1DFC;
	Wed, 23 Jul 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280920; cv=none; b=bgFxBtJvkIG0KainXRwhWcsc8kBKMJY59QCrIKYtubcpq80VUMYdSQCkUpKpeD+PIZS3xGLLNrMEQDP2tG8gxfNclWV0qy1XtibvSEfZJIIYhvjiNJFUPRekQqzqaSN/YIHpKs4tCs7vCm/xW+4+qoBHeWYiyKfFHH3Fk1Ra1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280920; c=relaxed/simple;
	bh=Bb/XIIaBN/0UhJhFGasC1pbKYzuf1LGwlcF6he+lC4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsjMXyxikpK4vZqwHLYVSlsEa43/FCnK9fQE+Bh8dYa4RjRRCOl5hX/n/JzE1pPL0Wt9FKEjToud7YwR24/umudvN7OtGW8/Lr2zgaoyckBzLqOC2SB8Hc2ESJNLQB8qG9xVqDr6738tYFr3dJ4G4Z6cBLuYGqQrobOyBTCxsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Au4h0cym; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NfOvOHP63AILH7Fg86c4DTpSZG2INn5g2Y9EbzDcQfI=; b=Au4h0cymEHwbvqdy1U5OzLXKP8
	lxekCJGo9MDcb4q1YihKBjPs1gnbSa8Ahr8C6RCbErZ9NbPBXj7kIZvCony+YAjf1TdaZhYEfdex/
	Az5Bb9zcjUfNVrH/i10CutlMqVZIZGAepCijdWaxMz0MdlRxqHuLmxQOJX0F5lXyz6NU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueaSL-002bFe-Ec; Wed, 23 Jul 2025 16:28:29 +0200
Date: Wed, 23 Jul 2025 16:28:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <d4bbca28-5ba9-403a-8389-da712602af68@lunn.ch>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <aIB0VYLqcBKVtAmU@pengutronix.de>
 <20250723090145.o2kq4vxcjrih54rt@DEN-DL-M31836.microchip.com>
 <aIC944gcYkfFsIRD@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIC944gcYkfFsIRD@pengutronix.de>

> # FLF Behavior (Immediate Failure)
> An FLF-enabled PHY is designed to report link instability almost
> immediately (~1 ms). Instead of trying to recover silently, it
> immediately reports a hard link failure to the operating system.
> 
> # The Disadvantage in a Single-Link System
> 
> For a system with only one link, this "fail-fast" approach can be a
> disadvantage. Consider a short, recoverable noise burst:
> 
> - Without FLF: The PHY uses its 750 ms grace period to recover. The
> link stays up, and the service interruption is limited to brief packet
> loss.
> 
> - With FLF: The PHY reports "link down" after ~1 ms. The operating
> system tears down the network interface. Even if the hardware recovers
> quickly, the OS has to bring the interface back up, re-run DHCP, and
> re-establish all application connections. This system-level recovery
> often takes much longer than the original glitch.
> 
> In short, FLF can turn a minor, recoverable physical-layer glitch into a
> more disruptive, longer-lasting outage at the application level when
> there is no backup link to switch to.

Fast link down can be a useful feature to have, but the PHY should
default to what 802.3 says. There is however:

ETHTOOL_PHY_FAST_LINK_DOWN

which two drivers support.

	Andrew

