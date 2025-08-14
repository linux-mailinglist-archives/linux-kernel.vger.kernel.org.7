Return-Path: <linux-kernel+bounces-768795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9ACB26590
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F77C0001
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC322FC870;
	Thu, 14 Aug 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MXCMvXlN"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688592FCBF4;
	Thu, 14 Aug 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175217; cv=none; b=NZ36xrd5H/xUWHKal3qgqjenqjB5E0x2SnH8I0dYIjv1J/CPMaHIfAQt8Ze83xgqw5Qp7k3QxvH13mJLE95LB8Almvp7UTBuniwzyy0SAOHsODoFudqK7fJho7Gn17HYS6Sbm69JXM8V+5v45MAYTwMydDuxv1atJgkC7ozsnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175217; c=relaxed/simple;
	bh=a009CU8HjHG/c1yVK5PhlY9OdVEkZllt+UZhM0Mpl1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WeoIwH6+h+ne7QCfcn3fdcSiPxXDf/Oz1l1hb48PNx04Ti/Dv5uUCNEofiMEXTujIE2T76aW5W+lIZ1c1DWD4PFdrvgnbqRTBuF5ux+pgxqeTo96JbLR4o3tABdKH2H9zdCf/J9RMUdoE1axh5Y0WUCBDFi+Jwy8QS+UrSPDplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MXCMvXlN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAioq1010546;
	Thu, 14 Aug 2025 14:39:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	WzSNHix+jDzhryW7L6rWS044+qiGmGt0CFqW85ry1ZA=; b=MXCMvXlNHKbc+con
	Gfz+5BevdW0tajuBGnIhEJT5lDj+ijrbmRk/6w1spiO43qCkWl3tZW7gwJ/x36SA
	Qbi0deGn40RBnP5ubhNCLBvz0iAjYE6XmPBN3c60DRZLovhvuEE1GNx84ZR8Hbee
	fFl9MEdnS0k5WqzrGo0JKjLlikmtpaFgtnWE6cic9Fy8xgIvDxVOmmg6t50qAFqJ
	cXPLf9+oWcXdRmy/P11Hv6e9XESlfpbCUObOs00BlYX71IoHDRugn6zS/mG5K/SM
	4cq8ZLBZGub26xJdIXbTKZaZqbHH2ltlsk2vPjFrP+DbHnXWA+i/8KiBMx/twoPk
	66sqnw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48eh9nh6xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 14:39:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 38D9A4004D;
	Thu, 14 Aug 2025 14:38:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A1B671CEDD;
	Thu, 14 Aug 2025 14:36:49 +0200 (CEST)
Received: from [10.252.20.8] (10.252.20.8) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 14:36:48 +0200
Message-ID: <2c13bf48-5453-4302-9cde-eac51e314af1@foss.st.com>
Date: Thu, 14 Aug 2025 14:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] dt-bindings: display: st: add new compatible to
 LVDS device
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com>
 <20250812-drm-misc-next-v2-3-132fd84463d7@foss.st.com>
 <20250814-dancing-nautilus-of-camouflage-ebb441@kuoka>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20250814-dancing-nautilus-of-camouflage-ebb441@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01



On 8/14/25 11:09, Krzysztof Kozlowski wrote:
> On Tue, Aug 12, 2025 at 03:49:00PM +0200, Raphael Gallais-Pou wrote:
>> Update the compatible to accept both "st,stm32mp255-lvds" and
>> st,stm32mp25-lvds" respectively.  Default will fall back to
>> "st,stm32mp25-lvds".
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
>> index 6736f93256b5cebb558cda5250369ec4b1b3033c..b777c55626e4b322d77ef411ad9e4a3afb6c9131 100644
>> --- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
>> +++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
>> @@ -31,7 +31,13 @@ description: |
>>  
>>  properties:
>>    compatible:
>> -    const: st,stm32mp25-lvds
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - st,stm32mp255-lvds
>> +          - const: st,stm32mp25-lvds
>> +      - items:
> Drop. This should be just enum or const, no need for items.

Why would items not be applicable in this case ? I want the compatible field to
be either:

compatible = "st,stm32mp255-lvds", "st,stm32mp25-lvds";

or

compatible = "st,stm32mp25-lvds";

example-schema.yaml states the same pattern.

Best regards,
Raphaël
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>


