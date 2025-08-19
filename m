Return-Path: <linux-kernel+bounces-774843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D8B2B849
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695F5188E18E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7C30F7E3;
	Tue, 19 Aug 2025 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKlvMXpq"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C7252906
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576578; cv=none; b=q8gISPWOLY8lV1Ck6f7wKbO12dpSMhUUVSpKNs6ibf8iQ4+Agb2nWHGJ4Hfn9PH+RPQEC872gLXpIFu/aF6OEOA//5pc9ozlm6onhIn5P8v9wxXkxMxdVdmEOjYqTaYNiV+9rG7KupRJB8F90TsxXt7/djaXiVEuJoG1Jf80BjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576578; c=relaxed/simple;
	bh=7dor42KySMcpOZlyvUFGNcxynjMFKXZK2A67QrP+tO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R85GZFizaqdpKwv4WQCKCzuqzaxZYqcgw38Ydlwxg4PLilpzjdcP+A0MvMbtZuHQwSkfHDwGJhNnAI0NSpEseokOfHXtmVvpqShrrfc5W9mMjA8qoGg0oBTYtZ+rUwxu/3p9egPD9A5bbrcZTjzhF2lYQoKk1LhVYj7/7DdiXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKlvMXpq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0bf08551cso170261cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755576576; x=1756181376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztcBg5RDRX7GPPZYTkfZrwxVUlSNU2Y6uUSU4mWhmOo=;
        b=MKlvMXpqj+ejlL9SdHwlB5wo/PinLCTwfi7HpFiXcfpby5KhhknWBErXbeCs6jeqy0
         JZyaTs5b0zjBEvMaL+8DFgrJfoSQNdskRyawtIGY5qEnjMhrfR8Fh/ZbYvB4jkvnu68F
         8J8XsbLtHOsJta5urTX/5EiAGSd8QYr/Oa9zTNbY/18KE/OWgSKJwmO7Df15+wjkxbgN
         uqFLJxT/CRUscfyoIvCeZFMeQwXMHgwvlSP0PIhMm2y3PEW90zWiJL2Y5GJ+i99zU/Jt
         UE1o25450IBAoyZBEbMH3OlUEC1aR4lWD92dhUVmrkAywKwqzEhO3LTtfdcgx4iiyk6f
         K6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755576576; x=1756181376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztcBg5RDRX7GPPZYTkfZrwxVUlSNU2Y6uUSU4mWhmOo=;
        b=sHXgbinBO1zE8yuEapWX/sgQ2kmihe6TMR5xsBLQhrgnVcczwnA8/QAUp85k6Cuz/h
         yTHn8Lo2SfjqytsoYEDlq5YnGQrYxbU8Cqbiso/lDaZKyYwGd42yvI+PSCJD3EGObTke
         4i+R/lTKZhmFDVOMX3W2BRmKWAb1Xeyo7iHuUT2KznDI06hDYybt9tcalMPEGNZTTein
         rgPBpg9wNpoXqR04fe7mIZWhNCJ6pWAvjE6gqOmL7hH8KXye0kHbif1JIHSW3msN7zrl
         mSpOvoKJOFAHkYBgJzEIs6HH2VGrXxdPzFirdIl0TiGpOUZ1DJI4MKj0+fbC6BkMltNg
         ZKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpljQTiH06ZdsoqGzsXnkZZDWk5Exb0H+JTe2SescDzt3ssCOm6+5iML/Yt7BryVK5WILRvFKRG+Wu3hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTeX+33El/5Geiv2yoC+ngCiWLELtpiaNSk/F49zfo2Xm8xTw
	znITVu/zakugdEgfigwGbEHYEmgR1r5P3J/+cozjz19rx9/ru3XGIPk1WtItSL4/QEs/WdVZniQ
	58U0kwGcX50sogvwO9ehgoIPmCkOv7dQf0wiAnIVVeQBZMxXdaIXEVQeK
