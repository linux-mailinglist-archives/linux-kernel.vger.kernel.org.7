Return-Path: <linux-kernel+bounces-828182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18CAB941F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761C32E0849
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280F265CA6;
	Tue, 23 Sep 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFz4IHVW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF526158C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598734; cv=none; b=D+WRRSJyU5vvas6j/IAiNSyHYwKCG5HZwijCzrb6pmokWd87pSNYlpFgLhfscJxyRzJvq7OJ+PurCmLlRxXZh8klYduXTX96CCkCQkKbmqBy0ATBalsLCZV2Fk77b9n/zBippWCLBDIFUrbTynRoEkXaubIJ69vDZfwDVfZrb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598734; c=relaxed/simple;
	bh=xeu3h0son4iAtzIYRr3b0sKUbwGe49TTuiQdes2DrQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0GC0h/t2sE9SuORfY5I8IKznEvQ38yuAufMB3CKJsyneKR9MZ5vEDtjaMRWS9t2lpYCb8QveeI62NWHNJWFW/3yAIe2Dxp2TZ6dvHqki4HZmMP0I6n3lvGO8Z9+1Rb9z5dNWxrldoyAvBHyBJEhLFXLUjq/2SYi98i7OZEVlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFz4IHVW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHZu0a017057
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Y+UxxpE5WuCRJKuL0hvK4qAyKZPxGwcP6Rwn7/3joE=; b=KFz4IHVWkCAuM+Gr
	ihh3zMOk3sz7yyPuq6meqSBY7YiXu9sJ3Ovl8LYI61cfbz09oYecTiJe/lyjqVDG
	KEzyoIpj/5TgH/SsGYfYwYD7zQIQWJC8qOPQoNYsrjJDPIbpNkVOn+KXq+DXYAW9
	y3CO1VYETWVuyFcDyAqLjhdHY8TbVuZA5F1G/ClJBVyqz+l+v+BDQsPZrEWehj5+
	uR0MMK0F2cfTQzQmaoioJKQmVrq1s1+8cZkEF1f9ICprkjT3PLKdm4e1oybwON9c
	S/MYHMgSWrU1SY9zq+nOOo9Q9q30ORUfz8qlA7MwxCFU4ipWeBlzFBjJtnLrKzqp
	Zl/9Bw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98f149-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:38:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26b7fc4b7e3so10154875ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598730; x=1759203530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Y+UxxpE5WuCRJKuL0hvK4qAyKZPxGwcP6Rwn7/3joE=;
        b=c2mEYQwdKiGcUyXZGRczipq/unXN3CX7u1o8fK8PcBQcGyZ6IXqIT17+H3bY6YnUhp
         LglOxi/9Xsl6Xp3NEeaWJIZso/fKaso6oaNp1XPs52rC6uRzjE0yFoq9AQtNQd3sh+OF
         DBLFw5vGQ5gYp383x6CGBwgy4UW0iD7XrMS1PN0Xr83l/gVlPkQ8sGng/EChf0KJv0XH
         gquZsxE7Jj1RwUsDqwztSvQA21Zw/naNJgohcjOnsJvyzYTPiiQiZTUrYhdQkxnDItvt
         8j7hGWofbV2X5uk5iaZoH6x1KbyhAA/LwelEdpexZ0/zFO+3hULBYgezOjY8YYSv7/i5
         RsDA==
X-Forwarded-Encrypted: i=1; AJvYcCV+sWsC0Y4qnzPkl251SYVQ27lZA9AuOrjikWyXI4/Qq6G3FZRK2Jw4Tpm84D236hCvwTj2fthIghDFRmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZGheAzu54wZHo5HwJw1gJGVT3q4shxGafr6JJjfCMPa7kYUo
	qJJu/sLX21nlxNYkibuO+DH4r9haKXWU9vTqgSVIC3qLoqE1v2rBZW4UeYyhEWGHqpQZudu3s39
	vYRqcxn2YA7QTIDWwMtHKnf6VRM1/kIad7WTyu+uJLHNPPPH8CzruD0Mgq+p2lxezIqo=
