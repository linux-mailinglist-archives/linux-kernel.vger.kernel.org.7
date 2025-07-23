Return-Path: <linux-kernel+bounces-742586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEAB0F40D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0FC96446C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127272E7F09;
	Wed, 23 Jul 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZZFAwk9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AE2E7198
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277572; cv=none; b=IKoC5/KqhB0ufzxqKZTlgqUbmC5FEUVXNtpxIcuIt7vFBkcI7B8It2dwoEptIUurdVsmVPBu7ZxNXTDA+Dw9KWx94HP2abB1mXrS5HYlsyK5DsZs1t/7VPAB4uxu/ufvilyRcZIpy93//M7RHjcYXNmcogzBi9vWvfWlFhDaoz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277572; c=relaxed/simple;
	bh=2o+FXdT30xXgM0glTbZ0pQJ0LGMm8P3vxwge4l4APfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oDPo2LEVwwnbe/URomtdP7Z7/+tC+WIwph9+iKaYL35w2t6uRogfTXMpBrqfj4Y7JsimeUl3hxCdcYD6wnEtPrVpclxnYyzIRybD/KWrWAPeRu+IlxJoyQ76NFKRVeC0vXSW7Gulq4bw1rM2uqFfJgZJaFcQQ4KQnq6EK/xApTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZZFAwk9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9WFLJ011562
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	912BbCs1duhO3s+V1a0ndyvsqj38sc4RhanjQ0G1f2o=; b=BZZFAwk9a+7H7qk1
	xMP0ZOEsX2ncf5QA3GkO+DoheS8p/Xon/reY1Da/eshXSFLWxcUt/OV/lizGLGeo
	E54qnYe6YTmsoqmyTu5fHAQeFGYATat9arSgBrxEuMQzNj2jmQCEjTuDyVQVtCJt
	BvsQmtgta2Tt9ZXnR2UDVPD5Cx0sNL/MPeTPNgMqXgF8RYKawsVzgK+WEdPeMVtY
	HTmy01R00AVhERjCW0mfCcZmvcRmTb7Naxakf7K3wuo7wsiLvun8nmZwHTkIBhOK
	FcQZMm3V2Vnwr4773TbGHi7R+xN99N1IhQOnpNvK6UHaCERkfgZfdwMxzX64F7vJ
	9AsqiA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qd9an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb030f541bso16155566d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277569; x=1753882369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=912BbCs1duhO3s+V1a0ndyvsqj38sc4RhanjQ0G1f2o=;
        b=ndl0yYFJiG0PaqQIKg4b8/o2C4uDs+6ibvQ0+K8pJ/6oKQppKuM0LbAsAiXwadUThL
         fPOJrdHFcJ9bMcmAx3EP9ab4CnQeBUCtB5CKqhW9K34ByFD4OXzFuDGRBlzTq6iaYsSw
         OPQu+shZXgYY4xxhzx6UMHDhUQIyLMfkih2ueJdh+Fq9u3O871BTL/60lxbo9SFYgLjo
         B4druT/hEau457cgBKSSWFEtP9rvghiDbiRman2lZTJxg7RdoHfxcMtfxZTv0HotYfLY
         3e5PBGHtdqnOS+jlfzvyZMKI9hRF3xQV5rvmaW5Vphyr+s7QH3g+/pvjhGPZ/yHn2tkQ
         KIfw==
X-Forwarded-Encrypted: i=1; AJvYcCWrU51lTp0IsUqjSFs3dDTMLvflxJok3/uhYDkDaW/gzCNAIzyMcB5h+4rQjJMCt/BdG9eCffUxfOMyqGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ0/g+Ck75QjBtW9OHW4/pqesdCBA6Hd5CExMDRCFanRPskgF
	UMAcXN1U6/+Gj3o2g4o8yyhAwHXRK0JqLqjEZCBvhgigqsLBNMXtHlh+gUthFNftQWjq9bqWXeT
	Hu28ZmmOtyOxex9H22xIcmZ9cr31auySwxWp+VRmHHlBQpEHNUXA1rEM6S8jeCIlTaB4P4Nsuvj
	Y=
