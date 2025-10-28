Return-Path: <linux-kernel+bounces-874459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEBC1663D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1E504210
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91434A3DB;
	Tue, 28 Oct 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqTaHq9K"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFE217F31
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674628; cv=none; b=A+XRT+cuZIt2T8Z4+7kLuwD00f/FDyWT9IgfOE0cVm6Iuqkk7CaHHLkkT7J5KUP3NofKTjNPNKeDj2mzjyNcbJ93Ve3aBolmnKBxCiB1Vdro/FgDAXfG0w5moSqGEjn0TmAPij1DupzLxmMkBdmtD7HPVZPGLBje+0bTKWaQe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674628; c=relaxed/simple;
	bh=Tj8ZvhTz97/8amvz01XKhun3eDCFY803CdI9bwOU1JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEhihzob6k9+Q/2xXDgAzaZC3IHCqcX2Yjw5N+uIFU02pHAZKp8jotrTO7+15QJqwvD0OjBBUbA65Nsh07ZTG805mA+tftwrCTFe/KdG9YtFp97tAhtpu0FHHMfd+32jG3T1EkSXAMa4lZnJ2zoLvDoQA5IaTH9CymMx3N9KUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqTaHq9K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d3540a43fso67035105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674626; x=1762279426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF5TM62qsWY0KYgalRztsNCpOTJySBlQjc+dN+egIAg=;
        b=LqTaHq9KoWdTUKmE5KONE51B97dz5QEHczG9XHqmszZcF+9xP4akT9WWmj5y/sTYjA
         +74ddGJEsyd7EtI2dpKL0IUJXzITATPZWhfrHGtKUNTh7C6T2r76x7odTelhDvySVkFv
         UyWv+5NkltGfAWg6Srs9GrvfiPdAEdqY85Ai5RVmtJTprTV4ZH+dlVEQwMFcde6gK4rJ
         9MYk0FqJRF7kvXiJEjwnz8veym27xIuEAC0KU5fhkIjIJiS0DRf1c6hlzqV1e2BiFPuN
         aj3FFUaqLtPuJP+R2nNMGtQuG9ZMDiTPOhiHPGF0bNp7zg6tIOV+mHmvGzg+i0r1xagQ
         s6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674626; x=1762279426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF5TM62qsWY0KYgalRztsNCpOTJySBlQjc+dN+egIAg=;
        b=qKzoNsd3juPULyuJ06bAZYqRPMmcr5bjGsroXZR1LUKL/h7EfESIPTEdPMiR7srTfD
         wqWnEy0baVLPGqLTTQPfHebW+VmA/iahKnOlBWCBoRXn9AnvYWklrvpYU9zaJn1DVO79
         gbKGP7kW7XMowCac/E7iNmHTguQmAoKBlwsFES1/iCZY36ajpR7ZVZHGlfunm8I/Ijww
         YbofpZwf7D4gTZpbEdpNselmdxwWhIKiCUzc/CDbbymJnXcSUc6OEjx7a7fopwxzl2i3
         v+T5rBUNxNymAE5luNorFG8q0LPUpT4gUzJ4zhaRmguvqrjQ1JuD3ZvWBBl0J0Yu03KH
         GErA==
X-Forwarded-Encrypted: i=1; AJvYcCW6U7vBBzW6txv11ardRJ3phc8FRDXJbMnR4Ca+Gwd+NwGfgmIiAwZAZ97WhpxVaep19fkHBy+3MFqBhmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwduKqrLGFY6OGlSKyky+GeWaUhzVjMMlZcaGopZDekkX4ZyDi
	NISG8z06Ug/VsvtASWHuvz4cwxdlrN2Ts6aCmefeXkv5xUrK+TBEX0ufHsjD91hr3vBDjk3G7oH
	K0wDR7NKNtGldKcJNVMVui+zGpclD1JA=
X-Gm-Gg: ASbGncstf3IPzzPb1LAkgeKOBkUkMNLny6hBKfcosLum4A6zXIrHYE6WEHwqf+A2CWh
	aWJcj3XGN3QcbhAtlrBJjZah81pUxyMv2tQvqLaC4padDaUwMyreOsVl/gDyWT8eUzv9+tqwCDR
	3WBC+3SYscUog+CCXa2/pp3jQ2+RYtpipaVm1wiVeq4CMQm1KbN7o31UJ5KbYTbC2XozJunIo3b
	lakoEKNvMzFxYJx+V5D9tt1fDaMAKTagc/uGEV1Ek7/rcYuS4kxosEpp4W6mmoEAZ/UUZe7gg+1
X-Google-Smtp-Source: AGHT+IFEBly4eLU2eMtrpHdWDwUWq3jIOQKd58DzgQ3u8neDEg4iOH++Ap+sBfMU/91tfTmuT/8gb217U8qyaHQbJ4U=
X-Received: by 2002:a17:903:24d:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-294deb25bc7mr1425415ad.0.1761674625931; Tue, 28 Oct 2025
 11:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-2-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:03:30 -0700
X-Gm-Features: AWmQ_blOGTMhHAR4mFgi-mzpm7Mwgmbx48rSRLx0IY5MkekEooV1tyvh3TpbvC0
Message-ID: <CAEf4BzZWzxkUvUc+3ufLahSsGi+BrAv7xQBGhZPCNuy-ZYji-w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/4] bpf: Free special fields when update
 [lru_,]percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
> calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' could cause the
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value[,_long]()' in 'pcpu_copy_value()'.
>
> Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU=
 hashmap")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/hashtab.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c2fcd0cd51e51..26308adc9ccb3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -950,12 +950,14 @@ static void pcpu_copy_value(struct bpf_htab *htab, =
void __percpu *pptr,
>         if (!onallcpus) {
>                 /* copy true value_size bytes */
>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
> +               bpf_obj_free_fields(htab->map.record, this_cpu_ptr(pptr))=
;

would make sense to assign this_cpu_ptr() result in a local variable
and reuse it between copy_map_value and bpf_obj_free_fields().
Consider that for a follow up.


>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
>                 int off =3D 0, cpu;
>
>                 for_each_possible_cpu(cpu) {
>                         copy_map_value_long(&htab->map, per_cpu_ptr(pptr,=
 cpu), value + off);
> +                       bpf_obj_free_fields(htab->map.record, per_cpu_ptr=
(pptr, cpu));
>                         off +=3D size;
>                 }
>         }
> --
> 2.51.0
>

