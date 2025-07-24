Return-Path: <linux-kernel+bounces-744096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD5B107F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480D01CE39DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3232267B00;
	Thu, 24 Jul 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDj68H2m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52552286A1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353716; cv=none; b=HSs7Y4hvIuqkG6TJJrhfbtGraYdzj6bj9ibtG7RIGHwtFfHv/7C3nifBxJVz4BKggHunpg7czWjbx7BlPAFTP/wvR3C4a1OxKscXyx7ifeYPq1Dzq8MOmM0V/mYCUtOzwk0mdyuaJ8E49qwik85oQ/0QZUzRfx+l8UbetESjK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353716; c=relaxed/simple;
	bh=45mxVuaLRc67oFbJfFBmp3p91vP0zbO/KNdSVJZ7lHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh4LlgQW62xkXV7mOQX08sY9QO3mLLIAdPGzaJX8mVUs9bbjlQII1Ghqj8Hv+ydBCInaP8S1JbiDLms20nNnC5BFzdivqQaq+nUkxgp3pA2sn0o5t/hB++8sCpGnS6wRiWFJJRo/FjH4ts0EmoSAvn2IGNF+RK6O5sw8DovdRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDj68H2m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9Ve4l015228
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h8c+hQ4SGUWWF7MgOg6CDaNDYEfThSf+pDJc/IkTmMk=; b=LDj68H2mJ4QU76gx
	FeTWzxShk0rMghYpScaiJEVC/Hkazps/jGjeXKM4grfNDy5/1H/rtlpJOFpOvR5Y
	nrion1dPZidgS4tbrARhgsPTJwVLLHbQiR+N2B97b1Gs6RafWrgNuLZVNWPTk3jx
	ZPlQdxwo5KhnIwdNm4BqgzeVxuIfht6m1qvMIDXofak6ONSjYalhKqCOLXZgPqM1
	Z+UeFH+LB6N8+qmkoDy+IrBtL7AEiYDCvnBIk/ZdkZ1Yfyluns/TV2fNVu0AZgZH
	qNbfVwK9UpDm1dUfqVqpZ+4WvMu/AlA6XdpshwXXwPm7NWlsOam4rjNwTzxaM9Yc
	oZU9jw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379tj0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:41:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7070970cb2aso15272576d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353712; x=1753958512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8c+hQ4SGUWWF7MgOg6CDaNDYEfThSf+pDJc/IkTmMk=;
        b=D0UCTsCf1b/nK09nIwUNpGQpvRZiawrlFvuYi08/Gh+2QJqqj5o9jEY4vb6utx/Pph
         Jfv12iakAyLpQySLsUCjCu/3ZE9xN35vf4cfx7kcYq2MS3i31e884qpNRDIpDhj4CsvA
         nTFcDWUTUYXdA1XXFAzELUOof8uX1BgaVXUdjDOIztIJGKt57CIwJizOyq4J50jKOFo/
         Dw5YBc5Zb8SSr+24mE5ZMg7Woqm/PFk/64LJCF0xz6WuIwEZL/6Pskeo+xqQGZU5Qm5Z
         JjmS9pSpSPxGvsxCI3Hj8mCED6aLp8NZ1EceT6bpH1PuPxvLz1/kE8Bxlea4umrQF7j/
         Wp+w==
X-Forwarded-Encrypted: i=1; AJvYcCUYN7DAkQDUirf7WkE9iwDb/d+NG154e9xBC640rPMnDj+0tDlFRINR7uGD92SH/nCUTvCUqt6wkLgZwZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0M3fFiwGgFBpx925OJNvhq/YYkzZGknNy3WvPreawmuYJc7Cg
	t4Ax67knh61Ow7t0w3iSVvvUmM74e20hlE/TOa4CaDfReQc0edR5plKxlHdO14KqVLWmfvTVhYT
	lj9DYzleqm4louUQVZJeqH50TijW7OZBC0bOeQQN0GRMgmshxD/C6ynjB4bOH3eKnqlg=
X-Gm-Gg: ASbGncs7pjFb9Cxf0Q3HVTDFY9up72EX2sVOwUIIc3fH0/wYvKnMwb/R1bAj4ziQz+x
	o4dXkbayy35Xvwoe3um5cbyly+uPawDtGRAvZXbi6C1M+cTbq1oDMHsuP/Wwiqa6b6CA6UK/lz0
	ixWfDflQVkDh1c6tXfj2Bz9Kl+pqEUCcWH3idSMawdNqqzfc2DEVzlQQsqszzCfVqnCgwkR2xss
	7QzbycsBi8aJyZm6m6JOMuIo2y7FGYL+j/6guzHFuuskFUnlrnUpYpT8s3d4C/5tMnb3KJ/Jily
	OUA6/CSqzPZgzS/VN5rq4/aNj3FHkdAh+eTespX0METpxLpWW4Rysg474P6hqpeGxYY=
