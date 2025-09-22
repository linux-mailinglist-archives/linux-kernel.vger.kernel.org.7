Return-Path: <linux-kernel+bounces-826960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24668B8FBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33521896147
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66423287518;
	Mon, 22 Sep 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jop2Uggq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175A284892
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532792; cv=none; b=QGQh0RoczWrIUOAj5vF+fIA1CUQvB1x5IQ7j2GcADWWNxSIEgZOXd+xI7Q9CwS98Pa0J0a69sUXcoy38pNkpSe87cNjl2wBAB+IyIYouYLWxwlczfhcwU1agt7qycH1ykwquRWapQ1ohjcfFLXyxqJvaVec1Jj/LbBeN4bC0VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532792; c=relaxed/simple;
	bh=iahSutWnM8ILN9f1GZL+lxyjU0INcODBKIEp08lunJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy9oE2HUEJObhu1G+CPei6yy1AqlNX4bsEPj+xZly5VCc2CYhLZVnpl7bD7v3mRt3CYgNR24LwFuvWW9t7GPEPjNjbkC1Y4Q0JTJSPs1BfEOX6Mq/1YPWmfVMnES/R8ZxfDXzdyhkG3ca5N5QSF7M4M/YpxtDyeQV1PmhBszCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jop2Uggq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8wqwV030254
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QFAuB94TCuhJbu5HfgrzB51Khzr10FN1no2TYnl+3I=; b=jop2UggqJ8cXVBD1
	m585fhzOmI+yGD9lZaq/gDVGNuTf/4g73kSNzeUy8q+znm1KYBzDW4OgH8nKo2U3
	fI1QHHWvnK6+5z0FjXvUJ2SVAh1+XV5K3+sBZh2X7nExAMwlggad+SBxXK4kfCUb
	Ssgbro6R8AoOCFAaenKeznz/amkSeQzJjJNlCDbdywvUrlbxYLY6+yhwsHW+dgj9
	4t5r08a+UHwBIqvzsmU9uCbrFFG+vyv+UR5PFgz1OFz/11mDlsHh+MdfRHVJZpdU
	NSTIemjDXUvRzZdDBmATkNLu29QVAleyVB4n/B7U54Y4j0Gpm/bhkslx951Lhm8f
	F0jwtg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0v674-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:19:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b522037281bso3169479a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532788; x=1759137588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QFAuB94TCuhJbu5HfgrzB51Khzr10FN1no2TYnl+3I=;
        b=Mz8AQBYM7xTT+VWn9DvGQaigXdfW+MMyjuo5Yjq/Wn3lyus/tzLeevxwPlvnJAhc9R
         mMogccBczBuAjQIAAmvZ8Jbm/6Szgi8WUVD6USwtEeUVQHr+6CpiKWNhgC9BRdokjPzW
         i/9aFkC01dv9TqXJLtZzrbXTTk6H6+ZnY9UKBAUfSjVRmdFmtG4Gs3UNBabm+r6q36vS
         G+ZAJpDgjz3WgWilKkSdTeitE0GykTNtUCy8d0XB6zmyYKEgT9WAj/h85JaeB7j185+2
         D/OSMEka/M32LH1RzAd3nXzAG3EHbmx3OJPLB7lm7NVn4xmR5Kt6S8V52Ncs/YpnvTnG
         MZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVlNpjQGUWzDSr3QKSP3aV8t43kaVt0gLqde3RT9/JXup6DgUhfd+T5Jcmce4I5AIyr9L94i0S079GKlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z61UZl6LPs2qjIyLS1pL5DheEk4bXvkvOJ7rUy0JQqQ1FFli
	pbp8GjcjX9C5AGjUphI9K15AiS+S6Wb8axOcxneoRltOdIrPtW4FwwvYMwKrPqi4tM1AXRoB4od
	1kBFjGCSXcyP6xI9hZF3jcw7P4Y/86PRUjnV+GsI2Dd5vWtcGQStmi2JO7c0SDa+DS807pY7cK0
	vQ/g==
X-Gm-Gg: ASbGncuAE/HgAYlGITXm4fBYjDnrdiCL8mhIKabOGFT2SpTq3y25HL1n5puXJH+fM0n
	gvCCgFmqJ9REldTV1QswcpTZuuHbyX0KHM7nRqcqZEdBLTb6doPZddDXY8nYnPgi1h2ux7mvETO
	1uzLXWhd0FYjN2e2Wz3jLVNSXVVaqblk/4UiBSqPkjH6VLHS3YqbiKb5xkLNnoKNs3t2yYQ1U40
	Sqab1PlcdTHVm+QXo7uaRCgBH9/3gn4tlzgEpdPnlLWB1/SXtn5MbUFn/ah3ckfy7XzQZfaGPnc
	WbNxQ9Jf9kINERJtKEUQyig9QAqlceOEdvZ0o7PDE12c8Tv2Yd13yKJCgDsWhgFBjL1ZbXYgkCs
	kTRYQWORXvRq7Dd2M2YblgRvub48x
