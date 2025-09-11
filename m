Return-Path: <linux-kernel+bounces-811472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B14FB52992
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0732A580E10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C2266B67;
	Thu, 11 Sep 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KG+eNPYX"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6A201278
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574520; cv=none; b=BK8b5kKp/GF6tPdFOxJezx9U0mwA/9zvNPPvaxbvS2aTIh9V0GITO/mjimb54kTrA39vQr2ECxjIxxqrzfOy+pM+PSfev510JXpdluaNYjNNUao20EM9iLQmnPnZxy4OhahoL4GU/7SDf9OImI8DnhT5wjBjvTYyE2Gthaxb1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574520; c=relaxed/simple;
	bh=bhNDS7r8Kd+yF1km8cFRwJNMfwGdMPi3saV8F1M7gEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTKrySYtSFY4YFhGHe1a5iFmDza9sIvO29oAIL3iEeUS1SR2YdqBQnSUx9gUNuk0zx+rsJMhr1zgKb98KlrxFNWcxIGemJn7Vdh1SbVSjxlL1t9awieqWHVBdHy9PEptOGK56uPefrW8cBTRFVqWPlNnQhmWp4uo3nDgZ1o80Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KG+eNPYX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A1D5B1A08FC;
	Thu, 11 Sep 2025 07:08:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70A53606BB;
	Thu, 11 Sep 2025 07:08:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CA29102F28AF;
	Thu, 11 Sep 2025 09:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757574515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eAKEcYhJqeo3WpbpnN9yL0ePD0pDirbDTpiQAUZj6l8=;
	b=KG+eNPYXCREyj3lyG85m4mI9JA/fjr6GoroXKBsJ71JPWT8Htfbsh8sGzHliQlySONeGxD
	Z445mci8fK8dZlZSDbtbc/z/+ay+J+bpqXg5k/1/yoWuMt7FhJKNSYF1F+Ua6BbNhgVbsp
	5nKy9ec9Xq+9Pa1JUC/3L+lzRqrZw/6gSmr6tLp0Be1tpOk1mXN4Mv9Ne+CNUcncZevkoH
	NqX+mfL1VbteQgbhA62OHhhk3ItozgUcFlJQA2gqdKK/V5cIKwew82zpi2BtDqvP8RXbfh
	6rU/GipcfqLoM/UUS9pJOW7Outko6AewFsJLlNeYbsMrPjErQO8fhFwVBE9otw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Cheng Ming Lin <linchengming884@gmail.com>,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  tudor.ambarus@linaro.org,  mmkurbanov@salutedevices.com,
  Takahiro.Kuwano@infineon.com,  pratyush@kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  alvinzhou@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
In-Reply-To: <20250910163631.GA142639-robh@kernel.org> (Rob Herring's message
	of "Wed, 10 Sep 2025 11:36:31 -0500")
References: <20250910030301.1368372-1-linchengming884@gmail.com>
	<20250910030301.1368372-2-linchengming884@gmail.com>
	<87wm66d67k.fsf@bootlin.com> <20250910163631.GA142639-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 09:08:12 +0200
Message-ID: <87jz25bh5v.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/09/2025 at 11:36:31 -05, Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 10, 2025 at 11:09:35AM +0200, Miquel Raynal wrote:
>> Hello Cheng Ming,
>>=20
>> On 10/09/2025 at 11:02:59 +08, Cheng Ming Lin <linchengming884@gmail.com=
> wrote:
>>=20
>> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> >
>> > Add a new boolean property "enable-randomizer-otp" to enable the
>> > randomizer feature on supported SPI-NAND devices.
>> >
>> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> > ---
>> >  Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Doc=
umentation/devicetree/bindings/mtd/spi-nand.yaml
>> > index 77a8727c7..432bc79e9 100644
>> > --- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
>> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
>> > @@ -21,6 +21,10 @@ properties:
>> >      description: Encode the chip-select line on the SPI bus
>> >      maxItems: 1
>> >=20=20
>> > +  enable-randomizer-otp:
>>=20
>> This is a NAND wide feature, so we should probably add a prefix, such as
>> "nand,".
>
> 'nand' is not a vendor, so no.

Sorry for the confusion I meant "nand-", like we already have:
- nand-ecc-engine
- nand-use-soft-ecc-engine
- nand-ecc-strength
- nand-ecc-step-size
etc

Thanks,
Miqu=C3=A8l

