Return-Path: <linux-kernel+bounces-766623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07BFB24927
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FD47A7E68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E58F2F83C3;
	Wed, 13 Aug 2025 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oK7BQKZC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811B2F6571
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086842; cv=none; b=ciIxQdlTYfOhhDbI6/mLGXllffezd7bQw7ZC7LIrKdGBfswlSeaqGF1+S06zHRxolY6FcxL7tH0Sb9bnBP5XvZ4XVo7GaS3KaZKv+fqlYEQ3GAWtN5wI7Xd4VZCwsCpFnA4A69Vld7UTIAbRIfxNXSqTOejzA8WIl95ENmjC5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086842; c=relaxed/simple;
	bh=9qGcsLi3E1UFO4Ta3jTChcqEtx0TcY4Yl7Ij76foFms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rttZkaecldOvCOegBzyP+Z56fk0gQv52N1/MRzpezPc0lbHLlHJPmbK/e7Z/nEn074VJfHQ9eEbvAI4JIzXrXAAWPZy6B42mjaL/HXCPU0PG7o/01EQbGEJcY1KBT1RD70vNiMmSFR6R6NTPrysJ6mATsQrLOnT0yyNU6llbxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oK7BQKZC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLf49030083
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpMBrmFukhU4y6bCKMTKHpHZgNaPXxJRJsX95Y0wvlM=; b=oK7BQKZCKX+/NDhf
	Hb1HOr8MuTn1j7LRuc2YfW+CSOtw/441t6C9VDYNYRpDAONHxCLalD0V2LDM8KY7
	X3MBSEM2Vz3+YDZ1eNnTsFH5H4KTW/UZI0e4aU2kslBnFTUKkQszKbXkg07OW5+N
	u7o7ss87Kv51zhOsuNse5CNFUhcLa9XCYkliJw/I+ML4rSQiy/jLnJN34nfxKB3v
	q6QYKwZb8ab7ASLcKj4a1WH34yLsJTRnnWTxW5VWjwz7JoLdaSGeZqetfIcnU1YR
	E1QdW4QTVnDoY6obToK5RpMGp2ZJ2tsNKR2plS8608R9L/v9zQHoc8tPDvZyB1su
	O/WmjA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vpm42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:07:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0c502e87bso5366001cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086839; x=1755691639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpMBrmFukhU4y6bCKMTKHpHZgNaPXxJRJsX95Y0wvlM=;
        b=HLHESvUJNmHY+B1fg1Tkd49B+ba98h8/Jvv/vFiNDsGIod0jhx3nGEUUHGXUm0d5zV
         q6byw1Y7aXCoVKQB9umosf5mhippPq7xk53PJeCE4I+8odIaz7Vhjp09eImwgAk3HRbz
         SxcC3MoM4cQLlo9i6C/L4+9lHwxk5CnkL0uyM6HvXy6tkB3f2mc9yCnMeHkduiQB06Pa
         +x91NF8+0KHRV6HmLfEYX20SDEpxTSE99sNpQhBpP2IgMl65FK8pcVLIyrwApTNeHyIS
         cc8tjJQu0IKW6MeoUz7rUmVvbkbQSmhGqhY40ea2GWd/DfvT6XygIAfi2cTAubT1MUJK
         XWaA==
X-Forwarded-Encrypted: i=1; AJvYcCUcxSeiUDdhs0Ks8sN63YAbd0ioxLtZROzfIj/lm5i0neXkSF72KOx82ENTvTOS12XP+CuI86R+Iam/c6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW6/dhSTkAsMG9KbwegCqlxFgbPctzTvP3JiZhmgtlbY+5GkV
	APo+7V9hhn3UcKNT91g8DL6gzUR6qYpiqfwwHJU4k5hoNee68NDz7r3hdMk2v2/R4gxesu8/GjR
	RCMtCQLrITKzZBmzExBT7A3lVka5VG2SpGDAcDLVP91nJgn3BckL1hu709DoCySI0FQc=
X-Gm-Gg: ASbGncu9qHOrDod0rw83w5dr6g30ddMmUo7IDQauvOr1SzHiKftscpUXUEDS5Di7g0l
	XJK05ZYxAeL6/T6b3lc8BRyGFIXl4y2GmcZjINTFr+MEP6Uf/HKlENwJ2z7NEE4zRYPAgAxM/lG
	eGrV7Po8sP9TVm47mMWvv3FANiBPld4AKXo+gFHw/mIZNtLex4Z9goBO50GoGO8cR4lfDJD0V4d
	SApTBtkKzFr0JdGMf4j16Wujop2pCbt31+9DWlWGi9zXUqxF1gsElrdbP5vwWLcixWjkBUB5fu8
	aSyiSD9Cjh4NIVVt52e8jeWmti9TVE25dYJzczZNRypXoVDl3RIxOlhBcdStH/6ZkPmk4iUa8Ne
	RSmdXaLbMSodppuEEuA==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr17927671cf.10.1755086838446;
        Wed, 13 Aug 2025 05:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZpdI3hsMO67WfmjVMZeVxcjGlR3cg/Z3J/5n/B10NtxW+duZ0gzDzWCXUZ//zNILeSnGbFw==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr17927091cf.10.1755086837804;
        Wed, 13 Aug 2025 05:07:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6187d96a320sm385968a12.4.2025.08.13.05.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:07:17 -0700 (PDT)
