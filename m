Return-Path: <linux-kernel+bounces-578580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30205A733E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0111B3A7798
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A56217668;
	Thu, 27 Mar 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LB7FkJMG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06C29D05
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084370; cv=none; b=Nj0nmDCZzh950LMfTCDmm9pABzApTcTfOlitMb0y+2w9SGQ07hwrLODGx53YY4VGEbCX5mthA9sI47/VOs9dQgEFdPopJqS0Du7aMBEmYdH6QJYzwe+9sBRZb5n3l9bKm+oquDCIGEAVY1WGgKvJAgzXHJdNCzSIlx5C4SBmmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084370; c=relaxed/simple;
	bh=afvCO3GqTkYmUbMmMPc9YHgnK5xxbjvJVFV7ZeJ+Lsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfZLDN53FPo85RVqiIR9zI48Fk+wIREGKV6DUztz9u0L8Ye9DKdFv9v/T2VRqIFmEHYY3XqDp1y1K/5RerROgGDNLU0kX0V2vPwlKoadhbNqF1Tcv/tOjAaTqBBz+QAfiZWbaRLCCZQ/VqRkE7InGhkzQEQ5FR3cJjwzvmZi+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LB7FkJMG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jEac021258
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Z3KvQEYwkY1/2lhJB022eBJFJ7oF2A08hRma9OdFRg=; b=LB7FkJMGasCGJkip
	Q7A7dbQ6r9RxeV5jIMlSsgL8mVRhWVYdDYIJhRBl1AWGBFfn9UCpUDx7fwgUWvTw
	Q6xHrJFlcyvuur0REohlN6aIEqg6v/C6UJ+FYWLIYoTZfQeuttUoDnVw7xjmefU+
	hv7dQhSW0vuOsVhT64S7ic9rulR5OfEMlq+Q36aUNp1HtRY2jnxA/1QTtSNN/Ct8
	PT18n5Z/7OT21H0sKNIFhp1zNfPsR4YmlBFniLBgKaxVMDr/THoeogKY3Z3etS+0
	77IpJAJYEuqHwBCygupwOZ19JFlOlzo+jzwsyCGCDmZ/3PFaVpYlnRiSQa+QUx9r
	L7e0Yg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9pjqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:06:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5841ae28eso27689185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 07:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084366; x=1743689166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z3KvQEYwkY1/2lhJB022eBJFJ7oF2A08hRma9OdFRg=;
        b=AQOfV1vjawVkZVEpDeTw7+C9uJ8kVG6II12Pq5lAh5P0aaQ3oIQRA9z6un5Wfr6bpe
         T1AepIwwrhXKb7C+q2ZhZyqt+uApFQzJaODZa8DHnssNl5DuLQXSHXKR1VdyJ1GUHEff
         VnbzJCJW6w90FVmIXfl27lIitiKv+RDZXQK2YDMbYfNXMcXiqOwOAGXttQSVxh5xwD/W
         c/nBFtpyY0yTWmYUg7Xme//LLVdnMaOn8Im38sWDbgjERjVFDC7dhaGZBpYmYG/9AQVD
         jxc/464sjZebULJJokMPpYRCzzUf/mMHuc1iotdOWGT6yW/1RKwWz2Ep5kJ3kwMr4bP0
         aHUw==
X-Forwarded-Encrypted: i=1; AJvYcCWfcMxO7qebsiBqMTLJ03t7fsEuUqCJTEPxGRn+e3m/WPCNuLl8GivsF+Qs1oURz5OLRZ2u4CY/p6YSyGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiqc/qluM1clQ5zDAEtSz09NdGjHKHnllYaKEikA8h9K69sH53
	Rgno+Fdo0XCrarola7xb7RgUDaWdNMKQCj1oPLWAGYqM6nrFlv+yUSE3OyPdrVDDij6staXbQws
	gjazUMptupvR7V8gM+L0eOgA+fvbthm1Zq18tSKPjY+3YxMD1N7cY9alZLcdAfOk=
X-Gm-Gg: ASbGnctEZzh1by/Py3JTtNwCkzf38X9eYmFEFmdI8jNopiSVMK2tBwQxVO5ZArg9RDm
	+4Hic52ZLSw5C/LX3D0ZkEJxgEvt0P2C84c0Otxa8KgqOhtAmRpMMKB4iJKp3IHoOxIINARFx6T
	pWcmCrUD6xzCNW4PQTTcQIaR92DIgbk2DgVA1jbYo8+MNkEdkz6VAbQfIFhTAI9hr9L7TgqSEfe
	70MV0AhA0+2dPpV29tihyW2tWq+Sh7/woOMTw5uH3YG6glreHW8BzHd479ui08yraCEwwKeCuUe
	+0Q6HibH/UqI3/YPSgUC+i44hERF3NHIq9H2dPYCjGKywhuY0OHpefB3Lkz8xD8aUcN6Qw==
X-Received: by 2002:a05:620a:444d:b0:7c3:d798:e8ae with SMTP id af79cd13be357-7c5ed9e0e27mr214865785a.2.1743084366504;
        Thu, 27 Mar 2025 07:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9U/NvKfe+2u2COADpA0a5xEZZ0BxZtOhr2Vb8gi40zJ1NKZ6CZ8U/c1x/1bIsmt3ifaanzA==
X-Received: by 2002:a05:620a:444d:b0:7c3:d798:e8ae with SMTP id af79cd13be357-7c5ed9e0e27mr214862885a.2.1743084365910;
        Thu, 27 Mar 2025 07:06:05 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e5128sm1235201466b.59.2025.03.27.07.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 07:06:05 -0700 (PDT)
Message-ID: <f2e1090e-d4b7-4984-b852-5d7cb54bae6f@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 15:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sa8775p: Clean up the PSCI PDs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Sayali Lokhande <quic_sayalil@quicinc.com>,
        Xin Liu <quic_liuxin@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250327-topic-more_dt_bindings_fixes-v2-0-b763d958545f@oss.qualcomm.com>
 <20250327-topic-more_dt_bindings_fixes-v2-11-b763d958545f@oss.qualcomm.com>
 <dr2wkctvk2glk5agdxpijmz2wifvj5f3dwyh2pjlzesravutwx@xa4zcsuyur5p>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dr2wkctvk2glk5agdxpijmz2wifvj5f3dwyh2pjlzesravutwx@xa4zcsuyur5p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tBPiKFmjOZjldIWfPiiXrprNWlq1wqb5
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e55b4f cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=sGqUSZP9eBR_ybGCrCcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: tBPiKFmjOZjldIWfPiiXrprNWlq1wqb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=867 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270096

On 3/27/25 3:00 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 27, 2025 at 02:47:13AM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Because SA8775P comes with two disjoint CPU clusters, we have to follow
>> a similar topology description like the one in sm8750.dtsi, so:
>>
>> system_pd
>> 	cluster0_pd
>> 		cpu_pd0
>> 		...
>> 	cluster1_pd
>> 		cpu_pd4
>> 		...
>>
>> Do that & wire it up to APPS RSC to make the bindings checker happy.
> 
> Should these two be separate commits? One being pure cosmetics and
> another one being a fix (probably with a Fixes tag).

potayto-potahto, both are needed to achieve a non-cosmetic bugfix

Konrad

