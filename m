Return-Path: <linux-kernel+bounces-896882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D6C5179A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569093AC62C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919902FD7D0;
	Wed, 12 Nov 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fB2en+/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxxSIL4p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7292F90EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940502; cv=none; b=Eq5fuIIBf23LukRuPclEweGIk5sAX6FcsnmU4IuVliciblPwR10GinyVfKg9+IuvBPJHVORnUtzffZKb2s/Yq6Oin+Sm5q91/ZdwBy8ul0wJaECHKS5qbGapOV1nTEbAcFvLXAMRnMCEX+EbzGGPt9+5QqnMvRnUsbeuWuw1xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940502; c=relaxed/simple;
	bh=yEpfRnXwpng+YAbKiDkRctzbO6mZ6cOtzRE8XZb0WYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TY/bD4egb65XBUVOnR4lk3CxIhyp1EIGqyfxje+n9fZ1Vu14qIEEXA+BQZwpO0XWBPadZXHOZtjEmhTHjXgl3OU8+GIBEK/6s1UCbIOjeL307fsuYgWGKkSxsB8d5lIw3lFkK13cSWxB3Xb8+uMDOBsjfqXBCC876kT12kbcI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fB2en+/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxxSIL4p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9SLvq4078737
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	niMngB1STMCCBtBn00XVFAnSjuGH6D0XJXQ5Yz9BtZ4=; b=fB2en+/2vl1MO2zV
	8TLZYpt+VTsVSs8oGF2+fJ5IeBxHZIQeqigEmA2Q1i8TAxVVKm0NtgwAaEc8OI3N
	Lflr+EdWdg8s1fq9Z9EJvDM1/X5oJhTFoaWjvyFLNuq1J7Rm7mWJcWfZxtqO2Lsk
	LWBqBAKY+mKKt1S+npVQLMvh9PFqyjtgi8pi6iTMln1bNDy9PoSry3UKbcioAW1S
	TJabnXJ82RbZeikCXi18jCUFFhMO1MPyiJbMmZzC9O0M5W5wYtKCKTBXA+5uAA3V
	Xx9AmNP1sp0YLmOjm4RmrGZPCN19FY6uidJjW+MUGY9twyzEecjXDrAMitLkd/XJ
	qvZtCQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguah9x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:41:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b29f90f9fdso15303885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762940416; x=1763545216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niMngB1STMCCBtBn00XVFAnSjuGH6D0XJXQ5Yz9BtZ4=;
        b=jxxSIL4pUEMh1IYrt4i3IYXWUNfTS/r/nLy9fkFuaHNQScLLX5NJN33kzx8GqaP2GQ
         WpLnwwzpPylFZthYhlyd1BYwqmlW51wEGnaDC7OZFg1pJx39EAn1aXJrK6BwQn0/3Qc0
         NUBxc1ltoosd0dKlMBfyqqvmuWeD9KojgLWBQ5a0RaZKuxXyPY4XWEs1/7erekNMQKG4
         zIyhFeYOBI7UBbh/qXbFgAZ3hKdeeWatjvH0mVmmYBjzQb03cYXrcWfLo2Oov20Ss3dB
         6vxX5O9EJw4vrvcly1a/SfT4iei67oKz08dp5CJZBF7dzEOt1TMKLWyNUhTVXSj39G6Y
         WZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940416; x=1763545216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niMngB1STMCCBtBn00XVFAnSjuGH6D0XJXQ5Yz9BtZ4=;
        b=Hvm40+zw2btH6abjuIJ2LOdk8A8kYIft5w/o9+GEXRKcbYSqh4bl2WAsQzk8jxAJ02
         brkgVKKYonD2QHpe0EwB6V/FoW1141VtKQoYWDbySNLk5e0YOjXGGwmFkdGVjkw7shwp
         3mhdQxAoBxhoXyIL7ohITQ9nj5wP8pkXcKFCSvdywAzrykCa+ti6gOY8I1v5kKvYtNSH
         u7ru6KCBnoNPD2qLcoSS1OnbOM/TthP4J1R6xgIeqvmqwvENkvCMoIr0PmboLRPbY4Ie
         1bdvBUmynQP+ioYfNRuWqEBaoJ7J82FNnDVEeaTCzhKHM33p0ShxWwvmSNFLanFQTjGN
         xWMw==
