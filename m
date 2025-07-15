Return-Path: <linux-kernel+bounces-731222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE49B05139
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050F23A572C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060D2D23BF;
	Tue, 15 Jul 2025 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ea1jjHx7"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E684501A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558597; cv=none; b=CD6Qa2VNpRppSYrgli9qQWbV8mmYtlCF7U/LHQ7poDdIo44/r+gRluHz2YHAz1oesXpJsVWMIRnfm3drgp+XQ1yRahALTLc8pt+PfTSkjydMuH529p33jGflVX10Ru8vlUdV2RAUWondQ12Oga4y4XAlQ3nUR5L6OM/a3WCes9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558597; c=relaxed/simple;
	bh=LIeyK/2QM2YrkwMZzmOBymmg/tpyPgZFMjUEk6TblII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKt9CIPHrjPDFjDMaf+Ext9KIxtzq3wkRscdLZ+J8FZ/uGjbS29WFAIhXsZF8Af6Di00mAUM+SRlfybKxerhNnOwXcavo3MT7hD7g1cDwDOnkS/91xjZDPXYUmzTgCzeHIr9edcjSNt3dSwWw6uYTAQwQgSsIAZZY2Se4eooJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ea1jjHx7; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21970a1e-dcda-4c23-af84-553419007a38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752558582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCUpv2SK5CMGdJCQSvTooC7yLADWxi2e3sIA550QsOQ=;
	b=ea1jjHx7uUXost6kJd6a+23CzlToM5nrApGHzh/FsKNBgxvARbj6Y5FQmInJBEm7cHFOmn
	3za9HMfSTgRCln650pPwm65YM4XDH1aM4joAKHztTEJbkEtTHUJHwTo6hAHYwACp0iurfJ
	rdGldEgAFXtBCr3u6a26Il63t0c7GeM=
Date: Tue, 15 Jul 2025 13:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and
 attach_tracing for tracing_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-16-dongml2@chinatelecom.cn>
 <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:23 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> We add skip_invalid and attach_tracing for tracing_multi for the
>> selftests.
>>
>> When we try to attach all the functions in available_filter_functions with
>> tracing_multi, we can't tell if the target symbol can be attached
>> successfully, and the attaching will fail. When skip_invalid is set to
>> true, we will check if it can be attached in libbpf, and skip the invalid
>> entries.
>>
>> We will skip the symbols in the following cases:
>>
>> 1. the btf type not exist
>> 2. the btf type is not a function proto
>> 3. the function args count more that 6
>> 4. the return type is struct or union
>> 5. any function args is struct or union
>>
>> The 5th rule can be a manslaughter, but it's ok for the testings.
>>
>> "attach_tracing" is used to convert a TRACING prog to TRACING_MULTI. For
>> example, we can set the attach type to FENTRY_MULTI before we load the
>> skel. And we can attach the prog with
>> bpf_program__attach_trace_multi_opts() with "attach_tracing=1". The libbpf
>> will attach the target btf type of the prog automatically. This is also
>> used to reuse the selftests of tracing.
>>
>> (Oh my goodness! What am I doing?)
> exactly...
>
> Let's think if we need any of that, as in: take a step back, and try
> to explain why you think any of this should be part of libbpf's UAPI.

I know it's weird. The "attach_tracing" is used for selftests, which I can
use something else instead. But the "skip_invalid" is something that we
need.

For example, we have a function list, which contains 1000 kernel functions,
and we want to attach fentry-multi to them. However, we don't know which
of them can't be attached, so the attachment will fail. And we need a way to
skip the functions that can't be attached to make the attachment success.

This should be a common use case. And let me do more research to see if
we can do such filter out of the libbpf.

Thanks!
Menglong Dong


>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   tools/lib/bpf/libbpf.c | 97 ++++++++++++++++++++++++++++++++++++------
>>   tools/lib/bpf/libbpf.h |  6 ++-
>>   2 files changed, 89 insertions(+), 14 deletions(-)
>>
> [...]
>

