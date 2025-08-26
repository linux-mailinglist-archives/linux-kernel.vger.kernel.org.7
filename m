Return-Path: <linux-kernel+bounces-786396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D36B35934
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE5189359C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1347731984D;
	Tue, 26 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6UacdCJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B53002D7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201182; cv=none; b=rwOge2oHj+Bhq8KpdX30IDK+DFK3BzFnDvLst1KZlHDRSXlssu46IBPkGBmrh/H0rAGFVbsfIeJQ/2JPBQuN4WB2lYo9vB5Hiz66K6cLpNRS6QAgjpurYokcGEaN9k76ak0sSoeUc9gEybMs55zhFiGLWGNpO3wPUpmEk0WB35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201182; c=relaxed/simple;
	bh=nQ89gkCyArWzWht39aCxK1CNu/d5AvIhVfheIzD5aD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCh4qtogffy03fGsB+ev0BD34J+8LUa/4mHs2UL9Ubvzs4xeXybGP3AYbRieRpf5+PFqlNHR5d+1ayR7PH3On/pdFUKa4wR47QzoH6BX8N4ZPwEyRoLAYOdWhR4dR2gnIFced8xe2apTYNXbUCNFjOBZdbGsFVcwdDvUL+BvmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6UacdCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4g3Gg007281
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0rJ7RQ7iMaxrweLuf0/TuG+nG9I0o3A0GkBWILSS2Jw=; b=N6UacdCJtMrZGCof
	zoNYCnmYk6/hYjF0l1xbh6YE8HE3vY9pjnHT7erwmcEtd2BR5COTc6lms08za4h9
	jgqwt6nYb+fFPqMYcMkvlpMATIFBLNJHsevjjrG8BADUXEFe1e2umfhnJSFzDGkk
	wBePtKKG81c14C693XKDw9Pk9gUGHeVhlPEPYakaulYvSQ7Fu9aQZonxWDnnmvv/
	3QPDIK6JoxwTiYABG/lMNdWP+NsqEHJbv7KpqwgaEi+i+CQdBHZVzt6ed89UoP9D
	e9ytboSINW0gpLkoq9WYaz1tRtC4e8DozZvFMnUDhd2ZRLPfJJfEC96nhlPKt02K
	vwANHw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2req8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:39:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771f71fa5dcso587142b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201179; x=1756805979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rJ7RQ7iMaxrweLuf0/TuG+nG9I0o3A0GkBWILSS2Jw=;
        b=UdjsTXbAaiLSc1LfIdKF9CpJ8PHqoQeZn9/omJ8gjGT87UbOheVkC72wNR5k0kOWk8
         MijYsy6FP0vkFOKuqg5piOfam6n966KXIoLEArkYdwLR7q/iYNMU7rgpIMFa6QudLsw4
         5YpYveneCQRj+MEPFuqzKa2wTFIAL+uPHX9xCWnC8SK8GVDhZ6W9fl1YcnqWbBCC8+9p
         ZSAc9YNGFrKr+zrDajxNVH3NjFz60xdH2oEYKC7t/a6hXEOWRAeIvgFeFRhUWKaO+V7b
         3x7LC/3UmJ1/0eZz868dFUEFFZXrITTZ8+7g48zKa9R/8VRIizVS+8GUVjMNVTI0MiEz
         GXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVARgAVTrvqS2qu32Slvufk5pWpdKwSzU/5RegUsl1QsjhgZ9EOomipfFC+xU4rhCNQToY6Ncu4tKb5Sgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKTxM3szHFHF48lT8BUxj3NnepDdwXKi65hdQuYzLRhHXKcWi
	N2I8dF97uJbcfBezmudMsmDBF9v2ONkIrpIrgVu6kDCMH8ROIfdTP5cgCfrzlDBu2gjs1kBFwB1
	LrSzzSEERtJmsLzK2swwzxBlBps6Qfx6wJ2q4TuCzbXB4eWEZIg7UyrmNkXiI1gUpMK4=
X-Gm-Gg: ASbGncu2CXMUtfKRnQ3zbE2iep/2f+dp8PrvFPp8yfekZivR9Btj9ynERMmcIxxtIDA
	jr40WosNpp8cxm9TMQZBOWk52BdG54BX8Mg4fdkhVSHlkMEqJe807yCzb/U0jtyIKdnknFKf80C
	xnoMbmk4OcyU019rKcqXqaTSRSKk+5l2ZZIkux2JuBvQpNSnYiogg8hAbyxUs4/XBPJx7jIYtSq
	0WKaZIbHXhJn4jzjLYtpXR+Cq9QkuRZCwrHzvKalp/WfglgyGZEOEJzhEFaWEL0QciOK9WdgIBp
	dWUVAMqLkmdOyapMv4Y/xRfC+DsfXMITZLeLUIezUDxacJAgdGGwE/lR1JepNOVfg6qfWQebMi0
	f89K81qbuIFund6aqoQ==
X-Received: by 2002:a05:6a00:391f:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7702fa08e63mr17441220b3a.3.1756201178666;
        Tue, 26 Aug 2025 02:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpC1NlqUJbgFKkBeK5Cltifq2zeEdvWBJDY78r30KUUeQbyAMv/BePEb2dXQpg6uS1/KyxCw==
