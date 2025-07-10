Return-Path: <linux-kernel+bounces-724709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DBAFF611
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C28E560E02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747172BCFB;
	Thu, 10 Jul 2025 00:42:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BACA32
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108178; cv=none; b=JcyEkleiYDAXR1L3KVtTy59ZFGOEs0LFuyo1TSKdcpDHZI5OIKrNx9XR+MvBR5/Ry1dll1W9m9vHBI+UkFsOoiGCLN1TeNax6HgOVaeziUtWGI6Tu84KOWABda69cqoReKXWgJC+S1BlAskGyslEXpq31QEq6RGcoFO3IWuixsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108178; c=relaxed/simple;
	bh=M5AOlc7nfLPWfqNeTKRwsNvqOCCyehvOZHBTgEX4iEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqSVP1lEN4HGtzderO3tzTjn+5+2Xd+Ttz84q+OV4Ib6oMsk/Mhla9D/I3HpxDrCNRd2kzLfkvv00CLqTTo3x34pQzUFEJz1wxgRKvr+8dgyS82hi88K60n3aS/EMuk9nq3HeSeS/cZqEEx1pB150wSBxFSXDD8Ez9mlgFp8xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ccfe583e5d2611f0b29709d653e92f7d-20250710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:367d6493-e81b-47d2-9243-07b2acedfef1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ff4927b9883cc6a27eb834208d54dd16,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ccfe583e5d2611f0b29709d653e92f7d-20250710
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 183848906; Thu, 10 Jul 2025 08:42:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 84F1BE008FA2;
	Thu, 10 Jul 2025 08:42:47 +0800 (CST)
X-ns-mid: postfix-686F0C87-3821944
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6C903E008FA1;
	Thu, 10 Jul 2025 08:42:43 +0800 (CST)
Message-ID: <adef8551-2739-4817-af3a-29357b2aab19@kylinos.cn>
Date: Thu, 10 Jul 2025 08:42:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Initialize uclamp_rq alongside rq setup
 in sched_init()
To: Christian Loehle <christian.loehle@arm.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, patrick.bellasi@arm.com,
 qyousef@layalina.io, xuewen.yan@unisoc.com
Cc: linux-kernel@vger.kernel.org
References: <20250627074535.14064-1-zhangzihuan@kylinos.cn>
 <d8a805d0-74ba-44dd-b5f7-8d2373c9538f@arm.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <d8a805d0-74ba-44dd-b5f7-8d2373c9538f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Christian,
Thanks for the feedback!

=E5=9C=A8 2025/7/9 18:25, Christian Loehle =E5=86=99=E9=81=93:
> On 6/27/25 08:45, Zihuan Zhang wrote:
>> uclamp_rq is currently initialized for all possible CPUs in a separate
>> loop within init_uclamp(). This creates a dependency on the ordering o=
f
>> sched_init() and init_uclamp(), and duplicates the per-CPU iteration.
>>
>> This patch simplifies the logic by moving uclamp_rq initialization int=
o
>> sched_init(), immediately after each cpu_rq is initialized. This ensur=
es
>> uclamprq setup is tightly coupled with rq setup and removes the need f=
or
>> a redundant loop.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   kernel/sched/core.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8988d38d46a3..a160ec8645b2 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1998,7 +1998,7 @@ static void uclamp_post_fork(struct task_struct =
*p)
>>   	uclamp_update_util_min_rt_default(p);
>>   }
>>  =20
>> -static void __init init_uclamp_rq(struct rq *rq)
>> +static void init_uclamp_rq(struct rq *rq)
>>   {
>>   	enum uclamp_id clamp_id;
>>   	struct uclamp_rq *uc_rq =3D rq->uclamp;
>> @@ -2016,10 +2016,6 @@ static void __init init_uclamp(void)
>>   {
>>   	struct uclamp_se uc_max =3D {};
>>   	enum uclamp_id clamp_id;
>> -	int cpu;
>> -
>> -	for_each_possible_cpu(cpu)
>> -		init_uclamp_rq(cpu_rq(cpu));
>>  =20
>>   	for_each_clamp_id(clamp_id) {
>>   		uclamp_se_set(&init_task.uclamp_req[clamp_id],
>> @@ -2043,6 +2039,7 @@ static inline void uclamp_rq_dec(struct rq *rq, =
struct task_struct *p) { }
>>   static inline void uclamp_fork(struct task_struct *p) { }
>>   static inline void uclamp_post_fork(struct task_struct *p) { }
>>   static inline void init_uclamp(void) { }
>> +static inline void init_uclamp_rq(struct rq *rq) {}
>>   #endif /* CONFIG_UCLAMP_TASK */
>>  =20
>>   bool sched_task_on_rq(struct task_struct *p)
>> @@ -8586,6 +8583,7 @@ void __init sched_init(void)
>>   		init_cfs_rq(&rq->cfs);
>>   		init_rt_rq(&rq->rt);
>>   		init_dl_rq(&rq->dl);
>> +		init_uclamp_rq(rq);
>>   #ifdef CONFIG_FAIR_GROUP_SCHED
>>   		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
>>   		rq->tmp_alone_branch =3D &rq->leaf_cfs_rq_list;
>
> I don't necessarily prefer one over the other, both look fine to me FWI=
W.

Just to add one more point in favor of this change: by initializing=20
uclamp_rq directly during the per-CPU rq setup in sched_init(), we avoid=20
a separate for_each_possible_cpu() loop in init_uclamp().

This can reduce initialization overhead, especially on systems with=20
hundreds or even thousands of CPUs.

The logic also becomes easier to maintain since each rq and its=20
associated structures are initialized in one place.

Let me know if there's anything else I should address.


Best regards,
Zihuan Zhang

