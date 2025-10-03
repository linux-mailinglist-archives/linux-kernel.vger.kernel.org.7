Return-Path: <linux-kernel+bounces-841044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 838BDBB6058
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 478734E81D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1D2222B4;
	Fri,  3 Oct 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBs5Rh5g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DC188CB1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474856; cv=none; b=poiCcgquM4mCUl90gb9VlUX+kVPp06xBu9N4U38AQgC54Ea0qY1pASNoefl2bfJeJfiBpuoER0RUluHAOKbXyDvMVIxP6IK9JNklwD4tFQW0PmOxzOdNGOUU7NJpjxMBcRqWc8Sfyr5OHc34JNxcbsu7djg6PxPRFnd9O5onmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474856; c=relaxed/simple;
	bh=5Exm/8PLdaYIQsbxEm7CrsQS0hKOILQWwFq03IzluZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQO4Dbp0asJQ8glFnhI3dvdeZfO9w44YmndL6uRVOPZw0DdxQveRcRRK4OR2s1kjhJfbbVWKdlOhoMWzmyiQ+dw2XxtVy89DHXBHrvKXVmWqjiO5mYoM0SHiti9gAL+OupsxtT/J+iifSwVe4C8XIgk+LmLTQ6YWa8nfyLa0lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBs5Rh5g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Nn3t9031252
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 07:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Co5VzprZsR81aFpnYkYXzmF6KQjbt0d229OVKm0YBpM=; b=NBs5Rh5giHTu0yIG
	fp3IUgm2pJos2/MW3R/9TvxauMsylD+rNDtBlCQWXTj2lG4mgTtlj/tc8jzPqRwp
	9p9thZzJNaiS+0drtWdS+gFdWJ1WewKKeGyBNs3GP+FkthMom72/HRve+yLV0iPD
	Pe13nZuQ/Z1OaITbRrRevj9YJqDUBpMi8U8CUElBi8U0uocGYaqrCh5eHm4spqPz
	I0N/Hy+y5l9fa5tm+FIT0fcXy2PgpKMRgjZx+m+rnrM2yRMxwvtXBc4F1q8M9t+Z
	CLLwAqWJmAnJyOF37CKywJ84MlLpV+09p4hVf713stV3IDmzsuo7H4ciA4+KoO+4
	NBzulg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vra1vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:00:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso25715005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759474853; x=1760079653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co5VzprZsR81aFpnYkYXzmF6KQjbt0d229OVKm0YBpM=;
        b=naJjgJf4CYmE2hqkzKAJzs48r2Zvv0UAkWwnn92ycbpKOHwh/PbMKcQHc/Qk9oeqw4
         FWHkXuH+FQseBFD53Ft+YxWRCVBC1nYpje8mTjWkL4vRU8sC76aP8iDDU6z12tpVLhqN
         Ycd8MCI2dQcFBnBflp9nzZ/Fai+GIPzjFweslSweo53xrwK0PwncDUYCjUfCMZuIBOhX
         l0fXGHlY2vb3hhvC06aeeAIaGUixK2Ivrnq1AE9fRXmIO/xTsPw0Ld1TXw7XqUq6ALgo
         XvCn7p5wQAbT4VCOAxQvTyVNJ9K6EeO7Nv12o/tdgzFe+FA/HJItwSY/Xu3RgZimK6C9
         8uLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8eX54yLfNBmV3m3ZMzcegNsTQ1YQtCoSaanWO0kY5K01kyHIhce0eXOS+EP5qcww2gJp7syO9t28pmd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCV/KCiRrpbC5RJZOsv7yfZ7Tee8eYLOsNKJkj1gZ2pMlMVmjR
	HDkmEJdoOT3F75D4WFGF0VteZW4m8mXmLmHF/474Y9uSXBmx234p2kZy0/xEmfgn+9YlLXdBXE8
	Mk8REwjDYxVeF6uxoF1rcNBwMUBjzxaYOz3pYdy/7vZzX6Mold2EuboC3L6sCIUNhmvM=
X-Gm-Gg: ASbGncsNYJDatrGS+kfN6IX+mD7iAGz7ZCf7nXVbpwYgeZRY5XxO/hvcl+CCgWyYDKZ
	Cra00yd3N9ZzKTjjRb45VJCFXLuQAbHHEoroQOvwgpjSHW4WOoSjteNx4J3e/XEazkg+z0mcVT6
	36/QNiqohx1f7x20rres9ZPwIlXRSufergy2jlpTetQ36XYfWtO5MOPqY4qdONXo9YU7qytsCip
	wUfaydY3FOfcIC0jfXXVxPmI2CiTtjhEncyTJ0feAtXc0BC0KtRx0RgZfJ06oi4u7k/9nxJ5rGP
	NsOW9JlSQvKFBYeT5Dk7FCeUZ4zBQlfADCqLzG2fLI7OebTS4+XiqEJnqbPi3+yRUfxM9JKmXnJ
	qQPYJDC5g
