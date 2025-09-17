Return-Path: <linux-kernel+bounces-820510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31193B7CDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57232A5632
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE02C0F6E;
	Wed, 17 Sep 2025 10:51:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D57464
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106292; cv=none; b=s5wx5tvv1YCuA1qTMPGHMNJyxV1Znbimsr6XPwQrBLA+CNhKGpi1iVJo4YhowSrjqw3R+MS2dnqIpCFG5B/TjWJ2giEXGueqVrv0izFumpLGySyvBo2+m8BWgmT4E8BrS4Q+MlmTZMOFmXWywVSJPnV3kVviT2xh1swYqkAqCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106292; c=relaxed/simple;
	bh=CHubr+gz/8SeH2ipxwdDKf6GGQvYOWnJ694fs9NTuo4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UR5exgfUWBAajzHnrVjer55MG0BTeC8U4ZMxclv998qNvxE2CN453f/f8wZugWKGQuJ0cuVZ46UpZjytPPj+/x1HH3fF2L6JgkBsmvLgg9u3RDI9zbfXsI+5cErj2qgj6nV9a5k6tjS+XV0lUWujGcRkaDPXmU+nSTvc0InnbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 403277e093b411f0b29709d653e92f7d-20250917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a6d723f1-d286-4965-b2a4-2108b27af4c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ae52444b68201e296db1878e51f33df7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 403277e093b411f0b29709d653e92f7d-20250917
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 245116275; Wed, 17 Sep 2025 18:51:22 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A658EE009009;
	Wed, 17 Sep 2025 18:51:22 +0800 (CST)
X-ns-mid: postfix-68CA92AA-57447578
Received: from [10.42.20.31] (unknown [10.42.20.31])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6AB64E009008;
	Wed, 17 Sep 2025 18:51:19 +0800 (CST)
Message-ID: <31861b75-02ee-495e-b839-15d7510bf7c6@kylinos.cn>
Date: Wed, 17 Sep 2025 18:51:18 +0800
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
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, boqun.feng@gmail.com, longman@redhat.com,
 linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 t.haas@tu-bs.de, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, jonas.oberhauser@huaweicloud.com,
 r.maseli@tu-bs.de, lkmm@lists.linux.dev, stern@rowland.harvard.edu
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
 <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
 <aMmJlv8JrzyHRCxR@willie-the-truck>
Content-Language: en-US
In-Reply-To: <aMmJlv8JrzyHRCxR@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/17/25 00:00, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 04:10:32PM +0200, Peter Zijlstra wrote:
>> On Tue, Sep 16, 2025 at 11:39:03AM +0800, pengyu wrote:
>>> From: Yu Peng <pengyu@kylinos.cn>
>>>
>>> A hardlock detected on arm64: rq->lock was released, but a CPU
>>> blocked at mcs_node->locked and timed out.
>>>
>>> We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
>>> versions without memory barriers. Suspected insufficient coherence
>>> guarantees on some arm64 microarchitectures, potentially leading to
>>> the following issues occurred:
>>>
>>> CPU0:                                           CPU1:
>>> // Set tail to CPU0
>>> old =3D xchg_tail(lock, tail);
>>>
>>> //CPU0 read tail is itself
>>> if ((val & _Q_TAIL_MASK) =3D=3D tail)
>>>                                                  // CPU1 exchanges th=
e tail
>>>                                                  old =3D xchg_tail(lo=
ck, tail)
>>> //assuming CPU0 not see tail change
>>> atomic_try_cmpxchg_relaxed(
>>> 	  &lock->val, &val, _Q_LOCKED_VAL)
>>> //released without notifying CPU1
>>> goto release;
>>>                                                  //hardlock detected
>>>                                                  arch_mcs_spin_lock_c=
ontended(
>>>                                                        &node->locked)
>>>
>>> Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _rel=
axed.
>>
>> Yeah, no. We do not apply patches based on suspicion. And we most
>> certainly do not sprinkle #ifdef ARM64 in generic code.
>=20
> Absolutely.
>=20
>> There is this thread:
>>
>>    https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-b=
s.de
>>
>> Which is also concerned with xchg_tail(). Reading back, I'm not sure
>> we've ever heard back from ARM on whether that extra ;si was correct o=
r
>> not, Will?
>=20
> It's still under discussion with the Arm architects but it was _very_
> close to concluding last time we met and I wouldn't worry about it for
> the purposes of this report.
>=20
>> Anyway, as Waiman already asked, please state your exact ARM64
>> microarch.
>>
>> Barring the ;si, the above thread suggests that they can prove the cod=
e
>> correct with the below change, does that resolve your problem?
>>
>> Other than that, I'm going to have to leave this to Will and co.
>=20
> I'll take a look but it's light on details.
>=20
> Will


Yes, this issue occurred on a kunpeng920 96-core machine and only
affected a small number of systems that had been running for over a
year.

Vmcore Analysis:
=E2=80=A2 Panic triggered by CPU 83 detecting a hard lockup at
     queued_spin_lock_slowpath+0x1d8/0x320.

=E2=80=A2 Corresponding code:
     arch_mcs_spin_lock_contended(&node->locked);

=E2=80=A2 The qspinlock involved was the rq lock, which showed a cleared =
state:
     crash> rq.lock,cpu ffffad96ff2907c0
       lock =3D {
         raw_lock =3D {
           {
             val =3D {
               counter =3D 0
             },
             {
               locked =3D 0 '\000',
               pending =3D 0 '\000'
             },
             {
               locked_pending =3D 0,
               tail =3D 0
             }
           }
         }
       },
       cpu =3D 50,

=E2=80=A2 CPU 83=E2=80=99s MCS node remained in a locked=3D0 state, with =
no previous
node found in the qnodes list.
     crash> p qnodes:83
     per_cpu(qnodes, 83) =3D $292 =3D
      {{
         mcs =3D {
           next =3D 0x0,
           locked =3D 0,
           count =3D 1
         }
       },
     crash> p qnodes | grep 83
       [83]: ffffadd6bf7914c0
     crash> p qnodes:all | grep ffffadd6bf7914c0
     crash>

=E2=80=A2 Since rq->lock was cleared, no CPU could notify CPU 83.

This issue has occurred multiple times, but the root cause remains
unclear. We suspect that CPU 83 may have failed to enqueue itself,
potentially due to a failure in the xchg_tail atomic operation.

It has been noted that the _relaxed version is used in xchx_tail, and we
are uncertain whether this could lead to visibility issues=E2=80=94for ex=
ample,
if CPU 83 modifies lock->tail, but other CPUs fail to observe the
change.

We are also checking if this is related=EF=BC=9A
     https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs=
.de





