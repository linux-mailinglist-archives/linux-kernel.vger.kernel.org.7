Return-Path: <linux-kernel+bounces-797901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E9B416F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672EA188A9F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D362DE6F5;
	Wed,  3 Sep 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f6PnfX05"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5733991;
	Wed,  3 Sep 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885194; cv=none; b=kDi1GwKTE5C3Zv7ciY9cExSGgEp1YTtCEO6kI7EH8rfOWLiu1OrgJ/b/Ozvy2tlGyxejEBROSe9lkOg8qNlmAjFl+MX1w65pcCdcVMu5OmI97CHpAOA052GbY3u3M9DkLkT6P8UwhHrSe7n0N+mW7naq2g21mjeHm9/KyCM5GeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885194; c=relaxed/simple;
	bh=6uwz7gDsJt7qJxikPyOGFrgLUhMH6zeFa0DlKrhFpC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jSe0gNqajCRD49w/ig1zj91607inE7LDswPvVc2v4qHK8/eK0hzTgWuRiPek4aQ7yveBouP+jsBoT7vojx/4PEsgyUAB6XTTBQZeMPqP1wbFSfBAZPA8Hfm5BMdbfPpViecui3buc9GkGNS3ofNUBmyr4zqazkA/yDtS+ZVlWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f6PnfX05; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5835jZYh007176;
	Wed, 3 Sep 2025 09:39:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oTO3GWe6vWTxVF1nz0fRYpUGQk7A1HpUGiGkoFHYPaU=; b=f6PnfX052q4atmjA
	4p3rG7NLg6nSAVvfPHh6OoDoJ9dtKFB0rFd47RkIdkqjqCCGJjNTrbpt4kg2J84U
	pBnd95KHLWdfLW5pqkSEbZmPM8Cys06fUkwx6ech9Oc9DGwOBLwv4Ariy2xGfNPc
	9jqReH9MmUyvD2HO+ValDs6G3mc1iSD94QBiqSQz/s/mdWrIBcThvxei/RxUlH76
	1r3e7ySt4POeitq9b+NXlZTINueQH+OPaIYYAhULAZq/FiHjJN7cNvZUa1p5mFV2
	lbaiHBVoulwpXub7Ej9idqGItDfO1fCXtNIxRRBhD3nHfWwZUd+GR6DTF0PWUlgO
	AKhqoA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkg5u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 09:39:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F4154002D;
	Wed,  3 Sep 2025 09:38:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C354029038A;
	Wed,  3 Sep 2025 09:38:20 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 09:38:20 +0200
Message-ID: <667a4a36-5b5a-4a45-9300-d0abd10d4b53@foss.st.com>
Date: Wed, 3 Sep 2025 09:38:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: stm32mp151c-plyaqm: Use correct
 dai-format property
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, <mcoquelin.stm32@gmail.com>,
        <robh@kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shuah@kernel.org>
References: <20250830225115.303663-1-jihed.chaibi.dev@gmail.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250830225115.303663-1-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01

Hi Jihed

On 8/31/25 00:51, Jihed Chaibi wrote:
> The stm32-i2s binding inherits from the standard audio-graph-port
> schema for its 'port' subnode, audio-graph-port requires the use
> of the 'dai-format' property. The stm32mp151c-plyaqm dts file was
> using the non-standard name 'format'.
> 
> Correct the property name to 'dai-format' to fix the dtbs_check
> validation error.
> 
> Fixes: 9365fa46be358 ("ARM: dts: stm32: Add Plymovent AQM devicetree")
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>   arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
> index 39a3211c613..55fe916740d 100644
> --- a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
> +++ b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
> @@ -239,7 +239,7 @@ &i2s1 {
>   
>   	i2s1_port: port {
>   		i2s1_endpoint: endpoint {
> -			format = "i2s";
> +			dai-format = "i2s";
>   			mclk-fs = <256>;
>   			remote-endpoint = <&codec_endpoint>;
>   		};

Applied on stm32-next.

Thanks
Alex

