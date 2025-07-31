Return-Path: <linux-kernel+bounces-752220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E98B172A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B5018C6714
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCF42A87;
	Thu, 31 Jul 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hN0jodfG"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A21EB39
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970449; cv=none; b=H0CdEQ7bVeGUgAmvRTI9r0QLGdzmpCKFgiQtGVoC/woTKiCq9X70d6PMrjeF45IatzRsTn6/xO0wpvEy1C/am8a/V0rigBG1XeG4/cqITb4rjz/BPDFeZX1Hwl4hRpBQLazAV68ISy9XQWROegcJHALXuHX1xpn/0ElWeSp4m60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970449; c=relaxed/simple;
	bh=TYO0hAgc/23BSBfxrpwoUOqMVuftDOSqOdIkA5xugVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+nVErBgOYoOXpTYb43DPI5hY8NNZVySu9stxuQ0fwusqz1KlC6ZehGmanjnPRxqaeKgYRyspJcauNN23ci0qVuzVhShYzZAoPPwmJPi9/HJjwUlf9sP3Nv85lU83h3d5TVqu5rbM04/cxBWPSOMWRdwSnWjBDIGQZc2R5Xoy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hN0jodfG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4aef56cea5bso171201cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753970447; x=1754575247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1dXZWgj+fot6VQlsiFsqWy8IxRr4ctPcghfLIk+tT8=;
        b=hN0jodfGAk+5q1yK3TqX8ovR7MkGGHbsCTx5cGBsV+vu2fVbqr0tmqfP4Y+9wM+Ro9
         wYktGUKmoOAZpv7QyWIs7S3RHodJGL0eNcVbi2dAQC15Dl7s9n4Xxyh36c+s0AY+FOvH
         41f6C+m6vx3JAOzXJ9hDWIV+2x2XondVGK6v7uyAHOS1ufc0+U8l7dtfXu9cVFrKgEkj
         XesoUxYi+EemiBeFkJ5xjX1AbTGxKyxF5w4IbA4FlRuTqDU6QX9HHD3HL/r4R95OFLUn
         VJN4MMy7HC46FggXtjrbUUBDZ9LcsKeC8DMNVbRuT4I/jQxnET6rMgFpkgh8+EOYyW2S
         fi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970447; x=1754575247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1dXZWgj+fot6VQlsiFsqWy8IxRr4ctPcghfLIk+tT8=;
        b=tm9WIOEx55aWi27GtNXdAdbQzfZ05HwYO8z4XQkwtZSXWSNfJXSi7Xne3uDPDmO8Wn
         CiZwRr5A5RO1/LNTtErfioeEk6NGv0252A3AjTw3Noil/4BLxhDpvdFK7SUIKBLqylhb
         Mav9osP3yisnf0cXluyO1UAYQx0tXnBGYRfzuktZFjmXZFSwwW+Ej1paM1SSV6DxzAYs
         LpS7Vbww97j0bIpY9NF+JS/S/fA+L82MsVkGgkD7sDMueSPDcMhZs+50RP4ybCDuTi3h
         UJl8ve45cN4zKLU1KCCxo6bdDJCmnSM3ZW6O0wSQBehVLXVp1FKcJ6q8BZ+uIKR9Y9Iq
         2fVw==
X-Forwarded-Encrypted: i=1; AJvYcCVTQv04Mae7p6BpiEi72l9HAlI052rJ+pZcY3mqV6Z6Z7uXs5pETfr6MD6HYwT5TThi2W5d6m/8PDgAOME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQqfpc3iCAf9WlhFuuOhIGy2uY5WqpLLtT3ZJryNgiUTDbrY4
	D8ia2j4uSboDkk04cGJdd8fH01n5VH1JrVVZ05V2SeSoTVmCQdg3NFpluUN/JR0vvlGfRfnBCOL
	uKzeisuP1gZII6hq3ikcH2LiLoDId98vFyVSTPIjZ
X-Gm-Gg: ASbGncvNTnpSKCuRo8qgV5lvNjF0PBgnq99PtKcRmPiyXkkOf2br37Q2zMPlB7xQPC5
	qY5es2axmVc/tQiG7gWceFVkCHSqTy6WbAXqQ2fzZDG5VFSTRfR5W8DyZ4vPRSXYN3hxODAxu2D
	99w6ncDlOvsbchklaEqAIel8AaMfCvnmru7AANil8nKlrJx8qqmN+CSbEjK5FKpJLsAGC6+U8gG
	xNMbi4j8ci5BIJu5tlr/lqNMBb8xdoL3S5ElA==
