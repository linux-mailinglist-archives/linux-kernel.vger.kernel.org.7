Return-Path: <linux-kernel+bounces-734770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D527B08631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2651C26590
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507021C16B;
	Thu, 17 Jul 2025 07:07:12 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991D2116F4;
	Thu, 17 Jul 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736032; cv=none; b=PDdbKwNdyyTqY/mdK9GtICIj6Tu0LxIO0i47Wmkh+UKdczvRyg3vuQ5FaSakXtKNrAagRx3HFo4d2UVoSM12qnJEJtN3/5eUzaVouQa5+XtBM8ttoVRrf2bZPdpUS15zJQfrQO29TXO95Ed3/6MYlMVO5XLMCiNJaQBVBbbi//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736032; c=relaxed/simple;
	bh=RahtlL6mBlyJZfn1DLAzd6+oJqncdb82FIkd27+Czpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8nUp8+Z3ahNzE3Ynq75p3IsXnmAm/jUkpg1wIl/f9dQM6Ax3lZk0vPTiW+Q8x1uUVAopzC+gQZxqna70ZpkmwBrrQLZ5Na0BuroXKP5NE5wPg8GhwXgayaBYGUIkHTiUCom/g4DKBz8GfGmeW4BJKzJgUk9gjQFxTehQLP/yOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.108])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id E3DBBB4D0F48;
	Thu, 17 Jul 2025 09:06:59 +0200 (CEST)
Message-ID: <c3d8693e-f7f5-4072-bdce-2bb0778c77c3@freeshell.de>
Date: Thu, 17 Jul 2025 00:06:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-milkv-mars sort properties
To: Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716061940.180231-1-e@freeshell.de>
 <CAJM55Z_77aygReSPJyZMtfZWk_UPYTzYLH5E5uEw6K=GSu0LNQ@mail.gmail.com>
 <20250716-strategy-evasive-57b400af9366@spud>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250716-strategy-evasive-57b400af9366@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 08:28, Conor Dooley wrote:
> On Wed, Jul 16, 2025 at 02:17:34AM -0700, Emil Renner Berthing wrote:
>> E Shattow wrote:
>>> Improve style with node property order sort of common properties before
>>> vendor prefixes
>>>
>>> Signed-off-by: E Shattow <e@freeshell.de>
>>
>> Thanks!
>>
>> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> I'm going to pick this up, but it may be very late for 6.17.

Yes. The other questionable sort style in this dts I was looking at are
whether we want "compatible" before "model" in the root '/' node?  And
then why we have this common pattern of 'pinmux' (or pinctrl*)
prioritized firstly in the natural sort order, also pinctrl-names before
pinctrl-N is a common pattern that seems an arbitrary reversal of
natural sort order?

Thanks,

-E

