Return-Path: <linux-kernel+bounces-771076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E0EB28295
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D8E188C40F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FB1F4717;
	Fri, 15 Aug 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+lzozbM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3819D081
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270276; cv=none; b=VejvpCpbBTu1Pf/jLVlDvD9aywkrEge/8lw7rgzS7S0yHeJuSG/VvhCHEcJwppFq/UlMp3eeLxiMBt/Hn3dDreYtEb7QcEkeLoM3sn6zfbwy5wQsxUAGFqpkaqIHdpavQE8dtyP6//HAAeyHU0M2xMN9TlYmwyobnPbapff/qLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270276; c=relaxed/simple;
	bh=Z51+j2km8ddbVTSeyDux/kROt8g3lSGezfktc78yutc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrBPwG2I6yi/9lCj9NS4zfqi3u6sZAKkndJ7oQwnfrOwrb7hzwL1jIk6fG6zX/1RiUH5pOu2c1wXfKt2owZqmFB/tHiD+pVrUdkp78TGPrhxw2iFBf6GCtfFUPJDDWagf4RuavOhwUTGHjQuRDtnhLgtjG7XmJC/wo+UsC4CEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+lzozbM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce5247da6so2109438e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755270273; x=1755875073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp94pLZripqg6DXdOBsKXQLYLF6BHz1zUMlVq+K/gJM=;
        b=D+lzozbMYyhualyCpO5gmVVvWTmmsl+H8QxbHSf3tj2zL22aVWhPkuawyvoE+C9QF8
         r0eXxAwjqYlnhCewJK5BzR5Ddw+DPlurkD2UJGS7hrm482lKGWkJFe4dQYjiZrSBrk3/
         3Gt76euj0oNumWQ29hiy7pdCGqlz+OKc4aL1PIA29mmEb/4M5h8oC8OeDI4RioKbfWet
         3rOoj+zgU7WFc+8MRrWlyJP1p4jpZq0rjrDRky6DV6+LIziXaG8G+ZTYCKAqYNEIYFKs
         OfhQBy3dTrUSGo9I8Sdtg/Ij1i81HsO4pgaJHndi3jDLYFfq5CV6sti26pr8XKJ/rKpu
         LoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270273; x=1755875073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp94pLZripqg6DXdOBsKXQLYLF6BHz1zUMlVq+K/gJM=;
        b=b0p/RvVniabirvLOIoD9XLerp2JgHeFFb0zrm7d7AlrBBUffxfGu9I5qsPcGlA5WRz
         ANZxjEqjB463M2C3Qx58RI0W5VqkwAof5DVUDDFUOWOvqMB4psiYjPKndrO299Lcyx2r
         uJy48NmL0hErzdJlNbtBA8of97X4h2bN3ybWYQ91do5sW+LnXgu6dN2XNCYN+dtTygAr
         QqQw3ZtM3XW387P71mFmATOHQkUVk9dW+mvdudBvVI29bIizQo+KuxJukReC41J6Q1Ti
         5UUsB/Rk0itODS8myEp7Fgf/Lbxo+Zc0NLQV2NwUJsdt0r92rbYhVq2iMCQzbnz9giUt
         ymMA==
X-Forwarded-Encrypted: i=1; AJvYcCUEkFcnXKaTLhdgu/jBpF49HvRWs998VsbxyIfbkXWRKtrwEj0wGGqj2rbJ824M/GaVKC+QBhF9pCbTNd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfHga9+D5CInSDLsYA25q86gQBzDTiynCqyx2CZh/zZ4iTo3H
	mBnZamXcFbgJ45cS5Ba/R0EAyVvaR/I07Lt/4EXcjc4UmBn2XR/jtD99nVzGLHPMg9pzjqtamH3
	yyVDl93yhFfVIkj6ggHcG0wdPBSvdFNQG/05MqK2o9g==
X-Gm-Gg: ASbGncvh91wwRO+MB2ui7uKlVV30vpyYqHawWW00n/9uBf8015OPyE7qhwGJ96S+8PZ
	4VixaTp1leuRk0KFhUrxZVJYKoWQyKVJDouXGcT5cMk73DJdwbGbRDIrzCugBepst0+V9oN2a0S
	k30iTUmaEnmf0WGbJnQSl4+93GM5QL3hYof7QpdzLDxlv/7H/n5xmHmjm4NgifN3f9KcKtAx6Jw
	+FZLTU=
X-Google-Smtp-Source: AGHT+IE8Qk6BHMFBf9U3IWk6DXLCzSG3SFLdYC+TdgKQVfcghPqI3c01lgGm49VUwUOg3oEbKVySGxlwZy1bUXGI3iU=
X-Received: by 2002:a05:6512:3f14:b0:553:cede:6a9 with SMTP id
 2adb3069b0e04-55ceebb869amr541797e87.55.1755270272957; Fri, 15 Aug 2025
 08:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815121252.41315-1-ryncsn@gmail.com> <aJ8m42sM1NX_wEE9@casper.infradead.org>
In-Reply-To: <aJ8m42sM1NX_wEE9@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 15 Aug 2025 23:03:56 +0800
X-Gm-Features: Ac12FXxYXlBYCdJIvWrwehc72wOjc3c-8FR_1vIHreuh2_FrYBGdZYJ_kEHzaBM
Message-ID: <CAMgjq7CYzdmt+mJbbkrskiksfvXuhOhLQ72hTnqGhc5nu8uH0g@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: drop usage of folio_index
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Aug 15, 2025 at 08:12:52PM +0800, Kairui Song wrote:
> > +++ b/mm/page-writeback.c
> > @@ -2739,8 +2739,8 @@ void __folio_mark_dirty(struct folio *folio, stru=
ct address_space *mapping,
> >       if (folio->mapping) {   /* Race with truncate? */
> >               WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
> >               folio_account_dirtied(folio, mapping);
> > -             __xa_set_mark(&mapping->i_pages, folio_index(folio),
> > -                             PAGECACHE_TAG_DIRTY);
> > +             __xa_set_mark(&mapping->i_pages, folio->index,
> > +                           PAGECACHE_TAG_DIRTY);
> >       }
> >       xa_unlock_irqrestore(&mapping->i_pages, flags);
> >  }
>
> What about a shmem folio that's been moved to the swap cache?  I used
> folio_index() here because I couldn't prove to my satisfaction that this
> couldn't happen.

I just checked all callers of __folio_mark_dirty:

- block_dirty_folio
    __folio_mark_dirty

- filemap_dirty_folio
    __folio_mark_dirty

For these two, all their caller are from other fs not related to
shmem/swap cache)

- mark_buffer_dirty
    __folio_mark_dirty (mapping is folio->mapping)

- folio_redirty_for_writepage
    filemap_dirty_folio
      __folio_mark_dirty (mapping is folio->mapping)

For these two, __folio_mark_dirty is called with folio->mapping, and
swap cache space is never set to folio->mapping. If the folio is a
swap cache here, folio_index returns its swap cache index, which is
not equal to its index in shmem or any other map, things will go very
wrong.

And, currently both shmem / swap cache uses noop_dirty_folio, so they
should never call into the helper here.

I think I can add below sanity check here, just to clarify things and
for debugging:

/*
 * Shmem writeback relies on swap, and swap writeback
 * is LRU based, not using the dirty mark.
 */
VM_WARN_ON(shmem_mapping(mapping) || folio_test_swapcache(folio))

And maybe we can also have a VM_WARN_ON for `folio->mapping !=3D mapping` h=
ere?

