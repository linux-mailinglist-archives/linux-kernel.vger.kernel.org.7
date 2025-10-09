Return-Path: <linux-kernel+bounces-846558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5726BC857C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A3EE4EAE83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039512D73B6;
	Thu,  9 Oct 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbTF4WvT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61932D663B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002869; cv=none; b=cYBAh3tOc2pOy/lESZrzKS1HBCx84NOzn2sBAhVjgl65F7dtkjbzweHsq2jY/UvQQ1J0gHzEKunqlVKM8k/5if2CDf384W4o7Ht02w9ilwHPHY7VSUiy+uV2Kd+tpm+PcQF8Wn9O5XtUb4XHrPU6/LEUyAgXCZidmO7HtKgRwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002869; c=relaxed/simple;
	bh=hjO46nWg5it8CbNTZJjSu9lbQry+Y0tbqwAr4+hiepI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/oKrt0gEcjYIdCN2tK8yRcG6HW4XxIO6tFKs2iUGks8KKoswhxur4n4PynKL1CAYjMa1FIjJfrP/kRiEmsWDVE0F2YMIGo/TyGRwYjB3awsb8pTHfZk/jrYtCMZ4Iu+fYxFssqaEc4nMxYGcEf1m6HtOX9GItlQ7GEVHG9c2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbTF4WvT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EZuJ028652
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aGTlSSq+8eQOySdUbPi/aGR701kfDoEADHwTgeSc78g=; b=CbTF4WvToQvbh4fr
	pLV/hUHFHJzBIx3W/idPY/KAuGoosSiyrPRp5lDKYuEOl0t+q9NGJRUo4f7JEi2D
	szKjZo2iGIxmig12JUmRQm9pVbiQIoyxS+grEQvU4DgGNgPTLYltcT3Bj70xuTcW
	6Ntuxv2fOy9Y6cIo14nHbfratWmNB6XY73rMk84xl8P91YgHaWs5M0bS5uktJST5
	8kaBK2iIx5hOSfGjfCw8HgCO2K+A+ZWNqdm0BzX7sad9YCu2fmbC6ZKUrd3ArYpC
	Z0Z5GJW0pSCdUDXlxSlo/8C3uL5MakDixZkF5+RhmhnB6J5T/UD/dSC6iXt/e2hb
	96Am9Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kt8gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:41:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697c4e7354so24186625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002866; x=1760607666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGTlSSq+8eQOySdUbPi/aGR701kfDoEADHwTgeSc78g=;
        b=dGGR80BOGpAtqV9BBbxEk/cEj1ls2BbMKJoFRmgYSSFrsjrgbwOK1ZtgvMSkjBkQyA
         8ASeBbQHt9y/Bmp9mmp7TjW14i1NJ2TxTe7wmDzKV2G8V9e+LIUdR9NRHxI/uWy8abLe
         DrTbWrDR4uyY2NPY5fvr0Vwl08p5b5u2JXXG5VVkxOxe9Btz/xrht2bCZhNh9XN31T9i
         ptJo+40jTXMvJyY0h4pbG3nZmZ4nMgDBD8XdRE7I/6B5jqOLks7W/pRyLpFCmMXHR7f5
         jGot5NCh7dElepVqjCWOF503XXNS9djL2Rk3OChziX4Ryy++Y/3NKX+lFnClTByqg4zp
         IJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXPA6R2ZGZBu8zbjZHVT0hB4VuIA/I6hJYDWBEfaJOxFrqyvSPOw/kp6nLUhjJgaeqW7iMs4g0BXCLtrMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnn9krwoMs4bkiC+u7h4y2nJB8e+o0WiiWSYthq1aFV9p+FiB
	KLl/zzascFxWge8zwBNZYMvGP5i9ttofQZNQmUY4HuT24PnkZp80fvYekisqCYpzMnpCYMsD02O
	4zzL1E8ysjgYqAKDs6iiK3kClaUOpXMk26aHrEWiyFvftJ7OfUH5oGaaiZvOgpB3FHXw=
X-Gm-Gg: ASbGncu8Vl12XYS02VhzyWGCoCHVwFqbL4f+t6HpernApIOJIuC9AxR/O6EsdMdcYuO
	6/lKy+/cwvvlMs1OkHEr2el10dKhHjrduxb8wHFtsbeQ9bhYdq5lWpyGFJlN0vaSJqH+joXotUF
	BQH8Jvvai7vDxaJs6qVAJce26xK20ED37AMERQnat/4Un4dc+G4lOgpLws1YzakadkmbcXYK9EN
	VPS2af47FqRTIUwtyUw6hPp2gw9yUcOrHHss6FCkiAbilUDbQDZikndsyEYQhB6gkm5YZNuJL1r
	/qASajUALQfYxaxKQlsGXs8nL5GGKUMyOYrC9lyvfQbtedqRY/9XkeYWX0tsbvbvigcyNee4Pzs
	ETDtkoL4egcKSR1F137O66Xr4YW2poAs=
