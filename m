Return-Path: <linux-kernel+bounces-833795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130BBA3194
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16DC323A23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444EB26D4F9;
	Fri, 26 Sep 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNgeqdL3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34A194137
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878257; cv=none; b=a9sj1jbV3KiVn5tF9Ok6bFTL/L5rE6kgHCZWsE8yAgssmGoE23HzwBwI+E9v/bUq+Wnmyl5b7JZ+/Iz6Xnul6nSERAZz+bEpbBdSf2cuCvA0glLGGmwq2z1zVgWnodkfhdMtTXH1ge4cojwLgL8LoRnmjBMqaAR2t7+Bm1emsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878257; c=relaxed/simple;
	bh=IhVIkSlvFGuoBf7MEntBolNq3AVtioyVBXbE7vV4D9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jvla7tWalmX+LCJx/rpUVzhAzqnLFSzpxZEl807YsI5K8vWLTXERR0fH/JfCf64x88CzApkMrZ/+SJK3jvjXu7WzsPmElIvUt+cHGI5EAu1S9lrKGU8D/EyhspPkClErpxYN/xZKJpaAM9yPTsgJfU4C4NsHGWbzobGnpedatdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNgeqdL3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vpEH029963
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wm50d4xWWfh0HW+Cx0UYIE/gdY+1+ZE80v14qcFJHbs=; b=iNgeqdL33AfJQY6m
	HpHam5rvSwaARcJA7ySFTVKvMYWlanoK9djxVoIKbMRS6YBp8BfEXygnGooY1q8d
	JdpXhjzIOToLc24yg6gk4nLtERVgvbh5F7SXeU4pvQunUseVMbwOznWtEQdWgiAp
	YHsXmsLdiXNrd5F4vcNE+4uNmlx72h5VxOoYf3X/4iRMebGFcRAqJ+81lMhpsGax
	ElQyInrmMcKgUrhEEMCOWk6tuGQmBL2JYHw31ecuVxKpvZO+UWVj0/2LuGKe9ft3
	ux896clB67Ko8NqiKK+ukpXVosFTyoymg99OW/t8PUVtBpBD1ehwj57tgZmn683i
	CJnQpg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db322832-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:17:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-267fa90a2fbso31106815ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878254; x=1759483054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm50d4xWWfh0HW+Cx0UYIE/gdY+1+ZE80v14qcFJHbs=;
        b=S9B7gJ9juAvZ9haBOgbQ75sddCtfy1kNQ2dMn7TdwDVLU5d4WY13OXAAoum7FHt9qQ
         W1k9+MpCbVdqRXI3n2NFmIk7b7dK9RVKwSgFjG8w/ZfMTbWzyijUzIdOeJPjHNUzmZ9+
         Nv+5dT5ZTtVsTYXYbdxlBR6TvU66+MxfWg1rWEC1lEUnUTlzOpfxujJEnUUAgLh4jHGe
         sabRYZTtjK0F98yddO9X5CjwmS5l0X1rrdcRcMU6+JDKsnUw9hk21qsoObNZm2ZGoJlb
         gaYqUKa7e5WhuO0x3myBCLMcfaqmPywTLKQ4/U1pYdwLRRajerD46Bh4X9gunTGse0nE
         xFyA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4LVWMx6eyJTo+YNjpJsqyAzy3ZdFAjosJs9r53773txtzVPxDBDZ+Id1zccSHH6CXS1+BScOaMQ8lhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUNV0Myde1mRVf+ScUE26tiIvt/BSmF2L4v4+GSyGnWdy/IpO
	rXAPnZjOA/V/0JSlES2bpaiL8kP3p09+IwMYYieGIYtVhMztOactfHPjG6VO4xRNYqSkY/vn8Wa
	JklW8hEA/ecoj83JWe6nc8oqwAwG8oGnJl1OeCzkbN3n0Rb0KnkKyjaqTFIGZEmF5vms=
X-Gm-Gg: ASbGncsPg/yFUNkDNvEn+O8MfpqKuWqE8moI9NyiLjUi/JAIaJTJMi/rTN8s4xtOAoI
	jLGMLZDploe7wuZcsuY9DD8jnEzfMYoeJlRZX3ENrCylpy1jCW8YJsiSODizfp251LtgpD4Zk2+
	WJE310QHUuP5h+WZI+gIWHJBPzU1dTd7/6LeC0wkL1xUkfPgO9lFHMK3RsOhBsTIecNnEDMKa+t
	HE0/TVqpRRtakzw/f3YwIV/rEAZVSuonkdE5m67ztRZ9lhC3pFfsQoChU1jqpyCyMyNKORmz6MV
	pmMddhLUGcsLyJd7c6pRQgtzNAXt9wYKj+8chv1jqxcDSPxBI4tu2BEpbyu/YsuVVJfe8iq6W23
	vVoKuiXk+zahohngeRh2sP1SRwLQC/jRvTmPX
