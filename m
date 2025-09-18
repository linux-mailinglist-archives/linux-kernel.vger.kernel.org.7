Return-Path: <linux-kernel+bounces-823194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB13B85C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45210177134
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A33168FD;
	Thu, 18 Sep 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETy5Jc+v"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118A31065D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210334; cv=none; b=JqevNitnR3IGq1vx8XRfwPEfBiVSP0npj9rF0ZNKZvKwTG+S7QvfUXHoGmvFh8CagnI7E+hCepxyCb9DaRxhrMvK3Vd8AgTdJKY5CuNVKXlDIOcF6y4v1pxF4fzGy44QQ7nPDqKeqXX5JwgDKuBNA2lS6mplXPCdgBSZ53dFJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210334; c=relaxed/simple;
	bh=k+o8V00UY3Lwb7Hv9K2ILNjTEYBIduaH7WclFbLmI/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YG8KndVGtrdjwEHRlc6qrMBZ6Oixfv1IDUN7bPelEaHkeclI1y8j/N8kAYbHtL+JcD1X9hCP6ttXHvEjlMocQsIbU+38xOu4H54f/9jbTlt3ZhSFbN3xeX0A4XRwHF6EUMXQ3sXtHSUoqrdHM+zW0aoDefP9KpOi/CNMuuDRLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETy5Jc+v; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 995EF1A0945;
	Thu, 18 Sep 2025 15:45:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC64606A8;
	Thu, 18 Sep 2025 15:45:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92F3B102F1D23;
	Thu, 18 Sep 2025 17:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758210328; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=35NWme8b8OsSS57EP8m0LCDhn1NlHjtCzKoRiR++ww0=;
	b=ETy5Jc+vPFhYB1IR+xry7jt713akS1jNAYJ4Q5jWaFSaFm3HIdE7uQX1T9lvVkJUcEfD3G
	WsvP8dUjmFo5pR/CZBkugRuTYaFP+jZPiqaSaT/HABYJjq5rv7BVDLr4obKpjq/gmHZti9
	T/Fy+glML484Utf3XFN9dd0Zfb5bSb79ujPGgnY/YSpox73bBSgSnQR+XlnLNspvSLYeYX
	BXc2QIS8lJ821zgbO80FBLKd9a2H/NlJj5yy2iIjsINNmDUeiFWRC+UDsCi3jgjekLaVDC
	0WWlky9UZ/j6taJZeBjJPR210pwf2j3uR2l2Zt235JnqI/7cufuLfltms5PPhg==
Date: Thu, 18 Sep 2025 17:45:22 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: wan: framer: Add version sysfs
 attribute for the Lantiq PEF2256 framer
Message-ID: <20250918174522.5f34615b@bootlin.com>
In-Reply-To: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
References: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Wed, 17 Sep 2025 08:24:01 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2:
> - Make DEVICE_ATTR_RO(version) static
> - Split version_show() prototype into 2 lines to remain under 80 chars
> 
> v1: https://lore.kernel.org/all/f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu/
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

This patch add a new entry in sysfs.

Can you provide the related documentation in /Documentation/ABI/testing/

Best regards,
Hervé

