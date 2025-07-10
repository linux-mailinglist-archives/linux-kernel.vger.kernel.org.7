Return-Path: <linux-kernel+bounces-724715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED70AFF62E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1FD5A6AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49D757EA;
	Thu, 10 Jul 2025 00:55:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2D539A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108941; cv=none; b=h7aHgjzGxy5lxafChord+bqsEZv/7ZXYdlB/52slTruVNR+41ANEEo4uJf5Sr8mk+1WuMO7fbRdCpI9R0G1BaoXZrVBLjfAJcfpRjuvG+vuy6h0SyuNQlpPRJkL7GajzxPp92MIcxvb1p5LxU8MZVkv44LekrxCwmPiz6PXH8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108941; c=relaxed/simple;
	bh=79F+gUTXlPhq8CuqgDKtn/cro8vGCbNIHc0A8RgZLww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jao7qoIJiUWoi5N0GQrfuJti7xW2P+0rXPEUofd3ItifSbrCs76NxD1Pp0Su+Ns4e+BorwjM9LeeHzOVVuH36mTUMXCeNCj61CgqPaTSH0TYguha+gyrsgCbR56L9ijyRJHBcP7IfXzC6fnQ1uHR00Qlfr7JfazV78bakUgudXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 946eb3905d2811f0b29709d653e92f7d-20250710
X-CID-CACHE: Type:Local,Time:202507100847+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:45539900-b632-42c8-b311-88df7a24d4a0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5217392a40c34cc84f26c3787e02cd14,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 946eb3905d2811f0b29709d653e92f7d-20250710
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 198134766; Thu, 10 Jul 2025 08:55:31 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 98420E008FA2;
	Thu, 10 Jul 2025 08:55:31 +0800 (CST)
X-ns-mid: postfix-686F0F83-44035310
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 38EB6E008FA1;
	Thu, 10 Jul 2025 08:55:29 +0800 (CST)
Message-ID: <554d1da1-8b35-489c-973d-b5d5dba31403@kylinos.cn>
Date: Thu, 10 Jul 2025 08:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Loehle <christian.loehle@arm.com>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kprateek.nayak@amd.com, kuyo.chang@mediatek.com, juju.sung@mediatek.com,
 qyousef@layalina.io
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
 <675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
 <6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
 <20250703105147.13e10a77@batman.local.home>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250703105147.13e10a77@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thanks for the feedback!

=E5=9C=A8 2025/7/3 22:51, Steven Rostedt =E5=86=99=E9=81=93:
> On Thu, 3 Jul 2025 18:07:20 +0800
> Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:
>
>> As Xuewen mentioned, some kernel threads may intentionally set
>> scheduling attributes for performance. So instead of unconditionally
>> excluding all kernel threads, I=E2=80=99m now considering a more conse=
rvative
>> approach:
>> skip only those kthreads that haven=E2=80=99t explicitly set any clamp=
 values.
> The above comment bothers me. What kernel threads set scheduling attrib=
utes?
>
>  From my experience working on real-time, no kernel thread gets
> scheduling tweaking correct.
>
> -- Steve


You raised a good point =E2=80=94 in most cases, kernel threads don=E2=80=
=99t explicitly=20
tweak scheduling attributes, and when they do, it might not always be=20
correct or effective. I appreciate the insight from your real-time=20
experience.

The motivation behind this patch is to explore whether it=E2=80=99s worth=
=20
optimizing the uclamp hot path a bit further. Since kernel threads=20
typically don=E2=80=99t benefit from uclamp adjustments and often just in=
herit=20
default values (e.g., max=3D1024), we were wondering if skipping the=20
aggregation logic for such cases could slightly reduce overhead in some=20
workloads.

Of course, we want to be conservative and avoid breaking any legitimate=20
usage. So I=E2=80=99d love to hear your opinion =E2=80=94 do you think it=
=E2=80=99s worthwhile=20
to pursue this kind of micro-optimization in uclamp, or is the potential=20
gain too marginal to justify the added logic?

Thanks again for your time and thoughts!


Best regards,
Zihuan Zhang



