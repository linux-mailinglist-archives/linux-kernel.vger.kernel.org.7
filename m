Return-Path: <linux-kernel+bounces-861093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B69BF1C62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DDF18A72A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE51322A1C;
	Mon, 20 Oct 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJUZLJik"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417B321442
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969725; cv=none; b=kSvEHH4wQiO/yF9OF8ypH1kPHpHEFyhoaOzhhzjTjRRb7LQLNUeJRY6oogYnS9KI56btt+04e3GrI09IPXpyXT5DycnKdG+iUTlxOg3qqySfHYLqgaMQOtG+cBu6hT92rJNe3keEK844AUoPHhD76BpuDbQzvc1oA9iT3N2xJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969725; c=relaxed/simple;
	bh=pclgVt1NaQFTZ+cJhZ1SnUnca/hbnaHZrZfaIkyjQ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCwBkaGhu7lEWVUKvOfx1S3xKjiRj8preAjGNcOS0OqtC2GxlGwunkFCtw97w8pTYGMQm00fbnGwcigkXE280OwxbnJvD/MEM6+vf1JtllCJXT91h3E2pe6VgtozOdMKhVChtKKSk9HQCtI4lA4SBBSAswVr/mF5xK/eP6v5yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJUZLJik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBo2kh008133
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDmy2GELi7gtK/8jzxwGBbx8R1YBxICNIb8VNFsE1t4=; b=PJUZLJikmWQP3BlF
	519kMTMz74gHVVnCpksl8pQUEKNqaYAYhqquCzDaIwYoi1bL1Nl/2mKVdCQDg27+
	skeVLrdlFK9D3ZsItTdTKGMjYQGX3W3I+7e6DURs3uLlSJELCdnDKAg1fwrwL6PU
	MI0ss15A6EXJtv5Pvk3kxyg/EPbBhGQTq7H9Fx7cRd4NJWIPsD2GX+Ii6kceXBOA
	7f3R9REKSTyyqqC8t8mqLYQ0FAXz56YAHOePkbokpvLVOEeiFwt4bBkudJLTZOjb
	EVu6y3l92CHT6xQppMYSSu9Wl+RDhyJgz0SPJ7xw6T9TvSsTHK6kh4HsP9Qc1pYp
	blQmCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343w0fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:15:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88e965f2bbfso196376485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969722; x=1761574522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDmy2GELi7gtK/8jzxwGBbx8R1YBxICNIb8VNFsE1t4=;
        b=XdKkYR+kzohfjHCNrdNkl3PX7U06w1eWE06706JadAOQzCBNNR82s8f6PNDoaJ+ZSY
         r0bSrx4Ft9rU+pgELV1VX6aAcFWPB7uajm+5foEJW2C0zLW0CxfdtYzt1+BOqv5A02uV
         omUAgLDPjpPbuYWahIvKFgVvvhdMG/XUXvzkP+ZHAjQnICFEA2IO+6e9S41JMXOUcazD
         fQ2zCkOY0cwSFPS2y4qXD75aGVz5PNnJC8Ms4qDEqFHJ3pCWT5fkNGkP76g3q2Mt+Eg3
         MD20oWClP51oDGssKXUu2knatMPYSgmKuJ9znHWMZLUED4BBnfw05zbQjTOY9horxKYJ
         LuUw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4ajlSv000UVA+Y+zIy7fEbRpmp5R5x4Cgkw8TrzZYybxWPEysgHjJYq9SjZ8k2FbzK3VWJfcd3ldTsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXGIEwI/kWrkgjpqXNYK3nwdxcJD9MU3zb4fZLBGouB7WzmWj
	vbcFzOFgPmfFN0y1hGtdougLc1Ml3bIo9U3LQH2FumM+PwZLKs7ttOUjpv0qAWQwDIf0E+xD9VI
	CUYxSVPqE3+6fpTg8dMhVX9eq4/Q5nfdAQoNH8Tghr2ncDqiLjcRdOrSIcDValPAGssU=
