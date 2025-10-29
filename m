Return-Path: <linux-kernel+bounces-876936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2598C1CCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744A54012A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C973563F2;
	Wed, 29 Oct 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H05Mi14z"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6550314B85;
	Wed, 29 Oct 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763219; cv=none; b=rpwd7p2j8eahq2F2PTzyGgqsslp+oXuEiFH8dyh393HdPfPdn4uEv9SypZW/wakMuLn5BmsJ4Ba5LSSYZ7CuobB6Bz/OUvyFZFXGgK9gNLFyPX668GbWYSRXeiA9pjDx7JNPvrH9z3SFg2U33pLem75RH1vFtj0F8/Aj2k4P7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763219; c=relaxed/simple;
	bh=ihf290eU778Q2uR07iHtjf4aZKtRDXPFWn90SV1n7rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJtpz1XMI0o16QSfm9sskhVpfQugGMskrXE1QfkYr9YgpEUYzBfMjna7LKHZyWyeF3twLXHWwjZx314u+iHm6CwieZjLcgDGPcmbaH/oVf5vhyWeHfPkOhYkJW3+uGnnoffkxdZyqotUl+2mRWe40FXHQ7tr+P0zFTI7W3NSfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H05Mi14z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+wTQHXHEz55lZnVKQoEBXed9IwYEB/NZLENwFxT8JZ4=; b=H05Mi14zJ0Z6ChyO600PklZ4wK
	+F+forUi8wi1HEYgMNpHzeH6YhZrUPyMMXQMbi+5z1tsj4Wt+XQkqf9JoW0dLuV/zajkrUoTPicV5
	ry2ZJ9r6v+2Ukm60JHHaDlP4OPTOOJVebn6VktAa0oljj0WFHVN9jvrcXUEMtJV+H8JQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEB5d-00CRAR-Gm; Wed, 29 Oct 2025 19:40:09 +0100
Date: Wed, 29 Oct 2025 19:40:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: phy: micrel: lan8842 errata
Message-ID: <731889cd-1365-434a-8a61-928fe87858d8@lunn.ch>
References: <20251029072456.392969-1-horatiu.vultur@microchip.com>
 <20251029072456.392969-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029072456.392969-3-horatiu.vultur@microchip.com>

On Wed, Oct 29, 2025 at 08:24:56AM +0100, Horatiu Vultur wrote:
> Add errata for lan8842. The errata document can be found here [1].
> This is fixing the module 7 ("1000BASE-T PMA EEE TX wake PHY-side shorted
> center taps")
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf
> 
> Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

