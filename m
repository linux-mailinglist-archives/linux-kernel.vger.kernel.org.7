Return-Path: <linux-kernel+bounces-838581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C254EBAF9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723BC166901
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118427B35B;
	Wed,  1 Oct 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lPY2n258"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF927AC31
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307385; cv=none; b=jm38sxSfI+4lv2rU3OMNnGqqAQIvn1wKXLxPEs1of+OSh0URTfhgReKDWEq5mZvuvuuAUoh7UIMMzkBeJuFBX006tjKUEA+UPY58eRNXoa+mWsTt9yMUhJD/FsAJQQ5hg91gcxjEe0mGpHb55H6T/Bts+MKQSVqkb0X1bAqKENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307385; c=relaxed/simple;
	bh=iqZxrMmOCUso30RFZ6gTRXsEmOGLnP6HtbNYPwF1Wfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HckTOO5alCpvU9H/4D/cRXlJQnw1EEcFFTV/fPU2TnC7KJLd73I0tV3FFDu35vDVSYSnp6KTYESJVQoTEcBUjAw1Hom0mu18sM/FnoEJQ7mIr4+v5t9w2f8K6iW2MjKewdUnHUJQNVXN4MwWthgK89xw6Lh6pD0VkG98jI/TLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lPY2n258; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917YusC012433
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A4bz1NnqQrT8sw5X8qWBPC30nWyB7EeMqsmSDdrK1ss=; b=lPY2n258l+FI9ZYs
	tQEPtA1Y7rKFvvhrDRtfR3xIn8CddVUsdPczxKYspN6l3bvWOFF0781+Gz6PW01C
	RRhoYGkpp+1p0aX82pS0nEh/4hBRYgGrhYLp8PBMh05/uAmf9PY9IHEkuiYkWmlg
	42IfkoT5d1lvWF+YGW3Q3ivi3MPORBtxePZ0AzB2j/cxJLt89/0XOuYjZ0yILENh
	RGHtVKvvi87G8CXUentc5KTtbmpIGiEGr5KrDe+V6u4S7qcADzKeS0st5tMQedqd
	xPz8ZIE72QYHnuPsB15cmqz4vd07TeUT/LTedkWXmu67dQmkxqlzC72RTgLdxLen
	oV+TNg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a63wm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:29:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e231785cc3so7118401cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307382; x=1759912182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4bz1NnqQrT8sw5X8qWBPC30nWyB7EeMqsmSDdrK1ss=;
        b=edxivHMEzIYrc3DNHKuhvFogHtE3J1LolugwkIlz8VmnmZEO3eKtLN2wa9YrfTSepd
         TU/RKK0HHX9f6amoUv6BtbGCmt4GiB1CnOQ5nNfyDf6TxS+60UG3sULMbr2k5fZVi4Az
         WKyY/7Ba+/XWdEYOaU6NuHUXGbiXCQUxU/sBSbAzvLNwl1tU0VJRdynxKZn3518zxLdR
         cjjmBJlmjqgoGqzXPlCznTW0fj7Eh5lXZ4cRSR9a5W79gXrS4+0zRtw529VaLNcDsAcg
         bqNYHbMj6Pu2vWdKJBa9kHoDefg/ruW5vgO4opK/Sz4pE85GGsLGoQBHWqTXfNxUWKzr
         Envw==
X-Forwarded-Encrypted: i=1; AJvYcCVfxaKduBPabR04Nl0nzj53iDsyhIOjMHCNoR+Q7h6KUsBaSZ1637FI7bHABNioCmyaWlyIFjQ+ifbsrMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySw6oFanPtYT3VGOLsS8ED1LVa/bEf9BYGawotthImnc5zZJa
	mHPEoGIGMCaWmhGbeiqUMgtjDzIHFlmRuF87rVdgHjoxFH+fVgBLhR4K0WnXpRvJYqZB29ZI9Ye
	CHDcvdDV5xkURLsuBHhpAo/6ps52T5IRKXsNGm7Dc6dmUAUas2PU3QLvUROrRqzF0+Yc=
X-Gm-Gg: ASbGncsPzVddoLwqHh3siuLfVLz04k0pd9yCQrZPl/lXk0BZr/Ax4Ie8IOenYz9K4WO
	IbTrC9MACgRpI3gOVRSiJr4Duq3SwikQj4xF0dIJu4pSzWsPg4RjB/RLCC+MyO/R5Mox36kYiEz
	yA5/LsgzP0BA+HXix7+So4cykVfrL8bLICJf6P6ryQNhRKFw4HaeGUdIGdTa5eC76l5N3U4c7eY
	SyiYvN2lEkoEuZTatanyMqiZ8nR05UOvvJa8Wcdx9WJMdeKTxUD5shEF2Qg8MMZx/WH/BqPR+rV
	rIi0cx1bu8U+9nXNh5nbBBkv9rP/r1oJB0IzbpfMVcnuBwhlSxuWVZEFYQPqJL75C13fQD9CVat
	y1vECsKutsn1vARt6Ed+XYveFO6k=
X-Received: by 2002:a05:622a:1444:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4e41db86a41mr22416181cf.9.1759307381790;
        Wed, 01 Oct 2025 01:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUqL1RsW5QiQi/riKCanq1p3YM18OkyHpHFi5otusy0fPMrF9AasNPUvKABfOrGjygx+Caw==
X-Received: by 2002:a05:622a:1444:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4e41db86a41mr22416031cf.9.1759307381329;
        Wed, 01 Oct 2025 01:29:41 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f87511dsm1323076766b.43.2025.10.01.01.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:29:39 -0700 (PDT)
Message-ID: <dfd4a03b-22ee-4ea0-af4c-9184a464cad5@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: qcm6490-shift-otter: Enable venus
 node
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-6-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-6-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dce676 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=Q9X1YL7jsAXwpJAzmCoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: cYpXgMlBARYnDh78GWYXOQ6uElGoE64I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX+4jgLGn+h8Al
 WvrHzibtvITl3lr29drdjubk0TuTHiI2RS8YQao06hAbA01ULaUNdrPXKGF5+AfZfTlvNFE1aop
 QdPuXwVDZ384wzgjS2BPAvSpnkqhk0EFJlj7d0Vm7CjPpBJZNJ3UXv2Mpg/Y6ADgc9FBiYXpFIa
 gg7A+1nzXjsULEkWLqXoPJnUMEpO5uMDurJDjXphTMHMdezdwSSiVu/cR1KJm2ouSWp/2fQKV2o
 Q1vaP7Q5XCyxzYKTF2QI0+OGhWBzgmoqsxzKBqzVS+qEZFBvQlt0XoMe8CRAVax9aaGr3Ebi5LA
 VEKEMT2ZxFrRODMFvlDqoLBHuW68evbNYWSaMAMh5w7IosW7L3Ybd0qSSK06bpkIVqyzscmMUUx
 8QoW3WtuuUwUF+f0WK4Fc1BpqmrSXw==
X-Proofpoint-ORIG-GUID: cYpXgMlBARYnDh78GWYXOQ6uElGoE64I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> Enable the venus node so that the video encoder/decoder will start
> working.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> index b4c69dc50ed0f0b3cb45341a01c89210bd261993..98c1ad4c21118831f079c83f4fe66ea30c141fac 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> @@ -995,6 +995,12 @@ &usb_dp_qmpphy_out {
>  	remote-endpoint = <&pmic_glink_ss_in>;
>  };
>  
> +&venus {
> +	firmware-name = "qcom/qcm6490/SHIFT/otter/venus.mbn";
> +
> +	status = "okay";
> +};

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

