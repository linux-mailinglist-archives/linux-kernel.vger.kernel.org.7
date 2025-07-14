Return-Path: <linux-kernel+bounces-729673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2067B03A29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479AB3BCD05
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2620D4FF;
	Mon, 14 Jul 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVE8o/6b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D823A989
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483522; cv=none; b=sunaW3l00jrgukj1VsReNTK4cVNygAkvHIJ67e61heaDLgenDA5NBKzMI4c9hU4uLRmuz+BaiucbPorhYINuFgYatlbt+SEwge1ln1AI7zCxkf7GUdx3NjCtVg2PvCpMX3NwQ0hEK6rmsvtBEf2LI2jS8vS4KvWUa16ideBhWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483522; c=relaxed/simple;
	bh=QiVcEFWR3A0fEZp/JWzDxq5uuw1b/SjZBvKgRWUUwHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deKdlSi1DrxwJAy17p7RZquVtgpa08TWZ9JFk7blCi39UdKs/P3q2iRoIjlDJO4O09kpeZ1J//f7sfKEtaCzNvJjqlxjkCnqbLs4k2oDt9S8AoIZGpzZA5vnC0cvMpFR944JEQzB+bLqgrNFEc027zcoGeO1Ht1GnBkz7nI0suo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVE8o/6b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLfG99004879
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eVFSQFBFf/hmbWz5fQBJA1oBoM/6k55vueTBlZ5GRIw=; b=oVE8o/6bscuHKq7J
	IW5N6KHrzpEo/H6P8ELGcZQbbiL/AvZtwBHw+hZnrkiaVs6CDSybdof1Tt/ogY+C
	Eezy6RrDjflRxkIfFH2ZJMarw81pvItkKYS4GI97axTyl4nirCjqA0qLR0vKfAsa
	Dwb1fHLhntSzm6edej+Tdn/Lqh4mAoMwUbg3ImwCtjCcNypowPEaWQt/0y5lPFbp
	2k0vs7IkYhlm/VpFdj+7CF01Np+dMlUiPiaC6ZZJMjZLt8zIkBeUOc+ZmneBQpku
	3F4KADkHtv8y/usjqruPzuoglpNo9fWJ0oDktIgm4oxI1n2d0p3iEbLB6Y5xQ1Sg
	OtT84A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxauxtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:58:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab7a01c38cso125321cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752483518; x=1753088318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVFSQFBFf/hmbWz5fQBJA1oBoM/6k55vueTBlZ5GRIw=;
        b=EAuMpicdBVqZR0CtvKHCY30ne7dFfA2W58Z/867HSok7L2/gsChSxvj7b8NtKuk5f+
         BsiafAYTrrEtHi4BrtcUJUhNKUFSPXfM1gAVtmzJ/g9qU6bnyrfi66fmO097FEiRPUIz
         6Fdf12A+7esGo46kLA+YAnec1HBBhgyxqAVWQ0YMp5aN7k+n8RXPctjjCBDKsPzVjgxT
         GFjL928UK0BZaEYjs6iBAvKnK2wE8YGVLWHolKQvXKgjbk6CuTbtKgl5B1g9QOodg+CX
         QtGY5LAMCnivILDlA8aG2kyYwofOq1th5i3Kan6Bj36G1hzPWRYE9th6O168wCBrTUD/
         +0FA==
X-Gm-Message-State: AOJu0Yz8S5CTTToGd63x0sJMnjTMyPUv3s8pvMMsEy6XQCZpWbudG+kr
	LX2Q5fV6LehcGBx6WTfeC+iS2/r2h8U8v3OIsm4eY+HEFRErK+gjnLEq+8z6EdlOsNHYMQXjrqc
	h3A4yUYX2jUD3STV0QSzoBEsyEZV6u2zkdtOdFs2PSW/LEsZ0wnFFUelpsOGff6BJEMjiCrVQef
	E=
X-Gm-Gg: ASbGncvSWtaDbufjjDCOoEIKf7EyF4xVviBa88nzVOC8RRrM5T1Yh78SGl5H1/9CVmH
	Kd0ks/FZF4hSEOuUA2/1DSk85J3ZD3RvTfn/lcPB2WjSDdRPwvYQIIWfYHErBXD7JK9MixK/7nZ
	2VG60UOnZatQfLlP7aDyxZjdS1lcxiV6SeLMzsCdTtEuI03EjYBkfuxj5AvGAlHc4n1UknUw24p
	Zp7+2mC7Kms4BKuedZLNgw8QwGkbKvXBPw85uFo/SJJDJvlT3lHECrsrlxi5Jj5bdndInb9/oP7
	i2IhNI06s8gGtXYjfGPm+Jvn7sBH32ZCgFYwZj5hh9QZN4VCMMZirsfvbAjLSQuGHS6afRqo/wV
	31+fqcHNLEBno7BB3BkLz
X-Received: by 2002:a05:622a:6a04:b0:4ab:533c:109f with SMTP id d75a77b69052e-4ab533c1d38mr33202211cf.15.1752483518552;
        Mon, 14 Jul 2025 01:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyWKteUj8o5VODQK+2BJ0/X/YeuYekA6dRnqZzX1W2y2SY55bcGHUGGjZdrZb6seu9rPe14A==
X-Received: by 2002:a05:622a:6a04:b0:4ab:533c:109f with SMTP id d75a77b69052e-4ab533c1d38mr33202141cf.15.1752483518093;
        Mon, 14 Jul 2025 01:58:38 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee48f6sm802041966b.55.2025.07.14.01.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:58:37 -0700 (PDT)
Message-ID: <55048b4e-6c80-4f4e-ac05-e2b8cb48203b@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 10:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sm8450-qrd: add pmic glink node
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
 <20250714045310.2092385-2-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250714045310.2092385-2-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o3c-_zKN23Xs-HRUa4VFdnFAMeIv-vY0
X-Proofpoint-ORIG-GUID: o3c-_zKN23Xs-HRUa4VFdnFAMeIv-vY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA1MSBTYWx0ZWRfX2/xCpiy85uHB
 X/rPu9DqlN5Bgvh7v2x94iA7xjrp/M5k/TmROVNlbMlSIAgTDfE0bUNBiuYWqTnQ1suyTJ4+Crc
 XUxDaxj3IWJxiShH0k0yK9mox1sQUEekyoXvyqNs93tnshPfTY59s9DjonBh5OTmKXa/1IJ2WG1
 N7V8GFNSQfDO51J72rmlPEaxtFQ2pZnq2RyE4UJIOZxbQlGggTqTsuaHh7a2/45lXUo639ulNHU
 6wsjFMn1IWyXJ8qGJdUSUFiMtc5Y0PPYALK7yKQPdBOyLrK9VTgfBa3+fndWziuKxEx61DCDBBK
 zScwu8+hyNq4V8+RvHYvVFHhIMCRXT5SsH115qNd6CApnU1pGFq51qu29ZkfB5cs0MAyB76kuqH
 k9mXiIS+glxnXzDgES4TgKBcEyfx+FVEL78DxBmcs5XYTkeOPFRcfVCvX8NzoFah+94wRR+z
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6874c6bf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GY1l66hMsWQi9t9MqZEA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=900
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140051

On 7/14/25 6:53 AM, Krishna Kurapati wrote:
> Add the pmic glink node linked with the DWC3 USB controller
> switched to OTG mode and tagged with usb-role-switch.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 51 ++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index 8c39fbcaad80..a5093eee3dea 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -37,6 +37,49 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	pmic-glink {

Please move pmic-glink above vph-pwr-regulator (so it's alphabetically
sorted). The rest looks good

Konrad

