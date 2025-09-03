Return-Path: <linux-kernel+bounces-798717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E58B421E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5A1895808
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40913090D7;
	Wed,  3 Sep 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OswDVRc0"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274E26463A;
	Wed,  3 Sep 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906604; cv=none; b=cmwmDpFk5OT3AoUfd1ZBUUd3IJBP819c/O8hstD9kHZaUZ00NCsq6cH2S42XCbcLgidp4Zj9AaZKlCWKN2cWEaY41VT0eMrN9HCadkRsEsD1/FFUYm5+EXzsxkeC53mknB83cfldI7B4KA4NgnOousYqgIS12FQoajw5/UALBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906604; c=relaxed/simple;
	bh=Y3gIGrF42jI+3IzuwOT5sPZFYcfgGiHCTqp57EkTB9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cRMzTpXGO3OTR7eDca0r0JrD++amsfwWtZ+ZeToyeQDqkGU/6zTp5kScY6gQwawTW9JwSK9rkOeSX17J1ClMMFmraa3BhnUkMsv8aQ/ENySH5Qa+DXidNcrBxNy77k80brFY4RAVZuzsXz7E1OBr9TsJq8YiLsDN5CotLltx7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OswDVRc0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DWqw3022718;
	Wed, 3 Sep 2025 15:36:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bzHn34jeAFC+trUamzDM6dfK6EpwqtxxyQu4NkAXCys=; b=OswDVRc0fkrDCn+U
	jX9Y6JwB7sKv9I9GTRnblCrimf8bCCzaFC3f1b+uFYAEXx6/574guT5BrAlfqg1T
	PrWMo7cxoxMAkTaiYjUpKBkHTr3sfMklY/xnyHXWZyfGvPD5YTYsSuSyEZCRLqRw
	I5zHZ507T90b1NGGwQSvuo5slo6I7Q/q9a7UgHQS24fchqokjpK66XnlEmg7UyyL
	eG8m6eKen77x59fEljxL5h50lzGd+MZ2LXqtLAhaz5FekOi8b8KxAZZyyWPja/tD
	reaKyH3dlFCXRvxHAQYTHdLWJ0nq3v9hOXTHThTsGo1C/QUXCp66FCoIvJ9p/fuB
	NFd1tw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2q0p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 15:36:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA26D40049;
	Wed,  3 Sep 2025 15:35:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6162A2B4B41;
	Wed,  3 Sep 2025 15:34:53 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 15:34:52 +0200
Message-ID: <9cfa9cb4-bf7e-4d48-b0cc-0726784b7462@foss.st.com>
Date: Wed, 3 Sep 2025 15:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-dk
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
 <20250903-mp2_ethernet-v1-2-4105b0ad2344@foss.st.com>
 <5c49e94a-9267-459a-ba6c-70f3763f1a7b@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <5c49e94a-9267-459a-ba6c-70f3763f1a7b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01



On 9/3/25 14:21, Andrew Lunn wrote:
>> +&ethernet1 {
>> +	pinctrl-0 = <&eth1_rgmii_pins_b>;
>> +	pinctrl-1 = <&eth1_rgmii_sleep_pins_b>;
>> +	pinctrl-names = "default", "sleep";
>> +	max-speed = <1000>;
> 
> RGMII naturally has a max-speed of 1G, so this line is pointless.
> 
> You only use max-speed when you need to restrict the system below what
> it would normally use, for example if the PCB is badly designed and
> the tracks don't support 1G, but can do 100Mbps
> 
> 	Andrew

Right, I'll simply remove these lines.

Gatien

