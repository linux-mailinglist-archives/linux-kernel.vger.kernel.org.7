Return-Path: <linux-kernel+bounces-832023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3CB9E29D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E634E2BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16D27A460;
	Thu, 25 Sep 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HX01tzQg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDB27586B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790815; cv=none; b=kRWqRIh7JphheqZkfMyLXU6vU6yZAtNCYUVEIoLD5ZEVHbrcL4aRfc5BnpK/nWXi9ZffvFLVNHYmKmJEW/go/NT3TThjI1a69aBqJFRvb1Ta93jaKioPG2ZQfQWBVby/Z8PPhqOU7JwKrkDdHZVD5U3hkDTN/yPv379440m+8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790815; c=relaxed/simple;
	bh=xBVWxRrKQUXvM0i9+aAurwMoSPvugsmmUwI8wwwCFAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LacQWu51fmXNrTrdGUYqYP5gS5G2b1zkhVC3SC0zY9vpGA04z60It3Ta+qFDUbAfDAVeW4NH8BfBoZq19h7l6BeazPkIh9JGoNe9tVm3fz8hSK5wx9FuTZXpH3M5jg1I+uwAwcAQbQYHVix3nTT+sA6iAgiKnjDuuLpkI/5CwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HX01tzQg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0opB8002792
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NanOuqfcVHSh1yGypDKoQ9iNS3HSzo+7sV5Au+ABCI=; b=HX01tzQgkeMYqdqp
	dQUzgmBAN2BoftCTKUKZLEx0Y6uKQKKjwp2QlH8dDOp3b0dRT6a+mmDUkJTQbsjw
	XolYAKOSURgSvRV1yhvVS5Y8F8D0HRfsJnFYn6gNyIbzZEa6rfyTdgdADr91cUTt
	2opAUH16e2/eiJl79PmB2h3tHhPm7L0+1tF4FzYiiDoQ6DsF6YC7A7h0VkzqR5BB
	/t6xiDGV91Znu1cGfgagFtJsTd0dRq8Ef7VyqdLkykcn0EmF7i6Ve4c7rMNALagz
	MKuAmYy+5/fPpWOvSYoSmkMLXtEvMt2f111X+qSRNSTI+nVjDdkgSfHDxndHpX3Y
	RiHVCQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf20p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:00:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d88b669938so1559611cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790804; x=1759395604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NanOuqfcVHSh1yGypDKoQ9iNS3HSzo+7sV5Au+ABCI=;
        b=PPMc73DrfKTsmqhDL/ZHvIsR34RKxLbsqtxHnrWYboN+P1J39Xxj0ga8wiKmLZPfsa
         R95yBu764VIq+ZRk26UWbh6x1B/RmCnnKYbI4QQxSKJRwfCJGfc4B/T7F4bij6Qs6CE9
         y3HlJX0PYTZu4XtwK4IFNI9+777xc+CvMvo4pvUveNPK5Jwgy+fv1gbayzw6Jx2/95WQ
         tvpoDaBDF55jsNTxNzD1+J0QaArOayPwjEyBOFZPDVLah1dWFnIy9XD2GNWKKr2kuEGI
         dCCg9uoZ26nd72KiKVJ4IPD3iEKnBtmsVyzGI79eVV7csXRjx5TIJ/nak62bE3YsBj0J
         iG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfRhj3gQ9O2Ekfy4sGxVr59rjnUVlPLj98/lHgEEO6mMRL1ys2N4tz0DxTFYvQ0pIYGy/F18iVzD05/KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRnuc1BycmkW6fZRaV9xDLUb0GYAD0HC4Jf+0TKRA3j5zvfT8
	lcMifNHHPaLAWwY2RRsNIINQlyv6XwV5ucnftoHE8az2niuSTGaJiaa2E5gfULtzjS0wtMsX3FF
	qfZb9RnIfifRLgDIKw6svwlVlpPfkLRDAB4gRR7+1DVJCsceR/BOwd/tVvmEFGCNfQak=
X-Gm-Gg: ASbGnctf0TWRcfVHjpYoqWFzD8JpJO+jqhu11iYX5vhjkK1wpHX2cI7C/ebFb7r7tGv
	RNTJ9hmpkkKvHxl2kom2yAWa85APrXPUBi8j98E6AhlMuC6A2gjmOpi6yVUXGbiU5DN/UH5SxAL
	9venmpbpKP+hVS27I4NBmtJ8lEtG+XlYXB3yLz2eaHoPJYOszIfIf0pRZkxXQiNsFtFz+915c2C
	i8/fWxBYUXua7WSb//e3/RwpTwJ4mi28ZA1bYShuD86lEhAGA9upJiQgfjo/Rk5eg1gZwWuXTjb
	jTZJjXNlNln634YpqbHV5trzwD3Pdx6Ea2dbPNV6PJIwoE7R1ife2tj+wZzCVpEd2mqatwzxZVh
	QHQJ4nc5PgdarhElXIUrfqQ==
X-Received: by 2002:a05:622a:1905:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4da47c0cf8emr26077041cf.3.1758790803530;
        Thu, 25 Sep 2025 02:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIDMuVkqRV8Z/VXyflZmrCENWFMJw2jxob4qmvTixZ0jpMmD0v+KXFqVOY7vWuj/loeIisxg==
