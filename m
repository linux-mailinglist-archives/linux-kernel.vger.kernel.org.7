Return-Path: <linux-kernel+bounces-868044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35FC04382
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E74F4B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F0260566;
	Fri, 24 Oct 2025 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvzaN1/E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F11AA1F4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275248; cv=none; b=YqFIkqJ6uSNF3oU+W8D478fZHVZ89qu0Vo+TDG0qfmOBCkfF080caz03OFSMJ5dXxllLKjzIrzMBWUEKgMB6Nuq7X66Rkeccp8s9vHgQz/RHqb+em6IaYWvAJQ2IbhHeaLgk/+ToFgTSCXprjoGYSiKz/eHZjy7rSDELVz7uOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275248; c=relaxed/simple;
	bh=94Rspz2YsRJ/mI3tptdy6Aac/h5cKOPzhyiJkVjLZso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFQ4OBmMjgTjQhwV1KPZAt7hlrXVHeli89Hzma1VhkFvw1zAgeQxPf4Ea16NXY5WDZtOSCIKkJFXXJQhRFN0CjdXAOrpbWgK7cuLXrI87BluYY6jAuaW91VWT1UzQelweM2MOTPrjoHZsh+3U4VkvObv85bYS3ONDOehXe34l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvzaN1/E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEVjtC005006
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P5am9cIwdsyXY0VIFsQ7HOlbX35yaubT05poJPGxdS8=; b=HvzaN1/EfOEjR2LI
	AdQ7hAWcvYxxkJhuP1u/S8kRTBcl5NYkrz2UTPpJVLDxIEklY12lRbhBQkvJnv0Q
	6zcm0C89uCRyGzfy8j2jzk7JA5qTmzcuN5snTy+rNR+aUwiMMrSN1+B9jKzDJhDz
	bPCGjx9LQdJA+U9U+fnKRd9e+Zlb5dzgBQeRDWQWtV1vg7NbnrQNNgVd7Kzahx3i
	nhppfkE82nXRUcmsN8oeSWhMYHwZ3EPf21xnVWkBRTUwgh26PiQg8/Eyv1uZrQ55
	6E5rn9bHOzxHI3wc3L97wF1zhE5VktGzeXMlhp85qjrN1jC7mLwZ6K2vJHVsOMf3
	AJNYrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k1uqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:07:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27c62320f16so15071075ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275245; x=1761880045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P5am9cIwdsyXY0VIFsQ7HOlbX35yaubT05poJPGxdS8=;
        b=cfUh6hrmGKEBDBNTwH8rmh5G3qO2KnxC4V75LfwTbTnf0T6mIq737yxi49P1lUjwau
         fFmV1UpYU1tB3+YwI7QVdoTV1yd6ran7Y5+Njui6OWIXTQYf3Z5YgqrgCHxZE6G9YpSx
         tdK6wdDRuY7ga6/EfLQ+LBazEKUb8MWszL/kf+9ZJF9vsiNf87cFbQqgy/LdZu9txY9K
         tTpsdtIzO2nFPFaAKruCO6AuzFCLAmJas7cRcvL4nEjrrrLxtyuM4tESj5ccy7xuKN9t
         d7vgseonYXDOR7cloKe/kdVI1fuflcS0TFZz+pwa29wBy/Xv58h/vgn6cuzll3GDxpbW
         vDfw==
X-Gm-Message-State: AOJu0Yx7DyN/bs3jQt7RPnXWg1/xQJOAH3nNLfuZPlz0fLY0TVq0nxND
	n50g+WCP8T+ACy5oBoYbN9SofGg8baRmBWEj4cCgjtAO5y3DNUPAZRdTpoeEAjY1C+jWMUjUFOu
	EiTqHbtB5mTykidhfWRjEOOxwt11eMPaFWwuPOtvxtENJM7qegpxGHprD7BrFGCbWHsw=
X-Gm-Gg: ASbGncumXAUdMZlIc7qI0yh3u0v4EEHMFSmv6mRMezDrcKR6+OX9KvbMaldFwa5kDbf
	BJM7AndnfcRMMcMHtv80ZdMA0sJKJVK+CV/b/a+5+xR5/hW1ifWSE6NTu2Bf2MHWJPq2jo6f6i6
	Wjmno6AJxl9iY/WESIWeQfhvMJuRR13mFIYijO85JWufmfDqmmy7DjlBcrKIi+R80UimVB4bvIA
	7oOqH0bNOlLe3oEL1YWic6t2OWB1pk41cB1cZp2nsqJyD22ngG3UZ2a1YBluYnj2uvK+cQvOyEP
	V0cy4rCuwVrx2yhYx2CpaCbEkzVFBm3et0NEIwtq+kiS6BPlqd5QX5ar8UkJ/T67fO1AKQ1VRbp
	FurVq4Pk+y+eHzh+Xs29qIxPHglEO4/yiPCU3I9IeiQms
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id d9443c01a7336-290cb65c642mr331251375ad.54.1761275245121;
        Thu, 23 Oct 2025 20:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hT/5IHicpEX0vzAdNXzjs8PnqWwhcmBGRNi1I4wu55KZqXrQ97k30+PpTa8qlbH5TEhPnw==
