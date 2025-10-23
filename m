Return-Path: <linux-kernel+bounces-866617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0CFC003E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA391A65A18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E235B15A;
	Thu, 23 Oct 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbNeaaBT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E5307AE6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211847; cv=none; b=hfq00+2mlaXFik1P8t8i48Thhw8eXzeZBZRe/yyiiYvu+BaN2FVDNg+G+Spbf+i7be3Xfm5AqXZgxzwg/BVLN38mGfm1F3+G/uQjaWPVnbQLZIE4X0RDDPHfhxuDjz2C9o+lCLyedt3pjO/A4zBxzLpkD3IWJmdmX4x0MtHm3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211847; c=relaxed/simple;
	bh=gDpUDiXrDas6zKuKFZJhSQFS5rIKPulwiUd2vxXh9MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+WLPJwcFM/D4DmW/4Ny8S7sijp5NdyysSDK197CExh9xah0x/PAPc35LSLBM2ENNv3vHdQZrxA0xheL7uQ0Bhi69gMszrWXn91k8DI5nJc3Dd6sk2EVuddCZrk8W2Tv1VxYT6h5d015P1kmio2Dsb+ecORbmJqQuEQWKl2p/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbNeaaBT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7B8XG026077
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvgrhya8OiRRBgIX3KTvLE88himJCuk7lyQHjo9ZbF4=; b=lbNeaaBTGPJafyi/
	nyzF4ismjyfezEmXhep83IaTcL6tanuI7Znm21t2ByjlsqjpPG7mj2zh2WxSmT9s
	9Os6es7xQowzcKhOlwIRFZooJl+VMMsukNkNAZTavmJnoSdRVX81GfgAMuG3+N5P
	bXIpjM414MM4qGuzXfFFajL9NtK2Zhr+S9tWZAXUHuUtad4yA3YGMNUejyD91/M5
	l1EdcZAfWbvj2u+4wP1VzhcjDg+L4OAwrx9/VlTq4qveH7N1zsnTupnT9apVG+Tz
	RGkiBAnu/ohYoGtZpokqqRZXxZu7xn5W4M+eIXE6dEb9vCB9lZqNPqgbjh6Ak0C2
	H16HSg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kfne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:30:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a4c63182so16394791cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761211843; x=1761816643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvgrhya8OiRRBgIX3KTvLE88himJCuk7lyQHjo9ZbF4=;
        b=xNZh0i3ee+sq7QEh3AM5+OZ+dmFfebcXGcOrdcQF0KrxMS2vTL9W3zqcY/tl1gNBGK
         DCT3yg3daDNnwl/LIhkUQkxN0ZKpQHDuLBy/yNK6B6jP/8Hk9mBQxs4zjKbF/l/Ta0Vd
         8Wyup0V8PeB/qYsxNBFjQ30oqNntba4/kQSObbf/TomnszSwaOld/bv3Geuiz3V6Rwd4
         oITwA+Vz2+bZa8U7F49sPNRGe3iFCDVPRixGGPhHoaHAGOdVfFwtDsWXqywsatDmLIgZ
         iCkJ4Jp79zctc8NL82vT/F/ks33R9XqqQp40c7tm6IgQqKc0W8BtBD/Zb1cCjzC1OQmb
         e2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbRB/TIx/l5MDY7LVuKnMOsMjYXY9sa0jzW8L9TUud4wb0JS38DpBk4anhT9AQI1Z8TvfL0zntYTof0DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXMNZVGnzpDh9P6iP8pQwwDAI+u7P/T57BU0EHlJ7uRMryIEp
	YnQ3g9y4Xpye7sJyYjE4krlU/NaCVeVYdn6x5TY/bv73M1lJg+tIYdTRglKBl6MsvcpPZGAZson
	5wRZbIk+vPeJXYzXHMKCeaPo3tKO5xKExDUhMqA+/XHTuA8/kGx4HNNZ2S5GUtbWEAr0=
X-Gm-Gg: ASbGncu4F81bd/STHxXY0fAcrlwIF3PmrHIqHsbt9wVTK5IksLHgTJgFuQoAP2kf9Re
	L6fbhEtpXMcBH0EilOA89Rdi+OO64wvImHoTD+x8locCv+5LwbLB4r+8tWakXm/+aN1quvHprY0
	GR9mGHoHblnJToP7pL9mW7qz8HQqky7lhYX2EutWPG2g4TXn5mVc4OXt/cnfl4ZV4R8cV6n6bz0
	a4yQH7d9Nkfu186nXicAoWf23WnfagIMZkgbl35HDQuuJxqoHiahaKPMc8/RXyjfnk39sN6l9jg
	G4ISbVg0N1ZcKzMutyu2iYzUTSrk+MhpPmPU75WVsyTsw9bDw/M9J50lHGIJPxJSkZZOU3LcHS6
	U++VXlybmsQm86SDszEp+2CZx5A==
