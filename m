Return-Path: <linux-kernel+bounces-872005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091EC0F09F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BA219C3E05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835132D8DCA;
	Mon, 27 Oct 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx+jkrkg"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A82D595B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579907; cv=none; b=dBXGejYcF2crYVebE3n4FcRFw7/97WFq8/BjBHThnPxyn3iQ0aJzzS7ScFybD+xBBcWIRAE4xTyT1sZpI+6u38dvWxuCelR1bJjsqWtIJSdomlf3zsa09EDpxuLURGnkjs5qiwCeh2kkO2/MIANULXNBxjFdTuE/E+MAC2YPhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579907; c=relaxed/simple;
	bh=qgXmkNhAhY6WchRH7Q4rsd2FBpG4g/uYCUhhcPv5dAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGqtlxYoMtG2TgDF6MhusYZ4hO1hUkLckeOEuZs+U2QaG1hZn7HFyIx/IUcc8x6oJ5NhL1F5JtrvwIoqm5VnTHolSociYbjUTIXjW9hXbqgDHwR1vq3FfEwyQo2rwqUFT6HX3E1w3X371DWztBR6nymuEPv9ANvulV5jDDKl3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx+jkrkg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-784807fa38dso54986597b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761579904; x=1762184704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBQiLZSwF/LNIt8C2mTIJJ7RPYKplhz+h76J6R2gIAY=;
        b=fx+jkrkgeH9QSQjTxN9T8lY8s1AyubSw5U6+FW9C5DI02357iT2bwN85Nx0m7ErYxB
         woBbapX4kDWldVuyI794AJtr5oLwbSxkxiRtLMZ3zk2WeTYJIwpsTgJ8so5h5/rLW3nf
         G9dW8W/DymEzYPrTjRQJbnp57EkLeTyZMe5m/w82XAbbwQX7I35LSAXArgGeqOYkXMLy
         5aJ194iyRkKx4benygsi/L4sJvpSGSwqLtLLjj4rOma43mgaA471nMI1hjrEySCGuAPT
         zc1rHcxl2zfD1OIGdc4iitzFsP9o6aTXI+e6SdSIPjDhABTsM0mzyq4lvSLviKR9MZxG
         BsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579904; x=1762184704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBQiLZSwF/LNIt8C2mTIJJ7RPYKplhz+h76J6R2gIAY=;
        b=B+FPENH4sWU33zJx7rfqDl3o/euc44waHz8pWC88QoxuJyd+G5KEym6yYgglv5Bz0U
         FPJwl5Qo6SCU1tUrLEf2Snhi6RoZeGrH3dk/a1m3OBB3JXTwfVhlixUh+ewugUpPaIVY
         2RM6z+4tMxZpyGkpxz+cgdUMICS78a9S5oj80ppwVEWfgY8lYMVt1qQMDTOaaFA3qKnK
         jSV8uHe3Dg+/bsiHjgd1iHihMjHC/YDzyipih+Qf6ABYfICA/+5Na86rHm9AOi28JBfW
         Q/umPnLWCCy6NDLX9I51SjCdQlHXAQIEQqkVL0f70BoPcw0jebQ31EmwFEJR37upOFZT
         5o0g==
X-Forwarded-Encrypted: i=1; AJvYcCWQLkttlQRrX+dxJ8eauBI6sOfZNlaXfBHyQ/XGX2+yDYrf74yD5PpwokmxmhGBV7J+YdXux8YUt+lgR90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1BgTFaRNepGA9jZk5Sa2Kqn7t/g4mLG7/Dmf4FHoycWLKd4v
	8JYAjn+c8iIuXfFLUNnhqXfk0gZumkcyG9Pv1pL1Z/zSzKFxwDaj9VRamHSjDCkK9WHjIHI8VxV
	c87Z0lUc1qXzm5BmpSydLPimaCr7wo38=
X-Gm-Gg: ASbGncskQnJUzxhjjHmUhpgPxwiguOjEY93TzQiqIFk3FzUN7Yd2VYKxBWbQNYevwYB
	29tGrT2XXXT0vSJ3Ojlz5ny0ujzqEYUcjW+LvMfbypujmDfgEZEN8S6M9ur4lDN/aKC9pETSwm8
	gPTvQvfNhwRBXPCm4q08IQgeDm8DbwJ0bu5PwW9UlPK3NVaI3FaAHgsppGNnenIDUX84+x/ACtD
	edSQCqf8tJ3fQQbA0fSrgYYreUHQJ9mQx+1DoABiG7ujouHoSPVy/oMHd4K2jJuqstIS0M=
X-Google-Smtp-Source: AGHT+IExotPP9DeycZFzjGUJtTiClWmPd9kW9XEQYVHSF3lBLy99xgpcnLYzoQeFuBkOlvR/aO1x4UpiEz1jnJW67ac=
X-Received: by 2002:a05:690c:4d06:b0:76c:1926:8029 with SMTP id
 00721157ae682-78617f70da2mr2804767b3.54.1761579903991; Mon, 27 Oct 2025
 08:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-4-leon.hwang@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Oct 2025 08:44:53 -0700
X-Gm-Features: AWmQ_blhWwrOs7XJgSMOEnYRZPoMEn0YxuvdEaBupfg1qMVmRp8bsrdLudOgbSQ
Message-ID: <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When updating local storage maps with BPF_F_LOCK on the fast path, the
> special fields were not freed after being replaced. This could cause
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Similarly, on the other path, the old sdata's special fields were never
> freed regardless of whether BPF_F_LOCK was used, causing the same issue.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value_locked()' to properly release the old fields.
>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/bpf_local_storage.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index b931fbceb54da..8e3aea4e07c50 100644
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

[ ... ]

>                         return old_sdata;
>                 }
>         }
> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>                                       false);
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);

The one above and this make sense. Thanks for fixing it.

>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }
> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>
>         /* Third, remove old selem, SELEM(old_sdata) */
>         if (old_sdata) {
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);

Is this really needed? bpf_selem_free_list() later should free special
fields in this selem.


>                 bpf_selem_unlink_map(SELEM(old_sdata));
>                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_=
sdata),
>                                                 true, &old_selem_free_lis=
t);
> --
> 2.51.0
>
>

