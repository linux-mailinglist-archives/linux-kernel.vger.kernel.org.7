Return-Path: <linux-kernel+bounces-805045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786DB48369
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1AD3AAD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D131221264;
	Mon,  8 Sep 2025 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="naUTLXkZ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE621FF35;
	Mon,  8 Sep 2025 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307113; cv=none; b=o5XPsVlXvw6PbJazvvYE4ezgB8pGOdgcuVjsO38vSjrLroEheLoO8WKzaI1P5lVk8TyxSuDVLFl25eY+NCKFfrazrMq7ntnVie6gbjpbRqGjZidScHlRwWqAacBxPdC3/Gsv2TgqcTZGpL3FGRe45Ra5MAKUb6vf29VUbv4ELjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307113; c=relaxed/simple;
	bh=EOOstQ/bAdx4SF5Hkxh44HMUg/WO72LadiYAkK0ZlYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G5cPubyCEHHXvmVawtUI89t6P6ZlSROSQApSgb1wEwwE85Fm+tMO9xTp/1YShfUVnPBRCcrk2ENNt8GTNxDNjupUKQ1iPmpctoG+w4/iutvauam6rQaZWbiQAIS6xZcRBukwGSFNkr7reNCDErEHL9mlIzSQqTKzOxPc4cXXtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=naUTLXkZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5884pT5N3710709;
	Sun, 7 Sep 2025 23:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757307089;
	bh=5a/tGsO7tFJN56qqkawWAWzxQN/3WsgosHJOsz5q2PM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=naUTLXkZe/CZdVUridvOapJu4TpntdbrzUzH/XFYKLMHE6jyJwpnPkgICNskXnjwJ
	 7woVuoLBtauHi82duCpihCFMiesygGVypuxdP+jOoEVeu/2q/frE07QczCSc/F4yI7
	 r9e3MDcCXRqkpBhgEVQXue7hoWGpOwIvlMrYG8Rk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5884pT302702270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 23:51:29 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 23:51:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 23:51:28 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5884pNxr283181;
	Sun, 7 Sep 2025 23:51:24 -0500
Message-ID: <a562a287-20ed-4bc7-a6f1-fca60eae0713@ti.com>
Date: Mon, 8 Sep 2025 10:21:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: Update DSS EDP
 integration configuration register
To: Beleswar Prasad Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <m-chawdhry@ti.com>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <aradhya.bhatia@linux.dev>,
        <devarsht@ti.com>, <s-jain1@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
 <20250907182806.1031544-2-h-shenoy@ti.com>
 <9769c59d-dd5e-495e-8056-0f513a78e1b3@ti.com>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <9769c59d-dd5e-495e-8056-0f513a78e1b3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/8/25 10:04, Beleswar Prasad Padhi wrote:
> On 07/09/25 23:58, Harikrishna Shenoy wrote:
>> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
>> TRM Table 2-1 MAIN Domain Memory Map.
>> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
>
> Gives a 404 on the above link?

https://www.ti.com/lit/zip/spruil1 this downalods the zip, refer SPRUIL_DRA829_TDA4VM file.

>
> Thanks,
> Beleswar
>
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

