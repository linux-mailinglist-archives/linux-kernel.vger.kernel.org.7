Return-Path: <linux-kernel+bounces-787999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE61B37EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DDE687343
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C5342C8D;
	Wed, 27 Aug 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A0ZDD+16"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F925C6F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286328; cv=none; b=ulORLhjcJrfR/YLDYdlhO2xDaR8mNP1IQobeyDVBwPBooLYFD4N8NQmzTOlRU7ggqWOFh4IuEDqdlDAlJ1OVXBp/Wty9zAkri7gzrZf7hNYskZb1S9jTGHC2w3ubzL0CYN2wGopX6b+NGA6iCcgVOwMhDCWv2KS3k9uMwM8jo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286328; c=relaxed/simple;
	bh=uVogBQRE2Y/GsSLDqPGy9Aa63de/21Ehujpp/tZQ3Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6ViYVk2NquK1rmbi1FazVJXqVEWdaE54tpJq1GFMMfi+T4S0TuooJje9qydt+SlkbPYpkckUsVfP5Q/En3b8NflYSM+ajlyXxVNMFA9TyPKdQPH2korlW5olrW/Mbup1AjuzKfVoYcCcXm+P0rRIS5a2Ys1L32Ye6ozc82IrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A0ZDD+16; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kDq5008186
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y3ZmNgPMfhfr75Jy+s9Ep5b6gD2yM6Jzf4SvrXiJ2Lc=; b=A0ZDD+165l9r6he/
	0mWHt472B5s7FWBMG7a9bmindEt4NPoSB4zXk8JSX4wmpv1dKRcjbCUIsOZCtdHT
	6Dzwl1XUzJ+QLFvoiczD3gwMiRuteOc2kXvQwwDO1O1P//gAGoDk68ItxKthnWwv
	X8nTNXE4qtvxSrSzn8r+CGaCTwOp0SJ93IW6bSt4Nj5WZ3XQNcH2ylnCMSb7nXBq
	HCGXc1rAVIAG8iGi7wd6N9Z3dBvXsh7TbhgNDi+sl2q+X85lebnQlMzO3P5MUwmg
	qpIqI8wWtOaJ/Kr37N3PWvC8SEHeiGzAo+CrAkdIYEskvmoPKuQJPjufmV12Mouc
	FXX6hA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ajc5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:18:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246a8d8a091so83596155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286325; x=1756891125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3ZmNgPMfhfr75Jy+s9Ep5b6gD2yM6Jzf4SvrXiJ2Lc=;
        b=kUsBBauuG9HmloMjs8OOo6qVSlJaGSf7jgASWf/zZW6VkiMcE+eEETuMtsg41iF77s
         ASN/uAWxsdRkKp411SYLnItlfI0joQiNCJS8SrXNDLI53on7up5Fer/Skjb6WrqTtjny
         9Vp/a0SxtKj3VC0R5RIN/gb118KrfWrALG5fHp5ZZjzyExLm2yeIzZMSB44NHVCuA25u
         gPCPar82dxNNKuGuB57LVi5+kT1UmeO/KRMm3YE76Ov8riagHW0dMjzrtpo7qRFxghQh
         KniybRu3VE+aNk3La4Od5Q8CxzwMHgRY3Hf0u7kK82En79rNVC4FLrV/gcnFKLiQmtnT
         KxqA==
X-Forwarded-Encrypted: i=1; AJvYcCVe4hprVJGcwlfCJIV5sEBpeEE3OyQfrdS4qPhfEYs5nyoOnLYS3yorksb7vfm6E801wr7eqexrCg7ziP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+pgBNzbL/TOyoXRDQmWmNBbMm/zM6q+ib1P5ZfAovWnomAJX
	PHhen5Ry7KDvVYrShK2qYcQWqG77xkpYIrwcxC3jfeQiXYEIUkxNmomoxKLL1Mb7q5orALH+1Wb
	ZYkOlm2nJDHFBJgaKWWC83O5c7ehp6ghJZXFKpPlO/uEcQxPJwkrUZyAGW4tlHi+u/dE=
