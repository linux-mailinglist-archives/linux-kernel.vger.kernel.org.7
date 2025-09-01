Return-Path: <linux-kernel+bounces-795392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F725B3F15A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553337B07EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C176285C85;
	Mon,  1 Sep 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rBH0tXnH"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5032F75D;
	Mon,  1 Sep 2025 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756769567; cv=none; b=iJ+Sy0hw4Syz7QzTFSIxstubhzFUwjUDPnyh/ooX/wHoB067Df2xwCia2njj/3PHQivRC8qMJ94zClMmH5hLMkXibTbgFiDqe5DByJntymGrP2/bq8C42wYWO62IN0iAQmeoiJYmO4z8JOgGRpbbnsG3g2FONuDJAK0pAYySFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756769567; c=relaxed/simple;
	bh=sZjP5amXMPrxZMOpY/Vcag7mrN4zZ3huedD5PnZqACg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkInPgYBkBd2wR7S1YZQr+g/lP2UY3mJWJ19COIrlFrFFkdk8J+B7KNcKJYrtwTNUxRRDNW4vGLXT/BsxGmOHWprkvk1m+CrzkQpbt06Mo9vAa/WRuSDtnCS0MNiKTCDaHsX7WYAiOANfbkYB17sBYQLsBlWpi2BCRsJNIXn4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rBH0tXnH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cG4t24TCTz9t5M;
	Tue,  2 Sep 2025 01:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756769562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21cy0heJjmP9Ld43G50zc2SVhk5aa4VJAaf/J1BjNx0=;
	b=rBH0tXnHVrXPb8dCrZ4CQ2TwrIYBKhZISkYa24/yPyJPUnQKlR1HjpfVrlj5PgXzukKbeO
	LpRxIQOHXSVkIsMPVAYM1fvnNMq3dvQ/WrD/0ZytPMR1OCBqt62u9M60C/s4GjEm1cx5iR
	6mCBkvLWbFFGsZOYRq/sYA/oSJzgemPsE1OImBKLwzlY7KUvfgtdWPcNNOebPdx3XaU9u2
	rq+fNX2VNdwsNJik/KXQZJeaCUqzN5RdoSYEo5TDwdDc5Da7OYIzJE198jIM0gVZMLiU8J
	OWaeNVWQoF+8Z3Rut0e8G9R1Mci/Yi6/EDhVGJR52e1gjjJq9INC5E/sb7ztoQ==
Message-ID: <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
Date: Tue, 2 Sep 2025 01:32:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 E Shattow <e@freeshell.de>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7953aab8df04900d273
X-MBO-RS-META: ox39hmicyjhub973d6jzuxm3y1aktfrc

On 9/1/25 12:54 PM, Krzysztof Kozlowski wrote:
> On 01/09/2025 12:30, Marek Vasut wrote:
>> On 9/1/25 5:33 AM, Krzysztof Kozlowski wrote:
>>> On 01/09/2025 04:22, Marek Vasut wrote:
>>>> On 9/1/25 5:22 AM, Peng Fan wrote:
>>>>> On Sun, Aug 31, 2025 at 01:04:45PM -0700, E Shattow wrote:
>>>>>> Move imx9*-{clock,power}.h headers into
>>>>>> include/dt-bindings/{clock,power}/ and fix up the DTs
>>>>>
>>>>> No. The files should be under arch/arm64/boot/dts/freescale/
>>>> Why ? Linux already has include/dt-bindings/clock/ and
>>>> include/dt-bindings/power directories for exactly those headers , why
>>>> did iMX9 suddenly start conflating them into arch/arm64/boot/dts/freescale ?
>>>
>>>
>>> Because maybe these are not bindings?
>>
>> Please compare arch/arm64/boot/dts/freescale/imx95-clock.h and
>> include/dt-bindings/clock/imx8mp-clock.h and clarify to me, why the
>> imx95-clock.h is not bindings and the imx8mp-clock.h is bindings.
> 
> That's uno reverse card. I do not have to prove why these are different.
> You need to prove why imx95 are bindings.
> 
>>
>> Both files list clock IDs for the clock nodes, one clock one is SCMI
>> clock (iMX95), the other clock node is CCM clock (iMX8MP), and they are
> 
> Yeah, entirely different things. Like comparing apples and oranges.
> 
>> both (SCMI and CCM) clock nodes in DT. Both header files may have to be
>> included in drivers, the iMX8MP headers already are, the iMX95 headers
> 
> No, the SCMI cannot be used in the drivers, because these are not
> abstract IDs mapping between driver and DTS.

The SCMI clock protocol on iMX9 uses fixed clock IDs (the ones in 
imx95-clock.h), just like the iMX CCM clock driver uses fixed clock IDs 
(the ones in imx8mp-clock.h).

Where does the "SCMI cannot be used in the drivers" come from ? Can you 
elaborate on this part ?

>> currently are included only in U-Boot drivers.
>>
>> I really don't see the difference here, sorry.
> 
> You just pointed out difference - no usage in drivers, no ABI!

Surely at least the SCMI clock protocol clock driver does use those SCMI 
clock IDs , so that is "yes usage in drivers" ?

Also, the SCMI clock protocol clock IDs are being used in U-Boot 
drivers, which does make those IDs an ABI .

> Instead of playing this "I found this code somewhere, so I can do
> whatever the same" answer the first implied question - why these are
> bindings? Provide arguments what do they bind.

I am not sure how to answer this, but what I can write is, that if I 
scramble these IDs in either the DT or the firmware (which provides the 
SCMI clock service), then the system cannot work. I am not sure if this 
is the answer you are looking for.

