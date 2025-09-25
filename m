Return-Path: <linux-kernel+bounces-832041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69AB9E366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26316383CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2DD2DF3F2;
	Thu, 25 Sep 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pcpo4Dcm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C81279907
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791422; cv=none; b=ra4na+nVmEEmB7wRJq2cKC0Q/I2E24erk8WgInwG1ZavtXptIlaaxqKLvOYYZ4pFKyOe5vpeVPiwhN46S8NaTxhSDUrpsrCQAfq5lLJMIYeo++eV/+BWYzF7wNt2it80F7JFVI+MZgtvJ15AU3v7U8ac/kSLHRAr8vBxk5mTMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791422; c=relaxed/simple;
	bh=VaO3i7T1b7yOwRkFlMNKwsdMGDTOTdR9OM8uKc1xL/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCWTSQgbgql/vufZyoZy47eGPZgi4yJtakhlEYpQiWfINWdcNINPOx1He9y1akaeto/ZN6ydHj2yuoPqMvLanZLqRUqXixj+D4335om8+eDLO2SLVQ8SuO5tEBxaGre8TMesxRB/YwLZD6dkK1yXNXpznFxLG/RPtui7cQcmo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pcpo4Dcm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1OPkt029604
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eYZzVW9nVW8KA6tqECyGN+RNlHNLZrOF+4bwFfwCiLE=; b=Pcpo4DcmW+oDY+r+
	rZDyKMfWtqOYmhDD+enL9K3uf+OTqlFyAXN/08CmPZ3ClsBOpmOvqZYc2iq9jzh+
	ZNZfVXyO3GFnzRhVce+wuD/Vi7/nu1KcCHDXjAU4+T+Mp2XXuEpf/CV+ajux7p3D
	/nQW/mMp7q7mXkLksJUAlDZncJak4r6Vf/neAeWxxctL6Jx6VRqBRgMGxgWTd4V7
	r8P2lldig94Y5NjiLSbYD6CxB49v2JzmeKngy8C9KKJD11te01a4oMGirqXLoir7
	8sWfk/7Zs8ZAcisVSWptv7S0ItJSbiOGBVD7kesJwCflFdYvGBABAZ0s3aKQHwzb
	D0F46w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqd35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:10:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85e95d986e2so580185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791412; x=1759396212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYZzVW9nVW8KA6tqECyGN+RNlHNLZrOF+4bwFfwCiLE=;
        b=kAMCjrurXwkOOc7AveR5et+H74TdKeb/PM1ymxy8LhYHEQL3sluEQHf1aGZ3LhC2uc
         zB2Ci5O2wx/HapzwXZPkAe8ZxrJuZXhrPkeSN8t0F89Y1UKBkdDkgJ6RoRv/QpmFiQ1N
         LfkCPSoehuTXyiPvfOStqL9S/ez5O4ixw+G7BoHQDREMxoRu4nr+9SfC7aL/EWcf3zcN
         xmQnJDWoqXPncnReLfdoMR5gvchsaZzV8hWVWbFaoXP07JUiaEzfsEWdmZ0g6fD7eCy2
         zBWUH5hzKg92S6fiKnmbS3HZ+aqF73Vtx97aZhp6XzQq3fiU9X7Pk4G6jvTs76GaeWqK
         EXjw==
X-Forwarded-Encrypted: i=1; AJvYcCVMa7B0iu4W2xtx8snvWF94H1kEVIVyUvJs5LYKdnX2X49vybXuDbSpcjGONKK6179job7wzCN2ar1ncXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJchFNs3lthyvg7yV7W7POepG+GPW43HHu5sc3Uyw6mRO6vxHn
	yt8FVw40t1qz96ws+BZygGdzJkdZ9J461xfq4L5wMB7IezKAPv1Qu90pT3GnIjS8ImseXVFvxAg
	1t7PRhIv8eBdN/ue6k5KLWjiK7Iym17flP6MY2BV9dF4Z0j0y4LoTeTIVVjArEVn2gk4=
