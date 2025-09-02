Return-Path: <linux-kernel+bounces-797219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DDAB40D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848CB1B26F14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87F345723;
	Tue,  2 Sep 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyEtmvBe"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4AD341ADA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839899; cv=none; b=LrO6mEyrmwMWc/jEf8uAt5J6SsxOqyETGzm3nL5QOjYls/ywpHWID8Hg4QKMsyzsfoMULaEX9+aaHKJ23G2Iop40G0ocVYeekRbUYvEQVVPQkWQPEv2XYRIKjSGU0buyYoku0Mssjoyzfxg2pBzznEmRscxy8RdiQCNqArbOC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839899; c=relaxed/simple;
	bh=k/iym4cIrJNo4Q5VC/UKquxFkhUODw0zuZKatOzpAZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEEV1xp1s95LvgMjXuzwmZZoF1xr8R39NXXmu0gyUY+Wb+3b5hEdhFFudfhG+Tef93emZnunf3K354NQS/sKxpvmwJ/2dlYKevixU4Otjf8K/yz0nY/biFI51kUeneI3huWxYErJkYb+CtG7zLFsC3V/tBpzgz+q/waFJvzb4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyEtmvBe; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so2186a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756839896; x=1757444696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/iym4cIrJNo4Q5VC/UKquxFkhUODw0zuZKatOzpAZM=;
        b=NyEtmvBeUxSJCebazYIFrX8BzeYIZQvk8lRHAwy5sV+KipJ+KMMlgxCQbTGY/UsorP
         bUMUTPtvqKmhk/wJIe9/3tcVJRTkzFCzNJy0ws6eVy1oPwfMEOe0xTcZ9HYIe+Guh6rK
         EE7k2gRdLy1fg/vWqw9mLtNN0GOcU809iM37eAHMmSW9oa3atL/Sq55XdkUVgWyHyGzT
         M3rMNWAG0PhvU6yZzblslzD1EPO31gG1jkh6A5D2AWViRpxPJEEjTUggPqS8aDFsk3+L
         N8e5NfsfFEuM2xgxvDtYqMtfHEn0fh9PmuMAKJpzSr/KMcKVwTAoDjNocANc3nSsvcRS
         UBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839896; x=1757444696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/iym4cIrJNo4Q5VC/UKquxFkhUODw0zuZKatOzpAZM=;
        b=g1+YjmT565HaXY2Lz7Bihk1osK7O089E9fit4AE81K+QV6fMr6I+ykgaueZQtscCs9
         3SEh2PlTOZ1qNio26vGuNbJ577XhLOr/8l2aLjaDMxc1wdPl5I0mMBwpv81JxfSUFYOo
         +ZlfOtOeoNAYUl03lSlC07kndUWaBqXdAwqJsKcKncAv3zE0kUMqgNJFbI1PSRBgAPyj
         XumoIpN9GzGGLtMnIGzAAZGcHYckUlL8XFBJqBKGTa5JkILA6UT+CKjBS9NTVba1jcNg
         9RGBS9+T2xpg/gF+0Rx8YChuQ343/px+i3r6BLh8ewQdP9HZvEi9ZLOIENu9w9VNNJJ2
         I+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCxnXibj+9fFJH4m0D7tPE/gpVIxq4G9WzFiJfVp/gH7uvAmrZGwxnHo8oKmGRTZca0TvXBubEjvIO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrsXHkVkj0MQ+PKrY4b+lGGcL/tPDgLVybHb0KQvwdTIzCWkr
	7EC5xX729LLbQpPPLMDEI+ZqXBmzBoZF+kG9HGzm0DPMEEEaQ2mFUxc0kexe8v+xADFxPQtPgph
	1MZdSr24K6sI1UeM3XE6xFRD8N0ZqBBJMdVeuTmOu
X-Gm-Gg: ASbGncvheDCya0d55QcGiidFJfEmNse6Ncz1Q305cBGmy5am0XQBCL8cGKIrs2G7ha2
	PxDQCBA5ReiFa64s2pDnctt8Spkvxxs+twZEcPYEOFPvogc+Z4hrtlpiWhYnpWKgftWTV4sDUa+
	5HBi/QNjIc/CkwjYGE14/FqiKltyIMJH88FgJ1zzRCPhpJYBdaBZ/31idz3VMpKUYObsxKTL7zU
	+wy2aUm1K+X6uvTZB7RgFfjBWHPbU4Poml55IawNc4dfMmX2WrL7sI=
X-Google-Smtp-Source: AGHT+IHW1iP2K/0lzfDE5M94W+26Zi+j3C1Zop0Fbmf8Oniuw1MxpSYupR6RBrxTt3Dh2I5ouGxFOfoGIigbrfA8ZRs=
X-Received: by 2002:a05:6402:11d1:b0:61e:c5d1:5d4b with SMTP id
 4fb4d7f45d1cf-61ec5d15e4dmr86086a12.2.1756839896149; Tue, 02 Sep 2025
 12:04:56 -0700 (PDT)
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
 <CA+EESO5FnraOUV=CzcD6t_e086pC7rDZuVv4w2ng==7KacA=Pg@mail.gmail.com> <d61b173f-ed58-4d60-b1a1-b93678371576@redhat.com>
In-Reply-To: <d61b173f-ed58-4d60-b1a1-b93678371576@redhat.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 2 Sep 2025 12:04:44 -0700
X-Gm-Features: Ac12FXwmHm5I2z834Z7P1GGZaAOSsWVEGTGHgu4b-CIknO62BLPfbmr4hrdBY0Y
Message-ID: <CA+EESO42EqQps7C7P1HfMJ07ioRnkktKGXO42VU0fHT_1xvC8A@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 02.09.25 20:59, Lokesh Gidra wrote:
> > On Fri, Aug 29, 2025 at 2:04=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> >>
> >> On Fri, Aug 29, 2025 at 10:42:45AM +0200, David Hildenbrand wrote:
> >>>>>
> >>>>> I do wonder if we can identify this case and handle things differen=
tly.
> >>>>>
> >>>>> Perhaps even saying 'try and get the rmap lock, but if there's "too=
 much"
> >>>>> contention, grab the folio lock.
> >>>>
> >>>> Can you please elaborate what you mean? Where do you mean we can
> >>>> possibly do something like this?
> >>>>
> >>>> UFFD move only works on PageAnonExclusive folios. So, would it help
> >>>> (in terms of avoiding contention) if we were to change the condition=
:
> >>>
> >>> I think we shouldn't be using PAE here. Once could consider using
> >>> folio_maybe_mapped_shared(), and assume contention on the folio lock =
if it
> >>> is maybe mapped shared.
> >>
> >> Interesting!
> >>
> >>>
> >>> But the real question is with whom we would be contending for the fol=
io
> >>> lock.
> >>>
> >>> Is it really other processes mapping that folio? I'm not so sure.
> >>
> >> Yeah, I might go off and do some research myself on this, actually. Na=
il down
> >> wehre this might actually happen.
> >>
> >> Generally I'm softening on this and maybe we're good with the proposed=
 change.
> >>
> >> But still want to be super careful here... :)
> >>
> > Anxiously waiting for your assessment. Fingers crossed :)
>
> I'd suggest you prepare an RFC patch where you neatly summarize all we
> learned so far. :)
>
Sounds good. Will do. Thanks.
> --
> Cheers
>
> David / dhildenb
>