X-Gm-Gg: ASbGncsGWjVZb/8lMb4MYTy7RPCBDTSFt8LxniPNRqWpIHb67f2ZGEjJpNxMa7s1IpL
	9X+i3G0JO/QISZr22EOi2lKapQPLsEnWaekWITtDnwQ9+wUiEEqbE4eybJJ3mceWhsI7JCx/lkl
	HnCn5ys2Ip6g9CxZzrsV8ZaPqMHvIc7ZYMVsPQNPLmGhU2tzNdnef/cBj9/zIhzcG1TWiCY598v
	s1XTLfOJzKwHRB+rqt6eywQxk3OktDVxesFmtPAap5ItEB2IX6IcBg0gzokATWtlOtkkJNmxtcP
	qCS/UubJ/2FJDJgFkEh5oc3Hr0vYCj89OLlSmMq8uxa5jq6usbgRRB72F/6ovFWLTVLp0ELZ54s
	vgSfC9s1SrXisrdVh3Q==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124516485a.13.1753277568640;
        Wed, 23 Jul 2025 06:32:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUeU5pu5DYMS+wgbInyCg7rQVUxQG2KcGpfh8b1CBhLL7zRzD/MTKzrABkk8bm84AzEwg6A==
X-Received: by 2002:a05:620a:48e:b0:7e3:3c61:564a with SMTP id af79cd13be357-7e62a1da96amr124513785a.13.1753277567973;
        Wed, 23 Jul 2025 06:32:47 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad64f0sm1048517666b.148.2025.07.23.06.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:32:47 -0700 (PDT)
Message-ID: <4b8e0bd3-612a-4ef9-a844-08791ed1b8d0@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: pm_helpers: add fallback for the opp-table
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Renjiang Han <quic_renjiang@quicinc.com>, quic_qiweil@quicinc.com,
        quic_wangaow@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com>
 <ffac121b-ba15-4384-8961-2661f9748d2f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ffac121b-ba15-4384-8961-2661f9748d2f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX9w2vJ/bAVIji
 ItJn1t1uE+Z/teN6MJZ+M01sQdZj6S4DlGMMwF5F6yJSAaUAA1HSLkG3f9pxwCim2BWJXaVg6Nh
 c4FM+nBSBawCey6FoR7gFniFzEHQbswIHGKmdPXQEygYx/RYl7BIkDKZoV6cFxsNjBR+fFJp5wP
 INeAaAxma+d/ELUtBi2BctCnu8k7il78a+gksh1b60VPVzNjrvyQLNCV4gQWQwKYcbCkXJiYodJ
 0v446kLDa22ia5bO8/+hWEbFBAPo77+FRn9s+OAswuJwYzdA6GhxIw4q4r6zp21bYFrsbj6tmOM
 VjUjm4mU+W9v8yT8IjJcARtQs9buoFHgypsa7u98oeDLTmP553jQQSWgj07/mLF9ouLHybFISe1
 njsYKOl0KLz0dpsuR00qMsPAJmk4v0DeSBsI2AEscdrSVIgkTy6kvMedqcRhFRT0NV8aA8hy
X-Proofpoint-ORIG-GUID: bBOADdfJxT-aeUnO6Hp1ZZqOxOYm_44m
X-Proofpoint-GUID: bBOADdfJxT-aeUnO6Hp1ZZqOxOYm_44m
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880e481 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=Gq9SLu5374Em_OP27MgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230116

On 7/23/25 3:30 PM, Konrad Dybcio wrote:
> On 7/23/25 2:56 PM, Renjiang Han wrote:
>> Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
>> do not include an opp-table and have not configured opp-pmdomain, they
>> still need to use the frequencies defined in the driver's freq_tbl.
>>
>> Both core_power_v1 and core_power_v4 functions require core_clks_enable
>> function during POWER_ON. Therefore, in the core_clks_enable function,
>> if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
>> it needs to fall back to the freq_tbl to retrieve the frequency.
>>
>> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
>> ---
>> Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
>> contain an opp-table and have not configured opp-pmdomain, they still
>> need to use the frequencies defined in the driver's freq_tbl.
>>
>> Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
>> fails in the core_clks_enable, it needs to fall back to the freq_tbl to
>> retrieve the frequency.
>>
>> Validated this series on QCS615 and msm8916.
>> ---
> 
> This is not a proper fix, the logic you added in core_get_v4() should
> be moved to a common handler

Well, it is a proper fix in the sense that it makes things work, but
you're expanding the delta between the power handling across generations,
even though it's almost the same.. I submitted a series to clean it up
once, but it didn't go anywhere

https://lore.kernel.org/linux-arm-msm/20230911-topic-mars-v3-0-79f23b81c261@linaro.org/

Konrad

