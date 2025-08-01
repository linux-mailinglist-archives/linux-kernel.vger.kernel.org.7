Return-Path: <linux-kernel+bounces-753348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717AB181C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717393A7B42
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41A246795;
	Fri,  1 Aug 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MsejR5Im"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535E23C51B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051357; cv=none; b=ZSOeKh/B5x43ccLLVR7kB7o3SDHf9tRf3ipRdVbZpjEHzrbYtFBLzpMm4gWixMGm2pzU6kCm/mFrwgnUKtxeejW9/jDolEhZcXMb55zjGMioJlIC92KcNJB0EKqc2XnYBb9wf8+h1bGVG6i6aEzHPLsU4hwcZE/EKSV3jZ+IN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051357; c=relaxed/simple;
	bh=9eeIsqJhN+R1RaTRmw9iYYQMEupvaq6UTGVW5EaQc5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWzp/cXUD5L1mR3syC+MEWIR1bMj3H4WKn7Yk0f7Gmzfs7sPk8qb8rH1AvXmCGHYjvnGM1s1R9cf8cNANUM2T/3jC6HvChIMi8csBchux3XDNpSkE2hyig8ciqqjav/MxACS0XdfTH6ZUi/uHLZDGi6p6bxQ8NuO5c022BPL+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MsejR5Im; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7x0ULyBro9Shm+25cvvQsGEKlK61nD7f8t1QjHSvcG0=; b=MsejR5ImqpPTLXJQboE4iY//GS
	xRGtlC1OlfvKuhjB2HCWeTzZ3QJ+5JEIDaTLS3wh6KoPfKmnOuEnXrDN1vpPVyxqfI/RdCt3covHy
	ln0LWmV7vest06PT4eUMgyyE0qG4CN2Wk+SCetXk9iW35tJI3vUcWU38Tyl00cIXBDz3AIh3ULqMR
	yEz97iT/KHj3gJ19/MxE6R1gofELbVZr7raCEdpI3JJs48hyXXgtsjudc9fkgrCTIAbMLWa3xDzcF
	PlBOU6bk/yMYmZ1kdEUdikYL7M/9qE+20GBvEJdiO2A05/5QWffQkyZO3hUx1R1sNbO8mXXY9qqe+
	UYIBfA3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhosp-0006Ta-0B;
	Fri, 01 Aug 2025 13:29:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhosn-00024I-2R;
	Fri, 01 Aug 2025 13:29:09 +0100
Date: Fri, 1 Aug 2025 13:29:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: irq: Free the regmap-irq mutex
Message-ID: <aIyzFa8E6gxlsQVx@shell.armlinux.org.uk>
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

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

