Return-Path: <linux-kernel+bounces-819464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC0B5A11C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8EEB4E207C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D32DF13C;
	Tue, 16 Sep 2025 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OdbHvbYs"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE326E6FB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049995; cv=none; b=X9uaTuElx3RmM/ZWjMiizBe3rYw2k8Z7Bkx6AMxvsKLSvzhAVPZkjQD/eerVHMbAtlJUzCQupPQ8wPTkz7zwk30nKHtIDXge0H/e8ENCvUVGLiSOhn+mIJU+xerIoX9XoXEFvge0MIkHGuzR/PgVlC6i631hf2tBaGxZHwBLsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049995; c=relaxed/simple;
	bh=OfcPz91lW0Vh8uuafTjAUzoa+yvWon5QDCCxA1+xfAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgwdwKBwALydXFQXq/61Rg8I58jHYR2e/GTWDpy9yf6NfibrQ7gCnnkmP9bH/TnOhSwqUHTlJvzYP/1c1rQoy0FJsBsixagGHypVQN7i/GuTwOjA8eTp1ElvArm+LpYnve2ilQI4B4r8Wo94K9YxYvppXzFU5BqeBvwRSSSgrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OdbHvbYs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3CB824E40C71;
	Tue, 16 Sep 2025 19:13:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11FEE6061E;
	Tue, 16 Sep 2025 19:13:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76EE9102F16A7;
	Tue, 16 Sep 2025 21:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758049983; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MasoXUdCQrht0je9DvK2uV3fHTpYnuPSASEiFGg2BqE=;
	b=OdbHvbYs83/ljHGgkuxTZTZMJ50syFiczM9oPSmf2VUjdZZSgNPun/37kUiz0YS6lzryjC
	pQNg1jj0vKZkSW8zrE0LyqVdhN/e2M3DvL3nqV3vTKMEjK9YgGIynns5Dcy7nQ+qHSyEkO
	pQ3jfsdZVUBNSum5XX+MFbjw4XcWyS770wWKTfBTk1xrDFbomTZwIM3ZtufF8GmZE8aqi0
	MxtpOFeJyeg6jfQEyqG4mszKxl3fz7Rea4EhlTdmAZHPgspw1qHQvKFo+XlRQltfALDAt9
	JaLlfRlHBDjdlGKDo5EkFO51zv3imnMCEoHzjxxloU9gE7Sak0iCguywDmnPWg==
Date: Tue, 16 Sep 2025 21:12:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Frank Li <Frank.Li@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the i3c tree
Message-ID: <2025091619124436ec80e5@mail.local>
References: <aMh95LzHnl-9-w5Y@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMh95LzHnl-9-w5Y@sirena.org.uk>
X-Last-TLS-Session-Version: TLSv1.3

Hello Mark,

On 15/09/2025 21:58:12+0100, Mark Brown wrote:
> Hi all,
> 
> After merging the i3c tree, today's linux-next build (x86 allmodconfig)
> failed like this:
> 
> /tmp/next/build/drivers/i3c/master/adi-i3c-master.c:13:10: fatal error: linux/fpga/adi-axi-common.h: No such file or directory
>    13 | #include <linux/fpga/adi-axi-common.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> Caused by commit
> 
>   63cae74bea7cc ("i3c: master: Add driver for Analog Devices I3C Controller IP")
> 
> I have used the version from next-20250912 instead.

Thanks for the heads up, I didn't realize I wasn't rebased on top of
v6.17-rc1. I sent a patch but I will only be able to push it tomorrow so
the i3c tree is going to fail again today.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

