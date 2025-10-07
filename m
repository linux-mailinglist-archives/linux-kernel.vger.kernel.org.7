Return-Path: <linux-kernel+bounces-844514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50BBC21D1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A423F3AD52A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA22E7F30;
	Tue,  7 Oct 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zspHA+iW"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E911712;
	Tue,  7 Oct 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854491; cv=none; b=WEkElFROq6R2PXvBNJJGvNEbYV47C+Dp0DYTfWdPBRQuOb0rR3yDYkuhN1+EK4aGBzLNiaj2YvuDp9rgY5eKWjrPfHu4kiCAAkExzvgKEgVoQTtYMWr4n5aw2dSeAt9WlF1zI25TxLAGTY0H6OMkUwmr3T8xAwf6tUImnhxEMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854491; c=relaxed/simple;
	bh=6FLy1wq268733luOmRwct1kCS6sCeSZUwKr5j+mJjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA8goIHtW2qDggmy5xI7xZiGEfofByC3QzHdjr23u41LqUpu81YSol7rxAgJuASyGvCdXDc/bhYVoAp1mi8OfvZxN24ohcojuL25GM5VmEkYGEftb0VSu4BIyXKa4DQzVsqWSGYTRBIZOUGcUq4Tr7rOQUKc6pcBxiBLwEQKNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zspHA+iW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CSdeUl0+Wlj3wrQusnKRTtGq1C5jdr7eduitM3MGZgo=; b=zspHA+iWPxTcZTxT/Je2B4G6tw
	v534xoaaXgJXV7v2hC90Zwk4epC3hYCX3ntpzHLoS6snCOfo02fOfHMWw8lGqVd/V0iQjfqrfo9aL
	S0dtRxcKDb0X7AOyf14bE07Uf9IvbJsrcNnauB3jzCZSrvz142bz40vvhiUkiOy7ESb7t8EaexArE
	vl5J/TnKfxTKNnfJImi4I+X+4nLUXDwTydF0ccP/m15Khrii/uUE2dj/jKnj5Bz9xx4b+7yRWQ63o
	w7NCEmkPmM0sFRQHO56bXcVcX+jWImi2kDXUWcKQ+sdu9L0hlp1i//GhivJwMeWTjyWbX2eTamTtk
	PqFESXUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53078)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v6AXV-000000005Li-4389;
	Tue, 07 Oct 2025 17:27:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v6AXU-0000000032l-0FFc;
	Tue, 07 Oct 2025 17:27:48 +0100
Date: Tue, 7 Oct 2025 17:27:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: jjm2473 <jjm2473@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, jbx6244@gmail.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Message-ID: <aOU_g-47JEycc8ZV@shell.armlinux.org.uk>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <DD57IZJQ4FQM.3T5791FLUQ8KQ@cknow.org>
 <CAP_9mL6+uoeG7LX8YCcUFjoU13De1CdPFqxNNfoJvOdsOrYo5Q@mail.gmail.com>
 <DD63EEOKPWNV.3IK12D6CFPTQZ@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD63EEOKPWNV.3IK12D6CFPTQZ@cknow.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 30, 2025 at 01:19:21PM +0200, Diederik de Haas wrote:
> On Mon Sep 29, 2025 at 8:09 PM CEST, jjm2473 wrote:
> > I have another question. If there are reviewers or co-authors later,
> > do I need to add it to the commit message and send it again?
> > Or should the reviewer or co-author add the message and
> > continue to deliver the patch?
> 
> When you get a Reviewed-by tag, you should add that tag too to a new
> version. But there's no need to send a new version to just add those
> tags, the tooling used by maintainers picks those up themselves.

The only exception to this is if something changes in the patch
after the reviewed-by tag has been given - because changes mean
that the changes haven't been reviewed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

