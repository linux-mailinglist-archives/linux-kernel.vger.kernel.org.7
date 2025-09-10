Return-Path: <linux-kernel+bounces-809423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C68B50D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0591541F93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2D2BE05B;
	Wed, 10 Sep 2025 05:48:30 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D0260563;
	Wed, 10 Sep 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483309; cv=none; b=qILpkCjNLeOvgcRj66ypaZUiSs2Uy5HzcMJOAWtnuMt9Vn1FvEsi3X+V3aeQVNolRzv0f590yJUzucYL11mubtM6JQPAcleI4z6eUR8gJaAj0x48314cMREHlfvH03+a3RyJ/KwzBD4LWh8Ezd65N4npRaNnYLCsUMM0Q0lmNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483309; c=relaxed/simple;
	bh=RJVBN+K7MfHBSKwRDNOws1GkEFGzP+LepVl1hqVdDok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+lZ2hb8XZRcZomSowAorgAVn1K2G2JCojryGeXYBm7DZb2VAINO/0YNkMNWasI7q2IWTIDxOp+S+xVuChV6ek73Cale0/q9xA7i344blag+O2cEX1ix0aMQU92TwIDx4hxcWLabhkgTnSZV/6/Clb6bDmttVkbTop/ZXqoGzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: zesmtpsz3t1757483248tf8f310e2
X-QQ-Originating-IP: KVh3ktC16c3+M4mK2vmK3P0xJ1csK5INbnJe0MsZUVk=
Received: from dkx-H410M-H-V2 ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 13:47:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 671171605676410902
EX-QQ-RecipientCnt: 17
Message-ID: <55CC0521CC5B0671+91c4b933e5c5f604ade4f7e314be6fe49efc9e99.camel@t-chip.com.cn>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3588-RT
From: Kaison Deng <dkx@t-chip.com.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jimmy Hon <honyuenkwun@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Wayne Chou
 <zxf@t-chip.com.cn>, Kaison Deng <dkx@t-chip.com.cn>,  Quentin Schulz
 <quentin.schulz@cherry.de>, Dragan Simic <dsimic@manjaro.org>, Jonas
 Karlman <jonas@kwiboo.se>,  FUKAUMI Naoki <naoki@radxa.com>, Peter Robinson
 <pbrobinson@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 13:47:26 +0800
In-Reply-To: <20250909-romantic-efficient-sambar-4fc38f@kuoka>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
	 <27b2ce7950fdbf28c6c8404c3f8be3c1c35d6b3c.1757322046.git.dkx@t-chip.com.cn>
	 <20250909-romantic-efficient-sambar-4fc38f@kuoka>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MrfJYRspGRl/g0y08jEFrg1Gr7cmX5Hqt+guH/fdbK/ww4DzHDHa/Csf
	HUMY7QbRdHawoldBNhjz/03ovWttQZ/BNvGhsr5Axsa41deUPzfBqPhZVmWRXYJbC2aYZp/
	nm1b8lhdg4xKWB9ZvugxxZcPZCV3yGakoB0Gvss1pUxuyJ1B6GpXXuPaywXJqWL5PwgynBO
	Bwa/u6rUu4/8zOeGrLyEcBDrrVoeU/o8Kp6Y9UEdA/JhsBtY7fjtNdcIMg00Gh1GNQUd/LQ
	AsZOoLwek4yFry/W2FPLAELzviO+tGzB+miPOmul1A0d1TqImNXlMRgJR7Z13uFy/HSVTd6
	HWH0YD6anh3t7fKl1TcdMHXg9yK5mHXjKU4kMkTzw2yllyALon9nrbNvKm/QUNQFir7L+R9
	yIDLQtf2dMUXr9ZvCE5gyXEFD+0Qn6sUD5VdM5HXy1W+U9oRiLerNAY79G7l7/qR7QQPcd6
	6Gg+XD+KUQiDVDRpkQS3OMswELU1vtoxKpi4ixL3FshDZz053lu7VJ3LTgvooW5am7lTULP
	giAUAKzR8Bbh6jvPviQZazoRb6v8ucnxX9o/RK+4fHx9HMxlcXEzjg1R6DXOulZoCz0jJFC
	fOLME+VVj+uGSODB6ebMb3cO8tD41UjjVdh4zMtqduSS07rmzxsGbH2bSN/I3q8hKNW+G64
	VnhwLcVsQWcD49/lGsK4u4JX1B4zDr9BHF5jI0ss7s85B51sPIJohv1NpIvyuRQ8lPxvvBq
	F0NKajMS7T+cYYzWspOwRBMSAH3UkSkVxA5zNkYyaPXdMiw7Mz7HQKTFOF8po6jP1Cw9Zw0
	4z9ZYCcjCP/9CXLrDHT21zBZhYsusjEhm9Vouc59z3B279yfIzHCS6DpPAWyISsCqf7qh5e
	vlEXnMRX6yteAqOoIJjVZb3dfVvebe5PHETlqHwVXEOJpQmMrs1c3zdXeyNcIWSIAFCjrsw
	MTFmDpQKI4MNFE2ctTqvtXvKPtgta3UspV39c0SCfMcNH/1f6unW4NUwaZ5K1DQHak1tB7S
	P9O8l++fS8CBWFChHx9Cs1gmaN45zLoygTL37xXGXLLBvLKCfF
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, 2025-09-09 at 09:22 +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 09:31:47AM +0800, Kaison Deng wrote:
> > This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588
> > SoC.
> > 
> > Link: https://en.t-firefly.com/product/industry/rocrk3588rt
> > 
> > Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index f9ee77f17ad7..6aceaa8acbb2 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -258,6 +258,11 @@ properties:
> >            - const: firefly,roc-rk3576-pc
> >            - const: rockchip,rk3576
> >  
> > +      - description: Firefly ROC-RK3588-RT
> > +        items:
> > +          - const: firefly,roc-rk3588-rt
> 
> That's just enum with ROC-RK3576-PC. BTW, all these descriptionis are
> completely redundant. Actually getting harmful, because copy+paste of
> the same is only obfuscating code.
> 
> Best regards,
> Krzysztof
> 
> 

The ROC-RK3576-PC is based on the RK3576 SoC (4*Cortex-A72 + 4*Cortex-
A53). The ROC-RK3588-RT is based on the RK3588 SoC (4*Cortex-A76 +
4*Cortex-A55). They are two different miniature single-board computers.
So it does not apply to the enum with RK3576.

Link: https://en.t-firefly.com/product/industry/rocrk3576pc

Best regards,
Kaison