X-Received: by 2002:ad4:5cef:0:b0:704:8aeb:f918 with SMTP id 6a1803df08f44-7070058cecfmr82340606d6.6.1753353711785;
        Thu, 24 Jul 2025 03:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuJmYhWmwFTrg+fHs/E5rNOHK9w/JHH2Isep7h44OroNrmgC7EQsO7iUpSdkEZcKrPa8GQCA==
X-Received: by 2002:ad4:5cef:0:b0:704:8aeb:f918 with SMTP id 6a1803df08f44-7070058cecfmr82340216d6.6.1753353711191;
        Thu, 24 Jul 2025 03:41:51 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b76fcc2b8asm1790768f8f.74.2025.07.24.03.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:41:50 -0700 (PDT)
Message-ID: <f6c837cd-97de-4908-9d8b-c12d6cc4cfe0@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 11:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] arm64: dts: qcom: sc7180: use dedicated elite-audio
 dtsi
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-14-srinivas.kandagatla@oss.qualcomm.com>
 <aIHi5uPxAtYARc7O@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <aIHi5uPxAtYARc7O@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f1dthKSxlFYemb8bem9mBEPOMwwolMCm
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=68820df1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xLGpAxj0MuNPjuNy5_YA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3OCBTYWx0ZWRfX7hPnPb1LkdZp
 HykYSGiVtzOtlsqsiLck58plBFTTeEZZOcVbjHPxQ8Xv2WtwLHf+FT1b1+1kNyjGSIjuDf67kqi
 iMFVO/4oao/4sI7gRJghHhGWlNbpG2+HihZl2S/aIT8gdWPdA1NPLN1ov/QD16nxCgjEFVrcz73
 U7k6Wyizhbav7hvUW/bKM7G6qbGr03INEIwRGyC76+M0qt+Y89deu+LBGAuQyyQ/iM5M9wo9Y5S
 2iPXl0X8ZLUrecSWIGbkRGGmY/vx+72pfciHJji4owwDyKrDajronWWCI2YsqoP3SaWYOv6JPWz
 g7/YzfbiUIQopHAcqHgQCUUPOgm+FNVJM6D39V5B+WbqIDTyHQntNBzIhpYRf8SO5sBXTZfucq7
 EErLEZWQzDikJ9x1p5D+S1fJ/Nt41gNeG/utx9zGbvV22HXQN7JbjVwAjG6ZYcb3fsE/GyzD
X-Proofpoint-ORIG-GUID: f1dthKSxlFYemb8bem9mBEPOMwwolMCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=666 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240078

On 7/24/25 8:38 AM, Stephan Gerhold wrote:
> On Wed, Jul 23, 2025 at 11:27:27PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
>> This move removes duplication.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  .../boot/dts/qcom/sc7180-acer-aspire1.dts     |  1 +
>>  arch/arm64/boot/dts/qcom/sc7180-audio.dtsi    |  8 +++
>>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  1 +
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  1 +
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 56 +------------------
>>  arch/arm64/boot/dts/qcom/sm7125.dtsi          |  1 +
>>  6 files changed, 13 insertions(+), 55 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
>>
>> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
>> new file mode 100644
>> index 000000000000..d6d41ba93195
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +#include "elite-audio.dtsi"
>> +&q6asmdai{
>> +	iommus = <&apps_smmu 0x1001 0x0>;
>> +};
>> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index 74ab321d3333..0e267b9fdefc 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/sound/sc7180-lpass.h>
>>  
>>  #include "sc7180.dtsi"
>> +#include "sc7180-audio.dtsi"
>>  #include "sc7180-firmware-tfa.dtsi"
>>  /* PMICs depend on spmi_bus label and so must come after sc7180.dtsi */
>>  #include "pm6150.dtsi"
> 
> ChromeOS on SC7180 uses ADSP bypass, so explicitly including
> elite-audio.dtsi for Trogdor is a bit unexpected. It doesn't use those
> nodes at all.
From DT PoV nothing changed, its same as before, for ADSP bypass the DSP
services will never be up.


--srini
> 
> Thanks,
> Stephan


