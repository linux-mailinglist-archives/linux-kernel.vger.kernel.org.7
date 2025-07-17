Return-Path: <linux-kernel+bounces-735820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5533B09430
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C322A62B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2824120E31B;
	Thu, 17 Jul 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l6U68Euf"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC82080E8;
	Thu, 17 Jul 2025 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777799; cv=none; b=QxBcnWYnCti8XmbJnJzwc6UE4kENwo17tSs6T1BXE7Iuc9iiquF1/Az35014WiaAvMeBobDGastPmfZrHPfvwfSVRXVN6NsoB7P79ES4zbkA2S4+179ckBXeOgvAYXc6240Xc4QUGAre7IFje5ZmRUeP7qhahAGDzhYc1eIuG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777799; c=relaxed/simple;
	bh=eZquciYh6+vleuLeXd4IYPIBpzHTbHmwoHPNlV4DzOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emI8MzkvmyWOnJyuMJqAxck0HFT+UCHpoUpxOG+GWfkKGOQf46toc1D3LUhBIzqk+XldOdAp2VT1Gf9WHib+TJZIj1riB1WINrKML7wy2TclKHe2MevDgwcbYaPoL8FS5N+NQkt1NjO3nvoq35VqekHz4wC/9WgwZkt0TqG10Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l6U68Euf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3/x82yAFtzziHM7W8fNK7hkRPGR6RbvruwUT9HdauK4=; b=l6U68Euf3t+0Go4pudFdhenDa/
	SAbohVRDEVKt4Seb5Lv4QX9VdKOGRX3NXPXUkHbpADWg2Y7u0YDUD/xnJDojQQdNIxwUdwJ11UWOu
	823JBeLpHGtfJ+VXvHtOU0vHZ9e+Wp0no/k9r05ziZNiAU4jfMzKS/U1NKTZunNBlMI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ucTZT-001v7k-CG; Thu, 17 Jul 2025 20:43:07 +0200
Date: Thu, 17 Jul 2025 20:43:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bcmasp: Add support for re-starting
 auto-negotiation
Message-ID: <c0de05e7-cfe3-40f9-8c8d-8b8fbee235da@lunn.ch>
References: <20250717180915.2611890-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717180915.2611890-1-florian.fainelli@broadcom.com>

On Thu, Jul 17, 2025 at 11:09:15AM -0700, Florian Fainelli wrote:
> Wire-up ethtool_ops::nway_reset to phy_ethtool_nway_reset in order to
> support re-starting auto-negotiation.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

