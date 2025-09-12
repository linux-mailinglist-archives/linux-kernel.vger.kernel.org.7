Return-Path: <linux-kernel+bounces-813881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB8B54C25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A535A2723
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90318301476;
	Fri, 12 Sep 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="caipe07O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26000314A8D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678082; cv=none; b=U1lMqXHOP591VGeCYKLOwzAEWxyOIbiUdk5owOtSvakVdy/zHiBAQ7ZDbs4vihioFfsudJ1NdNy+AfKCQ55YYKHFZGQ73KXRRS7UoYvD+7pRuRyRKAtVyy4llHMs5WWCzSsgvxcSEXwATdQ/mV/z34rUiovvBWeNANYgNtZEP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678082; c=relaxed/simple;
	bh=ZK8/4aNLllz7uk+iaLyWsRe0awdZ9X8BIaYRhatobqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqasRoCuA1XrkHLBoPmBdHdXrPz7RwFNnKH3sdRS7mnLd2tbkgBC7dhcrIWjjxOhzyuG1IxNampJ1Iy05UAGauxrZhjhdntFiVJICC/GS09eX4umUS8auZH2WdwXmjYnWBm96JFFSAmkAyggsmRasK+C3sxACr2jxNWA/y2yODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=caipe07O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fGZU019756
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CL+lI9VYcTxc1ylzMUGhgewY3tUhb2X7dvXH5IYD2tM=; b=caipe07OT38c4Ooj
	i5GS6gjRDKPJxngB9qSRS3lGHGBzaJ23DY1OTTMbT9bFx42LgXJB1JMNi50SDOXX
	CYaUzwoqLP6lDS91llXVumAo+FErbCJnBbN81ZdvAYdvP0AAQY7u/PwnCXh6YYq2
	5zTjWuIP9tm9erikfJ2KkwjRRGCGYe4Kb8DDwy0M/DwY1qZNg+1NujGaHY57X94D
	PW9oukioENMcRLyAm0X4EXawsB+GZNqRKLfBojab1Wy/LTBYcI0rHX5PWXp8g8Zv
	CdhJNLcL0IsSP2ds/+7iSiRHYRtuFK7Ax80KpGgUPo3j5Pq95ANq5TAj+hHoInr1
	ZiK/tQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t387xx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:54:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b521f77d978so364145a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678079; x=1758282879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CL+lI9VYcTxc1ylzMUGhgewY3tUhb2X7dvXH5IYD2tM=;
        b=eec4RJTZM9SAZCTigO87QFKbNa755jqY/LrIQWIAQ9TH2Mns00h5T4F11OUvceV7Co
         TJ/54WCjg3Ug9Q98fxOibQ2kazzF7dsSV4WvySG7hVjfZm5e/77DGdurS7D+BdzPz7tE
         xq2TEdVPC5cc/Cli/5pH7LC/532VtHcdrNu7NnHqMaWddmORSSkiEkedPSi12mZAn0fW
         YY5XQO4srizS0BVpn32RKZim9cmO/8DmjRIlPHwvgOK+e1AEO9xZNJnbL3qy3gYYMZ+w
         qyZr0GblH14AZCv7XcazegFehp6/XaD9FZDvTsB4/dm5e+oV1Rc0f2MI+AOyWltTdL13
         KuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhKKT+jFKv5fhKS98wlqriA1FwRIe3jW+2vOHgnBuabOVX82dK9NM9WYOcFLRgWeL+uSo8aRR9TMzO1Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiIw5CAdbv5WBQ1cRYR/ftALa14/cYcDm5u0elil4zuXm8xe4
	ZC4SXNG/UfJUvT9dHjckRVZ3OnSNfoBwT5JBM4371r+ReDE1+354/pspgAsUAODahXxLClY+WCm
	2GOv75NtTYi0rhT/yID1c7t0XErMymUhaWL9Vuc6sZRNRTnfLW6ySRh2s61rxY2KaUjc=
