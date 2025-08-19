Return-Path: <linux-kernel+bounces-775256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6000B2BD30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4831D4E5FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355FD3203A9;
	Tue, 19 Aug 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVq0ZZhM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605F320397
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595309; cv=none; b=BqqjQ2b8+qjEAvtqe9RRK8YmSF3vrRSqQo1MdxTaGyr9eDGffFjBieup22q42YurTZQCquac9h62Ff0Z/NKIiDaQLrM/x1Qz9UbF8vx3OoluB7+WI2kPPtc5z+oQquDtkxyE2nEcv/JGbWxWEkFejO7r2k5tVjL3hs4bN1K7mgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595309; c=relaxed/simple;
	bh=MaJ5CtbzYcmSzaHub09dWgREZi9K9yHAnOoD4ZSx1/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeIBvhjTr1djRc/2Dpl97JW2ytT/X/SnZLPiWk6jVMWWCki1Ue3T1uksMn19fKpyzs1/qEpCi3J/ysWTj4BXMXsMuxvw0LVZiuqxGAkEcNbwitaBNO+oDZW3f/4OIGHquM4juXO216SMmrlp2/Vep57mFNC9gYOQSX9nOWC0Mek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVq0ZZhM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90gBN030574
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XeLoNElQRYDHRk++SgBPgdfN1LI9ODXyEKJtgngTUGA=; b=dVq0ZZhMETwhqEnt
	s9EfemQb6XzcugD0fg40sr83pH+2k2K+UZgvgtAqw3++2bTs7uSCmU71SU/ZjD0B
	AfsOk8hvc8Q7Kr81MndamSUWR2bF7md+pIjAgPxSGlFjYjbfFSsrlTJT7NXtddY+
	rnMEi8lGjgX8pt4zPAnjAZ1fTfPV29jlnqbA2zrbTwLMrtYmAQxQFTsTNV4fehh7
	nNOJVdCMl5T2Rcq6ZyCN407NxCXsuYu4QK37AVfeLuyZNIoxOvTb3xO98iOGtoLv
	DzynLzO1RjTNZMNMCSZhfThoyRcF0sJJh2RxMM0amncpykOcsHo0PJqKMTtdaD6H
	pJ5tAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunv6jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:21:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806dc88so128975115ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595306; x=1756200106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeLoNElQRYDHRk++SgBPgdfN1LI9ODXyEKJtgngTUGA=;
        b=bX9H0Y+E+LswwWZyBJTLzXQsIxb6u6cql1/QuT/oQTkwfgFOGt1GW+Deq4P1TsDpSh
         83pxiAbk+hpm25/Io0cBtnIJFNo3wSyCdYstxetObeNOw9rxYsU2vdQUJu3tmD+lJb0V
         Gn2JCSt+0T2spr9ZONA5VecX6K3K4TSf7NfE2efqnLdWrUpK9XzPRBudIzPPzutsTW7T
         RlFbg1Ru7lQdVsOIG3dWPtnna3PFgP5ye43uFV6lr0+9hi39TNruqZkE1ubjc5kOOxOa
         wGpACPHIalBuSqAFipwKQyhqCKT/FKccVuOUQLEvXkibL1PH4I6jJmdAVq0/h2XAwmZX
         lgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMTEt2Og8w4HjcQdtPG4dAbmkmOnjdfyDDV64p0N72u4ImjrlQMVMB+o0UoJyEcDfSFVBdQctLka/A5BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbLnPdsv3sf2YTk599kN3PGvpbanofEeIX/rp0lCjLHyHRmWZ
	WZ2SzDW3pq5tTqB1BnAeoCMEezAuMgQZlK2ZDYacYerxiNDofofE44TJqH+nh96xo2I83y9lubL
	iKJ9zxizpDobIgtYjOcaJq8lcgBZ7Ou4y9rKyBIpEAWtcQTcxP/iZTKF39yuXzPiAMgc=
