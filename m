Return-Path: <linux-kernel+bounces-873664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AFFC14611
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9504F308B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5630ACEE;
	Tue, 28 Oct 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="njF1zKZ/"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23A3081D0;
	Tue, 28 Oct 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650988; cv=pass; b=SBhXhRccidzMz5jSa5GkWHFvJZYp8dU2iYwk3WzAPi+Eznat81JdmzmAC+i/GLlQQTwtqWbUFSwdYuSIXACZlsksKbv0vv9iXNnD8XeraAqKBQcN50OImukRbItbwYX4KGeYjBNInZFjQyu2+5m5b1VSQbLVSkLu9d5ex/hDHQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650988; c=relaxed/simple;
	bh=tYbeQ90vGGHXXE7MCg3eqhYlsB9W8v0Z3SOU4Enjgp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaRm6YOtu1nBW8ZNpn/PQ+4xYwUGu5nlubo3T3DaM7CV07aJdGIDi/rq1VG1NuIxMJNyblieY0dnDiewr9I0y2SpuFcNZScVRo/n2jWos5f1TlEMGLg8mzAthNdn/7CTK+DZvX2zpcrE8u+6TmmQashI3+rCbVAIEXUCNdjFbUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=njF1zKZ/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1761650958; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OPE5nDWfuugw1kKa6IcPSetaU8VLCXsoaM0Nn5DkvqFPMPAtCpyRR74CKCvp8fgDrbw03ZqetOY2b58Bha7NWrdpabp+hq08LOC1lmHwhRSWOS6wlcrFbnJds11Xf4yLCMa7oe+aRw2gC1FZtUsCVunrhmyG6A3MWg321jayJrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761650958; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=htCIUeie1Fllw0gMKXGW6GDJsuGaHCRZYsDOba4fJdw=; 
	b=leSEemltU/maU1r+O9yiGVP2P+FEnVzaaExpVFmnPiimQwOvEUCH4NyS4TKf04DShFVxd3dXUgZLI7YlDzBBSUwJs0eAFMYZZR5znF/caGAnK3TWtzJVzi/FYnFDsgw6XXpTnTPcNwqryZqsg/7AnUp9w8Xd25liHtm9HHUeEPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761650958;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=htCIUeie1Fllw0gMKXGW6GDJsuGaHCRZYsDOba4fJdw=;
	b=njF1zKZ/WbjS+4NeXpMU3JLnnb5YjV33OKRR0aHXNhR7Jcwqy0kdZzM/JEXoeWlU
	ZXYj5TwdKFdb/ALbBzm3sGGOLbFJDdp6qQsqwvO3yuoa7Mbt1j6PoZgPYh1hF31oXew
	mEHjaI416JMXgTPtRsi4dT4ijkPqBbzoflyteJ64=
Received: by mx.zohomail.com with SMTPS id 1761650955763658.116487530986;
	Tue, 28 Oct 2025 04:29:15 -0700 (PDT)
Message-ID: <e66945e7-9be0-4208-8b60-ec534db4fde5@pigmoral.tech>
Date: Tue, 28 Oct 2025 19:29:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] reset: anlogic: add support for Anlogic DR1V90
 resets
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
 <20251026-dr1v90-cru-v2-4-43b67acd6ddd@pigmoral.tech>
 <36d28431c41ec9ed86487135d81e50b136ee0fae.camel@pengutronix.de>
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <36d28431c41ec9ed86487135d81e50b136ee0fae.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Philipp,
Thanks for your review.

On 10/28/25 4:17 PM, Philipp Zabel wrote:
> On So, 2025-10-26 at 22:00 +0800, Junhui Liu wrote:
>> Add reset controller support for the Anlogic DR1V90 SoC, which is an
>> auxiliary device associated with the Clock and Reset Unit (CRU). All
>> resets are active-low.
>>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>   drivers/reset/Kconfig        |   9 +++
>>   drivers/reset/Makefile       |   1 +
>>   drivers/reset/reset-dr1v90.c | 135 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 145 insertions(+)
>>
> [...]
>> diff --git a/drivers/reset/reset-dr1v90.c b/drivers/reset/reset-dr1v90.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..eb9064e3ab454fb39adc1ad426f458e39bb6169e
>> --- /dev/null
>> +++ b/drivers/reset/reset-dr1v90.c
>> @@ -0,0 +1,135 @@
> [...]
>> +static const struct dr1v90_reset_map dr1v90_resets[] = {
>> +	[RESET_OCM]		= { 0x74, BIT(4)},
> [...]
>> +	[RESET_NIC_HP0]		= { 0x78, BIT(0)},
> [...]
>> +	[RESET_USB0]		= { 0x7C, BIT(0)},
> The registers 0x74, 0x78, and 0x7C are exclusively used for resets?

Yes, these three registers only contain bits for resets according to the
register list doc.

>
> [...]
>> +};
>> +
>> +static int dr1v90_reset_control_update(struct reset_controller_dev *rcdev,
>> +				       unsigned long id, bool assert)
>> +{
>> +	struct dr1v90_reset_controller *rstc = to_dr1v90_reset_controller(rcdev);
>> +	u32 offset = dr1v90_resets[id].offset;
>> +	u32 bit = dr1v90_resets[id].bit;
>> +	u32 reg;
>> +
>> +	reg = readl(rstc->base + offset);
>> +	if (assert)
>> +		reg &= ~bit;
>> +	else
>> +		reg |= bit;
>> +	writel(reg, rstc->base + offset);
> There should be a lock around this read-modify-write access.

Okay, I will add a lock in the next version.

>
> regards
> Philipp

-- 
Best regards,
Junhui Liu


