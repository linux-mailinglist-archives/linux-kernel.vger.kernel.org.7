Return-Path: <linux-kernel+bounces-849377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E24BCFF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 06:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D765C348501
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84B1F5617;
	Sun, 12 Oct 2025 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nwvm8NQP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32921EB9FA
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760243046; cv=none; b=iJS7/xArHSj2RNGl44CJv+kkXxy8XBf3Oglk/0qyJhBA4cz+kxGdCkNSPk/PT2xRF9Y9J2/k9J1qDEkbS8Qf7uQMQZnL6GMORBv+/DhUdrFhCenCT7i1eXiLrcudbGoe3CFr0QLf1ipKqSmh7HUrrjefc0dj7oBwIHPI9COJp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760243046; c=relaxed/simple;
	bh=04BZizl5UtwUt/m67Kt6kTCQKad8YV8N4XAYQtSkgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUJYp8m1cQagC3xCDhoq+H6rOc1TZOMbxwS9W60HycMV6brZvyDNobWDm0qaVJu3O/z9yTk6Wr0K6MMaUTImdC3i8oLTxx7YG+HJegxrTDgvpM5KeuWhAslcb5nwYfMIxIDneI7qtuF19AKMjTE9Jio0dWiPl7LDEkE64+dXJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nwvm8NQP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so53325e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760243042; x=1760847842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31C64dvExcLvA+pvLaqKGJxfqiu7mgCUQLhcnfrebk=;
        b=Nwvm8NQPOXUsUofWy8THU1JSsDsJFE2qAWq8V7p2UOEWosjOYIBN8+ZKBk81uxdGi0
         9Oe+5ehKhTUzxYV0WMb7V7L9u7wtJ4/gj3vyLaYlT+Rdb9TN8tbEJTtoUIKjjiDcHvj/
         Ay046w+WiNv/pBO/9QmwMN5trvzl+Brm+Oshym1DZsxns8u6HVNAqXKyQ/z94lXWt7Jw
         NsIm/ByxjmTkdPYMwNfVWFg9TUg7Z01cwuvDAjUB7zYr00rVSpDWHoXioyUFtx08F5fL
         YEeym0RruIm5gmzGxT2OuK0xTmtrgz0lbCvqvJXRQmQ1WceQN6VqdrrAwXDZXVM3MlFM
         lUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760243042; x=1760847842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q31C64dvExcLvA+pvLaqKGJxfqiu7mgCUQLhcnfrebk=;
        b=iuYP4YIKwrd7lXL0PN+zhWWrSfMyBKuhEJ5urFoWMAebvtk6bKZMGmLYQJ6nmQ+Gff
         GKx9TrE0ZiD8pdSbL0fMvSjmqtVAUR+LRnzj5udwtHSfqDfQetyKV4KVTYrdecUrQf7h
         DKKZ6WbvqclAaBes8PeE9aKqiWKzzBJ6cisc63g66W4S1t+J2+9f/6U9LOeRL+eovdds
         Zw95JiF/CzKHCF3rru1Z3eeAo7DLDWznTFet5YbkW8EYu5lt0AdcmP2CVlWKX1EfnMkI
         3HMBa8iKwQCpmIJyvLEZqhw20cZtkC3oKvHB3XnDEh6oNr/7u0nlJbsKGlXpEYOw3VUf
         FUBA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEx2ETKIcHQy8BAgaf0MlhDo1FngMu0f8MssjwVVq4UuW2bn+3lyX31i/aq657HS7GEMrQgRo5px9gFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4esduN+oLpazp9uevuyzXVXGAqQ3U/q6rt865UQdkdHvXiXP
	2VIB84khECOUZysuSuEQ6datoN7RkeuFEMMQV2LbuDw9JQN1CaPtieTyMdyBcxK3E65AAxcn+60
	Ktl+eoVmrSluV5X5plJuXFynhQ9H42grYkjvu/fBY
