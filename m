Return-Path: <linux-kernel+bounces-809076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4EB50833
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411B94E48BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F5253F05;
	Tue,  9 Sep 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IMAfRLR6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536F24169D;
	Tue,  9 Sep 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453499; cv=none; b=tuV18KNATZ2Sy9gcsbAqTufHN44vGw8S5cORENY6gXadfc3QOGgPtoqyMT8n3pY3feMKatmghTKQMoR78MQbd4hKiSWHtu6YejHQLy15kBg8ZiqrKSlWjKnocmy6gI6avcQ7n0VChdfonhifIp3rgzaWB53QrwFbNiSfKv3waOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453499; c=relaxed/simple;
	bh=/JTfYqqLUxISlJK7dn0vUWCxTKB6MQbM0XgscKTtVTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m26T/Vv/0Waj5sVB59VXCfcppbqevaUbXK+u2YRewJlqDXv8JvprNzqCeFDVXQr1PofnTJRL38LfAe6ns+JVUd4s5hr9Z1ePfRcp6EZhRZEMITybgqSePfLsReu+MX2u/qYxR+Bj2QKjLxqeuGGy+jK2yW+2A+Y3S/inn9IIXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IMAfRLR6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=foiadcst+S3Y92KPZcC1u8rOc23oVP5IHFtiOAQaB1s=; b=IMAfRLR6YBvE2D13Xa6TiCsqUL
	B5hY2Rd2RTIoi1ImhTAIAPsSvHy9IxMF7jBroKpk40aCNwWOTR1cLm4kjrkTCNQ6F25aVa+sMD67r
	a8xnRVi69qDB6P4yhCzY0hlK0muAO08cdRWymHyM+tPBBKYDGkeOfzHx4OYiQM9tLi3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw5w2-007rYT-QM; Tue, 09 Sep 2025 23:31:30 +0200
Date: Tue, 9 Sep 2025 23:31:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: phy: broadcom: Convert to
 PHY_ID_MATCH_MODEL macro
Message-ID: <a40d1160-6980-4972-88d9-bdaf629fdb40@lunn.ch>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
 <20250909202818.26479-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909202818.26479-3-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 10:28:12PM +0200, Christian Marangi wrote:
> Convert the pattern phy_id phy_id_mask to the generic PHY_ID_MATCH_MODEL
> macro to drop hardcoding magic mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

