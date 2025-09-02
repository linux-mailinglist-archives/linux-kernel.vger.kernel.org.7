Return-Path: <linux-kernel+bounces-796967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDCB40A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572917B637E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960C322775;
	Tue,  2 Sep 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0Kb/z85"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6C30AADA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829182; cv=none; b=IJzSCOiEeE0Tg4nGiePeG+HE1jrx1jfoq/yKoLmIUgySTFPU+G5qepsCoSZDURz7V7gNisi/ECyULSdz+HVtPRRGh5LZ7dpMEb+GEBdeDibqBrc1XOHb3H7bDjzXbSsgghG0NioMW+60HRv6LB6aCQCUGqeNMuh0wrI7f6vvcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829182; c=relaxed/simple;
	bh=5VuJ2i9/jC7ksUTZP07b2sTU5J6JZN0KY6kjI0VYiHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHOC3qUQGy7+DTc3FPFKNfBpAP1ov0p3ufWLLezzCeZUNFMFVf/bN1iEN24OeRAG9L6GZToUTFXfJuRtqWwQBgMfoPWXV+60vNSB+vCkPn82T+8E75pTMuzFVF3uoXKN/r3lsRi15SyOjpSl5wuWnw4Gn5UBx18HmmJ9nm04YxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0Kb/z85; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61ed395ba46so2576a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756829179; x=1757433979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzANuyEuI1RP0uICgM6hjPd4IH6cBKzDDVGFb2HLC+A=;
        b=f0Kb/z85AOu8Rcl9bz1iid++/pIpSTWGRrcBwKFi9TnGnBqSRp456wkRMqZx36BSvo
         +ZYBz5SqzDOr8xjMp+PCEdrg9lKDxHeCOqyEKxUwlI4v1B+dKFUTgy39Q6NKEEbpZBZc
         mZLH4ut3u/hICAbcM0BHxPLv2BBvqlwy+g0exMxSc6qbSSlJd5Sonnv+AKs74C0LcT+N
         v7ACB6VsJ0+Kz0F1w/IHdjmHdPxeTO5K2ilpGoaQJMJaWcxNuuPXV//hWfWujxmRT6ho
         e0HvHpNGvrDs5TwNQp/e+7pYfM60DABmuDPQbGMTYb8n6XdGcdzWo7oTUerIJCXmly/k
         lDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829179; x=1757433979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzANuyEuI1RP0uICgM6hjPd4IH6cBKzDDVGFb2HLC+A=;
        b=QiWifWepugrytP6HKF0JyzQeqa/BzXdJpXG3tgdHaVXXnYe073UcrvOfob89hEowhv
         0w/DHB3E4hMyNgRIQaIXjvzuw9CNrKLU/SJ02iTJwdKFLnXBAMbK3ktYJ4GIwrGusA5b
         I8K8xaYwGWLUet8d0ZpmEMSiQSAYun8YKn6y6varL8hmD6sv/BG+pmGHFgtKbZCj3pG5
         XZI1DraX148DLd5yxAspJT4FoiJuTmdqzf7HDOMtplW+qmYEvgRF3k38diwnhi1WQctt
         DKHuM+Ti413wUF05atXm+3g9e13qJwupfSr/1KlPdTF/G6CkZ5UC4JemZEAXi+CNugWE
         u9yg==
X-Forwarded-Encrypted: i=1; AJvYcCW3RjdXXhzg7S+2cm+DfgBXIHwyikbmJv+SaMp3UFT6okbZPNmSzyQeJN0HqjpATAIvRaSh0Uw3MD9LQP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0iEj4KWH0Tw1Tdk/nqIaK8czDTqmn1Rur9cR0OA9bYbvneZsb
	yhpfTPv4/Xt5GiUSx4y3jW8JTt2fpwBOhsSNMfyLGNiWEVyf8GdO67YffZeY5RL7/O2RqkilFvv
	KYs5VvwVRWnZAzZ6HCReoCb75sMN9MbW/OoZmgtzW
X-Gm-Gg: ASbGncsIxJEnSZ1ueXz7OiGiQtou8BwocxkZxxdDqNYa8uoovE/5qVONIkTwNKLxlVg
	rxWrAveTWd/6x+QOtFwvxEN7l3bF/mfgZxM4ldelPDDgCJMp8a9n3QFfDpHmr4u77gjWT015OQ0
	UbeA/T4cG1ofFDr9u+0mervkXGYmpxjDM05rDarRACwD53krIwXylvzE35S65rLZmccsLizcyM6
	KeBS5gRcKsmYYE2pTlRjs1vTQwzLTY50Wg+4jHXrk36WIeHrf9p
X-Google-Smtp-Source: AGHT+IFVjdQ+2T7/LXpZCpOfk33GaA9SF6xBIIl71Fs9cHt3AeFCESliSAH3aiD8Kxte9Rt8Kym9K8NUgZg1oMEq0VE=
X-Received: by 2002:aa7:df92:0:b0:61c:ab1b:1828 with SMTP id
 4fb4d7f45d1cf-61d21f9fc51mr262090a12.7.1756829178846; Tue, 02 Sep 2025
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226030129.530345-1-riel@surriel.com> <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
In-Reply-To: <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 2 Sep 2025 18:05:42 +0200
X-Gm-Features: Ac12FXwEw7Qk0kLzRMa95Y1yUaklA4c8qD40uRP3S8PLdE1A0rat-HccquoTMss
Message-ID: <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, peterz@infradead.org, dave.hansen@linux.intel.com, 
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jackmanb@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali.Shukla@amd.com, mingo@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	baolu.lu@intel.com, david.guckian@intel.com, damian.muszynski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 5:44=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
> On Tue, Feb 25, 2025 at 10:00:36PM -0500, Rik van Riel wrote:
> > Reduce code duplication by consolidating the decision point
> > for whether to do individual invalidations or a full flush
> > inside get_flush_tlb_info.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Tested-by: Michael Kelley <mhklinux@outlook.com>
> > Acked-by: Dave Hansen <dave.hansen@intel.com>
> > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > ---
> After 4a02ed8e1cc3 ("x86/mm: Consolidate full flush threshold
> decision"), we've seen data corruption in DMAd buffers when testing SVA.
>
> From our preliminary analysis, it appears that get_flush_tlb_info()
> modifies the start and end parameters for full TLB flushes (setting
> start=3D0, end=3DTLB_FLUSH_ALL). However, the MMU notifier call at the en=
d
> of the function still uses the original parameters instead of the
> updated info->start and info->end.
>
> The change below appears to solve the problem, however we are not sure if
> this is the right way to fix the problem.
>
> ----8<----
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..e66c7662c254 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1459,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsig=
ned long start,
>
>         put_flush_tlb_info();
>         put_cpu();
> -       mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
> +       mmu_notifier_arch_invalidate_secondary_tlbs(mm, info->start, info=
->end);
>  }

I don't see why the IOMMU flush should be broadened just because the
CPU flush got broadened.

On x86, IOMMU flushes happen from arch_tlbbatch_add_pending() and
flush_tlb_mm_range(); the IOMMU folks might know better, but as far as
I know, there is nothing that elides IOMMU flushes depending on the
state of X86-internal flush generation tracking or such.

To me this looks like a change that is correct but makes it easier to
hit IOMMU flushing issues in other places.

Are you encountering these issues on an Intel system or an AMD system?

