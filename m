Return-Path: <linux-kernel+bounces-725691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BC4B0027A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F8A5C15D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA325F986;
	Thu, 10 Jul 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HK1JI6X+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6825D20D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151910; cv=none; b=e7PqA0c13JPnP6BA4fgaytFG59oiEkPQ/2lrQhlWXxjuiMLkiEiOcMF5UA60lXTQ0GeX6deonnKrQerITAmlkYbretBV0VGZbkqVZ0PnOQSWMX66PZgAlW/4ZiQXlsKQISHimxvWgXoacPYuqIYynEZuPtUBnR9AFcep8jnAPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151910; c=relaxed/simple;
	bh=qJVTFBo4M3xSTa06WUDvRL7tfPqLymiyJ5yF+X7E17A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Kdv3DJHwfanYl3K3M1uthqsE74P11+BXdN8rdCJtCnHoOQhgGXx6uPBWjpo/aGevd13+AdqjzNZABErjI5gkYZ1pAbCaoqZFl5Vy541fv6m5O4mJTf3XcDb+/V3AQHiJJM/3S9oB7wr9hLQ9isoAQyWGxxaIVvHAqudz87soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HK1JI6X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9H53Y002945
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wFqoudmfrTbWJQztUs6Cb/RCXPYE6JgwnxS2IM1aJI=; b=HK1JI6X++Uk5l4+o
	jjyPacBM1++58Z7OuDwo7krtsAhI93JNJplCS6h98YMIHbelo8TjIuzYH2bK7TaS
	3pT3pnesAvO5dBE0rwrcuUXjqLhcSckRtrWyjiqx3aD8jKcdQ27v0xknihEIa4s0
	6UqDss277fDc0K/sLQgavC438RjUoIXtVMERwgyr8MPQ65ahENdRTXjOTb8loBFx
	+nyXYV9sRiSeIjM/kDkzywiYlSebgzubHSZf9vbk+uOfKF8uJGG5UYFmndzT50br
	nROkAZvbucGVDybTi6w6Wx63XijFGB7tO9sUr3Q861PdcgiKf586s13KDnPxmldt
	8/tfSw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg8x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:51:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23c6ff64067so2467325ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151906; x=1752756706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wFqoudmfrTbWJQztUs6Cb/RCXPYE6JgwnxS2IM1aJI=;
        b=qTea4AaVY+ROPf74896ySG1wRvU7G0GkCBcrboYPfcxVUc8O0MZz3olX0HaiYFylOy
         DHCrqdwj8cDWV5mOjJTU6meMLMnrij5YUCsxd3AjyChveNdPUl3Z9P51KnjEVF7iAmwj
         ZkLuo2g72M+BckUf/CJzdXU60ZelMuF/UPaSyn9g/GH1kBvmWfb+oz6UbfejPDhBnWOc
         6zi5Mdik6RgixGxjeVYPPNtEQPaLuu30uo5+kIIhAQS17+ByShSWMUDEHOloeiofEfVd
         eQA2tK1EQ44KTmB8biOoAoCVpE1FL6y47+3KgHzBI1DDsUhHh+uBs89BogpJiI8mUxRN
         53YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7WXdeDqPMYEOf2K82jFHN6TZG3RVt+hzaEFMJjv2IbfhYhPi4FhQB6RIuTNzLgZ0E7XQgzpK2YeW3Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIrrpCVKbMxKYl89P5yC1f/B+ZSuIfGHAOpB6Tut6gDux7her
	QSYhKkFvkbCK2gVyX0gJUQL2IgylAndXRiymw+eZx4RqAAzzRP49EjCHczgQvGMpKgTRjY+qhce
	XW8rtqoE4ZEJrimG/2Ud2QYKrYPTLyH3RqusX2hdtit1xEmeCQ+TjkGmoiOpIhIPbU88=
X-Gm-Gg: ASbGncvcn1Okcx+4qufaPX+sBS8qYP9E7DCoBe4LB5YzL72Iu4m1KbFY3WgVALnqvjr
	LmhZRfR2weQb8Fcs1pfIFRCTZu1NQ9mQXrbcZQBzQA63OkNbNWTMxH4V7YlirlKq4vtTOgzyo9M
	a15+surMSlzCu/ymhwlp4GOaIE8crTm3qWQ7nWTrBDQ/tnlUmqimR8tflzmOPVjCV0WybbrpR6A
	aJnUvQmAcP/AT8Bc1OSPXujPdVsuBG4OFmgYqaHIPWYhcteH4d8LcDVzeG72Qnw3R/7CDvdDWMN
	jqh44gM/sSMBBI2n/Eyp4UxvHKJ58nIZvdOCv+HpUvmjkOW1nT53qgVwtJWe8T+1JxNQvYM0O9z
	ml5sOwlWC