X-Received: by 2002:a05:6a00:391f:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7702fa08e63mr17441190b3a.3.1756201178152;
        Tue, 26 Aug 2025 02:39:38 -0700 (PDT)
Received: from [10.133.33.155] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm9889294b3a.79.2025.08.26.02.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:39:37 -0700 (PDT)
Message-ID: <a6be4d7b-d163-47df-9ab3-ca410f703555@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 17:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] coresight: tpda: add sysfs node to flush specific
 port
To: James Clark <james.clark@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-4-jie.gan@oss.qualcomm.com>
 <3ac2954e-5663-4ea0-bc1d-a09e1992af5b@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <3ac2954e-5663-4ea0-bc1d-a09e1992af5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ad80db cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=sjPE1cIhIzOb-vUN2KUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2ZXrANkq8p92
 r7vOPKNL+CExHlq9RcZR2Fpi2Ao/eUrg3e71tGMYXmgJSgsJJbQUnpoYGSmp/P7/0yZygXWpYxi
 LVXda1UBeYGvXO4vDvr/7T4bbQQMMg+jUundMDJ+ykjW2rG5QgFtxKt6VV1iuH+/m7ZVb9AW3G2
 v/UlKUt/OVpg7mNBCPZHqOnuSE/dXBGgZOgxJYOHhX/CoabI9HBHbQe31CFK8Y8fjoelIdCKxuu
 KCsQurO1MJmXee43WJowSPffooOfOZSlsbQ+oO3X/V29GVN9MEIPQ3iELhHVJISpJ4Xjmog67aV
 o1WMjYEWFksbtSfyNTHlAJpjL07oVxwa9Ll0CCS2P5Kn65WJwnEc6nFIQH3c+3A3BjyHCGxuXEj
 //nVrYiW
X-Proofpoint-GUID: upq5gow3L088wuQ0xpSf_POwHIlw5OVR
X-Proofpoint-ORIG-GUID: upq5gow3L088wuQ0xpSf_POwHIlw5OVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/26/2025 5:27 PM, James Clark wrote:
> 
> 
> On 26/08/2025 8:01 am, Jie Gan wrote:
>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>
>> Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
>> for port i, forcing the data to synchronize and be transmitted to the
>> sink device.
>>
>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpda  |  7 +++
>>   drivers/hwtracing/coresight/coresight-tpda.c  | 45 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h  |  1 +
>>   3 files changed, 53 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>> tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>> index e827396a0fa1..8803158ba42f 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>> @@ -41,3 +41,10 @@ Contact:    Jinlong Mao 
>> <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
>>   Description:
>>           (RW) Configure the CMB/MCMB channel mode for all enabled ports.
>>           Value 0 means raw channel mapping mode. Value 1 means 
>> channel pair marking mode.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/port_flush_req
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Configure the bit i to requests a flush operation of 
>> port i on the TPDA.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>> hwtracing/coresight/coresight-tpda.c
>> index 9e623732d1e7..c5f169facc51 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -509,6 +509,50 @@ static ssize_t cmbchan_mode_store(struct device 
>> *dev,
>>   }
>>   static DEVICE_ATTR_RW(cmbchan_mode);
>> +static ssize_t port_flush_req_show(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    if (!drvdata->csdev->refcnt)
>> +        return -EPERM;
>> +
>> +    val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
>> +    return sysfs_emit(buf, "%lx\n", val);
> 
> Decimal would be better for a port number that goes from 0 - 127. If you 
> really want to use hex then don't you need to prefix it with 0x? 
> Otherwise you can't tell the difference between decimal 10 and hex 10, 
> and it's not documented that it's hex either.
> 

Got it. I will fix the code here, and update the description in document.

>> +}
>> +
>> +static ssize_t port_flush_req_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t size)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    /* The valid value ranges from 0 to 127 */
>> +    if (val > 127)
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    if (!drvdata->csdev->refcnt)
>> +        return -EPERM;
>> +
>> +    if (val) {
> 
> If 0 - 127 are valid don't you want to write 0 too?

It's 1-127 here. 0 may leads to an unexpected issue here.

Thanks,
Jie

> 
>> +        CS_UNLOCK(drvdata->base);
>> +        writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
>> +        CS_LOCK(drvdata->base);
>> +    }
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(port_flush_req);
>> +
>>   static struct attribute *tpda_attrs[] = {
>>       &dev_attr_trig_async_enable.attr,
>>       &dev_attr_trig_flag_ts_enable.attr,
>> @@ -516,6 +560,7 @@ static struct attribute *tpda_attrs[] = {
>>       &dev_attr_freq_ts_enable.attr,
>>       &dev_attr_global_flush_req.attr,
>>       &dev_attr_cmbchan_mode.attr,
>> +    &dev_attr_port_flush_req.attr,
>>       NULL,
>>   };
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/ 
>> hwtracing/coresight/coresight-tpda.h
>> index 00d146960d81..55a18d718357 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -10,6 +10,7 @@
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   #define TPDA_FPID_CR        (0x084)
>>   #define TPDA_SYNCR        (0x08C)
>> +#define TPDA_FLUSH_CR        (0x090)
>>   /* Cross trigger FREQ packets timestamp bit */
>>   #define TPDA_CR_FREQTS        BIT(2)
> 
> 


