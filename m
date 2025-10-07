Return-Path: <linux-kernel+bounces-844100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA01BC1011
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C1FF4F1334
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5642D8DCA;
	Tue,  7 Oct 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hU22RQAO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6A2D8399
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832665; cv=none; b=LiViGaGExNWiiRCu9U7xADlxTUMSNp5+6xWi6HXW4f9vEpC6YJZJCgusvWUUgT5PA/8/2h4Enmcr0YtNNVOmShfdYB12PCp5WEOnLMQqQamulNESB7MYZJIZ1W0MC0Jb5UbGgNnzHUr/jf2pqWACtAL4K8UG/M15T7SqxRijP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832665; c=relaxed/simple;
	bh=Hz0Lw9XoJxxpUtx9lMNm5Vj6GKjcPnXjgaggtSuRo28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvhVpo287cK6u3VWawGL4j+MFrwPg71aMCIPQPXo77ROK1WNnB1x4V/u8p5eXdAFLgOex7T1DvSavJPZd7myC67P+oOJL1Ms/Odi0q/xLVme2kikpsMJPNZMJ/VWHHGa7LQuDOuRfZcL/WxFfRVgwU80QjpSTDexBfjDAOfchxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hU22RQAO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5971xGSX011762
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hz0Lw9XoJxxpUtx9lMNm5Vj6GKjcPnXjgaggtSuRo28=; b=hU22RQAOLlj20ycM
	Lbxfz4cMeFzA0X2Ot+4wz3AcNfmsC5lxP+YqcYQqJRyjxRwBi1dUV4AgDGHT+4aB
	81hRCV0nIgmAhXehfYcBEL8gv2qDdblLL4a96ufjvUAfxTXzpe+pHwBNHye+NcSQ
	JsEVjKFN4oGDGQfzy1p20pESqAPrFYaQNt8xAUePTMRGhUeYtT/5MAmaSbHjaffC
	PiIThhhvXnaJAMmwGvsIGVZntwV/y9Ws++NNiGk93spi4n5lErcoqY7+oNG7OnCp
	89v5Qa+SV/5GCutVILDVsDQJvvwsXqnnd6sQUbwNWkT9jT1pcieHlQ/1uoIOsfxr
	Z4N8Tg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dy2qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:24:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7cc365ab519so16661166d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832662; x=1760437462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz0Lw9XoJxxpUtx9lMNm5Vj6GKjcPnXjgaggtSuRo28=;
        b=fhrV3OGPrhzEz1u2+yXr+ViWhmIB0oliEJoIyX3Kf7ZLx0GTHw4/Wmm+t0y/abbeew
         cm8g1+WN1+t38nxOdQn0wXLgieZe1ULWv1052SCVE5xFw/Lhw6BdfvhzqOPweIEB3spB
         UYl66E4Sx/9i5AqCn7YfzUDcXYPCxqNdy5/rK76TUC3X7+VCj5W2BHtt+msntyGyG7mV
         +31CX6vCa6+28ZGrwTcwrws7MgYH+mo7GrxhOs70dmICKeXxYN5LOTyAtlBRXMAWEeNH
         YwbPWi0mpU7cyTMuk4ZUC8JMPujGIrJw8IfVt1o9KCv5u1v60axx4zIilZFAtWHttOfD
         t0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWyxQc5sL2alDNHV5hZpnjHVMljfUX1jfSkd4FpvZmo9l24yM+rJUpdtaVFqmz5rBNWVIKbftnIuwlIa84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrp2jjT4pIdOiR4o6yt6B3//YjhiUt6jkw/Ngt306P/hyr+tF
	POycBDJQoyfijSiuDG7CDHMZIn5lijkyqaWRUIQkJ3Dt2v2GltiqOQud333yJbyl09lb/1a7McS
	30dFDYboelx10q22wZQVr5piWaLOtIuZQE6qmuHjsjzmtVIODDZMu8K9KKiKfWNEtEUY=
X-Gm-Gg: ASbGnctvfN/wJVUykc6KrRUtG19urCbimqD1/0KMJU6h0381iyG4Q2fpkF7SAxgAE3X
	GWcBIDsRI+i9tcRM30DGFE945/DhJ0l+5geAWtP+AgYn/hqXw6zOmuLYXFBR2dBTht4Fs4pAJ+5
	dNS1580/eXL7Pv/gpIKIGBB47lyMyEmLcmgkcgYnADHY0ASct8awn4UHswGOcsKUdTfaDj2+dK7
	mHLokX+GokjkSssVMCFotPPP1LsM0tXatGbYET+MFy5wrnqxdIRxlL9xUPsgO1JGQEP1tsld0vR
	LEZ+M/qXnJwnyrt8Z7cqDX2CrVDVqYUNIz7uA/G/dlCb/AVHHaea7eJNVl1XlCJ5v2XImbtu5kO
	I1NCVN6GYvveDMviKpPG9gznE8oQ=
X-Received: by 2002:a05:6214:230b:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-879dc6b708amr132820196d6.0.1759832662376;
        Tue, 07 Oct 2025 03:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Zrt9GJ0jEKgSzWhbAu8xtMsQTKHzxXFf3iuTYiuMvNb+I+Lvf727ImsmH4W3gKxk48yO2w==
X-Received: by 2002:a05:6214:230b:b0:815:e14a:1f44 with SMTP id 6a1803df08f44-879dc6b708amr132819936d6.0.1759832661751;
        Tue, 07 Oct 2025 03:24:21 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881011e9sm12024316a12.25.2025.10.07.03.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:24:21 -0700 (PDT)
Message-ID: <64719a5b-0747-4f3f-9bf9-c04900a5e0e5@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/6] sm8650-hdk: Enable I2S for HDMI
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
 <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org>
 <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e4ea57 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=T-gaThBTW-us8SvG3JcA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZphuTMPm_a1DIicXgzMmOr_oJyeZ_Ke6
X-Proofpoint-ORIG-GUID: ZphuTMPm_a1DIicXgzMmOr_oJyeZ_Ke6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX0GIOrq9ShKP5
 AalC5Q0kbKGqCT69foVyrB4eKPjyGqWKa1pJ9MFFkAmbifksYOIumr+kCYKRpz5dVVH/wuL2yfG
 wmgQ8MAI7yDdlgdK/DcHvDKu5mHhSXfanl9ftg7tcK5n42FbF+aHGWCTOBoeitWCmMKfH5XGWnr
 1uV8xTXiX5d+uF3sK2+M5el5OQQxK8wsIwI0Xbzdh6ZP7r/kZuYaH0fRbSBlBr0aYmFimVLHlq2
 RfxIIqoDsXYZ2tGlKiRTfxeUVqPheo3swjbNIBo71slJBYxxYR0auLUczW8eIvVdbntb7H0YYIQ
 N0qrjENiMBgsEHfiuY8iglZiYPYNQn3rrYa3F8iGieeSPfZ4cbK/e3TDqxMeBaps78nV+iZ07bu
 +N5PkBc1wV4hcYwrgRW7dChmEUFu1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/7/25 3:39 AM, Alexey Klimov wrote:
> On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
>> Add the necessary nodes to configure the right I2S interface
>> to output audio via the DSI HDMI bridge.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---

subject prefix (patches 4-6)

Konrad

