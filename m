Return-Path: <linux-kernel+bounces-794567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63979B3E35E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00548189FAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6363314A8E;
	Mon,  1 Sep 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FXviXmr1"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3126D4F8;
	Mon,  1 Sep 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730182; cv=none; b=CUgOq6M3PnOpX9+bVoZ66maEHak2OLMdFMMJC4fREc0vlpx5kOM1ntk1xL/m1NygTZ8m9Os0D/cKl+6bqkQ4R35H5nnj5+/hUyW2FkqlDXAuLplZcz0pOFb+A0HDWcnbMENiIg4XpwoO+LkgdlxtAdF49tFu1DwWDs7dq02ij1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730182; c=relaxed/simple;
	bh=JTR+HJ7M3nxSF98EBlWH2/ZWC6P7OY4FiE8itSmkYvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TvBC5nYw2Qd2jLLIoyNggoPi/JqlGAPA/eAGAdLi4GA6q9hWtktQECwO8XjkDMvK/AW5F3oNaSjoxWQAKEI2mbBliwlOI3WMBmtpxlJQeEM36GAFSGJ7Mrsuzn4JweGb3rSDHsq9W1O5zs03YUiOh2qoEidqD+OKbx68ty8MgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FXviXmr1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581CaFKw2370398;
	Mon, 1 Sep 2025 07:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756730175;
	bh=KBhm91W/X6btvvCZjMsTtSPxGaGBYZHao/LH8z03qog=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FXviXmr1OZDsrkmSPqK01MrRoDoUtP+R3+qDhLBBU0D9eqGOHb81jaik1nXtXkbcv
	 DDGUCD2sFRUOxGVAHhNnG1rqh8S5j0xxex//gkK2iG5yyuEEN3EEl0CDE/nKZrZ9XM
	 OWVdRlFDSmRLYg4WQ06QD3zA9WDMyCf0QZTmbALU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581CaFfp2102724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:36:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:36:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:36:15 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CaBNq2514359;
	Mon, 1 Sep 2025 07:36:11 -0500
Message-ID: <d6ab538c-f3b1-4513-8226-773a13510f86@ti.com>
Date: Mon, 1 Sep 2025 18:06:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
To: Vignesh Raghavendra <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-4-a-kaur@ti.com>
 <39f2bc33-e35c-4de4-9377-cf41f510ecc2@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <39f2bc33-e35c-4de4-9377-cf41f510ecc2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh,

On 13/08/25 20:08, Vignesh Raghavendra wrote:
> 
> 
> On 31/07/25 17:26, Akashdeep Kaur wrote:
>> Add the drive strength, schmitt trigger enable macros to pinctrl file.
...
>> +#define DS_ISO_OVERRIDE_EN_SHIFT (22)
>> +#define DS_ISO_BYPASS_EN_SHIFT  (23)
> 
> These *_SHIFT macros are mostly arranged in ascending order of bit
> position, please follow the same.
Rearranged the newly added macros to mostly fit in ascending order.
> 
> Also, ST_EN_SHIFT is already defined ?
Removed
> 
>>   
>>   /* Schmitt trigger configuration */
>>   #define ST_DISABLE		(0 << ST_EN_SHIFT)
...
>> -#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
>> -#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
> 
> No we cannot delete these. There maybe downstream dts files already
> using these macros and thus can cause incompatibilities.
Added these back for backward compatibility
> 
>> +#define PIN_DS_FORCE_ENABLE		    (1 << FORCE_DS_EN_SHIFT)
...
>> +#define WKUP_EN_LEVEL_HIGH	(WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
>> +#define WKUP_EN		        WKUP_EN_EDGE
> 
> All existing macros in this block have PIN_* suffix. Please align with
> the same.

Added
> 
>>   
>>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>>   #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
> 
> 
> For future versions, please split the changes to 2 patches: one for
> white-space changes only and one for addition of new macros.
Point Noted

Regards,
Akashdeep Kaur


