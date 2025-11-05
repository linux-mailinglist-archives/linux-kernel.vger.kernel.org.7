Return-Path: <linux-kernel+bounces-887026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE0C372C4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6202266197B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB132F74C;
	Wed,  5 Nov 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5e2Bclc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+qepDgG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CF31353C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363160; cv=none; b=HJLU0BAk6B+25G10tjga9SQERcf3lbNKkHE/yGgW4vh1VqxrYM217+mzy2ST73oWifYYKCasXQjjNnFtQ3NZTd634uhm4CHAx4h4z2C9vSSCe4bCdKQsTPTTcCPwozcErK84I7pN/LVkdJc+8HkWsbLkceSCGvppX/1FcwOUng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363160; c=relaxed/simple;
	bh=gH+IgiY5WDgW/EjcfxnbiJKK5tHc1KANHL2VeROjdCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mchvZZe5BOL8xEIvbKVI2IzMiSLiQ2Tv8hDEK9Xy0BRpT2HoXnpGg6b83FdWNxQ4G2hCgxhWlHMmqF3JP4suzG5lqeZTk3as7n4lYJY7dHRoSfRE1+0eYcnitOzPPum+rsUmAlTzxcs61+yW7vbkEJheAlvrxFF2GWOMtGM6Nhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5e2Bclc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+qepDgG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5D9qDW3915283
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d2jzqV8oJZ4plosAL5G1y0RTbjdNLT/7KsDqWwEv4zM=; b=R5e2BclcGpupn+E6
	eJr6HC4KPCNehHfO+/Xi04jG6UhWi77hYWRyBXtfApIR5iGblyE+8gQ+nt/jEvbL
	mhsU7wOdW/vXfopUc1TbT3Iqsqdv8LGkR4d/ECyg6lhi6hoqRDx0jJrymhRCgUbN
	eE5sI2hl1QWubnFQt6y5c6BnyfchNIb04uHICuEbLWMtW3oqI/C5EIu+K5QVgqXk
	qME0RkgcJjwQpByK8H5cS28W/DgJdXlQa5CEL0iLKK5AV8PLMwK9MS544hZG/7Pp
	YzG1GUl9O7tczvX5rvXW3fIGfLcVfCkTmYUfDDyUDO07Ki5UfcQLpYANF7iMzKHO
	DLl+AQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7y37a4aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:19:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33d75897745so527683a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762363157; x=1762967957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2jzqV8oJZ4plosAL5G1y0RTbjdNLT/7KsDqWwEv4zM=;
        b=H+qepDgGjE7K5ZQ+ZtKWx9zonXDkgDl+ZHxpwj8/7SNbqQJfhkeelANCieyZ0ZLVHv
         9/D7WQ/AhhSvBG872McDqtBu0qM8X2tDwcrQt9p/WyT6vLd404buChK2tAD/zQ3NyM+N
         Ak/lBk6PgWKHkrVxTG6gDE8Yqvt5nwP95Wa9/vh4f3zpzNAMpW7O9gHdWmZBakiFbK37
         nI77dGyGHpuC/kckpbGa469wOlIx96H5R6GjASieRnC5WnOCjgqlGCqnXp7L99wH9hjx
         7CSKIGQVGyeMMXyYSZMfl5B0goWLfcaCPlOt8C297QREtAohhF33uSVTD6aMYS1C8iIz
         s8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363157; x=1762967957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2jzqV8oJZ4plosAL5G1y0RTbjdNLT/7KsDqWwEv4zM=;
        b=VdL0p+mlMzSm3v3kGSfSKeomujNoIcino1ooiHq7oWvmaSdOpfE35sW4mRkNqRwhFI
         JHnn+H75y1+vQBz4gVnSIiquIlio8FYufRca+VYYF3hFyxtqlpKb7Aa1TKPM9aTXbX1s
         iFKUGq6iawv0DBAp4YVsVEp4KjjdoE9BM8k7yB5lDScfcjc86evxC+KuSe96yzbKfOTN
         PzgRuXMd6pSph2gosmqNSHTAHpBK5doQIDkiWQpDolwvbsgTd7zBg5txOELGuK6Mf2nh
         BGPC+D5MOZzpY12irCRQzYZ44Qqx+W/XHN/+49ShqrGW9YbwS1pDWhNi7qBd8xRMIv/C
         kMew==
X-Forwarded-Encrypted: i=1; AJvYcCX39QwEu/UGs7nITCTKA7WDTtjl4TmrOGbO90nbFtv6+hGi3gxWg+NYxh76zb3W/SeReHvHTGFk+E9vnHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7Bnn0XSrPIcvWmpMpeo2fWEPwfYMQyT86ucyR3IsAMhcSOqu
	pVXHpz4mS1wO2pstifNNbeYQfoaZNS0JqXleaGFL5JhwmlXi3XEJGCsMveqqcv2rbivNr2X6pvp
	Y7Ty+nNTpAemjEuh0Ebzg+lF5wuodWZbhv025i/pnZOk7ezna5IY8c+nUAbnhyCdFDj4=
