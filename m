Return-Path: <linux-kernel+bounces-731234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA693B0517B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1930E1AA7279
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C972D3ECA;
	Tue, 15 Jul 2025 06:05:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890A2A1BB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559523; cv=none; b=CL2tkNuaWWraIogRmkzGQ/kPaNYxoDJy8KYKcgKOJnyq/7W5MPOX3TqRaWnFvF/GuaU3rXDRu2ZgJa51+Z8Kf6EUbkdGwrg4bCCwtLbpOVh/76jqh7zVRto0SpYWYI1bHKsWV/x3T5TXuYKxTdXda5MaypCznU12Pj+ofqZdpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559523; c=relaxed/simple;
	bh=p6SD7ZAPeitOzAuCPgVf+Vecr4pFxJ0EfaJ0fTzr4Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmx4i5KHaUe3amL+b4jdUGO0T41FGxCuXvYLdmPH9Pk16rkrblcfhcKmJSvEQ+hyu+1gw7s2gbOmwLhCiBrDn+TrrvqQfrkMEBrYYtE8OOJwpZTo4HRhF3yxME0P3SOOY8XJVy01MBeV0KytvZrpvNSgcN4OFAI2gQLyc1YjGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a676cc22614111f0b29709d653e92f7d-20250715
X-CID-CACHE: Type:Local,Time:202507151354+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8c47d828-1003-492a-b37e-9ffef61e4f2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:25ee9673b6672b5a7e05d6317dac9e69,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a676cc22614111f0b29709d653e92f7d-20250715
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 546356701; Tue, 15 Jul 2025 14:05:04 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E4575E008FA3;
	Tue, 15 Jul 2025 14:05:03 +0800 (CST)
X-ns-mid: postfix-6875EF8F-829418151
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5BC91E008FA2;
	Tue, 15 Jul 2025 14:05:02 +0800 (CST)
Message-ID: <7d940c32-0803-4571-8982-71e7f587bffb@kylinos.cn>
Date: Tue, 15 Jul 2025 14:05:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp logic
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Christian Loehle <christian.loehle@arm.com>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kuyo.chang@mediatek.com, juju.sung@mediatek.com, qyousef@layalina.io
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
 <675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
 <6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
 <8a64cb22-24f7-4ca7-8e4e-22e1612124d9@arm.com>
 <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
 <fb97657e-cb61-4e8d-a156-eb1141dce19e@amd.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <fb97657e-cb61-4e8d-a156-eb1141dce19e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/7/10 11:41, K Prateek Nayak =E5=86=99=E9=81=93:
> Hello Zihuan,
>
> On 7/10/2025 6:17 AM, Zihuan Zhang wrote:
>> - For kernel threads that do not set any clamp values, skip the clamp
>> aggregation step
>>
>> - If a kernel thread explicitly sets clamp attributes, it should of
>> course remain fully visible to uclamp logic.
> There are also sched_util_clamp_{min,max} global controls via sysctl
> which can be influencing the kthread scheduling / freq behavior
> indirectly and glancing at the implementation, I think these are
> still handled by clamping in uclamp_eff_get() and effective_cpu_util()
> only looks at uclamp_rq_get() to make freq decisions.
>
> Wouldn't excluding the kthreads from the uclamp aggregation also change
> this behavior? I'm assuming these global knobs can be used to limit
> frequencies when thermal throttle is detected and be reset again once
> the SoC falls below the throttle limits?
>
Hi Prateek,

Thanks a lot for pointing this out =E2=80=94 I hadn=E2=80=99t fully consi=
dered the=20
impact of global sched_util_clamp_{min,max} settings on kernel threads=20
that don=E2=80=99t explicitly set clamp values.

I=E2=80=99ll take a closer look at how this behaves in practice and caref=
ully=20
rethink the approach.

Best regards,
Zihuan Zhang


