Return-Path: <linux-kernel+bounces-813872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E47B54BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595FB462788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12330CDBF;
	Fri, 12 Sep 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F094I8Ky"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9B30C61D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678041; cv=none; b=Zkua4+vF280flTi7CVHICMt/MaVdbTsHz0y1bL+1DJmFHfDxc7rnNyllROIRrFeojXr+IHSYF3ITm1AW4ZEXr4ne5pERt7yib/ed/r2Funyh1Zh5Bzj6OLWLR8WJJwmQ82d3yfKodQpXAVw22PjdBBJ2sfj5ZKLxQglKqG000Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678041; c=relaxed/simple;
	bh=wph7RSmz1zwsGALV+zh23s9XdXCIIpVfa7QUyi66nFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkxViSopEUFdyqFWFQuxgDXKYwHMKM3KNcvFuqc5ofOr9Z6zw5Miz2Bh7IZHCJtr5Qc4t28fsAuMoz04EbfegQJfF5en6aJhkast/28iVY3XrXkhZ0y41XPVoekJaaN8NzJhU1LTx8auUFuKjkZoikMAimCkSDopLfu5eDhyLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F094I8Ky; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fNhc010905
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BAbR0VkBTtMW5jEdUFfz9c4NlZZZn1XOV6N98HhO2c=; b=F094I8KyfbQuDqu/
	nok0Obhg9UzGh32wFsjO7nnXlM6e85X6uOGWukNleegPBr+QBvYzbR3ovtvzbs3y
	vDOGr8GFsDBhAEYZJBeNAgNr3xLizxvFdYPFeCGM2QKnsdNSHofJnECvzxum7lfT
	XOHVN6qh+sxB0TLFc3O28lHnWRNddr3Yigi0b9A5eY7/WKP1gkcdEHuiaCTsGFkw
	IXwqhGn1s6FOXlJmXdxk0pakwqS5TeUPqv+VUVO8waTeGpXtD9diy2gt/1ooi3JW
	CbgGhI0VkMoxluSvdQJLAlVcCH8sbOX0bvp7AB1EGg7fF8HMCGQ09fqPjJxA+pdF
	jtIZlg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4mbb7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:53:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b521f77d978so364035a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678038; x=1758282838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BAbR0VkBTtMW5jEdUFfz9c4NlZZZn1XOV6N98HhO2c=;
        b=I6inOfckOlr6Gxy9Z3x2FaTlgHdBOJPGLrKgbai35nmAmsfKgDtgV1i5gxF6jmLJNi
         ijEl+yZyJrqgeLyu0H1xN8dbpinZ9EnhMoJgnQOZsuBzk0qD9AcahETB5NOli8yFn9wN
         F67L5bduEzpKgk1mV3tv3ymb5tXz2w/meXBBhMZxiDd97uHDBNEENH2jgOZ3cWtxmMhg
         uLnoqzONisHtSYlrsXVCG4kPVipYTG1Gx6AaGBE45A3ncbGMH37s5UgXUQ9gpPw5i5+v
         tHVfID/dh7FV8f3k3tD30m9IOO5oxLdDFIR6GRF2ecXH7hsMuowslFSTm9fOJM1hnmAK
         S/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAdg08mc5kw2PxE5V88dsKad5bjVe43Oxu25WUCuuDyqGBNORqkdwg6njPg/Qi7rAjZpLKtxlCv/tHUTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMq3DBkLtp/ADq6uYCIsM2CLN/9mS4qeSqAbcMT/mllWrmm3N
	s21NL1xOBqpbpBdv4flymt0rP59NtAo78bibUkh7g2acuNKopw1Fvvuh0QlDMn8h1wKA6RZSAq6
	cnKFSChGFDJKF6+o4qqUS1SLDf6JH6dYFg6QSqd68LaEDqMHAvZaCQdrFyHDWQHXhvMs=