X-Received: by 2002:a17:902:f78d:b0:266:3f63:3500 with SMTP id d9443c01a7336-27ed6ce6bd6mr59847885ad.12.1758878254226;
        Fri, 26 Sep 2025 02:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbhY2xko/xj3ahYbA0EHEhHusHZw6XP4XJMWBT/7X9Ki73zPM3HqiR38u2BGTHutIJSleAWQ==
X-Received: by 2002:a17:902:f78d:b0:266:3f63:3500 with SMTP id d9443c01a7336-27ed6ce6bd6mr59847515ad.12.1758878253715;
        Fri, 26 Sep 2025 02:17:33 -0700 (PDT)
Received: from [10.133.33.162] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm48314975ad.28.2025.09.26.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:17:33 -0700 (PDT)
Message-ID: <ff178417-5903-43d5-8f4a-7666df9ff85b@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 17:17:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on
 QCS8300
To: Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
 <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
 <b745c515-2264-42aa-8d92-663efc7f6276@oss.qualcomm.com>
 <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d65a2f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=LHWNMJjZwAtaeQ_MGxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=d3PnA9EDa4IxuAV0gXij:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: fGKsAbsnTcU_61zpEYoNzCA3c-lyiMia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX4IRBvHWAdUd/
 Jo8RblTAt/47RgGD4T6W9b/0Isw9aGlkLzU4Vep63ZwWm9NeGRoekxkx+3q/8QWw8SxeT3uDUJZ
 bxFqlaXbH6OACJtAq+TvZ6AGCt+CSlfKprWi2usujXBlzeZj+n0Y/k0swXldlIktN4xyZQqZdvL
 d6iRNE95WSZaMvEL9Kij/7buWy/79UYoKNNEjaYnhSwFXqp2HWXRqhTTguUu8y2lr8oAvRg6Tdi
 Y6f9960/aODXUO5A0X0gJ01fcm32u0rgHeVkdVaTUplGWzZyjWkbD5ywKvGIcYWAjMi2Tv4iRsw
 wJ4pKeCjSHoi+22k70HymSYnG+L7iyZbFGDlWGl1DDRs9ORUBRe/Htxwdd2WcEyZEUr3zyi3ACs
 zIm476rEUoWaywiJKIXLArBQTYIt9Q==
X-Proofpoint-GUID: fGKsAbsnTcU_61zpEYoNzCA3c-lyiMia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172



On 9/19/2025 12:34 PM, Krzysztof Kozlowski wrote:
> On 18/09/2025 13:14, Yongxing Mou wrote:
>>
>>
>> On 9/18/2025 9:01 AM, Krzysztof Kozlowski wrote:
>>> On Thu, Sep 11, 2025 at 07:24:03PM +0800, Yongxing Mou wrote:
>>>> Document the MDSS hardware found on the Qualcomm QCS8300 platform.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>
>>> Patch v11 and still basic issues. I am very dissapointed.
>>>
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It looks like you received a tag and forgot to add it.
>>>
>>> If you do not know the process, here is a short explanation:
>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>> versions of patchset, under or above your Signed-off-by tag, unless
>>> patch changed significantly (e.g. new properties added to the DT
>>> bindings). Tag is "received", when provided in a message replied to you
>>> on the mailing list. Tools like b4 can help here. However, there's no
>>> need to repost patches *only* to add the tags. The upstream maintainer
>>> will do that for tags received on the version they apply.
>>>
>>> Please read:
>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>> </form letter>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi,
>> Sorry for the confusion. I did intend to remove the Reviewed-by tag, and
>> I mentioned this in the cover letter, but maybe explanation in
>> cover-letter was probe not clear at all.
>>
>> This patch includes three changes:
>>
>> 1.In the displayport-controller compatible property, "items" was changed
>> to "contains".
>> 2.Use "qcom,sa8775p-dp" as fallback.
>>
>> These changes might not be considered significant. So I’ll be more
>> careful next time. Thanks~
> 
> 
> I really do not expect v12 to receive so significant changes in the
> first place. If you keep sending us buggy code, which then you keep
> changing after review, I will just not do the review. It's easier for me
> to wait for v20...
> 
> 
> Best regards,
> Krzysztof
Hi, this is the final version and i will be careful going forward.. Thanks~~

