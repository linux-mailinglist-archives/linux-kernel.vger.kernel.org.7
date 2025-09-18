Return-Path: <linux-kernel+bounces-748620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A37B143C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8033E18C153A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACAA24BD04;
	Mon, 28 Jul 2025 21:16:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D22E3708;
	Mon, 28 Jul 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753737407; cv=none; b=cYE1z7KTAOrw67CfAelfNgHt7N0ez6zLqkNlcfys8zr6YZrD4B4XQMyA4NYvZNBNsh3sZpkxfHlIKUBgzteb888XotsUFrhyWvzPpld3/Ty7+B5olhuFHI1WqWTv9jPZYzd7myH2aea1/rE5zBHqRowynbTsKGZwf/KDNdwDvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753737407; c=relaxed/simple;
	bh=2SB4hOCTjHPnC3ATVq2epJBl8eMFjsjXYNTEDrr7BOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE+e7mNbI8iQuTNUQGmWjnrElfQEle8nxRePouI/huVqgN6u7XbsTU/vX44Ai+7tA6DxQLXaEany1WtrDyAcSXVVMe+CO5rO2gLcPJALpmE02PlUuMS+gBWcgX00tHfaxqaVc9QOnX9+bSobRJVj7VmCN2BV5IZBFhOF21mbnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ugUjt-000000007gU-1tQG;
	Mon, 28 Jul 2025 20:46:29 +0000
Date: Mon, 28 Jul 2025 21:45:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Robert Marko <robimarko@gmail.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-kernel@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jul 29th
Message-ID: <aIfhVdMj1K6Bd2-F@pidgin.makrotopia.org>
References: <20250728085356.3f88e8e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728085356.3f88e8e4@kernel.org>

Hi!

On Mon, Jul 28, 2025 at 08:53:56AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> We have one agenda topic - Arkadiusz Kubalewski says:
> 
>   Wanted to meet and discuss the need for clock id on microchip driver
>   provided by Ivan, I hope we could have a meeting to brainstorm some
>   ideas and decide next steps on how to deal with such cases.
> 
> I can also provide a quick update on the netdev foundation activities.

Christian Marangi and me would like to join you this week in order to
discuss how to proceed with the groundworks for standalone PCS drivers.

See also:
https://lore.kernel.org/all/20250709135216.GA721198@horms.kernel.org/

I know this is kinda short notice, but it would be great to add this to
the agenda and decide in which direction we should go.


