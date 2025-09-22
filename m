Return-Path: <linux-kernel+bounces-827183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBEEB91142
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B83AA223
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965E220696;
	Mon, 22 Sep 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICQHhCOJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C67082F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543325; cv=none; b=V/DHiy5x9NlsyWYv4cpdmX1onbzbYHLLkK/KzQzZrv4s8BU9DIJzKZnApsfGDM72di6cyUPIpovXfGHgTcPP6Pm4EdAU7Mhj1691l8l2PR/Mb7bRtrjb/xpAaEh0CvW8GK5Y78hoaqeF5KPWBBochDK5JrjluJNvfQCCsShs7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543325; c=relaxed/simple;
	bh=G3F0xMEE+TMsLruePptbFERK2DWVWwzzsLhy11bsxDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD3TWK09jrMvtRKYRQKGXDvUe/0/qcYilFEDY8LZyq9rq2Feiiepu01629KtGAaNWgmrxQe7vwOcPCTrz1emdbW/z8wZ0DurT0igSws1h5BaqAGWY2bbC8Wxok4iSvYDx27f0bU+XsdbcacbB9ldbtUR/4r/YRqf45+YSdvF0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICQHhCOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M9BDdg029336
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2SOcElaA9ELOUb5vvWlHmIL1+0Xp49z4i8jOou1NK2U=; b=ICQHhCOJDviz6wjG
	VQYHLnyag2O9oFXDHa6uFvZ79hCsn8n6yzpFtrncVlK49rpzkZBKkULl9Su6lOAN
	CEr7KbchXfhXaXYjiQ3lp3vPSiVcLSEGIbYrCzxvGRkd+aCxAfsmMhsgA0DgvIWj
	/FySuvB/oBq0SX2jN9n5HxNwpfPKiaWkWzg/h3MQususUtJlhfYiwx/OwYg6snvW
	JBdRj2GUDoDz7QhejmgrhuIPPciUwGpk3ezVmpGj/VporvYy1JJxcVNlZcAATRvH
	RuRtXWnQEyAGMFHUpNLhTp7nyyuQfEfKc/FA57tRhp1Ny7VlGxHqytDieH/ph3A+
	uoFUAw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk0h7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:15:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24456ebed7bso53261885ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758543314; x=1759148114;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SOcElaA9ELOUb5vvWlHmIL1+0Xp49z4i8jOou1NK2U=;
        b=p0EytcEteiHohj9FjTLcnhDKVWmf5eyNr/G82iJovgzRUSQj//aCtN6GMyk5zq9M/U
         xMwajmHu24WY3EV+I5fm7AJFDkyUSHdbUvkSfibUVYHMIocXGQNsrnT6tcEhfleSYEG9
         xviRtijHM05NfLaffIOFMNNEjA65VHEwqVYsLub5X/zM25es5b5VWY35C7ug0W7GvKnC
         uMcChxtsa0s2WFyKrSXhZpImoHOi5If8HVdMaAgLT3eMquFgPcN9SAr/DQzQ6lVELNx7
         dRJsMBf3833OZMvw1tuxqt6n0Gd7yRtIArm/iKh65gosjuNXiUl1tpNwNBJ+St5N6lhz
         CrSg==
X-Forwarded-Encrypted: i=1; AJvYcCXH9qmvNTnIwZg7Ic37ytDZekLpszYk/dUN/tW5jYqeA5m9CjY1cqWqkeLoyGLAxCRHGdiJTEaa+ijd+NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwV8s7s6qzAL2lLoiUV471pkHAgpAR2IyYjTLDj71Ib9uvY3qc
	hMlIa5ZNjBzNeXzgU76ZIBjG7ncG8AUmf/rSKR7wIQkEUtaPVX7AdAKYq7rLyj0b9T1zjBujKB9
	cW0+0k1yJXygTfwLWXmVfxu9Dq/xY6DePsIrdA+E3piBOzXeqmFMmA4x2Smw5RHJlIvY=
X-Gm-Gg: ASbGncsmcNvyKOglmT509chTBCtgbr0g/Wau0o9udEGEvNjzJI53ywHwzMCqyzqx4uY
	NuPYB0w+DFF67lwxilslO5volJrRWhWO/80xkXDJM1p+d0sdI2khu6C/UvuzMFpoC7rfgoJBo17
	aYXVUw20CoM5cAiucdKo/ntFSyGnMmmPoxq553fN7CrwgEa0imbTdKjeW/ol55skYgOVpqgCb3e
	kk72gjYXVvCDgNh5RVFq8eb9/J1/JI2jAFZlpjZkDayzlbJQ4Q8Jqc6EyVsAcmJeispdimj2KER
	MJA+rWvqKkr+1Hrpt9FQzYL0FgU24kK0Ub47e9z6RjZmVjU84/p4mYEYA3rSaNY=
