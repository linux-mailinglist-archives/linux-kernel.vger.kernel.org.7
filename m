Return-Path: <linux-kernel+bounces-780410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FCFB30188
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0EDA08659
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557C30E830;
	Thu, 21 Aug 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRI6L3qe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A192D63E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798978; cv=none; b=nSZUV5ciePGdjiFJ11KY3a0xNLB4kd90p/sQfpgosI4Z92IgJGpunRpuOV5Q6WRSpF9FYvrPFXryPB1KQjFYN3/FV6hPrbZ0wQoA2VjhMhNC0X0ICnvbx2yqYcPjtBCeQcMhr2+KFSHZciVMlAYyKy/tK9jEiUHHqqxONXWcqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798978; c=relaxed/simple;
	bh=JsiP0JPvwI4ToK2Oaapc2FkvrjDvUWk0U7cL0bqrohY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIL8P8nGIAieMN/cF71t1PRyzFYtt6ORSEcaGHKeEp0iXct7jYUYwfJ9p2/5hdnU6nqTawZVr8N3Oe3ob1USyaMLchIAt5fKnhCoU0wXeeGrKssFkTZEptxLaIwtCk6fUzJvI3lckdZfUcCSrBjRjGruRs7BFCUPMvu/qGZfG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRI6L3qe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso956a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755798974; x=1756403774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OaNKB4ZUL7yid73jmJTsnRphjsenr0Bd6ivArlhGHc=;
        b=VRI6L3qeVn7B+1BXIei1dAgDAQEnRAYKnwSqwlld/RvDCzTtAn3uIOb4kyWGrkzr0R
         L+qa8pGGXh64AzR3qgjBy0eWKQA6xwnC6zBe6KCb6wi0XpTmMn/FYMTA6NCB6rWPkck5
         03FiE7PbxjsSpIdiD+9DEmN4B1pS78iStU6toQ3s28zBQQOLsqPuINzrmolGmoYGAJQJ
         sm0R5N2kRyEytyhbqzhWQcWbalr6B/ib0G/mZghwQMDiM8HVyhAOBcTBH1bZOF9JGzet
         0BNkaclCVBfVwc0sd3hKonkh7bf7x3gIq58N/Jjcti1DRYf1uZk7Ao2pe3lTk7k9HU1D
         R/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798974; x=1756403774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OaNKB4ZUL7yid73jmJTsnRphjsenr0Bd6ivArlhGHc=;
        b=vZgbxBvNpUQ81FGvukgxFLmx0EePEPKAO+tXbyYV/PUZrnm0GP5yQoIae1rr0nvjDU
         kV5jqGi4/OVyMtwDpWoL4g9Lh2qP2s2gAA+lnWmkLNPEyJJyiFWnRjQDx5t3fCtDWFMG
         yoWeaTHrcccc2NYsUlvFpYNgCyLkwBBh7ND7MdnM4RPH2YuLKOIF5yCSZBNitI4/5sJs
         YqkKfY7H+yrrs9XNnv8gT55IpnScUeht0bXiyHPIShhuJ5MH5t6E3v/CFeHifS05X6gD
         S/CaP+W/0xmA1sUjZvlMfmf5IjuSb0dW+S8VrJSXkGjL5F+lmAqYrV3kQtAb0QHs3LB/
         WV2w==
X-Forwarded-Encrypted: i=1; AJvYcCWdmnknifeAHWicmjrkUMu6cRQUjRVV/lzBL+Rc8ZDPRPDU/nbKXfW50WLyTgUdiQsmNfbKagpZ4PuWtrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZM2yTP837ttJV/kwSU/YdFX9+Qe7e0KWLK+GOlRTbLBleecss
	zq/Ba+AYcATDf3E2A693QCowPlcS3Grgisw3tAZRxK1HVvwAKud7ejsbi1ApTEzqOjsM0zKbw1w
	kbqTlDdq4iYpIyjGOy/UEwrRlC8QFysbpVA8aAyQF
X-Gm-Gg: ASbGncuxKwXCg/OyOkBeV2PcfnyaNNiprVeEqbQOaTBMQHN4Tb6SNjO5j2iYNuMdChd
	4Dnmc8kmr4hwg1viioYNaip41MJAYzOMCWozPT8v4kOkA/hdn07dcyV5YWtNrsMSI7lMsP///+8
	uhnNCXJhwWbNRI/YhFYA53V7ZqjABlojYOPIkRwAvZfLOEOkf+s6kq/d2hZTYSW55m/OFt1rpzn
	gQxAh/tOuXA72YR5uI+Z+o9UEJclRz7drUvjgSgBL1/d4fr/i3BaME=
