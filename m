Return-Path: <linux-kernel+bounces-745696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8525B11D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8E9AC1393
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F72E5B10;
	Fri, 25 Jul 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF0iXWRd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1062D9EE3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441734; cv=none; b=QZnLgAkUvbY6Ke355VqSFIdOb2FAE1X9YDJ6wDKF7Y4DW3VW/ZDNF+YPG68B7Dg8eoHdjqwQ2YEx3SMyO4wT1Mza1eyNcPWXeRztYgDLzNDDPdTTDgypWPCBr/5GkgjCVzXHWnZtI1+eYQpEZCZr+ASTaX56dhY9duGuBiiyMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441734; c=relaxed/simple;
	bh=8uh3VjLlOhvPO7QSa2UmA7IrCegHoyj0YYL7MaiQG00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW31728rOEg81T1SVksXLpsUYwzq8HnZ5ytZgOlYw5rNZyms18wKe9DHMQtuRbdAMaeYnoHS46LPjNC6PBPjPek0p+gWDe2bYpHZSoGAbY6k8aqQXa5zlv9wDLGvOYZV05al1/830ygfg5LIWMs0LiZBMfo/1LlB03bkQ5bFUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nF0iXWRd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so8461a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753441731; x=1754046531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLCJAxauY0TBG6NK+a7XThqW2O8slo6BrQZ0Ungqotg=;
        b=nF0iXWRdr4moYFHFOtHn7WiHL/WTi/YzgP3KuwMwKYA7xK85n21Fiih+DjEp52ZUGe
         nsbdIyfFAXjXldemSKwK9m/BHIe4/jldpAllnJY7hzKLziLJqLSUWiltfDq67LlMMEsx
         PTX4QYp5jd09rSbRgU2gg38fApiDNOuNvC62OY57HuTt6MqsksCljCKwcUiUgNZ2Lunh
         G9wFEClpecNUSCsUqALsRC6WN6TBRBWW/+dkXPMQE9Rxin8+zvqRqQbGnwBwCk0VNHQd
         H8fETFb2wgPpuAEMsTDOiUt90tM8k9+uticuZwqFwvbOYBIttdl9XFTuEWcDsJNp1yCO
         Y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441731; x=1754046531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLCJAxauY0TBG6NK+a7XThqW2O8slo6BrQZ0Ungqotg=;
        b=fWz2P+WOaVPPfSuZN7aLe1R5681k6PJCb53u8FR7NFcM4OKRW5mjnhQxfUCaFJu6O2
         5uhmsMUO7W/o0l1A72kEfSPZamk1u1MNh2gKyUtEry+IfdzXxDN0/szGEl8QbEvG6oFE
         uesQnyYqERI37msGQ8EGFlj9eEvaOdAVs4Nl9+GoEQr9MbriSROdCXL3dKQr043CWKJn
         Z3IWy8eS0f3u8bqr9P/j7mvt3uiQvDGAYWQo2GcWSBb4AXQajQMhHmxxHKpMsats+Uku
         8k68ZU14BSoBCEjbyKIpU8blmT3LdZmb2mwEZpR1zMXPtpLop44RQnm4Xpk9zxMK+6TJ
         doSA==
X-Forwarded-Encrypted: i=1; AJvYcCW5mnv3JrqvYhc/d+9ucgqiL2X0bgVFKAyXiqv79okKigt2ImUAMTN385xUlAJ2ns3f3ekwQdfeWvu1GgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9luLm+6gO3oYzBNY5nmuCwWKlR2wrXljj4DVJAMfgZo62Zv6X
	YZWOjTFiiSxyFRZK+bGHRW5NgPYBrNZXrFlWBvkmSP5geVKAwSZLbBg6tSUdWx9ZUcaiP9zN5Ao
	RHLxQ9fbGHpEmqQACxpyl6tGqxSxoVXr5pFTn20r9
X-Gm-Gg: ASbGnctjXpO0y2iGY5pTBHMh5Hz4vz+cp04OHz3IAv1Xe7/HsJN5jF5p4p5IdtObBP9
	oYz1cxY4mueti7eL52A+MCUFLAfK8lmWKRLHo0vMLvs/VfbeAi3hteZKZDHXDjJ+gTdrTmDMejB
	9gQGueoIf86xpxjC3ablO/9kYAR/P3cfB0zbqWY2nGq4KbAFn6B1wlkTE4fvKBDeH+oCW/HbhU7
	bPSNXrGvhhsybzyaebsBBtxg+XSoky0thI=
X-Google-Smtp-Source: AGHT+IEMTDwjyL4+fhFLe3ohk28hL9nR7cJsI4d0+0IyjLdUTX5kyLugNJfv0jM6zKjvqFnigkMFKZTQwIs4QvJUeew=
X-Received: by 2002:a05:6402:50c9:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-614ea6ecc46mr64310a12.1.1753441730560; Fri, 25 Jul 2025
 04:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com> <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com>
In-Reply-To: <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 13:08:14 +0200
X-Gm-Features: Ac12FXzjxVOOI28yZxJhKS1I6WTue9iDCrodBiA9h3gKa9DeS0XWfCckJLCwVKM
Message-ID: <CAG48ez1O+7ciCNDVnh9MPh_1_1TLWd-=H9L6p90J_9AEbav27w@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> On 24.07.25 21:13, Jann Horn wrote:
> > If an anon page is mapped into userspace, its anon_vma must be alive,
> > otherwise rmap walks can hit UAF.
> >
> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> > walks that seems to indicate that there can be pages with elevated mapc=
ount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressu=
re
> > randomly caused reclaim to rmap-walk the affected pages, so it of cours=
e
> > didn't manage to create a reproducer.
> >
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages=
 to
> > hopefully catch such issues more reliably.
> >
> > Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> > unlike the checks above, this one would otherwise be hard to write such
> > that it completely compiles away in non-debug builds by itself, without
> > looking extremely ugly.
> >
> > [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.=
com
> > [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.c=
om
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >   include/linux/rmap.h | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index c4f4903b1088..ba694c436f59 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(cons=
t struct folio *folio,
> >       default:
> >               VM_WARN_ON_ONCE(true);
> >       }
> > +
> > +     /*
> > +      * Anon folios must have an associated live anon_vma as long as t=
hey're
> > +      * mapped into userspace.
> > +      * Part of the purpose of the atomic_read() is to make KASAN chec=
k that
> > +      * the anon_vma is still alive.
> > +      */
> > +     if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
>
> 1) You probably don't need the CONFIG_DEBUG_VM check: the
> VM_WARN_ON_FOLIO should make everything get optimized out ... right?

The PageAnonNotKsm() check is outside the VM_WARN_ON_FOLIO(), and it
uses page_folio(), which uses _compound_head(), which does
READ_ONCE(page->compound_head); and READ_ONCE() unfortunately doesn't
just mean "I want a read without tearing", it also (intentionally)
prevents the compiler from removing the read when it sees that it's
not being used for anything.

> 2) We have a folio here, so ... better
>
> if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
>         ...
> }

Hrm, okay. It kind of irks me to write it as two checks when really I
want to ask "is it this one specific type", but yeah, will change it.

These helpers don't use READ_ONCE(), so the compiler should then also
be able to remove the check...

> > +             unsigned long mapping =3D (unsigned long)folio->mapping;
> > +             struct anon_vma *anon_vma =3D (void *)(mapping - PAGE_MAP=
PING_ANON);
> > +
> > +             VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) =3D=3D =
0, folio);
> > +     }
>
> In general,
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

