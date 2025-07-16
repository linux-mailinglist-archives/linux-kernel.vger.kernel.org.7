Return-Path: <linux-kernel+bounces-733389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A115AB0740F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136AB1C2429F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73EA2F3C24;
	Wed, 16 Jul 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O2NmZYy4"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2A2F2C5E;
	Wed, 16 Jul 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663299; cv=none; b=fJoDY+FIoUIGQTyNqDKAuPWKi/niM4SO13F0lJIQU+r/zcVhvHAdRiGCJaOvBZ9TOe/++N6fmyrIdKnUjdQe7WpSVS2DYlCqWNNBRSZmAvucmOHLAIuGG2iJv5h+z6fJ7JjK73UbVu71ka2GSOikX2QYbfDZpClECs7YryAeZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663299; c=relaxed/simple;
	bh=6CWMTEKFA9BNPeS8O4sm+Lz7bxlyumj2lKTepr/xdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAXJKllCSWIrou/rPMS8ZcNBRO7k13iV1gXquyeFNu3OopkEOReMVepmtP1aZ3yqyE5BU48fkoqdVUv3NhCNLNn1APJmPWY5zBBbxna7yjAm9f8pPYyG0EU1iBeFJS4CsAKQiQmvugGkqHXSSBEqpsqbudqPB5e39yoCd7QQDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O2NmZYy4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q1g2FEiri82kpKPEVQdgX8TbYvRer7HOD7LN+607hMw=; b=O2NmZYy4qqLsZH/dGAq4aevn1J
	yCdUPR+omgLMmaSEzjPdJj65ZeZA9RwH7pqqABtY+6EoYwwXUxhDXWMIpi9zvo+r7USw3VxcZqjiG
	E0Ka6i4P+SzORzJrV4g2M+H72G10I57nbSPWyv7ig4jB2Infi0d265B5s2IKXgJ8NR+HlKv4qrFoo
	QC07CNP8OeqAmraa00+NVGerNZAu/4dsvWFPlJGI0LpiZ849vYUoZR5RS34qlK19mDY4l+QDsT+id
	Dx3TpjPursBpIeQITaC57EkVbj1Btzbw9zY88dUSrPgQqjQ78HMmhlfhTJbat8fS3d/+LTeXCIdDS
	casWQYBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58780)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ubzjm-0007xR-18;
	Wed, 16 Jul 2025 11:51:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ubzji-00013x-0X;
	Wed, 16 Jul 2025 11:51:42 +0100
Date: Wed, 16 Jul 2025 11:51:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Phy with reset-gpio fails to read phy id during kexec -e
Message-ID: <aHeEPh9-itz4nGYH@shell.armlinux.org.uk>
References: <ab95299d-d986-4e2b-9464-44e3467556e3@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab95299d-d986-4e2b-9464-44e3467556e3@windriver.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 16, 2025 at 03:55:30PM +0800, Xiaolei Wang wrote:
> Hi
> 
> During kexec -e, I found that the network card did not work when loading the
> kernel.
> 
> I found that some phys used reset-gpios. When kexec -e is running,
> the network port will do_ifdown, and phy_detach() will be called at
> this time, which will call phy_device_reset(phydev, 1); to keep phy in
> reset state.
> 
> After loading the kernel, since phy is always in reset state, the mdio
> controller fails to access phy id. Therefore, if phy uses reset-gpios
> during kexec -e, the network port will not work. However, I have not
> found a better solution. Can anyone give some suggestions?

Honestly, I fail to see why we give the kernel control of the PHY reset
signal. It causes masses of problems, mostly centred around exactly the
situation you're seeing, and we have to put workarounds to encode the
PHY ID in DT. That then leads to situations where, if the PHY is ever
changed during the production run, we need different DT files, or we
need boot firmware modified to update the DT passed to the kernel.

I think we need to scrap the whole idea of placing the PHY in reset.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

