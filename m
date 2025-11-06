Return-Path: <linux-kernel+bounces-888028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF736C399D5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56BC14EF5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5524308F3A;
	Thu,  6 Nov 2025 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="cWhr1oqh"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281B2D0C66;
	Thu,  6 Nov 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418530; cv=none; b=WLDKoSeHQEQguzVYXXfyP3/aZ+B9urFKsCeeFRIDnPHXukKMjvQquw3fphbSVucAIviXzDyOmRMTfwNFLw5JKF8jNR65m7u0gfxb0epz4JkDVO0wT7Qr1TjmRR7Gn2X1hz/DghgZVxrvmG7ppCuGHBJ2+2j+L8n2kUDFHg2z8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418530; c=relaxed/simple;
	bh=aO/sdUf6lM54QirIfhiTr1e4Iamqnl70j+qLacTd3mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ7WdJI0nr+lbepIrqrfHIhoUem5OugYrcxcjSKACau+wBj0IitTnvukdiDRpdwq3EYyT2R84j160UOPzKGsgyQCTIXqL1hJ7Wd2a8rfyg3otxrI/45gNh96R0jPGm358CbJr30E3XWdXQxXeQgC03zyav3if4n2FeltGxmn2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=cWhr1oqh; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1762418525;
	bh=55OuAQr6FIZPr3TAwPNOMnE17WSzk2mx5oUi4VbSojU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cWhr1oqhH0GPTEogfnukErJBnrRr5LRJdzBFsZJi6gqihZMJ5G2B0lrSaK90WA//i
	 JiQ9F3ODec8Pdo2t8YzOIEYpAevHj7AmwcU6AIt4EteEm5q3RWiFBMMK9PNWPqSEZO
	 RUpNnbQrQMYRhvhgLwPverOnuoK/dEx9Y8cG31uc=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id EBF96A03F0;
	Thu,  6 Nov 2025 09:42:04 +0100 (CET)
Message-ID: <5379d7f2-24ce-4730-ac39-f2f103403da2@ysoft.com>
Date: Thu, 6 Nov 2025 09:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Model the RGB LED as a single
 multi-led part
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251105152555.1992513-1-michal.vokac@ysoft.com>
 <20251105152555.1992513-2-michal.vokac@ysoft.com>
 <CAOMZO5AKmKWciyF7-f_mVfJWdLB1rjh_Xi=BhkBAcmV=cJ-nyg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <CAOMZO5AKmKWciyF7-f_mVfJWdLB1rjh_Xi=BhkBAcmV=cJ-nyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 16:55, Fabio Estevam wrote:
> On Wed, Nov 5, 2025 at 12:26 PM Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>
>> Describe the RGB LED indicator according to the reality - it is a single
>> part containing all the three R,G and B LEDs in one package.
>> With this description the chan-name property becomes useless, remove it.
>>
>> issue: HWOS-816
> 
> This issue notation appears to be an internal matter. Please remove it.

Ups. I will send v2.
Thank you Fabio.

