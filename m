Return-Path: <linux-kernel+bounces-865188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C6BFC840
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE406E0B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2334B67F;
	Wed, 22 Oct 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ar1UucqO"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E926ED34;
	Wed, 22 Oct 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142348; cv=none; b=HU4+OirRsPhLkxgeiJZy59MEIMl6sJ39lUmHCtmiALWFnYYiDJNnrDxu4PPTHdN339Bewx2ZrPC+cCaDVOtzsFVSVM5m0i81et3vep1ksXTZ7IOwaMF9dt/XLp4FDUM2DNOxMc9eUOGdAnYasNLiHGA9YrtQ7yTt3V4cKJ01rJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142348; c=relaxed/simple;
	bh=2tD9Dd2I5mfKt/jOPREylpMxst4xlujfA1H39bh/pAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKA4UV8f3UPTcQ2cvCAJ88izh10w+5gB0WncZyajqYKcviJllSy6Fw99KQIw//72ABcZeCFiAwlVHSdTBEN3uoG1B2sG+I6izvnA5zNdSmCh+CpKfucnWYlS3ah/v3DKNF/8vymSYUB3PfnzVfhiZbqJCUjS43Nfci06loxyqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ar1UucqO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A1B14E4127A;
	Wed, 22 Oct 2025 14:12:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 32FEA606DC;
	Wed, 22 Oct 2025 14:12:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47A7F102F2432;
	Wed, 22 Oct 2025 16:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761142343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2tD9Dd2I5mfKt/jOPREylpMxst4xlujfA1H39bh/pAM=;
	b=Ar1UucqO2ytR2avAw0DsbeqP3tjYfW3tcBpwoXfy+A3o1GpC+BboZjWTzKIB9dj7pyfFhB
	bOuASXrnWebu4BAkXx2CScZDu/F8i9goSPLq85Etsdt/w+GCiU4nqyCRfOF3lPzjlnYNEt
	2iIg0MdKTdXIfDYT3yiXuVizvajwDjIsHaDjfPxlgdeMIxZEt/bB1ohsXRIo26jyGl/c3Y
	3/FlAEQXutzLAgzytk4ezgNzuBM7laNYWaUUWRipBS7Fch4jdtp/m07SkErQQKVEH/s1R/
	xDANDM7g0/4y6j52X/SEhc7JeS3vBcWYN4mX4rIriWgh0l9YCcPP4tHtfm9IHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,  Gregory Clement
 <gregory.clement@bootlin.com>,  Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>,
  linux-arm-kernel@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-clk@vger.kernel.org,
  linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Convert Marvell AP80x System
 Controller to DT schema
In-Reply-To: <20251014153040.3783896-1-robh@kernel.org> (Rob Herring's message
	of "Tue, 14 Oct 2025 10:30:38 -0500")
References: <20251014153040.3783896-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 16:12:21 +0200
Message-ID: <87frbbrpoa.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Rob,

On 14/10/2025 at 10:30:38 -05, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convert the Marvell AP80x System Controller binding to DT schema format.
>
> There's not any specific compatible for the whole block which is a
> separate problem, so just the child nodes are documented. Only the
> pinctrl and clock child nodes need to be converted as the GPIO node
> already has a schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

