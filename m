Return-Path: <linux-kernel+bounces-852304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F537BD8A22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9EA19216E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE352ED15F;
	Tue, 14 Oct 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PIzByqpz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1C2E7178
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436175; cv=none; b=dey91fA4ZiqEkHwpUwEm/w5rB/wsNa9eYFbNT9aUDI7fvnBD7gHhSFocyZPoLQAVhz3kW0jfIyklEzZ/NhZXyMOTYeNjTc/7/fmQR6eozIQzYjAFwDq6Ke2zNtEGZmUPkIlf9h6DNh0rWMHEp9rnezz2YZJpezh0BJtIWjNB8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436175; c=relaxed/simple;
	bh=bVhHjhDLmZz3sKkTchRJtm+6H7mXSchASd7zOLrW230=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvYPor98hr4ZIT5emIRlWbIJ5i1dXBp1TTvRh7lrn34nvs5Cu3yqsLxZGg9KQXYumNVR/uenu/zwiv0dO4lNVv5RN2dV7cHF1tiM0HllYSGhZKD64ytq7sZFKmfpeZK7mIQuIUhVjK9mgpGWhNOLQK+8JZqM82FmG2uWiYtEoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PIzByqpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Kb4019963
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JYjKTtUvBgaZV/+iOUpoJCKb8Vbb1mGbZF2yoFSadIw=; b=PIzByqpzBz4RzqVC
	viA+Qv4gO7W9o09y0BuAfFyqv+iX8wqDAr8Gy0vHqDMRcbRBpwLwqMA7gcrjmFsz
	yzJVCjSFFCZltpiZmHBmVk76nL3yQqZRf55wMwTEP4CzvGWkomuqIvehBEVOYueV
	ahNedIy9a39946/RS9+/dl7xN3xeNFGrrYVIxCMIsrznPV+pkPFctS0DUuMOmS/h
	NTlH0YITczx/cysla8tkpajRe5ac4KyKLXJCS4JslVd34l3E0wlTmWAvdgJCX7fU
	r1D6qRyXRWSyhmsjNlrOtQldHb7hj6fFB+TiiFo8JHJy+WPHzkl93E3q3O4mlPWK
	Ox3iog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c006m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85db8cb38ccso275616285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436171; x=1761040971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYjKTtUvBgaZV/+iOUpoJCKb8Vbb1mGbZF2yoFSadIw=;
        b=wCZwP/YZrhJTJIWRaORRhmbtX4OKV3VyQnuzA5xFeMpcI/wFDMfTCpD/Ty/cQJHZE/
         yg3Vm/M+skx67Zc/HnZLB1NiJT+U13RFGxOFiYfNmSpHlZrawxVLu7Cu0t1APwKm5OI6
         U45JEcmHGWMfZqJNYk6wS7egRcl3TloTVdYUckJ3HictojOobZpLRy7r3o+gRWeY1PyE
         HoN9giMW5E0YJzehO7B/D1MT03G/qsfPDL+E5p6TNXJV/Iepr+3llDoAacMVbNFuH8CA
         dSfRhyuZRkuiSkYz70oU7LqjCQ1m0FIplURAZjCduIlZXqz0Ej4RHIp9r6m96HSuazDp
         5BkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWYHZfbtxtK+DZClGBraXYXEabJyVlw0lq6FBjpgQiL0pbMWU3L7fpkB7l0fXo1cEq0O30pOukblZ7d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwoKk1ZxFYk/4BFUzzyLXc1rgzlxE2tAtbD5Lzo/9I+HWDApw
	38j5pYwHJurPIuA5KNUH0NDAArYR0mjX8poyCHGeDtcSNPHykOMHLZdsg3VOTqpI6645XfXHWo6
	xFIs375tS395KfzLjcU5XVPlWgwrgflLP/5ycnE0QAhPUD3MLmKSXbx0kb/QbCsHr7NE=
