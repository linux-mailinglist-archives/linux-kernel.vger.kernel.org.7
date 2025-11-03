Return-Path: <linux-kernel+bounces-882303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75226C2A216
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84753A39FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1C2877F2;
	Mon,  3 Nov 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYnJbs4v"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4A1990C7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149641; cv=none; b=tPQovMoiYVzM3Ib/DJPgQxkPcSLtBm5N8D0B1KUB8yrDln+4w0/Q+Jlmf6C6+QbtvlUXHJg4K6j6WDmMdDYaeW44pliSWZPji64+4Etp0DfGM5dI8/7rTdSiujvQnxlgZmmyAEPl6TzzowZrugOcZSH89mtTtm8tFsVUjzMwN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149641; c=relaxed/simple;
	bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nzn66cWjhzAzVc7O3Yz51YoSntHSlUOgv7b4glrY//BWKafuoB5SWa0h3Bwaz+GINWzQOUI2IGSMeMqHNJU9BfdHBKS1xRW9KSxZifQ5m9P0I0dM86Fy24c9YjmHmxLvl2Fo1r3veiAEUI7DA2vwoLYpZR/vpw2TmC31lC6/mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYnJbs4v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29516a36affso26681785ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762149640; x=1762754440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
        b=UYnJbs4vIjMLsbtCjskCs16VmNkF6uhydvwRR4mlD1zmXzolRcPnfe/KxgderLfBNt
         9cckavzkfNCaZop7/2tDqJjRpUedOH7L1x9HSb41HAHx0LnLQGWHihxmRYxpw++k1zbw
         Vc0X0MRA5zyxLVuuEBfKrW5WFFh+OERDayKUUbkmHHhAy2j7lgVQP1Jy5kQn180eqo2y
         aFn5NfJt1rTsjuZ6XFRt8AOOPBaFTKHLL+Q27U7akRaENTpKRzLRbZWwpdk4EUNGOknE
         KfertAPTHErrafxPKC4AArb2Y0Lr61P+XMjkiOe2+r3k7K0UHZ+KIzsZfwx51K7cPhzA
         9yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149640; x=1762754440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
        b=O8cC8x8qQ9ZGyK6MhB1vSqxRJqeW2ArqlzoFROFjMYnvzhZ9gbdSugRXz5qZ8YOxos
         xt17yphHEYchYaMGsnyU07Kjuv9+wnzKL9MI9PhmbnaZAIZ+sW1mgsXYifoh6LZCVkzI
         yh+r2RdiwGx2itb0ZWH4NI4ME7k3O/nyi8WWzt0fcxGoOurlmtb3VReop+lepwNYGdku
         lJ6YCvCbAi5SZAHAl3H2K9pkz8SX2+Beu/t3aYgdYRAgprVsrQkj+gUzUGr+FrwPCN7g
         ZK0TP8fOc5NOpThMsmEFi3t9aP5yonSC7y3TNhwY0ZSWMiJu2+N2xdj2DscHtYsKWwfc
         fTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4500fZhmz+3oJtkUyW2Up591SSGWcuD/HUZfvBLwnuiQ649VcPTf0vsiArp3tTI3kgm6eKklqycUiYdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZuiEge6Ju7cav9vsh+WtnB57RiwwDlWLcYHtocw/3Wv50gFL
	ivaNbYqEtdiTU/+aIZgLyN0pzzSjRWUdmC0vG50cntQW0cvq0taiK6/O
X-Gm-Gg: ASbGnctZd99Exjl9efYayRe1gTtFQMOZvBLlDZt4iuWarPYo3zKNSff455Q8ut3ccen
	z4vJ80GuRzqA0Fey4ACTFCiaSQMogsuj6SLPcz9D1gH2M9dql1VoCUZNN1DbZpuG4peiMp0A/aj
	+XnTwzl8ZXEX5uZP+BWzL+I4N64TJWUdM9DHnrrer42OGu4eNXIXZc7F/S7tCAWaTwV3A7VElJY
	MnYVHPENjZIgoAvZ0RyO8IXnqKB8pz7WfkTD/UnYphNFluLquYzTSWZ2Gk8Rhv4PAmQdBeyC12C
	j+J31TXEFib12OgbDgtJwQUcZmheyFNh72xbAit5DEEpOaDbZ2auuhdmUEEHieBEHSjvw5HV6aX
	0w39NNk5EBzbtmd/YZHRKRV6sXiaBEedaI5hm38xdFrYPc+33k7z24UoiI4NOb+4oJoHrpzTkCL
	s9eIBIaXj5VkE52Z32hQVpQg==
