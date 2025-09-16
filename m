Return-Path: <linux-kernel+bounces-818664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5DB594DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2991B27AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598022D3738;
	Tue, 16 Sep 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERQxo6t2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EA2D239F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021101; cv=none; b=dYg9MCmRZzSeG2iGzPggvbhMFqZMYuOvwe6QmkifgmuF2gTnHM7LgbcecXNHwh8S45Pjy7SNHQH1zfmfCY/CViUczbMhPnnaaDFOn3MI1sVMDwtLiVJCM7m/mN1XOrJesdrQQKEg7H0/Z1ciYqwBHJZCUTUmTzCLV/QKe7Tl2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021101; c=relaxed/simple;
	bh=275oPonI9MjWeJkyrUhmar7DMWxX8YBm5z0LrGXMLuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2ywa08F3YkIJKPEhsLEfhTwDVgtSd7E35hWiVvQ9EEbkvl2tmAhYePdjsCSUEthq6NW6hJBP5RRarWpQLN9UL34bR38HsTDbtzi4TpY/zkzp/IhUv5LVG6dK6ox88DLXAuA6NWV7lvSGwlGmeZfmpccYkpWVxJB6Sp0a0mKP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERQxo6t2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA4956005233
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIclFIP+LOqTqDxbmvs6AySAEMGiS2FOLi7+K6YMV/0=; b=ERQxo6t2OMvGWd2C
	Np11Rzcvp7p8epeQb2kAN3KDNiQcU+WtMF0pYiEIoeUJQWR4eZDHsqLroLzKitqy
	8Jtu7m3399Fq6HXoUXvQi4SiaeFTVVedoI2BpFn0tjCKlwOePfX0LUmAqDdx5knp
	k03qlq+oClSrMoogIUnKYu7ElFtG3C342E7xw2vGbdKKB3OQ3MU9AZBR1Xtev5eB
	v7Nfg1Nf6WPlYxrtNGr5cWETshzlMsM8yHDcVQLJzQWjbqiecuXVUPiBuqlg4SPG
	0A0Vw/ls/BkS4I15igj39/q9rXLNxBNOcqNHMOdsp8avn2vB6hVHIIHAY6gB+32G
	e429/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4a7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:11:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f92a6936so14509331cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021098; x=1758625898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIclFIP+LOqTqDxbmvs6AySAEMGiS2FOLi7+K6YMV/0=;
        b=aWIn0ZqUx9PAq2f6n0wupA4XWzkOTD1UsyLog9katkUsWwBstPzMTXFtr+EAzxF9TC
         HKxUpkez2BcFz/lAfrunYO2V15a1aNs79X3SLgr1HhFhsneK27mju07PsdY2Q/VqI6Rf
         7/7LjdjfQYWSddUF3bEfQixRXtvY5GLrfbDpBiSL6V0WGyCsVk3qmcqbjdZ9banZTvn9
         KHzbJr13fxDTAbHSdM9Om9g6u44i4IhoHucOfKNgdb002qXiAbWCMt3/QylF0kkGgLfB
         lrvDI/Rb6Pq/QO1Ybd3raOzOxfNxXzScb/AXoKyrUfhG6iVAk3HWv8uBAvo1fG9IVTI1
         knKA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZLWmWO/0qjidcCA6i81Rj8JHjHDPq+Z4dAFPjQBIVlzKJ9NFJRG3krk30dy4xVD+9AvocdwL+2UXE2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAQTgrVvk3/PJUl3Fy2UzTX5lK7r23e/nVBdVXioUeJBwoCOt
	uFCOGgR7wGsyK+Lc0IuvnlV8JR7iEDpUDwveGpzLUnjf1AgHfvKbVJfppP8yuyL+stfBRO8Qcxq
	vKdsG6FdMsPd6L8x/+BUGQ55Ckq5q5cj2Uja8WeifxjC9H10TXIKneokR3MqTFa/MaCk=
