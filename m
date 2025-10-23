Return-Path: <linux-kernel+bounces-866770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A462CC009AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65AE3AEA24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A430B519;
	Thu, 23 Oct 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aydXRKD6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54902C3272
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217280; cv=none; b=PablXePrWy6ewy3yBfztNuZShDTpHJfL1EAr0ixmu64DTNhhzROUT3BU+NK3kiKan2j/Y0+osm/nYWR+Kxl/pPsIMTdu4TPK67YMVqdJ0L5uko9giB9iWyfyukv03zmEToff4rnh6r3O2pymKOL7RLQNKIfTHAdPflyDJejwBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217280; c=relaxed/simple;
	bh=KLbKfhQdEVpsqoRQiUj+noXGDqfEwZDNBazhIEzNO4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI/CoS9aeqNyGn1MThdbSAH1RJJIaBC31nSHB1ImJWgckErnritEytNFZ1tS/xzBsa+Zp7i02CyX1Nc5riDcIkyvbZnaHv7kSZcAltGpKQuIGzCdm10i+pIxknlr3P41ajoMSEKCQEznRPhlOR1nFWjtyqJP08oLfpKZ3dAuS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aydXRKD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6ttmm007459
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SWvodgoQHlCAgUxLTGA2zNee27B1mcvQ6fjtgBWIkUc=; b=aydXRKD6CXTPjNb3
	7s39KU9XMjsR6l2oasW0vp92hs6LaLZYFvI93oWlMeVAaTE8wbm5eClsIzHC1IAV
	iK+rOnFqIwPz/7ckt/JLNVFGMLPf9ngHMlokZc0N5OzeVIm0cFe6diztG3VP0Plk
	vu63xt/WTX85GcKgxPv6in3PofN9U2ijEfTWho1U7wJcC7lKmhMWY3tHCVgLlaWg
	bVVqXYobTQpNQEA/plPfV9XZyr7wmTBVros+5dptcrRukToHW4wzLIzuCcDDXRsA
	onPmD1aCpx+l9KQwfHSdl0JkLC9wPjxrxFwu19KzaqgtMQHL3ObcfGrpilEQacPY
	1SJMbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344867u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33d7d774b68so189516a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217276; x=1761822076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWvodgoQHlCAgUxLTGA2zNee27B1mcvQ6fjtgBWIkUc=;
        b=g+BfwnqxVlMkT6JVlvtMHFZWjZkIv850xPzqxCCjsYgtCUkFC7FrtCzuaJTZD1B9/a
         0VBbxsKYvV1XfplaewVfWFweGNDemPaAHWeCCMqQj1QB7Blm+9mj3kXFU1HSY3Lwd4OS
         YtboBbjSX5C8GFx5DCW8OKSXyIaun4pf7x7wrhSwD5HZ7O5J4+rqB5iBVWm3IhOaTs16
         YT1Ay/iq/HQSOCkjLHVRHB1/7I2PKe6qCwtaBkf1X7TN08NfxLtlMtj9w4Ld0b7gtirG
         mbAuf5yAGADpBOcpq6gSdBjjhtPlyP/vHLnRo6gjmirsN8Q73rjcZzwnJcMFmWZs+WB4
         WJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG6Us6H7aM7TNC0Yk/d30rESHczu4HmJZdG+tS1rQZrBP/xSxYFdJQbZ1TBMxlyIeusFI4Vmtro0F8iiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfMndGXVD/r7XqMhk7uzqrzZX2zEoRowidUOiy+tL2i/ssfnb
	YZNFn1Bkvi9ViRWwtRtPV3dLIzTcXfaOnFcs1NBSQk4HCo86LSzlRdNPcxZN1d4Z1quMkZX1V1A
	SflS9mb0BFftrnnycvlD9B0ICDuZ17dOi732RtW0NDTLq3nWkI42XY+OwOGufy7lHYQ==
X-Gm-Gg: ASbGncuOwSlJ40fIG3Z0OUP4DxPipOGq+PIe7Ti6sc3LJLVsVFEzW8Bt3+e13yjL3h8
	V9T8FwsgVNybOf0RsgjtoFInM2gAv+TI5Nfcvh3inVCL5jn15M13jKKLYOiUz+sOscMKwnSKMDH
	Mw8DuvroXyMGgA+ye9ZQKnFHy8fEeqPT2UpX78dYok2/830hQn8hr+PzWQbwnDTbspnZiQMUUUp
	1oG1aipiGEtfgdUDZAo680pQrxac0m+VSxCahorslFl46K6/PjImqf2gl7KED3S4Nkduy2NTVOv
	QbvvD6k48Ym1jSqcSyuNhFnd2N0/+dGIb+2CKK8RhDGi7T+7yp4dMntqqaDxeirEFEUGty5v7Ke
	q0PfSIVkK3vWHzodZszHo7lPUakLK
