Return-Path: <linux-kernel+bounces-791542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B381CB3B858
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054291CC04D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0E3081C8;
	Fri, 29 Aug 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="trC8TmGG"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895983093CB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462319; cv=none; b=Ac2x2TylogHwVH8biP7e0XuTVF+yJqo1P71YvzMet5KMY3xkKRGRutY93IOAecdHfEgZKnQYw8sv9TTaTCbJJoTP9Fkvsqfh1Dj7hL+UGbIjAdDQO0KJLgyU3mnr0bcO1R2Mb04XcNPeGj9db8YCdCL5Je9p218r4kV/k5sv0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462319; c=relaxed/simple;
	bh=M5mqqu6lY1kpvsliyHMCkk1JVMsBobZ+0BTdJ715Qz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzdm7ElXtdJY1KxLpxAF9AgJBAZ3G6wNBkv092DhGUdL264Gk9DLocJTYhnV7QWMDtlfVTbN788x+dMO5fH9CKfyJfpSyvomJ1rvNR4mlkRMJykHaIro9Xh1ECRCVXNMhct/vW1YxDNTV0VA9cfQQSnLNUu9WA5+TIy4SlETHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=trC8TmGG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HLKEYWCOQmMDQNx/pwPo3zfJS6SvTUi5l0tmvLYsX6k=; b=trC8TmGGWkV8XmJ1xRQnsYuKML
	M0TU/7fG2aZwTUA+lL6h1cxZ8BsaytI/TiRCPNmG8nlnjdvH9iK7hEKQL4AeDagDt7Cod89RU4L5t
	hLT9oh1r3vaBMAPOEzZ6VDgkp6stVbN9oNlZBfpjqpXOvSDzjQ48Oak+ZbJWg2iaFdV9+JH1QDOmN
	ZDJGVkRtkBBir9MO/9yT70Nd9I0nm+77chksqmliT9JEuAKmIAQHEUOgPtEFG+bFcDzCg1inajMs9
	JNzSE547v35E7KyQzppx9BnLh5YOYkGBd2k4pXpvQHiiRi9ZbJprblv8goc7zd/EbL9fkJhM9n1U6
	l72bP7qg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47766)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urw5I-000000002dF-4159;
	Fri, 29 Aug 2025 11:11:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urw5G-000000003yZ-3YcK;
	Fri, 29 Aug 2025 11:11:51 +0100
Date: Fri, 29 Aug 2025 11:11:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: Ensure the override of
 module_arch_freeing_init()
Message-ID: <aLF85tovbkn5vjav@shell.armlinux.org.uk>
References: <20250829090726.834456-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829090726.834456-1-petr.pavlu@suse.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 29, 2025 at 11:06:44AM +0200, Petr Pavlu wrote:
> The function module_arch_freeing_init() defined in arch/arm/kernel/module.c
> is supposed to override a weak function of the same name defined in
> kernel/module/main.c. However, the ARM override is also marked as weak,
> which means that selecting the correct function unnecessarily depends on
> the order in which object files with both functions are passed to the
> linker. Although it happens to be correct at the moment, the proper pattern
> is to make the ARM override a strong definition.
> 
> Fixes: cdcb07e45a91 ("ARM: 8975/1: module: fix handling of unwind init sections")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

LGTM, please ensure it ends up in the patch system (see signature
below). Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

