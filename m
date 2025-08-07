Return-Path: <linux-kernel+bounces-759235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4BB1DAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1824C3B1BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804EA26981C;
	Thu,  7 Aug 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHmbndFI"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27A267B9B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580442; cv=none; b=NsNSOOcMS0Cg4DPqLdBdJyvZuEUmiTCw5nzXcWyDPuniun1/2Z3QCr8jSe5ZFZ31/Osg5Ca4dzbvJlmO/4o3pe7tuaRmiXKvRg0N5qM05wlvajnBls3ViQVo3vPq1jvmkIcHbG1TJ05I2iSKaX1bDlZDba0wEIHU8xJYNowIFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580442; c=relaxed/simple;
	bh=mL1pBirMJzEme72kKHRF2wr+5TBxmQNWIHDsAk3E3ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzrVRtl573/VxvNvNVP/jAt7p1HDK8fIeWFV0FKhwAmqOjgQzszuge7PZ2i+10HVoLgRf0kGpoB8W/jsb1FINzeVOeM4YgqhQ9eLlulE43HOVyviOYiVbHdMT8HLKIlEpubKT3z3Hks2epNYHGERom0/Eeqj4QJahfouCIY29xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHmbndFI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b099118fedso356111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754580440; x=1755185240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xioyC2IWw8hko9lVkldYv22q6OUtLq1NUecRh4m4n4o=;
        b=PHmbndFIDSUTUf4WhUbdxhBmexysSjqB8/Z5jnubC+HbH09kJYe5yhENPI9XvvtIEd
         D/rv1OyTXi/9FQ8mHlt+RWGgwa8c1tsTKhu8VbK+k+DOF9wbEw1TlFKNcd7fS0VwJiQg
         rvNA2OpL9s3NyUOAc43xqZoU/QygIiqT5SNcSUssKBlV4u61tNJ0t1ytxdZ/Nt7u6F4H
         bP4yP7U8zyXO2nxQiqM22an/+sDb1UwG9Xs4b2dOYJy/qZcL3MQkYrwIt7tr32iQXEQF
         saytPcvWSqv03P6unxcjGK7dKsp8FhLYBuIeQ/87l+d/VRtD5BwS7gr4KlMtNLlI1hTR
         hYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580440; x=1755185240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xioyC2IWw8hko9lVkldYv22q6OUtLq1NUecRh4m4n4o=;
        b=elQFFSgGWP1X5T3pJHQ8hU/MhU15+DoDxaqgGh2/uzdfEmqKjgGFEHbgM1QaghvU3k
         XccevksZRDmjCkPW0cBjHg1V0LfTZTcJy8I8UZ/BmsH2TE2bf7bqVP7j6houlHXE2Wum
         U95obz13S3w2mVEfBdCDS1G1tS9GpbwT1WtX1OuwgVIBK1iH8dyNPD5LKJaEqZrUPmZl
         thboYV0uxlx2zy92INIUWSO62AZ3biGtvpZvFprSB+1/5ZbgJUp5fFvvzeihszgBMNV8
         cnZPahY0TKZRaD9NXyoHL/OlhbiPd+EjU4JrQkcm6kQTFgvbT8tOMAXeLM8/1pdkJ7rR
         68aA==
X-Forwarded-Encrypted: i=1; AJvYcCU1InRmKhtVga/x7UDlPO1jwrK7vk+sgpkM7s0Ru4qBwAvQ+JhHFVETgFJVGRyLMUlQ9wuzpdJQOnT0stw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZabadRadIBtZyth9jabXGfhQW/h8Yypobo+NvMHYfSd1oZqC
	amFnzL37YPNbrhci1H0+eJ+dgaYmpl+l3uY5qa8xnGziFA26QANup0GVps/mVph0y1xYlqA0lLK
	dOFzVPdKj3CqzDw3CuMja607YBqNWnHH9pTLE1A3S
X-Gm-Gg: ASbGncsW7HQO74Jn+TGytKef4TbP6zmSFj+yfAZfsNG3W/cNcaq3jBTAvXDafmxG9b8
	4fE3EEKr2xJarFqPIB2VMK26i13ZYOwSmWN2lOhAOzDCeDk5sx0yuUfpVBmZ3+0RRjAOztvOb1m
	9GFzcfQdLZ8UPVw9YKAJQp5U7ke0PCXHw0gRtbNoRe4xvRf5XLwojVcq5IY8BpVdmKIy1D9FlCV
	ILG9kPwI+ZLjLU+3UTb28piRcz8Hb5T/uwgBxSwK0ai6pNU
X-Google-Smtp-Source: AGHT+IGqSzXAmTUh3Qi2CUJgK4pgM8gORIxm8uH+FHAhS4VzwkyY6xnxbuHT0p3P7PQwzevNQcRG65DrMC35ALNZ2Dk=
X-Received: by 2002:a05:622a:41:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4b0a6dd90f8mr4013581cf.7.1754580439612; Thu, 07 Aug 2025
 08:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220022.926763-1-surenb@google.com> <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
In-Reply-To: <3eba855a-740c-4423-b2ed-24d622af29a5@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Aug 2025 08:27:07 -0700
X-Gm-Features: Ac12FXw0D7Y6MNnLaNuzRlNa7wyKoBPDReSLik-x4NPnGAkXfZmI9tMKxVv_LLY
Message-ID: <CAJuCfpExxYOtsWZo6r0FncA0TMeuhpe3SdhLbF+udtbqQ+B_Qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:31=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.25 00:00, Suren Baghdasaryan wrote:
> > When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> > obtaining a folio and accessing it even though the entry is swp_entry_t=
.
> > Add the missing check and let split_huge_pmd() handle migration entries=
.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v3 [1]
> > - Updated the title and changelog, per Peter Xu
> > - Added Reviewed-by: per Peter Xu
> >
> > [1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.c=
om/
> >
> >   mm/userfaultfd.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 5431c9dd7fd7..116481606be8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >                       /* Check if we can move the pmd without splitting=
 it. */
> >                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> >                           !pmd_none(dst_pmdval)) {
> > -                             struct folio *folio =3D pmd_folio(*src_pm=
d);
> > -
> > -                             if (!folio || (!is_huge_zero_folio(folio)=
 &&
> > -                                            !PageAnonExclusive(&folio-=
>page))) {
> > -                                     spin_unlock(ptl);
> > -                                     err =3D -EBUSY;
> > -                                     break;
> > +                             /* Can be a migration entry */
> > +                             if (pmd_present(*src_pmd)) {
> > +                                     struct folio *folio =3D pmd_folio=
(*src_pmd);
> > +
> > +                                     if (!folio
>
>
> How could you get !folio here? That only makes sense when calling
> vm_normal_folio_pmd(), no?

Yes, I think you are right, this check is not needed. I can fold it
into this fix or post a separate cleanup patch. I'm guessing a
separate patch would be better?

>
>
> --
> Cheers,
>
> David / dhildenb
>

