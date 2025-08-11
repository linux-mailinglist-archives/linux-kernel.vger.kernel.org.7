Return-Path: <linux-kernel+bounces-762378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DEB205C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844B83BEE33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101D26E6FA;
	Mon, 11 Aug 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+J0AC6q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6B26E6FF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908626; cv=none; b=AK2n+tic7o2Q/Yw8jVC6dTKrGHTQDz4y2UzlobW06GQQ9WkSy/TMQasQ3IyTBDZz9QpPXWShNcGk1C/G/YOR4Lc23vA0sVDwNYjnc/FAP8vtrIwA33zASww/Zrbi4oagVo8ilb5eBnoZu0/4t2/AXc145wUINGhLwmoITz0asa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908626; c=relaxed/simple;
	bh=QikfI1Y7UGLrmo/VJcTOMNHQlyxpRldmUGBXg94jSG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHF7eCaJB4fZZsnk+4Yq+ZMMirMRruR9+2VISEqt3eckdB4PzbzQmE0uXxbB5QyNT1yO8MtCxjYzhjgb+oynDhu0iP/3kPL45Ooy77f8wFhiK0Q19TsP+wJpWk4J+EUhxjU/lQN3QFLVLWX7WqxuEAE49OpkZgBNYIBG/hIShS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+J0AC6q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dLri029350
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6J24Z6vXIRBkYsnNDEpJUSa0Kgse74Ef/BzsEOsA0z8=; b=S+J0AC6qY0UYJMaJ
	M6vU6EDV5FPItVmIwf9NVBwbc9o9Codo30mkWYwcVGQWyxWl0jgPg18uBGyrwGb+
	Fy2fYPQnM2bKZOaIfSNMTM0KYtvB9nzs369FK0U6yKZnDJzs1jJk6LjRMxEWAe4B
	GOXFT0lBpwMDEep43ItDthHT0PzePvyi35j0EjRDIFdEe1iwAo4Mgk9+T4nBEf4+
	jfAKE2iX7wrPOEcfzOJy8VB0yXXeLH59HMGO6Pp9Y/Jhc0g4ogGoLWV4jNWClhzI
	9za1XRVtzlyJAfn/p08lkCjwJInQ6bndEb8zsPv2U94+eN4hY5kCqSCP4u0w2aZd
	y4Hf8w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbyy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:37:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7092ca7dae0so11720816d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908623; x=1755513423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J24Z6vXIRBkYsnNDEpJUSa0Kgse74Ef/BzsEOsA0z8=;
        b=azOX1lBRhfUYQ1Y/X/UMa2vtTXR3oInKEad4ULG63ZXq9uMo9VlfN8VYeXGa3eqU7Q
         t2jiao1I0k+T8uNuA28ntYYcgFjpn1IdF2GJCFYyd2hV6xhoPom4tZL7P2b+BBbJn8K4
         AQDzQu8b40wnSmQ+rG/utEXvnYQdzAGyFtf+ZRk9HnJnlRXX+NTLOm0hUyAED0A75uxX
         RyLSpYNRBTas8jMQrnJj9ctJajQt/Ckl+SBj1I9gBPVz3vlcO1IJz//mqEsXXpQa+eTj
         jYimPUhPdEZqQbaPo0J7KivZdg+6R7Pb8sGaW5BO+RTRa+/JsRmI5tnayfWeJpyjLF2d
         ObSA==
X-Forwarded-Encrypted: i=1; AJvYcCVhX7ie7h9r6S/AjivngocpB8v/aa+BoCj3pj/41/jBC2B/tJYforcCQ3ylY1gCKl0IJ/swqmkcsYYqoGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/3DWoFYp+pcvqQQOrIZfxtKo882l58/cpqFWoaZrshVh7DiE
	4lrio8vrFM1MlHMD1UmHDDjquz89Uu6UjdiyYVQM3eHzKcxed2tRMwYhUerkxlj1PIySpn47V9S
	uSH6UvmrKNmmvfuB6ZwoT4s2SgIMBoiNmy/lzt+fYnEcIH9G1DpYzpC/us+ZLnwhrRiI=
