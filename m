Return-Path: <linux-kernel+bounces-738914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502FB0BEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DC23B4DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22821C190;
	Mon, 21 Jul 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ahKjYLQD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4A1E50B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086788; cv=none; b=bpc9d+SROVCpRBw4WDWF9QNTGCj56X13cZEIOI3UkOl9M9ruteDE+9CLdAol2W3rpcE9fF6sUYTNkrCJBta3nFR8qT9gZFgM+BIm6VK3jZ05hJDMmXJ2MPRUk4mQJMNKXsdOIKbDdrAUeCfB0WVCEh9SBIkKFH5bkbIva5s3XIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086788; c=relaxed/simple;
	bh=fvM+ozl6+XHAtWN2KGwlDTr89jfpjuWTCkNTiKJMvYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjYoFS0q7feCw17NxQVUZBqFhkp6pTMFPbF/qsDcOxOtdcEAofUTfZTMuNN2s5JtNk+xS/mWMLMNE7l7II4oyZy7Ggdt2aSojeXeB9D8+9cgYl6QKXh85OatXDm0AwqB9Bq4YaMXdXe3utiyu+nUvDJf0ymoN4XvW/2vb239Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ahKjYLQD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KKktwV006542;
	Mon, 21 Jul 2025 08:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=bGSsdyfTbpSHzpF5JRfLo
	TZ7fjKYg0XjSy0F4yc/F+c=; b=ahKjYLQDKDLgY/s6WjJeM5mFoYxgHVWcZG8tR
	B9tUNYCKJ7KvmJ747lmk8lcab6uh/xHZdqudisjMTMBtRfF54DDGgkpl7qntUQQ3
	55O5idO9All0onkrkDWndhLUkjE8lBeyEOVaNI4xuqT7rWHDrE6CDRl03AKvAoy5
	nQzFa2ajUKRkdqlG2ryMwSu6ZRknKjFG5ZDcMC+3jJL2z+eCTyxyGyxNbkoeJeKx
	+W+Z3OtXNexTk/gzXwnMLV/gzD11S3Mw+Pp94Vn2gv+1evFl3m0wW9Cc1sQOJ3UM
	OFaUMfjfbYXV8dUlRr7WPknLKNrF/ZJcE+n+/SIFKCqPCMBiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v7jcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:32:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56L8SwiL013165;
	Mon, 21 Jul 2025 08:32:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v7jce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:32:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L473ch014319;
	Mon, 21 Jul 2025 08:32:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppnw8au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:32:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56L8Wlx549283376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 08:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B26B2004B;
	Mon, 21 Jul 2025 08:32:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E5F20043;
	Mon, 21 Jul 2025 08:32:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 21 Jul 2025 08:32:45 +0000 (GMT)
Date: Mon, 21 Jul 2025 14:02:44 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: simplify sched_init_numa()
Message-ID: <aH37LDGeNHoT9abR@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20250719210753.401129-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250719210753.401129-1-yury.norov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EkXuy4EIkTCccyPbXlKy-kvSgrBuHXps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA3MCBTYWx0ZWRfX4oxFeeLa5jZq
 X4uwX06xN61uEAYPVJ4ioPsG6HPCJLD+RLF8t/92jud82bULyiWwv7P5Ow9Px0NW/09VZ8eQZx0
 TmHfeT2KgN365KYbqdYmwZuZbTA7pTpOEc5U19S1e1KucolGGr0vBpC9aF0gPxE+HsgkkG+YdVI
 EMda4hP880EHTlX4zcBn+vJAcBf2C74p4k4QbdCnm3LdWVN/Nkb+pRBikxEl0jO8HLHdNO76BgL
 8yofq+ChhDsRN9D+gVbH1Zrx3q2z7JRaCKmrtXLbBR38UGiDPiH/dZsbQA4DxziBPw81qtuN9O3
 4lJgFGYAIx6FRXtd7JcB9QvcxB44+GdMsfBwr24/wSGI5A1/bj2HSHsCujLHfLuuMM5ryZv7Ldo
 yN+U8+Ui4ucHxQ6Ma/sqhHKdJiD+mPBNSrQFnL34yiRf0nsSqo3gdkp5Yj8xE1axoeE6aH4q
X-Proofpoint-ORIG-GUID: FtGUxRqRXI3K22o_9G5OcLT8-IlLA73Y
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687dfb33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=0pdV4kcqK58f5xqvrRYA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=879 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210070

* Yury Norov <yury.norov@gmail.com> [2025-07-19 17:07:51]:

> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> The function opencodes for_each_set_bit() macro.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/sched/topology.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b958fe48e020..7dc3c79aa480 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1932,10 +1932,9 @@ void sched_init_numa(int offline_node)
>  		return;
>  	}
>  
> -	for (i = 0, j = 0; i < nr_levels; i++, j++) {
> -		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
> -		distances[i] = j;
> -	}
> +	for_each_set_bit(j, distance_map, NR_DISTANCE_VALUES)
> +		distances[i++] = j;
> +

Dont we need to reset the value of i;

Also now we may be iterating for NR_DISTANCE_VALUES instead of nr_levels.
It should be okay, since NR_DISTANCE_VALUES is just 8.

>  	rcu_assign_pointer(sched_domains_numa_distance, distances);
>  
>  	bitmap_free(distance_map);
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
Srikar Dronamraju

