Return-Path: <linux-kernel+bounces-824372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D47B88E29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944777C55FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47097307AF5;
	Fri, 19 Sep 2025 10:22:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE21307AC6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277354; cv=none; b=HVVz7oZ6bx9U8V58LWWwNUykCBMcOjwWOGZQNszioXfMLPuo8cG+lL0zuMsn8UWifmT42UgWjHN6HjjuVifqsX7fFCeDX913qcOoxp/3ReI4SSIocaJl5Asz4e5lTiQoGNtkf3s7SPFYXEF5k3f+ERE1iREyRhNN9m9ufx/nPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277354; c=relaxed/simple;
	bh=NJyqgcT0ToOoygv6nJUWxVirKbL2uPJ3S7OumxDo9ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RtXHBCQIpwDv3hplAlVWcBm6+9QTwijnJygSvuVO50BIziNAuYhNAsbbTT8lCVzV4SESHc9u5HKWpzLvhRcantYR2toyK04fdOCxZMTbOBJivuHj42lVJRiH7pBN2z4A5TZAybrofF7ghCrQmvSrGmtqHBINWoe4+eT+hEvbGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a6c67b4954211f0b29709d653e92f7d-20250919
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:35d2b3a7-e1c2-4b48-9dc1-dd6e3126be33,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:6493067,CLOUDID:47cfc50a539eb13cb7ec11c6b1a2fe85,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8a6c67b4954211f0b29709d653e92f7d-20250919
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 813518812; Fri, 19 Sep 2025 18:22:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id DC5CDE009009;
	Fri, 19 Sep 2025 18:22:26 +0800 (CST)
X-ns-mid: postfix-68CD2EE2-7977454
Received: from [10.42.20.31] (unknown [10.42.20.31])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5EBB4E009008;
	Fri, 19 Sep 2025 18:22:24 +0800 (CST)
Message-ID: <8a713303-65f7-47e3-b2e6-6262f044d728@kylinos.cn>
Date: Fri, 19 Sep 2025 18:22:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: pengyu <pengyu@kylinos.cn>
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 boqun.feng@gmail.com, longman@redhat.com, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, t.haas@tu-bs.de,
 parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 paulmck@kernel.org, jonas.oberhauser@huaweicloud.com, r.maseli@tu-bs.de,
 lkmm@lists.linux.dev, stern@rowland.harvard.edu
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
 <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
 <aMmJlv8JrzyHRCxR@willie-the-truck>
 <31861b75-02ee-495e-b839-15d7510bf7c6@kylinos.cn>
 <aMqdaCkflusKi2hA@willie-the-truck>