X-Gm-Gg: ASbGnctp85iQ+46GTSqnXJ7ycCl/Lak2HUhcZn+QKxRuMfMm+jMxhkFYwJNWOKC7JBV
	0PrYKfYJ4gsNJWwMx40EqIvyGscn+3vNm2/dGUv+dcr6PWhadK4OSTOZlpYsrIWnVY3AxUEh4f7
	Z0TFuEyK1DwP8HvQTWB8H9IVLxjv8JLzvuP46p2FN0ikutbmjbtsXBKmQMGxsidFj/AszD+OKvX
	65VJKTHvAauCaqHiZEftQEk+jvyOKN0Vy9YMtHHcOaaRSY+97T6I5270tsbgg3IS1fnrou/1GKp
	Pvxocn58HUbMd/LBK8o55R0uG61FySYPlzlpQOVdBqqYe5PS89+MS7EHawxVgduf1zCtxAYE0Uf
	M2u+1IZf3eP2JKVSFjg==
X-Received: by 2002:a05:6214:e4c:b0:709:5007:9f80 with SMTP id 6a1803df08f44-709abcb6b7cmr55987246d6.0.1754908623539;
        Mon, 11 Aug 2025 03:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTrAinsHS3lX6lpHjYp65jzzXK4FwsVNqOAIzUsaWy9noN4VK/hftIl5eBF7ttkBFQYzjclg==
X-Received: by 2002:a05:6214:e4c:b0:709:5007:9f80 with SMTP id 6a1803df08f44-709abcb6b7cmr55987086d6.0.1754908623021;
        Mon, 11 Aug 2025 03:37:03 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f245c1sm18271623a12.22.2025.08.11.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:37:02 -0700 (PDT)
Message-ID: <619efc83-37f3-4b4e-b756-c53ecd2f6867@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] phy: qcom: qmp-combo: register a typec mux to
 change the QMPPHY_MODE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-5-43272d6eca92@oss.qualcomm.com>
 <ibrupwvn5frzb4vo3eukb7p7pzonaxwhygshz743wmyrbprkcq@xcpt4ryzvwqr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ibrupwvn5frzb4vo3eukb7p7pzonaxwhygshz743wmyrbprkcq@xcpt4ryzvwqr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/rr8ObzRbkTf
 mMXxzOuDiZDfeR+93ouC/diB9iMD9WVWDmv5vXr98gWtVB41pwfGBUqjQhdHbLPnu51aNx5b3A/
 6k9ybMvRtc9rYHEtjGlrz9N1jTaN/5xyU818QAny9bwKeEQGEogdK9lVLPWFSCx3rtTMXjpaE8F
 p6GyXaPWbBfogYB7t/p8sDoxav1SeQF7cTorXEtxaSmJXZ6IRjMbdI+4pQawZKnYQUIjhFL4oaT
 nbzf2DvOunpimiI9biLx4aCOscDU8foP6qNVIfIxGBnRjW49TcpneTFVyGsUfWxVSSO5buH2k8E
 F9AG8fBflL2JM4J6cgaXJWxOWXWDrwBfzX/SJA/2A8zfIVAzgMJNOvGd6ASGG4sLUUD6S4LGvbf
 p610k7+Y
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899c7d0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ZHkuymcytaaAwfHE7G8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TKgUc1o1lUEwbhm19Pf6KrWnHfSmBfum
X-Proofpoint-ORIG-GUID: TKgUc1o1lUEwbhm19Pf6KrWnHfSmBfum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 8/9/25 10:13 AM, Dmitry Baryshkov wrote:
> On Thu, Aug 07, 2025 at 06:33:23PM +0200, Konrad Dybcio wrote:
>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Register a typec mux in order to change the PHY mode on the Type-C
>> mux events depending on the mode and the svid when in Altmode setup.
>>
>> The DisplayPort phy should be left enabled if is still powered on
>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>> PHY is not powered off.
>>
>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>> will be set in between of USB-Only, Combo and DisplayPort Only so
>> this will leave enough time to the DRM DisplayPort controller to
>> turn of the DisplayPort PHY.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> [konrad: renaming, rewording, bug fixes]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 118 ++++++++++++++++++++++++++++--
>>  1 file changed, 113 insertions(+), 5 deletions(-)
>>
>> +
>> +	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
>> +		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
>> +		return 0;
>> +	}
> 
> I can't say that I'm fully happy about it, nevertheless:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

IIUC we'll be able to get rid of it after the dp rework?

Konrad

