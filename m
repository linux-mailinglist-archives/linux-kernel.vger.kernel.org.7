Return-Path: <linux-kernel+bounces-846236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F6BC7574
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AB6234EE0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D81EF36B;
	Thu,  9 Oct 2025 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfH1KhJz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A11F30BB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759982512; cv=none; b=Y8mV+FhDhX9Qgg8SXu5zX6VSDZQVnIPl2MZdM2GpNofgqOwhmCWMWXDhl2QZ3XYiET7Xrs8S2khn3Qw8501A9h6lG/8PPrs6d+jOlYlputPWyRYGdp1Wt0hCKitJLSn7oEqIvpHyOqTPmM9U/eVxyDTVJyr3eJNNssezsaqeGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759982512; c=relaxed/simple;
	bh=a43a/WOJy8uZXXez1tGKF56g5QwNfcVFfqzFknkXgos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3MUkFrfhRJfpYVz0agFBBVuL7iqM5pv1o+suVQcQatHVq72Nsw7TnMJLBI7dhcI/T9Zg/I0qTKJ02hKaAu/mei1ESiPonitIxRCSCzZ33tjPq2dPsyEjI2bHfgOwRXn4CbHgY5kMBYJaGKulP2YsX+z9gYfm98vAcVMSRfcOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfH1KhJz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5IFx019524
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 04:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xMzD/1x6I5Sm3TA9hm1nmCUR2NzvzpGDVrWP5NKJhvE=; b=JfH1KhJzxJhL5G1g
	Dui3e2YHuM64f9HyO0f8acVpeOmZzPIWh/rUHLjVw7x8zF8J0d+2eFPXGs7X80g7
	KOOFPeuxYNP6aIQbrcVHw/l2RoxFU1qlAsLo58ac5qtqLHuVmhgetSkIvg4cNHIN
	bFqBX3L/AliwnVNFrkCTEYqhKD5WJYTMNxGj07zUVjGqnE28zI9hDaJ6m6jxE50d
	YzOWb5t3N+yiBUGDJSMBDDqetPl3tww9TCwLLLVGVxMd2Z+rKB6n1FzA5H2nM8b5
	YllpCtBGtiCN4IbSJWNxxZdeIo2xedNkb1BExmRLMVpsN4LNaPD6BTE2/W/6DIkQ
	0cCqTQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9a9c9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:01:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso640475b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759982509; x=1760587309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMzD/1x6I5Sm3TA9hm1nmCUR2NzvzpGDVrWP5NKJhvE=;
        b=HRiWcsjHfeYGjo4ngzscZdODdUWxR8SFIdOsJ7O5vz9+wtDAdxCz4wSXzmnE+bSyQ2
         VqYIj5ysjm6s0dim90YO1M6msMpArkNqbL+2ai+MO2FoFyzSx+NFTlksC/labLd/utu4
         I/nlRTP8G+vyb25MHuTPpSx+eJkzD+pF+qlqLVzheEl5Swjcno1cdwuNhu9c7nctsxI2
         YVNNg/7YwJ3ZV+Ch9jigksyyAFMyHif/RFCopGf3B0tZx38ZxF5f2Pk0lLx0CyaqKJR8
         35i19FFrRuxInqjA0IfaZ9elzYmIi5GtYrDBY2M0uxCeS2n3EMQZOgIM0i87ZXA+faYG
         D8iA==
X-Forwarded-Encrypted: i=1; AJvYcCXNP2xLHEkse11drlYdiOrTOTIYUkA7zPD2GD5f1BB1lWg0JvEoUdhw7lLx5nhRIbmb12TSSKL3105B3fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBFCPm3rlAPv9Mt3Ew8PINfmb2FQTBfFrlfYm8QDS7h54nQoD
	/KLmtSECwxMI/3gGlucLeqHtH2K4yU3OmZJE/1z/xligUIOvMrXHXqY6l0mlF8mFxON1Jz+SB5D
	7avSnVMd9ccHXlaqbRjj8k6C1xToaXAmGRa0DFI+P/F/yiLNffU6UWJbvbQ9oXHmBSzg=
