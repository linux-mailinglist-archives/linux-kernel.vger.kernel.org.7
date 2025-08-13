Return-Path: <linux-kernel+bounces-767597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20086B2568C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CE41B682C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEC30275B;
	Wed, 13 Aug 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd3Y/GqT"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67157302756
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123737; cv=none; b=qL+TkWyWkq6IfTg5lPKq6cuyrHSbAhD15PRKBeGJjIewkxXVzstCvYy1Ql5BL0nV9VnfDV3eN8BriJYKKaV6X4Yc6QQGmx5MYtx3+aTPmUTdVD1m6Y2aTNqBFzNUcdt5SIaltLaWERjyfuLWmxtZaJQT9FEtoiC8fggRmhrwCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123737; c=relaxed/simple;
	bh=L8JinYnL0VDr2NpcSrx00lGYsCzEd3kG2rmko+NI2R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5KuyDTUqHVK1I9UkPuJFdTWHwj/XDjvcGN/sKV1le+9IaOfymcT0uOZkqo3BnI9wNlLeVfSWPregJCZJteutkM1KUiggM2lKoU9vZ2faEbu9DHn+IYV5xqNKWwLBy/PCyIt+UooQwOtpHMXedGZJ2XNdwINupH3/9viSQP5Hf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd3Y/GqT; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50e2e0ce5f3so1204752137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123734; x=1755728534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8JinYnL0VDr2NpcSrx00lGYsCzEd3kG2rmko+NI2R8=;
        b=Xd3Y/GqTFeBOT3OGlAP3LoJ7DSQJnTEgc0eJVVo7BqtUM/IKmgZmoW4oaki49B4FSk
         C/0RzcNYDCSeLeLqL+pK5hRCqqUbfloVSG2BoXtITn3IlaveyeF9ebP27FyWBUnfjN7D
         Ym/RYPehKsBVbSRKYXGWum+b87Q/ugr6E1pNsAWLA1rD3Br5IfzviSVgEUcQv5gKk0lL
         xZIm/Ay+k/0mQtCZNKQFn/FZIFDxnEs9lGLxzG+XXGieAIlTmvZScu9c7Zn6Il8/eYes
         cwtAyDywTic8vKi80peq/JewklsknCO0wdma1P8r7ULs5o4msMtF38KDrS1iYBydHgQS
         +eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123734; x=1755728534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8JinYnL0VDr2NpcSrx00lGYsCzEd3kG2rmko+NI2R8=;
        b=jZrrUM9//Mjm+bBYIh+aHGeSsWlylZSaWjb5ozg9LeiTtZPH4BcCGW/7WQgJOO12rl
         H4enx7eoWd9vHqW1Wv7TWQSmS/Vvq9QdvPVO3Gm1CnB6/Wjg1Ks4xbC9ZfZuHPQFYtn6
         XAPcTFXjqounkmOZB5z3h8yhr/zBzIkj46b/j+cv3h6iTZB4M0mxVHk8ZryDgRoFJSAi
         HTztWyIxIJ75O8PgNMR9akEUyYTS6Bk6TnxpWyMJVqVF2QX7ZG7X8mSGH/uqQsK/2hom
         STUMC0d0m9tW2rAlP1Ppsv/dG7yqDrY8L/qqWtJBIBDCyozundwOj9jH1fqs/3qtLZC2
         KQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxRHHTMFTI+ewxCvgtrzF7jyqoOS18NvCli/2TH4XGB9YqP0p9rUx7BdpuGXPs2h1r3mMdKrZvHzkNHMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WLxmGD/fF8a3EveyV8LyaBpQBgNznmSKZAGnH/f72YKUX/wP
	1RrtWvSOxM/hCdhwHd9ocRyhQDkhkPyq70s4n8cosclxsObl91q6qJKMczyvBLiSBqMrUr5PzEr
	iFNFJ/xw5Qkq0W/q7tRaMx8H8DL/BZi4=
X-Gm-Gg: ASbGncsJ1hkJqCGSBr7GW58TGsdFR51TbsbTu85I+IBYGONNk6fnRTqVEK6sWIlCgD0
	plQ74jX3My+MsLPrLhwgnvGmZKTNv8aEgUx47vvxtf+VtFzvXtWmLGSZVDq6p1aisobHv4tkWFi
	3ZABWrr5RbOh+cDJ+9hpgrvNfX3Mm3XAw33t+RqCvjqE2h/DmCzeFsppYqQdZKv43G+uNmcA/46
	Hv7oDi1gXszKedl4UE=
X-Google-Smtp-Source: AGHT+IEB9dd27CpqZ3tZhuk+dnRMQE0xsKyMYhBLvHiogzgWl40eGKb7DS9F51dOLlxoW3soSY2bjnSiK9f9mYkmwGE=
X-Received: by 2002:a05:6102:688f:b0:4e7:866c:5cd9 with SMTP id
 ada2fe7eead31-51063b913a7mr150333137.11.1755123733925; Wed, 13 Aug 2025
 15:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
 <20250813144737.c3f388313fe13ff44856daf5@linux-foundation.org> <CA+EESO4rMS5ot_wJfWVT+7rDKYgk187xnZJ3NNZsFgUXCbG1yQ@mail.gmail.com>
In-Reply-To: <CA+EESO4rMS5ot_wJfWVT+7rDKYgk187xnZJ3NNZsFgUXCbG1yQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 14 Aug 2025 10:22:02 +1200
X-Gm-Features: Ac12FXyNzZAvcnVYDVRHlxe6ItaT4qyY3OAZCnNUj5DlNTf8sPTsX6OWzQ8e4FQ
Message-ID: <CAGsJ_4w2L6ztZZG9aypa7DVpSEt5vJWPgUuDj7WY5KYtZRFvuQ@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:02=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Wed, Aug 13, 2025 at 2:47=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 13 Aug 2025 12:30:24 -0700 Lokesh Gidra <lokeshgidra@google.com=
> wrote:
> >
> > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is require=
d
> > > for moving present pages. Mitigate this cost by opportunistically
> > > batching present contiguous pages for TLB flushing.
> > >
> > > Without batching, in our testing on an arm64 Android device with UFFD=
 GC,
> > > which uses MOVE ioctl for compaction, we observed that out of the tot=
al
> > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), an=
d
> > > ~20% in vm_normal_folio().
> > >
> > > With batching, the proportion of vm_normal_folio() increases to over
> > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > includes TLB-flush overhead.
> > >
> > > When the GC intensive benchmark, which was used to gather the above
> > > numbers, is run on cuttlefish (qemu android instance on x86_64), the
> > > completion time of the benchmark went down from ~45mins to ~20mins.
> > >
> > > Furthermore, system_server, one of the most performance critical syst=
em
> > > processes on android, saw over 50% reduction in GC compaction time on=
 an
> > > arm64 android device.
> >
> > Were these inefficiencies a regression relative to an earlier kernel?
> No, these inefficiencies existed since MOVE ioctl came into existence.
> IOW, the patch is improving performance, rather than fixing a
> regression.

It would be nice if Lokesh can backport it to older Android common kernel s=
uch
as 6.6, 6.12 etc.

Thanks
Barry

