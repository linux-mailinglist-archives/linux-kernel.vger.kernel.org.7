Return-Path: <linux-kernel+bounces-747638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB64B13633
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747CE177A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331622DA0B;
	Mon, 28 Jul 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqJ3vKw/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D58223335
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690797; cv=none; b=AnQhIMh4t775vswV9AXPG0GPCHJ8iWIffRoRhSvLCMksJyuHpeyTthlug7oTbGiAkTRRWVzaOatuZvoLVp/nDrxYY82CZ/x7sVqO7rv1lcChd4Sg+vdBdsL87CoX3Cizf4oUJeisxl+IBokn+rgS5QVnAIxJJtvsFWf3TypTsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690797; c=relaxed/simple;
	bh=k8n0r804RPCue8KVUZzax0URN/CldCx1tfSkQPdnc8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gvm+tOTJVdccZxNsyel4npmU4mqfzriK/Y/iyRzso5fCR6NWTp6/WGVVhzBqjSbtNzFq+POebrFqpOKoIDmoQG4lC4JyvgtuZfWAJ/vTo/qUSttKlhulrm1x5+Qsle7QjrbkT4kEbVdV0HCLgGpPxeibSWkohcX2caphK+W3eqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqJ3vKw/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rFAI023098
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c3/V22c4H9/4N87ToxYjpj2YTnx67TDaYm5Xeu+qWco=; b=ZqJ3vKw/3GvY4XkR
	u3CP1JJjp9JwcIxipYoHGHzZEbT+MvMBKeBaTicf7yJuUihKYUhTyE2SeRM0bA4i
	hht87B7LURdJ1xM0YJ+76Xn1V7YNMBA8ZTDupifYtDmK4sTM6vw+pZAVjHfwLRuJ
	sJQzQXG79WLFWma44upEaDxFSrKYEIhduEUkGSbeAftU1HlXVq+Bk30iF+YV7wQx
	XmN3ssE54IOxsp45/O1nmgVeLCoXXVMuF/t0lkWiDan60me4LLzjz7+wVxGsRyPU
	2ycHzt++gelNTdIQUJe3wRptMKuSZ0kwRV2IBn38EQg3yrmTG3+uR3+++n3PAVZG
	K/RKfg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1x95wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:19:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b52cc9b3bso437988b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690794; x=1754295594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c3/V22c4H9/4N87ToxYjpj2YTnx67TDaYm5Xeu+qWco=;
        b=hbITNmTJMu09pViLke2MpigfPdjYUcjDLjiUqJrJexab12t6vk9YXj1YQiyb1Esi4y
         9RhUz5AUO7u2A+MgfRC0eQj+FCyB4Y7/0ZW5jUWk2FZHSOie4LTnluMO100wxhDXOk5h
         Znl+uaMeljutcxkoA1446TrJkf2q82UD5Y/LUHNliOek6+Pf+DyDMRTG0QlA0SUUZzO4
         +vNDtEKQfj8JRTkcyMOC+Ulc6/FF0kGFsTROSxWAXZV1ZVrAzcXlO7P0+TjNhAsLxfe3
         ew+CO8ZWxTknX8KysjwZWH/ozk628jOyCDGJFs7hoADVrnS6hpnL06pnyUC5zZrVsd6J
         eehA==
X-Forwarded-Encrypted: i=1; AJvYcCWiWGKF+ICFeXLRLYOdTHMFzz3pFVXwYncNYUM65kyMjRIzg+iHHlhDQb0RM1qUiUSvEkZp1qmj4lHCewg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeehTkTI8cVMf+fkljmiqNpsud8UhMiMZjSUSGPabSywcLlsw
	ndX59y1w+v1AfnFP/G0JgpL0y/vbexYADUae2OrBs9UX+5/GT8HasbmBVJYz6mUibiU+zUycbwz
	yI0b3yv4rK8YVRqAgBm+1fb6mkLbzZ4UQY3sHHCK66Udu7ob5dAnKrEGls9PB0IJ3Syg=