X-Received: by 2002:a17:90a:1101:b0:33e:287c:cb2d with SMTP id 98e67ed59e1d1-33e287cce1dmr2745957a91.2.1761217275919;
        Thu, 23 Oct 2025 04:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7sjBjqEtUr+LFigXCOi6Pc0gZjDtpKqghp/7YaBoW9/xfSqioLyHdakc+MWVYZtwoh4Wh1Q==
X-Received: by 2002:a17:90a:1101:b0:33e:287c:cb2d with SMTP id 98e67ed59e1d1-33e287cce1dmr2745921a91.2.1761217275163;
        Thu, 23 Oct 2025 04:01:15 -0700 (PDT)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373f5sm2070267a91.4.2025.10.23.04.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:01:14 -0700 (PDT)
Message-ID: <e9c24261-d54f-4d43-9101-a8c7bbae0399@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 16:31:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 mtp and qrd board
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
 <20251007054445.4096630-4-sarthak.garg@oss.qualcomm.com>
 <f8671543-bba7-4ed5-ad69-297df9bcc43c@oss.qualcomm.com>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <f8671543-bba7-4ed5-ad69-297df9bcc43c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OZ2cm2u7f0m1Ee4x0f-VZRYJ9GJbZOUf
X-Proofpoint-ORIG-GUID: OZ2cm2u7f0m1Ee4x0f-VZRYJ9GJbZOUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzwGQEReyNk0h
 y5k+M/J3loNM9NIAAK9O9+MOUkYwGIQZVzIdccZB3IFWaU7By8/9CltgYnN8zB2mLZy+s71DKsh
 92hUXk4xvTdEiDmbXxDPxKw2t67o0ARli6Bf1pqJLvA/KYUA4phPCUx+qgwH5oyd3cIZzyMvxJa
 7wd0VY16BRfWErLMKH/XLl5HrN9xMwpJiZLVd3VWkKMixXP0W55JMcavspvzSR9VYNlu8QhIn/r
 IPlDFq3nu8tIdICUlZ6mlUdPNP3Bppl3gilvsA3L3KtisSkTZnx3tX2HxSfmWZJnZOIlF0s7eYD
 eu6nSpYAxVDHlyg8rWpZGuzP6vNYODoB7y2FRSwfW1vPU4uxtGLmYTHL/6r+RDxXqMu6LilTKak
 CsiXINoLy5ITmWlOSd72UL59yZE/8Q==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa0afd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9AcWnSgGjwGhTpeVYLEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023


On 10/8/2025 5:49 PM, Konrad Dybcio wrote:
> On 10/7/25 7:44 AM, Sarthak Garg wrote:
>> Enable SD Card host controller for sm8750 mtp and qrd board.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 16 ++++++++++++++++
> Normally this should be one commit per board, with e.g. "sm8750-mtp:"
> in the title
>

Sure will split in separate commits per board.


>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> index 3bbb53b7c71f..26548191d95d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> @@ -1030,6 +1030,21 @@ &remoteproc_mpss {
>>   	status = "fail";
>>   };
>>   
>> +&sdhc_2 {
>> +	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
>> +	vmmc-supply = <&vreg_l9b_2p9>;
>> +	vqmmc-supply = <&vreg_l8b_1p8>;
> Any reason you didn't place a \n here..


Missed it will place in next series.

Regards,

Sarthak


>> +
>> +	no-sdio;
>> +	no-mmc;
>> +
>> +	pinctrl-0 = <&sdc2_default>;
>> +	pinctrl-1 = <&sdc2_sleep>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	status = "okay";
>> +};
>> +
>>   &swr0 {
>>   	status = "okay";
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> index 13c7b9664c89..8d018eef44da 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> @@ -916,6 +916,22 @@ &remoteproc_mpss {
>>   	status = "okay";
>>   };
>>   
>> +&sdhc_2 {
>> +	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
>> +
>> +	vmmc-supply = <&vreg_l9b_2p9>;
>> +	vqmmc-supply = <&vreg_l8b_1p8>;
> ..but added one here?
>
> FWIW I like the 2nd one more
>
> Konrad