X-Gm-Gg: ASbGncs6AzQ4l5DUie4eqD8pIYHtUCWaT7Qqdc0MBXXnCVHPRhHYug4PXoTyNKovlEk
	mV3TnfucVhi43N6YiljnM4c7zfBVTeI/ha4GPfnlQ3KEIHgMrVFICcRk53RROfzua8vDuxM70uP
	P+h7XZKfE7isHELD5+tCrCr7Vs05XJ+zjIMngZxgZhFHmq/hZehO75zPxYhg0Bz/pPWDunvkZYV
	Vd86e1kVA/bMm6OyurmYMJNv4bi7Mksh/08F4UyTPoDJqeFIoMKwbJAQ6GDCudgkgjBFfJD5veW
	vVBB5C4OqryItoOfT7RjCDVvPbTgAqa/3XptdhO1BTMfBhcgqh6gC7c2gmCXE0twz+k3FHP2+1p
	wwwmzPwdKRTHuoCFDqhJDGHXSK7EmSw==
X-Received: by 2002:a05:6a00:181e:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-776121ec346mr1686425b3a.4.1757678038034;
        Fri, 12 Sep 2025 04:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt3mxQMkv5DuTk0o7+8kWj/nU80uRbbQWBwndCE/G8QbqHBZ/ES9haTMqTr8/TVjovNYCW4w==
X-Received: by 2002:a05:6a00:181e:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-776121ec346mr1686395b3a.4.1757678037556;
        Fri, 12 Sep 2025 04:53:57 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c473b9sm5342655b3a.93.2025.09.12.04.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:53:57 -0700 (PDT)
Message-ID: <d9c55e72-0683-4eb3-a22f-015a799e2c79@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 19:53:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/dp: Add DisplayPort support for SM6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-2-02b34b7b719d@oss.qualcomm.com>
 <budeqnh65mcmtc5rscbgvy2nz3woptxnht6sddzg7jhttsnx5f@bwf3kyvbrfaj>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <budeqnh65mcmtc5rscbgvy2nz3woptxnht6sddzg7jhttsnx5f@bwf3kyvbrfaj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXzc1Z9fuGqWCX
 c5l9Foc+TP1zMnKkWxqwGcRQTHkPP+L7kFg0EmlNFh9f1eIEEX2h1ljDLPXBA6NUCpB1ctNakC2
 rf6ZGwFyS12fbPEQqd1U5K3IZpEZjEIFFurg83OH253I9bYLAoUrinmSdiWIXXPCoiLX9hotpAk
 UyD9fZsMwwGeuYO6CtY7WMMcp5IpiClyqp17qH5n3DNpcNfpUp3IQcUqwb7QCZ/+cu42Zm2Pm1d
 stEE8atyw5w3j4pZ4/Tz5C64NV+/AvA3RUttE8norhzvuH77TCQmrA0ifJXy50kXF9PboAd/09Q
 ZXUSQtJUyzTdy7PzvlMegPS8HYPzwH100kFqUoQdqdJ4Vobowpd+B0NgDSGf9CDloCyw8uUTMrd
 ZyE9/nGj
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c409d6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NvjRSh8cQ8dmTSQMK6gA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: BucNANPBuqtzgdfVukfLLLQn_DwD2WVI
X-Proofpoint-ORIG-GUID: BucNANPBuqtzgdfVukfLLLQn_DwD2WVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038


On 9/12/2025 7:47 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 12, 2025 at 07:39:17PM +0800, Xiangxu Yin wrote:
>> Add support for SM6150 DisplayPort controller, which shares base offset
>> and configuration with SC7180. While SM6150 lacks some SC7180 features
>> (e.g. HBR3, MST), current msm_dp_desc_sc7180 data is sufficient. Listing it
> SM6150 supports MST as far as I can see.


Yes, but since msm_dp_desc hasn't been mainlined with MST enabled yet,
I went ahead and submitted it with this commit message.


>> explicitly ensures future compatibility.
>>
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
>>  	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
>>  	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
>>  	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
>>
>> -- 
>> 2.34.1
>>

