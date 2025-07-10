Return-Path: <linux-kernel+bounces-724712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25FAFF627
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A113F3B8E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B378F39;
	Thu, 10 Jul 2025 00:47:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EF3F9FB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108444; cv=none; b=Cdlfq/CWhrXdVZv8dGxuOP67Gy5oj4RCbbB8UoA6YxmS3dI8I5KiTQ4YEV0oLMbqoJsiurVfrJoYrKRBNpDC4RB4ThFu5NwoyaShz4sH0ygrT0VkuO56rIBzJIsbw7T2e5yiSQTPcti6/RkLfOTtu+DM0FI42yL4ewRfafRZTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108444; c=relaxed/simple;
	bh=ksAwr5wIj5CljQ9NYC4Tic0p94tnRkn4iutCwKqtE7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFlzJp3SUeULusmx4N7ZuPaDLchU3yIrXe+HUtIqR/ZK05XD7KQPX2G15qWfXqsgNl+ioIMqWkhL2S2OP58gUXErSf6oxu/foLnVXUu/Kk1Vf4X8t6GURF3nqtPWB7I5v5v8tW5CklpwuAYyWgMBb52wWxFjaJwx/DEOu+Ue56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d2d4eb45d2711f0b29709d653e92f7d-20250710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:135b7ca4-19e6-49e8-9d47-e5bcfecd3eeb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5217392a40c34cc84f26c3787e02cd14,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 6d2d4eb45d2711f0b29709d653e92f7d-20250710
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1550207551; Thu, 10 Jul 2025 08:47:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 43D61E008FA2;
	Thu, 10 Jul 2025 08:47:16 +0800 (CST)
X-ns-mid: postfix-686F0D93-7534961
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7575AE008FA1;
	Thu, 10 Jul 2025 08:47:13 +0800 (CST)
Message-ID: <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
Date: Thu, 10 Jul 2025 08:47:12 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <8a64cb22-24f7-4ca7-8e4e-22e1612124d9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Christian,
Apologies for the late reply, and thanks for raising the concerns.

=E5=9C=A8 2025/7/3 18:17, Christian Loehle =E5=86=99=E9=81=93:
> On 7/3/25 11:07, Zihuan Zhang wrote:
>> Hi Christian,
>>
>> Thanks for the question!
>>
>> =E5=9C=A8 2025/7/3 17:22, Christian Loehle =E5=86=99=E9=81=93:
>>> On 7/3/25 10:14, Zihuan Zhang wrote:
>>>> Kernel threads (PF_KTHREAD) are not subject to user-defined utilizat=
ion
>>>> clamping. They do not represent user workloads and should not partic=
ipate
>>>> in any uclamp logic, including:
>>> Why not?
>>>
>> As Xuewen mentioned, some kernel threads may intentionally set schedul=
ing attributes for performance. So instead of unconditionally excluding a=
ll kernel threads, I=E2=80=99m now considering a more conservative approa=
ch:
>> skip only those kthreads that haven=E2=80=99t explicitly set any clamp=
 values.
>>
>> This should help avoid unintended clamp aggregation while still suppor=
ting performance-tuned kthreads.
> I'm skeptical, fundamentally you cannot exclude some fair tasks from uc=
lamp logic.
> At least the cpufreq part they will be affected by, so if you 'exclude'=
 some
> kthread that doesn't have clamps set (i.e. has min=3D0, max=3D1024) its
> utilization may not contribute to sugov frequency selection by being
> clamped by other task(s) (let's say you only have one other task with
> max=3D0, excluding the unclamped kthread now leads to sugov requesting
> the lowest OPP? Is that always correct/desired?)
>
> Is there a specific issue you're trying to solve?
> FYI there has been discussion around reworking the uclamp mechanism to =
solve
> some issues you may have been facing, but so far they haven't lead anyw=
here:
> https://lore.kernel.org/lkml/cover.1741091349.git.hongyan.xia2@arm.com/
Our original motivation stems from the observation that uclamp is=20
primarily designed to manage frequency selection based on user-space=20
task behavior. Kernel threads typically do not represent user workloads=20
and are often not considered meaningful participants in uclamp-driven=20
decisions.
To be clear, we are not aiming to exclude all kthreads from affecting=20
frequency, but rather to explore ways to avoid unnecessary uclamp=20
aggregation overhead from kernel threads that have no explicit clamp=20
values set (i.e. uclamp.min=3D0, max=3D1024).
As you pointed out, fully excluding these tasks might interfere with=20
sugov behavior in certain edge cases. So a more balanced approach might b=
e:

- For kernel threads that do not set any clamp values, skip the clamp=20
aggregation step

- If a kernel thread explicitly sets clamp attributes, it should of=20
course remain fully visible to uclamp logic.

This would preserve correctness while reducing unnecessary overhead in=20
the hot path, especially on systems with many runnable tasks.

That said, we're open to alternative suggestions if there's a better way=20
to achieve this optimization. We'll also review the earlier rework=20
discussion you linked, thank you for pointing that out.


Best regards,
Zihuan Zhang



