Return-Path: <linux-kernel+bounces-750742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7FB1608B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A763AFADB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A594207A;
	Wed, 30 Jul 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PGoJrr4z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0A7E110
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879525; cv=none; b=iJd4db587f8lC+fac3wtZTKkIJwDLmveCLLwERwY3bh7vJlk/E2euKN3xptg8XwNPAy0RmACmNPODG1i/R7R21AfRgQZj+vfo+YHAw2hDcz65xAb9ebR55Lbj23oFLepz8Li0R5YmyAYFDe16PrACMG+OaCe23jWVP5Rl4pdlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879525; c=relaxed/simple;
	bh=eR/zuSmJZH0jf1czY0eWikoB4WjQbyO+so5KHHNY4fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WujX/+tDjud7h8z5Rr1Yu0V4swHJbniyfgP/AJi/cH+Zx6vpVmESLxkZHqmK9F2kKz32btRj5SGLBH9skyByxOEZJPNkPF3cVWKK9is+FRRVfbIjU6SkaB55URRhy51FNSgFMVvydnmCxsz3Q17yFHQFIvNNvOTdmCkx1wC8d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PGoJrr4z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb9dZ017607
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tGD7An+ORZOjh//giVMxSzmnuZTa775G5JSoHE0guvU=; b=PGoJrr4zHtCSTMPk
	m4+MGP3v7i8nvYY6l/IeF+O/VzXc/JOJkvDKxkB/WnwfCUMbbY+mQ/vtfeylc9+q
	GvDQMiv4Sl2WCjxQZSuOvTQQGE5nVD5AwxOTPBhakMxacyKtC+rGtNIqsEV8bLD4
	/6NEs+qZEnPJ9NbcgY6C5HtPpq1RzWlGRp/jCRVxDez8RGDUWKvmqHtiB03I2kQq
	Ac9owKDs8M8roGeVDkoI4YndtHPlFrFkLLqb14inLTFeN9RjNueWdOukdmpLof6V
	rc13k8IJO+/z4KUVlA+HGHma5Sus/CxAA/QH4HKno8Xkpj6zA5LTHNg+ASv7VzkV
	moBH/g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda3pbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:45:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-707641946ecso1934636d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879521; x=1754484321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGD7An+ORZOjh//giVMxSzmnuZTa775G5JSoHE0guvU=;
        b=M4+s9lxNgOjlIWn9Vf7V6s4PGJNPJSplN4Cm8ILyv4gBakDR0RdJ9tUhWwR6sYQl+s
         4dyyBYNU71uvd8lM6nuaj9gC7OVJJEQv2e1aWm/NfdjNg9YXEgSCL9etPuFfj410g0IG
         46I4iqRQLIobMoqCWZZ/LkYLuXUeCMK8rRgUEH5WKbnjrOqLxEr2EyLjZDB4TAv4Ya8U
         EaiZ7z00Jfmoy19JnULiFnpg33MQzwAATvrPUH/u4QfzvimG9QXR6ES4bJycMTWC8kj3
         KGILqhr6rB7EG4OsHLfA3uj6/M3OQanmsvSf8o9j77RbUY9EnwkmIP+qd7BgcFW/9/in
         MmLg==
X-Forwarded-Encrypted: i=1; AJvYcCXnH+VVGRjDHo5qT3J/wHI1IcJRSUKjZj1uQo7x9O0JnDEa+XXawoRpt/nJB43ws9/4ZjscRe4Qlq+XbmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObYZ4VcOZDO9Kj4/4m7074GYO4iAI2V7cPlty8MJ6a0zX0hb8
	d7LO95ucF3aUHhLE/RfNnxgRkg+Osfd4mqLjjI8pM4cFDwZ/tjAfRWUX15a82DLkon87G0yY3H3
	qowL7nFp44WxVp83ESO7vk0VXnRuqHcucKrBVMmpb1jwdeuWwvAhdr5JxPOrZC5pPA1M=
X-Gm-Gg: ASbGnctBu5xP9FuwOb6P7e8O0gNbrG7lIJcGP8TzKA2RfYiFj15Y2BNBPUNG2A9RiIP
	zvvOgvpB1etYX6qe+HBTmTITyfv1nxu6Xq2XYSioIqsLlSOP56/Ovnf7EjhQAOfVkk8S3apjyP9
	2Cu3i7Yn1F+ZcKchJ1u1sRvo2MoMVPIFSxFJc18n+0ZJ2oUStm0lkoIoyf+946CRdbAhuKikhSj
	5vF7+Fv5ILnhPUq86Rvrfmf20ZKlEIcC3EweIPITcZc4V29essRmCuNrLkZ2Q6ary9ZlbCL/Abu
	eyMfK+VR5UVXhbN2zHx5m3f3jP8jfvP+e3j4uzKNzeZo9iGp2WknVbUAwCsWqMJcip/UxI4f61h
	CzX8sZ7+CxWDfLUoGlA==
X-Received: by 2002:a05:620a:c55:b0:7e3:3c02:4c10 with SMTP id af79cd13be357-7e66f340dbemr204407485a.10.1753879521331;
        Wed, 30 Jul 2025 05:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdISRDnj4LdKwJnA5RwUTBCM101PtZrNYA6In3rDGQz1QjGYTyHcrpf0LJ3CYc1iz1Xdis+g==