X-Received: by 2002:a17:902:f68e:b0:262:f975:fcba with SMTP id d9443c01a7336-269b7952ec0mr164439985ad.9.1758543313683;
        Mon, 22 Sep 2025 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETp5+7x0LZwwUg6TPsnjfrGzvqeKvEn0RwiiAxqp/8tCtsL27SgsBFX8tYALlFBBn3b0Z/+A==
X-Received: by 2002:a17:902:f68e:b0:262:f975:fcba with SMTP id d9443c01a7336-269b7952ec0mr164439345ad.9.1758543312965;
        Mon, 22 Sep 2025 05:15:12 -0700 (PDT)
Received: from [10.206.104.82] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm131950355ad.88.2025.09.22.05.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:15:12 -0700 (PDT)
Message-ID: <134a9c5e-3933-4e53-bfb8-5d1de0111fcb@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 17:45:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <20250921-kvm_rproc_pas-v3-12-458f09647920@oss.qualcomm.com>
 <aNEHJv92i8NlaSO3@linaro.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aNEHJv92i8NlaSO3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Lzpzd0MZptk_UjpjfW48xl8sMb3zpa6m
X-Proofpoint-ORIG-GUID: Lzpzd0MZptk_UjpjfW48xl8sMb3zpa6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXyb+sNlhvy6Zh
 kvjxobd3IDAQ0SudJMMavfRZ9me+f3bTZObzHvPcHFcFXOkzWhG34ltTbubCocx9V61uFoFOVAb
 JDb6kf6YZ0KowSdF5S23U28CuYjM2sk+TQx1MBvsj8/ztHyBM9qeYV3LX6vHQHIR+RTRbKvXn2Q
 BIcIHHigMsxkJXKF/xQcb2WHM4recT6J0taD2r0VRc+6O1i6SV5ZuvNaDsOpaZtDnwiefI/rm/c
 3CdQh0EPgO9n/YUXtYNxC6sUVKEhx/A9FUsNrRgED2T48HlP/C1EhPLq0NAPR3lbd86aoEPS9Gs
 uqPvZbXEXmH78Xn7Txayzn8lR9KyKco2tVZ3xC4+4FyP5nasYYztTbdTcCIMc37MsoR645/5HAu
 bYj7Np+W
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d13dd4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=b-_fF0JyYpgD-z2UGBkA:9 a=QEXdDO2ut3YA:10 a=eSe6kog-UzkA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/22/2025 1:51 PM, Stephan Gerhold wrote:
> On Sun, Sep 21, 2025 at 01:11:10AM +0530, Mukesh Ojha wrote:
>> All the Lemans IOT variants boards are using Gunyah hypervisor which
>> means that, so far, Linux-based OS could only boot in EL1 on those
>> devices.  However, it is possible for us to boot Linux at EL2 on these
>> devices [1].
>>
>> When running under Gunyah, remote processor firmware IOMMU streams is
>> controlled by the Gunyah however when Linux take ownership of it in EL2,
>> It need to configure it properly to use remote processor.
>>
>> Add a EL2-specific DT overlay and apply it to Lemans IOT variant
>> devices to create -el2.dtb for each of them alongside "normal" dtb.
>>
>> [1]
>> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
>>
>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |  7 ++++++-
>>  arch/arm64/boot/dts/qcom/lemans-el2.dtso | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 296688f7cb26..e2eb6c4f8e25 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -35,6 +35,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>>  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
>>  
>>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
>> +lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
>> +dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>> @@ -136,7 +138,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>> -dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>> +qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb qcs9100-ride-el2.dtb
>> +qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb qcs9100-ride-r3-el2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
>> new file mode 100644
>> index 000000000000..55a2a9e2b10d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/*
>> + * Lemans specific modifications required to boot in EL2.
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +/*
>> + * When running under Gunyah, remote processor firmware IOMMU streams is
>> + * controlled by the Gunyah however when we take ownership of it in EL2,
>> + * we need to configure it properly to use remote processor.
>> + */
>> +&remoteproc_adsp {
>> +	iommus = <&apps_smmu 0x3000 0x0>;
>> +};
>> +
>> +&remoteproc_cdsp0 {
>> +	iommus = <&apps_smmu 0x21c0 0x0400>;
>> +};
>> +
>> +&remoteproc_cdsp1 {
>> +	iommus = <&apps_smmu 0x29c0 0x0400>;
>> +};
>>
> 
> Would be good to disable &iris here for now similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=c0f045e303e014cec5d883edf82fe5de74769944
> (I'm assuming it is broken without specifying the iommus?)
> 
> What about GPU? You can load the GPU zap shader in EL2 without further
> changes in the drm/msm driver?

Lemans GPU DT patches are still in the mailing lists. Hopefully, they
will be picked up for v6.19.

-Akhil.

> 
> What about &remoteproc_gpdsp0 and &remoteproc_gpdsp1?
> 
> Please make the changes in a way that they result in a properly
> functional boot without errors. Disable functionality that needs
> more work before it can be enabled in EL2.
> 
> Thanks,
> Stephan
> 


