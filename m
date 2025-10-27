Return-Path: <linux-kernel+bounces-870758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BDAC0B9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4F018A08A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFACA28C849;
	Mon, 27 Oct 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="fwssSO/0"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EA7083C;
	Mon, 27 Oct 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529208; cv=pass; b=lqmeuIcIoGDHB6BRO+4NGy/CdCZYsdpD2qdY7UhZ3krSW7zswNeMinjivWnVARdaM+Nma4ye1+mspr4VvJpU7LMM9hZWm/9Mdxx5kiKy6Hkqzcc4hQfoyIWocjOgO64Xft9UFbKeCZKffC8BZ+M/Mr6CFC+Eh3b38bgUbwPvFDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529208; c=relaxed/simple;
	bh=sFLU71Pa7OQpJkrvg3nrjotjHRe6lIiWdpJR2mPy5EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foX1g1/cwPDcG1L0wpKdiJ4njFB82+08BXbYBxxIDIXHpXV0ldNGCxEinnoGux7eOoWCggH/EdkAU5Y9gh/P5Ng/kkCOa4rORv9aB7fcWWjI/wW6IICl9RoDVqi6d8pDqBNkDpDhAfkDMYQfmMPaqC3nK3tcxXgwCmuJiLuipo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=fwssSO/0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1761529176; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I1To7CQ/N9w65YjOf4u0X+eyxsyw8XxE6qSgTzz2kMc2i6d6hbkXFJhfnlfS02L/aYGX2PivK41MIeeOl60IRdBhEydgJRq8HTTKhy6wfBQTEFuHdOBapcz1J7vKiECna8FQJ95C3jJwakyeRZPNJ/kZAqzBLUtVkmKd3hchCqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761529176; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JoGIXRFcAng7DM+SqkhKz/acJkJyRWeHRK0Hc2jgQto=; 
	b=aBPPCjDPxXAeuPupkg5noJartf1AgACcmGtlAn3fIBpgoX1xEHN3FaEZtT3EjJxSPtTt/gqF6/n7I3wUnwAgoThoRxTKau0Hp8JLTMUT3jciB8rtLW59sAsIAB2fmegqsKo2As4xma016PSuq/hr3Wox8134ehnRjfguF8+DXWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761529176;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JoGIXRFcAng7DM+SqkhKz/acJkJyRWeHRK0Hc2jgQto=;
	b=fwssSO/0UmKwpLR5wHtQKh++2OabRrMc2Ts5aM6FcEwkyjt2Xwfnwhjlm8uPo84a
	mFmuDEdcPjDejWNHcD88lNIsQw8ZgwIN+yH7IKoHWXVM0BUKUfQKvhdBN9wsqbk2KWj
	gQIz6+YmomITZUGyjlztFJvDDFZg64rpw+A9Py9w=
Received: by mx.zohomail.com with SMTPS id 1761529174228823.0757477108508;
	Sun, 26 Oct 2025 18:39:34 -0700 (PDT)
Message-ID: <1bceed11-e7d2-4d10-93fc-b40c6e102bc5@pigmoral.tech>
Date: Mon, 27 Oct 2025 09:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] clk/reset: anlogic: add support for DR1V90 SoC
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
 <0E60AA15166FED21+aP7JRmPzDIq2WhWw@kernel.org>
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <0E60AA15166FED21+aP7JRmPzDIq2WhWw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Troy,

On 10/27/25 9:22 AM, Troy Mitchell wrote:
> On Sun, Oct 26, 2025 at 10:00:40PM +0800, Junhui Liu wrote:
>> This adds Clock and Reset Unit (CRU) support for the Anlogic DR1V90 SoC,
>> as well as corresponding dts bindings and dts integration.
>>
>> The CRU driver framework is built around the clock controller as the
>> primary device, with the reset controller implemented as an auxiliary
>> device. The clock part refers to the vendor's code [1] to determine the
>> structure of the clock tree.
>>
>> The Anlogic DR1 series includes not only the DR1V90 (based on the Nuclei
>> UX900 RISC-V core), but also the DR1M90 (based on the Cortex-A35 ARM64
>> core). Most of the clock tree and CRU design can be shared between them.
>> This series only adds CRU support for DR1V90. Nevertheless, the driver
>> is structured to make future extension to other DR1 variants like
>> DR1M90.
>>
>> This depends on the basic dt series for DR1V90 SoC [2].
>>
>> Link: https://gitee.com/anlogic/linux/blob/anlogic-6.1.54/drivers/clk/anlogic/anl_dr1x90_crp.c [1]
>> Link: https://lore.kernel.org/all/20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech/ [2]
>> ---
> Do we really need a cover-letter? Since you only have one patch, Is it
> better to put the above information below the --- line in the actual patch?

Yes, we do need a cover letter since there are 6 patches in this series.
I think the b4 tool only added you to the To list in patch 0 and 1 because
you gave a Reviewed-by to patch 1 in v1. You can check the full patch
series from the mailing list [1]. Thanks.

[1] 
https://lore.kernel.org/all/20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech

>
>                                        - Troy

-- 
Best regards,
Junhui Liu