X-Gm-Gg: ASbGnctlkB3Z0QeFtckQfkZkPM1lytpE4gNrk2gle8iJFKIXNDBDdyU3s2DuxZMmSBi
	gzfft+a7u1PhC9XEkrV5RioNm25Jh7I+xGJnuVKCvRb2gxLgOeMB1qJA8PVUKk99hy3AoEhlTtj
	3fiN+AtSGMCPPDzA3l7SDWA9C+usMQESd3oUgIWcKomBqy4yX/WGS1yKHF3K+YGPEBNo7fSdlnX
	F4t12WbFOxMisQh1cRDgK4=
X-Google-Smtp-Source: AGHT+IHaJMVY8MOM/c5j+pR0p6Xkf0AbhVTTukYaslfi1GxFjKp1eTRircaiD6qar1Gbvqm5iBV2XhAexicJk+859VM=
X-Received: by 2002:ac8:5ac2:0:b0:4b0:8318:a95 with SMTP id
 d75a77b69052e-4b28644b11dmr2365431cf.8.1755576575653; Mon, 18 Aug 2025
 21:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-7-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-7-roman.gushchin@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Aug 2025 21:09:24 -0700
X-Gm-Features: Ac12FXzLbPuoxnMNoJu89p8-KDZbGkP1Vhh2K8HYHSwD3YgxmIxXxlNBFUSNhXg
Message-ID: <CAJuCfpHTtLQR0NpsbFytaOdEc0KqNv6PxVpxNetYD6Ce4sY9UQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] mm: introduce bpf_out_of_memory() bpf kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
>
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
>
> If the wait_on_oom_lock argument is not set, only one OOM can be
> declared and handled in the system at once, so if the function is
> called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>
> The function is declared as sleepable. It guarantees that it won't
> be called from an atomic context. It's required by the OOM handling
> code, which is not guaranteed to work in a non-blocking context.
>
> Handling of a memcg OOM almost always requires taking of the
> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
> also guarantees that it can't be called with acquired css_set_lock,
> so the kernel can't deadlock on it.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/oom_kill.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25fc5e744e27..df409f0fac45 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1324,10 +1324,55 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_c=
ontrol *oc,
>         return 0;
>  }
>
> +/**
> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
> + * @memcg__nullable: memcg or NULL for system-wide OOMs
> + * @order: order of page which wasn't allocated
> + * @wait_on_oom_lock: if true, block on oom_lock
> + * @constraint_text__nullable: custom constraint description for the OOM=
 report
> + *
> + * Declares the Out Of Memory state and invokes the OOM killer.
> + *
> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oo=
m_lock
> + * is true, the function will wait on it. Otherwise it bails out with -E=
BUSY
> + * if oom_lock is contended.
> + *
> + * Generally it's advised to pass wait_on_oom_lock=3Dtrue for global OOM=
s
> + * and wait_on_oom_lock=3Dfalse for memcg-scoped OOMs.

From the changelog description I was under impression that it's vice
versa, for global OOMs you would not block (wait_on_oom_lock=3Dfalse),
for memcg ones you would (wait_on_oom_lock=3Dtrue).

> + *
> + * Returns 1 if the forward progress was achieved and some memory was fr=
eed.
> + * Returns a negative value if an error has been occurred.

s/has been occurred/has occurred or occured


> + */
> +__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
> +                                 int order, bool wait_on_oom_lock)
> +{
> +       struct oom_control oc =3D {
> +               .memcg =3D memcg__nullable,
> +               .order =3D order,
> +       };
> +       int ret;
> +
> +       if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
> +               return -EINVAL;
> +
> +       if (wait_on_oom_lock) {
> +               ret =3D mutex_lock_killable(&oom_lock);
> +               if (ret)
> +                       return ret;
> +       } else if (!mutex_trylock(&oom_lock))
> +               return -EBUSY;
> +
> +       ret =3D out_of_memory(&oc);
> +
> +       mutex_unlock(&oom_lock);
> +       return ret;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_oom_kfuncs)
>  BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_oom_kfuncs)
>
>  static const struct btf_kfunc_id_set bpf_oom_kfunc_set =3D {
> --
> 2.50.1
>

