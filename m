Return-Path: <linux-kernel+bounces-803052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDFB459F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E5A3B0525
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616A35E4E2;
	Fri,  5 Sep 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gp3Jo45O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C941A9F89
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080801; cv=none; b=l/QM4xvavGh7CsTELiCzFTwkjD5Z7AINaCNtcF77JYH/z8wpPxdPNR60EtLlx4Oq6gxVWms2OTXwurq4BdBepWcf6edJKrcuBnT2A7aqOqELfYumW8XbDm5DH+m5WweG40qTaqn3tihCh7VvkoOsdysLDRLCPfWR1No3EC+jVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080801; c=relaxed/simple;
	bh=Nxs4jNv/0ib3sf+j4qyuTZlmnL6qwSijbxCkWrKUZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz5lISe+sFkw1HupI+nr10DKO3f7MBw7vTONK5ZLi4Lr99KvklS52jTmq7hXJo9G46MlF9pkGBR0hRGWhdPom/qaoWcYBQlYxYyDt/9J8jp3n5zYFO7Z8tEalV9eMfH/C72Qjy1d5gbmQLsbaw1XbTRS3ceEGdbxymn6KJNI9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gp3Jo45O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857ll8w012122
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ea05wx5yo8UuvtRp2vDxehHvL08xPw5lw2wd8l1MqSI=; b=Gp3Jo45Og9cQPZc8
	mNUvOZ8QlKcHamZT/P6ndQ1Aivt4WQ0l1FPQHQr0sZtMJW8VTlzpJ8gQEAcU6Qse
	DfZbI9wtsVB5MGbe9OA2xA5EMp2raLJlOdmQU/6qxwuhIPJJkebzR2SP4NOy89Gb
	fP28CDKE/197QdBmHbgNHUXju95thY3rbrwZZtJfQt01y2xkx8QfKHHdhToviT7p
	54GrW9k+1UCtuj9cLuDN5JsOtHxwmbudokWo+RKgI5P27hVDmeCv2zM1aebZjPkJ
	3Ss9jbW0bIeit2QZ4OHKO37tiTXKrGF1ABmDuhoe5CQbskfEHnF9Bwr0hkU1UV4q
	kTNnTw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj7ncv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:59:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70de52d2870so16320886d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080798; x=1757685598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea05wx5yo8UuvtRp2vDxehHvL08xPw5lw2wd8l1MqSI=;
        b=fysa8CMsuS8SxpmKPdlzr1l6Fv4caJ1dJKxoOJ/7u9+rWRYNwyiEdML8zOPo0Bulnc
         +zZfJpsUQnAyLg+VITLXnJYAQwdkQ+jLPYHV2oGFU5EINHRckpC7P9BZ5tuwVUA0Tp5C
         FX9eNwcPVMUuKbtxY0VVAFT/n1MMiccqEN04m8rD26uFx/HAxrMvFpEoAkfOmzqTV5bM
         jIXsZtTKUOXCoXCYdt5YH5BvNA9TSBxxIy8osNbCQjdaNRgTje7x+arkP9ijY4fTJ0ur
         Wmmn8xtBCV6DdZIWhePbGpe46q8Y4Ugj+N3NS56BWma03vygMVnW2Ko1/bNxdPAJDjmc
         hyFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0D3bpu2VZx7X+AoVkm68HBa0Q6X3iLus5tQcaDtsIo4f6qEuTcjYyUvTp0eklZghdV8y1Lo+L6MVEElc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJDPiRXhZU08eFTa+9rBZFCn2Nt45vmcRxBKYxIjpTZSxnuYI
	S4X+wDR/aAfeH/769Xos8VoYnW7AJlFK+f8y/Qfcngu2Gr2A0LnGhLROCnuzTyE9f5De0CE3HyP
	K8RleHh17Y9imJVtC1Ih99HcRh8Z61uNhdGxBvszMRJE6zce5ibiX19v7/vBg3ey09GE=
X-Gm-Gg: ASbGncuXgk19A6TsdO8kRr0CYkzQKfF2aa28LdtA+cfi4h4csMocsEY5wzK2jAQJJti
	gFpJgkz7afHwOEX9Gi814Pk3vjmZi4pSkuJdpOk20Og/pRIO85Q+Qwj37gfFm2mD7Ca24y7JGmG
	4hTZZBuvwNo+fEe2yr6GDxfkq/A/hAbNdOe9aX/fN/9+SXvantr6ywK+tXymCz7uJdd4Hl4YQWl
	iu9us+9Sqb5sKrvjUgKi7IEWIGx+VX2s/j2+fMLdqnZloMz4QgCRgoPtgEWdK9D9sEHtOpLpqqJ
	RZATcyT8gei3ZALJSMOS3ka6iecNazWKIgdD+kIWITrgT4fJCmnfABN5m1IQbsoTVDM=