X-Gm-Gg: ASbGnctrOoGDGqh5gRNugLfmO9m9PvAIXjAvKQpZ0qlUatHPJ5LENBcRZ3N+q31n3OK
	k8J/u6H6m0UV2NyiJuoKjbRmZD3+3kTpAPkMHBN5kWwsOo/CAjAfIf0YevTjBFOKhBnBcboYipK
	LgxgS3EokpoT8F6FN8E+asKTvahfJduHS1wPxPXd0TBmxoczfh2UxsWZjUDCEFHKv6tG0Wq1OfE
	SaLQ1cyiEKVZuKD3YSrOtFbPMDvwV65Vd6oMUNFca+RCDlBVgYy/Yb6U21aG5CO+Hkd+QwVA0c0
	bOyMi23K5pd99B/DiXkkLU4Sg7VSoc0uXkRGXKjwBclELhdy7rWt7YgNCMh0wo71mOxA/HFOEsA
	sxS0OTePFJqo3E5XgSZHlRzvmwomUelt9jEc=
X-Received: by 2002:a05:6a00:1828:b0:77f:3f06:1f78 with SMTP id d2e1a72fcca58-77f537a8173mr828259b3a.2.1758598729779;
        Mon, 22 Sep 2025 20:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5W8YAPrrchgMVeHplJ5Ln5bt4yZvCXn/JchjMJMX2nlmqazlCN5vnpvVhSh9oEhVk8Z5oRg==
X-Received: by 2002:a05:6a00:1828:b0:77f:3f06:1f78 with SMTP id d2e1a72fcca58-77f537a8173mr828234b3a.2.1758598729324;
        Mon, 22 Sep 2025 20:38:49 -0700 (PDT)
Received: from [10.133.33.111] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f41b85e84sm3439351b3a.86.2025.09.22.20.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 20:38:48 -0700 (PDT)
Message-ID: <d7b2a904-97de-4716-b179-4ad8d3ecbe58@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 11:38:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] drm/msm/dp: Add support for lane mapping
 configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-14-eae6681f4002@oss.qualcomm.com>
 <j7ooyi5vih6ofnjigdgj6uk3ycutugunpm5pu5zf55pu5ua6r2@agg73zakjicn>
 <CACSVV00Bat6LE=joM+Wh3HnC1=c3_Y=crxUGdhLQWxxpZ17Q3g@mail.gmail.com>
 <t4x7okzjvh5ltyoniwlreoyy76735igtnxpeohpbojn4hkqk4q@v3ayfjrkez3e>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <t4x7okzjvh5ltyoniwlreoyy76735igtnxpeohpbojn4hkqk4q@v3ayfjrkez3e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yzmmYCCrPae2N1kUhmgNuE4LPFb4smLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX3axSOfmI//Dw
 mM4WnSNvWifmejcRv3R8Euac1vqu/5t21HD0gGo2e0djqbJCkAaILTMWOQ1EjP2IXVnhXbzSxvR
 Bn5ipQL9KCJRhomzsLXIF3E4OLyvsD9dRPhH3W0UZ68LJbUMone0Uw95MClukyPtdRM0ehT5XpN
 mh+X5sx0F6L65tgRZKyhbagrFS0tKOHvwsxpK6yY6jdJffHzyQW67r/MsuZxfdteb0Tra/K+sPJ
 7g5OdgTqaz7n6ctm6MYgsplpECEcp60YnRlWIrGmSM6KzprYuiHpMRyO9Xq0jE/48QPYskEJwfd
 onYkzAOoKiySls9Q9ReYo7HPI+kGOP+uK5KpBrWpEP2ciy0guKEN5WVJYfHLGhkZz1oBtC33GpF
 BYkbwGI/
X-Proofpoint-ORIG-GUID: yzmmYCCrPae2N1kUhmgNuE4LPFb4smLX
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d2164b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gP3TSUq4Lgg7EeaY2V8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018


