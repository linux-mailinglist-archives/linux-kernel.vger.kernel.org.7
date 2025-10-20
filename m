Return-Path: <linux-kernel+bounces-860863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9FBF1383
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113E742320D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694EC3126DD;
	Mon, 20 Oct 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cThWQ2Yr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51411311C21
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963373; cv=none; b=IgnBA2vt4st+A7i3VAoHaWRiPGB4/vfDfJaDsqk+rglr8qQUEG+04ik001d+oYggJVWG6pTGzin/SWGYMo556ilyaqD/2WeqNdpvfsH2iEcUsiuT/Xckg22Q5ZChEoNzlfXUdUZ2P0Za8yfKh5iTh4NP4FqHCNU/PgtxVC7qobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963373; c=relaxed/simple;
	bh=By4gOhzgftPHwGUyIhrk5JkXD50v475jHppkhs0x1Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFwROR0kbRivlvkmIxVggInjMr0aR9i7FYPpFvhB89vVkE/iloQ5d9c1+FSXqz0LRY2z9lkxxSKHLH5w6i2NsxmahFASRAXPVHFArwvQVZS3YFwYTUDNSqSvlPIn8QWRFb6w7aiSZ3AxWs7zqd3WR3I+UGJAEuo+vV/0xkdN2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cThWQ2Yr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBv686015332
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SlkF8eWD1We9s4Yi5xxwuMqmhkIuqXs6z1JCL27wQxA=; b=cThWQ2YrRAGKTAQc
	P7yrF//YZn8xELhD9SLaTUFuAHAbU49ttgjIw8mxZ6ReSIJHHhJge9Cjemq1b3Zo
	Whw8eYpu8FDsHtW9TP7wIblzR3tFGQ6f6G1ldWBaPpK+g58XbilaHzAek7iiy97y
	n5B961GKcnulbN3jlxGi9wVBLsZklvSIedPTUSsjeDVEA47TxlvPxTpd1B0KizmF
	qKiGn6/Cdi5AI/EkinhPsIAbx5J6q5jdx1ktZGO3i+cQ3fSg5w0D6Vs0U9VWUoLe
	Sjn756A/g9Mnu3oEq6i9d/Y2LwxqIn/U91zJb19Ta5JHWRiiH4ftSYSQT9IEd2b2
	0ZLruA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343vqds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:29:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-890cb81b3dfso149999685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963369; x=1761568169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlkF8eWD1We9s4Yi5xxwuMqmhkIuqXs6z1JCL27wQxA=;
        b=wjfv52e4f+itwnJkrIwNE+BrQrz5fpGM3jN4bZNMRbLvR/G+Ar0JZvLbnba/L8r9yt
         /2u3R6aaHIJ0h9+Z53yShaxJzno9Nh0uANlK4DgltyFTgiqhAuOH8WdE4RSnId69E3jP
         zpXvO6df4OfdJP2gMEalxzeDoMfl1J3W5fBVzCZZzXT3DzeUkl+TnwMJda/f2ngSCpyP
         O8v8ftHzwd9zWaLExNqwiIq2Q9vh5QBwBGXBmwtpNGrzc9vcLWQkje+cL3d1VG+HKmMr
         kYyffhQKRVfIfoSQSz/HsXY8Axo/+AThx8m1f7l6C5PXfCALiJmS1AAue9j+oTxnY4rX
         qd7g==
X-Forwarded-Encrypted: i=1; AJvYcCVCEGSozQFobeFdV2EsT/htFat6wL4znU4N14goTcq4TJVFAT2LVPdXNfJwyDwD456qT487+PX98s/66dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx349JRdGX5bJQ0Rq2PHwfCbMgK2J/Qoy/HDUbp082YXVb02V
	TLaZhj1a3RIu+8pdFmWF3yvL6aLNdjI+EmIoAuMaCxODrY3jgz1pIdUqzyZwwUun+7NbKhWNZOF
	PCUrVQ1HgthQ9ETFY71UepnpyCjfiNyJv0UV04LmaneZsovBSejSzyJrMxj0HGs6sN3I=