X-Gm-Gg: ASbGnctopGEia8fHRzs9dZXdvUzR83MWGtXsgLPt/pSlkH4xwmaQ2g5zcZPjxGT7alJ
	uab1vMgoy8IsFmic8ZMeTlTP+IPXsN88sbptD1yZFHCHTXGx+TtLpdbdvuEcSuhA/B58jhPWy4/
	n6rv1M5a7QcXyHGW6a4DcYiFR8uH7xLGTPZBY468MNbtHEU+1NLqs8I/xUeeDxUlj/w7l6abQ33
	h15PPAIzdX6PNDqEOyPGUVhqbFI6rQgEUQLRFKkKV4gmKF4DroBhEPEcEfpe2kGonHB0jnDnl+m
	/bZEGxaaG8CLHbu3e8HznpFNQhHSgwPe93pWhoDG2A+LacJxy4KuWM9XBkZChOO9Z8iM4wAsrq7
	TvDaPkV5tZUllncQykWEvdebX2qRX8g==
X-Received: by 2002:a17:903:388c:b0:248:a1d1:28ae with SMTP id d9443c01a7336-248a1d129d7mr14311285ad.39.1756286324814;
        Wed, 27 Aug 2025 02:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5/6oHGHXze6Sp8tZZFAPJM4F1BeCYoxBde0pV4H8aBjDQSfR/ZYTsY9gz+mOb8HWOUU766A==
X-Received: by 2002:a17:903:388c:b0:248:a1d1:28ae with SMTP id d9443c01a7336-248a1d129d7mr14310795ad.39.1756286324256;
        Wed, 27 Aug 2025 02:18:44 -0700 (PDT)
Received: from [10.133.33.198] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f11esm116975865ad.150.2025.08.27.02.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:18:43 -0700 (PDT)
Message-ID: <27282f8d-e27d-45c9-b616-28d2c62a4e09@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 17:18:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] coresight: tpda: add sysfs nodes for tpda
 cross-trigger configuration
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
 <20250827042042.6786-2-jie.gan@oss.qualcomm.com>
 <5acf3562-e69a-49b0-8cb6-9e57c5ad4368@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <5acf3562-e69a-49b0-8cb6-9e57c5ad4368@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68aecd75 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=OiUlF2ysgpT-6eO3SmwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX6E/qokIAkyXi
 EOP1dkPCNXBqUr2K2bWSXw2HHATbfpOyKCvMc6Oip2PFMAT0OSooBwPn0rojHTcezmW/4hygzzd
 72A914/LzPLI4DiRGYhd3vFCAZtOTAXHMf7B8htQL66LpgKdPR3PDJ4R01d/2pTl0931Ori7nAT
 ucChyDuho6iebCOES2XyZid/IE6mPrh6UMZkLPEzARRQVR+r8jaVocSgVw5Qthq2scscImy8LQE
 l+UJzIIR0pfpquGreBrd6XrTJeNnWN0suQL425kH6EW/zeTxFuG3jWa1PFfq5aa5911bH/YJcx7
 W8qGTNEpxXp3j4CkieoeipAlTmzSfDRoYHpaewTZbM4UjxdB2qOwWL4gXiUQwsR8SHEsAyKS/Ta
 XQ0RtPXO
X-Proofpoint-GUID: HNzjWCyTdmoZZ-dsMLipEd2nmLpSRLzR
X-Proofpoint-ORIG-GUID: HNzjWCyTdmoZZ-dsMLipEd2nmLpSRLzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153



