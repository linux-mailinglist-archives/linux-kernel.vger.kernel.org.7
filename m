Return-Path: <linux-kernel+bounces-759447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E21B1DDAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C50721B24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0081224AFA;
	Thu,  7 Aug 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSaCC3rT"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506E4A06
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596136; cv=none; b=X0wmaAqur78QIqSDr9NEyyu1KXcazbH9YYmHnn6ka1GTf/41mBsf6OOgt1cubpco1cAcPmDTAZyVTJsy0JUvpHkzqumY2P/hMY28MWe/xY4ap1ppUqTnseASBWRDPJMbsmdYGeH9iQcrcStOOyUbnw0xUYpXbStDAmshx7spyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596136; c=relaxed/simple;
	bh=RIo76mvyq5VwQpunHgBEWm/3E3MErf0Q3HmctD25xyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgAXf6r6Kbghv99i7QbWd26mm1D2QlrEV+cuesCAC+HUUSwbb0ddu2KsXslpr1wsWl4nOl0I9MqKGYAzGZWlBduLGdsC7gCvg8NQBMRGt+JBRqdNL+D2Ey/2Tm233FJQjNRjM0mzkVjyHlzZKa0kLabvfTmMXWulCAI4MDo4ujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSaCC3rT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso8501cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754596132; x=1755200932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wFSxnKwuzrZsGAk9Mi7JG0vUdJDMSQzEw25HyCDeLo=;
        b=hSaCC3rT5H1hjeKDQqClPYl0p8l99VAzb0pPmGbf1AUIj3O91e2VQTB9+hmlSLiQ0q
         pvRH1Z8fRVweARUF5zaTIbAgTwyj7F74sHveWZ0Emq5J/0QT7sh8JMjYN4zfMoWf2Ykv
         XpG2QFFSR4j2IMg+q3Fd8A5iTj+FR6mjyl4/pqhegnSjrE039isEh1Bzgu9/JSiKAUKN
         6bfv2wvUoLqCKpNdzSt1GqaWJQPK19f9PSp4Ty7FFzGNcgfZhXsbnUFU6XHewOA8xa5l
         Rb5rjbVOgLtAcBnirlHP4YSxe0YC13CUwtLDq1gzRpaqq8tBxT0tdOr7mVdWZTmYHeAf
         patg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754596132; x=1755200932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wFSxnKwuzrZsGAk9Mi7JG0vUdJDMSQzEw25HyCDeLo=;
        b=jrW3eiSsRhcxWjnDii2ReQe5LQR/2vcIk+RTedOlPIeqOd1v65gwNrzpQFe61KpCBP
         b+uIs0Vuh7Okm6fzds7jd4ap3OrW4Mnm7uaZiSUByVcEDkned31xvpJXx7HMFlQVNaUR
         LzYKbEZrJGQFO4Bosp4AvpxPyDmTArhwIyZchFZVllNAEmRuifDrApJ8ab0f+D3NBv8t
         LTm4rwKw7gcPjIinAB2OXZOYR9AojHes7veN1n/GbcBdPX5j1nwFK+hg5Z9XkxNntdVN
         0+ikuaKDZX2K55uswisvWYE+k2UKT4EQ1bxmo2g0ery3zH+NJ1UQuRHztZY/UI3sKQiD
         Vvrw==
X-Forwarded-Encrypted: i=1; AJvYcCWC0RBOA6Xkovhqs0DP2RG9qisjj0Yp9OQXuxcyeMAV4WPfnHb1Lp9pufgqkP0D1uWK3EPGs5n4V2Bz4tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQI44cmf0k+dz4RWJQKQjB8EcmvhSVDfgFb4X4sgnoQeehytC
	ovqtApgHW87PsBCznheeQNMwzPAex20mjaivlXnJ0HNU9DsyYg46SUfR3UGCqalNpAC5ENOmrHO
	6beAyd0GVjpqldhuQ4AaM+rhoGzdnPq6w8qHKFUW5
