Return-Path: <linux-kernel+bounces-663938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E802BAC4F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B81BA0DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591A271471;
	Tue, 27 May 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="psqZ4Sn+"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A7271459;
	Tue, 27 May 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352018; cv=none; b=cRzK2guo8kurJAoljtUa6jtc/p1nRuCb6I9QAX2nWA2thCYmpon4EUdqm/zPmq785qkfy73h9jTTOH3PmynY+QBcYqF8tO5aGhlt0nn8fNX9tuZ30evJXvG1E3sgB1rg6IbJqzkzT9QvSrISvLC4/W5neHQXsGlNfOtqptVlk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352018; c=relaxed/simple;
	bh=hhOKA2MHq5A/Sp9NZ4YTpYbodg83i2jR0nNDX5GCkEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iy8o6sQepvxRpYWWd3OSjsR4XCfqpvs/oEOHRXmDzTUXql/yCr+f1+jsU2i++/oPhVlzqD5bVG+DClkOO99w0OYIS7iC0fnltwFRaLHdmOXsMJEeufC4HZP1HmtahBAQ/roqbYgKkn/4fGfRRVGKwnWqs2xBKJ/8Ex8DKSGJPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=psqZ4Sn+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RAsMIT011814;
	Tue, 27 May 2025 15:19:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	BFoE3HK0D28qwdUZStsXbkkPYfcQlaxFa0f8RDcbnCs=; b=psqZ4Sn+GcELhcem
	mXF6fCpefDL4VWSOiNFZnJ1fhr7KtX4F1kZb416PE4LaACw3r9T5oZQx38jo71oM
	IK1Tzl6EcIiCFK4mLYWNU7IsDkzORs8xyRhr7tYBK389R4sAp9Fq6Yl0lLcDJl1P
	Pt6rartBtbNDZI9AE3Edvw8jyvxBhoTrQSIcttAX0pOHCi/DqJ9YzitHk2SYz1yH
	MJzaN/5+mO4KEfrKhQXbVjM9tcj3szqckscmusjVmWKQnJqU7ZpQSMnV5kLRRQc3
	Dkv/KL5B7ZsJz22yE8jHEwG/PCrJzeA4wFHO+4g9jZCqoh6P3b3lKmK4ZiHeMMzT
	EUk0yQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u3hk4ghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 15:19:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EF61840055;
	Tue, 27 May 2025 15:18:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 45D52AE88C2;
	Tue, 27 May 2025 15:18:01 +0200 (CEST)
Received: from [10.48.86.139] (10.48.86.139) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:18:00 +0200
Message-ID: <ca047799-6ec2-4386-a3aa-068766ea24d1@foss.st.com>
Date: Tue, 27 May 2025 15:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: arm: stm32: add STM32MP157F-DK2 board
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Conor Dooley
	<conor.dooley@microchip.com>
References: <20250527-stm32mp157f-dk2-v1-0-8aef885a4928@foss.st.com>
 <20250527-stm32mp157f-dk2-v1-4-8aef885a4928@foss.st.com>
 <79fac1e2-c90f-49b0-9f9c-357c994b27ad@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <79fac1e2-c90f-49b0-9f9c-357c994b27ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01



On 5/27/25 15:09, Krzysztof Kozlowski wrote:
> On 27/05/2025 15:03, Amelie Delaunay wrote:
>> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
>>
>> Add the "st,stm32mp157f-dk2" compatible string to the STM32 SoC
>> bindings. The MP157F is functionally similar to the MP157C.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> How did you get Ack on something which is v1? Cover letter does not
> explain any history here.

Hi,

Instead of using my own patch, since Himanshu sent the same earlier than 
me, I rerolled Himanshu's bindings patch from there 
https://lore.kernel.org/linux-arm-kernel/20250524100319.22521-3-himanshu.bhavani@siliconsignals.io/.
I should have mention that.

Regards,
Amelie

> 
> Best regards,
> Krzysztof

