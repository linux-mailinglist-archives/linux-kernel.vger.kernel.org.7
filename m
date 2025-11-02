Return-Path: <linux-kernel+bounces-881930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84031C2941E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85680188B790
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357F22E092B;
	Sun,  2 Nov 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VP9PRTxK"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024C1F4169;
	Sun,  2 Nov 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105358; cv=none; b=MUyJ7GmPs7c8i3yvpDPniD7cpxB/p1vyfxSpXiLQpMSL3o0WcAdZNInRigLZBOTk6bBUMLlOfWmmrQNIsTwxnalPgJvK4RI9RPMi6/CRMrQ6VHBEbSPkyIq1tLhJKUWFHT3dQEWixFq7Z9/5cbCVr1HLidD1NfvRmCy4lJCttsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105358; c=relaxed/simple;
	bh=eWf1ssYER9+ZZB8rUrrghh1FssKnX/b4h4BzwdjLbu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpLmFLfb2YWS6j09y+sQFrvr+9HnNpQg8ugrQK6QyWCWyC90VSeb9LUKnW7OKLxqY/WENXZaBb9Lhashi5EWG+40C43SZ8I8GcXehmags8EFEqrutdmgembhZiQIh3C13KlH/mU+rof3rmqrnzd6uGJlCC07cz0aIn/lyKuoRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VP9PRTxK; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d029P19yRz9sxG;
	Sun,  2 Nov 2025 18:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762105353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebfnwj7tMpis+tR7jktZ8bbJq6Qt0Nfjii5Z7X6heM8=;
	b=VP9PRTxKRANrUVATpLf4VpHENaXsPDbREzODzM8r+WFvGQ/++XvFMtw1qGHV1h4Fo1h4X3
	gHHeLPJ/jPdlwUlGKqEHK2dYKhnla7T79zRVnSJXaQmA4SX+bs2tO/8fzM57LLD2pPKhlm
	6fV254HOzBLCUrKXWx+uCcOLffONq80p+E5lp9R0asgGAPQnpqfppepsesVxCq76SN8KqS
	F86GqtTjt+N0bdPjUTLOHmFph/dNbTnjmQyJ5gslpeBuNUb2qdlANqP6qI8l1Wc/31bNMp
	NfXHS6y9WXwQFuuVxsAxcoH5NpZL6L6nAbpNXI1GCNEDQK1uwa8tCrehg0kZQg==
Message-ID: <636f24ff-e775-468e-a13b-b86542098c74@mailbox.org>
Date: Sun, 2 Nov 2025 18:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 E Shattow <e@freeshell.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
 <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
 <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
 <afe58aa6-0c3e-4508-8133-8e7621a0484a@mailbox.org>
 <PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: siz7namta7ztp8gt3hs83jgy4x3gfjit
X-MBO-RS-ID: 6783862ee9dc7f685d6

On 9/10/25 9:07 AM, Peng Fan wrote:

Hello Peng,

>>> Marek,
>>>     Some U-Boot code indeed directly use the IDs to configure the clock
>> without
>>>     relying on any drivers. Since the SCMI IDs could not be moved to
>>> dt-bindings,
>>
>> Why can they not be moved to DT bindings ?
> 
> DT maintainers suggested to keep the files under
> arch/arm64/boot/dts/freescale/
> 
> https://lore.kernel.org/all/75ab9162-ed02-479d-92a1-7cfabff6b32e@linaro.org/

I think the larger question really is -- are the SCMI clock IDs part of 
DT ABI or not ? The SCMI clock IDs are part of firmware ABI, for sure. 
Does that imply they are part of DT ABI too ?

Or, is there by any chance a plan to allow e.g. resolution of SCMI clock 
IDs by their shortnames, and allow SCMI clock IDs to change across 
different firmware versions, even on the same platform ?

-- 
Best regards,
Marek Vasut

