Return-Path: <linux-kernel+bounces-744750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A25B1107D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BF5A78AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FD2EB5DB;
	Thu, 24 Jul 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kSRcuRqp"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714B1B4F0A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379189; cv=none; b=kO74CsSllaXVv12SBNykrFng1mrwRKMf5yfbRi0zR7+VIHeJvLaeTxbEp0+fRqVe3FtSzWY8d2qfBshCAWgW2iC0WnxgmBXGhu7pYOf8aiyvjFeaQPs0IPedlVHu0dkQatGU/0ZYwFqoEO9CxVRNO353Eodd4wrjj5PxWAXxZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379189; c=relaxed/simple;
	bh=i/Kpz+Ste+Djqg4BpNd41PAeFUiI434DZcyDd+zWh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQtSFYTof51sJ2EBJTnZRo9cpaKCbRrA3tVzgpLOgpQsHPGsN9qHGke+8uvr8wKeFka2mCZPPVkcEQZBwKw2IPqFQMj6KvwEn+7TziLD6c1tZc8pI3pUG28r39kRtlpwIRtiihGrqxRrs+umr4I4oM1Cxz8RZA1mDJ1iClrvFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kSRcuRqp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZCg+1QoRbgtlHKqHHRGHpdwt2kaPrsylpaRAX7tlZ98=; b=kSRcuRqp2hSV2mCRQ5JKkdZmnI
	rChDz5dy7d9lgGVJ8iIjVuUvhVEi6Fj+1IhO1mNpVSnTSKrVDMuJBo5TxayvowmGemNxdNuWfx0GV
	3Cgf65hQMP8zGV5ajpGa6GN/K9sJS1XqkQyEQQfPTOw8g09CWvnc+duS64f33U8AklDHI1SlKXz4H
	4UOybKFir40fJsuqS68elFYqRNl5t4UDm0RRr2LMvzFwWtS0qtl2Xqtw2W6u08WH2SncRLmJ/Gz3e
	rVwf2vEn32V13KSb2CqvK5TAbTuZ1zW89R/mg9y2a/XCNj/65vE/jNeMXkGlpOj3Gozm+wfbJgCo6
	vP4mgNRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40504)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uf014-0003co-15;
	Thu, 24 Jul 2025 18:46:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uf00z-0000v7-0L;
	Thu, 24 Jul 2025 18:45:57 +0100
Date: Thu, 24 Jul 2025 18:45:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: ardb@kernel.org, linus.walleij@linaro.org, ebiggers@google.com,
	nathan@kernel.org, lumag@kernel.org, dave@vasilevsky.ca,
	ruanjinjie@huawei.com, kees@kernel.org, liuyuntao12@huawei.com,
	linux-arm-kernel@lists.infradead.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: allow single CPU configuration by adjusting NR_CPUS
 range and defaults
Message-ID: <aIJxVDBXyFgrz8AV@shell.armlinux.org.uk>
References: <20250724172603.18701-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724172603.18701-1-suchitkarunakaran@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 24, 2025 at 10:56:03PM +0530, Suchit Karunakaran wrote:
> Previously, the NR_CPUS config for ARM required a minimum of 2 CPUs.
> This patch changes the minimum NR_CPUS to 1 when SMP is not enabled,
> sets range to exactly 1 if !SMP, allowing only a single CPU setting and
> adds conditional defaults:
>     - default to 1 if SMP is disabled (uniprocessor)
>     - default to 4 if SMP is enabled (multiprocessor)
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

This hasn't been tested. NR_CPUS depends on SMP, so if SMP is not
enabled, then NR_CPUS doesn't exist in the configuration. Therefore,
providing a default for !SMP is meaningless. 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

