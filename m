Return-Path: <linux-kernel+bounces-805276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60FCB48652
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D860A189A6DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE42E8B9C;
	Mon,  8 Sep 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TqFocPWl"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434F1DF74F;
	Mon,  8 Sep 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318649; cv=none; b=bg96+QM34aPegdFJoDaQ+/GCyQsqJxDQUwgbUYqkI9I7B1Kv1rJsVL1QAv9FX2EtT5IJz7JcaNSrSe0A0HoRMhQ7vKWD0KArM2nPzvHU/nSCf+XbTSpfgUBwqzwXBCcfn/lRvbusFPbTTrioj8gALPnrWb31UZ4Sbgjn5CN1NT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318649; c=relaxed/simple;
	bh=kl7itNdixLb2ZkrgJQWmvlLExsb+N4rmlaosXBUykec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZfyIuwAqXC58oXo78PbVfiifB1UzEl3VfrN7JCzt5cxt0ETMae60hTriXoLrGuJzPqycNy26u3sQtbja3n5/284e1s4PRXfp6XXv29W7UFBa00mZnFOd7Dp1FdCOZdcfZ1C+tprV02zVhaTv5cdTSUPtcnOq9mZ4CXcWDIPeSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TqFocPWl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C0F33A0816;
	Mon,  8 Sep 2025 10:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=vzIuQPf8yRRh32wjvtWM
	h26ibdLGHtiKlRRwUvAoFVc=; b=TqFocPWlS658xcLrcQJpe7WV2ehoQ9oQtujh
	OCoMl2FGVlYkymW9It5Qh1K4vJlXOIw3XLFuH2QcZNhUI0Dh/Md/RiKZEtMEJW1C
	EoVqVkZBP+jCellOs65tUJtS57AkdURAizQSbZ8vHxnvYCEcw8x6C8mDOJ3g24E1
	+GBENT/uV2Akmu1N5ey/FVaBKaIp/z4yjUz1hc1CNDaWTnAINq3nVr835bOatwt7
	HmqQXbSh6hlAncgwnRY3cPGJMZ8k5rX965LlIrB2s70Iv6MUEeNQkZDlk81kR+iK
	gT9i/OsjHW3frrPDi8ehwq3cbHBsJJIS16IpbBJBNImR7odNSwxgaS48d8qVNG4O
	vT9D/SKL3ypputiUpjuQsc1mHyDZ48HnK0cPgFuH4ea24PFaMeFp+TtKBtLpOwS3
	2aS1oCJ1j1CR0bX0pAQDnBfzuNE21LxoAyjlc4Fe/UQ41KA/y995xkMvA5oZaC9C
	Vj3EonVM13eqWLAZcoRwTOigLQwdJbYMSmoneZ2c1AB31rd5B8k3KugRCHGDa9jg
	TG8pmbmAH6Q3QT08MZbmVgFK2KwayLRfrizy8bYKWNsgIswWZN1pAWMYrN0i6QPM
	0B+GJstOyg07SagmOlxwB4n3CnuCWQsBATIuHp2KtMCuzgvreLUw00bo1QNXpGWW
	jTh7V+A=
Message-ID: <0b94d62d-6cbb-411b-8bb6-6f23023c5001@prolan.hu>
Date: Mon, 8 Sep 2025 10:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: imx6-savageboard: Replace license text
 comment with SPDX identifier
To: Milo Kim <woogyom.kim@gmail.com>, Milo Kim <milo.kim.w@mediatek.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>
References: <20250709-savage-dts-lic-v2-1-07e0f827bd18@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250709-savage-dts-lic-v2-1-07e0f827bd18@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E627560

Hi,

On 2025. 07. 09. 9:30, Bence Csókás wrote:
> Replace verbatim license text with a `SPDX-License-Identifier`.
> 
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
> 
> Cc: Milo Kim <woogyom.kim@gmail.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Milo, what do you think?

Bence


