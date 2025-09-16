Return-Path: <linux-kernel+bounces-819656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFFB5A432
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D715B46058E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA12F9D9E;
	Tue, 16 Sep 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="laC4ObbZ"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA82D9494
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059222; cv=none; b=WMJWdo5Y5zot4HXXUSQd1r7LqY0KC5gnBa5ruBABkYvv/qNsrqUm/awzbqTvqKLR9ZsyMKPPOXQ27Mk6GX4nA7YF+gZCMqxqKwlxp1/7pBse5WIzEcR+CTmS2T8Rfu1PB2YNRHyvBNibk2ZCpnNVYBso0BcB1fljdamCN4oDXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059222; c=relaxed/simple;
	bh=FHTxmvYwAyxzn1/GDbWQAY7lYeEMR32ENzK3j+HLyfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZcCPG4qRUi82pXvo4wbj6bHtAZmEKy4i23U96h+6UEDUFOoiHa7UQmxmF+Nhf5kRaMm4Xcf1P1esoKn3WdHuZcAnveTA3sV4K1s0r7zp3WVPQTm9FfsYxzaHTikBdcgeuAfDlPz1BRokOZlSnOA5OXOTvKJoNF9vMPHYDOde04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=laC4ObbZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b4bcb9638aso194761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059220; x=1758664020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cORpR7NP/vc984PKQDAJOieXaROC8axwk2H5vOdW60=;
        b=laC4ObbZvS5Lz5krtwqZ8SKJk1+EkFdXndVSvJ/PFpOYpgBsY69DKBGOd4oeXJIveY
         PnGorHhT1bd8RwHzepMrtrjfiT3S/x9/6IZ7QEprRqTV2yQicDgBGXGlESRlavRdhM25
         puY76EXxliWUqB73TsO5eKGwpqyimpzJxbbuQJ6W7GBjLAbirdg1Y62/f7Tgamqs3y0B
         IM5uuRtSZBleAvlDeIUAm3JdOxDGYDwRd0EPBP+J3hP97AYmLAw1ftjfDXYdzqayKPXq
         h07qy90ka9awReMtkox1vfCbCuWCBrmCfIWXWARUXFIJ9jDfab6qCtakTmag9XAnpX7p
         zk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059220; x=1758664020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cORpR7NP/vc984PKQDAJOieXaROC8axwk2H5vOdW60=;
        b=w8e5Cs0ldkVCPSYN4NogrUVux0h8wwA+K3jJhbNju8FjMb9vMn5jPj0uoVgaCi0IK8
         8r3kBiGxdtNl5v5ExeEd3YEAX/+XxruQ2h5RQ2PPuwHmsIl9iPA7y4vVyNJATUgJnJRx
         GpFRvSK4mEKlPDCvAfY6cDg7pC5n9LyKM9MksOfdJk0zZXBsdROikBYo1lDIKGZthRhR
         0q78oMRLrhGUFMiK8Wm7/eYjV1cgDFrLR8j63o3M95mTjLrUNAlXnMGZ4dSpLUxJN7jq
         oih3JFMsd+PFItC8YqEUaP5sZtA3KmYy2DqiMzluug/vie7ToZXHLSZhi/WdLSVU9Qc7
         5l2g==
X-Forwarded-Encrypted: i=1; AJvYcCXewm9U/JdzR/WnoefBdkt65zkveY6qtNNuGx8eHrThMEOmvXe5M30eWFzdmbOCAkj0FnH7iNxqexJHQrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZBmUwmFvOjp3tbz4xo4riY15DhMVU+5HB0aPuobFEb+cQ1W6
	MJL0bV+h4smizYGJLgTeRQN74UE2UGGwQ6h+BemupeBQBJJK/HbwRYq2GJEIzPh9B+4S5RawRGs
	RXSJUHyQtoAY7tlbGIhTX0vtbT1M9NNKQm6odX0Zy
X-Gm-Gg: ASbGncssq0rJ2XvHKT9QC+iaW7CGizAGOoirBghjCx0QDrchaImVpRE91RvZPQ4jb26
	DXEFbreDKBlIJ+BHRW4SLpVdmN1MYpSikLNt9ZlmWzW7TUgzR1C0FcSgFQtnPfHtMVKID/XOmqk
	POC/j+QRgAdPgpwa3OAMJ0Ho3wwEc1z7wdn1zYOBhTpOtQEMw6v+TeI9DF4QLz4ljw0kPPNAalI
	ZW1HLMouZSpTPcsvxRIEmEHVowsxYu9dVzYTjyaol0ilJkYLKddjkI=
