Return-Path: <linux-kernel+bounces-797213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97FB40D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE87A9101
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E432BE048;
	Tue,  2 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJjycS6W"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA133CEB4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839579; cv=none; b=Lfm+eMsZOvlt/EoaBqyzossK7i8uViUAk+taDv/856KQF/HwTWLudT413VoUcn6LpBua0lNyBYVA7QqlCiRGQeDm5icnRUSmoznJqFcFa4bWbsz3hH9Ba/fwR7mdLpdQ7z0UPz0elkv7cFqZtEtvs3BzdWFBVlL+/Loi4q+PyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839579; c=relaxed/simple;
	bh=PO6uBrgZrvwvFD9Y2iG++L1mUkkDAtsEspEBPhAeKaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMx6zd13Y9W63rAYShzso9JCPQWuUhpTLvCx4aYhj0SWAVBYLLrm8UshNV2bZQrud9sZaXeD0BeK4ZUzElg5BwnbPHIej+AfCVjnslustrVJ/SoUOikBUk6MOuuMD3+cHRe0MlX145S4ztUCpRYs22ukh6nCeFx50n1LOOam3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJjycS6W; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61ed395ba46so3185a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756839575; x=1757444375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO6uBrgZrvwvFD9Y2iG++L1mUkkDAtsEspEBPhAeKaA=;
        b=qJjycS6WLz4o8TB+vQMIUGxvP9Hu1iD4Fd3HTkxhho4WQcvjHWlBE7wlm0Gtw9GtyM
         kKjnvePDZt7X8BU08R11VqE7h3Z+2Bch0823lVdwCu9O/JZBEvodU/enmTJt6s4K+Wsx
         l0HTKHfg22f2gGD3q2Vsd/diYIOIcUZovgYlQLMUzM4YfYOn0cf3W+vym7K+UvP4g73I
         DtlWPBmJ5b8l9WREdJgR63KGx+zCse8bdIKshLMJTv8Luu6reb+SGXHEcF7Zs04sDWDz
         oQ5UxqorLCzDAlZl3jtof50bUjMY30TtPErvuFXZGpZvgqW9Lez1qbeTFQyEmKI3CVqg
         oWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839575; x=1757444375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO6uBrgZrvwvFD9Y2iG++L1mUkkDAtsEspEBPhAeKaA=;
        b=RVGiAAJAiksQF8Ctq5h4DiALQSQZdsP1s+moRSyAoR28zWxYqHMEepcKRYZoZJKDdr
         iS6uB3Nc0BnGy+h8mEspWh7nbXRsXmxl8W7w+p+qgKbp6zzGX/VUGVq7raIx0y/ts+/R
         svVZIEcYMTnHQ8Nzy2opiewEWcOc8MBLboEbRdhwbeHK+ewXMnX757UNP2PS9HrtbpnH
         ayVdaq/mU2upy8AB5ohcfU67cLKBZdsPK0lTWdB00lpJQiMWJhikaARNxrI0FVgAQogJ
         xvwkL82MFr3Ly2oj+oKu2gZ3EqfrBf1+Lanf8Aur/hxVW6gVwxsqs2EnXb8YsEqVoggf
         tjCA==
X-Forwarded-Encrypted: i=1; AJvYcCXptGVHdTGlmy8vPhPoNTT+EgeD5O+4bwjKimCEEZZgx7zGDp/mik4QzMxaMMUwF+NqD+eIG5xDaj9l/rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOh2Byo2IKPM+F1FzMxIygeRYlgjkiu503wtdxlEyR3tQT5H92
	qSMoAepY9NyPiQ1ZVTdphPJl78osH12PiX7Jodsd5AQmfkoOl2uACkZUU0smGEQMcrODR41iUYW
	cOQBFUy2d3FdVoFtABN4G/dG/+u8IjkXtGDtSkrEt
X-Gm-Gg: ASbGnctcDF2uHytLyf1TZbiw96VUR21ZL/wwBB6CR+smfEHlsPzW9wEEtY4Dqj75pcT
	YQ+iShAb8wtcgnRFWzonWq/nfFkcJI4+ps5Gs1m8h3/UOJ/+UdWM5Fryj4X8rO0hTzjDqsDCSW0
	UuZIQ9+bnhZgAukBrygV0aDrTmZK532PfCLtBIebt0lgVxMLuh+el7eS0Q0Q6GKUNvhNb5k9HgE
	hj12lQOoecMbWONKs+lLPATJ1AtbQX8YYXODdVma050
X-Google-Smtp-Source: AGHT+IFjfqil45P3xLPeX6vA2o1kgdJcuyVtGZnjUPClXaZBLSK1c50QtoACsnaFusJcVUUuKEVNu0qgZ5/GvOSAzPo=
X-Received: by 2002:a05:6402:2397:b0:61c:1dbc:67a with SMTP id
 4fb4d7f45d1cf-61d21f059e4mr215637a12.3.1756839575381; Tue, 02 Sep 2025
 11:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com> <a0350dd8-748b-41d5-899e-1505bd2b2e80@lucifer.local>
 <CA+EESO73TRAcMWeo_aXkLM+0rT5nt1cxyvf+Ye3Xp9kqxL5=6Q@mail.gmail.com>
 <f5cb68a7-19eb-40aa-95f7-51fd004a3f8e@redhat.com> <e6b12ef9-1808-45a3-9d64-5c7fd1904b5b@lucifer.local>
In-Reply-To: <e6b12ef9-1808-45a3-9d64-5c7fd1904b5b@lucifer.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 2 Sep 2025 11:59:23 -0700
X-Gm-Features: Ac12FXyu_JdCq7fD2tQ0dRu3q6Is8GLBBBqLQORpRzSbl-I9vnpCRz2PF9AzEko
Message-ID: <CA+EESO5FnraOUV=CzcD6t_e086pC7rDZuVv4w2ng==7KacA=Pg@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 29, 2025 at 10:42:45AM +0200, David Hildenbrand wrote:
> > > >
> > > > I do wonder if we can identify this case and handle things differen=
tly.
> > > >
> > > > Perhaps even saying 'try and get the rmap lock, but if there's "too=
 much"
> > > > contention, grab the folio lock.
> > >
> > > Can you please elaborate what you mean? Where do you mean we can
> > > possibly do something like this?
> > >
> > > UFFD move only works on PageAnonExclusive folios. So, would it help
> > > (in terms of avoiding contention) if we were to change the condition:
> >
> > I think we shouldn't be using PAE here. Once could consider using
> > folio_maybe_mapped_shared(), and assume contention on the folio lock if=
 it
> > is maybe mapped shared.
>
> Interesting!
>
> >
> > But the real question is with whom we would be contending for the folio
> > lock.
> >
> > Is it really other processes mapping that folio? I'm not so sure.
>
> Yeah, I might go off and do some research myself on this, actually. Nail =
down
> wehre this might actually happen.
>
> Generally I'm softening on this and maybe we're good with the proposed ch=
ange.
>
> But still want to be super careful here... :)
>
Anxiously waiting for your assessment. Fingers crossed :)
> >
> > --
> > Cheers
> >
> > David / dhildenb
> >
>
> Cheers, Lorenzo

