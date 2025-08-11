Return-Path: <linux-kernel+bounces-763506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B751EB2156E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9CE1A22624
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC842296BC3;
	Mon, 11 Aug 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0p9OB8/"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156926ACB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941105; cv=none; b=Kv4hefNYovHhjB/CN2QY1f1oIGGH2bjj61XE+GTVUGfyT4/xP7haTG8HCU3WVKmJSM5HJzSt/kEgSDu7NskzX6u77MSD2wXlPCUPg9OgmPBmYQ2GKBEp5qs6uFNILpLDDxks5Y+M2uxmfd3ouBFk/klPFoJUsynoDs+PWpil6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941105; c=relaxed/simple;
	bh=uMRmrFkD18qWAyJtGOLN7wd3iJns2aNOyMG0QwQH/tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crZOQSLS0wRxf3/vXsqNL8j3Fd4KnB8drVpQsiJeBNmOMoTC/3X5qQEexEBsaRQ09X/okjLRKE5dM6qJJoOFMO5VeaIr5bi7tQgpWsA3ZvJCCo/t2Fginld2gbj1lURmwGu2AKqSJJlsWClf7kizalIo8dlxOZPCs+mUo5X8KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0p9OB8/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8215e80-ff1b-4911-a5b1-417630f9cdde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754941091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaY5Vbb1I2eJYA+3jPXzVWZjR08Br+mJnxh6Lat3O9c=;
	b=d0p9OB8/6vu42Z2Dz5f6hFDY3RUKPlujApLIUJxeLW7vU9CC/IRE4G4ufwMHQjQHBttU23
	TW274dSZ017DaKqKffGKFjtHzzvoHCOb4fkaScqJALGpwPfa1AOeJjlDAvbXjEQ6GngfEM
	B0MM0ZmfdZjE+Bt60ul5W1S8iw1+55I=
Date: Mon, 11 Aug 2025 12:38:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix reuse of DEVMAP
To: Yureka Lilian <yuka@yuka.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811091046.35696-1-yuka@yuka.dev>
 <20250811093945.41028-1-yuka@yuka.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250811093945.41028-1-yuka@yuka.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/11/25 2:39 AM, Yureka Lilian wrote:
> Previously, re-using pinned DEVMAP maps would always fail, because
> get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
> it BPF_F_RDONLY_PROG being set on a map being created is invalid.
> 
> Thus, match the BPF_F_RDONLY_PROG flag being set on the new map when
> checking for compatibility with an existing DEVMAP
> 
> The same problem is handled in third-party ebpf library:
> - https://github.com/cilium/ebpf/issues/925
> - https://github.com/cilium/ebpf/pull/930
> 
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>

This should be a fix for this commit?

Fixes: 0cdbb4b09a06 ("devmap: Allow map lookups from eBPF")

> ---
>   tools/lib/bpf/libbpf.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fb4d92c5c..a554d7fff 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5081,6 +5081,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>   {
>   	struct bpf_map_info map_info;
>   	__u32 map_info_len = sizeof(map_info);
> +	__u32 map_flags_for_check = map->def.map_flags;
>   	int err;
>   
>   	memset(&map_info, 0, map_info_len);
> @@ -5093,11 +5094,20 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>   		return false;
>   	}
>   
> +	/* get_map_info on a DEVMAP will always return flags with
> +	 * BPF_F_RDONLY_PROG set, but it will never be set on a map
> +	 * being created.
> +	 * Thus, match the BPF_F_RDONLY_PROG flag being set on the new
> +	 * map when checking for compatibility with an existing DEVMAP
> +	 */
> +	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
> +		map_flags_for_check |= BPF_F_RDONLY_PROG;

Does it break older kernels that do not set the RDONLY_PROG bit implicitly by 
itself?

> +
>   	return (map_info.type == map->def.type &&
>   		map_info.key_size == map->def.key_size &&
>   		map_info.value_size == map->def.value_size &&
>   		map_info.max_entries == map->def.max_entries &&
> -		map_info.map_flags == map->def.map_flags &&
> +		map_info.map_flags == map_flags_for_check &&
>   		map_info.map_extra == map->map_extra);
>   }
>   


