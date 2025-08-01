Return-Path: <linux-kernel+bounces-753346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83670B181C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435413A5981
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A0246765;
	Fri,  1 Aug 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FYSr7UW9"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBB1C7013
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051340; cv=none; b=ZkCH0mCr9bnk7p5iyb1Q5eTgYxsa+s4qBtdtBchy8CVaKyZpZD/9R366m8HKPH8FuxdghMtRWEnXGQ/i6ZYkIe4iQpqjh3A+66bBuQBiQCppf4tV/+iDVmCyqPG94gBjylHEBiCvHuHo5Vx9D/uDnD+3Yi4SJ0f5wwcZJyrMbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051340; c=relaxed/simple;
	bh=sSldcBKyMda4s7gywBF3+fJ8Jm8QEToUi7VnHgo7DzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7H1bKu8xaPa6jGdJShvPohOwBfYGk9Bsgi2HMfSYIzYaHNeVIFZi7GNhxt67b+8uznuJrrVsEgjQtO7S1jdpHjXgIEBxt2pu/NwSSRUsF6TMk0wPuSvEmWes0NK/bEcNEl54gwNTgrPnk6fwcQCiTaSY+wAp2BCpARXVBF/584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FYSr7UW9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jPGIhqe96/NhKljG70LAM5nLqdyi/e6mWDk4sQJfH4A=; b=FYSr7UW9752D9zybwT9xuMvvuU
	r6J//HiNhCCcZVwQr2DnMag5qb+Hp6Fzvl7nc7IET+f47m6tmecvu9KsS8pEAAnYv7jFf9sqIoINJ
	+CjOuEryNrgT19qYBiciR+ayPrnYN+93T5Bqjkm7SalOJ4PP60Hpp6DMzGUQv6Iv79yQLOcCP/P9z
	WBJA5m5a9g3H96w6VaR3ftscTJzm47C+l2h+c+4/WyE8YzFnhalP559yo6lL9Od5jSocnmLNRB8v/
	IcTd2xWjN4TjmHAN5XExZvuHz9c0kAR3D6Z3ToWeU0y0vQ95WT7y1e90EGzXCwPEDXZN9OjAYqAnc
	/sVTX6ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhosV-0006TR-30;
	Fri, 01 Aug 2025 13:28:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhosU-00024A-2d;
	Fri, 01 Aug 2025 13:28:50 +0100
Date: Fri, 1 Aug 2025 13:28:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: irq: Avoid lockdep warnings with nested
 regmap-irq chips
Message-ID: <aIyzApkSjFc0ic7T@shell.armlinux.org.uk>
References: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
 <20250731-regmap-irq-nesting-v1-2-98b4d1bf20f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-regmap-irq-nesting-v1-2-98b4d1bf20f0@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 31, 2025 at 09:38:19PM +0100, Mark Brown wrote:
> While handling interrupts through regmap-irq we use a mutex to protect the
> updates we are caching while genirq runs in atomic context. Russell King
> reported that while running on the nVidia Jetson Xavier NX this generates
> lockdep warnings since that platform has a regmap-irq for the max77686 RTC
> which is a child of a max77620 which also uses regmap-irq.
> 
> [   46.723127] rtcwake/3984 is trying to acquire lock:
> [   46.723235] ffff0000813b2c68 (&d->lock){+.+.}-{4:4}, at: regmap_irq_lock+0x18/0x24
> [   46.723452]
>                but task is already holding lock:
> [   46.723556] ffff00008504dc68 (&d->lock){+.+.}-{4:4}, at: regmap_irq_lock+0x18/0x24
> 
> This happens because by default lockdep uses a single lockdep class for all
> mutexes initialised from a single mutex_init() call and is unable to tell
> that two distinct mutex are being taken and verify that the ordering of
> operations is safe. This should be a very rare situation since normally
> anything using regmap-irq will be a leaf interrupt controller due to being
> on a slow bus like I2C.
> 
> We can avoid these warnings by providing the lockdep key for the regmap-irq
> explicitly, allocating one for each chip so that lockdep can distinguish
> between them.
> 
> Thanks to Russell for the report and analysis.
> 
> Reported-by: "Russell King (Oracle)" <linux@armlinux.org.uk>

Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

please (also for patch 1.)

> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

