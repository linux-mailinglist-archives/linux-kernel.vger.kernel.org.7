Return-Path: <linux-kernel+bounces-712406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02889AF08AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 04:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0C942836F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187F16F841;
	Wed,  2 Jul 2025 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFXwASPE"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9215A848
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424551; cv=none; b=moE8ihJNWckcR1z5Kc1aUcYOv8nSki9odCFoIUnD+Puj49leX1zM3OKm87I4GFMwsrsNCYOu0szy6wFhvBFk2sJxmNfmxt1K43zZbeWYSgCcqf7jELLTP/ydsdyVYhoAq+UxHPU5Ot5GlQMX0izdTSKgN/HzXFZ7tC8OjQXhVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424551; c=relaxed/simple;
	bh=pnfX6anJGFD1XiQodS6OaxmSewMRk6zzePVS6bqvuXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7dwmD3NWC8534olfZvcT7RsgNgXzAPH5SX6xYUauRQaT641z9lpFrnwhYkIm2uSqkmgubayoSkStdij9gXuyvQIoJ+KX3FyLxB3IcC9AijRsmYysJ43t91a6H35rJPp9rH1n2iI60/VxQvwJ+klZlbQI4orxtxZSvumkfIIM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFXwASPE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a303984-e316-413e-a3d0-54912b19b7b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751424533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6Yg7AoSiOWbjjxodSNEoCGX7aXQA2GLA/3rDJ469cE=;
	b=gFXwASPEKxIRGAkpuJhcCtwIHCNuBt8b7q6ZTNstzgkfMfJKFaKlUQyBkjn/3zRLuGa8td
	Vu+vnEk4O4vCh9Cs34Zrf3TJU/Md/lmhM/W7l2DvAQ+87vH+fSNesty7rkZb8zy6o4Jyfz
	s/ofw4xyXMoEcUIBkYdzutAhGFtuR18=
Date: Wed, 2 Jul 2025 10:48:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/3] bpf: Add show_fdinfo for kprobe_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250627082252.431209-1-chen.dylane@linux.dev>
 <20250627082252.431209-3-chen.dylane@linux.dev>
 <CAEf4BzZYS52gztmLgQtsehNDVwv7NBETh97zMk73ZqLL9uJ50Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZYS52gztmLgQtsehNDVwv7NBETh97zMk73ZqLL9uJ50Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/2 04:37, Andrii Nakryiko 写道:
> On Fri, Jun 27, 2025 at 1:23 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show kprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      kprobe_multi
>> link_id:        1
>> prog_tag:       33be53a4fd673e1d
>> prog_id:        21
>> kprobe_cnt:     8
>> missed: 0
>> cookie           func
>> 1                bpf_fentry_test1+0x0/0x20
>> 7                bpf_fentry_test2+0x0/0x20
>> 2                bpf_fentry_test3+0x0/0x20
>> 3                bpf_fentry_test4+0x0/0x20
>> 4                bpf_fentry_test5+0x0/0x20
>> 5                bpf_fentry_test6+0x0/0x20
>> 6                bpf_fentry_test7+0x0/0x20
>> 8                bpf_fentry_test8+0x0/0x10
> 
> two nits:
> 
> 1) order of cookie. For uprobes you have cookie at the end, here in
> the front. Given variable-sized func name, I'd move cookie to the
> front for uprobes for consistency.
> 

Ok, will change it in v7.

> 2) field sizing for cookie (16) is a) not sufficient for maximum
> possible u64 (20 digits) and b) very wasteful in common case of small
> numbers. So use tab instead of fixed-sized column? And why 16
> character sizing for the func column? Just to have more spaces
> emitted?
> 

I just referred to the implementation in bpftool/link.c, i will use tab 
format in v7. "16 character sizing for the func" just keeps consistency 
with cookie, " %s" for func name maybe better.

> 
> Other than that the series looks good to me.
> 
> pw-bot: cr
> 
> 
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 1c75f9c6c66..e8f070504c4 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2622,10 +2622,37 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>          return err;
>>   }
>>
>> +#ifdef CONFIG_PROC_FS
>> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
>> +                                        struct seq_file *seq)
>> +{
>> +       struct bpf_kprobe_multi_link *kmulti_link;
>> +
>> +       kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>> +
>> +       seq_printf(seq,
>> +                  "kprobe_cnt:\t%u\n"
>> +                  "missed:\t%lu\n",
>> +                  kmulti_link->cnt,
>> +                  kmulti_link->fp.nmissed);
>> +
>> +       seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
>> +       for (int i = 0; i < kmulti_link->cnt; i++) {
>> +               seq_printf(seq,
>> +                          "%-16llu %-16pS\n",
>> +                          kmulti_link->cookies[i],
>> +                          (void *)kmulti_link->addrs[i]);
>> +       }
>> +}
>> +#endif
>> +
>>   static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>>          .release = bpf_kprobe_multi_link_release,
>>          .dealloc_deferred = bpf_kprobe_multi_link_dealloc,
>>          .fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>> +#ifdef CONFIG_PROC_FS
>> +       .show_fdinfo = bpf_kprobe_multi_show_fdinfo,
>> +#endif
>>   };
>>
>>   static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

