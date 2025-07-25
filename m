Return-Path: <linux-kernel+bounces-745978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F210B12123
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D0AC76D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182D2EE975;
	Fri, 25 Jul 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ICcacUBM"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DA2264DB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458230; cv=none; b=GCge8EobIAY+In96lzm0SaNkMunaKuIVab7paKIQgBCKImIgq1/m9KzekKB8/RbR6O8cHQ9N68NjwidhdvgrkV28UZ3KwiLs+BzyVlYFAH/zoOmiXVO/p32u9yd7Ooa2nTdqH1hm+SroTW5T0BfEt1G7/b/2ebym3DfqZGTZUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458230; c=relaxed/simple;
	bh=AGJrMrC5GgDrciuEXkM5ywtIb5dq9WZZRsYzDkf8Yrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aIunQ3/g/iYneIu+JSZqnuT9Nqr1od0m2VYD0SFtwoXgvLyIuiGPDTbzwZMZ1DvpKEO7VfmeByayhSzwY/Bb2bI/6mzpIPGxB925X3NzhP3NGrk5MgcXZraaPlpmLiCHbKjVyb3orez8SijC/T3bG89/Q8m4YYFs4sMJeS8h1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ICcacUBM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A1F343979;
	Fri, 25 Jul 2025 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753458225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGJrMrC5GgDrciuEXkM5ywtIb5dq9WZZRsYzDkf8Yrg=;
	b=ICcacUBMNsofq5G/8w66CrwZcfEtyXK1bYPPWz62hLo1wI1cIcnzLxJL7j7oQSkusQk8RV
	UcYq3BrsADr1HjqdsLTgangW8lcUEA2w+MuEnKmd5MpdfrbaSobiLIx3C4q2oCa5U+wSAn
	BR2kcZNWLaKT7pSzVYFr/TptYLX5teTmHZIis+3mH08f+kHMP0diAMiosNaKcuA9IZYOb3
	YN7ItV/IIb/KQ0fH4s55Nt2WYTrpl9l0qV1QGqaeGJ+eF0sEdEzSMZegYaLmby8e1GNMe9
	pIbyuHnGdurskVd5dshqm2B8RtobP3GIJHLGgZZm5M8SVLSoAH5eNQbnC1w8lQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <Balamanikandan.Gunasundar@microchip.com>
Cc: <alexander.sverdlin@siemens.com>,  <bbrezillon@kernel.org>,
  <linux-mtd@lists.infradead.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <Nicolas.Ferre@microchip.com>,  <alexandre.belloni@bootlin.com>,
  <claudiu.beznea@tuxon.dev>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup
 timing
In-Reply-To: <24142dc4-a3a9-4d17-bc85-913cc9a56261@microchip.com>
	(Balamanikandan Gunasundar's message of "Tue, 22 Jul 2025 09:51:43
	+0000")
References: <20250701133333.3871085-1-alexander.sverdlin@siemens.com>
	<24142dc4-a3a9-4d17-bc85-913cc9a56261@microchip.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 25 Jul 2025 17:43:44 +0200
Message-ID: <87jz3ws2bz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopeeurghlrghmrghnihhkrghnuggrnhdrifhunhgrshhunhgurghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghlvgigrghnuggvrhdrshhvvghrughlihhnsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhou
 gdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopefpihgtohhlrghsrdfhvghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Bala,

On 22/07/2025 at 09:51:43 GMT, <Balamanikandan.Gunasundar@microchip.com> wr=
ote:

> Hi,
>
> This change looks good to me. But it didn't apply in any of my trees. Am=
=20
> i missing some thing?
>
> However I got this patch modified and tested in few of our boards.

Stable is missing, and I took the opportunity to report a nit, hence
this patch was marked done on my side, waiting for v2.

Thanks,
Miqu=C3=A8l

