Return-Path: <linux-kernel+bounces-809798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12692B5122B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53463A4B77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D83126B6;
	Wed, 10 Sep 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYBHxHHc"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC12BE65B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495404; cv=none; b=Ly43hxQ9boW4QTakF+WIljxUinJYzbjB1PLceAhK6NdxZISZjZKQpOUTY69XPHDACXqNYIBaDurubh5iG00rztVOxVJ6g4NQzZ8nDQVOf5A8S+u3Da3YvKsgj+yMjwNJookBTCmOmAe6KGLNysOJBFb/HQ6QQdYg5NNvBUrmipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495404; c=relaxed/simple;
	bh=H9zCZyDIgvwzWEQM7YDLcK5/VX5ORk30XN2IWK4wDvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4Lo1pzy+RWlotKvKAffnw8RTuFKeqv4XnFSm6eHW99O6TE6T/BttWDv8v7WHA8k7++IvXKX/AmEyGbw7fO9tAcv0x2qCfBEgzksyjEooU8HTEgbGMa4gOd+lbDp/PoJxKQfVTipcO4tz5F9srzwDif7rISxt3Ybkr9asoVOwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYBHxHHc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EF759C6B3AC;
	Wed, 10 Sep 2025 09:09:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A07CA606DB;
	Wed, 10 Sep 2025 09:10:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D015B102F294C;
	Wed, 10 Sep 2025 11:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757495399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZGdZCcz9UwBIS4jBTMbck9fbv41yXW91D1xMl9GGQ8Y=;
	b=XYBHxHHcXTegSVJoHeE5qbiapSrwAvEXVOKI5IezhWdA9WwS54GGZgevjXwXdG7HA0+rr+
	9A8oqmp2ETMkEJwoK8CdCIBlXmNo20Vx/czOCkavpiwTog03Ofe5PfaJdcYl1UY3jY8PfY
	yxofQq7jFG8I+3rzc3Ky/67zilxcp+6W+jWIPSKRVlu0UYDUKCwHE4tIHRWKOv0Lhj3qKc
	qlRpDN218k2eOSNLzmFghGox8FY6tkdeugudJsx5ze8qWWT0q5JxMQGlu9eol+2B3ikDHr
	iC7hekKLgZpadIu3XAbnJ6IkOrs0GmLZ0Zso4hkaq0Yma7X2IT7Fu29bE//L7A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  tudor.ambarus@linaro.org,
  mmkurbanov@salutedevices.com,  Takahiro.Kuwano@infineon.com,
  pratyush@kernel.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
In-Reply-To: <20250910030301.1368372-2-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Wed, 10 Sep 2025 11:02:59 +0800")
References: <20250910030301.1368372-1-linchengming884@gmail.com>
	<20250910030301.1368372-2-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 11:09:35 +0200
Message-ID: <87wm66d67k.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Cheng Ming,

On 10/09/2025 at 11:02:59 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Add a new boolean property "enable-randomizer-otp" to enable the
> randomizer feature on supported SPI-NAND devices.
>
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Docume=
ntation/devicetree/bindings/mtd/spi-nand.yaml
> index 77a8727c7..432bc79e9 100644
> --- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> @@ -21,6 +21,10 @@ properties:
>      description: Encode the chip-select line on the SPI bus
>      maxItems: 1
>=20=20
> +  enable-randomizer-otp:

This is a NAND wide feature, so we should probably add a prefix, such as
"nand,".

Now, what about this "otp" suffix? Many (if not all) chips have a
volatile setting for that. About the naming, "otp" often reflects to the
OTP area, which is not what you imply here, as you want to insist
(rightfully) on the fact that this feature cannot be disabled.

Also, this is a per-chip configuration, while I would have welcomed a
per-partition configuration. I can easily imagine two cases:

- The boot ROM, for longevity purposes, expects the first blocks
  containing the bootloader to be scrambled. However the rest of the
  system does not really care and disables randomization.

- The boot ROM is not capable of de-scrambling, however the rest of the
  system relies on the (probably) more robust scrambling feature.

In both cases a chip wide variable is not relevant.

The fact that it is a one-time feature makes it even harder to fit into
something generic.

How do you think these constraints could fit with your needs? Can you
please explain again (sorry for the repetition) what Macronix chips have
the volatile capability and which ones do not?

Thanks,
Miqu=C3=A8l