X-Received: by 2002:a17:903:46d0:b0:267:9931:dbfb with SMTP id d9443c01a7336-290cb65c642mr331250825ad.54.1761275244535;
        Thu, 23 Oct 2025 20:07:24 -0700 (PDT)
Received: from [10.81.60.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ded7c8bsm38971875ad.22.2025.10.23.20.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 20:07:23 -0700 (PDT)
Message-ID: <b7f44bb8-b12e-43e7-b870-f6499ae13e58@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 11:06:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: add flags in cache_show
To: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
        linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
References: <20251017064839.585204-1-kassey.li@oss.qualcomm.com>
 <910a1d39-ca72-4e79-9f6d-66415794d9a9@suse.cz>
From: Kassey Li <kassey.li@oss.qualcomm.com>
In-Reply-To: <910a1d39-ca72-4e79-9f6d-66415794d9a9@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfXxaBhQWY6zu69
 XSOZg12SoRVfippwAZhsoHlo47Xtkk0Kjh/hypGRMs8Y1tm74Xf+h5AKLesUJmMEg0LKpiEgp+D
 3MGWD30iRb1Chc/oSLTJVVgSTSJ+iKbO1EmOiTW+ZmADUACpzMrusHZ4jnOpm7BHz8utK4GGqVR
 Bvi85X5zekil7n7ytZ2IIbQAl64+pC2u9rIAItQ2nnXyJ+TINl0z3TLGe7ydqcK/nMOLselhqML
 SqlVj0JaSeYegtrO7jAAMLMaDgmxFuX24SMgnvhzi03/EZPz01X7v5IavWThrMprnE6bROjZSY2
 b+T51m6XrLXpkQFdX0rSHfdUKxFOzcywe7iCDLP12q5GgdQgj4GOogl+HpxpmElEx0wPb2fE4ER
 S30ZYBqx42z+2S4xKXsJnATYFWyf8g==
X-Proofpoint-GUID: pF17cY3MHz-0uRq8JFmj4hvQdbOu2osa
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68faed6e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=cU5A3ohShU3V7SrR5iAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: pF17cY3MHz-0uRq8JFmj4hvQdbOu2osa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131


在 10/17/2025 6:50 PM, Vlastimil Babka 写道:
> On 10/17/25 08:48, Kassey Li wrote:
>> Flags info is useful to check the slab type.
>>
>> for example, _SLAB_RECLAIM_ACCOUNT:
>>
>>      0x50100 _SLAB_PANIC _SLAB_RECLAIM_ACCOUNT _SLAB_CMPXCHG_DOUBLE
>>
>> Signed-off-by: Kassey Li <kassey.li@oss.qualcomm.com>
> Many of the flags are represented by files in /sys/kernel/slab/<cache>/
> If you miss some, we could add it there. Changing slabinfo output could
> break some users and the raw hex value is not a stable representation of the
> flags anyway.

may you review this draft change according your suggest  ? if ok, i will 
share v2 change.

diff --git a/mm/slub.c b/mm/slub.c
index b1f15598fbfd..619f446d2251 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -9033,6 +9033,12 @@ static ssize_t slab_size_show(struct kmem_cache 
*s, char *buf)
  }
  SLAB_ATTR_RO(slab_size);

+static ssize_t slab_flags_show(struct kmem_cache *s, char *buf)
+{
+       return sysfs_emit(buf, "%u\n", s->flags);
+}
+SLAB_ATTR_RO(slab_flags);
+
  static ssize_t align_show(struct kmem_cache *s, char *buf)
  {
         return sysfs_emit(buf, "%u\n", s->align);
@@ -9480,6 +9486,7 @@ SLAB_ATTR(skip_kfence);

  static struct attribute *slab_attrs[] = {
         &slab_size_attr.attr,
+       &slab_flags_attr.attr,
         &object_size_attr.attr,
         &objs_per_slab_attr.attr,
         &order_attr.attr,

>
>> ---
>>   mm/slab_common.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 932d13ada36c..f43239211e69 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1083,7 +1083,7 @@ static void print_slabinfo_header(struct seq_file *m)
>>   	 * without _too_ many complaints.
>>   	 */
>>   	seq_puts(m, "slabinfo - version: 2.1\n");
>> -	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>> +	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> <flags>");
>>   	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
>>   	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
>>   	seq_putc(m, '\n');
>> @@ -1112,9 +1112,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>>   	memset(&sinfo, 0, sizeof(sinfo));
>>   	get_slabinfo(s, &sinfo);
>>   
>> -	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
>> +	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d 0x%-8x",
>>   		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
>> -		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
>> +		   sinfo.objects_per_slab, (1 << sinfo.cache_order), s->flags);
>>   
>>   	seq_printf(m, " : tunables %4u %4u %4u",
>>   		   sinfo.limit, sinfo.batchcount, sinfo.shared);