On 9/23/2025 7:39 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 08:13:00AM -0700, Rob Clark wrote:
>> On Fri, Sep 19, 2025 at 11:35 AM Dmitry Baryshkov
>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>> On Fri, Sep 19, 2025 at 10:24:31PM +0800, Xiangxu Yin wrote:
>>>> QCS615 platform requires non-default logical-to-physical lane mapping due
>>>> to its unique hardware routing. Unlike the standard mapping sequence
>>>> <0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
>>>> configuration via the data-lanes property in the device tree. This ensures
>>>> correct signal routing between the DP controller and PHY.
>>>>
>>>> For partial definitions, fill remaining lanes with unused physical lanes
>>>> in ascending order.
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++----
>>>>  drivers/gpu/drm/msm/dp/dp_link.c | 60 ++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/gpu/drm/msm/dp/dp_link.h |  1 +
>>>>  3 files changed, 66 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
>>>> index 2aeb3ecf76fab2ee6a9512b785ca5dceebfc3964..34a91e194a124ef5372f13352f7b3513aa88da2a 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_link.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
>>>> @@ -1236,6 +1236,61 @@ static u32 msm_dp_link_link_frequencies(struct device_node *of_node)
>>>>       return frequency;
>>>>  }
>>>>
>>>> +/*
>>>> + * Always populate msm_dp_link->lane_map with 4 lanes.
>>>> + * - Use DTS "data-lanes" if present; otherwise fall back to default mapping.
>>>> + * - For partial definitions, fill remaining entries with unused lanes in
>>>> + *   ascending order.
>>>> + */
>>>> +static int msm_dp_link_lane_map(struct device *dev, struct msm_dp_link *msm_dp_link)
>>>> +{
>>>> +     struct device_node *of_node = dev->of_node;
>>>> +     struct device_node *endpoint;
>>>> +     int cnt = msm_dp_link->max_dp_lanes;
>>>> +     u32 tmp[DP_MAX_NUM_DP_LANES];
>>>> +     u32 map[DP_MAX_NUM_DP_LANES] = {0, 1, 2, 3}; /* default 1:1 mapping */
>>>> +     bool used[DP_MAX_NUM_DP_LANES] = {false};
>>>> +     int i, j = 0, ret = -EINVAL;
>>>> +
>>>> +     endpoint = of_graph_get_endpoint_by_regs(of_node, 1, -1);
>>>> +     if (endpoint) {
>>>> +             ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, cnt);
>>>> +             if (ret)
>>>> +                     dev_dbg(dev, "endpoint data-lanes read failed (ret=%d)\n", ret);
>>>> +     }
>>>> +
>>>> +     if (ret) {
>>>> +             ret = of_property_read_u32_array(of_node, "data-lanes", tmp, cnt);
>>>> +             if (ret) {
>>>> +                     dev_info(dev, "data-lanes not defined, set to default\n");
>>>> +                     goto out;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < cnt; i++) {
>>>> +             if (tmp[i] >= DP_MAX_NUM_DP_LANES) {
>>>> +                     dev_err(dev, "data-lanes[%d]=%u out of range\n", i, tmp[i]);
>>>> +                     return -EINVAL;
>>>> +             }
>>>> +             used[tmp[i]] = true;
>>>> +             map[i] = tmp[i];
>>>> +     }
>>>> +
>>>> +     /* Fill the remaining entries with unused physical lanes (ascending) */
>>>> +     for (i = cnt; i < DP_MAX_NUM_DP_LANES && j < DP_MAX_NUM_DP_LANES; j++) {
>>> Nit: i = cnt, j = 0; Don't init loop variables at the top of the
>>> function.
>> These days we can party like it's c99 and declare loop variables
>> inside the for(), instead of at the top of the function.  My
>> preference is to do so, unless the loop variable is used after the
>> loop.
> Ack, works for me too. I think I'm not used for having theese parts of
> C99 allowed in the kernel.


Got it. j is only used in that for loop, so I'll update it to use C99-style declaration as suggested.



