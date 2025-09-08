Return-Path: <linux-kernel+bounces-805106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4EB48412
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73383BCA99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA1F21B196;
	Mon,  8 Sep 2025 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UQoqtQN0"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A331747F;
	Mon,  8 Sep 2025 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312482; cv=none; b=giOImie3azK1Zy0mc/v+ZupMcmKVnYTC3vW/K31q5qpTh2B0r3JVBuIHoEdUva/su9EfTCcUsNeXKDwPU6EappBz5EGB8trHvjaJxuF/yLInfEnJZiwb2x/CtGycdRbjqs+i/UGh6SMu+QUp0zEkxzitBqySF5f/+UxTL9s9OPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312482; c=relaxed/simple;
	bh=iIR0TbCpKDiRy0A3Yar0z2vPm0cIw4zRN+TDcE/C5/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tC4xHFPEhD7UV4TiJ6x4SjnNwKnw2YZFq+uMvlFbhaBpBnWzkmK02c/ZeVoko2cFAtsKv71Cx+EpT7AmEXf8Gnd35WE5Ju+zyg1864XuaOTkeLBSAIsBQt41mccoSu1j3UtAYUiSyuMgaMCurSKsXY0WNVvWGGUr6IuRuvQgnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UQoqtQN0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5886L0w93728659;
	Mon, 8 Sep 2025 01:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757312460;
	bh=l23+Neng0o7kEBKx7yVdPxQPupNJB6iM1BraKVuSp+4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UQoqtQN0WEc4D9yIF7VfgmLq2VeYdqTqVjN7g+X8UEYcPOqFR8KnnAq3Iw1ceXeCS
	 73j3rrmhNlA9t6JgTJm+ufHfj9j1Y3uDPb3iv0YBUltILRFa+9JcgPksy6z2GsCXZP
	 zK4yxZq2CrH9ZvcqTldp2RFeGNI3YVq7nZTcvZK4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5886L02Z2756534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 01:21:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 01:21:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 01:20:59 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5886Ks4N120654;
	Mon, 8 Sep 2025 01:20:55 -0500
Message-ID: <ab3b7c55-842e-47fe-b7c2-d076da08c3c0@ti.com>
Date: Mon, 8 Sep 2025 11:50:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: Update DSS EDP
 integration configuration register
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <m-chawdhry@ti.com>, <b-padhi@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-2-h-shenoy@ti.com>
 <ffcc5d3f-bf3f-47a5-a034-a20c59f93ff1@ideasonboard.com>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <ffcc5d3f-bf3f-47a5-a034-a20c59f93ff1@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/8/25 11:46, Tomi Valkeinen wrote:
> Hi,
>
> On 07/09/2025 21:28, Harikrishna Shenoy wrote:
>> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
>> TRM Table 2-1 MAIN Domain Memory Map.
>> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
> What issues does this cause?
>
>   Tomi

Hi Tomi,

No issues seen in driver functionality yet, but it might when we enable 
HDCP,MST which driver supports but not enabled yet.

so thought it is better to align as per TRM, hence aligning the size as 
per TRM.

>> Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
>> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index ab3666ff4297..3fa7537d5414 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -1863,7 +1863,7 @@ mhdp: dp-bridge@a000000 {
>>   		 * the PHY driver.
>>   		 */
>>   		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
>> -		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
>> +		      <0x00 0x04f40000 0x00 0x100>;    /* DSS_EDP0_INTG_CFG_VP */
>>   		reg-names = "mhdptx", "j721e-intg";
>>   
>>   		clocks = <&k3_clks 151 36>;

