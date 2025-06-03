Return-Path: <linux-kernel+bounces-672000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82FACC9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 16:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2AA18955DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F823A562;
	Tue,  3 Jun 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvlsbfNV"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D3239E8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962362; cv=none; b=sZ9DxwPyj3DsSc7+Wrc/+8iZXQKbHRn7apowQRQWSTPIogn44lDsGDEsuAtZecuJjMMQWhs9byGuUZAEwQ0npIefB0hOHJRTz2ZUVVbNm8DW3QNLW7n1yv08OdYbVme83T5pKf9HreU4IdptTkI598TbBmedH1zSnM+Q9xFBpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962362; c=relaxed/simple;
	bh=Oa3m9v6ixL/w0XwxKBKC++92c510OYz+SUXhvliNM6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGlStIdNzbyxPh+isy5xaXQMgVvxPRLL91b/Dl2miAYyvWI4hG7Bixc8niD+weFNnIKbzv5B/4aLseBbUZIlrWFShIOom2HV8X2fLpSBCFKsJNZG6xF7JygI60ZQFx+t1fN5uW0n3v0mqNAAJjuFG5GcezKeuQwb4T5Gbq+IxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvlsbfNV; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48e85d82-e5c7-463a-aef3-f1ecbe863524@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748962348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqSQYLxF3PQOOUCwlDTNZNkyBsHb04BWAzgAdjdwyhc=;
	b=EvlsbfNVsYNh4qBEjeX7r8BS5ZKoBuC4I9Jy/KBSDAIXBkGlYjpPjQ7FrGvaoIc1YK2U82
	NY68Dzuod4b8+tEG4r5jp31kylunsiX/isw+4+jDKqldeuak53JEUJPyINM2hBW1tnQIfa
	GtmqikcwdAhnq/2Jt8WgugxlKH8rYx0=
Date: Tue, 3 Jun 2025 07:52:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add cookie to raw_tp bpf_link_info
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 qmo@kernel.org, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250603022610.3005963-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 7:26 PM, Tao Chen wrote:
> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
> like kprobe etc.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   include/uapi/linux/bpf.h       | 2 ++
>   kernel/bpf/syscall.c           | 1 +
>   tools/include/uapi/linux/bpf.h | 2 ++
>   3 files changed, 5 insertions(+)
>
> Change list:
> - v1 -> v2:
>      - fill the hole in bpf_link_info.(Jiri)
> - v1:
>      https://lore.kernel.org/bpf/20250529165759.2536245-1-chen.dylane@linux.dev
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>   		struct {
>   			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>   			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */

See various examples in uapi/linux/bpf.h, '__u32 :32;' is the preferred
apporach to fill the hole.

> +			__u64 cookie;
>   		} raw_tracepoint;
>   		struct {
>   			__u32 attach_type;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8..1c3dbe44ac 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>   		return -EINVAL;
>   
>   	info->raw_tracepoint.tp_name_len = tp_len + 1;
> +	info->raw_tracepoint.cookie = raw_tp_link->cookie;
>   
>   	if (!ubuf)
>   		return 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 07ee73cdf9..f3e2aae302 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>   		struct {
>   			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>   			__u32 tp_name_len;     /* in/out: tp_name buffer len */
> +			__u32 reserved; /* just fill the hole */
> +			__u64 cookie;
>   		} raw_tracepoint;
>   		struct {
>   			__u32 attach_type;


