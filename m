Return-Path: <linux-kernel+bounces-730913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B96B04C61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADD17AB2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259D279785;
	Mon, 14 Jul 2025 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzZ6vymR"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93646281358
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535930; cv=none; b=D0FxVgiRmoLTpzxl3sNa41gtkZx9Y8HExL+HHiWdIDyNgWEIoTh+XA6EWgRd0Pcnvlyk6GHQ2IhTh6n+BkaEL4zVUzSph91jpBNwSiApzxj0HETt6XEj29KEcNvUFQsgb+6p86numdtp/HzgZ6R3xvd1jXi69CxloYjX381fKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535930; c=relaxed/simple;
	bh=g928VJ/MMQAjxhqh+sUjqL8aYh9PIDBqwlqj9HriKTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXVjRZahOOpSPpWV+/29SNi+CDBtFiXFahzJb1Wgm/useUKNqLJcDFTrxItvBJvzfdlc64YMdeNfTykXpbHCYwlgAsWY6+F6JOl9MyhoOhDpnOpWQI3qMY/442hYdefr1Gdj8jhHEbMc0lOP3LZo/KrYPZvX0NnxwnSC6o32HLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzZ6vymR; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <324a7b0b-ccff-4d8b-b0a2-f810e90f74f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752535925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjnFWK9YKajtsmrg56AGOFx51s3W0UmHKzgeMTuEqPQ=;
	b=vzZ6vymRoHDVW98EWXScGMUIpOnoibBi3W0HSqRmjnjuHLONeiE2iZ7zYHL237pwm0hmqM
	ILoOyAn3xZhotkqGun+z48vW5HaALVi5C7qMSspMKZL+ByBfRehf0vWXUSRWFdsjf3QO4M
	R+RAkQqp8l02sjVM55KbkcnrpKpXX/8=
Date: Tue, 15 Jul 2025 07:32:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
 <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
 <CAADnVQLHORFKC3PzJ540xxa_bETBypXu2-z7Z+8c+as97vByXA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAADnVQLHORFKC3PzJ540xxa_bETBypXu2-z7Z+8c+as97vByXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/7/15 06:29, Alexei Starovoitov wrote:
> On Mon, Jul 14, 2025 at 2:50 PM Menglong Dong <menglong.dong@linux.dev> wrote:
>>
>> On 2025/7/15 03:52, Alexei Starovoitov wrote:
>>> On Thu, Jul 10, 2025 at 12:10 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>>                           } else {
>>>> -                               addr = kallsyms_lookup_name(tname);
>>>> +                               ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>>>>                           }
>>> Not sure why your benchmarking doesn't show the difference,
>>> but above is a big regression.
>>> kallsyms_lookup_name() is a binary search whereas your
>>> bpf_lookup_attach_addr() is linear.
>>> You should see a massive degradation in multi-kprobe attach speeds.
>>
>> Hi, Alexei. Like I said above, the benchmarking does have
>> a difference for the symbol in the modules, which makes
>> the attachment time increased from 0.135543s to 0.176904s
>> for 8631 symbols. As the symbols in the modules
>> is not plentiful, which makes the overhead slight(or not?).
>>
>> But for the symbol in vmlinux, bpf_lookup_attach_addr() will
>> call kallsyms_on_each_match_symbol(), which is also
>> a binary search, so the benchmarking has no difference,
>> which makes sense.
> I see.
> Just curious, what was the function count in modules on your system ?
> cat /proc/kallsyms|grep '\['|grep -v bpf|wc -l

Hi, it's about 34k:

   cat/proc/kallsyms|grep'\['|grep-vbpf|wc-l
   34740


>
> Only now I read the diff carefully enough to realize that
> you're looking for duplicates across vmlinux and that one module.
>
> Why ?
> BTF based attachment identifies a specific module.
> Even if there are dups between that module and vmlinux the attachment
> is not ambiguous.


When the module is not specified, kallsyms_lookup_name() will be called in

bpf_check_attach_target() to get the address. And

kallsyms_lookup_name() will lookup the symbols in the vmlinux

first. If not found, it will lookup it in the modules. And in this

commit, I follow this logic.


So I lookup duplicates accross vmlinux and modules only when

the modules is not specified, and that's reasonable. However,

we always find the address in the vmlinux if module is not specified,

as the btf type belong to the vmlinux. So we will never lookup the

symbols in the modules if "mod" is not specified, which means

bpf_lookup_attach_addr() won't lookup duplicates accross vmlinux
and modules.

So just forget it :/


Thanks!
Menglong Dong


>
>> I thought we don't need this patch after the pahole fixes this
>> problem. Should I send a V4?
> pahole should fix it, so this change is not needed.
> But pahole will be removing the dups within vmlinux and
> within each module independently. Not across them.
> I don't think "across" is needed, but you somehow believe that
> it's necessary ? (based on this diff)

