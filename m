Return-Path: <linux-kernel+bounces-853522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FABBDBE31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E22463534A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F231419A9;
	Wed, 15 Oct 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MU2FHFDB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD62AD25;
	Wed, 15 Oct 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487197; cv=none; b=neZ5r5r1ligMhSYNQ1tMbxtOBm828PtDM2TLx+U2W1qt3n80SqF3BF/pZNmjKY1YSDK+Af4JnwlEtDztSwXsRk29EoA6HjgLMMZByPo3LfecGfSFA7IeI6xMp6CKWK6XW+aa/YFVLFUm598vF/vMen0zAPShi+VXl0qlCrTDnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487197; c=relaxed/simple;
	bh=2XCvL+TgBo6eAVuRGaL654NaU95xhNJLH0t0ITDmVYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qubRTJbgofWv0xOYKBdvVACXIGqqFIaErhFqX8vwDlIaWh410f3UsanFybstfJ3UKlMbRgTDnlk/Sl/lgYucphgqt2XXY0CzHnJDgg2ibuPXsKjeHOOWqv8Tg0kru91KXQ2ImkjUxPYlBww5XGQZxlxmxCLfxY7NsSiRDrSiPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MU2FHFDB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2a11Ly75LEhJitU7lNgDTcJn7h18/2bw5D0PDGOg2uQ=; b=MU2FHFDBYBDD2Cwr2NgqvMr4FQ
	c97EMfO7/hKIxqVgd5c9mkR+mPAKvHv+FXXOd0/DcyhkYuHV7WnpPzpBCocQ4CMYHVX2Xaoc0T3NT
	ClOWqa/a0Ht0CtD5G5dKPi0tRsVA0PIMu/QljKdRLn7h7AH1MTzMGSqTYWOCUEuAxlT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8p8J-00Axwr-It; Wed, 15 Oct 2025 02:12:47 +0200
Date: Wed, 15 Oct 2025 02:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <2cf3132e-d255-48ca-b49a-f7b6303efe50@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
 <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
 <aO7RJs8ceO3mwjn4@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO7RJs8ceO3mwjn4@localhost.localdomain>

> The fuji-data64.dts was copied from fuji.dts mainly for larger
> persistent data partition (64MB), and the latest fuji.dts includes
> fuji-data64.dts (instead of vice versa) because we wish to deprecate
> fuji.dts in the long term.
> 
> So it is a regression for fuji, but fuji-data64.dts is a new node..
> 
> My original plan is to add mac3 back to fuji-data64.dts (which will fix
> fuji.dts) when the rgmii fix is ready in aspeed mac driver, but I can
> add it back now if we need to fix the fuji regression asap. Please
> suggest.

Yes, please fix the regression.

> BTW, the current mac3 settings work in real fuji hardware because rgmii
> delay is configured in u-boot.

Which is the second wrong in "two wrongs make a right". Neither
u-boot, nor the driver should be adding delays with
phy-mode = 'rgmii'. That means the PCB is adding the delays.

	Andrew

