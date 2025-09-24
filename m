Return-Path: <linux-kernel+bounces-830500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B5B99DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE73AB48F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E612FB63B;
	Wed, 24 Sep 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HbBS7gug"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3432E03E3;
	Wed, 24 Sep 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717112; cv=none; b=s6AD3ZkxZTC8znnGNZxb6iqeTqV+o3UH/P4fHsEdbOK0GZns3bBmA1TQKafruroCUrCX52tUp+DT3dvyV431h409F+WdoDMLT802Yb43FW7UxG5HJD4B//SNrwVYaeQ1p0+PC1i41XU+MsG2dnZb5eno/y5LwGojfMmbbw8UFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717112; c=relaxed/simple;
	bh=cQvLvUixlWwRVB5OUfeym2k4wn5nZkOkVGpNyDcP2wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltG3XrNlHWU81UbQKiDWylqXR/ZkY03JL7+Zs8LgZzwOW4lgvwbZi6ZiQOgcp3Hq+XZvOk2Wlz6CG9v2jcgLfNlLmpqH7RzbwqG/ZcQqUKlVKhQulAbX9VQJAtECj7acW5edoimkqAc/yboiSyqAyDP82y9wRdosA8e94TfM/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HbBS7gug; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E0EA01A0EFA;
	Wed, 24 Sep 2025 12:31:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B537260634;
	Wed, 24 Sep 2025 12:31:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1903D102F1781;
	Wed, 24 Sep 2025 14:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758717106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0hNBGE90D+hslKE/xccXHDSefhm+2v98IysEU5PhoZU=;
	b=HbBS7gug75o51TWRYaCC+o7xRwPk6229Y/GaHhRYC58q6X9LB05PpxcS4UkQQlD4vt2CON
	MPkmuraQOsP3NomvDP0uKNjmN2ccTHV8RO/dqW7YqVzLgJXGPJuhqwS3Bqeg9jKDne/llj
	8zIU2lL0MjpCdNuRc1w7xPSf/FAxpq2R4SUl8tahU+QXSuCACE281RI/9czafF7hzzkxcC
	O+XqiC115j3P4yRkB29cAVGLvbibI5VFV+21bT0R8qzOWi/0nUo3ePlpkpX1dq1/dv05Se
	uVRy0SgzZIxak1K/AZLDTI2kQnKwM30P52q+QMniAqm7wRvIueTsyoJqTMXfgg==
Date: Wed, 24 Sep 2025 14:31:30 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Andrew Davis
 <afd@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, Jason
 Kridner <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250924143130.0a34badb@bootlin.com>
In-Reply-To: <aNNrbmZfZU-1xJFm@zatzit>
References: <aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
	<20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
	<aNJVqSpdAJzGliNx@zatzit>
	<20250923114849.2385736d@bootlin.com>
	<aNNrbmZfZU-1xJFm@zatzit>
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

Hi David,

On Wed, 24 Sep 2025 13:54:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

...

> > 
> > IMHO, no extra rules are needed in DT addon rules to constraint i2c devices
> > to be added in a connector node, a connector sub-node or an i2c controller
> > node.
> > 
> > This will be constrained by the connector itself (out of DT addon rules).  
> 
> At this point I'm just considering the end-to-end rules we want to
> enforce.  Exactly what stage of the process enforces each rule is
> another question.
> 
> > I mean, according to rule b), the connector will allow some destination
> > places. Either it will allow the i2c controller node or a connector sub-node.  
> 
> Sure.
> 
> > This is specific to the connector definition and it should be out of
> > generic DT addon rules.  
> 
> Hang on... what distinction are you seeing between the "connector
> definition" and "generic DT addon rules".  As I see it we're trying to
> create a protocol that defines both the base rules and what a
> "connector" even means.
> 

The "generic DT addon rules" give rules related to addon from a DT
perspective. In other word "What an addon DT can do"
 - export symbols
 - import symbols
 - Add full node only
 - Don't allow to modify existing node
 - ...

The way addon are used is what I put behind "connector definition".
The connector is a specific node in a DT with a specific comptible string.
The definition of this node will tell "how to use it". For instance:
  - There is 2 gpios available and an addon can use it with <&connector 0> and
    <&connector 1>.
  - There is an i2c bus available and an addon can use if with <&i2c-a>
  - The hotplug mecanism used for this specific connector (gpio, eeprom, ...)
    is also part of the "connector definition".

An external board DT supposed to be connected to this connector should
  - a) Provide its description using an addon DT (compliant with "generic DT
       addon rules")
and

  - b) Use resources from connector the board is connected to (compliant with
       "connector definition").

"generic DT addon rules": DT specification
"connector definition": Connector binding

Today, connectors are going to use the addon feature but I didn't want to
restrict addon feature to connectors.

For instance, a FPGA driver could use the addon feature with an addon DT
to describe the internal part of the FPGA related to the FPGA bitstream
loaded by the FPGA driver. That might make sense, right ?

Also upstream in the kernel, PCI boards can be described using DT.
  https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.c
  https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.dtso

Using addon DT in that case makes sense too even if a "connector" is not present.

Best regards,
Hervé

