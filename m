Return-Path: <linux-kernel+bounces-756756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61515B1B8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33AC7AF802
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E2293B5F;
	Tue,  5 Aug 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsHjzPwW"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B82566E9;
	Tue,  5 Aug 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413004; cv=none; b=oWCS5m2kUGva9VBksM3jMkRVeULGGp5I42SljR04wmmjL1MiGH3ezlfFY+nUAwB9aNhFhqFYmblYra/PwnFv0AXeXi6prQulvg1zrCGSjxmqrGUr07dNr7Rz5RssrdfzrxTC6bqI/osELIfsL7t5Eqy6SXynXbb2Pd2J+kvemqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413004; c=relaxed/simple;
	bh=T399JasSL8DmFMJWo/2MDp8Puq0rW+NQpAQC5f9lM/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMgBGp+SdrpaHvjto8lhYbdT8JMxLtyvL6LmmiRiPHHDOkwXAALvxTxPdqE9aJtnJXoM14rEB8qGrmqbfmCf04XyGHikKUma3sPZscq9F5U+nVM0YFb4UYFThARS22JP6J5COR6znqJOL88pSo0r5wxKyywYmqNYx419fEDANiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsHjzPwW; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-87c4bacb68eso83119639f.3;
        Tue, 05 Aug 2025 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754413002; x=1755017802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JURikxFj1JPMIG8k9K4ujHkActIooq9Dw9bPvRdWPoY=;
        b=LsHjzPwWD/NlNhWhJ934wyelq7evZxueo+r16axEbD18oo0+GE3smzsp7wOtwMPXBJ
         Yfz1gKZYHcs0CThm3VpVyaAdyvMpVJB+BQVYZpoLQR5IDCvDgwXZsKdMIBqpZry7TdMq
         UgqBAAq6cRk0/y3QCZJKyjauXcgs58v0Z6lrLlrbK4eG/7QKJBDU4Xbh3k294xBl+Te2
         HG0tk9NjB/GAbzI7VEv1EylyekjCVtPLweDZV/vxp8ec4hYgS1OsQWbSZjfEp7uNgdAL
         0q1fUvX4iaJ58ny0P5/zJJ7FHEiH92Hh49lbgqIDBLlqwXe8pfDGK5R1gYN6xenRhSQP
         5uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413002; x=1755017802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JURikxFj1JPMIG8k9K4ujHkActIooq9Dw9bPvRdWPoY=;
        b=O6suanPQMMKWATUdYRrVkJGT3S305k4niEduXWgRMe5YB4acnscKv/CgTKvcS7VEdU
         1aEFw54CVzoG+qj13+U55GX+P7ZYt3sWBYbSbmfmTRHbWKMI5kE4W2u5rwhnBeC1ph3/
         ka92tPWWtU3az7tgZV73lNt2pZluYtPLS/ytf0GuWLAJ888JcmcZszEr2Ja/gwS/ZrjC
         WVOYuN68BSpBgThrsHpcmKMSesIc8T6Jvcs1149K1oQ1Rdu8L2sOM7LwD0NvuHnLSBPb
         mLYumSXX9yJe0VdCPM22+f8SaRnHJ+zOHfN7lOEec3Z2n5S32HPqP1sp2+JB46fLlM1a
         snbw==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ8BMDQETk295rMv/GNAn3wtaiDBrwE4HGvZ24w6Wid6KfMh3qP7U9Na4KuW6lzlmf3b9rxcRqYoSWFFb@vger.kernel.org, AJvYcCVvxHxSGwkuXwy5ONJiuXphwj834xskL37QIQFibpm6I1vwP7CIdYy3sjjtvsY/2LsabDHV5RmIiYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZbCdHkNpYbLDdJcf7KgFqr0AVPBrlqQt1fMwaHiCVUpVCgVN
	wXr6rFpqgm6S/iUi6TCmM3zJnBy7Op3p/WlJJkEsgN1aPBmCSFKzZxpUkw/uFsQ8seslHjqoIBt
	ID/PjJyXHOoDXPZxsoi1O7csipVQNTiE=
X-Gm-Gg: ASbGncvEL0A39j6TG4tAS2YwAAKjRtd4GF9Eg5L2M6q0IX1krlT8YHh9YRROKGMLpnQ
	l8wKbdPZL7gDWsUt4hwvCRM1b/6E7zwTcaTN6nUs44FESfyjdc9NzebqE5rrzPDQrvMjcBipg4V
	CvPRawWnHyBvbmqhzNbJqY++ScGbWNj2e5muC2SviLe8oH0p4eldBo8aUcbx90/o2Y+pAzFlkKp
	mbpW6s=
X-Google-Smtp-Source: AGHT+IFKWuYJwFL/TSEMQ2ahjFJ9+k6YIyKX3uyxdbHn8KcO8+Zy6yyb03qRPbsqbjWe3FwKP26ZJ/nzd0auZK37yTY=
X-Received: by 2002:a05:6e02:3f0d:b0:3e3:fdd9:8972 with SMTP id
 e9e14a558f8ab-3e41615d9c0mr242900825ab.11.1754413001753; Tue, 05 Aug 2025
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805002954.1496-1-sj@kernel.org> <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
In-Reply-To: <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Aug 2025 09:56:29 -0700
X-Gm-Features: Ac12FXwKyCyXaDbbCA1d5wEx5xyJYQALLRbD4ssEiJbWg--hw6b-8mhARiZxjN4
Message-ID: <CAKEwX=MVBJ+Okfsob4Z30_5Y4P8c2DWoS1dYN4dF5dgp4+CexA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:47=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.08.25 02:29, SeongJae Park wrote:
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> >
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > the cases, by storing the original content in zpool as-is.
>
> Does this have any effect on the movability of the given page? IOW, does
> page migration etc. still work when we store an ordinary page of an
> shmem/anon folio here?

Good question. This depends on the backend allocator of zswap, but the
only backend allocator remaining (zsmalloc) does implement page
migration.

It's why we insisted on using zpool/zsmalloc to handle the
incompressibility case as well:

https://lore.kernel.org/all/CAKEwX=3DNC65XCkmX1YzivEJtPc+sEJ3pLHUsYhF60QJnk=
_OtpVw@mail.gmail.com/

>
> --
> Cheers,
>
> David / dhildenb
>