X-Received: by 2002:a05:622a:1a98:b0:4e8:bb14:d97a with SMTP id d75a77b69052e-4eb81020578mr17636481cf.3.1761211843525;
        Thu, 23 Oct 2025 02:30:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFffBBqQZW9ZspBnX2nRA2fUq8D1XIhDY4m7fLDnOMJqAU+Iq9eeSK2rMWGBbo5Jvh2IgA4Qg==
X-Received: by 2002:a05:622a:1a98:b0:4e8:bb14:d97a with SMTP id d75a77b69052e-4eb81020578mr17636221cf.3.1761211842966;
        Thu, 23 Oct 2025 02:30:42 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47496be2eb6sm56430105e9.2.2025.10.23.02.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:30:42 -0700 (PDT)
Message-ID: <a38edaa8-d793-4e3c-ba9a-b8717c8e7569@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ASoC: qcom: q6asm: add q6asm_get_hw_pointer
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-8-srinivas.kandagatla@oss.qualcomm.com>
 <DDN8PM13DWWZ.BCXRTJIFB7PD@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DDN8PM13DWWZ.BCXRTJIFB7PD@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 25ogJnKJtpm04t57EMYla4clCOYsm9UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX+tV1aDAt6FoS
 tKKoPw7XEuoKG43rmM0x7PMKuo3XPqFt3kdG1GB/NZMSLj7zVG7w1cpJyiYgLc4mipbIWkEhjHr
 TMELa6y3b4uHe8qnekCLzIHtPnaS/sVL43x2BB9z26UGMYDc2VkkZ8qqHZVyQZv4cbtGcTm9A1X
 q88gop6ZrAQ5jD1XgFi+Vc2+Ndl4gkAr3hYz31ppDhyJunv7phhqsKXdhJTpQSWCZGT7Q/oJqQH
 Z2CG3NPXeGgSrOWiHfvTd1hM8HlC6Bjs7W0CNzohJ9NVPeWAJ56Rso/aCge3wrGD3g9eASmj8Il
 /M4GYRmgOrbIfUpkkZkbo4aHrdgncIcfTTuV/sgT8/VJkanW9L65CX9fyI6L7KdqeCGZzM4lFhW
 vYpLIpuenzyoHLQ+iFSV99DsQFrohw==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9f5c5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0tmoJSEW-Zqf1m8SmKkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 25ogJnKJtpm04t57EMYla4clCOYsm9UW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On 10/20/25 4:04 PM, Alexey Klimov wrote:
> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>> Currently we are performing an extra layer of calculation on the hw_ptr,
>> which is always prone to errors.
>> Move this to common dsp layer for better accuracy.
> 
> The subject says that the change adds q6asm_get_hw_ptr but here it says
> that calculation of hw_ptr is moved. Where is it moved out of or from?
> 
> Currently the commit message is confusing.

Sure, Will rephrase this.

Currently q6asm-dai.c implement tracking the dsp hardware pointer based
on callbacks from q6asm, this is really an overhead, prone to errors and
redundant.
We already have buffers and tokens which can be used to get hw_ptr
location, use this instead.

--srini>
> It seems to be potential confusing split with commit.
> ("ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer") where calculation
> of hw_ptr was implemented in q6asm-dai.c.
> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/qcom/qdsp6/q6asm.c | 12 ++++++++++++
>>  sound/soc/qcom/qdsp6/q6asm.h |  1 +
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
>> index 371389c8fa7a..643ca944b1b5 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/wait.h>
>>  #include <linux/module.h>
>> +#include <linux/atomic.h>
> 
> Ideally this should be sorted but it seems it was not initially.
> 
>>  #include <linux/soc/qcom/apr.h>
>>  #include <linux/device.h>
>>  #include <linux/of_platform.h>
>> @@ -248,6 +249,7 @@ struct audio_port_data {
>>  	uint32_t num_periods;
>>  	uint32_t dsp_buf;
>>  	uint32_t mem_map_handle;
>> +	atomic_t hw_ptr;
>>  };
> 
> Thanks,
> Alexey



