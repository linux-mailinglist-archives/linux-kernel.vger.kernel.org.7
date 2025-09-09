Return-Path: <linux-kernel+bounces-807010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2A8B49EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CCB1B27338
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC323BCEF;
	Tue,  9 Sep 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uTJo+bCm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0670830;
	Tue,  9 Sep 2025 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382878; cv=none; b=n/omPepEv4CO+2ILrqsZxPAEwx3apI7jfzosRWLQPKzf5WWs6UKdoJ2DbQMm9trg/bSWYuqdFlzYHglgUqJv1cLhSnsbps/ec67UnP974uBMpmCkRjCkw3SkRGWgs6wkfusX5nof4zIO5ZxUW6L/qRzydlM5YdEC821rLId25gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382878; c=relaxed/simple;
	bh=+vub0WIXLsjM18X7bTqR5o1G4Zrsp5x1EhICCmdnjU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UQ3TI4j3S6BZilvVLpH9i6ktSG44PMUc/WzSocayFiTMOJgnBZNoQ4OrAX19BfBVzEEF/5PfyyHFA3abUDtFClijcEWZMHFsKJFb9qid4N62bzUtHsekI5m8qgFUQfA9iHYFiiWAqntcys13KOrqW9UE+P5PsAfujjEPmmdLrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uTJo+bCm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5891sCsJ179853;
	Mon, 8 Sep 2025 20:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757382852;
	bh=IZYV7FBqCSQGBRIWdWq+9FzQYdNtCwm09qcoVj4sE4w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uTJo+bCmoQlczta3U1lJEeTCcIiIB2ydxkKLdA/UXdomDK+Y2CpSCz5SH0p5ccBIX
	 WKtMGh1+l5EW0SgXRvnRS58+tyZ7uwnFcEHCZMnmMv+Qq5OcWBaCsfQRFWqffAh7J8
	 vitKwZbNM6aK5yiBCh+Z4uwbTn/dJ/4jZiVWzvqc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5891sCxb3372482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 20:54:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 20:54:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 20:54:11 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5891s5qp1527183;
	Mon, 8 Sep 2025 20:54:06 -0500
Message-ID: <25c1bfe7-0970-4738-b0f5-6778e3111d8f@ti.com>
Date: Tue, 9 Sep 2025 07:24:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: Update DSS EDP
 integration configuration register
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Harikrishna Shenoy
	<h-shenoy@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <m-chawdhry@ti.com>, <b-padhi@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>, <u-kumar1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-2-h-shenoy@ti.com>
 <ffcc5d3f-bf3f-47a5-a034-a20c59f93ff1@ideasonboard.com>
 <ab3b7c55-842e-47fe-b7c2-d076da08c3c0@ti.com>
 <cd58cfed-8ec8-4844-aed3-627c3c400a01@ideasonboard.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <cd58cfed-8ec8-4844-aed3-627c3c400a01@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/8/2025 11:58 AM, Tomi Valkeinen wrote:
> On 08/09/2025 09:20, Harikrishna Shenoy wrote:
>> On 9/8/25 11:46, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 07/09/2025 21:28, Harikrishna Shenoy wrote:
>>>> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
>>>> TRM Table 2-1 MAIN Domain Memory Map.
>>>> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
>>> What issues does this cause?
>>>
>>>    Tomi
>> Hi Tomi,
>>
>> No issues seen in driver functionality yet, but it might when we enable
>> HDCP,MST which driver supports but not enabled yet.
>>
>> so thought it is better to align as per TRM, hence aligning the size as
>> per TRM.
> You need to explain this in the patch message. What is the current
> behavior/issue, how does this fix it, what are the effects, etc...
>
> Also, here I think it's good to consider what this means for the future
> HDCP, MST work you refer to. Is HDCP/MST just adding driver code, no new
> DT properties or such needed? If so, what happens when a user runs the
> new code with the old dtb, which contains a too small register range?


we can keep to 256 bytes for completeness, but i don't think registers 
are defined beyond 0x20.


>
>   Tomi
>
>>>> Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
>>>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/
>>>> boot/dts/ti/k3-j721e-main.dtsi
>>>> index ab3666ff4297..3fa7537d5414 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>> @@ -1863,7 +1863,7 @@ mhdp: dp-bridge@a000000 {
>>>>             * the PHY driver.
>>>>             */
>>>>            reg = <0x00 0x0a000000 0x00 0x030a00>, /*
>>>> DSS_EDP0_V2A_CORE_VP_REGS_APB */
>>>> -              <0x00 0x04f40000 0x00 0x20>;    /*
>>>> DSS_EDP0_INTG_CFG_VP */
>>>> +              <0x00 0x04f40000 0x00 0x100>;    /*
>>>> DSS_EDP0_INTG_CFG_VP */
>>>>            reg-names = "mhdptx", "j721e-intg";
>>>>              clocks = <&k3_clks 151 36>;

