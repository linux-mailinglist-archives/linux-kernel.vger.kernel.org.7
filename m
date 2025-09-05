Return-Path: <linux-kernel+bounces-802700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD0B455B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFFC1B23EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C327296BB2;
	Fri,  5 Sep 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUMM5u6c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07D341641
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070330; cv=none; b=dnetyL3BgIswzSvO0DTQVWhTbbnwA8YppmIqWqYwN64jLQdtwyo9pKR25TgNUxCwtPPp9YvrML1/zJxFYl4bbZ/ICthEfS8c8IQeMo8O9qQ52r6d+ofF4+XD+9pMxgmAtYfXCZrGHUbNFIn3FDuAAzG1uGFo4+AaJnLfR8X8nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070330; c=relaxed/simple;
	bh=E+z0OzvLmJ/8onuEFCaHusvgVI2q7XxN8zJfDiwSrx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITsE3QIAX42jjQgLdwFftzE0hOe3jIue+RetRC9kg2gDIzJ8G/ad5GYJpkuZipwex35bLL3mNLGswC6d0EPLBygNA/v1OD730org2EEwj8KOihCEGBPx4+EMipyu2ATCUL559MT0Exi7VvIlMMZF3DakbVgKONRKjZJhpp2/8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUMM5u6c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857RdOR022450
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 11:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RCOkVoSgMv1L0VMNcsjOUXK9ZbBvTQO7jnuAMGFDWS4=; b=gUMM5u6caqUD9mVB
	V9qJX3Q58JsMqoFsYNLMc5HTrscb+ZsnsGw4+mGCM+gbbTRrtVbzB18Ri3kq0WnD
	ltDM3tlWsyHjJ8+FlyIVzCV4kYruOheUwrC0ER7am2akLW9OxJHbx1Pa/cOsytXA
	24Cb8dBLSfx21t/MxrQ4YnMh2TcOEbnhZaYh2fIxscHjFvIpS90B0dXJGPpedPJK
	ZUhQNhL5a/V8F7+Rj8Wd65nfkEBWQ4u6Y4MzVrFkjgAwOtiBW9I2q89tzAvkE2Eb
	CTDjFDfk2r3SjseK22S/6ZkZrqhgM4zQruh3v4Az9YQIctbLe3x2TJl4+XtjTjSG
	GMNPTw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9arep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:05:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2490768ee5fso16848235ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070328; x=1757675128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCOkVoSgMv1L0VMNcsjOUXK9ZbBvTQO7jnuAMGFDWS4=;
        b=xLQLd71OHCXMvlwCgwxp66cFGoAPUgsR6aGPPMwWrPMFjEau6RMq0VIyQS1bRmN48a
         GBKMYOL/F1PuAKRl8oQe6ASnMJoNdfiFfC1jM2a/jvxQghM/1rw0dBOhmUsBT1BVhtIY
         X9xUmwSIKhLdRdLtd5DkihM0VCxDoCqQsUwCf2xKbjYdtIbjaWSQDrT/kmevP2Qw1V1m
         j/xLNt76OrEo7upS1jXhC1OkfGmwe4F9e6iebhIknDNZV6rMHnflpVEuLIMGo/24VSfi
         /Wb2TF2vxE9YJSnkS0akpO+QfHsMtWe/2EVBIG0cr2txz8pid0EfOH9MEjqrCx5jB/Ps
         mwXg==
X-Forwarded-Encrypted: i=1; AJvYcCV+JvhBq2ygmLjTWqtMMpsS9K/mmf04/vt8zGht6/9fg27O71qmB6hmJzIdII2toV/6LNFzHWa/QTQ80y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZusIuQ3MfhwLCJcXPGkTldANx658EnkcXw+IpH8Q0TuW7MTBJ
	qCSq+2/v4cjwF2WAWG97V7/RGuq8f30oZ6edz2/XRZ4bliXHo+J4aANe4IfylCbDOOvrWGhYB/D
	wiJFTK3fe/k9ywU9zLHZdxqSWPye4ePAdEzH136dAQWvOeilT0mwY7MybGj9V/j1/xsY=
