Return-Path: <linux-kernel+bounces-677418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B200FAD1A69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B216973F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6224E4B4;
	Mon,  9 Jun 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KulvjbB4"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A41386B4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460820; cv=none; b=bJtEvr+kwPu7JS4fGofjDX+IyyOeDDZoKXYuN8MIVNZqosqt7F3mt80vYl06UlOx4aB0jX8dDm8pxmkA4MSQJMVrOzTOedHrpQU+17mdoALYfPcji4STozpxWC/SfdW3jYty73GrwRWcu9SEDjbfT6FVR9ij7TZtXhQzh6IER5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460820; c=relaxed/simple;
	bh=S/e++CAHG/GwRs6bZAl/cmZmOkISj5DtDX3fApo0lHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAiv/k5gdsMEaI+rMvX863+dFSRZNLNBP1+BkbQ6mdD/zrXjZXq6hGm7j/tt0ZzThM88KsZ66Yl3djL86v6N9JlQiATvoXOqDa6ebJu5Y9jewKG1KW4GNDPmIsSnqPo0IZMrRnn2JZTLfa6XBh2iUFAklEhkjM/8pVXHRu/+TDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KulvjbB4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4040433B5;
	Mon,  9 Jun 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749460811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLaNxGQJpPD63Lzluapai/rclx1n81PqQJs/TSEMG4w=;
	b=KulvjbB45hPm/V2VhKf82WKHPbA3PglbYXW4s2OaNh1vyKZkkzzFNHzZppTAjkQ4nwsNB8
	hOijW1NSI+XjdeDqUkKRvIODg5mcHhT5eTUpbyhiiFobiVuYw/woxtXdMeU5jKmy6IPfvW
	R26bB8wOUeGILTONH6ZBW85xetzCmZeFyI37sQ0Dh2Y5jzOHdvVwR+2dPOwdK61gsV47Qr
	YrvWxVylACnW0KOsjHOKv98UBIxSaLGvVXZN7fWYlMjBxOAZQd/p3j1ORoaUoDjfmEO+yI
	Ll6JE68dKDR0UawzaJ4XTq65KV+l/KKc6+5CucI24oGxf7/lzrGASYZQUuqsOA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Regan <dregan@broadcom.com>
Cc: linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  bcm-kernel-feedback-list@broadcom.com,  william.zhang@broadcom.com,
  anand.gore@broadcom.com,  florian.fainelli@broadcom.com,
  kamal.dasu@broadcom.com,  dan.beygelman@broadcom.com,  =?utf-8?Q?=C3=81l?=
 =?utf-8?Q?varo_Fern=C3=A1ndez?=
 Rojas <noltari@gmail.com>,  rafal@milecki.pl,
  computersforpeace@gmail.com,  frieder.schrempf@kontron.de,
  vigneshr@ti.com,  richard@nod.at,  bbrezillon@kernel.org,
  kdasu.kdev@gmail.com,  jaimeliao.tw@gmail.com,  kilobyte@angband.pl,
  jonas.gorski@gmail.com,  dgcbueu@gmail.com,  dregan@mail.com
Subject: Re: [PATCH v2] mtd: nand: brcmnand: fix mtd corrected bits stat
In-Reply-To: <20250606165756.1531164-1-dregan@broadcom.com> (David Regan's
	message of "Fri, 6 Jun 2025 09:57:03 -0700")
References: <20250606165756.1531164-1-dregan@broadcom.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Jun 2025 11:20:09 +0200
Message-ID: <8734c9z2ye.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeludduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegurhgvghgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhto
 hepfihilhhlihgrmhdriihhrghnghessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprghnrghnugdrghhorhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepkhgrmhgrlhdruggrshhusegsrhhorggutghomhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On 06/06/2025 at 09:57:03 -07, David Regan <dregan@broadcom.com> wrote:

> Currently we attempt to get the amount of flipped bits from a hardware
> location which is reset on every subpage. Instead obtain total flipped
> bits stat from hardware accumulator. In addition identify the correct
> maximum subpage corrected bits.
>
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> ---

Hello,

Can you please give the output of nandbiterrs -i /dev/mtdX?

>  v2: Add >=3D v4 NAND controller support as requested by Jonas.
>      mtd->ecc_stats.corrected accumulates instead of set to total.
>      Remove DMA specific flipped bits count.

The changelog does not mention the fact that you return the maximum
number of corrected bitflips as I requested, and the diff does not show
a straightforward implementation of that. It is very important to get
this right.

If we take the following example of a page with 4 ECC steps, if we get
respectively: 0, 2, 3, 0 bitflips per step, the returned value shall be
3.

To be very certain that this is correct, you can use the nandflipbit
tool from the mtd-utils test suite. You can manually insert bitflips in
various areas of a page and then read the page again with ECC enabled
and see how many bit errors are reported.

Thanks,
Miqu=C3=A8l

