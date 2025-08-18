Return-Path: <linux-kernel+bounces-774494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D91B2B312
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C531B23585
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F7274B42;
	Mon, 18 Aug 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IxSnGkQS"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D327464F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550709; cv=none; b=ptoKzoi4SNpbz+mBcAek0xIzdW7s8lHsh6rESdQq8PAljCUj6WSHvQ0xRaC1s8k+6q9ieoGfVRbb9mA50mJWVd5x5vfRIKCRj+xFs+Mdu3SQ4id02DwwmI/rizw84MZjKxLcOOD1g9Gzkcuooj0qrlOKMFBLfEQH1RLyFlfaXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550709; c=relaxed/simple;
	bh=4hW7LC4cNi+fS1SOv1Ntmk6ZkPN2wJjohyW0T1ZBUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfIUBly80GqEAdxIHmh9maVUxKxTqjgoZ1sL4bUZxXo0pECN6fwHsyTwXCUXD5F7yz07NF0w3051fFQHPPXuPl1cOsVp812DPamG1BnrkudCQgH3Ct69DmRVcJwMAMFLcolru+M8NsYdBuCu8cH6ScqAMjjVGS0t82X6ZD4+Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IxSnGkQS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755550693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8O2NHq6qYYnD5Hy2BlMg7tUM/p6f416odz+xSG1Xdaw=;
	b=IxSnGkQS0wzhiL3hUaYbcTUYI0I+SDPNy4HncmVgGQGolXOQ3ps3eNvBOFaUX6qFSH/Lqr
	eua8IPQyKSwUd/LffX+Q43m864orrshzagQ4G1mwY1L4yzYWMNoYTEJT3ukyJLW+W8lcfr
	zYV0bxu0MCCLtc+rZ6CfZ2ZvJ4ltIV4=
Date: Mon, 18 Aug 2025 13:58:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow
 BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH with NULL keys/values.
Content-Language: en-GB
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 BPF Mailing List <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
References: <20250813073955.1775315-1-maze@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250813073955.1775315-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/13/25 12:39 AM, Maciej Żenczykowski wrote:
> BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values == NULL
> seems like a nice way to simply quickly clear a map.

This will change existing API as users will expect
some error (e.g., -EFAULT) return when keys or values is NULL.

We have a 'flags' field in uapi header in

         struct { /* struct used by BPF_MAP_*_BATCH commands */
                 __aligned_u64   in_batch;       /* start batch,
                                                  * NULL to start from beginning
                                                  */
                 __aligned_u64   out_batch;      /* output: next start batch */
                 __aligned_u64   keys;
                 __aligned_u64   values;
                 __u32           count;          /* input/output:
                                                  * input: # of key/value
                                                  * elements
                                                  * output: # of filled elements
                                                  */
                 __u32           map_fd;
                 __u64           elem_flags;
                 __u64           flags;
         } batch;

we can add a flag in 'flags' like BPF_F_CLEAR_MAP_IF_KV_NULL with a comment
that if keys or values is NULL, the batched elements will be cleared.

>
> BPF_MAP_LOOKUP keys/values == NULL might be useful if we just want
> the values/keys and don't want to bother copying the keys/values...
>
> BPF_MAP_LOOKUP keys & values == NULL might be useful to count
> the number of populated entries.

bpf_map_lookup_elem() does not have flags field, so we probably should not
change existins semantics.

>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---
>   kernel/bpf/hashtab.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5001131598e5..8fbdd000d9e0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   
>   	rcu_read_unlock();
>   	bpf_enable_instrumentation();
> -	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
> +	if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size, keys,
>   	    key_size * bucket_cnt) ||
> -	    copy_to_user(uvalues + total * value_size, values,
> +	    uvalues && copy_to_user(uvalues + total * value_size, values,
>   	    value_size * bucket_cnt))) {
>   		ret = -EFAULT;
>   		goto after_loop;


