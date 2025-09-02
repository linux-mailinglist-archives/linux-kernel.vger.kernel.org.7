Return-Path: <linux-kernel+bounces-795578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54373B3F4C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22C0484A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1E12E1722;
	Tue,  2 Sep 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OS7MG+/D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C829A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792117; cv=none; b=jehQevKpRcUjQb4P1IxYGJ8odaw1hw0rUe994OSc0REa9t57/ZdiFElAgjN8mn6wU5bnyB6ZwV3dv59y691Oak4Rd/uuWtGvgn/ai8cmrqbjXD+QQjSiLa9aE3KgLZqNxCaBGD5JbHhrNvz13JSLfcDSfGIVjkSFnrH+UgJdMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792117; c=relaxed/simple;
	bh=wJUXVzZEjt4dllkF9GBssUfByeZHIyP5zZLl0B3Rpp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjCOU+aSecw1CPXBTZil1elRYIYUhZc2xcS60qGU2dPzc8oAkfL6i1jGk9+qcjaIa3+W8STcrFuUMEuxIRLyLPbKi8NBFgSSLYtI1UpWnuvQZyWVG2O6g4qj/31k/MGZjcnRXk7L2tX6HKSDN/KlXZe1GNrQwAeQHI38Tqk5MsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OS7MG+/D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rto8010115
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 05:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fRMEVrZIzXTP/WpidTvtFL57e8Y6bQRpGsTye5PDzTA=; b=OS7MG+/DfR8ElpNj
	VxIVSDgxszHN6osKnBWQgM90cQWfcAk9Iz2RXju9zAo/ZUqsWUutOlpec9CN5baY
	Uxc+w3aYnrDZMQrYU6uoZ44oexiSw389Cp4j2wL6+9AA+O2kQoOJblgrMpoVSf9u
	l+xTR+lkk8BV+JO6guLeW4TzQzZNu3IvlUXzYshApRsDftDvZ/jcX6Dk/65wHJSD
	aQ3ubRqFR/txwG/o0ThY4YwHiB/AfySuI+IHtLrw65XA2EVwNUxyJl7CmAl+wEHL
	jYGkF4LisVKi8x8SkF7Ciz0RVQvMnVSmE5ib0clRi9DGZZg/07T/5qXnjv0hZZjQ
	l0fNlg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjenfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:48:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248f7745075so73815565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792112; x=1757396912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRMEVrZIzXTP/WpidTvtFL57e8Y6bQRpGsTye5PDzTA=;
        b=IozTdcno3Xf3cGpc94q6CEBl6TrZx5uA5C1eoW2dvVdG8U+sq6d23qHpS6ZRJTKVLt
         HVBi/7wdV72M1gl7axpLROECAezB7OIPx2Q/5JS4lnXOaEwQvew36cBApCCnCKMuSYT1
         xHhgaSr+lam+riMDxT8EpnrJOlgBiDDYRhJ6fsylk8Yyh9Tf56SGc0IgPccRozu2kt0R
         zQg2C2vjZj6OgOjMOXUpkpLO2DDWWH1hIHkLvSsaaRoFX7tiSUoKFzVRLWy7Qc4WSv01
         nPr2P3UWTboN2ip9sAY+r2eDikCH/oDJ23E/W03jHrXVQKO/tmnkcSSuLUg2HRri4Xp1
         80Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUr4yqSMejOQ+d9JAYs1FrE1pXO2cSIIai8r9Zt4c4rKQiXGXwsUIULyk8zj8NFbe9A8HQWUr7hM2hqw1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2L4Otoh66BXlninsJrJYPxjUSDuxjAn6V0Ho1BmFLxVUJV1s
	dj+vDUyXMi42FjjtoRTZQ6YxfncpkhCp+HPMljsphROGt+SEy5v6H6gpk502y4o+QYs1/8yWfBd
	LOi6KJK9QZJyhf2p6VxaXGsn/AtZ/XQsJ698mhpWH3hJeMtnqRVZV6fxvKb5gPnljY28=
X-Gm-Gg: ASbGncuwiRlmJqABvjn+AKJctYhmUXD03WNzPtb2G3EBcCeQ2MWw4KKszguZXAWuj9O
	hHdTxFbfPurXtzlQulRuw2eV0EkUi6UQv4zbUyGWfpVuA4jWbUAjOPqEhV8Is+LuvQ30h0OhAMx
	67xf6DpwxD7Vy2Jxff0+aJkeUTYQkOn2pIuc6S9WSUGHv3rg6CRU/m2kjz0sJfpoA6JMnbAAblQ
	2ODpY8S1ybJmKk0f8iUqmEy+GPOBm7XcgVfz4UFocc/w8zf/zCl2w8oybUMRzoewozJhg/QsPTC
	O+30wNK0liCnbcADe/ZVWOP1QKRPUSGQmVyuyeqUmpwA0+ubmhxi9nzIKV6K1WDz3qv9NJ4k2Gm
	jDw==
