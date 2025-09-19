Return-Path: <linux-kernel+bounces-824850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3915EB8A4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DE1C2080E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3AE31B80F;
	Fri, 19 Sep 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K1Uw/QL5"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11C31A7E0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295833; cv=none; b=ij80bURH3cgm7PPPejmpXQ24ibPeFdxETFIYHH62dyTHcwvF/tkZ0OZrBDXxLNNTSpqDJOZzMvcLVuJKFZr9cVu4+IN2G0KpTGIUXusBXmg8MfdOvViegkXdKFhEju1kop2BJ96G88/TgTulh9Lll8ZFxLs1vL2NTlP0z9TBTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295833; c=relaxed/simple;
	bh=+4PZdqjap8xszXOt8XL4lD85fXoioACD8cWnc7TQ75s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmX9koqf5IR6NVXmCszxhSbLRmQIfXR2p8CGQQgJaUur7u6+rVqwsJxYPAW5N93rmHxV4jDfSoyT6Ar5PKC6E7ov2b96H0mV8Tfzh6JT2uUHGjsRlgBwom7KvjgeEVSzT1pIjnWnJ4P+f0Qv34BhRflHWHFOgLqVyVEolQSldYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K1Uw/QL5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AAACFC007B9;
	Fri, 19 Sep 2025 15:30:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FD67606A8;
	Fri, 19 Sep 2025 15:30:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B7D0102F183B;
	Fri, 19 Sep 2025 17:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758295828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KorTOHGT+f9+nNZ7UQL8M7VObv8JOq459H/SyY11yls=;
	b=K1Uw/QL59JphgBYp1ihEC+DD67F51NEXJc6M+eoPvZlg09K/xx0e3lJZZahpkw1kGpxv7k
	MAtNMWPcLZbYOqYOHxA545LjrW7ZIP/o3IqPHlKcKvQIR0yZf/2LLhtJkSeaAaHGbtbN1o
	u53EobUUqMAsY1P1PokRVOksVCLda6k7/Rk1arp9Ekx0UT0dFHOEZFDp6XMlxWfbNceakA
	6K06DMFMK/jlobQHVYamjzPJdPCBR38vJe/tkwcoT1wMM5TEMJfBiQGEuApewskyrT8MKY
	+ajjQ86ivLGvGdzIn0fd/NuPZw79R+GT6sS44NQ0uo4EAbRN3vNokveTpPUDJQ==
Date: Fri, 19 Sep 2025 17:30:11 +0200
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
Subject: Re: [PATCH v3 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
Message-ID: <20250919173011.4b32a928@bootlin.com>
In-Reply-To: <aM1rRuiJH9dlwBjL@shikoro>
References: <20250918104009.94754-1-herve.codina@bootlin.com>
	<20250918104009.94754-8-herve.codina@bootlin.com>
	<aM0lU01x1w2wB3LG@ninjato>
	<20250919151448.14f8719a@bootlin.com>
	<aM1rRuiJH9dlwBjL@shikoro>
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

Hi Wolfram,

On Fri, 19 Sep 2025 16:40:06 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > Rob asked to use only interrupt-map and use directly the interrupt-map index as
> > the hardware index:
> >   https://lore.kernel.org/lkml/20250801111753.382f52ac@bootlin.com/  
> 
> I agree with that. Currently an interrupt-map entry looks like:
> 
> 	interrupt-map = <0 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> 
> And the number after GIC_SPI determines the index register, no? Can't we
> simply say 'index = <SPI_nr_from_dt> - 103' incl. some sanity checks?
> 

And so 103 used to compute the index is hardcoded on the driver.

Further more the wiring of irq-mux interrupt output to the GIC input
line depends on the irq-mux integration and not the irq-mux itself.
Nothing in the irq-mux itself requires a specific connection to the
GIC.

But well, without adding this mapping information in the DT, maybe a
table in the driver in order to determine reg index from GIC IRQ number.

kind of:
  static u8 reg_index[8] = {103, 104, 105, ... , 110};

Base on GIC IRQ number retrieve from the interrupt-map item, we search for
the index in reg_index that match this number. The index found is the index
used to access the register.

What do you think about this?

Best regards,
Hervé


