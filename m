Return-Path: <linux-kernel+bounces-732056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA2B06157
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E551C243FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD226E6F9;
	Tue, 15 Jul 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JIKczXHS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F1258CE7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589698; cv=none; b=jDtWa/GhOysf4md2KNqSAsDTtr+1R2ixZ3xfPe3RleeYpDAYdqybs87A3LkDSAf+Bk2qJ57s6YoMW6n4TP8gZdI1NJKDsLJ2/g9Ga5Pl1KykjZ8/g7ru7meMKP7b7CBdxi3NTkANPMp85i56Avu77ceTroIvqofdioGGF12Nsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589698; c=relaxed/simple;
	bh=TDZRt8vujcFrXp8325zzooIkVrGQbAyR33qzAjuGeA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHG9V1Q5sE4F6GlwTsjxhs5RSMj07B1dG946JXX5j1X8l+koabuOdMXdBTtyqtWoG/xkniVG+X7pueez87nq4CwSFTWUeVJVGtT0TFsnRR4Dika1k0iG/V5RCQDoO1te10RjjX5gAf8IRsLXelcMLcYqbDQjMgwnUGMLJbeTmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JIKczXHS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCQ91J008643
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QSFaumHypqTTcwYiUvNp2N7DCB9NOl0z0cIbJaXbtxA=; b=JIKczXHSlYwtlPo5
	cfnuvh/3aWstmsfCfxtrFNwRlmSJrHb5eHVszCxvCXypRM/xDPbPi+Es7MQTchC1
	GV8K31gkctCkl11tTx8S3GEl3rTOgUVRDkYFQLhD7lX6lriblaOJ3yjofDRJ8VR3
	r55ceWb/LF5YJ0w5VGKRfM8ejWQws5GD3qk8N4cimU1ji3+fDxOp831a2Z0u2efL
	VrXOGCP25xmJMiRj6vIM7I1494tD2QopXMhvOcEkjWxRXtRE+33ADCIMfIQDyndj
	vtp8jyKxYy/PA0G2U3btLeOUluk9q2+I70nmamTxRTE2DVXt1X1CkaYoh4eCi7kj
	DXkE9Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ykcsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:28:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so51052485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589695; x=1753194495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSFaumHypqTTcwYiUvNp2N7DCB9NOl0z0cIbJaXbtxA=;
        b=WHEuZUlJheTPhD8L3rqoSGCDC3er8aUfrxxPDmEilCuIiklBCh28WAxkmomz/hnj/P
         Fh+mdUUwyBJDQ7gnazSgSYqBtGSSNMzxnz1HTEjiC1FCKuRczYN4G+vdNWF2pf28w5k2
         hpdWqZowKMfdhbWhh/2xUn8ZkZ+fLcUADS/s2KswpL7KFSeGaFBi7xzK2cTsefB+Dg4M
         kjkaFh6tO39KxvR6dsZRUFiTI5z23B2iLPUH5behdrnK/AXWNf8s+2FD0/zYfCLGJGQG
         iva/GcXadDdNUv314alFDIaR3LMGx/5QbU6WaNRnpUJALxx7s1xubauIj3ZmXLxSjTYV
         j5rA==
X-Forwarded-Encrypted: i=1; AJvYcCXFRaiBco6lpuHkjM5DWQm4o0CDohtRl9uQMi+zK9n2FssNLya8yf/UQI6RC+5qHVGYgej4qsZfFlMfl84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ56YO7mbfMQGtOvIjTiWbv9cV87+kZ6OfB04m7dLyFea23HPU
	f2VTcK1ixkdSZd8/xEKSwVJEz2qLfddS2vsOwRm3PTFFhdvSbZrxwz1PCGeAZBjfBhacAadX2QP
	bDOLgXr/aqoVvNZKIrfUHFhifPb/zJqGEcXFF1saJCcDixYyb6PrqKYf45nWvc667LV8=
