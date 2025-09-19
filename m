Return-Path: <linux-kernel+bounces-825014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB3CB8AB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D5B5A549F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8C322527;
	Fri, 19 Sep 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OFuihWIl"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266E321F3A;
	Fri, 19 Sep 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301953; cv=none; b=GJ3TMKPC2USjwcSGvFYaE0vIMXt5a7qqaaq0jsNy3niEtTB8N8qtTQhbrlTCy8NmmuZ3/yrD/3JqdRJAKg1F8jIcv1o6YcfgMw5toQid3OixoAKkT0EGLuEDkUEs07natEw3aJsfbbDXBqVWLpSqh0sNjM6NafZ8Qvm+DkpLzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301953; c=relaxed/simple;
	bh=9zSn6AbzOcblb5x8eCo/HOafd+xnwiEL4+CHNUx7enc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAgce80p85iWd/x1tij49Y9I7hDV2YCVfWFymH/v3PB0S4ARXQkTpjr0fpSxi/PGZG290saabgRdg9g+wrrjrybaUWCcsvZ8yz8V7+/OyfI8HYDL6bBz62GEHN/q+YPyrOI3qG2sIYgcS4T/i4u//GDp33uvIH6GRq6ky1SfYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OFuihWIl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0107E4E40D6E;
	Fri, 19 Sep 2025 17:12:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8487606A8;
	Fri, 19 Sep 2025 17:12:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83DC7102F1877;
	Fri, 19 Sep 2025 19:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758301946; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=82kGiflx9+qp0dBT1z2EI39WcJ+hOEaJO//+XgaOsJQ=;
	b=OFuihWIli3a5pINRtQ+q10zPNS5LkI4Q8B7UybqsLvA1IjVaNmVmthmUxrgGsbVjpQLtKC
	TLGd59DyV32zNkWR8kRaASvKHmv8IXXXWt9Y+2C8/K4nYkJzrrWbhuICKSg5IZUeJ8XFPc
	PZOo4M8bG+EIwDyP3zHsH0iLrgJthozTWDGt3oPWPXPpGUja5/ECF0LmJISlRD3aA5Hp1r
	+qRZW9tIZdOCyUoDehdc1n9B3v4akHQVpdT5yZ+pRFMCtriUaJ7LoPbAxonD6wzUnuaBws
	kKRrQJ34DHK6ytbRdT1zrnnI/dOEaQMLa16REcbA6nu6pC2NukhR4hlNn6iyig==
Date: Fri, 19 Sep 2025 19:12:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Hoan Tran
 <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@google.com>, Serge
 Semin <fancer.lancer@gmail.com>, Phil Edworthy <phil.edworthy@renesas.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Pascal
 Eberhard <pascal.eberhard@se.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 8/8] ARM: dts: r9a06g032: Add support for GPIO
 interrupts
Message-ID: <20250919191211.0ed4c976@bootlin.com>
In-Reply-To: <aM1rgY9CCF54c_Pg@shikoro>
References: <20250918104009.94754-1-herve.codina@bootlin.com>
	<20250918104009.94754-9-herve.codina@bootlin.com>
	<aM0llhn054OI9rA8@ninjato>
	<20250919155910.4d106256@bootlin.com>
	<aM1rgY9CCF54c_Pg@shikoro>
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

On Fri, 19 Sep 2025 16:41:05 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > 'interrupt-map' is a required property. If the board doesn't use any interrupt
> > GPIO, its dts has no reason to set the interrupt-map.  
> 
> Why is 'interrupt-map' then a required property? Can we drop it from the
> requirements?
> 

I need to check in details but 'interrupt-map' should be kept required.
Indeed, irq-mux needs this property to work. It is not an optional one.

I need to look at the 'make CHECK_DTBS=y' behavior when required property is
missing in a not enabled node (node with status = "disabled").

Also, got some:
   Warning (interrupts_property): /soc/interrupt-controller@51000480: Missing interrupt-controller or interrupt-map property

This could be due to the presence of #interrupt-cells or the node name (not
sure). As I need to rename the node (Conor's comment), I will see if the
warning disappear. If the warning is due to #interrupt-cells, I don't think
that removing #interrupt-cells is the right solution to avoid the warning.

That's said, I need to perform some local tries. I will keep you informed.

Best regards
Hervé 

