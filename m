Return-Path: <linux-kernel+bounces-751729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B1B16CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F126F7A6B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A029CB3E;
	Thu, 31 Jul 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5Xxl6oK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54831286885
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947341; cv=none; b=YMI0jT2Ky+HsAuD8uTAQJrpG7+zhUc5WKF/93rWIHCDh0Ed9ZXdvl7h7psB8hsLEUHtCiKXl84tt6QDEEADvIvr3B+Dqk8nhXN0N5OhtNGJ2yXO0C810PIAVBuYF0OgFlUK+qQMd87pfBS17/vuaAo5EFevteBpMuyGY6IQ6Js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947341; c=relaxed/simple;
	bh=Gdn9yZesKrtDa8CPMUqpXqONfI2istirVLcVIlDyMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfdOJafUzQGrcphg+jHzcCax045BKmxbHWEmp+VWoQr//LX1wFkWWL78BHZ7zUHk9M7/oItYmNSL00kLXS4VzA2uI5pW0umyCf72jgFM95UpZRsBWb8qPUyOpzg3OkCiZChFte44vlryhHG9EFBu8FmKkYbDFKWCcVUfGgpWHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5Xxl6oK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso7826a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753947337; x=1754552137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr4nI1RZ0aUC8kJED58iFvgqg3PeLMboTB7tYrXF+Rs=;
        b=C5Xxl6oKxzIDyZSRnEfGxLPMzbZTBgRadVlsto2lz8GL+Mv3F32gADD7K86+FDw8zB
         h1P/REB29SXqo8h+S+cc9O0GmwPz/yKepZdBdqoQsfSDuJ3+RrvUKQgi0PFUZcwyANdr
         eRcBXEJE12EA4zML2Vs2fIa4OMr110BQFdtmlFqtR6spTaE7SLmn84J34MU9tSbq8v64
         970DilFnaw1DeKa8uKxV4fbUjq9bCeshQpq//yQgv6fTM/FLUKZ3YduCCtlAdQbfirsw
         9pmpIPG3pvOUBuAG1qkHD7JE8ECqgsiisajQfoaEd6zlSKwax4kbqs3NOSf3vBnBeSaI
         beYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753947337; x=1754552137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr4nI1RZ0aUC8kJED58iFvgqg3PeLMboTB7tYrXF+Rs=;
        b=vd3/eg5xB3L6KP0sln9j5xb80FmAo/rPz/fVnyF9LRZ+t/XHo8pnyhtYI+6JpcVQm6
         yjsNiSvvOlL/92AIiTw76Au89LWluNKKVbBENOufaRihWi8Ku5wgtxiDNQF8qJiCDEf2
         +I6SiYnZixE0l4XHwzS09Whr4A7afhD7fqz2UbJyLroMmFpQLu0i49wW/gAsuNgRh2Rq
         16AxxnIfGPLRQ9aH6+UmdsxSFc4qCfhupdBL5IobP58YA3iwgJt59t/3TGKIelQzA7Ho
         bOYDJ7rpUr1XLYMpv3OA5aeaXXZ7cs+jZxTokykDG638DAj/v8+POAkylm/yUMVReXAM
         gxbg==
X-Forwarded-Encrypted: i=1; AJvYcCW2bEavvPVB465B9ybRYZqi53r1WaBFnYi887Jf0g3roLUaGl5TNUMtsllrHLIZOeqHwc7bFKGl4I9Ah0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEaKhdkA6/Wcr70h1iuGfGTneYCv1fEgXTIdGRg1sqX0/gPUX
	gQbGQ2HSPse/lFmJAQEUJeZPBhhO3qATGsuetF7fRG/MxXfALdsheCVxueuW1YN3MKfijhk7vJ7
	kUElkCWUwmCDcF07/N0F2hDartSdY6DAvX58Mg8t1
X-Gm-Gg: ASbGncsq3XsgCaY6xW/oKqoEBU/j3+5aWjOqEuLhygQZAtpusRJwBzgz7m4OWn5PVl3
	Q/DM+8G4nvQ+Eiwbm8OQJB2t+JK6sYWsqvzwKnJH5tHEodDLBKk4HxsWwEy7mfU8btTMMf0v7zW
	HXEcCP2ZI4aowKUxTkblt8EFekdY7tXN8rc0l/rSCwHj0ZHBgEd58lGh/QW54ZomyfO8Oo35CCy
	OhTIEXW2ZIU+xtFx8zHG0OiqC5+bcLXzlnFsux9pQ==
