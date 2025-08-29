Return-Path: <linux-kernel+bounces-791694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B7B3BA38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B551C86DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A52D77F0;
	Fri, 29 Aug 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FbW1SI+O"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35152D0C8D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468270; cv=none; b=UryCtJD8OUBBXpBQxye3sKthoo6ho+Eo3przL5ViOPiZf8BvQOOUUq9VJRAo16NHekqP6RO9YA1PboMm+U6r3ghHLF1ifOdPDyGLlIYgW+SqpCaV9rH+4tJsjaFOxztcU3uYDzwRuQVfA8lIU0jVePylYw+hLyjWXp/HTlT/BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468270; c=relaxed/simple;
	bh=lM0TV6yWIxE28nX20JUd7XOJHQP1vSBHIkCdkDGxhOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYVg/RzPIw89snXxdgI4d6lrvcnuU8ewuQZZ5pE/y/pl1qzh9sIVbq1Bo07b6dtKYD2FdaWmCZ1ONW1WViWicsC1TG/VFpy8zXh2uhPHxWXuFfE07ZlOUCxPalemJO3QD+OnGb+3zERVb/eA412tj3+SPS9vxmPguIzeEez41Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FbW1SI+O; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=JIXe
	PVtJ1yEilNa7lXXAyCenfguPQ1RpEBwJ2aRyeSc=; b=FbW1SI+OuFQD0Yxh41AL
	WrHpMqYquPfWtaG2t+4So+hI831DlQfGhaCwEBZrDBAsAlhnfmKnYod7upMaWCZS
	o8ld1dNCJpeyCpvrPbqqPzTzPCOPr5+o3ilfxlgTrAPHWa/G9N7b90ENREYrnhew
	cI8re+s56olhwok8QDBgpnLF4DAIOxRgj1oUvckzjGLfDbrSAoaisccuomZxbjKG
	kYQ7VOwlT0MAZuRLhdjT40tkFn6H9fvKt3+2r5jlzyLOj/gHfeqzFxWuSEOZYCX7
	VTQdHU2rbvNnnSYGaj6/63x/cTZOn1SJoG0miLxV/4cMgkniGuNwhm5683RBuggr
	8A==
Received: (qmail 1440564 invoked from network); 29 Aug 2025 13:51:02 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Aug 2025 13:51:02 +0200
X-UD-Smtp-Session: l3s3148p1@P7PRon89LqwgAwDPXwOZADQgI+b4m0Li
Date: Fri, 29 Aug 2025 13:51:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Add initial USB support for the Renesas RZ/G3S SoC
Message-ID: <aLGUJbA0szYQ_gN4@shikoro>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <aLAZprjeKtk4pusw@shikoro>
 <ae53d367-2ee5-49aa-82ba-86f9e84d4d25@tuxon.dev>
 <aLGGmI8bpKNVaSAa@shikoro>
 <be706ee5-057c-4b0a-b0d3-54ca24087f3f@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be706ee5-057c-4b0a-b0d3-54ca24087f3f@tuxon.dev>


> > Yes, I added it and it made the error go away, but still no USB. I
> 
> The drivers are not probed or you see no activity when connecting USB devices?

Sigh, I was so sure to have checked OHCI/EHCI but only EHCI was enabled :(

Checking with the schematics, I get it that only the rightmost USB-A
connectors on the carrier board are routed. Those two work fine now.

If that is to be expected, then for the whole series:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