X-Received: by 2002:a17:903:287:b0:26d:d860:3db1 with SMTP id d9443c01a7336-28e9a56700amr25147625ad.24.1759474852570;
        Fri, 03 Oct 2025 00:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHryjKfAj9HgoLio+jseaVb7X04rOxIe8KAqRAkzFtrkbcwQLuvAuQxIWXpvFYBtK4NEGv3tQ==
X-Received: by 2002:a17:903:287:b0:26d:d860:3db1 with SMTP id d9443c01a7336-28e9a56700amr25147165ad.24.1759474851714;
        Fri, 03 Oct 2025 00:00:51 -0700 (PDT)
Received: from [10.218.21.154] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126012sm40739195ad.41.2025.10.03.00.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 00:00:51 -0700 (PDT)
Message-ID: <ec31379a-4bc9-4cc5-b90e-ca380f5334aa@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 12:30:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel map
 mixer control
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
References: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <DD71KONODHKJ.15RI1DXF5T6PJ@linaro.org>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <DD71KONODHKJ.15RI1DXF5T6PJ@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hZEBPK4bQwre6hFPnT9vedQ1t6nLr1sz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXxXjfzOSi4KAB
 aFlyEFxJsbaaGgq7Yc2Hqq7jTrJF9dMmPt6xE74OXycn15aumJqb7JV9izDzcRAJsRQdA6hjt8P
 EgOCgX0DKGlVwNfznKN/KU++uhfwJMTML2g1j/Y3s5FX3ftzmJEFv1D+5UYEuDPMDwWP5H2OB3o
 BmRVSLXaUxmodKZ6S6X066FxRbllJ+y6xpk8+acObGzMBh3nn1Hc81ONA0gcTx4JwQ+ylA/zEF6
 IZ7GJGsFxucTHjC0297u3ODMx+wInWjDCHz7RSOjVf54Xz2jaUn5OKJjE6CFLOUVVE3e1o8Yzz+
 CYPW0ThDpZivk37r1Ah4TvQ7WO9k/9ga4tomNEOdslPwmq3748FTDIJolLtiSwrlrF+801+0JaJ
 Y5ylezT53ZW6pCB+tH3OHR1VcJ16zw==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68df74a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=onMMKnJRGUs5ctigZmYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: hZEBPK4bQwre6hFPnT9vedQ1t6nLr1sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_01,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 10/1/2025 7:36 PM, Alexey Klimov wrote:
> On Tue Sep 2, 2025 at 7:23 AM BST, Mohammad Rafi Shaik wrote:
>> Introduce the channel map mixer control support for LPASS macro
>> codec Digital Audio Interfaces (DAIs). The channel map mixer controls
>> are required by APPS to configure usecase-specific audio routing and
> 
> What is APPS here? Will be good to have this abbreviation or acronym explained.
> 

Ack,

will write proper commit description.

>> channel mapping.
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Updated patch with improved commit description..
>> - Link to v1: https://lore.kernel.org/linux-sound/20240930053111.3986838-1-quic_mohs@quicinc.com/
>> ---
>>   sound/soc/codecs/lpass-macro-common.c | 55 +++++++++++++++++++++++++++
>>   sound/soc/codecs/lpass-macro-common.h |  2 +
>>   sound/soc/codecs/lpass-rx-macro.c     | 12 ++++++
>>   sound/soc/codecs/lpass-tx-macro.c     |  9 +++++
>>   sound/soc/codecs/lpass-va-macro.c     |  9 +++++
>>   sound/soc/codecs/lpass-wsa-macro.c    | 12 ++++++
>>   6 files changed, 99 insertions(+)
>>
>> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
>> index 6e3b8d0897dd..777af4885245 100644
>> --- a/sound/soc/codecs/lpass-macro-common.c
>> +++ b/sound/soc/codecs/lpass-macro-common.c
>> @@ -8,12 +8,67 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_runtime.h>
>> +#include <sound/control.h>
>> +#include <sound/pcm.h>
>> +#include <sound/soc.h>
>>   
>>   #include "lpass-macro-common.h"
>>   
>>   static DEFINE_MUTEX(lpass_codec_mutex);
>>   static enum lpass_codec_version lpass_codec_version;
>>   
>> +static int lpass_macro_chmap_ctl_get(struct snd_kcontrol *kcontrol,
>> +				     struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
>> +	struct snd_soc_dai *dai = info->private_data;
>> +	u32 *chmap_data = NULL;
> 
> You probably don't need to set it to NULL here, if it will be overwritten
> by kzalloc() call few lines below
>

Ack,

will fix in next version.

Thanks & Regards,
Rafi.


>> +	u32 rx_ch_cnt = 0;
>> +	u32 tx_ch_cnt = 0;
>> +	u32 rx_ch, tx_ch;
>> +
>> +	chmap_data = kzalloc(sizeof(u32) * 2, GFP_KERNEL);
> 
> here.
> 
> [..]
> 
> Thanks,
> Alexey
> 
> 


