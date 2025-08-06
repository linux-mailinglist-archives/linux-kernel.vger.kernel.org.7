Return-Path: <linux-kernel+bounces-757922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A0B1C867
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92037B3136
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF86291880;
	Wed,  6 Aug 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk9ZeFMv"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E829B8C6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492779; cv=none; b=g4TvH+fNW/wu46kGioFBGyzDDZdSfme33BmG4CjeiiFqW5gz8a3sF85Rz2hqvcWR2cIJN7BznZZyJBIwAhDXQ7ete3xokFHwR/QGvhw/kbX64Rv3eSRwvpA17t1JRnnc/1YzwNX8n248VmrqkjeD7gk3QVYe7fyxefTfskCQJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492779; c=relaxed/simple;
	bh=1etKNrE0vlDHhfFeOKLaDNQ1jROjCc/S5wBeTrc5uNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/vamdNh61qM2lO8ObFH0fQGKsb4pUFmHN4q7SOfTiCPSuA3EDonW09WyGFfQoiazGNencx94QuwE237nhVHY0vO+puIO21Tbuh4vSfRJnTt6D8m0cobvUl6aWGffIJFBuidF5PMA5bJrP/ONe/y3+b3kap9Pd8mABefDQ1lGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uk9ZeFMv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso474711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754492777; x=1755097577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMkdALPxV5bI1ddOoCXO/TX3xqYimqA7Ocq/kfBYHfw=;
        b=uk9ZeFMvMsilObK61ab9Jl1Io8oULrrCTX5SI8y2qbYsiy7dx8pt1PMOynd6lcyT+2
         XXHdMl12Of+NgByIo7DiJYGyhtm9tltnTy3AlI8tNupflqzAL9gYJXKJNhU1GJeKk8Ta
         /5Pvird8Syf4Z8K559jplU13anj4ebXW/YPeulnN5OdAsZdyhZ0MMhDajNCCwzZFJRGJ
         PMRViLOFhY1INFWJgDVwv8PkokNoV1e5TZtXmSC2O0h9AbhFhlRDuOrgMyz8OTuI8dUi
         F5n1F2tmtCabGGnPQVDZqdKOwwjm4qSySHocwNROKH6Itxp9Fq3Wp/xMiv5I1ZuRrePy
         gRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492777; x=1755097577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMkdALPxV5bI1ddOoCXO/TX3xqYimqA7Ocq/kfBYHfw=;
        b=px7TiC3Uz8FZhE9Ie7spSNYlrQeDrWw+dowTZFIa4YywACIAiRFzkxcnB4TbWp2vzd
         iwCx2TNJ/oAVKo8x237XwNI2PkVnoZZDaNtnWeKa3HGLQ7VKgxJvimNUhTKlzPY7RcfQ
         wCAxLb1s8LKvW53OuswiJJYSWu7+6CxL4Hrzez81VSbeAsz3jE3XECt+Ad2KU+1fNX1R
         04BUxj/XVFCuepGF1I4wolM6ZqNCCuckcV9RWCiGE0r/nSQVKoitSt0P4BHiIvxKjXoB
         7F9KlPXIw8L61wg6N/BQwNRA4KQIQYywykfD+KaRYxii3xVw0Rac4mp4T0haE86aIYth
         x3bg==
X-Forwarded-Encrypted: i=1; AJvYcCXrRp4gfpBzz+oLtGUepnueMqwiZuZ78jOTAA9PBX0M23ZBkMIZvd6fpMY4z1e79dZQn46vi/YpX4CehbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfILCTgMca3xV6i2q8pF8eDVTJKKu1F6h/yI9eLibZUAGFGDi
	mJzytTUHy5F8vmxrmoqQ8Jib3SDoEn+ZbfNnGlq/RLKXCK3pzcxxW++oRNHvwc3TqcI5+ZuaMSz
	H1eof3LSLxX09NMR2iPPM+8XWaF0eM0zFuFkgp4jv
