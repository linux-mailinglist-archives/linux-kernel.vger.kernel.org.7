Return-Path: <linux-kernel+bounces-805153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14853B484A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9471316DC47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC612E3AF1;
	Mon,  8 Sep 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b+mIez9J"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527542E36EC;
	Mon,  8 Sep 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314661; cv=none; b=EZwXmFjwZry/zkMoBnZdSINrylQpusiIiqPC+csYS3z+AfvYojJS0j2++RHlHFFwQHvMqHxiLDIEJ15d6Hh5jzQrGgngxgU7uXtPi+NzH3Ag1gAlHLpKy0tRNSD7/iuNdGQASwhZ+9kCdi8nHGao/4Xa000nzwmA8sh7LvT7U4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314661; c=relaxed/simple;
	bh=oaYy0VFW7CP72ZtN5PeWtSMczIjr8xaPim3vMqMRrSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dF3M4P1kF5SDo74ukPFbV9LIGyxwLvI/S0/V2Q0JRxn0fS9QqrTMz5IsNNPwNAAtOu/g2ULw0EVltVvBlhsofpHVqzf06xNCnrU6hAO8MlKt+pg79aEKiX5EytUuO3MP+JpEVQVOeY4KG1ES1QrsFgbTdbXVweG7Nd1YYxgyTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b+mIez9J; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5886vW7D045455;
	Mon, 8 Sep 2025 01:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757314652;
	bh=14TSHFLKvEMEzuJ+6xG5V1fqFjVsb8UT1QEiAfFWu+A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=b+mIez9JOG1FWUgo8ybpolDVqENmbHZOniVnCo9h2pTrRWDcypaYxmW+alqdhtr/J
	 sQxuK4NAxpETi8ZC64Q3QmXrW3NWx7WOBM0Iy90FJCwl0ILBQhYo+viYCoDYIqLcu2
	 uqPQrIZ2QD++TQh8tAyACG8Q292hEI20GyCaYDBw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5886vWd23581255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 01:57:32 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 01:57:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 01:57:31 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5886vRbk166893;
	Mon, 8 Sep 2025 01:57:28 -0500
Message-ID: <63c958a2-3973-4171-8a74-80381218723b@ti.com>
Date: Mon, 8 Sep 2025 12:26:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in
 existing macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250904112538.529857-1-a-kaur@ti.com>
 <20250904112538.529857-5-a-kaur@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250904112538.529857-5-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 04/09/25 16:55, Akashdeep Kaur wrote:
> Currently, DS_IO_OVERRIDE_EN_SHIFT macro is not defined anywhere but
> used for defining other macro.
> Replace this undefined macro with valid macro. Rename the existing macro
> to reflect the actual behavior.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---

Fixes: 325aa0f6b36e ("arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros") 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 7c5b5783769c..36bb403d718e 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -88,8 +88,8 @@
>  
>  #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>  #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_DISABLE     (0 << ISO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_ENABLE      (1 << ISO_OVERRIDE_EN_SHIFT)
>  #define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
>  #define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
>  #define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)

-- 
Regards
Vignesh
https://ti.com/opensource


