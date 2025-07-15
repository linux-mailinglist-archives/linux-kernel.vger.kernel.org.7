Return-Path: <linux-kernel+bounces-731226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DCB0514F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8840B7A356C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB82D23A4;
	Tue, 15 Jul 2025 05:55:02 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F31A275
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558902; cv=none; b=qgHVuXRfBE6gvLj8UgCiWK2Tth4vOej+SprrCNH6bVUhAMljMOCIZxKQa/AOM07+FLEkqygmu+HjLrg0owy/ZK4E8tlzIqQHAuNGb2KbwpTM7Y2SZY7dBI+dn9u74BCwQq7T9XXFwqspu2skmyGdN82AD/qC5P1016DS0l1aTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558902; c=relaxed/simple;
	bh=XelLrXxmWev+15HoGh6EdOnv4tharnY+8LtAR1heZuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVYgnzELE1r4zX2jFoeDD8BavX0m52z8gmN8E7FxTg5Qm1qMyVbV1rvfbYauMvIh2JgnTvNJWc+k07I3vnac5C9Z+LC1wD5PJMKKdfwqv/4d3AfeUmkMEBbIX5cmtbWRK8GwtGHUkIWLe3J4k3QJdQHmeE9ux5eDRLW0STVVI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 38e36c7a614011f0b29709d653e92f7d-20250715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f18467bc-6192-4a83-a15c-7cd286de7323,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:25ee9673b6672b5a7e05d6317dac9e69,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 38e36c7a614011f0b29709d653e92f7d-20250715
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1701579617; Tue, 15 Jul 2025 13:54:50 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 94BD4E008FA2;
	Tue, 15 Jul 2025 13:54:50 +0800 (CST)
X-ns-mid: postfix-6875ED2A-502968116
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id ED9F5E008FBD;
	Tue, 15 Jul 2025 13:54:43 +0800 (CST)
Message-ID: <4aa7ab1e-b006-491f-8224-63dbc86295a3@kylinos.cn>
Date: Tue, 15 Jul 2025 13:54:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp logic
To: Christian Loehle <christian.loehle@arm.com>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kprateek.nayak@amd.com, kuyo.chang@mediatek.com, juju.sung@mediatek.com,
 qyousef@layalina.io
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
 <675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
 <6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
 <8a64cb22-24f7-4ca7-8e4e-22e1612124d9@arm.com>
 <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
 <21236218-b1a3-4333-aaef-cace303288b3@arm.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <21236218-b1a3-4333-aaef-cace303288b3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/10 16:41, Christian Loehle =E5=86=99=E9=81=93:
> On 7/10/25 01:47, Zihuan Zhang wrote:
>> Hi Christian,
>> Apologies for the late reply, and thanks for raising the concerns.
>>
>> =E5=9C=A8 2025/7/3 18:17, Christian Loehle =E5=86=99=E9=81=93:
>>> On 7/3/25 11:07, Zihuan Zhang wrote:
>>>> Hi Christian,
>>>>
>>>> Thanks for the question!
>>>>
>>>> =E5=9C=A8 2025/7/3 17:22, Christian Loehle =E5=86=99=E9=81=93:
>>>>> On 7/3/25 10:14, Zihuan Zhang wrote:
>>>>>> Kernel threads (PF_KTHREAD) are not subject to user-defined utiliz=
ation
>>>>>> clamping. They do not represent user workloads and should not part=
icipate
>>>>>> in any uclamp logic, including:
>>>>> Why not?
>>>>>
>>>> As Xuewen mentioned, some kernel threads may intentionally set sched=
uling attributes for performance. So instead of unconditionally excluding=
 all kernel threads, I=E2=80=99m now considering a more conservative appr=
oach:
>>>> skip only those kthreads that haven=E2=80=99t explicitly set any cla=
mp values.
>>>>
>>>> This should help avoid unintended clamp aggregation while still supp=
orting performance-tuned kthreads.
>>> I'm skeptical, fundamentally you cannot exclude some fair tasks from =
uclamp logic.
>>> At least the cpufreq part they will be affected by, so if you 'exclud=
e' some
>>> kthread that doesn't have clamps set (i.e. has min=3D0, max=3D1024) i=
ts
>>> utilization may not contribute to sugov frequency selection by being
>>> clamped by other task(s) (let's say you only have one other task with
>>> max=3D0, excluding the unclamped kthread now leads to sugov requestin=
g
>>> the lowest OPP? Is that always correct/desired?)
>>>
>>> Is there a specific issue you're trying to solve?
>>> FYI there has been discussion around reworking the uclamp mechanism t=
o solve
>>> some issues you may have been facing, but so far they haven't lead an=
ywhere:
>>> https://lore.kernel.org/lkml/cover.1741091349.git.hongyan.xia2@arm.co=
m/
>> Our original motivation stems from the observation that uclamp is prim=
arily designed to manage frequency selection based on user-space task beh=
avior. Kernel threads typically do not represent user workloads and are o=
ften not considered meaningful participants in uclamp-driven decisions.
> Two comments to that:
> - It's also used to drive task placement, not just frequency selection.
> - There can be cases where a kthread is fundamentally part of a user wo=
rkload,
> thinking about io_uring here, but others exist too.
>
>> To be clear, we are not aiming to exclude all kthreads from affecting =
frequency, but rather to explore ways to avoid unnecessary uclamp aggrega=
tion overhead from kernel threads that have no explicit clamp values set =
(i.e. uclamp.min=3D0, max=3D1024).
>> As you pointed out, fully excluding these tasks might interfere with s=
ugov behavior in certain edge cases. So a more balanced approach might be=
:
>>
>> - For kernel threads that do not set any clamp values, skip the clamp =
aggregation step
>>
>> - If a kernel thread explicitly sets clamp attributes, it should of co=
urse remain fully visible to uclamp logic.
>>
>> This would preserve correctness while reducing unnecessary overhead in=
 the hot path, especially on systems with many runnable tasks.
> So an unclamped task not being part of uclamp will definitely affect th=
e UCLAMP_MAX
> result, as I've mentioned above, you'll apply (other tasks) UCLAMP_MAX =
restrictions
> even if the kthread has UCLAMP_MAX=3D=3D1024. That is not always desira=
ble.
> Or would you let it take part in uclamp if the user explicitly set UCLA=
MP_MAX=3D=3D1024
> instead of relying on the default? That wouldn't be consistent IMO.
>
> Regarding the optimization part:
> Is there a specific workload where the overhead is an issue? It should
> be rather small. Some numbers should help.
You=E2=80=99re absolutely right =E2=80=94 excluding unclamped kernel thre=
ads entirely=20
can unintentionally affect UCLAMP_MAX aggregation, and may lead to=20
undesirable behavior in edge cases. I agree that this would not be a=20
consistent or generally correct approach.

At this stage, I think the idea still lacks maturity, and I appreciate=20
your input in highlighting the possible implications. I=E2=80=99m current=
ly=20
diving deeper into the schedutil governor code to better understand how=20
uclamp aggregation interacts with frequency selection and task placement=20
in real workloads.

With that in mind, I=E2=80=99ll take a step back and revisit the broader =
problem=20
from a more informed perspective. Hopefully, in the near future, I=E2=80=99=
ll=20
come up with a more solid and well-justified solution.

Thanks again for your time and insights.

Best regards,
Zihuan Zhang





