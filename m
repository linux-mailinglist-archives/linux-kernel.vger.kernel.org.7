Return-Path: <linux-kernel+bounces-773791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94103B2A9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A57B5A6A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CB322C66;
	Mon, 18 Aug 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qAQivGCf"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94439322C61;
	Mon, 18 Aug 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525864; cv=none; b=NT1IDo0PHxzAt6ykcEMvceOjYqZzJ+AfMYZFID1fJcko8+fDZbKLORzB9M76DWZSuAbMBn7hUAjeSDnYlsE4gkcuYPufN7GrcH+DSltNIWbhwL2wE2nJMaYIWP4TQPTuexX96cCpTOsRbZk5+YngSGPp05veqkUMiPfwHKlVmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525864; c=relaxed/simple;
	bh=9kWtwgbV9wvF6Cog7nBVD/R9LmiCzFI7JgT7tjGWHgI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=axVNR0quarvB2h3zaFQY/CX6kEHlQNrEKVo2Q0U/JrtVyCoxJF7YV5ubC4nGw8f6YPDKD11X73iLwlIbJkgUQNHZSv49dXTAV0uHL1AxiHREyL8u6Y4Ctnempsvlo0s8oDmbRpbl4NYOIxBbPp/xR2+SHfoFHbyuMuP3+naypOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qAQivGCf; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDFlne021385;
	Mon, 18 Aug 2025 16:04:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AAck9Emf81sVRE5nj2gy4fdVLzPWbRvHowUZM2d4qh8=; b=qAQivGCfs+YIegmc
	vwKsUSpLAfc8MDhwwG8yN39iyE5sNALBW52MNHaNPhR+Ph9h73iLE1xc6oR7QG86
	ajcM+xltusUsf47Knmr64s59rv1at2WmnAjD40hsajRm2uETmVyzYkorx5qVlflH
	fTR543oVIh8AGN7rzn43qmINyLrCmaAJVB5o4KVTULYBuRxs8Ocw7q7jjOxVNWYo
	c58lNaS4X0rwiHPT3ASKLQ4MgredTdL81QRAFH6CicxkTe151uRU51ofdaN2BhkV
	erP2hbSJVO4vUa5rBtrOZ8QvP3pXUOn1PGcKdjtyBXJwBYIMcJPnAOqyPZmbIa7a
	dWR2pQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48k4xmmeg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:04:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7000B40049;
	Mon, 18 Aug 2025 16:03:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EBFE0726262;
	Mon, 18 Aug 2025 16:03:11 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 16:03:11 +0200
Message-ID: <ce3edd3b-4d42-4a2c-b163-a9aac59466ae@foss.st.com>
Date: Mon, 18 Aug 2025 16:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: sti: rename SATA phy-names
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250713142424.41236-1-rgallaispou@gmail.com>
 <09384c23-cffe-471c-95b4-82b3d34de4e7@foss.st.com>
Content-Language: en-US
In-Reply-To: <09384c23-cffe-471c-95b4-82b3d34de4e7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01



On 7/28/25 11:18, Patrice CHOTARD wrote:
> 
> 
> On 7/13/25 16:24, Raphael Gallais-Pou wrote:
>> Stick to the documentation and rename both SATA phy-names properties to
>> what is expected.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>  arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
>> index 35a55aef7f4b..3e6a0542e3ae 100644
>> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
>> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
>> @@ -669,7 +669,7 @@ sata0: sata@9b20000 {
>>  			interrupt-names = "hostc";
>>  
>>  			phys = <&phy_port0 PHY_TYPE_SATA>;
>> -			phy-names = "ahci_phy";
>> +			phy-names = "sata-phy";
>>  
>>  			resets = <&powerdown STIH407_SATA0_POWERDOWN>,
>>  				 <&softreset STIH407_SATA0_SOFTRESET>,
>> @@ -692,7 +692,7 @@ sata1: sata@9b28000 {
>>  			interrupt-names = "hostc";
>>  
>>  			phys = <&phy_port1 PHY_TYPE_SATA>;
>> -			phy-names = "ahci_phy";
>> +			phy-names = "sata-phy";
>>  
>>  			resets = <&powerdown STIH407_SATA1_POWERDOWN>,
>>  				 <&softreset STIH407_SATA1_SOFTRESET>,
> 
> 
> Hi Raphael
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
Applied to sti-next

Thanks
Patrice