X-Forwarded-Encrypted: i=1; AJvYcCVn4YGEWMC9Bj3mNkLcgfv1TUrLlyImnD/Kn0SK9/zj3nkOypmnGuwa/UM5UzXTFldcrKGlyBdZiMM68KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex5C7y3caHd3hhJIV7kDB3r+FcHEAQ1GUUQE4EVl5toEBat9I
	Sy4MsAVpg0KiZwVwinzr/j8dQiz4ZMQuERGM+7dN+IZ0yAcURrR2pZ5OPrpA7peA1mafbFGP/nR
	4NY3/Tj6Mh6+ydW4pd5UdxRYWoIurU+DpLtMtUQAkOlxQas+EKTHnMhco7QxFrbg6E6o=
X-Gm-Gg: ASbGncvxF+lwCpxtN6PvHBr0ZcFBlrBFEk1ltNzqMh4rzLFoPS0k6vXPDy1bTnx2u+4
	oDcgIIS/uFouYg73P5AkTECAwOeBRU7g/I39gKlkKj7DecHOqY9BIQXT77j0wek9yh2CApGAeDD
	IDfaRNy20D4V2nY40USed1p7mUSdWaoW2Y74x+VKElriYqMzC4QW0XjGVi6frnbS6qOWLGAQlsd
	N5nkGBALZVWvDSc6H9aVXYhDsWUOvs2yz8jtsOz3F/KaLIGU6XAERe1fXbXMTWriRsSTA/2oVi4
	AWe8DoLukt/HpFyaCNO4JOyTd0r4O4vcLrTISmkatLXhbi49HSJY9StLGq7PDT8aVPqhdOsRtfk
	xy37K2D2OTfauhLIGN7Hkidllh5CCqQYs+dn4oU5WjpMY12Xf2SsrR0VY
X-Received: by 2002:a05:620a:444f:b0:8b1:95e2:4827 with SMTP id af79cd13be357-8b29b6c22aemr196979985a.0.1762940416308;
        Wed, 12 Nov 2025 01:40:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/UBVido4T7ElH3fCCu3qQd1JXXvVZZsxAdEl4gufrjb0+yrWlo30YT4rDW3v1gJasBUixsg==
X-Received: by 2002:a05:620a:444f:b0:8b1:95e2:4827 with SMTP id af79cd13be357-8b29b6c22aemr196979185a.0.1762940415789;
        Wed, 12 Nov 2025 01:40:15 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fd021sm1539442166b.25.2025.11.12.01.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:40:15 -0800 (PST)
Message-ID: <9d296c2b-da69-4b50-8774-9fae6b360f89@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: qcom: talos: Drop opp-shared from QUP OPP
 table
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Cc: mukesh.savaliya@oss.qualcomm.com
References: <20251111170350.525832-1-viken.dadhaniya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251111170350.525832-1-viken.dadhaniya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QJs9PBAZRMeK7ZMrk0kUMhvW_ybdDZri
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=69145652 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nWGZzGPzcphSW76LlmIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: QJs9PBAZRMeK7ZMrk0kUMhvW_ybdDZri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3NyBTYWx0ZWRfXyzHZTBLTof+t
 szqKescHp9eSjOydyxZCUYJzXRLdkVODd/+b2E79AibC5bEBEp4eRBLBn0iITzVaRpWZkue/Wbn
 SFx8S7WabODTz5c/B6egub5UP8gHcvTihTiZ1ptyYoQwp4LKyumbPtQnj6CoJO3W4578wLMSvKY
 qbb1hrH7aHXSMDEjgUKQea9XyJgUbMd30gt6Kf8C8F8JibSKRskrL9+YIAQUm3gPFUUouU3HUHF
 FUh7Mp8RhGXeK/2+tA/9AWjXbNTSdBbE37IStEAm0bgb3T//XZnlWs8nR8iZrzFXO2XZQqQPuoG
 17Fc56O6UdAgY04gwUEx/6ES28O5jtyMaItQzajVLc9EOMoNM4icRYG8pztY/8fPndMQ2IQgdeG
 j4uep/A8M02rv6EeeUfPfuxk6peACg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120077

On 11/11/25 6:03 PM, Viken Dadhaniya wrote:
> QUP devices are currently marked with opp-shared in their OPP table,
> causing the kernel to treat them as part of a shared OPP domain. This
> leads to the qcom_geni_serial driver failing to probe with error
> -EBUSY (-16).
> 
> Remove the opp-shared property to ensure the OPP framework treats the
> QUP OPP table as device-specific, allowing the serial driver to probe
> successfully
> 
> Fixes: f6746dc9e379 ("arm64: dts: qcom: qcs615: Add QUPv3 configuration")
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