X-Google-Smtp-Source: AGHT+IHtcUhgi8RZY+pP59eZQXFisUqGh+rMLisfzq31p3eUyY8SyT/jd1+e3gmkieggdj/A0+p+GZoIA8lDB3fc2rk=
X-Received: by 2002:a05:6402:24c6:b0:615:60d2:c013 with SMTP id
 4fb4d7f45d1cf-615aeafd1c6mr38128a12.3.1753947337300; Thu, 31 Jul 2025
 00:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730170733.3829267-1-surenb@google.com> <20250731015241.3576-1-hdanton@sina.com>
In-Reply-To: <20250731015241.3576-1-hdanton@sina.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 31 Jul 2025 00:35:25 -0700
X-Gm-Features: Ac12FXwJBI4mVpBBqUWfGr9jR9lO9A344ujt5HbmzXkVYW0YulijvoNB_gKKPWo
Message-ID: <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
To: Hillf Danton <hdanton@sina.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 6:58=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> #syz test
>
> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> encounters a non-present THP, it fails to properly recognize an unmapped
> hole and tries to access a non-existent folio, resulting in
> a crash. Add a check to skip non-present THPs.
>
Thanks Suren for promptly addressing this issue.

> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@goog=
le.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/userfaultfd.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cbed91b09640..60be8080ddd0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1818,27 +1818,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
>
>                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
>                 if (ptl) {
> -                       /* Check if we can move the pmd without splitting=
 it. */
> -                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> -                           !pmd_none(dst_pmdval)) {
> -                               struct folio *folio =3D pmd_folio(*src_pm=
d);
> +                       if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
> +                               /* Check if we can move the pmd without s=
plitting it. */
> +                               if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> +                                   !pmd_none(dst_pmdval)) {
> +                                       if (pmd_present(*src_pmd)) {
> +                                               struct folio *folio =3D p=
md_folio(*src_pmd);
> +
> +                                               if (!folio || (!is_huge_z=
ero_folio(folio) &&
> +                                                              !PageAnonE=
xclusive(&folio->page))) {
> +                                                       spin_unlock(ptl);
> +                                                       err =3D -EBUSY;
> +                                                       break;
> +                                               }
> +                                       }
>
> -                               if (!folio || (!is_huge_zero_folio(folio)=
 &&
> -                                              !PageAnonExclusive(&folio-=
>page))) {
>                                         spin_unlock(ptl);
> -                                       err =3D -EBUSY;
> -                                       break;
> +                                       split_huge_pmd(src_vma, src_pmd, =
src_addr);
> +                                       /* The folio will be split by mov=
e_pages_pte() */
> +                                       continue;
>                                 }
>
> +                               err =3D move_pages_huge_pmd(mm, dst_pmd, =
src_pmd,
> +                                                         dst_pmdval, dst=
_vma, src_vma,
> +                                                         dst_addr, src_a=
ddr);
> +                       } else {
> +                               /* nothing to do to move a hole */
>                                 spin_unlock(ptl);
> -                               split_huge_pmd(src_vma, src_pmd, src_addr=
);
> -                               /* The folio will be split by move_pages_=
pte() */
> -                               continue;
> +                               err =3D 0;
I think we need to act here depending on whether
UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not.

           err =3D (mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES) ? 0 : -ENOENT;

Also, IMO, the step_size in this case should be the minimum of
remaining length and HPAGE_PMD_SIZE.
>                         }
> -
> -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_pmd,
> -                                                 dst_pmdval, dst_vma, sr=
c_vma,
> -                                                 dst_addr, src_addr);
>                         step_size =3D HPAGE_PMD_SIZE;
>                 } else {
>                         if (pmd_none(*src_pmd)) {
I have a related question/doubt: why do we populate the page-table
hierarchy on the src side [1] (and then also at line 1857) when a hole
is found? IMHO, it shouldn't be needed. Depending on whether
UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not, it should either
return -ENOENT, or continue past the hole. Please correct me if I'm
wrong.

[1] https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797

>
> base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> --
> 2.50.1.552.g942d659e1b-goog