X-Received: by 2002:a17:903:2302:b0:24a:a724:717f with SMTP id d9443c01a7336-24aa7247fd3mr107166455ad.47.1756792112111;
        Mon, 01 Sep 2025 22:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKd6LawW4ea9rkZQXLiLMf6L7YBrtKTZ+bAhxeuf0bof7iqODU73Oimyrd5cxBoD3ntRSIyQ==
X-Received: by 2002:a17:903:2302:b0:24a:a724:717f with SMTP id d9443c01a7336-24aa7247fd3mr107166175ad.47.1756792111624;
        Mon, 01 Sep 2025 22:48:31 -0700 (PDT)
Received: from [10.218.21.68] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490370278dsm121876375ad.1.2025.09.01.22.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 22:48:31 -0700 (PDT)
Message-ID: <0d60f70c-dd62-4e37-8eb2-dd385506980e@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 11:18:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: qcom: audioreach: Fix default WS source
 assignment for I2S interface
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250822171440.2040324-3-mohammad.rafi.shaik@oss.qualcomm.com>
 <6ca759f1-27ef-4cf4-833c-ee2f6a9b2d87@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <6ca759f1-27ef-4cf4-833c-ee2f6a9b2d87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b68531 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ry2OTbbN1JAwg5-T194A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: C2hPClH8Fcr_wmi_Yy3CNPcCFpgt_8jk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXyCiP9k7O/q4V
 iJ4777nDlb6GwcSeqUgKfoo33yLTkWQ2RU96STQEO29Tuw5DrJ1UC74NQKNhCDp+ExnV7XB8h3X
 YV9DnB3rlqtf2Yw1G72BC+Yv34vI+Ds5bVLIXuy4Whx7x1C127pd4wGP0xJal8fRSeIuklGIPdL
 WehPLfefP8es5B1vL1YqVuzvspTEe3meAa93o8eZo9cjEkZ0Vipu9bC7GDzbLQ817bR3Yz9unuY
 ztxinSDEENSydY+6avZU/U5V3j7UKXmD86avWjOcIL2rm9LEPyMAD+NonzUO3AodhKmN8IMNtyF
 EY+m3Px6db46ZmcbDaccE1f7QBL7THkZNaW8I/wnQy92pdXyN3+Mkrbt3n/GYVuJmhQvSCk28Aq
 rYnCrJL5
X-Proofpoint-ORIG-GUID: C2hPClH8Fcr_wmi_Yy3CNPcCFpgt_8jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 8/31/2025 2:07 PM, Srinivas Kandagatla wrote:
> 
> 
> On 8/22/25 6:14 PM, Mohammad Rafi Shaik wrote:
>> Resolve an issue where the I2S Word Select (WS) source could remain unset,
>> leading to misconfiguration of the I2S interface. A default WS source is
>> assigned when not explicitly configured by the AudioReach module.
>>
>> For HS MI2S interface, the DSP need proper WS settings to set
>> appropriate endpoint configuration.
>>
> Sorry this is not the right way to do this, machine driver should select
> the correct configuration via snd_soc_dai_set_fmt.
> 
> who supplies the frame clock is decided by that configuration, we should
> not be assuming any default as this is totally board depended.
> 

Ack,

will use the snd_soc_dai_set_fmt api to set correct configuration.

Thanks & Regards,
Rafi.


> --srini
> 
>> Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/qdsp6/audioreach.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
>> index 6d7b1a4b0b2a..d4397f75e310 100644
>> --- a/sound/soc/qcom/qdsp6/audioreach.c
>> +++ b/sound/soc/qcom/qdsp6/audioreach.c
>> @@ -999,6 +999,12 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
>>   	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
>>   	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
>>   
>> +	/* Set default WS source if not already configured */
>> +	if (!module->ws_src)
>> +		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;
>> +	else
>> +		intf_cfg->cfg.ws_src = module->ws_src;
>> +
>>   	switch (cfg->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>>   	case SND_SOC_DAIFMT_BP_FP:
>>   		intf_cfg->cfg.ws_src = CONFIG_I2S_WS_SRC_INTERNAL;
> 