X-Google-Smtp-Source: AGHT+IG8pJr4Ku/EyvmNj7ByPDO1y93cWqsNmE/h4IbXm3vcafdNzffACFkfdJfTBgdN/uG7iO/k1NvDgpQ8Ad+czjk=
X-Received: by 2002:a05:622a:199a:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4b9dd893ec8mr2081351cf.8.1758059219140; Tue, 16 Sep 2025
 14:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <2d8eb571-6d76-4a9e-8d08-0da251a73f33@suse.cz>
 <CAJuCfpHXAhGZb1aOPyHOPiTWSwQJi570THqJQcjrVPf=4Dt3xQ@mail.gmail.com> <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com>
In-Reply-To: <a8519bca-ae16-4642-84a1-4038b12e8bb0@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 14:46:47 -0700
X-Gm-Features: AS18NWDiLEtpy2aZT2Vj6GfSOG8yRsirQN9jUBpKyJCyPlYfizq21u9MuuiIH3E
Message-ID: <CAJuCfpFJabb02OK8Rj08d7WU_7AM674i=vsZxzfw7i7h-PGftQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:11=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 16/09/2025 16:51, Suren Baghdasaryan wrote:
> > On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 9/16/25 01:02, Suren Baghdasaryan wrote:
> >>> While rare, memory allocation profiling can contain inaccurate counte=
rs
> >>> if slab object extension vector allocation fails. That allocation mig=
ht
> >>> succeed later but prior to that, slab allocations that would have use=
d
> >>> that object extension vector will not be accounted for. To indicate
> >>> incorrect counters, "accurate:no" marker is appended to the call site
> >>> line in the /proc/allocinfo output.
> >>> Bump up /proc/allocinfo version to reflect the change in the file for=
mat
> >>> and update documentation.
> >>>
> >>> Example output with invalid counters:
> >>> allocinfo - version: 2.0
> >>>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setu=
p_data_nodes
> >>>            0        0 arch/x86/kernel/alternative.c:2090 func:alterna=
tives_smp_module_add
> >>>            0        0 arch/x86/kernel/alternative.c:127 func:__its_al=
loc accurate:no
> >>>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstatereg=
s_set
> >>>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_=
realloc
> >>>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_=
enable_hybrid_capacity_scale
> >>>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 fun=
c:init_amd_l3_attrs
> >>>        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_de=
vice_create accurate:no
> >>>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_=
gen_pool_create
> >>>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thr=
eshold_create_device
> >>>
> >>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>> Acked-by: Usama Arif <usamaarif642@gmail.com>
> >>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >>
> >> With this format you could instead print the accumulated size of alloc=
ations
> >> that could not allocate their objext (for the given tag). It should be=
 then
> >> an upper bound of the actual error, because obviously we cannot recogn=
ize
> >> moments where these allocations are freed - so we don't know for which=
 tag
> >> to decrement. Maybe it could be more useful output than the yes/no
> >> information, although of course require more storage in struct codetag=
, so I
> >> don't know if it's worth it.
> >
> > Yeah, I'm reluctant to add more fields to the codetag and increase the
> > overhead until we have a usecases. If that happens and with the new
> > format we can add something like error_size:<value> to indicate the
> > amount of the error.
> >
> >>
> >> Maybe a global counter of sum size for all these missed objexts could =
be
> >> also maintained, and that wouldn't be an upper bound but an actual cur=
rent
> >> error, that is if we can precisely determine that when freeing an obje=
ct, we
> >> don't have a tag to decrement because objext allocation had failed on =
it and
> >> thus that allocation had incremented this global error counter and it'=
s
> >> correct to decrement it.
> >
> > That's a good idea and should be doable without too much overhead. Than=
ks!
> > For the UAPI... I think for this case IOCTL would work and the use
> > scenario would be that the user sees the "accurate:no" mark and issues
> > ioctl command to retrieve this global counter value.
> > Usama, since you initiated this feature request, do you think such a
> > counter would be useful?
> >
>
>
> hmm, I really dont like suggesting changing /proc/allocinfo as it will br=
eak parsers,
> but it might be better to put it there?
> If the value is in the file, I imagine people will be more prone to looki=
ng at it?
> I am not completely sure if everyone will do an ioctl to try and find thi=
s out?
> Especially if you just have infra that is just automatically collecting i=
nfo from
> this file.

The current file reports per-codetag data and not global counters. We
could report it somewhere in the header but the first question to
answer is: would this be really useful (not in a way of  "nice to
have" but for a concrete usecase)? If not then I would suggest keeping
things simple until there is a need for it.

>
> >>
> >>> ---
> >>> Changes since v1[1]:
> >>> - Changed the marker from asterisk to accurate:no pair, per Andrew Mo=
rton
> >>> - Documented /proc/allocinfo v2 format
> >>> - Update the changelog
> >>> - Added Acked-by from v2 since the functionality is the same,
> >>> per Shakeel Butt, Usama Arif and Johannes Weiner
> >>>
> >>> [1] https://lore.kernel.org/all/20250909234942.1104356-1-surenb@googl=
e.com/
> >>>
> >>>  Documentation/filesystems/proc.rst |  4 ++++
> >>>  include/linux/alloc_tag.h          | 12 ++++++++++++
> >>>  include/linux/codetag.h            |  5 ++++-
> >>>  lib/alloc_tag.c                    |  4 +++-
> >>>  mm/slub.c                          |  2 ++
> >>>  5 files changed, 25 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/files=
ystems/proc.rst
> >>> index 915a3e44bc12..1776a06571c2 100644
> >>> --- a/Documentation/filesystems/proc.rst
> >>> +++ b/Documentation/filesystems/proc.rst
> >>> @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable =
module) and the function calling
> >>>  the allocation. The number of bytes allocated and number of calls at=
 each
