Return-Path: <linux-kernel+bounces-868921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D5C06811
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708273B354D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B767277CA4;
	Fri, 24 Oct 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7H5HoEZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CE313539
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312415; cv=none; b=oTF5QH1UnHnUBhaLXA7MHd6EKipSsV4zZZ0z7xGrj43JiGfXoFyQNxs0pbPTWe4C0F/sS2LiTOh8LZYCHUAAoqysX6qfcJLGof2AoZb5RcaEVRc7Ucq/pFIwNzpK1xoOo7KT/HLSIP/ZnEPwaRg4VAk0LmnHHywzcSM+7Kj5hyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312415; c=relaxed/simple;
	bh=3m+14o8JFv3FlZ8WW5Z3ffx9H795C94Lo0VBZ8GcJhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIGEF5OY+R3jOaYSkDRpMuQuUM91Fv6X1cyNllqPigd6YZRq+V9hlrkSa/SkhQZGDuDd/1wMZbBcOjxgDQJAhly2R70D5jyJkT/iLuGA1w/qkXeK006v0PqSK30xKmgB8B4+6K4E7KfPnysjg9ciyVazPnkxMv4EIABt9DleCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7H5HoEZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so286936166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312411; x=1761917211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvz7WfloUlP5Ojd6e1kroOswZjlfxgMGTQOUIPJaae8=;
        b=Q7H5HoEZtR+eK0Zc+B1nojN33LinQjTgRiQa7lYQ8RexOXINwosBAQUF7yEwufBPzl
         a7d89WFnY0CrIsFovLk3O1h7rzdXTPFqEBY449A6GahcQpq8MpmlmNOFtw8fgZCaZ1dP
         qWmckNczxZL25Yg3navl72S6gFvEYIEBflrqBHf70lftEUFdTF2I/o1T0GXIFW0jpRQz
         e4P2nkWxrlxJoXZbpWNxlZa9qlBw2jOBxy7n0u1QB1mSvmMHvg7Mb2RODaeKgMI9T7qJ
         YFIMum6rr2cDnUbNXJdV5pVFhtorCThFmOzd6TLqKFimycT92+CUfpGUTbCWQ9MHgc57
         vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312411; x=1761917211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvz7WfloUlP5Ojd6e1kroOswZjlfxgMGTQOUIPJaae8=;
        b=GuU0BFuojfL29+RCg6pyjsttruYFF8B2vcwb5BoYHOMXdgb2ZX7+SJyIlZyzxJ4Z+G
         zecbRjHE+v9XG+ylf8fdOKoHHX/GT7V/MXtZzSlVMeU99YF0uZbryyTwvxmgI3Pfkruq
         yexGgBcXwTWcGhoQyByuXIFsd6ls0JdpZRnho9PeTZktq8YhM5EAd6dyquv2zChS8Tk9
         JdGgPLdM6dejOfE8kTcS4SvRbGF7dpDP6y3Zg/DXFKxi5XykDa4gL0KRQV1+zkLzOW0Q
         uCngerfwiv1PX8WthBnMYTiI1z9CLs24QDwD1RpcuNI+GI3H0so6XwaTXKRdISwvil5W
         cngQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7OoKW3fwUJwzhmksc+XoknyG1C8S1GEbS/gCeBNagHq3kLqieQof6B30j54Ps3A78Dlxfs/PpieP4Lew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0BU5MC3pCK88+xMI2kinyiFG789ZVuEkk/oIYgJwtU6e6gzW
	OtCJe89D86VWD9VYJYsPkbohl0wteN4kOtRSC4Sbb3pm2l+RXRjjQXdQ/ZPm2y1rwoNsB+eGSJR
	Z1GVtKGdBsbPlqbmNNsSE0xE2+dnFjHk=
X-Gm-Gg: ASbGncvtCwSj74sX2WkftOukmrviY2V3fLygYiMB0+qAk/S5CcMYjOK/mkKIuuXeqPt
	TLHq+RhTm2zN8elup62WY+yk8Eo2WHTWyPUEGi+6rlmrnpVn9GhivmPMPZNB2nKjGpuZYf+nM2x
	1cJtTq20L/ALsHy0Eu50tbr9QW7dHTNCZtvIqZs2yjcmSZvNiSBGNcuzTyiU5YVKWZfeVAvvCGp
	ZjdtstPto9why9t+fG5/KSDlHLBXYNMnLcQQA31VVSpU5/Qhi06rBYNNZ2t
X-Google-Smtp-Source: AGHT+IFjjTuBXN9RNE17o1HXG/pWOF0aA/eLredLJlFjVbvcwj/jjil+eqIqI4xViBT203RxM5WtOZyiRCx27mJLRPQ=
X-Received: by 2002:a17:906:7303:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b6471f3c28emr3320963966b.22.1761312411112; Fri, 24 Oct 2025
 06:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
 <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
In-Reply-To: <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 21:26:14 +0800
X-Gm-Features: AWmQ_bluve24JSPZEEhNHyJvd6ofuK_JksD9uA6QkIIpRPsvLrDnJBnZTAjSPIs
Message-ID: <CAMgjq7DuJp_zyW4NLHPoA8iDYC+2PaVZT4XzETV-okVUPLNzSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:18=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Oct 24, 2025 at 02:00:38AM +0800, Kairui Song wrote:
> > A few cleanups and a bugfix that are either suitable after the swap
> > table phase I or found during code review.
> >
> > Patch 1 is a bugfix and needs to be included in the stable branch,
> > the rest have no behavior change.
> >
> > ---
> > Changes in v2:
> > - Update commit message for patch 1, it's a sub-optimal fix and a bette=
r
> >   fix can be done later. [ Chris Li ]
> > - Fix a lock balance issue in patch 1. [ YoungJun Park ]
> > - Add a trivial cleanup patch to remove an unused argument,
> >   no behavior change.
> > - Update kernel doc.
> > - Fix minor issue with commit message [ Nhat Pham ]
> > - Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-=
table-p1-v1-0-74860ef8ba74@tencent.com
> >
> > ---
> > Kairui Song (5):
> >       mm, swap: do not perform synchronous discard during allocation
>
> FYI For some reason this commit is not present on lore, see [0]
>
> [0]: https://lore.kernel.org/all/20251024-swap-clean-after-swap-table-p1-=
v2-0-a709469052e7@tencent.com/

Thanks for letting me know, strangely, it is here:
https://lkml.kernel.org/r/20251024-swap-clean-after-swap-table-p1-v2-1-c5b0=
e1092927@tencent.com

But the In-reply-to id is wrong. I'm using b4 and somehow patch 1 was
blocked by gmail's SMTP so I had to try to resend patch 1 again,
something went wrong with that part. I'll try to find out the problem
and avoid that from happening again.

I'm seeing that patch 1 is being merged into mm tree just fine, I
guess that should be OK.

If anyone is reading the threads, this url above should be helpful.