X-Gm-Gg: ASbGncvOrfIjfTACd1s0l0rW3cmLNhVqCi71JVKnJHz+3gTIF4P8BG1kyAY4oVh9/B6
	p2gF0NNiPBf4ZKClKSyrnnjSgGrODI4vr4NpBomW1F9LaPhrdzmtRt7LjOurxKG4ypkHHYBvF+g
	QppuzeXkZuqFNN/0j47oUOna5UpO036rnQ0Je3jPGht+UjnzDVYMw8wQHAyd+bBSVafz7OCto/w
	LDSkLCn5U3TklemnvsVuW1oZ118w6Rdi4twK8q2DxU8snOZRp9hxVuz8hXFANSOANFv1/vJb/w+
	lb97nZvZ9dRuDpSmCV6LiE4WbxZWBx3Q0w5okc/7Vh/Uh38TMTIVADnXxbFm4jNjPm4iL2WXuqs
	m29i+AGZNUJU+XKcS3lTFd9kHMyp0AaoQI6r2f0/uQ/bf6Y4uYJajDKVR
X-Received: by 2002:a05:620a:4621:b0:88f:561:d952 with SMTP id af79cd13be357-89070dd72f2mr1010368985a.12.1760963369031;
        Mon, 20 Oct 2025 05:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtKce77jyrjI+Q3dWbyvJ8XAStKr+D5wxNDmpYHRE6h3Vda1qthUxSCuU16i/bVy/FmBEyVw==
X-Received: by 2002:a05:620a:4621:b0:88f:561:d952 with SMTP id af79cd13be357-89070dd72f2mr1010366285a.12.1760963368465;
        Mon, 20 Oct 2025 05:29:28 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da3412sm778937566b.3.2025.10.20.05.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:29:27 -0700 (PDT)
Message-ID: <9e4afde2-1171-4cdb-adac-3a496b8c53c3@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm630: Add FastRPC nodes to ADSP
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-0-9ab5f2865a6e@mainlining.org>
 <20251019-qcom-sdm660-cdsp-adsp-dts-v1-2-9ab5f2865a6e@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-2-9ab5f2865a6e@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GyuPiJ1KiuVER1hUDR5CO4zIrZK0_YIL
X-Proofpoint-ORIG-GUID: GyuPiJ1KiuVER1hUDR5CO4zIrZK0_YIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX9iWvl3+PBZs0
 TyDW9TdZmrsjEL4GXPn03HRpmBXlP3Ammj3buo0fvJkcmGiKM/HT73jOgVuszPvyaP1TgihPAF1
 aIDA53sNyY/UdpEX+qMlerdQHIwLjg061Z+KyySciMV8X5AXS4Pbl77Sr2MrYuGOFBj9jYW67BV
 sU1NB8vxWIgE5CPdYVmpcdf8wRi2M12zOPSWEHsty3xgMkNn3b0F3CYBWHnKfGCSz+ugJ+7D/Hb
 n4mgs3cymaOAmfsKlqHhmAdzPodG2jM2/yniP/3/r07KNsLEo5pXDcRD84p5aItI/Q44lXyNbS5
 +6kKAe3wfxM+TA90xK9Jv6sY8+YpfBS+9KZfbtSYnIqtZsD2+tAw7fKzJ86Y32XxGMKCE0tuef8
 CIZlO1Hu4NRrXMWhHNQsHtjTKSmayw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f62b2b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=6XgSZUbUjBfQJWIQPfwA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/19/25 6:27 PM, Nickolay Goppen wrote:
> This includes:
>  * Add missing vote clock and GDSC to lpass_smmu

This is a separate fix
>  * Add FastRPC subnode with compute-cb subnodes to ADSP node

And this is a feature addon

please separate this into two commits

> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index a6a1933229b9..2764666714e6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1217,6 +1217,11 @@ lpass_smmu: iommu@5100000 {
>  			reg = <0x05100000 0x40000>;
>  			#iommu-cells = <1>;
>  
> +			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
> +			clock-names = "bus";
> +
> +			power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
> +
>  			#global-interrupts = <2>;
>  			interrupts =
>  				<GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> @@ -2337,6 +2342,39 @@ q6routing: routing {
>  						};
>  					};
>  				};
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					qcom,non-secure-domain;

I don't think this is valid for ADSP, +Srini please confirm

Konrad

