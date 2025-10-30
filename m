Return-Path: <linux-kernel+bounces-879220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC45C22929
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB82F3BBEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C133BBA3;
	Thu, 30 Oct 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUuXGCYc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA52BAF7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863722; cv=none; b=iSJScmiXo5NRle5wkAIWRblOSMdPgajhtHxdGPRi0lOZoQZCXy3qgLCCgwp3Tv9tIAVCgdbHM8mQObhOQxLxLkzovklAP9uqFG04WIxVi/ak3At22hUdtznnh++l4yM/mTBmRjCHKrS2qos91Db7VdtVbREW83KnkYBpiSnzKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863722; c=relaxed/simple;
	bh=zLn/caSgsK1UHkcN+BLUKD1qS2XUazFMSmih5z8SILk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEZiash+mYte/z+shbJIrQuawIUuMtYZAa+2Ev0XUD+drbVqa7wOOLF83gy/8Mu7x1v4LoH+BD0CJizrT2QJqwimWgo4ialXhrIPrShG5v16ykr8NvnlRyA/DnUJ/NpvMfqkqiq7WkQFDOKbpOq5HeVZtixu0b/zvk8vSK40EJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUuXGCYc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so981266f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761863719; x=1762468519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2Kd7J+q6FDvOoPfI5A3gvP81dJS9CMda+auiDLSkyg=;
        b=BUuXGCYcE4eBqyC9jkeW7vWdpEl9d4X0rRBSWG8d6oUYV0QT1ScRn41N/JIUGiobp2
         BxV0x5nAuCpAomUGVE3hH5NprtqynDmsW7ZinbzrzZshdTppA3TPaNKJYzX+1a8Edc7O
         ZkutwTMy3xbC0EqiG34M4bQS8aFiKcfilAUzIRqAzGytcjKW2CUAeuJktbp7LL1xGUZG
         zf/7ZxF5OG6ApDD3B05NWecdi1KmQYJRvmQ6z3v1u755Jc14wWL6GfgjMXO7IEfcwvWY
         nSdI2KvDtrUITXpUDNGsKJ+QUo1DzmB1747a3cTq5mKLKznqAkPBpFxywEkxSF6300Oy
         /bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863719; x=1762468519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2Kd7J+q6FDvOoPfI5A3gvP81dJS9CMda+auiDLSkyg=;
        b=EQNXeva9bJF8oHX1TEBFHV0XpsOwLbycZBG9FAYOkv4Uz+3W43FqLJhzFgwwbk7igT
         S/N25HNTGhLRJ1MYQNeM565vuChVvST6gcDkiElCiYOq5fqY91FMPly2A1Mx3DlUGy8q
         40QGAcMuR+RG54+ZKg7ZwN9bhZm1QEBjL350eAdDt9BvfrgpStCfjbVolTbgdH74eHZ4
         vZKuFkWIc7yIzfN6WxQbQvmLSjougrbueRy3rZkWMQVL4Fbw7k3Yz4cqi6FOm3qhLz/h
         eZPLB3ld7IPwdLfs/Vm1dLljJUAp+Thok0gDGovf8hKp3cVergJie8lsL1o1BeYUMJ3Z
         TvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+EEBcnIcBqRqiIymkBk5P3LjyQJNNVI3EyVbuXyw+Vu8jAOJmxwUKS5BnpH4/+l8JGRXnDCgFzmfgJRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLgoQREIkmIwQ4Cyw2iau4Vk3zzF4OnEqVlpvCAPJ8jNYIQ7X
	GJ8n2obPIsYThYt5b3pigou3/l+DN4SeU6MZ9bcW1iPUaggKAWRMZc7SrN7wrnP229juZXMZ6DQ
	ujwHhAfnHAn6kSIk7ctinpsN4baq0ihI=
X-Gm-Gg: ASbGncsS/HEUMup7899cZUVN9UbxAdTzwzjpXV5jsdxoIln7I2fpYaKanc4fLcso3M1
	t16w5X0jyyRW7HibRe/boy1IqQLeroy55RYAu6JbDeW3tl9rgE8HV93Y+7Z1g3jkrkMdXj8v9hM
	y8ncTS47jRVNpkZwEtyWWHNQgkkWLXhya9OYasVX/50feXfdzH3PotIwI+4XVjrCxXKTax/IvUm
	8nDzEFOu3vyd43AkMVHhfSrml+/+YeelEGWXZyEh9KPxRdeTMBV8NH/0O+llTnRB7NQI8cEUVpB
	pkKRzFHHefg/BkrSwFu/3e6o7xCy
X-Google-Smtp-Source: AGHT+IHZCU0gTn2L+Kp3B9B3JGAYVk5CsdKbo+O31NvkyuOempOCQnQ6EAdMvfyCUL7LeYh5rvujR6k1Uu36Xz1gFFI=
X-Received: by 2002:a5d:588b:0:b0:429:a81a:a77b with SMTP id
 ffacd0b85a97d-429bd69d876mr969395f8f.31.1761863718764; Thu, 30 Oct 2025
 15:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030152451.62778-1-leon.hwang@linux.dev> <20251030152451.62778-4-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-4-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:35:07 -0700
X-Gm-Features: AWmQ_blKfB4pxXMdDnXXUorw9Ocz1_SHHY4LgAN_jPLmqmk4HBIDWWtoYD5-r84
Message-ID: <CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Free special fields when update
 local storage maps with BPF_F_LOCK
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When updating local storage maps with BPF_F_LOCK on the fast path, the
> special fields were not freed after being replaced. This could cause
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Similarly, on the other path, the old sdata's special fields were never
> freed when BPF_F_LOCK was specified, causing the same issue.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value_locked()' to properly release the old fields.
>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/bpf_local_storage.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index b931fbceb54da..9f447530f9564 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(o=
ld_sdata))) {
>                         copy_map_value_locked(&smap->map, old_sdata->data=
,
>                                               value, false);
> +                       bpf_obj_free_fields(smap->map.record, old_sdata->=
data);
>                         return old_sdata;
>                 }
>         }
> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>                                       false);
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);
>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }

Even with rqspinlock I feel this is a can of worms and
recursion issues.

I think it's better to disallow special fields and BPF_F_LOCK combination.
We already do that for uptr:
        if ((map_flags & BPF_F_LOCK) &&
btf_record_has_field(map->record, BPF_UPTR))
                return -EOPNOTSUPP;

let's do it for all special types.
So patches 2 and 3 will change to -EOPNOTSUPP.

pw-bot: cr