X-Received: by 2002:a17:902:e5cd:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23ddb19b4e4mr41885835ad.3.1752151906220;
        Thu, 10 Jul 2025 05:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNpPjMGYZw1nagLC1g4Vq18S4UvqTHhUCsBqkZdx212Vu1mHjiz+Yut2MPX53YHdJ0vn+tfA==
X-Received: by 2002:a17:902:e5cd:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23ddb19b4e4mr41885665ad.3.1752151905695;
        Thu, 10 Jul 2025 05:51:45 -0700 (PDT)
Received: from [10.133.33.206] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322af6sm19823905ad.90.2025.07.10.05.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:51:45 -0700 (PDT)
Message-ID: <c758497c-b008-4fea-a4a3-fb8769ce8b2a@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 20:51:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: Use rt_mutex for icc_bw_lock
To: Georgi Djakov <djakov@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_okukatla@quicinc.com
References: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
 <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDExMCBTYWx0ZWRfX3hwE8FTOZf+e
 gmN7FaonfTVf3bZEvjdHRwi+LfSvWE0X9SABAWoHBnN6eIBKb2LrZBkKpE7tCeVD9zdE+3hSWow
 PPnwyVgn7N7XffGkm5uT4VvI6AbUvCh6qaepcLoed6XL36YzreXOLPK7ipxAXcaD0H5wII9awox
 iBze0nDyKMi3B4GxKQo6KLU7iydhBH8iZ7aBroMkXu4C1THIWrmsFhK/9wCZDmciinjJph2ukK0
 IGV5PNaVyNlD/MVdn/1e0Hkn+oVF2hnvt+SaXALGFnV++RyjmRFfmTJwmxRGJb15Rnmow+usMyA
 aWzYGbYm6S6zdEZjXhheNElVukttrmvunh7RkHkjPQ1Rqsnv2jLR+j4w8MOdgKCkTPP7ye8Dfm6
 Q6D/ZSAzzbiMABULG5ESDOgg2OACMmHUwSeGjBGhJJEEXPVoCO6GbwGN5pvMaKFPyHhTZAPz
X-Proofpoint-ORIG-GUID: kMZvo6YmrwCUV_rQV9uinfHYfobye_tS
X-Proofpoint-GUID: kMZvo6YmrwCUV_rQV9uinfHYfobye_tS
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb763 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=gJ3ddmUR-uWLB-3PzjQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=896 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100110

On 5/16/2025 11:50 PM, Georgi Djakov wrote:
> Hi Mike,
...
>> result in frame drops and visual glitches.
> 
> Ok, so the issue we see is caused by lock contention, as we have many
> clients and some of them try to do very aggressive scaling.
> 
>> To prevent this priority inversion, switch to using rt_mutex for
>> icc_bw_lock. This isn't needed for icc_lock since that's not used in the
>> critical, latency-sensitive voting paths.
> 
> If the issue does not occur anymore with this patch, then this is a good
> sign, but we still need to get some numbers and put them in the commit
> message. The RT mutexes add some overhead and complexity that could
I have some preliminary latency numbers for the icc_lock mutex lock on
my Android phone under normal conditions, ranging from 50 to 1000
nanoseconds. I observed that three normal priority tasks and one
real-time (RT) task are contending for the icc_lock. The latency numbers
are not differentiated between RT and normal tasks, but the 1000ns
latency was observed on the RT task.

The latency numbers can vary significantly depending on the scenario.
Please feel free to suggest any specific testing scenarios to capture
the numbers you are interested in.

The delay numbers will be based on the scheduler's granular time. For
instance, with a 250Hz scheduler tick, single cpu case, the delay is
likely to be around 4ms granular per sched_tick and the other system
tasks's vruntime conditions. Since both real-time (RT) tasks and normal
tasks may compete for this particular mutex lock, it is advisable to use
an rt_mutex to enhance real-time performance.

Here is the potential flow for better understanding:
   +--------------+           +-----------------+


   | RT Task A  |           |Normal cfs task B|


   +--------------+           +-----------------+


                             mutex_lock(&icc_lock)

                             Runnable because of other high prio normal
tasks

                             4ms sched_tick to check chance to run


   call icc_set_bw()


   mutex_lock(&icc_lock)





                            Get the chance to run


                             -->mutex_unlock(&icc_lock)


                             -->deboost task_B prio


   get the lock

> increase latency for both uncontended and contended paths. I am curious

Yes, there will be some overhead. However, if we use an RT thread to
speed up the icc_lock mutex, and if the clock settings can benefit the
entire system, it could be advantageous. For example, increasing the
clock speed could lead to an overall performance boost. In theory, this
approach is worth considering.
> if there is any regression for the non-priority scenarios. Also if there
> are many threads, the mutex cost itself could become a bottleneck.
> 
>>
>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>

-- 
Thx and BRs,
Aiqun(Maria) Yu

