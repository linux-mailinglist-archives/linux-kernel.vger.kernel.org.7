Return-Path: <linux-kernel+bounces-722845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82EAFDFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD21C27A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C25226C38D;
	Wed,  9 Jul 2025 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qgicJCkS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72226B95A;
	Wed,  9 Jul 2025 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040306; cv=none; b=r9Me6oSquMAzA33DZLv+pgiNwBeWO+swY3NJfizgumBB7229VlLsoKxAOC4p3aalYAj965W5KcSdgPQAvowGfZRrWHJGTu52m3ejpvYwpG3Gb2oXL1DcR7IEl/4ij/mV8igUp+/wBSQwpmk6ptgaRjlts7zsWr6LgQqs31GLd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040306; c=relaxed/simple;
	bh=es6WMb9hlAoxAIRRFtKatfxvtBN7hYOOl6QsivtjBDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aAHCWdqtJPr/klsPc3yEIyTJVNjhCZLw9Hg/xrx6KQuUfqzMNFLHv3WitREpLDit/p8xNRc3ovuheXMyE64jGq0IS4+7EJpLvqcgYZ1n5L4RhJvGBi8syNhObzvFmb9YjLwLBcm5RG1AK8mHAePcNcei5yIkf3Ykv2sc0R85Ekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qgicJCkS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5695pXLN722034;
	Wed, 9 Jul 2025 00:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752040293;
	bh=uWmzUqKrcVoL1as9gAY2jOX82Zk8BVied/NoOb4adzo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qgicJCkSmjf1noVZyhgFoetrqIx45c6Z1Hf1tz7wp4n7oy9i9CQLda4UccZE3vB6/
	 YMuFVB4rXejjQW81g5nkbl5fg1zyUKpoklnb7u9lckfig7C7WOjlEyLkdeCeUbSYh3
	 F8DKtRUM8206IqKplwUDGsHbsUHqqxQBtt2ZTWdo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5695pWvu2168926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 00:51:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 00:51:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 00:51:32 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5695pRhx3408594;
	Wed, 9 Jul 2025 00:51:28 -0500
Message-ID: <a8e83bd1-89bf-4288-8953-15cdfd9549b5@ti.com>
Date: Wed, 9 Jul 2025 11:21:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] arm64: dts: ti: Add pinctrl entries for AM62D2
 family of SoCs
To: Rob Herring <robh@kernel.org>, Paresh Bhagat <p-bhagat@ti.com>
CC: <nm@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>, <s-vadapalli@ti.com>, <andrew@lunn.ch>
References: <20250708085839.1498505-1-p-bhagat@ti.com>
 <20250708085839.1498505-4-p-bhagat@ti.com>
 <20250708202259.GA904737-robh@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250708202259.GA904737-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rob,

On 09/07/25 01:52, Rob Herring wrote:
> On Tue, Jul 08, 2025 at 02:28:38PM +0530, Paresh Bhagat wrote:
>> Update k3-pinctrl file to include pin definitions for AM62D2 family of
>> SoCs.
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> index cac7cccc1112..0cf57179c974 100644
>> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> @@ -63,6 +63,9 @@
>>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>>  
>> +#define AM62DX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>> +#define AM62DX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>> +
>>  #define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>>  #define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> 
> Why is the same expression just repeated over and over? Looks like this 
> needs some refactoring.
> 

Is the comment wrt having another common macro (for better code reuse)
for the right hand side here?

Or is the comment wrt having differently named macros for each SoCs?
Having per SoC macro is intentional so to avoid backward compatibility
issues when these SoC macros deviate in future


-- 
Regards
Vignesh
https://ti.com/opensource


