Return-Path: <linux-kernel+bounces-760001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACBDB1E578
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A77720F02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4359268690;
	Fri,  8 Aug 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrvHbZqd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44D1A2381
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644540; cv=none; b=Ma1xNRkVo6+OlDJtWai9WOxGkqoQKP7XDeXPHKXuYaGE3LOmmS+OUqpNJT0UIbI5r/yFVqz2DWnzQrRTpRt8nFMwxitrRe2t85d3AVRQldRLPtRZv6OmP+b+alW7NwEILx4hJafWbUgh6jKjkO7BMrj3q96kqiE7cuFOfgvCX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644540; c=relaxed/simple;
	bh=bcB9tpsziJnAd8Z5RsgzutbjTzohLRjuG9QBGduuU9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnBydnunThrgfHNKqzpzaVdae0h0QMw1towHvaBt73q7P96JPii8Rrmyu89Ai/s12248R8Wg5owcWqmKOQmAPhQzcE8TriHiBkVsb+2EFLh7+ug2ZyxtW2l6kyeX2BJ7F2vCQ0gw5NRxhAECwHjagS3zvy7Ot3ArT8jSm6T8EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrvHbZqd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787EUr6008004
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 09:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NMDS7aD4EfSvU8EK/J3yiOfJ4VZYy3Dm1qZFyL4wKEg=; b=DrvHbZqd928p+NQm
	Gpad0WKzkCjVMPa+12yXfJqLnHhPp3KFFac69VrvBnrstDVayPbP2nLE9F3Y5t3a
	+3dPBpXmqKEs/Mnf7Ib6I+oHQWhLqRYQLtLJyuTYbHGvZPEGIqUt9u2GnbSa6Wmf
	cbtX+pxH2Ktsuoeay22EYX6zN5vA5L1SU/cxHyN+Db2ofkIb597rp8plyLMe/qBM
	31W/z7fdpDymqmitqhydc/R2+8kN0zVyd3/bTvO2iVZXUPyJ1AztR24oQ1YWCN47
	K9U0D2GLJYOmBVteNIXjimjHWKc8ICrLGQImhwviR2oXfspvIQyVJg5kAb5jBpk0
	dJqPbw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy71f1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:15:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b38ec062983so1561375a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644537; x=1755249337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMDS7aD4EfSvU8EK/J3yiOfJ4VZYy3Dm1qZFyL4wKEg=;
        b=Cft/Xejpxpft3xL/Ch2ItbBBcmy+9w/yxuiKQhPI8SsbobpsLDYTQf+Y+NEwIh/u3h
         2MI+CuWRUlcODJxZq0HbynANWYdV8UMoIkiLO5czu1/lcxQ6EAzmP8DWvvINbZPCQIwL
         mYgHr7pSCtUnFxTvrKCjWqSGryxs0FCcxDN5zuq1sQD71d7Uo4hjVqeDZkJNcgZO/hFG
         4eiTUDs4qAG2wrgw/KLgrarYsYxPKi9q7KXbis27vyfbrypxTwwCd7/dhHMHnFdgQTVM
         u3R2rVqMDNQ23UihHdf97N3GQWM9qQpg4laW+rBmBTzgV+JVpwMJdWLcsJQjLsIm97Qh
         xNUw==
X-Forwarded-Encrypted: i=1; AJvYcCWFVvApY4sUD62B13/NGDjjEzzg7j5CvFNhdrSrZH4xFgDOaj7RpcBkOiW9s/GMRGrvF//yXiT41eg89F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqsMKDmpRKxY17o5axYvFsfcgzyQVaHIpWuptrhvXeIcPiUOF
	DATN/aO8T/HG+/FI0KDvoSjdcC5oWVCTC+6/Nbhd7KZkv355ONNW27xt5fsN+SoFKfa+Zr9j16b
	jk9L2xraLRTJ2UxXFUrWUk6ujhbgrXY/Flv2fxHgpqc9VomX6gVxXaz19CbUnxhvoXIs=
