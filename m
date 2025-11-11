Return-Path: <linux-kernel+bounces-895097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156AC4CEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C12DD4FE4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F233556E;
	Tue, 11 Nov 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MIGkoQtJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E18335085;
	Tue, 11 Nov 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855267; cv=none; b=ARrKjDof2GNCz0EWKaKtieZxffzILi7sYzLcXzx//YThFtYUXM4AzfCClA7pj2S0wnGUFG95nZSCnE7EvwYy7B1BBS67fBC4p+iwAbO+LJQxA76o/8DM9RV1P7k4BlJmuKx8vm8xZdj9fmH5SLNV7RHQhfHPa4bMq1JOK6aScUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855267; c=relaxed/simple;
	bh=e3fqwRbOVt7OA+FEvmyZw2a0p2NHT5gR8SasjQ8stTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COKgfF0EvW2LkbYhXoAifGJxJzHUrrKEjukZnjW2ZaIIi/xPQ9DbKsJ24g79EDf/BYyH282m9WlsXblqEQE1QGvrR/5OgeYi+7R0B+ofHPUpKBKXVTQHMGdSrXH96oSCOUzlm43QFccfEyMrO1wqbij0qIqD8p6pHIvfLGB6VAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MIGkoQtJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762855265; x=1794391265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e3fqwRbOVt7OA+FEvmyZw2a0p2NHT5gR8SasjQ8stTc=;
  b=MIGkoQtJIBiYcX538TdOgPynowipdNxVP2IxNfCdnHTBhkkFWPywanTh
   0s0LaIuS/XVS1QE/YJiCpcrBi/IXltd1FwCGkDwwxQ0sI85gqbqctnATI
   zKuqgCgVAFD0+uMC2quab9/rRkfQ3E4PlgYYW4kYEyZnGKpSZXxCKgDYx
   A4Qwq2YS2Qxkoygt4DWODWP1J05pHsNtWPK/9/J40x/A/jsBS37VfqEyJ
   USTpOH2UZwoEwIEroMmNfa+6eNKq5JLfCEiIP/oEoBxNSMpwUHEn53/bY
   aMvu/TXqjXzPUi1Wh0KDsQQJiIpnrSeMIJvS5UndYpfgcx+4h5zQ9IMyt
   Q==;
X-CSE-ConnectionGUID: 2dh2N22+RT2H7OEQxVeL+A==
X-CSE-MsgGUID: DtILuQYCTuKnZZVhVVHmTw==
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="216293010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 03:01:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 11 Nov 2025 03:00:02 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 11 Nov 2025 03:00:02 -0700
Date: Tue, 11 Nov 2025 10:58:31 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional
 microchip,sx-tx/rx-inverted
Message-ID: <20251111095831.lp4kvdfcahtwgrqc@DEN-DL-M31836.microchip.com>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110110536.2596490-3-horatiu.vultur@microchip.com>
 <20251110-unwound-award-a11d69b9da4f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251110-unwound-award-a11d69b9da4f@spud>

The 11/10/2025 18:43, Conor Dooley wrote:

Hi Conor,

> On Mon, Nov 10, 2025 at 12:05:36PM +0100, Horatiu Vultur wrote:
> > This allows to invert the N and P signals of the RX and TX Serdes
> > signals. This option allows the board designer to trace their signals
> > easier on the boards.
> 
> Why can't this just be done in software, debugfs or something like that?
> Maybe it's just your description is poor, but sounds like the intention
> here is to just switch things around for debug purposes.

I don't think it should be done through debugfs. As this describes the
board layout and I don't think someone will want to change it at
runtime to see how things behave. So maybe the description is poor.

> 
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> > index 6e914fbbac567..21b19e06a75aa 100644
> > --- a/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> > +++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> > @@ -41,6 +41,30 @@ properties:
> >        - The macro to be used. The macros are defined in
> >          dt-bindings/phy/phy-lan966x-serdes.
> >  
> > +  microchip,s0-tx-inverted:
> > +    type: boolean
> > +    description: Invert the TX N and P signals for Serdes 0
> > +
> > +  microchip,s1-tx-inverted:
> > +    type: boolean
> > +    description: Invert the TX N and P signals for Serdes 1
> > +
> > +  microchip,s2-tx-inverted:
> > +    type: boolean
> > +    description: Invert the TX N and P signals for Serdes 2
> > +
> > +  microchip,s0-rx-inverted:
> > +    type: boolean
> > +    description: Invert the RX N and P signals for Serdes 0
> > +
> > +  microchip,s1-rx-inverted:
> > +    type: boolean
> > +    description: Invert the RX N and P signals for Serdes 1
> > +
> > +  microchip,s2-rx-inverted:
> > +    type: boolean
> > +    description: Invert the RX N and P signals for Serdes 2
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.34.1
> > 



-- 
/Horatiu