X-Gm-Gg: ASbGnctJGTRzbGOmY917y0SVIi6FpHR6J+YLiV2JYa6drmBUCf6gSgQXZao4yA3OkNy
	STGP4IzeITYDigeC0vwOCecIBg8+kiRqs9ki+VLmoDzYvmDZYkyZLh72htyRVNwXuBCHGEbuZsZ
	dvZsLju0OvBbTPjZXyeFYt6cyAtH2C32e26OWybVg1r64NSU9dC7/KwMtPe990AVfjtnOOW6dRE
	xhvpAVevX2jfSuNBEAku7Ciirz2AQDbl+6kql09jhAjiARp6IM38g/ntg5XxyIdzmj01L8sIW/r
	uOW7dD57wAdMYQKne+80/cRRdAyZZQ9TvCVN1al9gIBuWrqyWiqYDbQX3RW/W+inV55ebAIAmLw
	/YShpZ8qUw7o4+DLUSCIbeGY=
X-Received: by 2002:a17:902:ea0d:b0:240:11be:4dbe with SMTP id d9443c01a7336-24011be58b5mr24214745ad.8.1753690794473;
        Mon, 28 Jul 2025 01:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBHlvf/+jz4Co0OGrxgZgJllWx8x018fZVsC0zcR7Ey8G6AtlwbI1UqIOOzans4FRj4G1N0A==
X-Received: by 2002:a17:902:ea0d:b0:240:11be:4dbe with SMTP id d9443c01a7336-24011be58b5mr24214525ad.8.1753690793917;
        Mon, 28 Jul 2025 01:19:53 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdd687aesm28379815ad.67.2025.07.28.01.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:19:53 -0700 (PDT)
Message-ID: <c3f191f1-1b83-4284-b164-64c5b3e3fd43@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 16:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] drm/msm/dp: Add DisplayPort support for QCS615
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
 <20250722-add-displayport-support-for-qcs615-platform-v2-12-42b4037171f8@oss.qualcomm.com>
 <bca68e7a-cb36-4903-bde9-15cb1945c71e@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <bca68e7a-cb36-4903-bde9-15cb1945c71e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2MSBTYWx0ZWRfX1fSPzt+PV7w+
 CAUlEnKi9/5/xtDD7mcqS0HDxwY1Fzz5I2umP4PSpuYrWT/CKOqNRFCGJrhCiZn4rFYCe4+vROG
 3vbRQskNmu/bknWSGZ8E6fT6bJl4xvsbDRGq2zT5xhomTGZk8f3wbE0e5fKdDYqtJvC5/PqSH5I
 6L2OFDIur2FQEkepF1jiUkrAKZ9qpH6EmTXdzRzM5wobSYYlqBo4SRJteEez1i3u9TXZELVGNag
 fx+9OLRRtMKsoDAn1YO6CDuks51Zl+oEOCrINmBAT8YIDQnmt92w5xKu/PRBI5bbtl7LOsrpGxp
 KJx7ZPzER1Dj10tOW3AR7qMfcsCy57tMyY2Hds8a5erxCSUP5g5hPDx/VV5HkWsG9CWee0ce4Ih
 mTORvXLUT6RCOyxWEPvaplHj7Sihjl4jR64TFsC+jHgoRksqnJ2jfsi5ENKyGUxi4sa/bHnn
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=688732ab cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=E4FQgNMW2-BcOtG67-8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Nn33FG1T-Od9ObfemIiFoLKHfagT3Eic
X-Proofpoint-GUID: Nn33FG1T-Od9ObfemIiFoLKHfagT3Eic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280061


On 7/22/2025 5:21 PM, Krzysztof Kozlowski wrote:
> On 22/07/2025 09:22, Xiangxu Yin wrote:
>> The Qualcomm QCS615 platform comes with a DisplayPort controller use the
>> same base offset as sc7180. add support for this in DP driver.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index d87d47cc7ec3eb757ac192c411000bc50b824c59..ddb22b50490035779904d4cab20e2fee7e0f9657 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -196,6 +196,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
>>  	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
>>  	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
>>  	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
>> +	{ .compatible = "qcom,sm6150-dp", .data = &msm_dp_desc_sc7180 },
>
> So devices are compatible? Why are you adding this entry instead of
> expressing compatibility?
SM6150 uses the same DP driver configuration as SC7180 via msm_dp_desc_sc7180, but its hardware lacks features like HBR3.
Implicitly relying on msm_dp_desc_sc7180 may cause compatibility issues for SM6150 if the msm_dp_desc is extended in the future.
This is consistent with how other SoCs like SM8350 are handled.
> Best regards,
> Krzysztof