X-Gm-Gg: ASbGncs+CEGNUyP4QRRuW8+fsURLFhVVpLMjHYu/PiHqiLLyYqMy3FImdQt+x0hnz+F
	zvY6r0kPrzSYktoV41jp6/x6+A1IJpeaVUQJaSt6ARXhGe/2R3ZS62nYwyOjdY+MrsbUAERsIhQ
	WIrhUKvb4QH3duaKbIVEM9rI38qhxJs/fuY1dr5MVR3t3R6UP7VJFQjJT51DLfAvfy60TKFgXpc
	jJiWW9Zy5Dk3RnqlCyKhhAdlGpDdU4h7QM7FB3lBUC+ThRoMlxhw69XotyY6WRh61ovYAwRpwln
X-Google-Smtp-Source: AGHT+IGvsstjeffMbp1ePFQhQfhyz1w3TBL7Vrpso3NyYJuEzW6XJ+XIKOWxbfWeymVsMQNNGLjg2FcyDIgoAeFr/5c=
X-Received: by 2002:a05:600d:60d2:b0:45f:2e6d:c9ee with SMTP id
 5b1f17b1804b1-46fa9b5c782mr7327035e9.6.1760243041944; Sat, 11 Oct 2025
 21:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com> <20251012013707.ukkczekcmhntrot2@master>
In-Reply-To: <20251012013707.ukkczekcmhntrot2@master>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sat, 11 Oct 2025 21:23:49 -0700
X-Gm-Features: AS18NWDNNlba9cWDLAJfo9IaE8VDGLe4DW6zFS7qQrYqn3KDTM-KUFsGnG9Bxpw
Message-ID: <CACw3F53kD_Toxwvb-WXsfhxLYwKovGoPKVV5z-_r6S77a=hH-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, linmiaohe@huawei.com, tony.luck@intel.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	nao.horiguchi@gmail.com, farrah.chen@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Zaborowski <andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 6:37=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Mon, Sep 29, 2025 at 09:34:12AM +0200, David Hildenbrand wrote:
> >On 28.09.25 05:28, Qiuxu Zhuo wrote:
> [...]
> >
> >Hm, I wonder if we should actually check in try_to_map_unused_to_zeropag=
e()
> >whether the page has the hwpoison flag set. Nothing wrong with scanning
> >non-affected pages.
> >
> >In thp_underused() we should just skip the folio entirely I guess, so ke=
ep
> >it simple.
> >
> >So what about something like this:
> >
> >diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >index 9c38a95e9f091..d4109fd7fa1f2 100644
> >--- a/mm/huge_memory.c
> >+++ b/mm/huge_memory.c
> >@@ -4121,6 +4121,9 @@ static bool thp_underused(struct folio *folio)
> >        if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
> >                return false;
> >+       folio_contain_hwpoisoned_page(folio)
> >+               return false;
> >+
>
> One question.
>
> When hardware detect error, it would immediately trigger memory_failure()=
? Or
> it will wait until the memory is accessed?

Hardware detecting a memory error usually results in a poison
generation event. Kernel expects to receive such poison generation
event from modern platforms, then kicks off memory_failure without any
poison context, e.g. the current process cannot be assumed to be the
"culprit".

>
> >        for (i =3D 0; i < folio_nr_pages(folio); i++) {
> >                kaddr =3D kmap_local_folio(folio, i * PAGE_SIZE);
> >                if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> >diff --git a/mm/migrate.c b/mm/migrate.c
> >index 9e5ef39ce73af..393fc2ffc96e5 100644
> >--- a/mm/migrate.c
> >+++ b/mm/migrate.c
> >@@ -305,8 +305,9 @@ static bool try_to_map_unused_to_zeropage(struct pag=
e_vma_mapped_walk *pvmw,
> >        pte_t newpte;
> >        void *addr;
> >-       if (PageCompound(page))
> >+       if (PageCompound(page) || PageHWPoison(page))
> >                return false;
> >+
> >        VM_BUG_ON_PAGE(!PageAnon(page), page);
> >        VM_BUG_ON_PAGE(!PageLocked(page), page);
> >        VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> >
> >
> >--
> >Cheers
> >
> >David / dhildenb
> >
>
> --
> Wei Yang
> Help you, Help me
>

