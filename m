Return-Path: <linux-kernel+bounces-896380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3EC503AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CC4E7439
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5527F747;
	Wed, 12 Nov 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXvcihTj"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63D22A1D4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911903; cv=none; b=r0tPXF5rF1LNh9YAEYdtyg6qL9FIuRPXNXqL/EfqWGFkqP7G/lqty9Zjn+e1iMZ9n4Kwx13YNDtoh9KYCy7zPnL15BcYCzBIJ2SNLhhx4421p14cpeVmodI9/JHsZxQ5QFVQJNsRL8ysbgS9M15YAfWv4zqCIdVEnWOXZNmmBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911903; c=relaxed/simple;
	bh=kqsnlqjSa4IhOrl9lShbvf9SEWNTMIYvIgS6Hka5KSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGY6r0+1L8j18TSPv1urMEBf+pONqhRWDtwFfXN7PUj9zb7PyN5Vuu4uPYQL7KqvYDfTj6tD58kJS0Ad8D8pAPRJxIyCehME83t8k/Z6rx1zde1WQEf291vn0pDXXVVorf9QTOVuG+vJxsRvq9cm0qUqTXgO9K0TxtW3PuOx6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXvcihTj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a85e262d-0e04-41d9-9420-56a1ee1aeed5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762911899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPXmbSUrivLtKg3Q34VPnZo217pp+kGwg6tsDxXR0ts=;
	b=dXvcihTjaPEol0gaKNaafEuJl1ZGcBR4ln4HQke9wnnZPgJTSmjEyH4cuCGESkGMZbFISe
	ArnYcsnP6PHmie2ZK2i9duAq6VRkxpfIdEC+XlbdT9Vs/I57MZyML+uyb1crP480vVJrtt
	oelXpEIIzWySypYTVhFIj7UG774mHIY=
Date: Tue, 11 Nov 2025 17:44:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to
 fix OOB write
Content-Language: en-GB
To: Brahmajit Das <listout@listout.xyz>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251111081254.25532-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 12:12 AM, Brahmajit Das wrote:
> syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
> triggered via bpf_get_stack() when capturing a kernel stack trace.
>
> After the recent refactor that introduced stack_map_calculate_max_depth(),
> the code in stack_map_get_build_id_offset() (and related helpers) stopped
> clamping the number of trace entries (`trace_nr`) to the number of elements
> that fit into the stack map value (`num_elem`).
>
> As a result, if the captured stack contained more frames than the map value
> can hold, the subsequent memcpy() would write past the end of the buffer,
> triggering a KASAN report like:
>
>      BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
>      Write of size N at addr ... by task syz-executor...
>
> Restore the missing clamp by limiting `trace_nr` to `num_elem` before
> computing the copy length. This mirrors the pre-refactor logic and ensures
> we never copy more bytes than the destination buffer can hold.
>
> No functional change intended beyond reintroducing the missing bound check.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Signed-off-by: Brahmajit Das <listout@listout.xyz>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