X-Received: by 2002:a05:620a:c55:b0:7e3:3c02:4c10 with SMTP id af79cd13be357-7e66f340dbemr204403685a.10.1753879520804;
        Wed, 30 Jul 2025 05:45:20 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a669c8sm733134866b.72.2025.07.30.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:45:20 -0700 (PDT)
Message-ID: <74e3836e-af29-4b5f-b644-23bdff084c78@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: update the high bitfield of certain DSI
 registers
To: Ayushi Makhija <quic_amakhija@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: robdclark@gmail.com, lumag@kernel.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
References: <20250730123938.1038640-1-quic_amakhija@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730123938.1038640-1-quic_amakhija@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1ObQ63A1JDgcs96n14PW1sfzypm8_Vs-
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a13e2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=GqOxEGSAyoRmTf9NYtcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1ObQ63A1JDgcs96n14PW1sfzypm8_Vs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MSBTYWx0ZWRfX+8CiwEWl1YYJ
 kW1w1LDoUVu17p+x69vFKlnA+bQdRCk8z7M4MCCeQ7r+gGTv3piTkMcDpyvTGCtvpslwvfpjI0a
 3YU31uiCCt9GDggu8pVx41YhCT45CELmkcupVwiSvf+XL9dEnEkZeT0VUekQcR7OxYalSGaJ070
 BEfMUIJtth5Bb2dGveb7yc3OMtCTFZz38aUxrVcIeb0DkedEt32tmdm+XT3nJzg42cmrzN3h4q+
 PPZ5R5zIhvN0IMFq0ZpuI6Rx53Pbe2iR5fdovgQoAmnCLD/W4G6v9f2r09w51ZmS7mFyu561CGP
 PemdjtghKtshcTKkguCupx06V8QewUE9+hvIE1ezbvFNmyZ00Sln/+7JcxxfvUqGs6XK5z1gdL7
 lx1AnH2ePexENFlM9wFZIAUrbwO6w5wFVPbUgvEGv3L23GnKveSEa/Wz3fdu/vezurV8vi6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=920 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300091

On 7/30/25 2:39 PM, Ayushi Makhija wrote:
> Currently, the high bitfield of certain DSI registers
> do not align with the configuration of the SWI registers
> description. This can lead to wrong programming these DSI
> registers, for example for 4k resloution where H_TOTAL is
> taking 13 bits but software is programming only 12 bits
> because of the incorrect bitmask for H_TOTAL bitfeild,
> this is causing DSI FIFO errors. To resolve this issue,
> increase the high bitfield of the DSI registers from 12 bits
> to 16 bits in dsi.xml to match the SWI register configuration.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/registers/display/dsi.xml | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/registers/display/dsi.xml b/drivers/gpu/drm/msm/registers/display/dsi.xml
> index 501ffc585a9f..c7a7b633d747 100644
> --- a/drivers/gpu/drm/msm/registers/display/dsi.xml
> +++ b/drivers/gpu/drm/msm/registers/display/dsi.xml
> @@ -159,28 +159,28 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
>  		<bitfield name="RGB_SWAP" low="12" high="14" type="dsi_rgb_swap"/>
>  	</reg32>
>  	<reg32 offset="0x00020" name="ACTIVE_H">
> -		<bitfield name="START" low="0" high="11" type="uint"/>
> -		<bitfield name="END" low="16" high="27" type="uint"/>
> +		<bitfield name="START" low="0" high="15" type="uint"/>
> +		<bitfield name="END" low="16" high="31" type="uint"/>
>  	</reg32>
>  	<reg32 offset="0x00024" name="ACTIVE_V">
> -		<bitfield name="START" low="0" high="11" type="uint"/>
> -		<bitfield name="END" low="16" high="27" type="uint"/>
> +		<bitfield name="START" low="0" high="15" type="uint"/>
> +		<bitfield name="END" low="16" high="31" type="uint"/>
>  	</reg32>
>  	<reg32 offset="0x00028" name="TOTAL">
> -		<bitfield name="H_TOTAL" low="0" high="11" type="uint"/>
> -		<bitfield name="V_TOTAL" low="16" high="27" type="uint"/>
> +		<bitfield name="H_TOTAL" low="0" high="15" type="uint"/>
> +		<bitfield name="V_TOTAL" low="16" high="31" type="uint"/>
>  	</reg32>
>  	<reg32 offset="0x0002c" name="ACTIVE_HSYNC">
> -		<bitfield name="START" low="0" high="11" type="uint"/>
> -		<bitfield name="END" low="16" high="27" type="uint"/>
> +		<bitfield name="START" low="0" high="15" type="uint"/>
> +		<bitfield name="END" low="16" high="31" type="uint"/>
>  	</reg32>
>  	<reg32 offset="0x00030" name="ACTIVE_VSYNC_HPOS">
> -		<bitfield name="START" low="0" high="11" type="uint"/>
> -		<bitfield name="END" low="16" high="27" type="uint"/>
> +		<bitfield name="START" low="0" high="15" type="uint"/>
> +		<bitfield name="END" low="16" high="31" type="uint"/>
>  	</reg32>
>  	<reg32 offset="0x00034" name="ACTIVE_VSYNC_VPOS">

FWIW looks like at least on 8280, ACTIVE_VSYNC_HPOS offset = 0x38
and HPOS doesn't exist

Konrad

