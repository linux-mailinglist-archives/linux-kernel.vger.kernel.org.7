Return-Path: <linux-kernel+bounces-765045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31CB22AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B2A621710
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF12D5C83;
	Tue, 12 Aug 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnUArB/Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91222D0C99
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008769; cv=none; b=WzJu7V4Y4sq+FQbvQr1rqlu5aRWN6dMID2/TosbTvuH/dEa57EZCKLW9Jqn5HFbhO13Vulpp8cQQ8dInmBsuP9r6LWSdUyv00rchvl25YvBtNHd8CIub4GFpKXgVQJGAw+ewN+l9j0FZakyw3DQ/nFOgGanYqO/Vs/9zip3hnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008769; c=relaxed/simple;
	bh=EGD+sKUYcqQdiM8+RYCudtofEx7sqJDUQ+6JMPkBXkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCZl8BcwggO1PezaRpNFzW+2bitPRSUxn6q1aPpr/NvQhJFQup3btTWrFGvq7dq0iwgPlVZxTNPSQs0nUoxvbqGttahK2St1E0MgRlCCjVZqbjx/XB1dGAcuoTQcZDWv05XxK0QN0pBzE6OlERbjE2nI3BrF8Vo9rqtsj8LAEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnUArB/Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAw8Lm018204
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtXP8sH7GqQPa7UuRkPSokPxFXv4WNFCKY2MoXbtnt4=; b=hnUArB/YoB425YL4
	zcCExCIZGO63312q+tmwrvCgPlZlmj2xA4wcHWzN5k3yVQjRA8goQx74ciqGkqjp
	vIbs6spFPW/pxzZuuV29wV5Nky++2yBmRCMFKDHRCk92j4DkeSo8L0z547LMCS4A
	N2IbpNopvfUM5H9a4fDaLhRm7s4BeKj+xtApugeoeLHShibqSTb2IcArmf/lEDKb
	jK8S+tcA1nGLpjkBDKmQH0mCP/UDAmHdfcdkPf+IajFSHdFyaHHhjpFnwFBpyHBO
	POjxrJkx+2SFnoQmPdrsrZZcISNYfNtpXN/IYIterFeFCCi3PGlgWS0Q/i4QcD/q
	ktZyRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4ce5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:26:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07b805068so12677101cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008766; x=1755613566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtXP8sH7GqQPa7UuRkPSokPxFXv4WNFCKY2MoXbtnt4=;
        b=mp/l07idfQDiCNcSp9xaImhG3iVpH/Gt3P4qYBHZGUxd0+OX5sBwXzRz6p39qtLXM0
         bGaR7zTyae92FMzXEuJk48cgIwvxyiI+9uaRaildhhFOB62ahVsUSjB5LQeDRDVnyaRq
         M/wz4757Ao/6PDENOQpUZlJAnuf0IXeLujg+HAMRouO6qErmd0wfkYZrtSOiuFGQ6ocJ
         WWBRfNY1PFPRgLn/44R2xPiV17HezNNDZwW+zOomLIchW0CXAoYUt1PevndTBcbDuFDe
         X2EhzG10vfMp2VptpE3+WheEox/tXfC+RQg9aV7Sxhkag7gp5xiwsgv26buR72P8rh5D
         YK0g==
X-Forwarded-Encrypted: i=1; AJvYcCUzyvDucYlyrLP13h3GC/DgO2rqQiGHIeyvjjkgkaqNAk9pSir4LaQRxzq7nPmiAlOjCN4pJClSikrMe2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsE4yUY7j0V5HC4kHgy9D+G32fWcUxQTWn6kFK+yGrYQUurttn
	lnHpb2VrD8xBJoFt5unpOMmqHkm7RADnD1Uf9eweFyF72uGCfy1k/FqyoiKfMa54zvUUX9u+bHA
	Hmqz4C3pdChB/rCZGj+0nUAR76PD2OZsGKmBRnxoIyNopW4/hLRLjCLNfizVQezYsw9s=
X-Gm-Gg: ASbGncsYPpqZyj918qPziPrJDE3fonR4Z20I61pcFK1hQMXv3fiIO6ws9g40QoFx8ID
	7hf8c4Qn2y6cvWhhoqyqJVg+lYUSAdbYF1c0JgjxGuKiVQppN1ztlqVtFTXAZLbvXF97TQtif97
	7k/Rq7xKymqdXMDrPCB7teU0LDlvciq7tqTGOAkYLohnzD+uivjsOKWDR7HJ0VDvRHFAb1tWuZm
	Xn9n5Tu2WwdoPP2KPXuvViLMB1slQnAUaLk+lRUXnCSbeNcZ1Y/oOW2wnxqqXMUtdkGh6NKfyiA
	fVP0dQ6vUjgDS3A0L0fYc/WPkEd9ichhCMdPT90qkFMdjcmJdpuP494tmeVxpoqpqwjSTPMPYHS
	0AQMl1uud9Z1YSmKykA==