Message-ID: <f2f13082-20d6-4f22-8dfb-f11b01cd6706@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 14:07:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250801084518.2259767-1-quic_sartgarg@quicinc.com>
 <20250801084518.2259767-5-quic_sartgarg@quicinc.com>
 <69f2807c-9a28-4b31-97cc-2756f0ab9fd4@kernel.org>
 <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
 <8b023e56-435b-43df-8b15-c562a494e06f@kernel.org>
 <ab5d3811-9fbf-4749-9463-4457fbf50023@quicinc.com>
 <4091c488-996c-4318-82ad-c054a9ef5a22@oss.qualcomm.com>
 <a93fb5bf-1fd5-4e00-8338-b8608a9ba8fa@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a93fb5bf-1fd5-4e00-8338-b8608a9ba8fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX5IHU4tGh+hoA
 wV+SM9ncnkF5zJtroLvOl/JUSovaFBRrlMs+tuUZqlj+RAmxgSU660zFR25HwMA3W3ap7GtHvJO
 AmYxXp3nhmTtENGAMn6auSxOQjuaP56lTPgnnFSmPXdkKKI48w4kRMc+ENHvpePzkjO1pFMJxzn
 Ma5HA5Usmr136JC/7gU9iqdI6MSYwf+CZCjAxkT7pMJkmjx6mg8VTT/f14g6t+OFgAs//Gz/OND
 ZG1b1DawMU2tQ5IcSsC0sZDm2GHkElztNe6sP3rH0YPhbngEEstb/e2IMhAnYWoz0cRjfUZV3hs
 Xgs2i3uObnMsWzU8dJHpSwZWijTQzJbyvfP6QYsDe6SqRazh92R2eWQt5sl4pq+IE+UcTXKRE28
 RGmohM29
X-Proofpoint-GUID: 4Tr11oHk28xa29TXz4JJtGQy5Wdc5P31
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689c7ff7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=RWzb36qre9bUkXLxNJYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4Tr11oHk28xa29TXz4JJtGQy5Wdc5P31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On 8/13/25 1:56 PM, Krzysztof Kozlowski wrote:
> On 13/08/2025 13:21, Konrad Dybcio wrote:
>> On 8/13/25 1:08 PM, Sarthak Garg wrote:
>>>
>>>
>>> On 8/5/2025 2:55 PM, Krzysztof Kozlowski wrote:
>>>> On 05/08/2025 11:19, Sarthak Garg wrote:
>>>>>
>>>>>
>>>>> On 8/1/2025 2:32 PM, Krzysztof Kozlowski wrote:
>>>>>> On 01/08/2025 10:45, Sarthak Garg wrote:
>>>>>>> The kernel now handles level shifter limitations affecting SD card
>>>>>>> modes, making it unnecessary to explicitly disable SDR104 and SDR50
>>>>>>> capabilities in the device tree.
>>>>>>>
>>>>>>> However, due to board-specific hardware constraints particularly related
>>>>>>> to level shifter in this case the maximum frequency for SD High-Speed
>>>>>>> (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
>>>>>>> card in HS mode. This is achieved using the max-sd-hs-frequency property
>>>>>>> in the board DTS.
>>>>>>>
>>>>>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>>>>>> ---
>>>>>>>    arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 +
>>>>>>>    arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 +
>>>>>>>    arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 +
>>>>>>>    arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 3 ---
>>>>>>>    4 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>
>>>>>> This will break MMC for all of the users and nothing in commit msg or
>>>>>> cover letter explains that or mentions merging strategy.
>>>>>>
>>>>>> Exactly this case is covered by your internal guideline, no? Please read it.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>
>>>>> Just to make sure I’m addressing the right concern — are you primarily
>>>>> worried about the introduction of the max-sd-hs-frequency property in
>>>>> the board DTS files, or about the removal of the sdhci-caps-mask
>>>>> from the common sm8550.dtsi?
>>>>
>>>>
>>>> Apply this patch and test MMC. Does it work? No. Was it working? Yes.
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>>
>>> You're absolutely right to raise the concern about potential breakage.
>>> After conducting additional testing across multiple boards, I’ve confirmed that the removal of SDR104/SDR50 broken capabilities does indeed affect V1 SM8550 devices.
>>
>> v1 is a prototype revision, please forget it exists, we most definitely
>> do not support it upstream
> 
> 
> You should double check. SM8450 (not v1!) needed it, so either it was
> copied to SM8550 (v2!) by mistake or was also needed.

I believe that the speed capabilities are indeed restricted on 8550-final
and that's why this patchset exists in the first place

Konrad

