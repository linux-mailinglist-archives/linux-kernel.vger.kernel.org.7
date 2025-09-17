Return-Path: <linux-kernel+bounces-821047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B16B803D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC991B24A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71F2C21FE;
	Wed, 17 Sep 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZtXKNF+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6C2F4A1D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120382; cv=none; b=T0e7cQfoL3Xgiu7uI+X+tT/3WWJePOEMy0n2RgTf8CLhobw95qaDJysNTM18xDNxfDvMPe65R7L56Y/RkKNLoYZj/ei+0HCdEbJJlhYl/z2IXqmiBG3U2mEOX6OthGFluC0izOBMzG4MrnmxaU07Yg++R6g++0zWZ/QaSR29Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120382; c=relaxed/simple;
	bh=q4YiJ4QPvFOlePmtrZn6wvfEt4G/DCDDKy91qPSkSMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3G18/fusRVIID0tZll+Ncu0Aa+HuOLENEXttnyf9R/LYYuuYK7GP09dtdF+ISyUgx5UQAbL/GVcbu84ASo9aVPxeG0oEqCWoEDUZwo2kyijd4NbNskLYCjiytmA5/m1jXSuRNfbC/v6jTN928Nw5OLKjuJA3x8U21Szz7r4Wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZtXKNF+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBCqL8027546;
	Wed, 17 Sep 2025 14:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4c5NoP
	+/KMEyuE6stnFP+rnvUtBaPSsbrRLQHfCq0rk=; b=dZtXKNF+f+8v5kciT43b8v
	pU6ElQpsAMOYUajZ1Vt3XObPwHDGo8+4eXLhYsToHruYjIcrSgv68yTqXIkxLnyp
	ilWuPbkwFdKGQfnokAlFDtGGq7jq9d0JOmUib+VqYUlhft+wifz33dP2Eg4if4LA
	KShLo1rWYbwmVg49LPHQWaZbCorYVTSJd9NBm1Ju8ISK+jqzP0QGfvoC9Was9JfX
	g9kZBJ1pux5CVDda8e+kUukBQLov/R9MWvjsvwxVINFvX/IHX26h6S3k+16HmeGt
	QPB7ltwMG3bjv9rgJKY4KoXeey4P278C/8SDOiAbFzal5WD3WSV9diA/naxZEDaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p4dbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:46:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HEXE0E009956;
	Wed, 17 Sep 2025 14:46:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p4dbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:46:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDLA93006385;
	Wed, 17 Sep 2025 14:46:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu9yxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:46:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEk2SA26018376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:46:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D48C558060;
	Wed, 17 Sep 2025 14:46:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8ACA58055;
	Wed, 17 Sep 2025 14:45:59 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:45:59 +0000 (GMT)
Message-ID: <659ba2d4-fee3-410d-b611-04a3586b5bb7@linux.ibm.com>
Date: Wed, 17 Sep 2025 20:15:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: Added fork inheritance test for
 ksm_merging_pages counter
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <f07c901d4b6b1d1c15a8c1bbd324367d6135d0a3.1757946863.git.donettom@linux.ibm.com>
 <26e38fe5-e6c4-4678-8056-95c0ff4350e6@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <26e38fe5-e6c4-4678-8056-95c0ff4350e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXwnycUZ3Fld+5
 2YguMIDES/qowsvDjfe2GgPNRUMYd+a7ylomoGYeDDs82zO7tkSbrFmXCBIV5cJYqoQoxNamT+l
 F0q5Jm28Hv92BRPZ1HRy9xYfG7qDwp73ijaOLOE5MP0bau/2VL86gKFoHsSnKGaTPbIWcvbbdjQ
 WbQ+lymbj7V9dYZ8xNAq1kfwveu0YegRjHPJmo5v2zZG5lWW+Fj/eT8FjjIy9yJFovAqwPJIFIZ
 Xf6Lp1GIgyFovlRCxZJZ/QxzBxmQYEQ6WlnqTndi1lfkJmINtOlWwspS3BE9y/PrCRt8F7PQs3h
 j9HQmxvgOL3HoHXTDZxrMNN7lJIwS6c4+lPp8bTm9EUD9WeOo5Ji9ITacNA2JPuRxpnbcT6aMVU
 RVCc6QbR
X-Proofpoint-ORIG-GUID: 8VeRrE0Wp5XNH9_jmiJFajk_m7pZrsbs
X-Proofpoint-GUID: cPyzT-UFtYtpAzuBmZiqRj02G87oK7XS
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cac9ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Z4megsD6RVqFqqBZ_rsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204


On 9/17/25 6:45 PM, David Hildenbrand wrote:
> On 15.09.25 17:03, Donet Tom wrote:
>> Added a new selftest to verify whether the `ksm_merging_pages` counter
>> in `mm_struct` is not inherited by a child process after fork. This 
>> helps
>> ensure correctness of KSM accounting across process creation.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c 
>> b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index 712f43c87736..645cefba2126 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -602,6 +602,45 @@ static void test_prot_none(void)
>>       munmap(map, size);
>>   }
>>   +static void test_fork_ksm_merging_page_count(void)
>> +{
>> +    const unsigned int size = 2 * MiB;
>> +    char *map;
>> +    pid_t child_pid;
>> +    int status;
>> +
>> +    ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +    map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, 
>> KSM_MERGE_MADVISE);
>> +    if (map == MAP_FAILED)
>> +        return;
>> +
>> +    child_pid = fork();
>> +    if (!child_pid) {
>> +        init_global_file_handles();
>> +        exit(ksm_get_self_merging_pages());
>> +    } else if (child_pid < 0) {
>> +        ksft_test_result_fail("fork() failed\n");
>> +        return;
>
> Probably
>     goto out;
>
> in all these fail cases
>
>> +    }
>> +
>> +    if (waitpid(child_pid, &status, 0) < 0) {
>> +        ksft_test_result_fail("waitpid() failed\n");
>> +        return;
>> +    }
>> +
>> +    status = WEXITSTATUS(status);
>> +    if (status) {
>> +        ksft_test_result_fail("ksm_merging_page in child: %d\n", 
>> status);
>> +        return;
>> +    }
>> +
>> +    ksft_test_result_pass("ksm_merging_pages is not inherited after 
>> fork\n");
>> +
>
> And have
>
>     out:
>
> here


Sure, I will send a v3 with this change.


>
> With that:
>
> Acked-by: David Hildenbrand <david@redhat.com>
>