X-Gm-Gg: ASbGncspcPiEh2AmHp79VL9CJlKc6hYXG/y6xlnEAe0eBjH9+QP0N5nomELEDZQTYKb
	/u4zw1IzAk/CZPb1N67TNztC62dEBvxnUbsvbNv7/sbMhArpwhsTze5E/PvMHDuVki45jql9IPu
	KDDSzuO7y5hVQ9vQhCzcrqYLMVc6GYZHxg+Nb8dQlwouNV1gSdxdaWgczhePk9Z9Kyo6uDGwzWY
	6EOunHfzIvbDtmjCsm69Fgt5qVYV21yz6p9DhSdevsfB9Ote/eY3mcFdyzremiSfF4nR8kENRca
	2MLyMTZetooqK9f0PWa8yDLb5WuoCO6sf8+CKLzFYKK4SH6uFrzUqc2RbtXRsiawJ3rpf0obfVa
	MU0irIJVelp98bgyV9DlXaw==
X-Received: by 2002:a05:620a:1a0f:b0:827:52b2:42be with SMTP id af79cd13be357-85adf5d2741mr246322485a.1.1758791411986;
        Thu, 25 Sep 2025 02:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADNWi8FxPoW2rbFkEpU+q5ie6LXLacUuiyEXFSNUKEa5yYt7K4AF5EOvbsvCoObZuswbrig==
X-Received: by 2002:a05:620a:1a0f:b0:827:52b2:42be with SMTP id af79cd13be357-85adf5d2741mr246319685a.1.1758791411237;
        Thu, 25 Sep 2025 02:10:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65a62sm126307366b.47.2025.09.25.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:10:10 -0700 (PDT)
Message-ID: <ab28a715-6b5e-4adc-8889-f47ee2e18d5c@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yL0jsR4e-CEHk4sFZwIUKPQvSu0ka65o
X-Proofpoint-GUID: yL0jsR4e-CEHk4sFZwIUKPQvSu0ka65o
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d506fa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=-FEiAWMsPlssRVfEe-4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX5zZn/P2JnnM/
 J5RkpKpE38+OjuyXUcT2y3PmPFrqTN2ufCZbWLcTqN/mYS5XiwfNa/K3Xgg8vbzdhNJ7RLJuJSZ
 QtP3QK8cxotHOD+rklne0X9NrmBPGXcrxxWA0bKMKAYSuWbf0va1j8Db7Xtr+h4djJhz78T0u7b
 9lBeDPRkMBapIwshjxn3L5G+Hx5b+l+s6FfhaoN9hodZGXP4bjzJGAm3iwz5GEHq9V2VS+1FRD9
 6BdNlfIQ2BXTQJODvJbRpc8I6HfBQ5WiAtU/fvW11aP9XTWdOXbdouXtxKZCR92UHrUtiUCHNkV
 HS5KN0J8Bkmly87wRpg5+jlEZ1/gsieblzTlA8IMomGI9ktObwEz5swbJnIOi/YlO3q+DtoSzaD
 uOr4Jdu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/25/25 1:14 AM, Vikash Garodia wrote:
> Some of vpu4 register defines are common with vpu3x. Move those into the
> common register defines header. This is done to reuse the defines for
> vpu4 in subsequent patch which enables the power sequence for vpu4.
> 
> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
>  .../platform/qcom/iris/iris_vpu_register_defines.h | 29 +++++++++++++++++

This is a slippery slope. I think it's better if you explicitly say
the header file contains the register map of VPU3 instead, as let's say
VPU5 may add a random register in the middle (pushing some existing ones
+0x4 down). Such changes are annoying to debug, and we've unfortunately
been there on Adreno..

Because you're using this for a single common function that is both acting
upon the same registers and performing the same operations on them across
VPU35 and VPU4, it's okay to de-static-ize the function from iris_vpu3.c and
refer to it from vpu4 ops, keeping the register map private to the former
file which I think will end up less error-prone for the future.

Konrad