Content-Language: en-US
In-Reply-To: <aMqdaCkflusKi2hA@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025/9/17 19:37, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 06:51:18PM +0800, pengyu wrote:
>> Yes, this issue occurred on a kunpeng920 96-core machine and only
>> affected a small number of systems that had been running for over a
>> year.
>>
>> Vmcore Analysis:
>> =E2=80=A2 Panic triggered by CPU 83 detecting a hard lockup at
>>      queued_spin_lock_slowpath+0x1d8/0x320.
>>
>> =E2=80=A2 Corresponding code:
>>      arch_mcs_spin_lock_contended(&node->locked);
>>
>> =E2=80=A2 The qspinlock involved was the rq lock, which showed a clear=
ed state:
>>      crash> rq.lock,cpu ffffad96ff2907c0
>>        lock =3D {
>>          raw_lock =3D {
>>            {
>>              val =3D {
>>                counter =3D 0
>>              },
>>              {
>>                locked =3D 0 '\000',
>>                pending =3D 0 '\000'
>>              },
>>              {
>>                locked_pending =3D 0,
>>                tail =3D 0
>>              }
>>            }
>>          }
>>        },
>>        cpu =3D 50,
>>
>> =E2=80=A2 CPU 83=E2=80=99s MCS node remained in a locked=3D0 state, wi=
th no previous
>> node found in the qnodes list.
>>      crash> p qnodes:83
>>      per_cpu(qnodes, 83) =3D $292 =3D
>>       {{
>>          mcs =3D {
>>            next =3D 0x0,
>>            locked =3D 0,
>>            count =3D 1
>>          }
>>        },
>>      crash> p qnodes | grep 83
>>        [83]: ffffadd6bf7914c0
>>      crash> p qnodes:all | grep ffffadd6bf7914c0
>>      crash>
>>
>> =E2=80=A2 Since rq->lock was cleared, no CPU could notify CPU 83.
>>
>> This issue has occurred multiple times, but the root cause remains
>> unclear. We suspect that CPU 83 may have failed to enqueue itself,
>> potentially due to a failure in the xchg_tail atomic operation.
>=20
> Hmm. For the lock word to be clear with a CPU spinning on its MCS node
> then something has gone quite badly wrong. I think that would mean that=
:
>=20
>    1. The spinning CPU has updated tail to point to its node (xchg_tail=
())
>    2. The lock-owning CPU then erroneously cleared the tail field
>       (atomic_try_cmpxchg_relaxed())
>=20
> But for the cmpxchg() to succeed in (2) then the xchg() in (1) must be
> ordered after it and the lock word wouldn't end up as zero. This is
> because RmW atomics must be totally ordered for a given memory location
> and that applies regardless of their memory ordering properties.
>=20
> Of course, there could be _a_ bug here but, given the information you'v=
e
> been able to provide, it's not obviously as "simple" as a missing memor=
y
> barrier. Have you confirmed that adding memory barriers makes the probl=
em
> go away?
>=20

Could this mean that even with xchg's relaxed version, cmpxchg would be
impossible to succeed after xchg?

We're unsure of the exact cause, only speculating that memory barriers
might control CPU Store Buffer flushing so that other CPUs can see the
modifications immediately=EF=BC=8Cbut our understanding of this is quite =
limited.

Moreover, each test cycle is lengthy, making it difficult to confirm
whether adding memory barriers resolves the issue.

> If you're able to check the thread_info (via sp_el0) of CPU83 in your
> example, it might be interesting to see whether or not the 'cpu' field
> has been corrupted. For example, if it ends up being read as -1 then we
> may compute a tail of 0 when enqueuing our MCS node into the lock word.
>=20

I checked the code for xchg_tail:
   lsr     w1, w2, #16
   add     x7, x19, #0x2
   swph    w1, w0, [x7]

x19 is the address of the rq lock, and tail is stored in w2. The dumped
registers are:
   x19: ffffad96ff2907c0
   x2 : 0000000001500000

So CPU 83 should calculate tail as 0x1500000, not 0.

>> It has been noted that the _relaxed version is used in xchx_tail, and =
we
>> are uncertain whether this could lead to visibility issues=E2=80=94for=
 example,
>> if CPU 83 modifies lock->tail, but other CPUs fail to observe the
>> change.
>>
>> We are also checking if this is related=EF=BC=9A
>>      https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu=
-bs.de
>=20
> Hopefully I (or somebody from Arm) can provide an update soon on this
> topic but I wouldn't necessarily expect it to help you with this new
> case.
>=20
> Will

We also have another similar issue:
=E2=80=A2 Watchdog detected hard LOCKUP on cpu 18
=E2=80=A2 pc : queued_spin_lock_slowpath+0x2ac

It was stuck in a loop at =EF=BC=9A
     next =3D smp_cond_load_relaxed(&node->next, (VAL));

The read mcs node->next is 0:
crash> p qnodes:18
per_cpu(qnodes, 18) =3D $1 =3D
  {{
     mcs =3D {
       next =3D 0x0,
       locked =3D 0,
       count =3D 1
     }
   },

This seems consistent with the phenomenon described in (6b), but we
found that lock->val read by the following code was incorrectly cleared:

  val =3D atomic_cond_read_acquire(&lock->val, !(VAL &
_Q_LOCKED_PENDING_MASK));

According to the assembly code, lock->val is loaded into w5:
   ldar    w5, [x19]
   mov     w0, w5
   and     w1, w5, #0xffff
The value of register x5 is 0:
   x5 : 0000000000000000

If it were just reordering in xchg_tail, I don't think tail would be
erroneously cleared. Might there be other possibilities for this issue?

--=20
Thanks,
Yu Peng


