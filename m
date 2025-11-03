Return-Path: <linux-kernel+bounces-882277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BFC2A0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56603AE731
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CE21D59C;
	Mon,  3 Nov 2025 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SmhpqTcL"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AB28DB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147100; cv=none; b=iFitxEXoCjEZXy2yBEIb2TexUxUHK6FUTqnzja74dJff1jPA3mdA/EH84YTFqaokG6nEBYuJqylL0v2ZGQ+8C0GOtOwXZ6f++noxbd3soxXmGcQonYDREEGMS4U93reks+Xbwap2SSzcDjDGvU2LGvCC/rvMJBiQeNX0VvGAD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147100; c=relaxed/simple;
	bh=BqMy8OZl6w55Yx79EF1g0+22CIMrQmA4XtB4/TbawL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQ+HK8Yy7Bqv11kEezILo//LkLQPV0NoR/Yt67Ym0zNwBk+uZDtz1FGh5bS5/noSnJCDG1ELFVrtHhxBigTZUiLzE7h8YOTz0cqeP4xFjHROI32minnAZ82XTdFWBDcG9HEPULYlKrjsOgkBSRptVwTfQccBGLVSxN5c2ArhDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SmhpqTcL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22f12031-7a19-4824-a9cc-459fb63a5e0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762147086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zTkF1d2o7qRN090LzqlAsBurL3aGAhl0KhdI7HiEXo=;
	b=SmhpqTcLFM8wHiekx7pLSWnOWgBhwJNP/f3HWZ+h2y3OHfOvJRRcJF6OgeeIqt3v7iqcmf
	0NvZbgIMbmR/Bugfsp00TWPhK/+k0EdZLS5br/qWaC1nnFj7q/uK6AzbYx/ibM5twWJ544
	+T/2f0ioiogPEK7YwIVOR5Q4douJjkg=
Date: Mon, 3 Nov 2025 13:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Free special fields when update
 local storage maps with BPF_F_LOCK
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20251030152451.62778-1-leon.hwang@linux.dev>
 <20251030152451.62778-4-leon.hwang@linux.dev>
 <CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 31/10/25 06:35, Alexei Starovoitov wrote:
> On Thu, Oct 30, 2025 at 8:25 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>>                                       false);
>> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
>>                 selem = SELEM(old_sdata);
>>                 goto unlock;
>>         }
>
> Even with rqspinlock I feel this is a can of worms and
> recursion issues.
>
> I think it's better to disallow special fields and BPF_F_LOCK combination.
> We already do that for uptr:
>         if ((map_flags & BPF_F_LOCK) &&
> btf_record_has_field(map->record, BPF_UPTR))
>                 return -EOPNOTSUPP;
>
> let's do it for all special types.
> So patches 2 and 3 will change to -EOPNOTSUPP.
>

Do you mean disallowing the combination of BPF_F_LOCK with other special
fields (except for BPF_SPIN_LOCK) on the UAPI side — for example, in
lookup_elem() and update_elem()?

If so, I'd like to send a separate patch set to implement that after the
series
“bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps” is
applied.

After that, we can easily add the check in bpf_map_check_op_flags() for
the UAPI side, like this:

static inline int bpf_map_check_op_flags(...)
{
	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record,
BPF_SPIN_LOCK))
		return -EINVAL;

	if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record,
~BPF_SPIN_LOCK))
		return -EOPNOTSUPP;
}

Then we can clean up some code, including the bpf_obj_free_fields()
calls that follow copy_map_value_locked(), as well as the existing UPTR
check.

Thanks,
Leon