X-Gm-Gg: ASbGncudyzCSuWhOnkntnac1mg0TZGNMCiPVGx56EEnkdK319F6XNr7qZHiWurQGCgF
	COYRcbk7dWRhdzEUW2adtu2stl2Ukx77c7ZYBKpp4Q9X7QjBJcPjcewnhMbHH5pnSAmmL6P9lQu
	/iW5i+WKEMJconUSgP0lQLz4RkUD44bh5W/wwXCJIuRztuMgqEKTPKlha13VTm4jINL3Zgu1stG
	vTNG171VCc3l7ucG6Q3ckV6PoaJT2MN/YgUU5oxdltmhEox/sUENg75NJmzhWST5YXfZSPlT1w9
	zL9lX2atberDlYEWNpWvRt2URtxIBBHWPc2tjX1c03+o9D7XTrJxV+BlNWU7jZpCu+iH4h26+6h
	qbBzbUGhYm//xABAtbZxsQhnsssYBAg==
X-Received: by 2002:a17:903:37ce:b0:240:4b3b:334f with SMTP id d9443c01a7336-245e04926b5mr26682965ad.34.1755595305601;
        Tue, 19 Aug 2025 02:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpiiFaPA8kQRfNSDplxINgiGA8HlGb5Wu8T7SwEDTnoUTiI6Noo4c+zpUmfz128LX8UgJLAw==
X-Received: by 2002:a17:903:37ce:b0:240:4b3b:334f with SMTP id d9443c01a7336-245e04926b5mr26682375ad.34.1755595305122;
        Tue, 19 Aug 2025 02:21:45 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446caa3806sm103046795ad.28.2025.08.19.02.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:21:44 -0700 (PDT)
Message-ID: <76ff9434-eeaf-4ee0-a8fa-aec566c46c2a@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 17:21:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
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
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
 <20250819-qcs8300_mdss-v7-2-49775ef134f4@oss.qualcomm.com>
 <20250819-ant-of-ultimate-genius-fbfa1a@kuoka>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20250819-ant-of-ultimate-genius-fbfa1a@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EmAeLOrBdSgop8_w7gdTvMPfuegQ_yBI
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a4422a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=b6vJvH-rrpbGiSTQa0AA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX2NK/zKSjy8cd
 1zAU3I8CpTfjmEY6oh/ZtmGf7aUUzeShfkXv0AJ31yHpJNYZOMnv8snazyV514nbN65rvrVDMxc
 MAXb74V+geBtfI78AMCdWWf5qv3X3r8idwox53vwJ8z5Th/8JfcvTQ26Ucf1HavYjtiRYgB8DhU
 gTd6m2ZjO5eMhbm74ePe5/vD+ZL/6YmCXl8B5WhkHg0NguCX7IV8A3BZjvJCg+6+tRF3QTTFL9j
 KZVOZ5g7QBZeyV5o3XRv9bwBwk/VxcBk6/dYMQF6MONBg6VVP84JFiEfFQ+m7cxvPaaZhtZev6r
 HKryj/j8n19kloI8dBMbNPV1EmGtp9yBNl3ZMhVj/8/Nu31brXs+Hi+FzB4OzRVnahl1Poaw7n9
 N4bELZk3
X-Proofpoint-ORIG-GUID: EmAeLOrBdSgop8_w7gdTvMPfuegQ_yBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071



On 2025/8/19 15:58, Krzysztof Kozlowski wrote:
> On Tue, Aug 19, 2025 at 11:33:29AM +0800, Yongxing Mou wrote:
>> Add compatible string for the DisplayPort controller found on the
>> Qualcomm QCS8300 SoC.
>>
>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>> with same base offset as SM8650. But it requires new compatible string
>> because QCS8300 controller supports 4 MST streams. 4 MST streams will
>> be enabled as part of MST feature support. Currently, using SM8650 as
>> fallback to enable SST on QCS8300.
> 
> I don't think last sentence is true. Where in current code SM8650 is
> used as fallback?
> 
Sorry, this more like a description error. As Dmitry pointed out, we are 
not using SM8650 as a fallback; we are only using SM8650's data 
structure in the driver. I will correct the commit message in the next 
version. Thanks.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 68a6fd27506fda004e53174db5bcc88a29e8d2a6..ac44abfdd2853393ae199387c9ae2c37e1c48f52 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -18,6 +18,7 @@ properties:
>>     compatible:
>>       oneOf:
>>         - enum:
>> +          - qcom,qcs8300-dp
> 
> ...here not.
> Emm, if we need new compatable, can we add qcom,qcs8300-dp here? 
>>             - qcom,sa8775p-dp
>>             - qcom,sc7180-dp
>>             - qcom,sc7280-dp
> 
> Best regards,
> Krzysztof
> 