X-Received: by 2002:a17:90b:3a4f:b0:330:ba05:a799 with SMTP id 98e67ed59e1d1-330ba05a7efmr12060865a91.16.1758532787544;
        Mon, 22 Sep 2025 02:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGlBLHJiIRLKu2Bo5vmptL2RNjyGlsgtdhiL+mYYxplGiZaDVAKYWlOvZMv2E4Ns2BZBmdVA==
X-Received: by 2002:a17:90b:3a4f:b0:330:ba05:a799 with SMTP id 98e67ed59e1d1-330ba05a7efmr12060841a91.16.1758532787103;
        Mon, 22 Sep 2025 02:19:47 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1fccsm12530565a91.14.2025.09.22.02.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:19:46 -0700 (PDT)
Message-ID: <808e57a4-8f1e-4870-894e-2eb05ec7a134@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 17:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
To: Leo Yan <leo.yan@arm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <20250922082920.GB516577@e132581.arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250922082920.GB516577@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R-yNXmONtwdrKVs096jrtLoIOPyEDLFQ
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d114b5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=ck2vDrGU2QCsmqff:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=ZO4bw9XDxdbX_LlL1T4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8oOVJy7o7gST
 fkDqQ2DFTZc0/dxw7++AemKQbozBUZuT02dxG7PrYXJlIpMEhl71LiEsbAOjgpOrYriXKw2tSz+
 WTBQQmjWQa/+PoBwWUjG0PBUjFRW0K/91o2wEGeOHhwhCh5PLWoFtvoQINXoXipshAU13RrG1xp
 q7BBXe6/tTvfd6QxzD8quSMkS1o8uXdY8+GlYvQ3dZeht6mg5bQWAC60BY3aGygIMan/XtY+d+9
 67rkJdSEtNaCuxrdLgguLRtJDB/Qus681RGWRLS4YRAzNRsAIGnZTQl+NfSPHFh+ZddLMwqwN0X
 oTXYEOKccG9DOXhdQCt8JVNVl1Zr7ydYGUsn1TA32EnSU65DOMTEp/t8ogrynx1tR7d6RPgVKcx
 gOtG9SsX
X-Proofpoint-ORIG-GUID: R-yNXmONtwdrKVs096jrtLoIOPyEDLFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025



On 9/22/2025 4:29 PM, Leo Yan wrote:
> On Mon, Sep 22, 2025 at 03:31:39PM +0800, Jie Gan wrote:
>> From: Carl Worth <carl@os.amperecomputing.com>
>>
>> The handle is essential for retrieving the AUX_EVENT of each CPU and is
>> required in perf mode. It has been added to the coresight_path so that
>> dependent devices can access it from the path when needed.
>>
>> Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
>> Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
>> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c  |  3 ++-
>>   include/linux/coresight.h                        | 10 ++++++----
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index f677c08233ba..5c256af6e54a 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -520,6 +520,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>>   		goto out;
>>   
>>   	path = etm_event_cpu_path(event_data, cpu);
>> +	path->handle = handle;
>>   	/* We need a sink, no need to continue without one */
>>   	sink = coresight_get_sink(path);
>>   	if (WARN_ON_ONCE(!sink))
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index b07fcdb3fe1a..1040f73f0537 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1327,7 +1327,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>>   struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
>>   				   enum cs_mode mode, void *data)
>>   {
>> -	struct perf_output_handle *handle = data;
>> +	struct coresight_path *path = data;
>> +	struct perf_output_handle *handle = path->handle;
>>   	struct etr_perf_buffer *etr_perf;
>>   
>>   	switch (mode) {
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 6de59ce8ef8c..4591121ae1d4 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -332,12 +332,14 @@ static struct coresight_dev_list (var) = {				\
>>   
>>   /**
>>    * struct coresight_path - data needed by enable/disable path
>> - * @path_list:              path from source to sink.
>> - * @trace_id:          trace_id of the whole path.
>> + * @path_list:			path from source to sink.
>> + * @trace_id:			trace_id of the whole path.
>> + * struct perf_output_handle:	handle of the aux_event.
> 
> s/struct perf_output_handle/@handle/

Hi Leo,

Thanks for pointing out. I actually missed this error during the code 
review...

Jie

> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
>>    */
>>   struct coresight_path {
>> -	struct list_head	path_list;
>> -	u8			trace_id;
>> +	struct list_head		path_list;
>> +	u8				trace_id;
>> +	struct perf_output_handle	*handle;
>>   };
>>   
>>   enum cs_mode {
>>
>> -- 
>> 2.34.1
>>
>>