X-Gm-Gg: ASbGncvIEeEHHEJiA1djqh4m4F6bqu7j3CglOeFzYdTO3hdQH4Om6KYBSWuWonzR2Ws
	2lgJL6BjS6O1IGPafBq3R/PSL+jBnbzvcmkt+Phv/W6p36WFwLuC+oQdH2sm6ye9+BzIIw0kDvV
	fSorBYboeBQL9JNTIwNpvMa1d+8pSBNv4cMFGzwuQCSaaDNbBzJfApso/Eo4EB11Yy/pI8CzluM
	ByBhHSgkQiZefLXjhsJc4eQWdnUMwjsucr+fvVFj/gpf33ykWcdj54apb9b3Cfctl2OXZa6Qa/S
	tUOZiaaK85QXfA16eaQ5BVbSrYC+1ruCh7Ma/HUb7GLa5oxKdCakWfVA5MFnBs0BzTCVIzBjoO2
	iLyiRbT9V0H1RqzOzUN1yoA==
X-Received: by 2002:a05:620a:440a:b0:861:ed2a:2f9a with SMTP id af79cd13be357-88352ba651fmr2122069085a.5.1760436171350;
        Tue, 14 Oct 2025 03:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt0D7zWO7HIZAtXl1MAeQkSXOlc60URKPIzuUVE8zwNTntzw8XcV/pBFh7aasaW8fEsIs7/g==
X-Received: by 2002:a05:620a:440a:b0:861:ed2a:2f9a with SMTP id af79cd13be357-88352ba651fmr2122065185a.5.1760436170724;
        Tue, 14 Oct 2025 03:02:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm10859296a12.19.2025.10.14.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 03:02:50 -0700 (PDT)
Message-ID: <ea12c0c7-c629-4014-8bbf-862264182c0b@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 12:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: r0q: fix reserved memory regions
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251014044135.177210-1-ghatto404@gmail.com>
 <20251014044135.177210-7-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014044135.177210-7-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0h7MfMb5IIlqGjEQu0ebaNl5tOmkCtl4
X-Proofpoint-ORIG-GUID: 0h7MfMb5IIlqGjEQu0ebaNl5tOmkCtl4
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ee1fcc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=w6xXu69wQtdwpxc7i3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXySo074l2FI1T
 /SUgXYGSt23SSHr+R7twk4hrQ40Qi5It1l+qwEOaFoe2IWPUzZaZ7Rx0KlDTAtJaM79UIZgRm84
 V/0FFBfA8DSz4o3KgxLkRa/J/NCGJpQDqdAh0EeijiSWqZqf/7DG7IOeP3J5k+L3maQ0Wb9Ixs2
 hFFiFEUI4ArPjgBSVDIFPiOnRm0q8Tr8H/vJGSTslsPtckvIzPMtuTG+SfE/EMnypIcNSScEVKt
 4VNJayWdIF8JbhLHY75GAVfmRLvrHlDpkJOUc7LKVUt+ZCTArGuRzRgs7iniAvqd9dxsLMgh8mv
 4UfpRPlK+CcqRzcBqHFdHXqclUZ6xu/31aNgL6+xtF4bHfQvR55Nc4ak9pIZiwlk0B5UhreZbga
 b7z57/1CrkIhDZ2UefWAdUF/yoU16A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 10/14/25 6:41 AM, Eric Gonçalves wrote:
> ADSP and video memory regions in SoC dtsi is misplaced on this
> platform, fix them by deleting those nodes and redefining them.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> index a3b81403d180..8ed8a67aae0d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> @@ -10,6 +10,9 @@
>  #include "pm8350c.dtsi"
>  #include "pmk8350.dtsi"
>  
> +/delete-node/ &adsp_mem;
> +/delete-node/ &video_mem;
> +
>  / {
>  	model = "Samsung Galaxy S22 5G";
>  	compatible = "samsung,r0q", "qcom,sm8450";
> @@ -64,6 +67,16 @@ splash-region@b8000000 {
>  			reg = <0x0 0xb8000000 0x0 0x2b00000>;
>  			no-map;
>  		};
> +
> +		adsp_mem: memory@84500000 {
> +			reg = <0x0 0x84500000 0x0 0x3b00000>;
> +			no-map;
> +		};
> +
> +		video_mem: memory@83e00000 {
> +			reg = <0x0 0x83e00000 0x0 0x700000>;
> +			no-map;
> +		};

Please keep the entries sorted, also with regards to the existing ones

Konrad