X-Gm-Gg: ASbGncs0OXRvGDRYFTh5csaRDCaJCqEN/v7BN2GOgElQx+3AnAcXIj+cFgmK9cG8dRZ
	obXZuif6xPdFjOiuri6Uc8BJr+j3L7nuOc4+VBMxI5Lorjq9D2BsUL6XXuiKx4HzoeYa73015TF
	zEFmvyaefmxRpAK9uEmXsRgVuBqctdozxnAyv8cyEFtDSd32XMV9zzH/VTD3lECDSjKFvC73Qap
	wEZrjANpAA6tLqDZxzSjsi+AiH++5l4z822520HL2gzO7DQYlO7QJmoO72gchA6xu1kKUfocSRJ
	VvbsU+3zKs/Aim3YARBQWWPrRI2GtxE1TpVUxEm2OhbtURR3kxQjC4SAz+78Dbpkprilnnab6GY
	pQt6Z3HOVnqOhcg0b2bYlNw==
X-Received: by 2002:a17:90b:3c09:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-341a7012182mr5029896a91.33.1762363156983;
        Wed, 05 Nov 2025 09:19:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvzSRF+BBkWYVbOkPymWtRFgJ+GZ8PkUlrRHN+0DizYbOyTJnzSCGFEoQNIQNhQoPoiHhIfg==
X-Received: by 2002:a17:90b:3c09:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-341a7012182mr5029841a91.33.1762363156531;
        Wed, 05 Nov 2025 09:19:16 -0800 (PST)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1e7983986sm6231090a12.0.2025.11.05.09.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:19:16 -0800 (PST)
Message-ID: <e67bc77e-77f0-4744-a86e-73fc23dfa705@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 22:49:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] dt-bindings: nvmem: qfprom: Add sa8775p compatible
To: Bjorn Andersson <andersson@kernel.org>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
References: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
 <20250910-a663-gpu-support-v6-2-5da15827b249@oss.qualcomm.com>
 <8ff537c9-efa0-4aeb-987d-150bef8b7c00@oss.qualcomm.com>
 <bkhjgw4mtfmkatxjl7enn4fqqjbutealhaqgxihdmcvhekyyd4@lsosso5ta74z>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <bkhjgw4mtfmkatxjl7enn4fqqjbutealhaqgxihdmcvhekyyd4@lsosso5ta74z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Kxks6kVLw7pqJUGoC150k7q-0OUMmmg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX5r7FxTHf7NEM
 Be01fQBQSZ0CC6lkZgKqgjM6OSgyOKso723RnDyHf8q/nlQa5jGSjB6roprqQy5ziIG8v6QRVDL
 67Ll1BMZuynSpCjT9CSoT30dowVIJJ5Mu2iQoVT+BNWEUbxsEzHSKrvCCgv2mAXPRJlU7fA5evn
 f1jYMSBe5kdwGxDzxl5mr/0U2XevEZVa26DyRcbfSF9kwynCxVmmV/qJ/l3UvxziYVEsQ2yPNhC
 K1TcxAwMM+dbv5oBqKzWo8OcqbYHWfeBHQ8FmJTIACiE/04q1rkwxJsbdxDqqnignmn6riCSSOW
 FNZphqtYrBbiOet3HNgzLV4+ZNBlEtSh5zJe5pqVPh4/RFAxeaWDL0MRiSIfKaOZS44GPFj08ws
 CO9aZy7kirj38cH1oCbXarugVqgImw==
X-Proofpoint-ORIG-GUID: Kxks6kVLw7pqJUGoC150k7q-0OUMmmg-
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690b8716 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=kynJYrAj6unHVJukPU4A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050134

On 11/4/2025 8:32 AM, Bjorn Andersson wrote:
> On Mon, Sep 22, 2025 at 12:55:36PM +0100, Srinivas Kandagatla wrote:
>> Hi Bjorn,
>>
>> On 9/10/25 12:25 PM, Akhil P Oommen wrote:
>>> Document compatible string for the QFPROM on Lemans platform.
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> In case you plan to pick this up.
>>
>>
>> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
> 
> Thanks, it seems though that I missed your reply earlier.
> 
> Please pick the binding through the driver branch if you can, then I'll
> pick the dts changes.

Bjorn, Srini has picked up this patch today. So it should show up in
linux-next tomorrow. And I have posted a rebased version of this series
for you here:

https://lore.kernel.org/lkml/20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com/

-Akhil

> 
> Regards,
> Bjorn
> 
>> --srini
>>
>>>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> index 3f6dc6a3a9f1adc582a28cf71414b0e9d08629ed..7d1612acca48d24c3b54c4d25fa8a210176d3bb5 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
>>> @@ -39,6 +39,7 @@ properties:
>>>            - qcom,qcs404-qfprom
>>>            - qcom,qcs615-qfprom
>>>            - qcom,qcs8300-qfprom
>>> +          - qcom,sa8775p-qfprom 
>>>            - qcom,sar2130p-qfprom
>>>            - qcom,sc7180-qfprom
>>>            - qcom,sc7280-qfprom
>>>
>>

