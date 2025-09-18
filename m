Return-Path: <linux-kernel+bounces-775264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A8B2BD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A8A587C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68531AF34;
	Tue, 19 Aug 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICYEgLv3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810C31AF26
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595351; cv=none; b=C+xnO3vySB3hU4SK/3Ek3/cFJ/N0OfKMUynXXX05NScoh9ll22x0dGg5fCCBcAZpUdDrya5Ftwm5jzQ5ZwCwmEqEy077H1AGPBEl4zlI5iIsP48WaRrnoMip3LFEQ/120sA1rkpKH9iyFzQO0TPwuax/zB2yDckPOznC9LuftMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595351; c=relaxed/simple;
	bh=7RsH3VxpWgwtXG1eVErOEeFihCXGuj9RHQipyC2qkp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH4JdMkJfq34XgH04gSmvvHc38RxwKErnLH9t0g+yCmvbzc+4zrClU5oeeMtPC7rR3HqTeNKNmEBnzK4mim4/CBmg/wtb3v6viae89RgTEnVMAB+NWYr6m2Pwymi/nofAOFodGfGLUzWw0tcJLFJuN/4Mq44JgWlMW+ZuSdX3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICYEgLv3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Zqr001506
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KczFnqDzEs+8Gb7pivRJCslUzgY2ZS98+cXZUjdh5lA=; b=ICYEgLv3ITBdFBKr
	uvXfh7N/Y4K6UR7I6z0l/LLT8+qtcjGj56uYEbq8KzkijCu/+lZLh5HLBPmJ9YPY
	qgY4FP9o4zHREFtktO1RLFdhWX7WBfdm0VIbngG+uL5HgJx3HzP5LK+ewwd78dRF
	L/31KnStgx/WI18gKdrrPIUoM4KvgRzsmlzbs7Tmnbd1yRR7Re/1opsiIw9SOeLV
	euufvIQBHHwalR1X2pwXX4232jC5kqVJNcYcRaHeJCfWsSRbuuObelSWplReXcYT
	Jt3UPSB/VELqWlYzONXnCJ0zGub0iQCAAOeR7EBXfiZKXAczIgL9ZCg/dkWm1zXU
	70c/YA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh077ydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:22:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e614889so5088531b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595347; x=1756200147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KczFnqDzEs+8Gb7pivRJCslUzgY2ZS98+cXZUjdh5lA=;
        b=Gntt/E7lY39OK7uiM0wStE1xFGu9XjLZSoqYBeK1HX+jthIsJJq0BCGJ9goLhwK2Oh
         NbJVjMZ24K+Nlss0zTw+rZUTw6i2uV1X0iJbaz3SeRk2yhfN489tNXZa5INdG+nz74Cy
         lcjqE6QCaEnh0npaapXhyeIyOcCKCeeDfOq4cUCXF46kfteT8t0+Gr4o6N/B12BLU/Lw
         6taAEy/PD7lXSPOA6WUhyEHjlZvXCcixoeaEVLgosOyqksJvrovWS1d+TljOIA9aqZi2
         9xIO/j/J+mLQMNl/ZJdHwd2nuMCuAi8QATGsK/2ywOhFdpJlGQ0jz41KIFATZ+m6YQD5
         Q6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUR08YEkbuAPZyHfFBsPZ2rKILS4M0ZN9jb9VXovDeLF9KF0riJFzAB0RQ2N+FXlmhZS9J9rWSgiKQHxy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnS8SJsEch3pURQ59lbdbfmjx0ew5zyJEcEajy1PtmYxcOlTu
	wB5XT3v4tHXayCfDQduFUUbb7Z1S8KXNZA6qOJEMgb4Sr1yMuztpod4tKb0mTmAPfeZhRjNw0wO
	3cRlXgSVVMamddTOfBpX/GJMEFEfmVAmEzjphc2rFvPi5KDLPOGSNVq98O9+kjJto6yQ=