X-Gm-Gg: ASbGnctQdVtMOwiaXEEvClys2gue3N5X0jHjnhEH3Z+K69MEDrqE6bu8QSKyizAirE3
	qiA1Y7K/R16XXAI0R2FVK+scujaYIg8RMwNOIblLdC2DJH5DYOLJpYMmtDowMqtYI2YuCszFtEB
	xinvGzf8w5P1iMlR+QHfk2XFa11Bk/rzrh0qpHqENpRIy5JjmjZJ7cAe7F+xOwk/YecAlj5lC+w
	WlmIhG+MCyDA5IskV95sypBOwTUFgzG4fk+wuWm5tHEljHGAPMEsD57UpSfvpbEUh63uGHK5bJx
	TbpiTK4g7R/QCdtegQjePgg8Sm8N68ctQF0q4EvHvMfUaFy3RL7F3pu/Dd2ZsMeRbC7vnBSo9+T
	w/g==
X-Received: by 2002:a05:6a20:9147:b0:23d:ded5:12b9 with SMTP id adf61e73a8af0-240551a4ea0mr3443750637.32.1754644537198;
        Fri, 08 Aug 2025 02:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpKEjpx5US9jFpxWamPfNIopdhgz+RisNsrMCz6kl2jFUJBupKqUB+LZ0BiPnNSOjPs6qdzA==
X-Received: by 2002:a05:6a20:9147:b0:23d:ded5:12b9 with SMTP id adf61e73a8af0-240551a4ea0mr3443711637.32.1754644536740;
        Fri, 08 Aug 2025 02:15:36 -0700 (PDT)
Received: from [10.218.21.68] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c3f85c720sm2630514b3a.27.2025.08.08.02.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:15:36 -0700 (PDT)
Message-ID: <c2ff39b3-b7dc-4fc5-83e9-381b8f55fd60@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 14:45:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add lemans-evk and
 monaco-evk sound card
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250808052939.1130505-2-mohammad.rafi.shaik@oss.qualcomm.com>
 <14019ad9-0dd3-49f5-948e-5d0330b764c2@kernel.org>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <14019ad9-0dd3-49f5-948e-5d0330b764c2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _zk7sIeSf_uR9nSWKWv-3b0UuHOHwj3k
X-Proofpoint-GUID: _zk7sIeSf_uR9nSWKWv-3b0UuHOHwj3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0/zjVujfXqzQ
 /X5pXeWLlfXEQpQyTXCVUYp6mmhgZ+wczet+yA92dN7hCmVpcNfE6LzeuV/2QEVX+/spPBJ3ONw
 J5QvOymu0F+vVjGDrEfK6lgAGBWz+H1PunRRTKWmVw+YPH+Akp+JUp2PECTc2mFe1CHLYtckX7Z
 4HgM6yzimjEO9DwY22O4IyM1NHQ8AqWmxZ55TkWqCz+2ScKNNgswYqqbHqhWfylRPiEiS8I3674
 MKqbe0zy1/FfJwOB1S58Py++HefJLhGx7o3NcOo/AeT17yoTSzLSd01anlaDOXAYuSjekYwFGEH
 mYphQdJ6kgeCIM+JyaiPaY4O42N3/1lr2ZLHtPHqC4Ypizr32EGKg68VcvvW+KqdkvxMVFxQEfh
 6K8PwlKF
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=6895c03a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=63-x6vtTAcyCGrGXyLsA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/8/2025 11:44 AM, Krzysztof Kozlowski wrote:
> On 08/08/2025 07:29, Mohammad Rafi Shaik wrote:
>> Document the bindings for the Qualcomm LEMANS-EVK and MONACO-EVK
>> board specific sound card.
>>
>> The bindings are the same as for other newer Qualcomm ADSP sound cards,
>> thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
>> is separate.
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> index 5d3dbb6cb1ae..c63bfe031b57 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -31,6 +31,8 @@ properties:
>>             - fairphone,fp4-sndcard
>>             - fairphone,fp5-sndcard
>>             - qcom,apq8096-sndcard
>> +          - qcom,lemans-evk-sndcard
> 
> 
> Lemans is already there under one of the QCS cards. I was told it is the
> same, so you do not get a new compatible.
> 
> Monaco maybe as well.
> 
> We also name standard cards per SoC, not per board, so evk should be
> dropped or commit msg should explain why this is different.
> 

Ack,

will remove the EVK and keep the soc compatible.

For Lemans will re-use the qcs9100-sndcard compatible and

for monaco will add the new soc compatible (qcs8300-sndcard) in the same 
series with updated cover-letter and drop the Lemans related change.

Thanks & regards,
Rafi.

> 
> Best regards,
> Krzysztof


