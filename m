Return-Path: <linux-kernel+bounces-833976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF21BA3774
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB41A625A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39704285C96;
	Fri, 26 Sep 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VuRMzXKU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA01A2398
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885581; cv=none; b=f6RJ9y1tbG4vso9Gl0f/AvaRptQ4S0HHWqlIay68UD2reZSD1Bfy5YAZNF5maMP4ns2US9aW1LzQsC95JHEwj+N1wzuAHE5bCWp/QnoKzUzHt9lKFC80xVoi7dpfWozgp+GRTEdMWwARVSo+TKGavWghMhm16lf3cGauFyPTmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885581; c=relaxed/simple;
	bh=0MA12SMzbZdT4kPY6eeM+o3pTZwdB/AFBWR34+cl6fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2Q9yaXuPEmcf5C/yCOGa6Nv/dQEW844rhiF+hxQHaWA/Yv7WT6uHyOUOmR6mORCMqo27DlN3e6y281rjzhVzq0kLFirA48UT/7XSyAou2U6hcuXoOsxpLIhFA9yzxOQTH1foifRadNQXB/54tmi4o8Qf5raYzmvRpSfSC7dc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VuRMzXKU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8va0h002627
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A5iw9YhdKL6U7cNZ5d6DnDVFCM8BMpzQyf8d10H9FDs=; b=VuRMzXKU+gnS18kS
	t5LtFfQUglj8gilOALItOfxuzM48Em5gZ1ZofU7Vvw0ZbxAqkRCovwih9HX8TQKu
	FaTxdCQ/LW87dRqmFEaweEukAdTFhSLOJ91kdKfNLVpGzcLYJg2NOF7XoeFKdS+O
	LDnPvlanG8tL1uXevx1Kx1uCB2+1adPFhvoxdl6m8PuluPpgKAz8Kh22+AZJcH9L
	1rRELJOCVp+TKbhxL6vVYPfPFORzEDnfOY/iL+2idFT5/+w4t7hn+8vrI/3J2qLo
	MNBycUZe9CkjCPw0pOiEqB610w3plVZ0jcext/idrT25EVFsgg0nYB+WaAPxbCIS
	t7uHYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u2mqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:19:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cb12718bf7so5530701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885578; x=1759490378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5iw9YhdKL6U7cNZ5d6DnDVFCM8BMpzQyf8d10H9FDs=;
        b=WNuTU5x4FzPVmFfp5PRrCJBh771cGtg/vZ4tkQKqCXckp0e3EKruIKvIMp+CN0kRD7
         0CNBy/DB/4EEwrgTnKWrZeWwG3BdwP4N+qbiyoSR11wQ72uLwur2MGpnvvKTo4GFEyx6
         DF4iH3wAZS6e3n8E5QmOFdGsGyyW9ZtQq9nnRZkbiGZ4ZmgMQbogSL3rtmy+sEErHp3p
         1H4jjArMwumnbvg20ezguPcnfYK7biS/f9Oa3HtBaCLtWNFxYn+kLH0uLee1Suh+Hiia
         c8ffgiWpkMN1mwj9BDyAguQXZFvB/Ni8AH+XxRmv+v4+ld/ZeS4gPPLsAlS8n20Eujnq
         V0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgOhWCLueuGWaIQutILafrVafH83HFaFIVymSXMNv/6/IJfBKVw3FgLjhhR+fKXnyVNKT40Bd42aGzNr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkvGIbOJmqx2Oexhp3r7Sqtaw2kzzkcAQV1wGLwFazDkxoG9u
	ebOkU0TuGdjwM25aRRwVTY2X19Xhq/9meBGiSk96UVp0Lbp72gKovyk7SJCCwQ7xMy/PLY+OjJq
	VZdRS7gMnWfgNu1OiYZqWkAHpTyyDxV5ahipOQfWHvyyxTisVpo8Oco7B2erzMAmiI74=
