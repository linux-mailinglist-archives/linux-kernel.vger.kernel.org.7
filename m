Return-Path: <linux-kernel+bounces-731230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E841FB0515F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C824189C455
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80A2D3EDE;
	Tue, 15 Jul 2025 05:59:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0932D3750
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559160; cv=none; b=VrcUeqCxYyb2x2pLs0VsDZXEqRJovWO5mcHi9jOVBHBwIytLCdphTGqX3d395B1taPOHUTIUWWLYv6bsCQzG2my4LnVUazJTyeGD2Ham6u6RHaWr8Z6Alhn9Ehtmu5AmyzyKpCRvKgWntCGLd5qrROTyHzcqNcwvd2pvS2rOY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559160; c=relaxed/simple;
	bh=oYccVPTBCIZQZjxcWnnk04jD4txjoxrZCzGp2/TXie8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqsMWzuIOKiwoIDidNP4BuQQg/N831HHAcer03TV1hlsKMWlt9rXq8hEPvPrBHLaUK1lVt6HJUU34dbFOxiru+OssRN2csof8ykVi9g/z4JPBr7wOTNyXpueBSgUKjpsJ57O0pcscekPXJF09+ILYbUvz12IVWf0ewwXgKvUi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3985582614011f0b29709d653e92f7d-20250715
X-CID-CACHE: Type:Local,Time:202507151354+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:aa0dff6f-5def-4c1b-b87d-af1070dbd090,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:25ee9673b6672b5a7e05d6317dac9e69,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: d3985582614011f0b29709d653e92f7d-20250715
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2014499922; Tue, 15 Jul 2025 13:59:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 22119E008FA3;
	Tue, 15 Jul 2025 13:59:10 +0800 (CST)
X-ns-mid: postfix-6875EE2D-966942127
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 50191E008FA2;
	Tue, 15 Jul 2025 13:59:07 +0800 (CST)
Message-ID: <36dec74c-67eb-44f2-8709-d0eb9c65987a@kylinos.cn>
Date: Tue, 15 Jul 2025 13:59:06 +0800
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
 <554d1da1-8b35-489c-973d-b5d5dba31403@kylinos.cn>
 <20250710100311.15cc55ce@batman.local.home>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250710100311.15cc55ce@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/10 22:03, Steven Rostedt =E5=86=99=E9=81=93:
> On Thu, 10 Jul 2025 08:55:28 +0800
> Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:
>
>> The motivation behind this patch is to explore whether it=E2=80=99s wo=
rth
>> optimizing the uclamp hot path a bit further. Since kernel threads
>> typically don=E2=80=99t benefit from uclamp adjustments and often just=
 inherit
>> default values (e.g., max=3D1024), we were wondering if skipping the
>> aggregation logic for such cases could slightly reduce overhead in som=
e
>> workloads.
>>
>> Of course, we want to be conservative and avoid breaking any legitimat=
e
>> usage. So I=E2=80=99d love to hear your opinion =E2=80=94 do you think=
 it=E2=80=99s worthwhile
>> to pursue this kind of micro-optimization in uclamp, or is the potenti=
al
>> gain too marginal to justify the added logic?
> My honest opinion is that if there's not a huge issue you are trying
> to solve, then it's best to leave things as is. Tweaking this for
> micro-optimizations usually end up causing a regression somewhere you
> never expected.
>
> -- Steve
Thanks for the advice! I=E2=80=99ll keep that in mind for my next patch.

Best regards,
Zihuan Zhang


