Return-Path: <linux-kernel+bounces-806927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74AB49D89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9402B3BC8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD22F3616;
	Mon,  8 Sep 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sGdBMbwg"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2022DEA95;
	Mon,  8 Sep 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374560; cv=none; b=bLNvCpmgLLpRk0pPFOvGcHNJ/dkHx9PpDbo19CV8SsAWQsJoyyd5aSWeGQewtJyBn1LYLkQWELj3VFkSyaI6eI8vxvtqwaZjYWQ/rR2K0MJTQXoEUH/K0Kk9jw48++Gk9mR4/j3biwJ4hTZD+Dro7zxR4/tOEtzj7ly+d9o9gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374560; c=relaxed/simple;
	bh=EMM7E93s/ekUbTcRbj60Z72MQgUONxbUo/9aOqe7OOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V/h8wJXyl5MQbrbENmy1IPN0hVjDPdkvQf7iKr47J/vXR3MrjDdZ+g1VbMHlLPKU7P3CUuU2XK2TGUmyv0HO4T7/zPsYJxAv22rHZW56xb9xmPDBsKNKTWdlB7BMSPhuNqb99xdAYNpGasjjR107h24Hl9jxPoA60UPwb00lHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sGdBMbwg; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588NZrXj155383;
	Mon, 8 Sep 2025 18:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757374553;
	bh=C+es+k3ho11cQTKuzpC2vE3k0arMuciL1EOZEVF5ce0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sGdBMbwgBYMtC0S38l3sEFnz/BPdRdCPPTOrPomAeOg9FWe0jRDVlFsQHk/e+xuU0
	 wzmMe8ubSb01a8GfmPc9xUa/GDGJqOvqNl47JmTSouUwXljw5Gp+9hr1/gJUbFFuOf
	 BRRyLEaqPvpcZqk8412ajGrUoYbDOrqcPianv6ig=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588NZre64116798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:35:53 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:35:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:35:53 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588NZrjg1662346;
	Mon, 8 Sep 2025 18:35:53 -0500
Message-ID: <fbbaf67a-8e59-44fa-8741-49cf53f4a31c@ti.com>
Date: Mon, 8 Sep 2025 18:35:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in
 existing macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-5-a-kaur@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250905051448.2836237-5-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/5/25 00:14, Akashdeep Kaur wrote:
> Currently, DS_IO_OVERRIDE_EN_SHIFT macro is not defined anywhere but
> used for defining other macro.
> Replace this undefined macro with valid macro. Rename the existing macro
> to reflect the actual behavior.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 8ce37ace94c9..e46f7bf52701 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -88,8 +88,8 @@
>   
>   #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>   #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_DISABLE     (0 << ISO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE_ENABLE      (1 << ISO_OVERRIDE_EN_SHIFT)
>   #define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
>   #define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
>   #define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)

Reviewed-by: Kendall Willis <k-willis@ti.com>