X-Gm-Gg: ASbGncsYvs5u3hz5sR3NpmzO7CrJ5o5/c5u7AGWrrnwX5yL+5ZAkwhIy2+50S1BbWQ/
	Sbh7oiHOT4nXEAmVokEZOtfinibjoz7KdVV4rdgf6kzwyKlWYOQgyoUrBWd4zklYJ5bAj3hMUIm
	UoEwuBZePuovJtQrFRGwd3qg4lOjULxWyE/gj6+1yf4RBGMMvvMl7kebO/0Z3M6bX6tULBl+oJR
	i5sVgnkQ+HcnNiodHy14wkcX1gkbH1b0XjcWmzx3iN1vToc5w05ChyTIOILCMjApEV4O+ROddTW
	c49/WYIaEBenycTq2kUzbJA0hgChIpsWbqNfQdOezGG9JSk9Pik1YI6bTLH7CIfKEg3ux8s80G+
	nrDe+XdvjneeQhAzFbuN0OA==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr64828241cf.5.1758885577785;
        Fri, 26 Sep 2025 04:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrcwSjz3KqiYGa3gmDGxvngYxxkxyuMkovjao2QxnzsDzIGy/cWZ23JNdN4fAp9j20t9gbw==
X-Received: by 2002:a05:622a:24a:b0:4d8:7b08:64b1 with SMTP id d75a77b69052e-4da488a2d68mr64827771cf.5.1758885577245;
        Fri, 26 Sep 2025 04:19:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcde34sm352788666b.73.2025.09.26.04.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:19:36 -0700 (PDT)
Message-ID: <7f61ee13-c73f-4b5b-918d-288368ac2cdc@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:19:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/msm/dp: Update msm_dp_controller IDs for sa8775p
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
        swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
        sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
        alex.vinarskis@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-2-quic_mkuntuma@quicinc.com>
 <652595ef-ef79-4c36-9979-b536ca65e1de@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <652595ef-ef79-4c36-9979-b536ca65e1de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FZwQt_zx9f93vieSbAfgJAbvBK8RPnms
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d676ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=JnFwQ0sXLtjTzmeIXpcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX/LFiFyOb8p7L
 eyPP8aUcVyIXsNHc3vZB4jyY+5PJMxqb9t3K1DTJqejr42zRcEWyt8u9emrzbXAsjgUnPh5Xktr
 4o+gP+TYTftzkwD1l6vHkbePY9R3WxeEvOm1emStzYgX3Y0TQALzP6L3FbvuEub0QBOfDlV3954
 pO9eyKaRP9OROifJJFqwspo/6dexvSiGPPnwFV8DN2OpKZv+ct7Q+vGKy8H6Dy/jjOjqGqXcydd
 EQHY8nFasD1DtKzl2l2lCs0yaTYZbmbdtkJ7bB58eLVF99mKFn63p6djJ6+yKgIa6btCaoJrU7a
 HtnM2Ip6CbPYqsJLHI+O/2YyVhAcvIXsQYGx+gj+1CEzo0gDG+csOvQE30WxK5UV2Z+9aZUWdnv
 YaLjzswYyC7PI52ZYQehT/RqhHya9g==
X-Proofpoint-ORIG-GUID: FZwQt_zx9f93vieSbAfgJAbvBK8RPnms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 1:18 PM, Konrad Dybcio wrote:
> On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
>> The Qualcomm SA8775P platform comes with 2 DisplayPort controllers
>> for each mdss. Update controller id for DPTX0 and DPTX1 of mdss1.
>>
>> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
>> ---
>>  drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index d87d47cc7ec3..f247aad55397 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -133,8 +133,8 @@ struct msm_dp_desc {
>>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>>  	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>>  	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>> -	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>> -	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>> +	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>> +	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> 
> Well, did you see what happens when you try to plug in a display
> to a controller on MDSS0 and MDSS1 at once now?
> 
> (memory corruption)

No, my bad. I misread the code

Konrad

