Return-Path: <linux-kernel+bounces-798033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBFB418A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBDF3A7742
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619772E1C65;
	Wed,  3 Sep 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7quNYpbM"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4EEEC0;
	Wed,  3 Sep 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888418; cv=none; b=a3BxTRdVPMV9NgNMMAIJif3aplXszMA+SGu4/sSyMpjC33fSY3xdsfxpy1AVjmwSINhpl10ggqsbY9iJ6N0hxYmRnaOyThbwBTLeOA3IvJka9yfGoQLgM2PxKMgmgcVTdBpBdqagdcrd3nMSN5LWGFA/T83UcqX9lEe0Bs6qVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888418; c=relaxed/simple;
	bh=HiSHrXCUNRkCDM01LOUb5+rXYgXWJ/fY98NUynPwZ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tVPlH5ccvfjbEaFXv9Wou9+MG6yK7/QePo24vBNRmDX9jv4xcYfJlCXttainnQg7kHrmWsyN3nRXle6Enkovq9z1CWF+zky0pLZqObnQZs1/VJYJTNW+VEV9yW6JSCcL3zGZQRIA1cUbSekF4IzJ6AdEaFBveldS6Zo1Q9tii7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7quNYpbM; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5838RtY8015449;
	Wed, 3 Sep 2025 10:33:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	CbG/DgXgau78CIkI3+MQbjX+sYb7ZYtoUXtP9IbZlwA=; b=7quNYpbMIWXq5ZTh
	UGu5GfZUH8lRpdGGUowWnlLGHmly1s9B/zQ2/ZzuvzxWf7TiwTCJbgBGSqNeA6ss
	cF34z/PZVT/SPNX/kdyhGpPjmagnj+dD3mRaeOJskZS7sBu/6H9qo1Wz3CtNOlCq
	dHarfBeyrSzZZrKizqtq7au1TC4H4F+iq7lz/2cWSsDJPeBlnJdyTWCFL8j6wFKb
	sd8CiDkQzXlUCFpd3KMyufYtPVsTZssENKuAHDxIg20MvneLF5eB1Dr1mkT2g0/h
	lbfASz1oqbrsyMqQIKPOxSIMTU/FXEFlG2PfwOzOVG07Ztcy3Bm1vNxu+VLRREbR
	nuyIrw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkgg2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 10:33:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3F7FB4002D;
	Wed,  3 Sep 2025 10:32:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC4342BBC2D;
	Wed,  3 Sep 2025 10:31:19 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 10:31:19 +0200
Message-ID: <0dbcc59d-2797-4106-b247-9bd575c5de2c@foss.st.com>
Date: Wed, 3 Sep 2025 10:31:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: stm32: Drop redundant status=okay
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
        Marek Vasut
	<marex@denx.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@dh-electronics.com>
References: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01

Hi

On 8/18/25 16:37, Krzysztof Kozlowski wrote:
> Device nodes are enabled by default, so remove confusing or duplicated
> enabling of few nodes.  No practical impact, verified with dtx_diff.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/st/stm32mp157c-dk2.dts          | 2 --
>   arch/arm/boot/dts/st/stm32mp157f-dk2.dts          | 2 --
>   arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi | 1 -
>   arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi  | 3 ---
>   arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi   | 2 --
>   5 files changed, 10 deletions(-)
> 

Applied on stm32-next.

thanks
Alex

