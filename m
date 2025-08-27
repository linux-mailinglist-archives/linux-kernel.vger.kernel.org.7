Return-Path: <linux-kernel+bounces-788721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A9B3893C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D01C20342
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB427B323;
	Wed, 27 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMFGtk0r"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D727A103
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317815; cv=none; b=AcFfBk2U1sXBlTiZndnopbwE1RUF/sDxGtj2n0mSDuuhaxJDClnjxbqfJVERnelllRiA4uMgkJSsGZOGOPnG79rpHV+/f/RCUiczakaoGObl5EnWBjTlRCSy7rr6Vb1kR91lrghvTch1B/aEBDuMACI5XvK1DWQoJuOmOscbAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317815; c=relaxed/simple;
	bh=UcsoYt/kNi2IjXhnt14OC9/+65MFRvb3/skzVS2ojWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ihoop2P6hmUnCamJDjp/qnbHu+wWSSY28siGiVJH6BgQnC3FsPF9431GJKgGlsYaRxeCCFrBYfcZRErgXvdHIxs0Qz6HeW6WOObAfwdMWzKu6KT33wc/XRYrBrBMZgtVomVLQ6GardnX5OwDOasbbw9LCrRZgUms0DKvE1xYSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMFGtk0r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57REWA2h029170;
	Wed, 27 Aug 2025 18:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tsicJF
	yUGzqrRincdd9SL6qrr3FQUyZ32w3XHMjc0jQ=; b=AMFGtk0r/dDIFVGJulW71C
	G8/+UdBpoQyCiX/OV0hObViy7xNV2hR8piNzV4J7kl4krhS5rKnZQfdTjWHLaOrK
	JoqtiyteFLCwAAUYy5J9J8U2+yWqzQULraUL9R2nuJ1a/VqF/L1DRXj5wC/HRrg4
	58Uh/TaqISY7JhLCBPqAyJv0AH0uhhlu7HyaooI/B3hXFoxNpjmI8/oPI8pbnd2B
	fjDYXzzV7jIo1g6xdvaD5/QlwtEah4kcHfQDeN1URXzIwr6v9R/e845dqr+4pnH3
	Q16tlxbzukQXpGvytmtfk7uNpdkbeHcoOla0QBtawXJWAckhDfGfpESypRT2bE2A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975cvq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RI3H83002054;
	Wed, 27 Aug 2025 18:03:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975cvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFckvt020799;
	Wed, 27 Aug 2025 18:03:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc0s9w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RI3Fd665339766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:03:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5307258043;
	Wed, 27 Aug 2025 18:03:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B8BD58060;
	Wed, 27 Aug 2025 18:03:12 +0000 (GMT)
Received: from [9.124.214.234] (unknown [9.124.214.234])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 18:03:12 +0000 (GMT)
Message-ID: <0c724a5c-3317-4bc6-b9ba-98b073934b66@linux.ibm.com>
Date: Wed, 27 Aug 2025 23:33:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: add fork inheritance test for
 ksm_merging_pages counter
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
 <88d6d5f08ff119625fa9accaa7b849dd77f9df25.1756211338.git.donettom@linux.ibm.com>
 <ba6d3e50-d8dc-4ee4-ae44-bc1b57e4a2dd@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ba6d3e50-d8dc-4ee4-ae44-bc1b57e4a2dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YCNmbhLy-s6QMExH8r-QNmM3LVWDhq35
X-Proofpoint-ORIG-GUID: Usxyx_aXpToUZfM8V5gW_Hqd6HlYMoj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfX5jaV89N6LQJn
 A11Dun0fx97w01sjRhmsOyjj7Ztb2wEY7jLqcGfJ/95KwA65BkYhW49KPlj4c/PxWFzhSAb1za4
 iFj31Njn6SUQA41/TyRgpspHrnnZlnShjpFogom8KlKBFcwQMnN2j3+r0bHwJD9Y0uHyySqTNu6
 Abp7AeE1WOE1nwh9q5ELKHdBDA5tggNQfv/bwx4PkI5ohTXqu/P+nPTLRkV18R7/izfv5rKKTuk
 Pqp9df0wHjnTqWkJz4wKrCv8m9q68EUCmXSikqT/jS4JbZg33k7JD978bQLvlaaL6qIPxPlaDvD
 QyHxRRrZS5T7s+EJLi9UvYhraj2LSVZIcWtLP4XgDHRLxNTc5RG9RQmKWo16Z8bpCokXC6ArUFN
 ICq0Rsvj
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68af4866 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=BrG3DMFQotyEFiz2VCoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071

Hi David

On 8/26/25 6:52 PM, David Hildenbrand wrote:
> On 26.08.25 14:49, Donet Tom wrote:
>> Add a new selftest to verify whether the `ksm_merging_pages` counter
>
> "to verify ... is *not* inherited" ?
>
I will change it in next version.

>
>
>> in `mm_struct` is inherited by a child process after fork. This helps
>> ensure correctness of KSM accounting across process creation.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c 
>> b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index 712f43c87736..d971394c9567 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -602,6 +602,45 @@ static void test_prot_none(void)
>>       munmap(map, size);
>>   }
>>   +static void test_fork_ksm_merging_page(void)
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
>> +        int mpages;
>> +
>> +        init_global_file_handles();
>> +        mpages = ksm_get_self_merging_pages();
>> +        if (mpages > 0)
>> +            ksft_test_result_fail("ksm_merging_page in child: %d\n", 
>> mpages);
>> +
>> +        exit(0);
>> +    } else if (child_pid < 0) {
>> +        ksft_test_result_fail("fork() failed\n");
>> +        return;
>> +    }
>> +
>> +    if (waitpid(child_pid, &status, 0) < 0) {
>> +        ksft_test_result_fail("waitpid() failed\n");
>> +        return;
>> +    }
>> +
>> +    ksft_test_result_pass("ksm_merging_pages is not inherited after 
>> fork\n");
>
> Won't this trigger a fail in the child and a pass in the parent process?
>
> You should likely instead let the child return the result (or the 
> number) and check that here.


Thanks for pointing this out. I will make the change in the next version