X-Received: by 2002:a17:902:e849:b0:267:912b:2b36 with SMTP id d9443c01a7336-29027f257f8mr80329395ad.23.1760002865645;
        Thu, 09 Oct 2025 02:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6qD3Fez97NKxMLaWmN0Uk8mdrBcan/tESBp1DwEk4g/XwXSj//BKKzsIa66XuVcqn6lccJw==
X-Received: by 2002:a17:902:e849:b0:267:912b:2b36 with SMTP id d9443c01a7336-29027f257f8mr80329145ad.23.1760002865182;
        Thu, 09 Oct 2025 02:41:05 -0700 (PDT)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0713bsm22764545ad.67.2025.10.09.02.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:41:04 -0700 (PDT)
Message-ID: <392c5d4b-80a9-46e8-af98-496ed8837044@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 17:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: Fix 4-speaker
 playback support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251009072630.460387-1-le.qi@oss.qualcomm.com>
 <39ebaf4e-e91f-4568-8de6-9fc1f805a1e4@oss.qualcomm.com>
Content-Language: en-US
From: Le Qi <le.qi@oss.qualcomm.com>
In-Reply-To: <39ebaf4e-e91f-4568-8de6-9fc1f805a1e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxza8cVd+MauW
 m3ECo3tj3cDJ+kFv++2idZ/+vo1tqf5UgVQyuexTENSgPLO7TTxmVLboWZG/NAWlKDGkoPPyEHI
 6baZ7XG/yYJdPctj7tv3qV3xf7RNUuICK+oc0Kir1jrqduhabvfX3HA4ZRmTrqoZ5o8RFQMBxJF
 ih9mEMW5j12FYebN6t7XQssyw+5EqkB/5xL5SKS7K4+TtPnJswp7Hng0ZvNAhWaIZTBMWOH2y1v
 /qdGzpi6IUMb8p54aQAjzjnjKt8jEJDkO33A8sbo0D0fjE671kZQ/klocLioblkb5MQnrK/84MG
 l+7aHOIBO1cUKG5M0W1L6J2UKkDoq2/8n9mnnlDEYVeomPcGT4C+2L6Rmzb0G+ZodZJH4Cw0Ptm
 m9/CHDE7xBTvkIZTEocLSqdv+P/eng==
X-Proofpoint-GUID: m_nMT5n3gs8BkBXu61DvK2SWSdQF5kzx
X-Proofpoint-ORIG-GUID: m_nMT5n3gs8BkBXu61DvK2SWSdQF5kzx
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e78332 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=RyFr2WyApn2QNzaPLwEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/2025 5:26 PM, Konrad Dybcio wrote:
> On 10/9/25 9:26 AM, leqi wrote:
>> On the HAMOA-IOT-EVK board only 2 out of 4 speakers were functional.
>> Unlike the CRD, which shares a single GPIO reset line for WSA1/2,
>> this board provides a dedicated GPIO reset for each WSA, resulting
>> in 4 separate reset lines.
>>
>> Update the device tree accordingly so that all 4 speakers can
>> playback audio as expected.
>>
>> Signed-off-by: leqi <le.qi@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 30 +++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> index df8d6e5c1f45..de9af19be6e8 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -743,7 +743,7 @@ retimer_ss1_con_sbu_out: endpoint {
>>   };
>>   
>>   &lpass_tlmm {
>> -	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
>> +	spkr0_sd_n_active: spkr0-sd-n-active-state {
>>   		pins = "gpio12";
>>   		function = "gpio";
>>   		drive-strength = <16>;
>> @@ -751,13 +751,29 @@ spkr_01_sd_n_active: spkr-01-sd-n-active-state {
>>   		output-low;
>>   	};
>>   
>> -	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
>> +	spkr1_sd_n_active: spkr1-sd-n-active-state {
>>   		pins = "gpio13";
>>   		function = "gpio";
>>   		drive-strength = <16>;
>>   		bias-disable;
>>   		output-low;
> 
> output- properties should be removed in favor of in-code gpiod_
> function calls, otherwise the reset gets asserted by the kernel as
> the OF node is being processed, unbeknownst to the then-not-yet-
> bound driver
> 
> [...]
> 
>> -	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
>> +	pinctrl-0 = <&wsa_swr_active>, <&spkr0_sd_n_active>, <&spkr1_sd_n_active>;
> 
> Similarly, because these pin configs relate to GPIOs connected to
> the speaker amps, and not the soundwire host, these entries should
> be split between each individual device
> 
> Konrad

Yes, will modify and test, thanks for pointing out.

-- 
Thx and BRs,
Le Qi

