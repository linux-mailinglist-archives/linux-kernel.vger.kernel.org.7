Return-Path: <linux-kernel+bounces-794560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78385B3E35C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5279166BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98D33439D;
	Mon,  1 Sep 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FfZxRvOf"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA131355E;
	Mon,  1 Sep 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729999; cv=none; b=OuPWTXeRijsBu7I+cO8hHagSuWfMHpNBG/alCjD+q6mSS8HMvsQvmC8SjWioXbSNcU/xzki16ko74a+G6zUodFSQ0lKJstKtWA0p5Vvvij1D4B+7bhaKqjxLbnpOQhDW5qM8dzhKTVUWaZ/9VJnyo2JztY4ZcE6bsCJVgwgnHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729999; c=relaxed/simple;
	bh=iJ0INFxLzv5GP5m66QFzhCN6Es45in/NvPOukchdxWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hyg1f0tr041ZsKZpIViL5birGzH+IwnXCTG0JUI01R9S7+H5hJbhKLgmQ/hCEoi9jRDKObavcFiL0xLTxJIepe7IG0sGFqeMG+bouA6EwXOm9V83aDc9Rz208vTqj3nXF4DngYxhI5c8cpFmb39CdBv2GAIcOl0jdHK46wBFrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FfZxRvOf; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581CXDQS2771404;
	Mon, 1 Sep 2025 07:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756729993;
	bh=HHzZ0FqxIESHVBS2IBNz7HEwrKQZ2pXuzyqx5o4fT7c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FfZxRvOf5QnnBH32Fid7wFq1Y80oqVV9QxdqtUvPatJgn5w4nHctuAa0dn3ZZnVBv
	 BmxEBwznbQ9Gxnn7qtUc/Hf4xwOefiQ30Hne7gAIuiBZHcH3ji6FcY4NO4oaIUekI/
	 4k9EM9ZYu+dUKo6TlziueAkphlNV8Y3pMfKzUwyU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581CXDCw1541782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:33:13 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:33:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:33:12 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CX89Y2511477;
	Mon, 1 Sep 2025 07:33:09 -0500
Message-ID: <b3973566-0959-456d-bed7-c64bf3c34c44@ti.com>
Date: Mon, 1 Sep 2025 18:03:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
To: Dhruva Gole <d-gole@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-4-a-kaur@ti.com>
 <20250813130521.zpe7lguful6gyhjz@lcpd911>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20250813130521.zpe7lguful6gyhjz@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dhruva,

On 13/08/25 18:35, Dhruva Gole wrote:
> Akashdeep,
> 
...
>> Add the missing macros for deep sleep configuration control.
> 
> Please can you add sources/ links to the TRM/collateral and sections where you get
> all this information from?

Added TRM reference links
> 
>> Reword the existing deep sleep macros to provide combinations that can
>> directly be used in device tree files.
> 
> I am not very clear on what this line is trying to say. Can you explain
> a bit more with an example of a reword and how it is helping?
Added example
> 
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
...
>> +#define WKUP_LVL_EN_SHIFT	    (7)
>> +#define WKUP_LVL_POL_SHIFT	    (8)
>> +#define ST_EN_SHIFT		        (14)
>> +#define DRV_STR_SHIFT		    (19)
>> +#define DS_ISO_OVERRIDE_EN_SHIFT (22)
>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
> 
> Seeing it on lore and in my git log -p as well, the alignment looks off.
> Please fix it.
> 
Fixed
>>   
>>   /* Schmitt trigger configuration */
>>   #define ST_DISABLE		(0 << ST_EN_SHIFT)
...
>> +
>> +#define WKUP_DISABLE        (0 << WKUP_EN_SHIFT)
>> +
> 
> These too, fix all alignment issues please.
Fixed
> 
>>   /* Only these macros are expected be used directly in device tree files */
>>   #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
...

Regards,
Akashdeep Kaur