X-Gm-Gg: ASbGnctJEbQATTyPIaoGvDYsAD3acB5nOcBCehVNRe05AgaAhWwKcLtYC5Jdjz3asxW
	CxeQDuMNyZm6AYMAtoKsIgyHEJdorC9q09/qmLzSClcywRNb6Z6N6uooZaqzbmEc8wpQYLtf2Dj
	AMP2vVD/MghvDtt9wHY1QbNkCLIhNBT7P7JVdPU+qQAwja5q3LUUOlgQkmkyXIgwnXjWQAPgPsS
	Fqnpo3xMyT0Nilg06uSXUdcq1lP4Mh5yi3NyBFNXh6plYjZXTp3bhJSNjIttHTfcYFxDujQwKjM
	jimlzN2oghc86Cw+frd3MYySBwznJageczyp1WcGe4wOgESZ46l1cFkSHPk3DjWa8AZknPZ4iZ3
	XkEs1aN91ZsegeXWctvIe
X-Received: by 2002:a05:620a:454b:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e33c710490mr98812885a.5.1752589694711;
        Tue, 15 Jul 2025 07:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtfxTcgBGxnij43dQLyyxr09RRQ186qIQ25P+J4kz26uLidPi1uYyo+f55faQ4w2EfKpO5A==
X-Received: by 2002:a05:620a:454b:b0:7e1:5c99:28ff with SMTP id af79cd13be357-7e33c710490mr98809685a.5.1752589693998;
        Tue, 15 Jul 2025 07:28:13 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9734c06sm7386643a12.51.2025.07.15.07.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:28:13 -0700 (PDT)
Message-ID: <6220dea5-32e6-4ee3-ae83-96405362783e@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 16:28:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Remove sdm845-cheza boards
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>
References: <20250715-topic-goodnight_cheza-v1-1-68b67d60c272@oss.qualcomm.com>
 <f6fb3492-7e92-4893-8088-8e1353905ad3@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f6fb3492-7e92-4893-8088-8e1353905ad3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMiBTYWx0ZWRfXzI1r9i6RLRdL
 uYhMtirVquIGbIwcalvyvyxeUDsoTCkoK7eV3lbxgRhji9xMSnFTLEZ6L9RtUJrEy4coTMJUMFm
 WMh9Cw3Jwz2GqIu+TD+6/dXIsTcxguLcnrScvHspji2nQZbNM7XW8hCv+uPid3Wy0B3KxVyJ7gP
 emX32Mw9xmfcRMbXswrzkK8G2mHTX+3lKJANpoieoCvBI13ilEE+cIrF/qgMZQdh5sEYniA7sQF
 2swrVt2fyc/LGPB2/aGvW4lpwScCtPdKM2Kdy7YmYs4iIWWqG4yjrSKAbQmxVCal+UmWGLcBBe4
 B6Xu+S8BZoG5M880Ah5bQbraLvoZ37pNUuwroVbRj8CwiTH35bui5pL9e2NGNr+9V9m3WSGRMcm
 SJjRJZ+YAkLnrprAfVheucrksDjRPGD7f+0Tb6+MUyBuCVX5qgtgXnqwsGEJgkTQXGhBi6Ee
X-Proofpoint-GUID: bf1vMFREwnxy7tFoe5eM9R0lkvig9oEo
X-Proofpoint-ORIG-GUID: bf1vMFREwnxy7tFoe5eM9R0lkvig9oEo
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876657f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=z3venpNmMx4ABpSws_cA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=784 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150132

On 7/15/25 3:45 PM, Krzysztof Kozlowski wrote:
> On 15/07/2025 15:26, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Cheza was a prototype board, used mainly by the ChromeOS folks, whose
>> former efforts on making linux-arm-msm better we greatly appreciate.
>>
>> There are close to zero known-working devices at this point in time
>> (see the link below) and it was never productized.
>>
>> Remove it to ease maintenance burden.
>>
>> Link: https://lore.kernel.org/linux-arm-msm/5567e441-055d-443a-b117-ec16b53dc059@oss.qualcomm.com/
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile            |    3 -
>>  arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts |  238 -----
>>  arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts |  238 -----
>>  arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts |  174 ----
>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi   | 1330 --------------------------
>>  5 files changed, 1983 deletions(-)
> 
> What about compatible bindings? If this is the last user, it should be
> dropped as well (second patch).

My understanding was that bindings are generally good to stay..

That said, since there is quite literally no more devices and I don't
imagine Google randomly deciding to build another batch in 10 years,
I can submit a removal too, if you wish

Konrad

