Return-Path: <linux-kernel+bounces-619410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A5A9BC68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 03:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BD75A5CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63FD1386C9;
	Fri, 25 Apr 2025 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isaBs6G9"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CF49620
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545074; cv=none; b=bcDtebvDoYOWK9QIKaAOtpMpKSnfpEpG+km1fBPLh70HFut4e9R1urtoUexsQpjPThkwgoArYUfYe+KtHiAEKxngZv2GdxuyoJpYbjcsCu8u5+0FUkCzZE0i4OxwD++AQfGa+YUxCRHav4mvwjnLtM2qWAfltS/Ogc0KEH2syiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545074; c=relaxed/simple;
	bh=nq6X3gNPkqG+WVCcyEDqX8q/vryPwCmLGtNph9+gxyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNcKgRXv8uSXhUn8DGwCznNlzMIOrwujLC+2Ar6qa2iBmM1E8BbrReQb4YxcyXF5WMcip6fsahGDMf8gnq1XtrxmMxAMuJX4ZDwA1aBSxxGGR370mKqGOgJWsWefGlro6GqDN/hXhrUuV9ckhmeEjjNoSciQ0KR5lC6rFOgxgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isaBs6G9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774611d40bso143741cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745545071; x=1746149871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDXrukdCd81DIYcPQHSPF4pqx9uTLFQ+okxg/r2gO7I=;
        b=isaBs6G9aFJ5e8wGCtXtJPqKs+m/Twd1jS4zR//StrBA5fnX7bml5RixEfFMGRPQYr
         eNkQxtMaNwyjD2Wo7s38eCeVic9V4C8pnGf49F704nAVXYqa8eWiqdid/CFJRXgZTUUC
         ShhRptYUjMY/Oqq9GspVipJegzH8QEF/obEZhKv/zstLeF+QBiy2qaJKFwgsqj8+MT+o
         z2C56VT6iHliLvMEwtJB5KjmCHHRcoNaSjghiVUJCSmafjgdDiE3PgKj5VopIWtxVfui
         d34I/vWuR8cGIEvUAsFPosTow+xTre5BUkQGsIdepK/VPMuc76Gd6bo1Joloui2tD0th
         kvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545071; x=1746149871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDXrukdCd81DIYcPQHSPF4pqx9uTLFQ+okxg/r2gO7I=;
        b=YGqTPunePeePgS5qKKzwYuCZdMg+OOIGVBjs8yeTbNd8NF4jpLmVgBu6ofgapVNk4s
         wqKuDVSKYe4zd2wxyTNTXMGF8nrgXp8enBL9e/E7qNQ0o8BPcky0G3OSFdqX4qCiG8x4
         z+CiOcx8h64PH+Qu65X43YMk+qq+wLMr+1Bw6Oagg7T0wPGWWVDLMc90ZaEVGBQVHWhJ
         BANNJJUselUA7vhBpKlceum9plG2oVOnEh+X2mSXLB1R2EUb6jQ4xu5lzKd+/Ri6icVL
         qR6gc/NluyGuL6Gfa92+aHacbRpWChGS1IuBUdxpFWVBH1spXHDB/8642iG/ALoVsM0e
         73uA==
X-Forwarded-Encrypted: i=1; AJvYcCVOZW6Auvbr/0TLnEnEDruKqAWyL+20BUDhUC+uIhGYy0I93QoCetkEzNTp1knh85MwQBmiplZIn5+S8X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+NeYSfdGH9V50jmaxb24omGRgx5rWUHqoMi6xwbf7kwbXJgHV
	XaJBuKQfeKJFIcBXaDZmj9UsVr1/bEoB2Y5g2JHOcn/UzNQlkqa14NXLYAlnk+onF9xTfdg+GSX
	wuiC4I29ptjzEz4TH/cIw5vQINsIbblvC3Us3
X-Gm-Gg: ASbGncu4hukNp1PO4ljAeVameR+ZE32hu75R44IVkxo9NVTPRinO8iTteY4c662GVG5
	PFBolsCxcLBsa85Uf0PDdX/yLM46GjAPulmYtCNCa4KUzC0sue2W/KFQoAsGmXQEc8YdXAmlW3c
	d7kls4rX8CdAjNFXdRqQo5EK5SyIflDc8Bp2puD9DuTAp7WN0oKMRF
X-Google-Smtp-Source: AGHT+IGgMFS5E7GsDvhlmOHSNtU9pH6wAf8jTX+F1kd80jaw/M6aUpe/wo+Tbz40vzC5tn3ugJkcrncXTfqzsdBc6v8=
X-Received: by 2002:a05:622a:2b45:b0:47a:ea2b:4a4b with SMTP id
 d75a77b69052e-47fdf1e9dd3mr2127601cf.8.1745545071169; Thu, 24 Apr 2025
 18:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com> <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
In-Reply-To: <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Apr 2025 18:37:39 -0700
X-Gm-Features: ATxdqUHnY6QsCVinxtKvQN7hNEUB-23nGyATiZHGL0y9c1WzahO3i50btZOpp24
Message-ID: <CAJuCfpHxWwEiZdX-xrxe7J+Q20otPTPs4NR-oJBSnL7HNt-f2A@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in mm
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:22=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Apr 24, 2025 at 2:22=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > Right now these are performed in kernel/fork.c which is odd and a vio=
lation
> > > of separation of concerns, as well as preventing us from integrating =
this
> > > and related logic into userland VMA testing going forward, and perhap=
s more
> > > importantly - enabling us to, in a subsequent commit, make VMA
> > > allocation/freeing a purely internal mm operation.
> > >
> > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > CONFIG_MMU is not set, and there is no sensible place to put these ou=
tside
> > > of that, so we are put in the position of having to duplication some =
logic
>
> s/to duplication/to duplicate
>
> > > here.
> > >
> > > This isn't ideal, but since nommu is a niche use-case, already duplic=
ates a
> > > great deal of mmu logic by its nature and we can eliminate code that =
is not
> > > applicable to nommu, it seems a worthwhile trade-off.
> > >
> > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > rendering VMA allocation, freeing and duplication mm-internal-only an=
d
> > > userland testable.
> >
> > I'm pretty sure you tried it, but what's the big blocker to have patch
> > #3 first, so we can avoid the temporary move of the code to mmap.c ?
>
> Completely agree with David.
> I peeked into 4/4 and it seems you want to keep vma.c completely
> CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> IMHO it would be much cleaner to move these functions into vma.c from
> the beginning and have an #ifdef CONFIG_MMU there like this:
>
> mm/vma.c
>
> /* Functions identical for MMU/NOMMU */
> struct vm_area_struct *vm_area_alloc(struct mm_struct *mm) {...}
> void __init vma_state_init(void) {...}
>
> #ifdef CONFIG_MMU
> static void vm_area_init_from(const struct vm_area_struct *src,
>                              struct vm_area_struct *dest) {...}
> struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> void vm_area_free(struct vm_area_struct *vma) {...}
> #else /* CONFIG_MMU */
> static void vm_area_init_from(const struct vm_area_struct *src,
>                              struct vm_area_struct *dest) {...}
> struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> void vm_area_free(struct vm_area_struct *vma) {...}
> #endif /* CONFIG_MMU */

3/4 and 4/4 look reasonable but they can change substantially
depending on your answer to my suggestion above, so I'll wait for your
answer before moving forward.
Thanks for doing this!
Suren.

>
>
>
>
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

