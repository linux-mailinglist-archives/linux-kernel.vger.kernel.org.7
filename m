Return-Path: <linux-kernel+bounces-896719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DDAC510C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3897E4EB287
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C652F2603;
	Wed, 12 Nov 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XCCBJQli"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B329B793;
	Wed, 12 Nov 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934706; cv=none; b=tdUBuK7IHf6LSgRRMmxr4iEx72ZN0IxWdnrmjRZsit42YjmGsO0m0PRiWo1wgedfjZQ9/WFPRhEKRcJVqTZdbTsy3rWHekuGdixq1CCHc5DhXHQNR36ulp+0+iSNIA7rvcOrAKDNEQPaRT7Wkdbkwh4PPWmhyGxIEWuHtZAiHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934706; c=relaxed/simple;
	bh=7fgngQWE5JqhzDwfazakRBCRmnVFrLFlRIkASUf9MlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJhLTMS/YA09yzUNsvPgV8fzo1GbX6NZBUxvme2I50U1jpCE1Ya1r6YC3Yx2iFGfXzYrIKZg36ZbFuKDG+1JEyO8Pom3X/YON2Xui8tiI9jUvZOJ8AVRWj3rrH1Lj8h+O1NbtYDBDgZ2SpxCpB3n1GsOyfTKqZCrBv/Zqe37mQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XCCBJQli; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762934705; x=1794470705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fgngQWE5JqhzDwfazakRBCRmnVFrLFlRIkASUf9MlU=;
  b=XCCBJQlicHH/Xo0eeuUcdT2stoJ2arQZpOwtU33uH6NKOLfomNjZHx+1
   zLP8EQzUK3Z5fnJ9xJN1ZkcsRy3hTCwtrK46MAjNvcZlVaImyLIvDza6Y
   /q8KpEsArBbVU4KmkZQ9g72ngIWfLQ2/VFYBISiVZ3pwDlU57me961/9S
   Cx7uxgF2aO6klUn7qmTyLhfaa9h09z8jlM6oSpVSggTpNavaWSGUbGAql
   Uj+p+yfa/ftUr0TCjusdT9qhU0Wu7WKEm9+TPxBPSheSwwSS6wZU5rBqt
   +ItPAtxA1ZpRsU6bu3r6lxVUZ8opVXyGRxHyWig5gbmb9M4odtwFYsGbq
   g==;
X-CSE-ConnectionGUID: O+7tn57RR6yiVzrz+41PbQ==
X-CSE-MsgGUID: /JM4zLgETfazU5PP2MMZiA==
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="49497723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2025 01:05:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 12 Nov 2025 01:04:07 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 12 Nov 2025 01:04:07 -0700
Date: Wed, 12 Nov 2025 09:02:35 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional
 microchip,sx-tx/rx-inverted
Message-ID: <20251112080235.c5iinfnketsunefy@DEN-DL-M31836.microchip.com>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110110536.2596490-3-horatiu.vultur@microchip.com>
 <20251110-unwound-award-a11d69b9da4f@spud>
 <20251111095831.lp4kvdfcahtwgrqc@DEN-DL-M31836.microchip.com>
 <58b0d712-48a4-4490-a63f-404716844557@kernel.org>
 <20251111-ploy-dispersal-164ae403df4d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251111-ploy-dispersal-164ae403df4d@spud>

The 11/11/2025 17:39, Conor Dooley wrote:
> On Tue, Nov 11, 2025 at 11:06:02AM +0100, Krzysztof Kozlowski wrote:
> > On 11/11/2025 10:58, Horatiu Vultur wrote:
> > > The 11/10/2025 18:43, Conor Dooley wrote:
> > > 
> > > Hi Conor,
> > > 
> > >> On Mon, Nov 10, 2025 at 12:05:36PM +0100, Horatiu Vultur wrote:
> > >>> This allows to invert the N and P signals of the RX and TX Serdes
> > >>> signals. This option allows the board designer to trace their signals
> > >>> easier on the boards.
> > >>
> > >> Why can't this just be done in software, debugfs or something like that?
> > >> Maybe it's just your description is poor, but sounds like the intention
> > >> here is to just switch things around for debug purposes.
> > > 
> > > I don't think it should be done through debugfs. As this describes the
> > > board layout and I don't think someone will want to change it at
> > > runtime to see how things behave. So maybe the description is poor.
> > 
> > You said it is purely for hardware designer to trace signals, so sorry,
> > but that's not DTs purpose.
> 
> If it is not purely some sort of debug helper, then please explain
> better in your commit message.

Yes, I will do so because I don't see how this is a debug helper
functionality. I see it as changing the polarity of some pins and there
are few examples in the devicetree bindings where pins change the
polarity. Why I see it as changing the polarity is because the
N(negative) will become P(positive) and the P(positive) will become the
N(negative), so we just invert the signals.

> pw-bot: changes-requested



-- 
/Horatiu