X-Gm-Gg: ASbGncv1MH6/2qjYHB6WqEwnjlaPkTAJe/Pw2/Ap07tlAx67hleKsCnWV8SSTFYYiQI
	/FV0OGowXLPphp+l97rbdUCGhlFEW5GDyPebqZ3ATd7UbOe0mov+PMVQ4BPbixVB+D25FKMcaCA
	hZa9KD/XuzfDPW/i1MketWMFzzMzEVndorlHFwt5wIjg5pMZJp0X+7x3SMBxjOFBtdrmhGnyWOX
	iRp00DDeth3sN0XSvM2uK6Sw9zP7eW5vlaJ99/2S1yvooI66K2WWX1v9rFQPAkPcdE9637+yqCC
	H5JI7HGC++Jb3oJl9e/yAI5A03ikvzcvXWBcJPs/Rwjb7HmKsdT7YttkuymwqHzPsdrWNIafgno
	aJZ8=
X-Received: by 2002:a17:903:28c:b0:248:811e:f873 with SMTP id d9443c01a7336-24944ab8f4bmr302867175ad.36.1757070327625;
        Fri, 05 Sep 2025 04:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaBaEQj2/Ott7YevOzR0H8alV8LqIEopwPPE34mLhhoSdImcC6vNQ/KnXjEeJsTk2psflJDQ==
X-Received: by 2002:a17:903:28c:b0:248:811e:f873 with SMTP id d9443c01a7336-24944ab8f4bmr302866665ad.36.1757070327142;
        Fri, 05 Sep 2025 04:05:27 -0700 (PDT)
Received: from [10.219.49.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccbc8a453sm40592945ad.0.2025.09.05.04.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:05:26 -0700 (PDT)
Message-ID: <0b560cc3-1735-4605-a34d-7f2413fda609@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 16:35:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: qcom: audioreach: Fix lpaif_type
 configuration for the I2S interface
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905104020.2463473-2-mohammad.rafi.shaik@oss.qualcomm.com>
 <a9eae2e3-0e75-4ffb-9de1-3b8a9bce86a6@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <a9eae2e3-0e75-4ffb-9de1-3b8a9bce86a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LVVC4sAUqTAk9yz95as6oMXkdiHpVnQ8
X-Proofpoint-ORIG-GUID: LVVC4sAUqTAk9yz95as6oMXkdiHpVnQ8
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68bac3f8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ROh5OEer_01NpF1xJywA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX13kS/qy5Bx8l
 G7J08ZyR+qvOCedOMiYz7pDjXLmZp8NmrVZXIjfC8Vbn8Z6OL13K5KmIOE1NQ0HkcL53vtgT81r
 zKZwcLduHQp1Rm1m7v5ROMsdjgnh/kRYalf49FNPoM4FZ2fRb356WoOYwVKuB7HipCudpasz1+9
 SmUgmZNZzNjI3IyRs7LnRLz6cWTvAa7T532UVz9dT5yR8IoEruCjE7pwIHVEheqeWctGZDo7Lhb
 wOTGMpMyEppsMpD45HRVvb3I7IVc2Cgs8jjFMKq1ZvBBRshvjp3aW0S/+M7wSd96KZEUcBOaDgv
 7aR1VCDUiPrHvSPKHm9IF3lRdAU6Fw+jwAWmCj299V13UQxuRmakJIaGaG81CdScA5mdxj7ju2c
 J+4P6oxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042



On 9/5/2025 4:16 PM, Srinivas Kandagatla wrote:
> On 9/5/25 11:40 AM, Mohammad Rafi Shaik wrote:
>> Fix missing lpaif_type configuration for the I2S interface.
>> The proper lpaif interface type required to allow DSP to vote
>> appropriate clock setting for I2S interface.
>>
>> Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
> 
> CC stable tag is missing.
> 

Ack, Will add the stable tag in next post.

Thanks & Regards,
Rafi.

> --srini
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/qdsp6/audioreach.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
>> index bbfd51db8797..be21d5f6af8a 100644
>> --- a/sound/soc/qcom/qdsp6/audioreach.c
>> +++ b/sound/soc/qcom/qdsp6/audioreach.c
>> @@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
>>   	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
>>   	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
>>   
>> +	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
>>   	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
>>   	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
>>   
> 



