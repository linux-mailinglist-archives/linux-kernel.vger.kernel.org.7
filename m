Return-Path: <linux-kernel+bounces-768058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD9B25C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FF17F2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64425B693;
	Thu, 14 Aug 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5z3xqRI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E6257440
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154746; cv=none; b=mhmms7CBEqSiiXvlr2W6ART55FjNPwLfLspxNTq962R4HtADHn4gRzcimI2u0rBA05URiZa9y4JTb5p/KGsBvybVPn/qwZdVDQ8IV9aSxT7JwvQ4mkcZPsaFIutSEzlN+rm/3DYDWVAhimdB8JVCXq2D8Xi52aUcZ6sXq+azjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154746; c=relaxed/simple;
	bh=cv6dE0f1+2HJ6ifD9wlGrnlDAszs2lyg6y1T+FM/GXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojQGrTGxUJiCVmPOFVpeWjNAo7ZRCo2+NihOT1NJa9/V3uWq3KJjOnxqL95T88dYVu0WpLVvLtYbMIlXMmPa69CKsQ/EdYnPYYhNGCTEGRVIH7OVwPRUJEo3HblocuNjmon8kc7kEQtXYyoxTBI+TT6mvnWg7QJDfFSJZG82mgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5z3xqRI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMdUvZ012161
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xmxXpUgGKiuhKsdFeSAj9dw9kez65OgZ099Ql8PubOs=; b=F5z3xqRIEKnrF8D+
	rJn0OfWlC80aesDqxGaBES5tnswbIK2ph/chq0F6D0dWOA/bKIwjuoo8gkt0iPeY
	ylCgKvJEkCLyhlilQz3vSK7rt/rkzhZcBJvjhu0p+gg3oGEZ9GaZD5zxCU399iWu
	vpFpUJrL6LiqCzVejzWupW6zNS0ySDNetRncpzZAdZTTaR98PFVR1LTh+pBPTyx0
	8ikOzXPVkjP46AeaQtPk0DBDD2mwX6aPgCS5hwgZqBNhcn4SIWY95xwTj+eSU9D+
	d8Wqyu0+DF8UY4ILwBoMF+baIt4u+T5E/kthHk1Ay/ij2s4j2dveuJ64Z+rnqjwt
	5ZPF7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9wra3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458027f67so13002965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154744; x=1755759544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmxXpUgGKiuhKsdFeSAj9dw9kez65OgZ099Ql8PubOs=;
        b=BVFQhztGORCXdZ2u65ZNrAv6CjIuggfl77Km9JEq7rlPStsGUo/T34kdA9WVjdu40M
         i88F0fVeiMnvvFFii2q4Pvwz61CZtBmrxQSgI8DsNWeMAg6gQ+p/+/6BTsz8LySYgZsq
         XckJTc+LE3na47I1QvqzO4T2XmxRVpBt2WJlQeQzh69I3CYQZGOWyPaye5BqZnhDWMYc
         xLggJZFS+KkECvWtNWsGz6FlLk6k7rCIUj7eY2O/V5oQ2JMLDAep9XclAHHQFDanSqXf
         Z9IHzl7JWDwgnkgzcfDiFwdtoNU/TUAmrmLBu5KHjBNt9Ufi18bgjRwhUEtVl2H2Yize
         mAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6wVxsXlwuG9toMKiNvueQYcMS4HeVQQJ2EVa6id2791VmGqGgtO+vb2VnOY7XdwEUyXn3pOhwXt3yMtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssdBvDwcSRun89WbvADHR6IfiILUOGa31RmJzPx9zDD5+weCf
	U/Rud3OOWnBeRDlTgiu6LkIHOJIFleDT0EFLu58GQOQQxhVOEreJMeiYSvFXtjxPM1/JdCtmzzW
	6VGZYd65aMqlq0QEGDC1NObS6hzsC85o+hXZVWzXmO1rNsN0UQ/zrNMymW18mtnLEgrE=
