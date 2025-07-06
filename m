Return-Path: <linux-kernel+bounces-717291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E94AF9268
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA313580E86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164992D77E8;
	Fri,  4 Jul 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J097Db1w"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EA2D640C;
	Fri,  4 Jul 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631706; cv=none; b=XnIbRiLQ0iGqKO+q/w7igjzxdLcy3U15F2GnWlcVlt27AaXbxEQkQ2JSWSqULeDFdE2B+DeKktakrx1R9bJYtPxhFD90GcNdvT3IA/QyzxR68O77bF0ZuthKJG9NHopv82OdlfY+5Xvfk0LkyXpP6Z90RZCuJvQGjGFc5dOdvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631706; c=relaxed/simple;
	bh=8a4JE7cC0D+vkHlLbZY2UU0DDIew3l1nNVFssbZ4h8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpnhbrNwTrecvEaVMpeezHRbSYreKgetspFmN4LcxG54J7WFeQFlPfTDx+nA8lSCujBoa8o5JK0yx+J5d3EKraK9ywEtk1MkTmJ3lGrW7ChtB86pIKTXN3/V8Q3bUsgYUj8rd0UDpp45HQTzNtz9MSLNspF7mk9GuYxKZSb0Kzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J097Db1w; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283F2443D7;
	Fri,  4 Jul 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751631702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14yiLbluiFffVexpfXmhgolj33cjrEQatU2sWBvTEdI=;
	b=J097Db1wBFOvaRrjiF9azT0bdbkQY94mrPe7zYjitUqSWMfDesYbvsacSuyVVdFQBMdhwg
	H5h3R65CFuckmQ/22cfTk8dwQIbbo4DefNPG5iBIiBtLUSW7Wwzr9OKqv4ljrAxqgIoiob
	BXXAWBL0dotvhogtMiDID5oPru3xsZLM3wD6R26Fe6rNW6pMjPmn2exXLYpjORajw23luG
	sy7osrRw0xoLiFKXrxLrw+Fc6PLu8m/oAhlOSifFzkHeKnmGXH7DTKbnpWEadmujxOF8Rf
	OpIwn4FtYuUWSHHs7ibiBZ9lsqsLqA9X4pVUu4IL4n1kEEtLkIYOeyBtHoh+Zw==
Date: Fri, 4 Jul 2025 14:21:38 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Sarosh Hasan <quic_sarohasa@quicinc.com>
Cc: Wei Fang <wei.fang@nxp.com>, "andrew @ lunn . ch" <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, "hkallweit1 @ gmail . com" <hkallweit1@gmail.com>,
 "davem @ davemloft . net" <davem@davemloft.net>, "edumazet @ google . com"
 <edumazet@google.com>, "kuba @ kernel . org" <kuba@kernel.org>, "pabeni @
 redhat . com" <pabeni@redhat.com>, "xiaolei . wang @ windriver . com"
 <xiaolei.wang@windriver.com>, "linux-kernel @ vger . kernel . org"
 <linux-kernel@vger.kernel.org>, "imx @ lists . linux . dev"
 <imx@lists.linux.dev>, "netdev @ vger . kernel . org"
 <netdev@vger.kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>, Sagar Cheluvegowda
 <quic_scheluve@quicinc.com>, Girish Potnuru <quic_gpotnuru@quicinc.com>,
 <kernel@oss.qualcomm.com>
Subject: Re: [PATCH net v1] net: phy: Change flag to autoremove the consumer
Message-ID: <20250704142138.3f1a4ec1@fedora.home>
In-Reply-To: <20250703090041.23137-1-quic_sarohasa@quicinc.com>
References: <20250703090041.23137-1-quic_sarohasa@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehquhhitggpshgrrhhohhgrshgrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepfigvihdrfhgrnhhgsehngihprdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpt
 hhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 3 Jul 2025 14:30:41 +0530
Sarosh Hasan <quic_sarohasa@quicinc.com> wrote:

> phy_detach() is not called when the MDIO controller driver is
> removed. So phydev->devlink is not cleared, but actually the device
> link has been removed by phy_device_remove()--> device_del().Therefore,
> it will cause the crash when the MAC controller driver is removed.
> In such case delete link between phy dev and mac dev. Change the 
> DL_FLAG_STATELESS flag to DL_FLAG_AUTOREMOVE_SUPPLIER,so that the
> consumer (MAC controller) driver will be automatically removed
> when the link is removed.

This doesn't work unfortunately, PHY devices can be hot-swappable, e.g.
when the PHY is in an SFP module. In that case, we must not
automatically remove the MAC controller driver when the PHY goes away.

I gave this patch a quick test on a Macchiatobin, which has an SFP
module, and indeed when you unplug the module while the link is up, the
system hangs completely when running a command like "ip a" afterwards.

Maxime