> >>>  location are reported. The first line indicates the version of the f=
ile, the
> >>>  second line is the header listing fields in the file.
> >>> +If file version is 2.0 or higher then each line may contain addition=
al
> >>> +<key>:<value> pairs representing extra information about the call si=
te.
> >>> +For example if the counters are not accurate, the line will be appen=
ded with
> >>> +"accurate:no" pair.
> >>>
> >>>  Example output.
> >>>
> >>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> >>> index 9ef2633e2c08..d40ac39bfbe8 100644
> >>> --- a/include/linux/alloc_tag.h
> >>> +++ b/include/linux/alloc_tag.h
> >>> @@ -221,6 +221,16 @@ static inline void alloc_tag_sub(union codetag_r=
ef *ref, size_t bytes)
> >>>       ref->ct =3D NULL;
> >>>  }
> >>>
> >>> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> >>> +{
> >>> +     tag->ct.flags |=3D CODETAG_FLAG_INACCURATE;
> >>> +}
> >>> +
> >>> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> >>> +{
> >>> +     return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> >>> +}
> >>> +
> >>>  #define alloc_tag_record(p)  ((p) =3D current->alloc_tag)
> >>>
> >>>  #else /* CONFIG_MEM_ALLOC_PROFILING */
> >>> @@ -230,6 +240,8 @@ static inline bool mem_alloc_profiling_enabled(vo=
id) { return false; }
> >>>  static inline void alloc_tag_add(union codetag_ref *ref, struct allo=
c_tag *tag,
> >>>                                size_t bytes) {}
> >>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t byte=
s) {}
> >>> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {=
}
> >>> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { =
return false; }
> >>>  #define alloc_tag_record(p)  do {} while (0)
> >>>
> >>>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> >>> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> >>> index 457ed8fd3214..8ea2a5f7c98a 100644
> >>> --- a/include/linux/codetag.h
> >>> +++ b/include/linux/codetag.h
> >>> @@ -16,13 +16,16 @@ struct module;
> >>>  #define CODETAG_SECTION_START_PREFIX "__start_"
> >>>  #define CODETAG_SECTION_STOP_PREFIX  "__stop_"
> >>>
> >>> +/* codetag flags */
> >>> +#define CODETAG_FLAG_INACCURATE      (1 << 0)
> >>> +
> >>>  /*
> >>>   * An instance of this structure is created in a special ELF section=
 at every
> >>>   * code location being tagged.  At runtime, the special section is t=
reated as
> >>>   * an array of these.
> >>>   */
> >>>  struct codetag {
> >>> -     unsigned int flags; /* used in later patches */
> >>> +     unsigned int flags;
> >>>       unsigned int lineno;
> >>>       const char *modname;
> >>>       const char *function;
> >>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >>> index 79891528e7b6..12ff80bbbd22 100644
> >>> --- a/lib/alloc_tag.c
> >>> +++ b/lib/alloc_tag.c
> >>> @@ -80,7 +80,7 @@ static void allocinfo_stop(struct seq_file *m, void=
 *arg)
> >>>  static void print_allocinfo_header(struct seq_buf *buf)
> >>>  {
> >>>       /* Output format version, so we can change it. */
> >>> -     seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> >>> +     seq_buf_printf(buf, "allocinfo - version: 2.0\n");
> >>>       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
> >>>  }
> >>>
> >>> @@ -92,6 +92,8 @@ static void alloc_tag_to_text(struct seq_buf *out, =
struct codetag *ct)
> >>>
> >>>       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> >>>       codetag_to_text(out, ct);
> >>> +     if (unlikely(alloc_tag_is_inaccurate(tag)))
> >>> +             seq_buf_printf(out, " accurate:no");
> >>>       seq_buf_putc(out, ' ');
> >>>       seq_buf_putc(out, '\n');
> >>>  }
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index af343ca570b5..9c04f29ee8de 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -2143,6 +2143,8 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cac=
he *s, void *object, gfp_t flags)
> >>>        */
> >>>       if (likely(obj_exts))
> >>>               alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->si=
ze);
> >>> +     else
> >>> +             alloc_tag_set_inaccurate(current->alloc_tag);
> >>>  }
> >>>
> >>>  static inline void
> >>
>

