Return-Path: <linux-kernel+bounces-817879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE06B58801
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6131890545
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C682C0F87;
	Mon, 15 Sep 2025 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yxXgFxX"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBC2853F9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977558; cv=none; b=I3ZyqrivnXeGiODL2I+qV9F/LUjtAPeybsx4uXel78KMWZ3u2ikbppqjFzZmOfynC9PVyGgHOtg1Wiwjs94qRZK1xPgaFaaIrcs6NmK5G8ghuSllirZHyI+lJLnn6ZhBBVhIFGQmozoOVxRdXXetqJHr44SbRUWu4N/STqNfkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977558; c=relaxed/simple;
	bh=WpOaKYG+RBbPOhviqBKqgd2Hj8Y98yc033XtY/jK/h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA2NTWyM+G2vHNdeLbdqg8crgG65Dcu57YOUm5DkX7+F3yu0uDGjW6MD0xlSYWLXGaDahj/4SB5b7ifTexgBNdrwE7cOdQ8P5qa2Pv5sCCqhXScPGdXjDSUNiDFPWy+XJH6nYBzqpSgyRwfs+c0wDrV48oxjsy2V9nCmDdoGqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yxXgFxX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b4bcb9638aso103061cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977555; x=1758582355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qJ1ywJEbaE9nq0ko+s0hyX1ZObpOzS9ljbjORUd/zM=;
        b=2yxXgFxXb6f2+G17imIx9yYK7EO2rLtCfhdfHZ8J54er63cPdrMWlMIC3p2n6/Bf65
         ZdqVLD1gyf3dK7TflDf+tqxmlZv0tMnTFEFXevY/73VltyIw4ev55mg4ciSoMshPAhYY
         66I831QMqQzLmOiEBNiFyB/0B5UZhuc4j6IJ7mTAoUKVYikssMPdo6XlupbzVcFEA2MY
         ZXGpm8PidOM472JeoNX6tcJco+vELkB1kqLbOfCmU5n1MzfGLuTttsUzibYm1dY9SEgP
         u2WzwPem3HEe7q34A3njuG2SA+GY0Rve6FN3ewbQdKLLVXO4EpqFAKVcgged8n/Hc+vA
         Pxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977555; x=1758582355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qJ1ywJEbaE9nq0ko+s0hyX1ZObpOzS9ljbjORUd/zM=;
        b=XdbNY1eoK69PVewLd3n7T+jda0UerAqi8YfUjCFL0xqhAgdIlkc7OgzubIjwCiutDv
         1k06JNlfl5WjeItAI9UcauVhOP9mztq7vq5HwLwKS1Z6dRNBZAM8WD9KJC8X8UYtyDdx
         wsPWRNSuPEcRNAmHiNBrY92ZK8AoANa4DDQ+XnBAZYAmwBwCKhaeWvXaExC2grzOp4GA
         iMsQCcnrheJBQZ89LQ1Uvzauy7k8XvwKqyJ9wd9miLSTUyQRsrm9d6q5A5zdNm6RWthR
         tEpvauS5Fqnu9k6lxG2c9jgET7ET05tIQVhH4WeWGcoL4HSRfwXrJnCuabLyqPv1jvnq
         zceg==
X-Forwarded-Encrypted: i=1; AJvYcCX86kQQjXcs8Qzr8UjlP3A09qkWAzPklR3L+0/JibAYhgvjfWjoVVws/HQzVc2Er/MvdNO70vMmpYJqR1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZI6ZCmgZDtW3qgmNkD+a5ONvfInOiXi3iV08KtzqSRzo+7Ln
	U5PrT/kCJOv4yxGaVWBebPI5Nfio+VWn4sSTzg6LjmtRGmqp/Xhk2EMUfT2MxKYBw85XF8IQM9/
	VvsdlXRyNgesb84e2TVVe1L/BAjH+6TP4CJO2Nz2W
X-Gm-Gg: ASbGncuxQFA5YiOZ5e4fZq6U1EFs5DN/hkPSC8wTQEjuraPhK+7qNp2JOuH483erN9H
	wmZH18maPMVnhRc2rA4GZPdeLVF2g4XYi0Pj0e/l8vomyVj++soSw1Q3rPAun0HS7D3RR6aqn7i
	Y1NKYs+sTr91IpMrBgMdmOV16Ainx+7BSj9AOz2gA3wQhfvBOQmAUhxwAVsApTwIeOVK5cpu91c
	6oJBMblJql80iu8RFWGfyQDisE0gHi+qkSiw85vzISb
X-Google-Smtp-Source: AGHT+IGSDw4q7zvyhHz8jYY09WOelxKBRgvxIUR/b2xOqj3hs370yTlQ5WcBbmIrTt+w0VFq+mNlMcQ7e+FO0tWkJok=
X-Received: by 2002:a05:622a:1a1a:b0:4b7:9e3a:3804 with SMTP id
 d75a77b69052e-4b7b1ceb2ebmr2609391cf.16.1757977554914; Mon, 15 Sep 2025
 16:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com>
