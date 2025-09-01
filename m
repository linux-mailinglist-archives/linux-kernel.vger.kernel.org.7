Return-Path: <linux-kernel+bounces-794337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7459EB3E02D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084733B3974
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2430E854;
	Mon,  1 Sep 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WShtJv3j"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1833F6;
	Mon,  1 Sep 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722660; cv=none; b=rIKf94sKyfIQNgX7IEMxn4cXjuoEIkyyAHUPWpy1ZUO/ii/wz5CwKC2XH9ZMBO2kLAdA0dZnQMImqwdYfLoXQct0TxvtKFM0+k77pdHtxQIfEFqmxelYk12YD0x+5vTeI9mX42B+tg0wQLXI6Lk5nmEZg7esOJlB/+juwDlH20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722660; c=relaxed/simple;
	bh=cdecocXK5fiAUTGZOd1KKjcZ3IM9twg/URFPgonHzuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfQ+IUELZ55amE2+3zUjVprNdw31dbwOmzfYcS236yo8QKuOoFM1VcpzzjESkdnrJelgWJEXk/wY95G4DK/ta6yOxnUR00BG6+ylb307JupsyncH9v1zpn8sTtUKFuETQ2htbSDlqbXuvBEYuK3B3Im4FjbZzYf1MVpoH1zZ2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WShtJv3j; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cFlWz3Mvtz9tcx;
	Mon,  1 Sep 2025 12:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756722655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PBTt0C5Gx6hiojLqBDZVPUdijjHh91VEfxrRkHdGhE=;
	b=WShtJv3jYxoIoUZHOpT3TftdlXPwi64e9k7p204qwWCaYpF7hboaRyxSstTH0Gt/N1Wpq/
	AoXnPqp1Lly292ZxMP7aGqW/zeL6imj4B7QiInDdfBoskVZSh8bpYFN0hDKN4eWhvgjcKY
	4WHXCiPUsv4OKBlTBfj1xtg6yV+pjSq4T9/qGGAugi6EPn/1FQKtZE4KqxttGo8TowB79M
	AlF4Cg22WQMF9qVUC/eUVEdmmpCpbaiZPE5xj71kZhd7u2YHYLS2a4abYhy7qj8mvDnpxH
	I2fELANa8yO7AHfvIqzEiPH/L/pCqeMDNiVOc1G17geiy79NhB9OBdXl6uABEA==
Message-ID: <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
Date: Mon, 1 Sep 2025 12:30:51 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fd3b27795d06f701f7c
X-MBO-RS-META: 95xap3q14g4r4zuc3ine3z3bbq36zd5w

On 9/1/25 5:33 AM, Krzysztof Kozlowski wrote:
> On 01/09/2025 04:22, Marek Vasut wrote:
>> On 9/1/25 5:22 AM, Peng Fan wrote:
>>> On Sun, Aug 31, 2025 at 01:04:45PM -0700, E Shattow wrote:
>>>> Move imx9*-{clock,power}.h headers into
>>>> include/dt-bindings/{clock,power}/ and fix up the DTs
>>>
>>> No. The files should be under arch/arm64/boot/dts/freescale/
>> Why ? Linux already has include/dt-bindings/clock/ and
>> include/dt-bindings/power directories for exactly those headers , why
>> did iMX9 suddenly start conflating them into arch/arm64/boot/dts/freescale ?
> 
> 
> Because maybe these are not bindings?

Please compare arch/arm64/boot/dts/freescale/imx95-clock.h and 
include/dt-bindings/clock/imx8mp-clock.h and clarify to me, why the 
imx95-clock.h is not bindings and the imx8mp-clock.h is bindings.

Both files list clock IDs for the clock nodes, one clock one is SCMI 
clock (iMX95), the other clock node is CCM clock (iMX8MP), and they are 
both (SCMI and CCM) clock nodes in DT. Both header files may have to be 
included in drivers, the iMX8MP headers already are, the iMX95 headers 
currently are included only in U-Boot drivers.

I really don't see the difference here, sorry.

> Regardless whether you agree or
> not, the commit should clearly explain the reason behind.
Which commit ?

