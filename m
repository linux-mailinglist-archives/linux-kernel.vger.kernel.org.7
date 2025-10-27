Return-Path: <linux-kernel+bounces-872086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16218C0F34B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC85189F883
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB2312829;
	Mon, 27 Oct 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pP17JoL8"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1641922FD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581720; cv=none; b=oBQ+xrD0apC76eAsyOHM/G1xo6zSSxAIzZQVlswje/oydTkW8OM6lBAYzOSLoSiBhFuOC/PqCmajeiue5XdlAJPuacK90o8o0Dn2LNQ7WtisTC8PobFY8ZsYnyoihF4cd4nkxI7oUsNJtYDPTI+yy45TxIt+nbudfrZ67bfdT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581720; c=relaxed/simple;
	bh=hRAxd+FkwQLgGfPsQjGN8X1beEfzKDTTEusJws9tP+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXVee3hzjCHbKL3LcBjgNNLplQmEfBNkn3KuvMFhXqua9ELvjCod0G4b1/b/yzKafqV5mgbEh7CDHXmeh5XOLdyFnLKAxDZGDPKKeQoroEDCHRNVxN4bHV2z0JpGCOr+harsDzojwqrFGVh3A28p1hV5p5E2EdeNY69Gwo92D2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pP17JoL8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761581714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8JTohyHajSv2yqB/P5lZqmQ7D54tX4fjYrvkezQRS8=;
	b=pP17JoL8ihlLdX0Mz1k2oHA6DwL8LdNxl1/o3ETBf0jy2VE2Y37sbSWZW9xW+nzbsmUiWj
	CwhBwBJIDwTqp3AdOPn+Ge9joU1w7Mvqi8gzomjzTcPr9ufDS/yFVa/cOZpvtLw+yJtAYz
	oJPHvPUnU5MYinrHykT44hPQ/pnrGro=
Date: Tue, 28 Oct 2025 00:15:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Amery,

On 2025/10/27 23:44, Amery Hung wrote:
> On Sun, Oct 26, 2025 at 8:41 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> When updating local storage maps with BPF_F_LOCK on the fast path, the
>> special fields were not freed after being replaced. This could cause
>> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
>> map gets freed.
>>
>> Similarly, on the other path, the old sdata's special fields were never
>> freed regardless of whether BPF_F_LOCK was used, causing the same issue.
>>
>> Fix this by calling 'bpf_obj_free_fields()' after
>> 'copy_map_value_locked()' to properly release the old fields.
>>
>> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/bpf_local_storage.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index b931fbceb54da..8e3aea4e07c50 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
>>                         copy_map_value_locked(&smap->map, old_sdata->data,
>>                                               value, false);
>> +                       bpf_obj_free_fields(smap->map.record, old_sdata->data);
> 
> [ ... ]
> 
>>                         return old_sdata;
>>                 }
>>         }
>> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>>                                       false);
>> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
> 
> The one above and this make sense. Thanks for fixing it.
> 

Thanks for your review.

>>                 selem = SELEM(old_sdata);
>>                 goto unlock;
>>         }
>> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>
>>         /* Third, remove old selem, SELEM(old_sdata) */
>>         if (old_sdata) {
>> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
> 
> Is this really needed? bpf_selem_free_list() later should free special
> fields in this selem.
> 

Yes, it’s needed. The new selftest confirms that the special fields are
not freed when updating a local storage map.

Also, bpf_selem_unlink_storage_nolock() doesn’t invoke
bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need to
call bpf_obj_free_fields() here explicitly to free those fields.

Thanks,
Leon

[...]