X-Gm-Gg: ASbGncuDjTTkirhZJEpoDEshZFfB39Rqvbzm5ef+D0p/Sku3BQVkMjKDAimjzscsbIE
	RhRDVb2FlDjGH1K18bKF044UC+uGtMR4BNYjw1zb0yZ0nWre5gLQUk532GepXM8v2YF7l0XZxlq
	Mfblv+458iWDNSiIy69El4aF16TVuciSNSE1tf0kaRPNBg64usQTNsoLlYXH4WXogLBpq8T/BUY
	LXNH5f9dmNvwGmAkHezFJQI6X/BWYLnSHk9TA==
X-Google-Smtp-Source: AGHT+IFxjgJYfLtCzxTqC2qd/VGsYO0V9QbHxfH3kUKXYt+WP9H5eIIUksOBWWr2ADiUXznJbKHJFYhIUDbkwryBSWk=
X-Received: by 2002:a05:622a:38b:b0:4b0:8318:a95 with SMTP id
 d75a77b69052e-4b0904dbb54mr5571461cf.8.1754492776656; Wed, 06 Aug 2025
 08:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local> <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local> <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
 <aJIXlN-ZD_soWdP0@x1.local> <CAJuCfpFzP_W8i8pwL+-Uv-n+2LixgFrzqn2HsY_h-1kbP=g3JQ@mail.gmail.com>
 <CAJuCfpFEf92gTR+Jw+1wcCcT0fEt-SP193NHzpyxVXJA=VAwng@mail.gmail.com>
 <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com> <aJKkjEYmeq93w35-@x1.local>
In-Reply-To: <aJKkjEYmeq93w35-@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 08:06:04 -0700
X-Gm-Features: Ac12FXyjlXEiW5mf5x6iYKFmYX_DWMhNB6rnZ5RUsIFipgSWRnXVMmPjiayC93I
Message-ID: <CAJuCfpGpEOaKdqpqTpfbw1cdHEEWhiu6KRFQFWaM-AKODiDFcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:41=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Aug 05, 2025 at 04:41:18PM -0700, Suren Baghdasaryan wrote:
> > Ok, I let the reproducer run for half a day and it did not hit this
> > case, so I must have done something wrong during my initial
> > investigation. Sorry for the confusion. I could have sworn that I saw
> > this case but now it just does not happen.
>
> I'm wildly guessing you might have hit the numa balancing bug I mentioned=
,
> that might explain what you mentioned previously on the testing results.
> It might just be tricky to reproduce:
>
>   - We'll need a valid THP (pmd) first in the MOVE source region
>
>   - THP needs to be selected by numa balancing for a check (marking
>     prot_none)
>
>   - (before any further access..) UFFDIO_MOVE needs to happen on top tryi=
ng
>     to move the whole THP being marked as prot_none.
>
> AFAICT, task_numa_work() is the only place that can mark the THP, and whe=
n
> it happens, should see change_huge_pmd(cp_flags=3DMM_CP_PROT_NUMA) and th=
en
> returns with HPAGE_PMD_NR.
>
> [sorry I am still pretty occupied with other things.  I can try to reprod=
uce
>  together with you after I get more time back]
>
> > With migration entry being the only case that leads to that
> > pmd_folio(), the only check we need to add is the "if
> > (pmd_present(*src_pmd))" before pmd_folio(). Would you like me to
> > check anything else or should I go ahead and post that fix?
>
> We could fix the migration entry first, then if any of us can reproduce t=
he
> above numa balancing issue then it can be a 2nd patch on top.
>
> After all, so far we didn't yet prove it, either some unreproduceable tes=
t,
> or pure code analysis.  Meanwhile it might also be cleaner if we have one
> patch fix one issue, rather than having one patch fix two bugs.
>
> What do you think?

Agree, that seems reasonable. I'll post the new fix today.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>