X-Received: by 2002:a05:622a:1905:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4da47c0cf8emr26076651cf.3.1758790802838;
        Thu, 25 Sep 2025 02:00:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d014csm123421966b.19.2025.09.25.02.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:00:02 -0700 (PDT)
Message-ID: <888e0d4a-ee44-4b09-8dba-2e0b282c205c@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 10:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-1-e323c0b3c0cd@oss.qualcomm.com>
 <vqzon3svfqvk3poz76jm5x5gf4rd6vkygegonafcprmkejt4aq@5kwlwytg3ulk>
 <1af0d19e-30e0-1260-877c-5d6027c3d297@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1af0d19e-30e0-1260-877c-5d6027c3d297@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _JiSepYFYl3-VlaECLy-Uu6FENZrC0n-
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d5049d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=w5tCh-kKjUeJ5JU2OSEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX38yxJq8Y8zEk
 SEPVcpp2yql6n9zwVkpusRCwYdrAFV1/e6wX0Q5cMc3Ll9VgXPQmVFYmFtL/BK2y4eUkjwhwJJR
 iCOIPU0GXKPJXhPJ6h57aqrOT5bWiKvYiZNhfSVVCaA51h6D+wOHiyP946T9Vay3U7sCQg5esqs
 g0akDvIBg8mwqNlWZj08d0dkb5KtxqYsvmgFQSoECwZeINp7l2kZKVMHvObcVkeKWX2NP9s4tlO
 QkuTW25YT80lJIbNei1Pl4wy1V2wUQF/XRM8TW9iHiU4AS+kLqttar/5LRdxrjFu3MkN/i6D6/a
 ILLEGvdErRbelidvZBUgLXhl+Tytw1k7zOOfEukIsfwg9rtaxa1J1QTGcLzHaBi1+1p3CJNe3mK
 Gbj4FCFg
X-Proofpoint-ORIG-GUID: _JiSepYFYl3-VlaECLy-Uu6FENZrC0n-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 9/25/25 9:57 AM, Vikash Garodia wrote:
> 
> On 9/25/2025 8:36 AM, Dmitry Baryshkov wrote:
>> On Thu, Sep 25, 2025 at 04:44:39AM +0530, Vikash Garodia wrote:
>>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>>> compared to previous generation, iris3x, it has,
>>> - separate power domains for stream and pixel processing hardware blocks
>>>   (bse and vpp).
>>> - additional power domain for apv codec.
>>> - power domains for individual pipes (VPPx).
>>> - different clocks and reset lines.
>>>
>>> There are variants of this hardware, where only a single VPP pipe would
>>> be functional (VPP0), and APV may not be present. In such case, the
>>> hardware can be enabled without those 2 related power doamins, and
>>> corresponding clocks. This explains the min entries for power domains
>>> and clocks.
>>> Iommus include all the different stream-ids which can be possibly
>>> generated by vpu4 video hardware in both secure and non secure
>>> execution mode.
>>>
>>> This patch depends on following patches
>>> https://lore.kernel.org/all/20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com/
>>> https://lore.kernel.org/all/20250924-knp-clk-v1-3-29b02b818782@oss.qualcomm.com/
>>
>> This doesn't belong to the commit message. But you also can drop this
>> dependency alltogether. Could you please do it?
> 
> Sure, i see below works good w.r.t schema and dtb checker. Please review and
> confirm.

lgtm, you can also drop the interconnect header (i think you don't
need any rpmhpd additions so it can stay - potayto/potahto)

Konrad

> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> index f3528d514fe2..537e8d627a72 100644
> --- a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> @@ -106,9 +106,7 @@ unevaluatedProperties: false
> 
> examples:
>    - |
> -    #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
>      #include <dt-bindings/interconnect/qcom,icc.h>
>      #include <dt-bindings/power/qcom,rpmhpd.h>
> 
> @@ -136,10 +134,10 @@ examples:
> 
>        operating-points-v2 = <&iris_opp_table>;
> 
> -      clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
> +      clocks = <&gcc_video_axi0_clk>,
> <&video_cc_mvs0c_clk>,
> <&video_cc_mvs0_clk>,
> -               <&gcc GCC_VIDEO_AXI1_CLK>,
> +               <&gcc_video_axi1_clk>,
> <&video_cc_mvs0c_freerun_clk>,
> <&video_cc_mvs0_freerun_clk>,
> <&video_cc_mvs0b_clk>,
> @@ -157,17 +155,15 @@ examples:
>                      "vcodec_vpp1",
>                      "vcodec_apv";
> 
> -      interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> -                       &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
> -                      <&mmss_noc MASTER_VIDEO_MVP QCOM_ICC_TAG_ALWAYS
> -                       &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +      interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
> +                      <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
>        interconnect-names = "cpu-cfg",
>                             "video-mem";
> 
>        memory-region = <&video_mem>;
> 
> -      resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
> -               <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
> +      resets = <&gcc_video_axi0_clk_ares>,
> +               <&gcc_video_axi1_clk_ares>,
> 
> Regards,
> Vikash
> 