X-Received: by 2002:a05:6214:769:b0:72c:cc04:c3b3 with SMTP id 6a1803df08f44-72ccc04c482mr24151156d6.0.1757080797897;
        Fri, 05 Sep 2025 06:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHccFczVmu2K/MQDGzAtfbcJwtC1knDM1QHNcoZ7QIDaLyWrv6egTKR2btgO1NsqyhBqXTIQg==
X-Received: by 2002:a05:6214:769:b0:72c:cc04:c3b3 with SMTP id 6a1803df08f44-72ccc04c482mr24150546d6.0.1757080797193;
        Fri, 05 Sep 2025 06:59:57 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm31898228f8f.27.2025.09.05.06.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:59:56 -0700 (PDT)
Message-ID: <a3785cf4-750d-44ef-afaa-7d398e00652f@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ASoC: codecs: wcd: add common helper for wcd
 codecs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-3-srinivas.kandagatla@oss.qualcomm.com>
 <kmm4e5bg7uehmlsgrfhzo4agr6ga6d5gxtpxq5sg4t3wql5p6m@llwyz4kzsj7y>
 <f6a631bb-d17d-4eba-adfc-4db08540f5a0@oss.qualcomm.com>
 <6igcrtfra6h75v5g3wucokxw3ncj3k66ui3jnhfpdf2lmxc3tm@3hzihrpgjaz3>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <6igcrtfra6h75v5g3wucokxw3ncj3k66ui3jnhfpdf2lmxc3tm@3hzihrpgjaz3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXxvRsZXytG4Xa
 lwxs6W09J/Ry3mYJ/lBk35P6CkkvsNnshsvwiqlIzLmbEHGLJE9cPt+NK+uF0QQY1qVp0qt3iPi
 XpbVWieR9/2Af5BoGeEr+7CrfOyrh9rL8cMmzVAEXsuziZ2V2vK4l6lU+0yT8MYCz/shC75PJKh
 kJtg2eCL5+DKlmaTxUic85PyZyL6S03TVoncJz95106VC1XsuT1azxsMCB97P8nEKWrsNo9yDrN
 4dDUSJyWZJCgWFf215nLLcSyztJa/lQnwpHxaGzeIprp84VG+o86kNM23DJcFuFeHhKz6667rNw
 RN1cnlC58mYG/+4EWDU6SddFkMljbdYumibqcM8q0vsXk810KtwgqG6CnGMpbWDnUgCct8a6aDS
 sSqbD+GL
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68baecdf cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9GHC5Obp58ijhVwBxQMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: Oxg5EOpTqM2Kaw4EJmesX1ZfanFtEPTW
X-Proofpoint-ORIG-GUID: Oxg5EOpTqM2Kaw4EJmesX1ZfanFtEPTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/5/25 2:50 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 08:03:49AM +0100, Srinivas Kandagatla wrote:
>> Sorry for some reason I did not notice this email!.
>>
>> On 8/22/25 12:18 PM, Dmitry Baryshkov wrote:
>>>> + */
>>>> +
>>>> +#ifndef __WCD_COMMON_H__
>>>> +#define __WCD_COMMON_H___
>>>> +
>>>> +#define WCD_MIN_MICBIAS_MV	1000
>>>> +#define WCD_DEF_MICBIAS_MV	1800
>>>> +#define WCD_MAX_MICBIAS_MV	2850
>>> These do not belong to a public header.
>>
>>
>> All the wcd codecs have same MICBIAS circuitry, this is the internal
>> micbias circuit we are talking about here.
>>
>> Actual micbias value comes from device tree, but these are min/max
>> ranges that are supported by all WCD codecs.
>>
>> Why do you think it should not be part of common header?
> 
> Because they are not used by any of the users of the header.
> 
Got it, if the ask it to move it to c file.. that is fine with me.

--srini
>>
>> --srini
>>>
>>>> +#define WCD_MAX_MICBIAS		4
>>>> +
>>>> +struct wcd_common {
>>>> +	struct device *dev;
>>>> +	int max_bias;
>>>> +	u32 micb_mv[WCD_MAX_MICBIAS];
>>>> +	u32 micb_vout[WCD_MAX_MICBIAS];
>>>> +};
>>>> +
>>>> +int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
>>>> +int wcd_dt_parse_micbias_info(struct wcd_common *common);
>>>> +
>>>> +#endif /* __WCD_COMMON_H___  */
>>
> 