X-Gm-Gg: ASbGncv8fB6d9fANf23whikM3cRHeedXNr8ObQnFsuQLrVzxhJwbzgr/xLwlP452QSO
	QW2Z0t9g4fRLLFLCNQ6GcwoxymEnbOGYGb5/K5pYIFLz/OCH8nnpAeJ2GhFGmZM9gFha2VeynDP
	HPfFaObWZfGu7/csKA/SzlBS7e4fo65I8ZvxWBtOcvmooJ6+sMbXdWXIlN0E55vTIHYTX1f+MpQ
	/l5Tn3+odO6GUCwt5F1PF/1HEkCrAPXtVHR4T0JBrEfmdyN4pzeowRG1yoF4VNcg0zwj1bE0NJA
	mS1DqcIQ4ZBFQuUPrc1dcSMH5vkoo57KJgLQ9g2L11h+AdKXIWQmdVNDvWBEc2kIZS5kPSZeZZR
	TY1Rxea6jBEmjv1bLibM8rTV8MXU1aQ==
X-Received: by 2002:a05:6a00:181e:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-776121ec346mr1687412b3a.4.1757678079350;
        Fri, 12 Sep 2025 04:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzCCMI7c4SuCgUNoxpx0ryUhDrHgck7Ry4SOIXMr3U9+ASTVocgB9v5TDYgVMzzCnDhSBlA==
X-Received: by 2002:a05:6a00:181e:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-776121ec346mr1687392b3a.4.1757678078920;
        Fri, 12 Sep 2025 04:54:38 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46b7asm5251168b3a.22.2025.09.12.04.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:54:38 -0700 (PDT)
Message-ID: <d3743c52-4e84-4729-9f64-af856419d504@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 19:54:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: dp-controller: Add SM6150
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
 <20250912-add-dp-controller-support-for-sm6150-v1-1-02b34b7b719d@oss.qualcomm.com>
 <sx64y6vfov4yag46erckpbl7avwmqlsqt3siebckn76m6jqxjh@f5lueyih6n3q>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <sx64y6vfov4yag46erckpbl7avwmqlsqt3siebckn76m6jqxjh@f5lueyih6n3q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hwtzv_M1XQUvvq0yQUBLKF-bifurTitG
X-Proofpoint-GUID: hwtzv_M1XQUvvq0yQUBLKF-bifurTitG
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c40a00 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1DKY8yufIZSdyzbmga8A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX0bRujqdbL2Ke
 zSFEwrhXG4F6GWzv7ijUPnrhbgy5ARLpsJ8wwZAEd54S/X9EaNm4zHEQcnjrnfJpZVaylSO3Tt8
 wY0QoDWVF0cWUWS9He8wGcrcA5zM3hrVm99a/NFon70aOv6maM/DiStU2AKkVBX4EO70dPcwfrR
 ZtBOANzaIb3K23JVKC3YY7xAwrfd6xh98/wesK9fn8n1siyKJtv7ORh+iHpqJZjypbn7dLQwG26
 NVM5/4lm8sTI+7NAtAUv2tRsTeS11ToTCHcL0GTdvXUTAQzRkZIqWn0dL6QJeu3x66hfPonqVrx
 xCJkyzcRvo66CXOE4aAb1bB6PivGZWg542KZtJvGi269tl3mPaHzpZ+kVvtsIR1T5ZftNwmTMGV
 zA+I67Dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066


On 9/12/2025 7:46 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 12, 2025 at 07:39:16PM +0800, Xiangxu Yin wrote:
>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>> SM6150 shares the same configuration as SM8350, its hardware capabilities
>> differ about HBR3. Explicitly listing it ensures clarity and avoids
>> potential issues if SM8350 support evolves in the future.
> The controller is exactly the same as the one present on SM8150. HBR3 is
> a property of the PHY.


Ok, will update commit msg.


>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index aeb4e4f36044a0ff1e78ad47b867e232b21df509..2bebc182ffe348fd37c215a6bf0becea11e5ac15 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -46,6 +46,7 @@ properties:
>>        - items:
>>            - enum:
>>                - qcom,sar2130p-dp
>> +              - qcom,sm6150-dp
>>                - qcom,sm7150-dp
>>                - qcom,sm8150-dp
>>                - qcom,sm8250-dp
>> @@ -261,6 +262,7 @@ allOf:
>>              enum:
>>                - qcom,sc8180x-dp
>>                - qcom,sdm845-dp
>> +              - qcom,sm6150-dp
>>                - qcom,sm8350-dp
>>                - qcom,sm8650-dp
>>      then:
>>
>> -- 
>> 2.34.1
>>