X-Gm-Gg: ASbGnctwgrbBgbdQ4HCimJNMrsUo+tqNhyY6Okflh+zVOhGu/SvRWkEDmNTPQ1Ipdb3
	tA0CgjmpX6bTs2ey9xNbwamT6R2EeQVGiJ4V94HvKelhWZRXbr928Oq1nKkA1iaw/4tCW7fVDgP
	+kS2P1aTXYS9YoDk3yalmqWiySsqCy8/fCb0B/eo8iaHLsHheaWSWRqWbhg7sm3tRFm7Txh6AYo
	wFpB7IVTRJvURiomb9rrkYYQZ16F/c9G+a+k0J5axv2xKMjIn9mBAuCmXvBmymrfsYYTmgmR46V
	e1B7uESiU5fNpG7A6oHB6aq2wUfvIBUa2PBTupzAKglW8KCo60znmUU0s/zY7eAtGuNk7Wq+F32
	l9QtNRqqgHu/0z7UoJcD5Kk7i0oS8Hg==
X-Received: by 2002:a05:6a00:3e16:b0:76b:cae6:ee8a with SMTP id d2e1a72fcca58-76e81102294mr2238134b3a.12.1755595347384;
        Tue, 19 Aug 2025 02:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFphi7ddJrn4OsHLiNEW55tJtpl5xzFPqO7FIxkJjqz5ACjMc6dZTHp/btM76pdxRLSv7Tocw==
X-Received: by 2002:a05:6a00:3e16:b0:76b:cae6:ee8a with SMTP id d2e1a72fcca58-76e81102294mr2238112b3a.12.1755595346893;
        Tue, 19 Aug 2025 02:22:26 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d524c95sm1906515b3a.81.2025.08.19.02.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:22:26 -0700 (PDT)
Message-ID: <20e7790e-6a30-4301-aa50-db180ceeb7a8@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 17:22:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
 <20250819-qcs8300_mdss-v7-6-49775ef134f4@oss.qualcomm.com>
 <brculyyu3dgc5nkj2cuzv3jkjzcouljy5o4jwr6mw33r6i7gt7@j6ur7yvwmky5>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <brculyyu3dgc5nkj2cuzv3jkjzcouljy5o4jwr6mw33r6i7gt7@j6ur7yvwmky5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aWO5XYxwWBoCzh6vGUooLar1ZDYX6Cux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX9UIrw3s+dTNM
 i+4zEYGtp//SkFufu8QGeBNJqozLFkRYRV1ZZ1XPA2iPw7/lGTZZbMk8LPNMK8vNNISdtcJst3v
 UB/Qt0CRs9ZX0WtHNq52ybQBWMBPUl1sdwZ5ohqCFI3NMw1nF9lPtYVfYLd5Zck5T4JY4UFLa5s
 NXlkZ79izMb+IjmlOLYPn47zi3UIsoQ7m7tsz5a6Pt8g8ClpOrsou1gJWJYHxVTH2YDz7AbOujo
 IqMC1lofM26FLpVucEOpH2vRtA+6c+oGxRbCxtaTTqoC8vvHhEjil5l/GA0dxO9gGjtyL/sCui9
 eJPcgFShFlnmcT2W2ksS82x+6S5G+roLs4nSN12/p/JJ0ov4WUlNBjbZGNwMuIb2dKHBZJq7dX8
 ghnpz5/p
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a44254 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ZXt-rHCGnEisyK7TIFQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: aWO5XYxwWBoCzh6vGUooLar1ZDYX6Cux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020



On 2025/8/19 15:59, Dmitry Baryshkov wrote:
> On Tue, Aug 19, 2025 at 11:33:33AM +0800, Yongxing Mou wrote:
>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>> with same base offset as SM8650. But it requires new compatible string
>> because QCS8300 controller supports 4 MST streams. 4 MST streams will
>> be enabled as part of MST feature support. Currently, using SM8650 as
>> fallback to enable SST on QCS8300.
> 
> Hmm, no, you are not using SM8650 as a fallback. You are using the data
> structure for SM8650 for QCS8300. That's a different thing. It would
> have been using SM8650 as fallback, if you had declared device with two
> compatibles, qcom,qcs8300-dp and qcom,sm8650-dp, and then relied on the
> second entry (only) to provide a match and data.
> 
> Exactly the same comment applies to the UBWC patch.
> 
Got it, thanks, will correct it in next version soon..
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index d87d47cc7ec3eb757ac192c411000bc50b824c59..bb4660585849d1a67921a28e7e12422e0c327ab2 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -187,6 +187,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
>>   };
>>   
>>   static const struct of_device_id msm_dp_dt_match[] = {
>> +	{ .compatible = "qcom,qcs8300-dp", .data = &msm_dp_desc_sm8650 },
>>   	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
>>   	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
>>   	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },
>>
>> -- 
>> 2.34.1
>>
> 