In-Reply-To: <20250915230224.4115531-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 16:05:43 -0700
X-Gm-Features: AS18NWD6T-GfGYPt0XH871IgorUw9EfNUMGDUoO7LTR6UK84OFYT0bzZ_WbKkwg
Message-ID: <CAJuCfpG+Vp8w0ZuEbdxKEcG2YurYCij=7BrekDPtJwW9rFegjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> While rare, memory allocation profiling can contain inaccurate counters
> if slab object extension vector allocation fails. That allocation might
> succeed later but prior to that, slab allocations that would have used
> that object extension vector will not be accounted for. To indicate
> incorrect counters, "accurate:no" marker is appended to the call site
> line in the /proc/allocinfo output.
> Bump up /proc/allocinfo version to reflect the change in the file format
> and update documentation.
>
> Example output with invalid counters:
> allocinfo - version: 2.0
>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_da=
ta_nodes
>            0        0 arch/x86/kernel/alternative.c:2090 func:alternative=
s_smp_module_add
>            0        0 arch/x86/kernel/alternative.c:127 func:__its_alloc =
accurate:no
>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_se=
t
>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_real=
loc
>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enab=
le_hybrid_capacity_scale
>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:in=
it_amd_l3_attrs
>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device=
_create accurate:no
>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_=
pool_create
>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thresho=
ld_create_device
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
> Changes since v1[1]:
> - Changed the marker from asterisk to accurate:no pair, per Andrew Morton
> - Documented /proc/allocinfo v2 format
> - Update the changelog
> - Added Acked-by from v2 since the functionality is the same,
> per Shakeel Butt, Usama Arif and Johannes Weiner


Sorry, forgot the --base=3Dauto when formatting the patch. It's based on mm=
-new.

>
> [1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@google.co=
m/
>
>  Documentation/filesystems/proc.rst |  4 ++++
>  include/linux/alloc_tag.h          | 12 ++++++++++++
>  include/linux/codetag.h            |  5 ++++-
>  lib/alloc_tag.c                    |  4 +++-
>  mm/slub.c                          |  2 ++
>  5 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 915a3e44bc12..1776a06571c2 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable modu=
le) and the function calling
>  the allocation. The number of bytes allocated and number of calls at eac=
h
>  location are reported. The first line indicates the version of the file,=
 the
>  second line is the header listing fields in the file.
> +If file version is 2.0 or higher then each line may contain additional
> +<key>:<value> pairs representing extra information about the call site.
> +For example if the counters are not accurate, the line will be appended =
with
> +"accurate:no" pair.
>
>  Example output.
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 9ef2633e2c08..d40ac39bfbe8 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_ref *=
ref, size_t bytes)
>         ref->ct =3D NULL;
>  }
>
> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> +{
> +       tag->ct.flags |=3D CODETAG_FLAG_INACCURATE;
> +}
> +
> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> +{
> +       return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> +}
> +
>  #define alloc_tag_record(p)    ((p) =3D current->alloc_tag)
>
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
> @@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(void) =
{ return false; }
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_ta=
g *tag,
>                                  size_t bytes) {}
>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {=
}
> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { retu=
rn false; }
>  #define alloc_tag_record(p)    do {} while (0)
>
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index 457ed8fd3214..8ea2a5f7c98a 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -16,13 +16,16 @@ struct module;
>  #define CODETAG_SECTION_START_PREFIX   "__start_"
>  #define CODETAG_SECTION_STOP_PREFIX    "__stop_"
>
> +/* codetag flags */
> +#define CODETAG_FLAG_INACCURATE        (1 << 0)
> +
>  /*
>   * An instance of this structure is created in a special ELF section at =
every
>   * code location being tagged.  At runtime, the special section is treat=
ed as
>   * an array of these.
>   */
>  struct codetag {
> -       unsigned int flags; /* used in later patches */
> +       unsigned int flags;
>         unsigned int lineno;
>         const char *modname;
>         const char *function;
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 79891528e7b6..12ff80bbbd22 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void *ar=
g)
>  static void print_allocinfo_header(struct seq_buf *buf)
>  {
>         /* Output format version, so we can change it. */
> -       seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> +       seq_buf_printf(buf, "allocinfo - version: 2.0\n");
>         seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
>  }
>
> @@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, stru=
ct codetag *ct)
>
>         seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>         codetag_to_text(out, ct);
> +       if (unlikely(alloc_tag_is_inaccurate(tag)))
> +               seq_buf_printf(out, " accurate:no");
>         seq_buf_putc(out, ' ');
>         seq_buf_putc(out, '\n');
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index af343ca570b5..9c04f29ee8de 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *=
s, void *object, gfp_t flags)
>          */
>         if (likely(obj_exts))
>                 alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size=
);
> +       else
> +               alloc_tag_set_inaccurate(current->alloc_tag);
>  }
>
>  static inline void
> --
> 2.51.0.384.g4c02a37b29-goog
>