X-Google-Smtp-Source: AGHT+IEk4aTDVkOyuIOYsxQ+gdUR7gaQ2ViekFoFAWyX3GuYzKuvzqeg9L9gsG9Ro8y5GeaGz79xs2o9try+V3OViYw=
X-Received: by 2002:a05:622a:8e:b0:4ae:df79:840c with SMTP id
 d75a77b69052e-4aeef75aedcmr4234871cf.0.1753970445923; Thu, 31 Jul 2025
 07:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630031958.1225651-1-sashal@kernel.org> <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy> <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
In-Reply-To: <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Jul 2025 07:00:34 -0700
X-Gm-Features: Ac12FXyFwnVib7u8j59VKulDZYOzHHYnGyXScEgOwOvFCgoc4uSiWy98L6DGLZA
Message-ID: <CAJuCfpGiNve3SnGW5EDrZk5pUAqZbrv0MLaQ-Pzt+Y40U=7iAg@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
To: David Hildenbrand <david@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:56=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.07.25 14:37, Sasha Levin wrote:
> > On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
> >> On 08.07.25 17:33, Sasha Levin wrote:
> >>> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
> >>>> On 01.07.25 02:57, Andrew Morton wrote:
> >>>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> =
wrote:
> >>>>>
> >>>>>> When handling non-swap entries in move_pages_pte(), the error hand=
ling
> >>>>>> for entries that are NOT migration entries fails to unmap the page=
 table
> >>>>>> entries before jumping to the error handling label.
> >>>>>>
> >>>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE sy=
stems
> >>>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stac=
k is
> >>>>>> corrupted.
> >>>>>>
> >>>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
> >>>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_index=
ed+0x178/0x17c
> >>>>>>    Call trace:
> >>>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
> >>>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
> >>>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> >>>>>>
> >>>>>> The issue was introduced with the UFFDIO_MOVE feature but became m=
ore
> >>>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("m=
m: add
> >>>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry =
code
> >>>>>> path more commonly executed during userfaultfd operations.
> >>>>>>
> >>>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap en=
try
> >>>>>> paths before jumping to the error handling label, not just for mig=
ration
> >>>>>> entries.
> >>>>>
> >>>>> I don't get it.
> >>>>>
> >>>>>> --- a/mm/userfaultfd.c
> >>>>>> +++ b/mm/userfaultfd.c
> >>>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct=
 *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> >>>>>>                  entry =3D pte_to_swp_entry(orig_src_pte);
> >>>>>>                  if (non_swap_entry(entry)) {
> >>>>>> +                        pte_unmap(src_pte);
> >>>>>> +                        pte_unmap(dst_pte);
> >>>>>> +                        src_pte =3D dst_pte =3D NULL;
> >>>>>>                          if (is_migration_entry(entry)) {
> >>>>>> -                                pte_unmap(src_pte);
> >>>>>> -                                pte_unmap(dst_pte);
> >>>>>> -                                src_pte =3D dst_pte =3D NULL;
> >>>>>>                                  migration_entry_wait(mm, src_pmd,=
 src_addr);
> >>>>>>                                  err =3D -EAGAIN;
> >>>>>> -                        } else
> >>>>>> +                        } else {
> >>>>>>                                  err =3D -EFAULT;
> >>>>>> +                        }
> >>>>>>                          goto out;
> >>>>>
> >>>>> where we have
> >>>>>
> >>>>> out:
> >>>>>   ...
> >>>>>   if (dst_pte)
> >>>>>           pte_unmap(dst_pte);
> >>>>>   if (src_pte)
> >>>>>           pte_unmap(src_pte);
> >>>>
> >>>> AI slop?
> >>>
> >>> Nah, this one is sadly all me :(
> >>
> >> Haha, sorry :P
> >
> > So as I was getting nowhere with this, I asked AI to help me :)
> >
> > If you're not interested in reading LLM generated code, feel free to
> > stop reading now...
> >
> > After it went over the logs, and a few prompts to point it the right
> > way, it ended up generating a patch (below) that made sense, and fixed
> > the warning that LKFT was being able to trigger.
> >
> > If anyone who's more familiar with the code than me (and the AI) agrees
> > with the patch and ways to throw their Reviewed-by, I'll send out the
> > patch.
>
> Seems to check out for me. In particular, out pte_unmap() everywhere
> else in that function (and mremap.c:move_ptes) are ordered properly.
>
> Even if it would not fix the issue, it would be a cleanup :)
>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks for the fix!

>
> --
> Cheers,
>
> David / dhildenb
>

