Return-Path: <linux-kernel+bounces-694886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8AAAE11CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 05:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974EF4A228F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07E1DE2A1;
	Fri, 20 Jun 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EqRiKvO0"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AC49641
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390325; cv=none; b=QepE8Yef/boNl4ns7IoWg1U0mOU+BX/DMj16ROzRMjmIzfOQ4NBjOyWdYmQA+F/XrahEVfWKa8ZLJNkujjwP+hqZFZu+7MCxVjGXReBGKOnHuOUERsGtODB3lxMuRHACMp/RtnnpcU0dgtcmIAc6cpmgNBjeC6//vYcUBFoFWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390325; c=relaxed/simple;
	bh=qe2WZJOXDFXtbGsYs8yHVh293TDNB/jAfqNfOyKBbJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQfbgVjoZCBIkXr8G1v/zRuUguUi2tpVM05DO8yKux7G8Yw/4yPjjkUa1TQ6usC3BJyf+NJSSXsnc/btrSFN54A/d+WEaD2Bb1WSDJ6Ii8qiSKb+bJ1BfkR1CDxu3BPxsmgKbHiOwSUa6S4oMiRlNpphEiUfYwgYEHxx0LfmPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EqRiKvO0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77b09f48-01d9-46f1-8a31-a1824c0eef8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750390311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvpYb8k/NL2t39sUPEZh6TnSoeFYsRoqFlVYkMs7g3k=;
	b=EqRiKvO08D0o/1M6IsABbVCaKpmV6NLcNhfCrPzEHHvkJmCWQLslajKSRPNcet189vJjX+
	Sl0tvsTpjoiLAcuxW/EO/pNT0tjU+7pqDKfvVwd/P+2bFK0QzAija06prM6kzzHw/MkPrM
	aSnHXnRzqiX50p4Dko8uruD2mj0rpKQ=
Date: Fri, 20 Jun 2025 11:31:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250619034257.70520-1-chen.dylane@linux.dev>
 <20250619034257.70520-2-chen.dylane@linux.dev>
 <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
 <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
 <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/20 10:59, Alexei Starovoitov 写道:
> On Thu, Jun 19, 2025 at 7:46 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2025/6/20 01:17, Alexei Starovoitov 写道:
>>> On Wed, Jun 18, 2025 at 8:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>> Show kprobe_multi link info with fdinfo, the info as follows:
>>>>
>>>> link_type:      kprobe_multi
>>>> link_id:        1
>>>> prog_tag:       a15b7646cb7f3322
>>>> prog_id:        21
>>>> type:   kprobe_multi
>>>
>>> ..
>>>
>>>> +       seq_printf(seq,
>>>> +                  "type:\t%s\n"
>>>> +                  "kprobe_cnt:\t%u\n"
>>>> +                  "missed:\t%lu\n",
>>>> +                  kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>>>> +                                        "kprobe_multi",
>>>
>>> why print the same info twice ?
>>> seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
>>> in bpf_link_show_fdinfo() already did it in a cleaner way.
>>>
>>
>> link_type only shows 'kprobe_multi', maybe we can show the format like:
> 
> Ohh. Especially so. It would be wrong and confusing to display:
> link_type:      kprobe_multi
> type: kretprobe_multi
> 
> Let's fix 'link_type' to display it properly.

What do you think show like this:

     link_type:      kprobe_multi
     link_id:        1
     prog_tag:       33be53a4fd673e1d
     prog_id:        21
     retprobe:       false
     kprobe_cnt:     8
     missed: 0
     cookie           func
     1                bpf_fentry_test1+0x0/0x20
     7                bpf_fentry_test2+0x0/0x20
     2                bpf_fentry_test3+0x0/0x20
     3                bpf_fentry_test4+0x0/0x20
     4                bpf_fentry_test5+0x0/0x20
     5                bpf_fentry_test6+0x0/0x20
     6                bpf_fentry_test7+0x0/0x20
     8                bpf_fentry_test8+0x0/0x10

-- 
Best Regards
Tao Chen