X-Gm-Gg: ASbGncuLfC5XYkWxMEMKWrpOL1v/vX8/cyXWe8vYQVT1eMdy+H9YXNc/cQvI4PZD6h1
	v7aLT3zmNtppAsqb4ocmuY4VonUWn2f6hXhg8AN/Ps0Tzb0OrxxuFp8SYMygGHDmPajTyWXegjk
	UqjawRDleDtLsiz1R5beKYfqxXysD8V8SGZ4SZMSG+ieXEC4WBXTUWgnpIBE72kG2/tyaWbGoqO
	kP1iMnK6fnsM5tQKVqlMr39V0kl1Y1rMFHjm6Fbsc2zPfBH27bRGRGiHYXSx65re3211/bpPMCg
	0vwUFbhven+GD6rrc86BqDdoFdWFDFBH4QvDbq8LwFH4QeO60vKtBghwA+r98CygZ8zk
X-Received: by 2002:a17:90b:518c:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-3232799c1a1mr2789291a91.1.1755154743855;
        Wed, 13 Aug 2025 23:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8CTJ/JcSa7RvClhZ1Noj4UnKmQoScP0H0m62yaCrSPHKaqpNUci8RZ9cH7R5dNw7mRb715Q==
X-Received: by 2002:a17:90b:518c:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-3232799c1a1mr2789250a91.1.1755154743352;
        Wed, 13 Aug 2025 23:59:03 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32328d0a204sm500314a91.3.2025.08.13.23.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:59:02 -0700 (PDT)
Message-ID: <d81740ac-f83f-4ed3-ade6-193b8bb59bd3@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 12:28:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Bjorn Andersson <andersson@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
 <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>
 <ii366w2aftbitlhlmsa5fhbcn4s2n2fc35plrrb5tlsmtv4udv@btbtgo2vr4tw>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <ii366w2aftbitlhlmsa5fhbcn4s2n2fc35plrrb5tlsmtv4udv@btbtgo2vr4tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d8938 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=/kiP2gCwObMqexHosDfpNA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=5QP-OhRlovnELOG5v58A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Dx2tJYaOcijtqxDLre6WGpYzS9rAT1Tx
X-Proofpoint-ORIG-GUID: Dx2tJYaOcijtqxDLre6WGpYzS9rAT1Tx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXxfxWyt5PnmvP
 SOmS6DtjjZ+OAxCCOve5Bg23Z+MiiASlRKCAI3qZnfbOOxmD6dR7vWV8wMQAtAqvVzYdgcZgzdH
 rNDTZtc8rGTIh7h+XwCrqz2jX+FP91o1cmTMcs2yNUYOOZ+jZSiaWj1FTYalQ1+09E9AmVNxLbk
 Uz1VylDx+KNefDvzI+AeVQLnnG7iaG3NgDSIYHbyiR1hcGRqPYNybYjzx60Ay0WTvrd58iUoIDr
 FJKgVMm+EY1neJtctSPWr+sF0dtgLGmWsl/BBdTF1HljJeLtzIrxLsYm5vdGugrS0I7OFiQ6eSh
 lDzLf+tljdElL/87VINo3gkg5NEoirmcmHnEo8pAEyLgYtTGgKoxF0Rb/EscW5DGcqglCfXG2D5
 ksCXEQNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164



On 8/13/2025 10:50 PM, Bjorn Andersson wrote:
> On Tue, Aug 12, 2025 at 02:25:12PM +0530, Taniya Das wrote:
>>
>>
>> On 8/12/2025 9:15 AM, Bjorn Andersson wrote:
>>> On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
>>>> Add support for video, camera, display and gpu clock controller nodes
>>>> for QCS615 platform.
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> ---
>>>
>>>   DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
>>>
>>>

Bjorn, I will push another series which will fix the above errors.

>>> The missing clock-names in clock-controller@100000 predates this series.
>>> Sorry for merging broken patches in the past, please fix that as well.
>>>
>>
>> Bjorn, would you prefer that I add the clock-names property to the GCC
>> clock node to resolve the warning, or should I instead remove the
>> required: clock-names entry from the qcom,qcs615-gcc.yaml schema?
>>
> 
> It seems to me that the qcs615 gcc binding and driver is lacking a
> number of clock inputs. Can you please look into correcting this, and
> based on that resolve the dtbs_check error?
> 
> 

Yes, Bjorn. I will surely look into to fix them bindings and driver.

> 
>> Let me know which approach aligns better with your expectations.
>>
>> -- 
>> Thanks,
>> Taniya Das
>>

-- 
Thanks,
Taniya Das


