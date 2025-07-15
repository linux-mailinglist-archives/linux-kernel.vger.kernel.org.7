Return-Path: <linux-kernel+bounces-732552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB892B06887
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D209E3BA77C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224D2BE628;
	Tue, 15 Jul 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u8Nu9TKP"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765334545
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614832; cv=none; b=cA14ucjWc3m+PGeHZ3jdBTun7ag96RLfM2VVtaAUh6lo9amRpHm+5J4KzEVrQZ9BkSYnIdhjDfse92Z5EEuF18hppcncqRY0U34yLJkBMqhW+wOu/EgOOkxquUAIVZC7xU+6e+2s3d8OtOH4Da46T1Nsga05FNYz/RL98A9S88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614832; c=relaxed/simple;
	bh=VjpNf35OKcnhkXnLzTF/gK68gYHm7BJ+ugctx3uQ9Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loCLMW0NB3wT3CxGKVQAgqOUxjT4RhGPMN3DdH1hbpryPIMo8yJIdaKbp4PJlzQGLO3YzIq/q6xyaLZza82yQcAVnySnFNcjPj9BKV0aLeg9J/WBKjMz/Z/u768Ft+zISSbxZlxdj+cWr8bILiy8Eo1w99TP97um7rKX0ZeIuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u8Nu9TKP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27c7c76c-becf-47b1-812b-05f260a8cd85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752614826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEA/2zAXePybJDFAxaDLpMM9vm6sWfj9MGiKkmagMtg=;
	b=u8Nu9TKPospipBgfTFv9o4Tgfk0N3dRsFKn0cXx/l1STx1pHu3MUdBOyYvX/LGW8NhDJ5d
	EVRN1+35e7poQW7ktf+qgaMeoHTqoaN6uA1HR71eLkcXYHGC3t7rnmsWgSSpON2dZ47+gB
	MEu5EAHwE6b9/NByeWjUbriQ3hH/NC8=
Date: Tue, 15 Jul 2025 14:26:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: restrict verifier access to bpf_lru_node.ref
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
References: <20250715075755.114339-1-shankari.ak0208@gmail.com>
 <CAADnVQJ6_pB8ZU2Cw5S6nB4J-6s7bw5Fp-Hst9M_EE9=HxN8+g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQJ6_pB8ZU2Cw5S6nB4J-6s7bw5Fp-Hst9M_EE9=HxN8+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 7:49 AM, Alexei Starovoitov wrote:
> Also you misread the kcsan report.
> 
> It says that 'read' comes from:
> 
> read to 0xffff888118f3d568 of 4 bytes by task 4719 on cpu 1:
>   lookup_nulls_elem_raw kernel/bpf/hashtab.c:643 [inline]
> 
> which is reading hash and key of htab_elem while
> write side actually writes hash too:
> *(u32 *)((void *)node + lru->hash_offset) = hash;
> 
> Martin,
> is it really possible for these read/write to race ?

I think it is possible. The elem in the lru's freelist currently does not wait 
for a rcu gp before reuse. There is a chance that the rcu reader is still 
reading the hash value that was put in the freelist, while the writer is reusing 
and updating it.

I think the percpu_freelist used in the regular hashmap should have similar 
behavior, so may be worth finding a common solution, such as waiting for a rcu 
gp before reusing it.

