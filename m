Return-Path: <linux-kernel+bounces-851844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EABD76BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859E7189EAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B0299948;
	Tue, 14 Oct 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCnEZdpe"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427226F291
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419700; cv=none; b=WDP41VrA+C4vgQ2AMvNsfuvBf+eAPPfklggKgpaS37XSSJoQQjRjGQ4j1/6L7oMnDjaGouvsQZxgaqaVu5oqIsi/3OQY/TraYNYDp2lp37sMgs87mAan/FCnw2Fe2+5y9fvybi0pwUi1LJBvqj+cOjdw3H5ryPT/lIW6rRxE23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419700; c=relaxed/simple;
	bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOqwKo2SnvHDkCPU+5161c8KWka8//mH6UO/9kTBITjsSTg1wkHNgqq2XSbEfCeKOtl55uR94byDp1TruQPxHvLVTt/oBxN+AJYIN2md5dBfUkeen8vv/n7n/PACZ7BJ7Hada0NskHgfxw8u7N9zYN70pkCy9IYBkea1RP5LyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCnEZdpe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-375eff817a3so48086791fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419697; x=1761024497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=;
        b=QCnEZdpeWi4P2JJ0IzkJ7nloJjJ8ZyOvBbP88rv3P7b7BmejRx4PT78P9LGMV0O0ih
         nQ5fwX8DHxJHVB0fvKKvZADtaePRSreK7RD1R8pXeuwdQ0Vc4gq/yZ9A33wr6r0P3ivx
         +OP31lYfk3Nbi4bDBB7JlN5JMHykT/NqF/t6B+6Orkdc5HBQpr80Q30lG+n6EHnE/mi1
         CNvBe3Sa3eqyyYz+aKg45HIkUDhvOdJuvgV78iyt7zEXsVr0Lkbz4YovXDMXgofCJ3RQ
         JqXSs2mjTSjnKTXMtzYOvlAfzDoAPXBfDeuW4CkM5CUzib4E6JhCmfo2P7qrvU4NPDZE
         HJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419697; x=1761024497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptPHbzU60TAIm8mnnxk2ahAv+Cxa99UUvkWsQlBP2xU=;
        b=LwdMd6XadUl7Rcs4CMggAe7Q8ktQYuK6Ug9mc0D9RoNjwXENg7Pi5kaZSx7+tikW65
         jkfAX1p5q6KDKWOW7LL0dlqzrUDZtqgFbJRSN6tBLbt7j1x6QA5S6srG9OeNFfHNVZ+3
         KT1t55oADuZhM5DUjhSRLQciYygRtae5brJ91oDaGydTnLq22JoWnYRk+ydofxk1G3j5
         iqbZZJ3KIDCafdTwpDywM/3o7xJ2JDa8VqmLPXG+2Qh5QWHGGJrERzK3B7iSOW2eMe4A
         cnujjZQ5Pvf1tA4tH0Lb9FwklTRjxlftxwRq8GoS6qBu0S8f/xv2EBw1LmJnCO4P4aQb
         USbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZa0Rq6Ov+jIjvPbf0+nezb9y3H1j2Ic+hTJBcjQ9INbUn1LtRbvfx/XpLP+L0N6v+suZQgPhRcs9lExU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjeEjv9l1e1JoRIAchnpUqDb78lF87suw9+2Is1qSILyaP4lK
	tty9UgQEswsWQ1+SEjz9HGLI8Qso728b0ZUPxOEUJqImIlBSJL7AgdygUBZe1jJGC6wv0xFmMdZ
	o1Ks+KZz+anKsTYlokUAxST9TTo1WVMs=
X-Gm-Gg: ASbGncvkW5RTjK5iWAeWZbgyXptcBGNwOQr7sxGwCESQ2kWt3rpTL1brjICBlnVus8e
	5tDl4XXQchIpwKvM/eDChi9sSwq8xX7H4pQf9YfKgXysJhOnUiFlMEN8JxthM0Z8aeCgu//T7IO
	1zd9sWlFIMSgANFPqf/VpPjl5u/kE59eLF9YAddLNhqo3pBJFwQNU66Ht3DkumJsqaX5ayC322C
	kkH3u19Ejq99y9i/ZbIREc52A==
X-Google-Smtp-Source: AGHT+IGdjfNUCN4gunItNKInWlyxyXS9VWDbMBSmmBL39oiGRrNBNxoCrVW6HmO4TTj1J7zFqIEW6QQm2vhVXKpWfzQ=
X-Received: by 2002:a2e:bcc7:0:b0:372:950f:2aff with SMTP id
 38308e7fff4ca-37609e0ed4emr64933311fa.27.1760419696692; Mon, 13 Oct 2025
 22:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv> <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv> <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
 <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
In-Reply-To: <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 14 Oct 2025 10:27:59 +0500
X-Gm-Features: AS18NWDpoAnK8X4S74wzUC_xmUwiiptVaXx4Fi_Po4Ht89THf-aVMKFaVW0-Q-g
Message-ID: <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:21=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> > On Wed, Sep 24, 2025 at 5:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > > Since the Sabyrzhan's patches are already in mm-stable (and I assum=
e
> > > > will be merged during the next merge window), just rebase your chan=
ges
> > > > on top.
> > >
> > > That's fine, I will rebase.
> > >
> > > >
> > > > But also note that Sabyrzhan is planning to move out the
> > > > kasan_enabled() checks into include/linux/kasan.h (which is a clean=
-up
> > > > I would have also asked you to do with the kasan=3Doff patches), so
> > > > maybe you should sync up with him wrt these changes.
> > >
> > > Hi Sabyrzhan,
> > >
> > > What's your thought? You want to do the cleanup after my rebasing on
> > > your merged patches or you prefer to do it ahead of time? Please let =
me
> > > know so that I can adjust my posting accordingly. Thanks.
> > >
> >
> > Hello,
> >
> > I can make all necessary changes only next week. Currently, traveling.
> > I will send the fix-up patch Andrey has described somewhere next week.
> > Please let me know if it's ok.
>
> Please take it easy, today is Thursday, I will wait for your clean up
> patch next week and post. I can do some preparation work for rebasing on
> your merged patches. Thanks.

Hello,

Just heads up that I've already sent cleanup patches [1] and
Andrew has merged them into mm-new tree.
Hopefully, one week's delay wasn't a problem.

[1] https://lore.kernel.org/all/20251009155403.1379150-1-snovitoll@gmail.co=
m/