X-Gm-Gg: ASbGncuavdTBccOoLRasothrpG5XJglss40GA83GJK0mXzVx7s6EEaTeAcx+pqM7C2z
	+y8TY0YS/iOZUahUcUk9mMmdeFnEqcPSi1NZseTjBJ9gU8TklXnp443uWLmW0xbXAeOIhc8kA+2
	JGeTYPjgydvLheyLm3l1hSKvFSRUZoRkh43XZE4nsBLca64XwGVVLu69yGQrvzEqD8ptxtVAu5x
	r+tgWAYFwXmZFDzq4QjatW9ISw8eoYalm9CAceXI60uqXSKpuiEb2jtXEWEeWQIkFTVeTchHwA8
	Xlo/2SGrKmq+rf++cCuVlxFN/pGWkyE3gryOYbDFcQ7+PmkN2RnvjBCft0dH8Xjg8VlfzUFnMhX
	iSq7lwYW6oHVFNtjHifCWJRnNO50E4xY=
X-Received: by 2002:a05:6a00:2e03:b0:781:e9c:2178 with SMTP id d2e1a72fcca58-79387c1ace6mr7086589b3a.31.1759982508945;
        Wed, 08 Oct 2025 21:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiVFGjSsBPmIHkzRmXqGgO1LptcNCD4ejfPklbEg0Tc6AH+hGC0RQoErXtmfjEstoRjisSow==
X-Received: by 2002:a05:6a00:2e03:b0:781:e9c:2178 with SMTP id d2e1a72fcca58-79387c1ace6mr7086543b3a.31.1759982508363;
        Wed, 08 Oct 2025 21:01:48 -0700 (PDT)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e22ab5absm1322883b3a.64.2025.10.08.21.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:01:47 -0700 (PDT)
Message-ID: <93491a16-0585-4c24-8ba5-0e4222efb5da@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 12:01:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS615 sound
 card
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
References: <20251009023341.27277-1-le.qi@oss.qualcomm.com>
 <20251009023341.27277-2-le.qi@oss.qualcomm.com>
 <c469ad4b-9dc0-4ded-9736-1856e44d21e3@kernel.org>
Content-Language: en-US
From: Le Qi <le.qi@oss.qualcomm.com>
In-Reply-To: <c469ad4b-9dc0-4ded-9736-1856e44d21e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX3bM0xrFZwKAx
 pfuRmjxRiI7YVrk6dj4RtgjFaVomCIzBaExQZa8sxpnvWCCcivyN21d0adlO6hny5YuNu/EgRul
 wFOau03k6+30443y5moAW87LV6CHyCFUlGAyne6AzRNW2i3F1A+7izT3XLGofRoKZ+SHe5uoCph
 N60iKTZ/7DPJYRfnu/YPD+nykbL+uStKPdkfl44FVEoHyl2/vwnDuh2rip3q62H7uVuWhE6VhYd
 9hZb5laQpVyNMtboZA2klfru5kl/id2b5IC4AQwPx4HvhdV5ho116DJBTPM/0tFbcuJb1RHM/61
 SQ1/O81YtooVSRoyMTgHygza3LaWnAKmxk0PxtuTacIxH3gnNEQnCwghettfmD9GT5EyVkqvkOd
 EBdfRFNyVgmzCwH+o3lJHFtfVFTbuQ==
X-Proofpoint-GUID: jzIcB3vdbMxJ--AcM_GvDT_ddGeSHaN7
X-Proofpoint-ORIG-GUID: jzIcB3vdbMxJ--AcM_GvDT_ddGeSHaN7
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e733ae cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=uooNEMFFsLr74DcxLqcA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

On 10/9/2025 10:47 AM, Krzysztof Kozlowski wrote:
> On 09/10/2025 11:33, leqi wrote:
>> Add bindings for QCS615 sound card, which looks fully
>> compatible with existing SM8250.
>>
>> Signed-off-by: leqi <le.qi@oss.qualcomm.com>
> 
> 
> Just clarifying: is "leqi" your full legal name in latin
> transliteration? It just looks a bit like login name, but of course that
> might be just my western assumptions talking.
> 
> Best regards,
> Krzysztof

Yes "leqi" is my full legal name in latin transliteration.

-- 
Thx and BRs,
leqi