X-Gm-Gg: ASbGnctqRcjS5w+6M5Ktsqv+IFLPShVnWUt1YmxgdzbuyvNy1z/OLhJvZsIkdGo7PbR
	inRQVgBZoNlcEcx7H3FoLxosKUBE84OtjXc/Bo6xJEenQ+2RNF/rSSlPibaYojk2ow6SwCaHX6O
	Um922T1J9RmmbdZHl9VRj4U9qXyZm9aDkK0WB0zPx99wLT5cr2jZX8ch95oLs6HgrMvyjHiloFC
	cXLc0vwi+FNIWDmMq4ZOQSUZxPF7nCD7OIvO3gxc0Ja8of0Pi8eVpFnEoatGB/Ec8K7foEtGuYm
	r39dO938xuNlN4NwPqMImX27wOnCxiIYgg4ZRZohXM1y9MqZsVHagrhJL6NOJY/0t6e9rDg8uxn
	Zvh6qfVDB6kfdLgEwkJbBLVfAgqSvG1MGN8CTyHuptbyHudjlgogB+hTY
X-Received: by 2002:a05:622a:430c:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4e89ed27b1amr70538611cf.1.1760969721853;
        Mon, 20 Oct 2025 07:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgFJIAqpM19kvrDWGwCuBgqCdJgurbW+8pv+OyXQ/fhgIZbl4A99RK4rC5R2fhCALO5DvG/g==
X-Received: by 2002:a05:622a:430c:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4e89ed27b1amr70538361cf.1.1760969721351;
        Mon, 20 Oct 2025 07:15:21 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm6749303a12.41.2025.10.20.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:15:20 -0700 (PDT)
Message-ID: <88f04334-8d73-4ced-9c46-e69c3e6cbc72@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 16:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <1b783a60-39c7-49b5-8932-e77230f6cddd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1b783a60-39c7-49b5-8932-e77230f6cddd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7Um3rqMhwLx_U8HabsbbmsZeZB6DKOg9
X-Proofpoint-ORIG-GUID: 7Um3rqMhwLx_U8HabsbbmsZeZB6DKOg9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7p1SWowsGz0v
 EGmBhir4NeNIyfGACbPOVIKQB5DBENRT0ZYKU+cT2K7rKA6DZRwwda/YBgkhgDayskAD1C3zU6i
 +uZJIQ/TohPKo64ikvgH3fLiKjPjHXkYlOFVmpi/ST80Wl5i50Zk3hLCQmAQUxA+/cLJH8AUq3v
 NYZ7dGKCWml517KQx1wMLi5FfzpnXktkR7z+qMBw2zu9YKfEr7eEt5j8DzwsF39W9VKUX4kCTrS
 Tiq235H/JpbHEujFS8Mr5TTEipeILUim1E1FjRnsEcl4FgJJ0mPo4OTci0O3OrifE4jIIpBEWE/
 85LctB48OiRfJywCS3j0ervJ4JWX4hZ0F4yuV8U1HMfCl+OTzitDwcYpuq669cMgGe7WOAAT+yF
 QpzUTyBzFapZAtcehPSNfIrA58pR+w==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f643fb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=QfOM7-ESXlBk_NPiMl4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=cvBusfyB2V15izCimMoJ:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/20/25 4:05 PM, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 5/7/25 03:38, Jessica Zhang wrote:
>> Filter out modes that have a clock rate greater than the max core clock
>> rate when adjusted for the perf clock factor
>>
>> This is especially important for chipsets such as QCS615 that have lower
>> limits for the MDP max core clock.
>>
>> Since the core CRTC clock is at least the mode clock (adjusted for the
>> perf clock factor) [1], the modes supported by the driver should be less
>> than the max core clock rate.
>>
>> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> This change breaks the T14s OLED display, no modes are reported on the eDP connector.
> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] Assigning EDID-1.4 digital sink color depth as 10 bpc.
> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD monitor
> msm_dpu ae01000.display-controller: [drm:update_display_info.part.0 [drm]] [CONNECTOR:41:eDP-1] ELD size 20, SAD count 0
> [drm:drm_mode_object_put.part.0 [drm]] OBJ ID: 113 (1)
> msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 120 652260 2880 2912 2920 2980 1800 1808 1816 1824 0x48 0x9 (CLOCK_HIGH)
> msm_dpu ae01000.display-controller: [drm:drm_mode_prune_invalid [drm]] Rejected mode: "2880x1800": 60 652260 2880 2888 2920 2980 1800 1808 1816 3648 0x40 0x9 (CLOCK_HIGH)
> 
> With this reverted on v6.18-rc, display works again.

https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/

Konrad