X-Received: by 2002:a05:622a:189f:b0:4b0:8cfa:a507 with SMTP id d75a77b69052e-4b0f4ccd933mr8824051cf.10.1755008765541;
        Tue, 12 Aug 2025 07:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8LS3Zr7v6eg7PJPhic5KbiS+w16SpOf6m2iTrYCjLH0hf8ZvRoSmzx2RInkE8544/GXw8/A==
X-Received: by 2002:a05:622a:189f:b0:4b0:8cfa:a507 with SMTP id d75a77b69052e-4b0f4ccd933mr8823581cf.10.1755008764930;
        Tue, 12 Aug 2025 07:26:04 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm2226480566b.47.2025.08.12.07.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:26:04 -0700 (PDT)
Message-ID: <6ffa8d6f-d5fb-4a94-ab7c-1a923cae1332@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:26:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
 <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
 <e414163e-e171-466f-965d-afb9203d32fa@oss.qualcomm.com>
 <be5f18d9-a642-4b4e-bf69-e0108e988faf@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <be5f18d9-a642-4b4e-bf69-e0108e988faf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j030vVbYY6x3VLnmpwjFJplvapsOaKjB
X-Proofpoint-ORIG-GUID: j030vVbYY6x3VLnmpwjFJplvapsOaKjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX54Wjcy87ngPI
 WKJU/xOdtZRuMmLOt87z7pSrE7Qhc5hfja7CaFkt78sS/bFbu/XDdSUM+NsXBqbKC/vgJkfGoe5
 lRPtDBSBhYmyEJMRyug9hj9kXFuxXi0TeAkJVawff+viz8kXIJIB6kk8aSRzpeoLE8kOW9M+0EJ
 4FKeLb3h/7uvEZSus8Op8/VkTgpQtS33xP0MaVV9mpBph8FzcrrY4K/l/SOs8qpQRKpPdfMwkVb
 IX4sZ9FgJz6dUor825T49eJe1tCtbmOxxV7WCjbRxiAtq3JR9KLN1jOXCErzaxJv7MdVkJIbRaa
 edMpOg92JcE8t/F1wl1sdTmu9yNqap8H3HFSeV0mFjjIpNDywXlav3uV5pp9SaRZZ8EKK049aE5
 9nEXhiDt
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b4efe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=9XIazU3Zd_7FZfIRWW0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/12/25 4:24 PM, Krzysztof Kozlowski wrote:
> On 12/08/2025 16:21, Konrad Dybcio wrote:
>> On 8/6/25 2:38 PM, Krzysztof Kozlowski wrote:
>>> Add Iris video codec to SM8750 SoC, which comes with significantly
>>> different powering up sequence than previous SM8650, thus different
>>> clocks and resets.  For consistency keep existing clock and clock-names
>>> naming, so the list shares common part.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>
>> [...]
>>
>>> +			iris_opp_table: opp-table {
>>> +				compatible = "operating-points-v2";
>>> +
>>> +				opp-240000000 {
>>> +					opp-hz = /bits/ 64 <240000000>;
>>> +					required-opps = <&rpmhpd_opp_low_svs_d1>,
>>> +							<&rpmhpd_opp_low_svs_d1>;
>>> +				};
>>> +
>>> +				opp-338000000 {
>>> +					opp-hz = /bits/ 64 <338000000>;
>>> +					required-opps = <&rpmhpd_opp_low_svs>,
>>> +							<&rpmhpd_opp_low_svs>;
>>> +				};
>>> +
>>> +				opp-420000000 {
>>> +					opp-hz = /bits/ 64 <420000000>;
>>> +					required-opps = <&rpmhpd_opp_svs>,
>>> +							<&rpmhpd_opp_svs>;
>>> +				};
>>> +
>>> +				opp-444000000 {
>>> +					opp-hz = /bits/ 64 <444000000>;
>>> +					required-opps = <&rpmhpd_opp_svs_l1>,
>>> +							<&rpmhpd_opp_svs_l1>;
>>> +				};
>>> +
>>> +				opp-533333334 {
>>> +					opp-hz = /bits/ 64 <533333334>;
>>> +					required-opps = <&rpmhpd_opp_nom>,
>>> +							<&rpmhpd_opp_nom>;
>>> +				};
>>
>> There's an additional OPP: 570 MHz @ NOM_L1
>>
>> +Dmitry, Vikash, please make sure you're OK with the iommu entries
> 
> 
> That opp has troubles with clock, so would need some fixed in videocc or
> iris, AFAIK. Otherwise you will just PM OPP failures. I can add it
> though, at the end  DTS should be independent of drivers. :)

Weird, there's an entry in the frequency table for it (well, * 3 the
rate) and it comes out of the same PLL as other ones.. what sort of
opp failures do you see?

Konrad

