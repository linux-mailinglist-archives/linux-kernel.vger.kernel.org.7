Return-Path: <linux-kernel+bounces-760114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A9B1E6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598681893701
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763632749D2;
	Fri,  8 Aug 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B0EjYcKg"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABC1F1538;
	Fri,  8 Aug 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649844; cv=none; b=QwXS1nIwFZznkAOuCVZ/UO+CgjdCHlzTqTysjxx5Ypl+pODQ7xzOx6mOtvP9CEHGJ0tAmx0RgoyU9eXnfLGhXDZjNIEY/IWA1fH+fdDZQdj/bx65VZfhl4z4XTa3zq3OeXxuXTih2/EUMIjv2Y1jDkSRFji/k+8R/lGACgQtEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649844; c=relaxed/simple;
	bh=yD0mi7Uyn2c5rvpZYEE9/kGZcsO9rhPRIIJK6YIVS7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMN7dbqAC0vvsSUUdfYRroI5r9JvcGkZLM5fQ8OVdTYqCnGN6+dsiK6+za2xMFQ4ueD9ACFgysL+SG1Mdf0tPhBMVFNj3M8RB2TPErcibu4h//YhUEE8gBjSXJrlRrSdN+g7jC6qbJ1/DcUDXWkmc7zYJhvDYMMjMzdn4G5yyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B0EjYcKg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17DEA41C7B;
	Fri,  8 Aug 2025 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754649840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD0mi7Uyn2c5rvpZYEE9/kGZcsO9rhPRIIJK6YIVS7Y=;
	b=B0EjYcKgJzqeCgKhFUYQDiDJroLjBvTKhCAST0DimHX7D8YJG7g97F9rquUineE9/2Hzkd
	jg5p+1VqCnIjbRLs2ksamT/MXzQWK0n8gkUUTHMS1wYcSzGUfFiqY1EvmZu7evuoCpSbn2
	XLi919S9apR9YYzYDPEvckA2tpC8tFqYZTV3q4dfTKKbi3N/BCbfcriafbj7qwP/+nIs7m
	mG9F9lMzUSls4OV4U3ZwpUq0nLuV42726Pv2bDs8MGzrJyg4h3qvy5bizSmWbhDkhuGkuj
	KWNTpB5tgeeoH0KVgQDhNVZme0bU6iHmDSWPsiUTST1ldDk09M8Z2VVUSZaRNg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-phy@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: marvell,comphy-cp110: Fix clock and
 child node constraints
In-Reply-To: <20250806200138.1366189-1-robh@kernel.org> (Rob Herring's message
	of "Wed, 6 Aug 2025 15:01:37 -0500")
References: <20250806200138.1366189-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 08 Aug 2025 12:43:59 +0200
Message-ID: <87qzxm9jps.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrieehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhphhihsehlihhsthhsrdhin
 hhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On 06/08/2025 at 15:01:37 -05, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> In converting marvell,comphy-cp110 to schema, the constraints for clocks =
on
> marvell,comphy-a3700 are wrong, the maximum number of child nodes are wro=
ng,
> and the phy nodes may have a 'connector' child node:
>
> phy@18300 (marvell,comphy-a3700): clock-names: False schema does not allo=
w ['xtal']
> phy@120000 (marvell,comphy-cp110): 'phy@3', 'phy@4', 'phy@5' do not match=
 any of the regexes: '^phy@[0-2]$', '^pinctrl-[0-9]+$'
> phy@120000 (marvell,comphy-cp110): phy@2: 'connector' does not match any =
of the regexes: '^pinctrl-[0-9]+$'
>
> Fixes: 50355ac70d4f ("dt-bindings: phy: Convert marvell,comphy-cp110 to D=
T schema")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

