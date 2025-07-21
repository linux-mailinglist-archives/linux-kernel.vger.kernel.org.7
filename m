Return-Path: <linux-kernel+bounces-738677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED16B0BBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED03C1899F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545221F0995;
	Mon, 21 Jul 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coasia.com header.i=@coasia.com header.b="Curs6hNq"
Received: from spam.coasia.com (mail2.coasia.com [112.168.119.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02175AD5A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=112.168.119.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753072318; cv=none; b=e9BPpthvBv6IdEXthif6ykOcBcCCEKWlbTyoJqBt1gPW0hWfaxa+Nk6pIrEvYe29t+61SxZlI5bjVnJlFQ84lHpuAxDrWTgH/+giNioGNxFM3LXu1T7ESBy2TXKmWozAFh04dJ5Mw+K3U6LQjR2o4hHmjZi//AedcbxC1AsLc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753072318; c=relaxed/simple;
	bh=lxa9Bn6EeyGmj6jcfCOacOxEWNI2oVNDRLzi09fzPQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgfM9SDKmZrD087zjGS6wFolsy4quOdapsrJHHNhxmA0xQQg29Q/gRRZNVqM869igBE3BYKIl0HMfP5QGDbx6S8Rvcn6Z8oiGwGwA0teZ+9yVkuJAjtXpkKN7qNsJfB4qmxfwrJcSHyCp8jUE/fK8R50RERu704Ja37N5nwR2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=coasia.com; spf=pass smtp.mailfrom=coasia.com; dkim=pass (1024-bit key) header.d=coasia.com header.i=@coasia.com header.b=Curs6hNq; arc=none smtp.client-ip=112.168.119.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=coasia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coasia.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=coasia.com; s=coasia;
	t=1753072312; bh=lxa9Bn6EeyGmj6jcfCOacOxEWNI2oVNDRLzi09fzPQc=;
	l=6608; h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version;
	b=Curs6hNqcd4XWL8v1kjNDlXYBEUW0tiNmTWzWVlVaKxxneP3Fmy0RQYFxUEM9u+3/
	 y+b9y4Ms51gFqH8Earjp2LxtNS3DQRLPEoqRzxbqaatiE0Rcf9XXUZYObJ9WKv7egT
	 1yxJzgoL1p+c7xzoS9n/TaaK8ZYAOy0MSaYrBrQw=
Received: from unknown (HELO ?192.168.1.65?) (119.65.249.123)
	by 192.168.10.159 with ESMTP; 21 Jul 2025 13:31:52 +0900
X-Original-SENDERIP: 119.65.249.123
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: hgkim05@coasia.com
X-Original-RCPTTO: krzk@kernel.org,
	ksk4725@coasia.com,
	jesper.nilsson@axis.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com,
	linus.walleij@linaro.org,
	tomasz.figa@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	ravi.patel@samsung.com,
	smn1196@coasia.com,
	kenkim@coasia.com,
	pjsin865@coasia.com,
	gwk1013@coasia.com,
	mingyoungbo@coasia.com,
	pankaj.dubey@samsung.com,
	shradha.t@samsung.com,
	inbaraj.e@samsung.com,
	swathi.ks@samsung.com,
	hrishikesh.d@samsung.com,
	dj76.yang@samsung.com,
	hypmean.kim@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@axis.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	soc@lists.linux.dev
Message-ID: <fd261b5b4452cc797f50bb3fc8cfe93e4a38e477.camel@coasia.com>
Subject: Re: [PATCH 02/16] dt-bindings: clock: Add ARTPEC-8 CMU bindings
From: Hakyeong Kim <hgkim05@coasia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, ksk4725@coasia.com, Jesper
 Nilsson <jesper.nilsson@axis.com>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo
 Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Linus
 Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,  Ravi Patel <ravi.patel@samsung.com>,
 SungMin Park <smn1196@coasia.com>
Cc: kenkim <kenkim@coasia.com>, Jongshin Park <pjsin865@coasia.com>, GunWoo
 Kim <gwk1013@coasia.com>, GyoungBo Min <mingyoungbo@coasia.com>, Pankaj
 Dubey <pankaj.dubey@samsung.com>, Shradha Todi <shradha.t@samsung.com>,
 Inbaraj E <inbaraj.e@samsung.com>, Swathi K S <swathi.ks@samsung.com>,
 Hrishikesh <hrishikesh.d@samsung.com>, Dongjin Yang
 <dj76.yang@samsung.com>, Sang Min Kim <hypmean.kim@samsung.com>,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,  linux-arm-kernel@axis.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, soc@lists.linux.dev
Date: Mon, 21 Jul 2025 13:31:53 +0900
In-Reply-To: <7b9a8203-2d66-4735-a6a2-762f57fb5cef@kernel.org>
References: <20250710002047.1573841-1-ksk4725@coasia.com>
	 <20250710002047.1573841-3-ksk4725@coasia.com>
	 <7b9a8203-2d66-4735-a6a2-762f57fb5cef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 09:10 +0200, Krzysztof Kozlowski wrote:
> On 10/07/2025 02:20, ksk4725@coasia.com=C2=A0wrote:
> > From: Hakyeong Kim <hgkim05@coasia.com>
> >=20
> > Add dt-schema for ARTPEC-8 SoC clock controller.
> >=20
> > Add device-tree binding definitions for following CMU blocks:
> > - CMU_CMU
> > - CMU_BUS
> > - CMU_CORE
> > - CMU_CPUCL
> > - CMU_FSYS
> > - CMU_IMEM
> > - CMU_PERI
> >=20
> > Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> > Signed-off-by: Hakyeong Kim <hgkim05@coasia.com>
>=20
> Confusing order, unless you really understand this, but considering
> you
> did not add your own SoB I claim you do not understand this. What
> does
> Ravi's SoB mean here?

Ok, I will update the SoB section in all the patches.

>=20
> > ---
> > =C2=A0.../bindings/clock/axis,artpec8-clock.yaml=C2=A0=C2=A0=C2=A0 | 22=
4
> > ++++++++++++++++++
> > =C2=A01 file changed, 224 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/clock/axis,artpec8-clock.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/axis,artpec8-
> > clock.yaml b/Documentation/devicetree/bindings/clock/axis,artpec8-
> > clock.yaml
> > new file mode 100644
> > index 000000000000..baacea10599b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/axis,artpec8-
> > clock.yaml
> > @@ -0,0 +1,224 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/axis,artpec8-clock.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Axis ARTPEC-8 SoC clock controller
> > +
> > +maintainers:
> > +=C2=A0 - Jesper Nilsson <jesper.nilsson@axis.com>
> > +
> > +description: |
> > +=C2=A0 ARTPEC-8 clock controller is comprised of several CMU units,
> > generating
> > +=C2=A0 clocks for different domains. Those CMU units are modeled as
> > separate device
> > +=C2=A0 tree nodes, and might depend on each other. The root clock in
> > that root tree
> > +=C2=A0 is an external clock: OSCCLK (25 MHz). This external clock must
> > be defined
> > +=C2=A0 as a fixed-rate clock in dts.
> > +
> > +=C2=A0 CMU_CMU is a top-level CMU, where all base clocks are prepared
> > using PLLs and
> > +=C2=A0 dividers; all other clocks of function blocks (other CMUs) are
> > usually
> > +=C2=A0 derived from CMU_CMU.
> > +
> > +=C2=A0 Each clock is assigned an identifier and client nodes can use
> > this identifier
> > +=C2=A0 to specify the clock which they consume. All clocks available
> > for usage
> > +=C2=A0 in clock consumer nodes are defined as preprocessor macros in
> > +=C2=A0 'include/dt-bindings/clock/axis,artpec8-clk.h' header.
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-cmu
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-bus
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-core
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-cpucl
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-fsys
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-imem
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - axis,artpec8-cmu-peri
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > +
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 5
> > +
> > +=C2=A0 "#clock-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 1
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
>=20
> reg goes second, after compatible (Samsung bindings are not the best
> example because I converted them long time ago before many coding
> style
> practices were encouraged)

Ok, I will move the reg property.

>=20
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - "#clock-cells"
> > +=C2=A0 - clocks
> > +=C2=A0 - clock-names
> > +
> > +allOf:
> > +=C2=A0 - if:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
>=20
> Drop contains.

Ok, I will remove the contains wherever applicable.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
st: axis,artpec8-cmu-cmu
> > +
> > +=C2=A0=C2=A0=C2=A0 then:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: External reference clock (25 MHz)
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: fin_pll
> > +
> > +=C2=A0 - if:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
st: axis,artpec8-cmu-bus
> > +
> > +=C2=A0=C2=A0=C2=A0 then:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: External reference clock (25 MHz)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: CMU_BUS BUS clock (from CMU_CMU)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - d=
escription: CMU_BUS DLP clock (from CMU_CMU)
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: fin_pll
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: dout_clkcmu_bus_bus
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: dout_clkcmu_bus_dlp
>=20
> All these names should be changed to match what is the input. Look at
> latest bindings, we moved away from that style.

Ok, I will modify clock-names to "bus" and "dlp" and will update at the
other related places also.

Thanks,
Hakyeong Kim

>=20
>=20
>=20
> Best regards,
> Krzysztof