On 8/27/2025 5:06 PM, James Clark wrote:
> 
> 
> On 27/08/2025 5:20 am, Jie Gan wrote:
>> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
>>
>> Introduce sysfs nodes to configure cross-trigger parameters for TPDA.
>> These registers define the characteristics of cross-trigger packets,
>> including generation frequency and flag values.
>>
>> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpda  |  43 ++++
>>   drivers/hwtracing/coresight/coresight-tpda.c  | 227 ++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h  |  27 ++-
>>   3 files changed, 296 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>> devices-tpda
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices- 
>> tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>> new file mode 100644
>> index 000000000000..fb651aebeb31
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
>> @@ -0,0 +1,43 @@
>> +What:        /sys/bus/coresight/devices/<tpda-name>/trig_async_enable
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Enable/disable cross trigger synchronization sequence 
>> interface.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/trig_flag_ts_enable
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Enable/disable cross trigger FLAG packet request interface.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/trig_freq_enable
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Enable/disable cross trigger FREQ packet request interface.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/freq_ts_enable
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Enable/disable the timestamp for all FREQ packets.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/global_flush_req
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Set global (all ports) flush request bit. The bit 
>> remains set until a
>> +        global flush request sequence completes.
>> +
>> +What:        /sys/bus/coresight/devices/<tpda-name>/cmbchan_mode
>> +Date:        August 2025
>> +KernelVersion:    6.17
>> +Contact:    Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang 
>> <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
>> +Description:
>> +        (RW) Configure the CMB/MCMB channel mode for all enabled ports.
>> +        Value 0 means raw channel mapping mode. Value 1 means channel 
>> pair marking mode.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/ 
>> hwtracing/coresight/coresight-tpda.c
>> index 4e93fa5bace4..647ab49a98d7 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -156,9 +156,37 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>       u32 val;
>>       val = readl_relaxed(drvdata->base + TPDA_CR);
>> +    val &= ~TPDA_CR_MID;
>>       val &= ~TPDA_CR_ATID;
>>       val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
>> +    if (drvdata->trig_async)
>> +        val |= TPDA_CR_SRIE;
>> +    else
>> +        val &= ~TPDA_CR_SRIE;
>> +    if (drvdata->trig_flag_ts)
>> +        val |= TPDA_CR_FLRIE;
>> +    else
>> +        val &= ~TPDA_CR_FLRIE;
>> +    if (drvdata->trig_freq)
>> +        val |= TPDA_CR_FRIE;
>> +    else
>> +        val &= ~TPDA_CR_FRIE;
>> +    if (drvdata->freq_ts)
>> +        val |= TPDA_CR_FREQTS;
>> +    else
>> +        val &= ~TPDA_CR_FREQTS;
>> +    if (drvdata->cmbchan_mode)
>> +        val |= TPDA_CR_CMBCHANMODE;
>> +    else
>> +        val &= ~TPDA_CR_CMBCHANMODE;
>>       writel_relaxed(val, drvdata->base + TPDA_CR);
>> +
>> +    /*
>> +     * If FLRIE bit is set, set the master and channel
>> +     * id as zero
>> +     */
>> +    if (drvdata->trig_flag_ts)
>> +        writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
>>   }
>>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> @@ -274,6 +302,203 @@ static const struct coresight_ops tpda_cs_ops = {
>>       .link_ops    = &tpda_link_ops,
>>   };
>> +static ssize_t trig_async_enable_show(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_async);
>> +}
>> +
>> +static ssize_t trig_async_enable_store(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       const char *buf,
>> +                       size_t size)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    drvdata->trig_async = !!val;
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(trig_async_enable);
>> +
>> +static ssize_t trig_flag_ts_enable_show(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_flag_ts);
>> +}
>> +
>> +static ssize_t trig_flag_ts_enable_store(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     const char *buf,
>> +                     size_t size)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    drvdata->trig_flag_ts = !!val;
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(trig_flag_ts_enable);
>> +
>> +static ssize_t trig_freq_enable_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_freq);
>> +}
>> +
>> +static ssize_t trig_freq_enable_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    drvdata->trig_freq = !!val;
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(trig_freq_enable);
>> +
>> +static ssize_t freq_ts_enable_show(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->freq_ts);
>> +}
>> +
>> +static ssize_t freq_ts_enable_store(struct device *dev,
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
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    drvdata->freq_ts = !!val;
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(freq_ts_enable);
>> +
>> +static ssize_t global_flush_req_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (!drvdata->csdev->refcnt)
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    CS_UNLOCK(drvdata->base);
>> +    val = readl_relaxed(drvdata->base + TPDA_CR);
>> +    CS_LOCK(drvdata->base);
>> +
>> +    return sysfs_emit(buf, "%lx\n", val);
> 
> I know in practice it's probably only either 0 or 1, but this should 
> either be decimal or have the 0x prefix otherwise it looks like a mistake.
> 

You are right. It looks strange here and I missed this point. I think 
display the value in decimal would be better.

>> +}
>> +
>> +static ssize_t global_flush_req_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    if (!drvdata->csdev->refcnt || !val)
>> +        return -EINVAL;
>> +
>> +    guard(spinlock)(&drvdata->spinlock);
>> +    CS_UNLOCK(drvdata->base);
>> +    val = readl_relaxed(drvdata->base + TPDA_CR);
>> +    val |= BIT(0);
> 
> If you only set bit 0 do you only want to show bit 0 in 
> global_flush_req_show() above? The sysfs files should be divided up by 
> function rather than dumping the whole register, otherwise tools need 
> their own copy of the fields to interperet them.

Got your point here. In the show function, we only need read the value 
of the bit 0 and display the value.

Thanks,
Jie

> 
> 


