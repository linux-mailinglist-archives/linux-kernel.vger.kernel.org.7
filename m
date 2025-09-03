Return-Path: <linux-kernel+bounces-798575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C4B41FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B147B17BFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2375301017;
	Wed,  3 Sep 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GDUw3m80"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCC3002BF;
	Wed,  3 Sep 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903725; cv=none; b=WEHEyMS5VmlDxD+UdNpl1OuOTrIMkmn0OQP3ljHhipEnHq8i/33MgJCt1pm5+gG+T/XiqNT7ORYaJ8OznMJS7Xrr6jsTT1BjI0N3k6lb31gtxT1spi3dSk4oSF2ki3BkiYitLwEtToDvTXqoN/+Kprcoaq57Eydu/eBqWIgnXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903725; c=relaxed/simple;
	bh=neQ/YLtT3KymbxD614CLFkfz0ZDYTTCDAzEsAWDbROE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bFLLFXverag7GPkJN8E+RjeehDCIsZUbUtxVZwG1f1yyphjk79uwyB/srWTQQryY29nLphe3k40eOQSkTlbSfjluVn8R+TA3I4B9c03X9nKsiHFQgUdj7QSv8MYbnfkxzLiwyIG6Gbf9F1s1f/MdFHXsM/7r93Gy2mpY1H0RfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GDUw3m80; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583CHub7021895;
	Wed, 3 Sep 2025 14:48:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pR/cYTMw3jgl+YXiMt8OJ3yKr+qlutsK3voWnGrYc7M=; b=GDUw3m80Tdt3GIPv
	3e7yfOHZMxy6xuwAfJxoGFaJVQx4jWE6yi+nojXsxJFTZe1pqz4CUNF6PpN/avDN
	m3AYpAlSjNuGJt1x5m5dZwZT5OcgWOOVfaGEUsOxaNtgo19etY6M+YxVEUr2tKKT
	KP96+dMgyO+6Ar+U405fJGFYAje9q3Xu8paz/EFQa8LVzWrY64BgfZ02GABhV/iO
	lpJStkAC9IFR1+zXSaN7Fx35r+bAW53rj/MfnFo7nBllDMTaJ89HG9Sf/5lUNisA
	cXcFDDhsVl49uMSPj+UDYCb1o1SMr1Rll/LHM4AjOJfyCDJf6/MaHvDRzVzCiTPi
	4XipYw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2psd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 14:48:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5FB3B4004A;
	Wed,  3 Sep 2025 14:47:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0437A2B4D47;
	Wed,  3 Sep 2025 14:46:25 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 14:46:24 +0200
Message-ID: <dca0faa3-2d87-4a93-bc67-7028a7846647@foss.st.com>
Date: Wed, 3 Sep 2025 14:46:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-ev1
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com>
 <20250903-mp2_ethernet-v1-3-4105b0ad2344@foss.st.com>
 <faa673a3-d68c-4b7f-a2b6-1f5bf40aabfb@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <faa673a3-d68c-4b7f-a2b6-1f5bf40aabfb@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01



On 9/3/25 14:24, Andrew Lunn wrote:
>> +		phy1_eth1: ethernet-phy@4 {
>> +			compatible = "ethernet-phy-id001c.c916";
>> +			reset-gpios =  <&gpioj 9 GPIO_ACTIVE_LOW>;
>> +			reset-assert-us = <10000>;
>> +			reset-deassert-us = <80000>;
>> +			reg = <4>;
> 
> The DT coding style would suggest reg comes after compatible.
> 
> 	Andrew

Hi Andrew,

Right, I will fix that for V2!

Best regards,
Gatien