X-Gm-Gg: ASbGncvu+OkiwXoe3RO5GuhFCeRJ+2JDEXG6amGEzBvNtU6rS9u3itJUhvNiBPkleK4
	VIX3NRJ/bkJySqbW1IANGAcmKjpwfggxVIoknzfZ7cW1J5CEj4ry3B9XL3s6WbVw3SZO+AF890l
	qa7qiszEIgfLlMBr2qUp8zufix4Kzhtad43Rx/xDUtWKAyjbyk1tI1gd/bQDTGi2jT+pwacsIVA
	E8PU2BwWubfKfNYB5GnKu2V29jNsVi0DdjVw3ZpOjmeBQ==
X-Google-Smtp-Source: AGHT+IGAnzFGc75ayYfRxWbh7uLxZSTdYzNMshPpWSpmNdU9XPko9zKPro5GAtATFgigXkkdyna/EGGm8ixjXrUw3W0=
X-Received: by 2002:a05:622a:5d0d:b0:4a9:e34a:58a1 with SMTP id
 d75a77b69052e-4b0af27f42fmr657231cf.21.1754596131723; Thu, 07 Aug 2025
 12:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220022.926763-1-surenb@google.com> <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
 <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com> <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com>
In-Reply-To: <43f91e3e-84c5-4fd1-9b63-4e2cb28dab36@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Aug 2025 19:48:40 +0000
X-Gm-Features: Ac12FXwfQ6qiGrsCKNHq-ologii6PPu3d0YnpfdjkTe6XUo0_mB7-54uzVqhRMY
Message-ID: <CAJuCfpECC9w6RdfbH34Y906uV=egUDct=6H54Xn79okKK80cjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:42=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.25 17:27, Suren Baghdasaryan wrote:
> > On Thu, Aug 7, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 07.08.25 00:00, Suren Baghdasaryan wrote:
> >>> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> >>> obtaining a folio and accessing it even though the entry is swp_entry=
_t.
> >>> Add the missing check and let split_huge_pmd() handle migration entri=
es.
> >>>
> >>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >>> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@=
google.com/
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Reviewed-by: Peter Xu <peterx@redhat.com>
> >>> Cc: stable@vger.kernel.org
> >>> ---
> >>> Changes since v3 [1]
> >>> - Updated the title and changelog, per Peter Xu
> >>> - Added Reviewed-by: per Peter Xu
> >>>
> >>> [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google=
.com/
> >>>
> >>>    mm/userfaultfd.c | 17 ++++++++++-------
> >>>    1 file changed, 10 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >>> index 5431c9dd7fd7..116481606be8 100644
> >>> --- a/mm/userfaultfd.c
> >>> +++ b/mm/userfaultfd.c
> >>> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> >>>                        /* Check if we can move the pmd without splitt=
ing it. */
> >>>                        if (move_splits_huge_pmd(dst_addr, src_addr, s=
rc_start + len) ||
> >>>                            !pmd_none(dst_pmdval)) {
> >>> -                             struct folio *folio =3D pmd_folio(*src_=
pmd);
> >>> -
> >>> -                             if (!folio || (!is_huge_zero_folio(foli=
o) &&
> >>> -                                            !PageAnonExclusive(&foli=
o->page))) {
> >>> -                                     spin_unlock(ptl);
> >>> -                                     err =3D -EBUSY;
> >>> -                                     break;
> >>> +                             /* Can be a migration entry */
> >>> +                             if (pmd_present(*src_pmd)) {
> >>> +                                     struct folio *folio =3D pmd_fol=
io(*src_pmd);
> >>> +
> >>> +                                     if (!folio
> >>
> >>
> >> How could you get !folio here? That only makes sense when calling
> >> vm_normal_folio_pmd(), no?
> >
> > Yes, I think you are right, this check is not needed. I can fold it
> > into this fix or post a separate cleanup patch. I'm guessing a
> > separate patch would be better?
>
> I think you can just post a fixup inline here and ask Andrew to squash
> it. He will shout if he wants a completely new version :)

I wouldn't do that to him! :)
Let me quickly send an updated version instead.

>
> --
> Cheers,
>
> David / dhildenb
>