X-Google-Smtp-Source: AGHT+IFVRVvBfVGiJbFfaLa/SK3Cvgemy51aTnB6Yc4MQ127iC8/HJ5Is7jFT8FdwiTWxhYGMok8W/PgES6NTiKSXRQ=
X-Received: by 2002:aa7:c717:0:b0:618:8198:de66 with SMTP id
 4fb4d7f45d1cf-61c1a3a823dmr2524a12.2.1755798974364; Thu, 21 Aug 2025 10:56:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO6dR5=4zaecmYqQqOX4702wwGSTX=4+Ani_Q9+o+WUnQA@mail.gmail.com>
 <CA+EESO6iqowMAOnBPJjERqZym_qvd6kx8BDMQG8+3xQSrNFytw@mail.gmail.com>
 <CAGsJ_4xccre0rz5zgRTA=NbFzF4FLS-ZUohgLFnfTGY9Jdequg@mail.gmail.com> <3133F0B4-4684-4EC7-81FC-BC12A430E4C2@nvidia.com>
In-Reply-To: <3133F0B4-4684-4EC7-81FC-BC12A430E4C2@nvidia.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 21 Aug 2025 10:56:02 -0700
X-Gm-Features: Ac12FXw91HcIA-HfMpgbMbkQ0W-eNhyjVh_auRuyvKiToz0-CS0TI7_uW_klo84
Message-ID: <CA+EESO7_-64GU5v1FTMXbemQixPX+xo6SGm8r0txohZJLs97cA@mail.gmail.com>
Subject: Re: [RFC] Unconditionally lock folios when calling rmap_walk()
To: Zi Yan <ziy@nvidia.com>
Cc: Barry Song <21cnbao@gmail.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 (

On Thu, Aug 21, 2025 at 9:14=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 21 Aug 2025, at 8:01, Barry Song wrote:
>
> > On Thu, Aug 21, 2025 at 12:29=E2=80=AFPM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> >>
> >> Adding linux-mm mailing list. Mistakenly used the wrong email address.
> >>
> >> On Wed, Aug 20, 2025 at 9:23=E2=80=AFPM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> >>>
> >>> Hi all,
> >>>
> >>> Currently, some callers of rmap_walk() conditionally avoid try-lockin=
g
> >>> non-ksm anon folios. This necessitates serialization through anon_vma
> >>> write-lock when folio->mapping and/or folio->index (fields involved i=
n
> >>> rmap_walk()) are to be updated. This hurts scalability due to coarse
> >>> granularity of the lock. For instance, when multiple threads invoke
> >>> userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct page=
s from
> >>> the same src VMA, they all contend for the corresponding anon_vma=E2=
=80=99s
> >>> lock. Field traces for arm64 android devices reveal over 30ms of
> >>> uninterruptible sleep in the main UI thread, leading to janky user
> >>> interactions.
> >>>
> >>> Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> >>> folio_referenced() is the most critical (others are
> >>> page_idle_clear_pte_refs(), damon_folio_young(), and
> >>> damon_folio_mkold()). The relevant code in folio_referenced() is:
> >>>
> >>> if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)))=
 {
> >>>         we_locked =3D folio_trylock(folio);
> >>>         if (!we_locked)
> >>>                 return 1;
> >>> }
>
> This seems to be legacy code from commit 5ad6468801d2 ("ksm: let shared p=
ages be
> swappable"). From the commit log, the lock is used to protect KSM stable
> tree from concurrent modification.
>
It seems like the conditional locking of file page/folio was added in
a 2004 commit  edcc56dc6a7c758c ("maplock: kill page_map_lock"). Later
in the commit you mentioned locking was also added for KSM, and now
only non-KSM anon folios are left :-)

> >>>
> >>> It=E2=80=99s unclear why locking anon_vma (when updating folio->mappi=
ng) is
> >>> beneficial over locking the folio here. It=E2=80=99s in the reclaim p=
ath, so
> >>> should not be a critical path that necessitates some special
> >>> treatment, unless I=E2=80=99m missing something.
>
> The decision was made before the first git commit 1da177e4c3f4 based on
> git history. Maybe it is time to revisit it and improve it.
>
>
> >>>
> >>> Therefore, I propose simplifying the locking mechanism by
> >>> unconditionally try-locking the folio in such cases. This helps avoid
> >>> locking anon_vma when updating folio->mapping, which, for instance,
> >>> will help eliminate the uninterruptible sleep observed in the field
> >>> traces mentioned earlier. Furthermore, it enables us to simplify the
> >>> code in folio_lock_anon_vma_read() by removing the re-check to ensure
> >>> that the field hasn=E2=80=99t changed under us.
> >
> > Thanks, I=E2=80=99m personally quite interested in this topic and will =
take a
> > closer look as well. Beyond this one userfaultfd move, we=E2=80=99ve ob=
served
> > severe anon_vma lock contention between fork, unmap (process exit), and
> > memory reclamation. This has caused noticeable UI stutters, especially
> > when many VMAs share the same anon_vma root.
> >
> > Thanks
> > Barry
>
>
> --
> Best Regards,
> Yan, Zi