X-Gm-Gg: ASbGnculcXcFULHStNN3QmZ46H2MQ3GDI7X3gdAWdNi71tH2bvrtExUKyu7Li+Nx9GR
	e5dztQPMuFrwpYlKnMoR5UqO9E1BUHmS1TWojevNF/latCXt+VwOiSTbrZz5CxhWagJy6YbmJBN
	+ClHMuQ0yEEm8szBnpyDI9MJVw5LApM42LRRrz8utkFHkGLkeQVIyb3h2kg0vM7qNV9d8myQJWv
	dKgvMAMUii48vAL796NR+QfKjha965Exvjg4EpVCO6mpJ6dSxYJOAfWHJrsWcy7b5ePvVSS//vt
	2hFl1clZ3iGH5GzDV40NlkFcpRNgXBeVg2/dQPgnVrP7xKFIyLTTm8y+GcIHaeliu9Ex+sLXDJ9
	aA7D6ysRgc3U0Ijumbftx5g==
X-Received: by 2002:ac8:5902:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b77d1158c7mr127005611cf.8.1758021097895;
        Tue, 16 Sep 2025 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnXuilj96k6BuqcLnJZYaYn30Rx4rGcsXCSnzBEldqk8rQYINLpEqXJPXep1f3KK1X9KhUTw==
X-Received: by 2002:ac8:5902:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b77d1158c7mr127005221cf.8.1758021097349;
        Tue, 16 Sep 2025 04:11:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f416db508sm3834982a12.32.2025.09.16.04.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:11:36 -0700 (PDT)
Message-ID: <49d6c554-e6ed-4c86-8946-be2cdba659d0@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:11:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: i2c: qcom-cci: Document qcs8300
 compatible
To: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Vikram Sharma <quic_vikramsa@quicinc.com>
Cc: vladimir.zapolskiy@linaro.org, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_svankada@quicinc.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ravi Shankar <quic_rshankar@quicinc.com>
References: <20250912141134.2799078-1-quic_vikramsa@quicinc.com>
 <20250912141134.2799078-2-quic_vikramsa@quicinc.com>
 <20250916024858.GA3574831-robh@kernel.org>
 <373bbb78-2b0c-446c-be97-53b82edeed64@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <373bbb78-2b0c-446c-be97-53b82edeed64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: q3o_YYHYayipDITVw-IFJzbta0QEE8AP
X-Proofpoint-ORIG-GUID: q3o_YYHYayipDITVw-IFJzbta0QEE8AP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX/jzsxZmBQ2bh
 8z4rdd1XmSMM9Cd0Nhxf/5efcX2l7j3uo0ij2Y8/TYzqi/JDzxoNu8isrLYO/JI4Bc9wk8GOAiL
 TOHKOavgABedJdQt16AQUf2JWJqHnRV3ERdnRfOHqyezKmQOK2FP8WaekFTJXwvPVMHVzsWA+vE
 9Y7vk4fo/NwGSJGPsEoZGSxbxZcO89DaUIexW/xgPmCGmaFb/2kSHJLfWqA9MG3TV+WQ3ufd5Pp
 FFYatRdOWH51GPPHc3MzWPJZi7Qc2ZS6RAMvgQKxS9j8K+G4Lbr66j0iBBdkpE5EdBqpc6npUIf
 rvC2qi5vJve9SZ28ra5ejuhI1JotiYwRTm6mP7Czr3kxOe5El/ME2xjlwQo2qXV3Sz0HTHOVstz
 qNco/nr4
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c945eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=-IwCPt7gIHNx5Q8nY1kA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On 9/16/25 1:07 PM, Nihal Kumar Gupta wrote:
> 
> 
> On 16-09-2025 08:18, Rob Herring wrote:
>> On Fri, Sep 12, 2025 at 07:41:32PM +0530, Vikram Sharma wrote:
>>> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
>>>
>>> Add device tree bindings for the CCI controller on the
>>> Qualcomm QCS8300 SoC.
>>> Introduce the "qcom,qcs8300-cci" compatible string.
>> Wrap commit messages at 72 chars. And explain how it's the same or 
>> different from existing SoCs in the commit message. Don't explain the 
>> diff. We can read that ourselves.
>>
> 
> SA8775P(Lemans) has 4 CCIs, while QCS8300 (Monaco) has 3 CCI, with the 
> only difference being the GPIOs used for SDA/SCL pins.
> 
> Currently, the CCI driver probe happens through the "qcom,msm8996-cci" 
> compatible string. Could we use the existing SA8775P compatible string
> "qcom,sa8775p-cci" or we should remove it? 
> 
> Please advise on the preferred approach for upstream compliance.

Try:

"""
The three instances of CCI found on the QCS8300 are functionally
the same as on a number of existing Qualcomm SoCs.

Introduce a new SoC-specific compatible, with a common fallback.
"""

Konrad

