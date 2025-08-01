Return-Path: <linux-kernel+bounces-753344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45245B181C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD191C82A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD4246765;
	Fri,  1 Aug 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AFXNTs3A"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB81C7013
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051279; cv=none; b=ekfg17LZzH8ijxV0fPJBZC9jy80wg9xjwSBELY/88RhbMTeaEq/5aiLCwhvfzp5IDl2bbAHenVwiA2FIaMQW5DptdAUd+UIP3No3AXODui9tMyaRHugoKMe4rEk2/7EPcjxkS3rBJL1iyWngaSX0mWSMzWhKZcpD1Fdba77Sybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051279; c=relaxed/simple;
	bh=9fjaB8q92PSylWUwgTHJDteTgk7aHzr3FAI7y7Fog0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtUCZ8T5vAVgAQuTeBgmswutr6BYy0OFTpdcDJX2MAi9rzdfBU9foLcQcE3/o5ltvTtjUb+y73yAa0ImEiMgmzf3r9JcnbfMD95TM8cpuiqkFiGzMIaM5FA1Wx9B7EJ1MrZo5BbpCKbkWInsLHNGJ0Y+iHa88QsbZvo9k9wnhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AFXNTs3A; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cEN0JJsvr8GRy/ak6bdO4Daz/bkaIgSo5xZNbzWXujw=; b=AFXNTs3AC4oWpUXzfDDQQb0m5D
	y6ge+DsTSPdvmG0aMlL9r0cdbNv+EkWV2DJzTRDZCJ+70wTpuW8oM9MtFSNZz0QaNbLTLpbgDUtTj
	FWIEgNJrobK0l5tXKANb0Rflgp3txsfSqhYqHHsD0t0JIpAuwmkVV9cJrFz7VF2s0uKqzss6Akoxe
	0OYDfrPv6teXBsnI8JATPoaiwzRyl1C8ZLj3UXtMHZZAKN8mMOMj2084IBHdR8ArNIR58xXHJ72Nk
	AywWUZZyt/87qeC2meJXoQr7YwLXEI2lR9HhLSZp2Tg4nrY8BE8XrFaZB3khiGjz1QS/x3osazuXz
	rxV395hw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhorZ-0006TH-18;
	Fri, 01 Aug 2025 13:27:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhorY-000242-0G;
	Fri, 01 Aug 2025 13:27:52 +0100
Date: Fri, 1 Aug 2025 13:27:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: irq: Free the regmap-irq mutex
Message-ID: <aIyyxwkGEGPRUUwZ@shell.armlinux.org.uk>
References: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
 <20250731-regmap-irq-nesting-v1-1-98b4d1bf20f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-regmap-irq-nesting-v1-1-98b4d1bf20f0@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 09:38:18PM +0100, Mark Brown wrote:
> We do not currently free the mutex allocated by regmap-irq, do so.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