X-Google-Smtp-Source: AGHT+IGRzFc83vH+4aej1ZtXWsWRwhc5e/vhPzGXxyYQr93eNqozzEOLe2v+EaAyyyHN0ypSfD81jg==
X-Received: by 2002:a17:902:daca:b0:27d:6f37:7b66 with SMTP id d9443c01a7336-2951a486898mr157814315ad.47.1762149639568;
        Sun, 02 Nov 2025 22:00:39 -0800 (PST)
Received: from [10.22.64.59] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29531a1965esm99055775ad.6.2025.11.02.22.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 22:00:38 -0800 (PST)
Message-ID: <bac1bb8a-b9fb-46e5-ae96-cf963d0a337c@gmail.com>
Date: Mon, 3 Nov 2025 14:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-5-dongml2@chinatelecom.cn>
 <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/11/25 01:57, Alexei Starovoitov wrote:
> On Thu, Oct 30, 2025 at 8:36 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>
>> On Fri, Oct 31, 2025 at 9:42 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Sat, Oct 25, 2025 at 8:02 PM Menglong Dong <menglong8.dong@gmail.com> wrote:

[...]

>>
>> Without the session cookie, it will be much easier to implement
>> in another arch. And with the hepler of AI(such as cursor), it can
>> be done easily ;)
>
> The reality is the opposite. We see plenty of AI generated garbage.
> Please stay human.
>
>>
>>> At this point I'm not sure that "symmetry with kprobe_multi_session"
>>> is justified as a reason to add all that.
>>> We don't have a kprobe_session for individual kprobes after all.
>>
>> As for my case, the tracing session can make my code much
>> simpler, as I always use the fentry+fexit to hook a function. And
>> the fexit skipping according to the return value of fentry can also
>> achieve better performance.
>
> I don't buy the argument that 'if (cond) goto skip_fexit_prog'
> in the generated trampoline is measurably faster than
> 'if (cond) return' inside the fexit program.
>
>> AFAIT, the mast usage of session cookie in kprobe is passing the
>> function arguments to the exit. For tracing, we can get the args
>> in the fexit. So the session cookie in tracing is not as important as
>> in kprobe.
>
> Since kprobe_multi was introduced, retsnoop and tetragon adopted
> it to do mass attach, and both use bpf_get_attach_cookie().
> While both don't use bpf_session_cookie().
> Searching things around I also didn't find a single real user
> of bpf_session_cookie() other than selftests/bpf and Jiri's slides :)
>
> So, doing all this work in trampoline for bpf_session_cookie()
> doesn't seem warranted, but with that doing session in trampoline
> also doesn't look useful, since the only benefit vs a pair
> of fentry/fexit is skip of fexit, which can be done already.
> Plus complexity in all JITs... so, I say, let's shelve the whole thing for now.
>

As for bpfsnoop[1], the new attach type is indeed helpful.

For example, when tracing hundreds of kernel functions with both fentry
and fexit programs on a 48-core bare-metal server, the following results
were observed:

bpfsnoop -k 'tcp_connect' --output-fgraph --limit-events 1 -D
2025/11/03 13:32:11 Tracing 586 tracees costs 10.190874525s
2025/11/03 13:32:14 bpfsnoop is exiting..
2025/11/03 13:32:45 Untracing 586 tracees costs 30.667462289s

With the new attach type, about half of the time can be saved.

For bpfsnoop, the return-value control could help avoid redundant
filtering in fexit programs, though it's not strictly necessary.

For instance, when tracing udp_rcv with both packet and argument filters:

bpfsnoop -k '(b)udp_rcv' --filter-pkt 'host 1.1.1.1 and udp src port 53'
--filter-arg 'skb->dev->ifindex == 6' -v
2025/11/03 13:52:55 Tracing(fentry) kernel function udp_rcv
2025/11/03 13:52:55 Tracing(fexit) kernel function udp_rcv

With return-value control, the filtering in fexit could be skipped.

Links:
[1] https://github.com/bpfsnoop/bpfsnoop

Thanks,
Leon

