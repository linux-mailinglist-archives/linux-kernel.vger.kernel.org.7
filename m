Return-Path: <linux-kernel+bounces-773793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E212BB2AA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D2B6E4000
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114C350835;
	Mon, 18 Aug 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="updHvFjI"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7D34575E;
	Mon, 18 Aug 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525877; cv=none; b=OzOr44z0JSOdEPKDkmSWEvq3iuzVt/yM6EbTSEwu+4xpZTZeuEDk4PL1dRiutrGkEJWLQyfqP+AinSu77n0JkDDe2HkfMULQc85lpdqh5wcli/WeYmEM6D+yhnIk9yg5sFqJS0ZepSe8jCulz7wjF9zMGQHahWG7IEAGiIPzm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525877; c=relaxed/simple;
	bh=LoJpb8ayV/4M9p2M6PFV8FZtQ6WHFDuKd8GwXtvVNII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KYrJ1f6eUiQa0woxnbmv5Vi0VE3TmwkmIuFKyIVBXay8g18vRvUON4HydslQ1CJ3PvZEf5PpYYJwvkf1JB/ZyapyQVU763fOgEPzjyj/kcXb5gynnIRzMnl4QR05k+C9eDYz7HVKqO+J2lfkPPNx+HSmeMFqR+mVpL5a72SHdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=updHvFjI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDgcJo022338;
	Mon, 18 Aug 2025 16:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	SdXtjCINBYYl2y0vIxcCS+dE3WLQsljv6X6tY5i9tL4=; b=updHvFjI2C7p8gFG
	QApsM9kyPimXAFYNBtIJyCaOhgx34foyMQH8xFMKefIBW+7P4qrrBKQjv/+4MlWd
	k9YUeze9h79r4aBprU144nzdU+645oUPSQfb2QrnR9xNSJ3PCXJ3dhobR5dlqRKP
	BTKkql0SwE0FfJqE3yYpQygUApIRrIdSqndKrCM0ZQRHDU0mVKanAqrz+sK7WFsr
	gEa59GXrFUd08Y6PUpLHQXHeJzXd01flU7UtHnq1uAccc3o7yzM+jcSsP3F9Hgwl
	e0Lz6wjPWPgRXYi4ZjvaUcewO39FQnC4lcmAO01P8udM2urXTLtEvqm84m5pfWEL
	YO4whw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48jf47phne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 16:04:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6CD724004F;
	Mon, 18 Aug 2025 16:03:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99821738B2D;
	Mon, 18 Aug 2025 16:02:55 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 16:02:54 +0200
Message-ID: <fa1f6952-dba5-421d-9a79-03904059df0d@foss.st.com>
Date: Mon, 18 Aug 2025 16:02:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: sti: drop B2120 board support
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-3-f4274920858b@gmail.com>
 <517de150-9fb1-4098-92a3-d5a24eea67a1@foss.st.com>
Content-Language: en-US
In-Reply-To: <517de150-9fb1-4098-92a3-d5a24eea67a1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01



On 7/28/25 11:26, Patrice CHOTARD wrote:
> 
> 
> On 7/14/25 15:49, Raphael Gallais-Pou wrote:
>> B2120 boards are internal boards which never were commercialised.
>>
>> Remove them from bindings.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>>
>> ---
>> Changes in v2:
>> - Added Krzysztof's acked-by
>> - Put this patch last to get a bisectable series
>> ---
>>  Documentation/devicetree/bindings/arm/sti.yaml | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
>> index 842def3e3f2bce470763d3665c7603b9058b1e4e..177358895fe1c9f80f8c825142cf015d04286ce8 100644
>> --- a/Documentation/devicetree/bindings/arm/sti.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sti.yaml
>> @@ -14,12 +14,8 @@ properties:
>>      const: '/'
>>    compatible:
>>      oneOf:
>> -      - items:
>> -          - const: st,stih407-b2120
>> -          - const: st,stih407
>>        - items:
>>            - enum:
>> -              - st,stih410-b2120
>>                - st,stih410-b2260
>>            - const: st,stih410
>>        - items:
>>
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

