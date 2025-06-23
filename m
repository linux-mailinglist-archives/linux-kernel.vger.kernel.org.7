Return-Path: <linux-kernel+bounces-698875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B91AE4B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479713B35C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B32BD01A;
	Mon, 23 Jun 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6D3KXE7"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F28299A8C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696679; cv=none; b=LtTf+6WkrU8kSRFtT+tABkBN2HOGEvPug9NHcobn2qdI8ZGGGoXeuMKFyOeffyrf2pBfkiK3dmwfGedXWNPXowb9hQTqfWhjyxXAHEJQMF39HuPs5chXchmpLm9438DqwZ8IY2/BxaVdvXvZuTTlG/qSy1eQHOiV8KubvyV9+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696679; c=relaxed/simple;
	bh=JS1FG2qENkQ353/qm/Vo5hQuv0HIVwdvuruB5QR/gzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVyjDJc5y3CQYBVoNHOzIzm0GX0HdtBvKvRH08BWDzTfxW7b0DZOn4kBdLBcHmXTmt2iyr91M0RZVsMcrogboISEQvacwnlncOc3KK2gkIkYf7RS3ogQ8W9pGLYLOcIINK3ZfkVuowdjtVqnSrziAOr6uAam9HHpqC09ES2lEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6D3KXE7; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so2935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750696677; x=1751301477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri3+Ap4cqoeDbRAUlcrZd437nBvU+XraT/8Lh4iGeK0=;
        b=B6D3KXE76BIQVNqRZxqzThbRtp42uPjlR5m8BSm5LHuALEPl9XbKFwNYU8vsCVLhb0
         2tmz7/W59rjp5YJublF2o/0rXjl5PNDa2+iIDhvVpM4ZgfET0eGLASPLtrgUpP6XQCtk
         T5AWPvPQqM4bKiiZVcSqIRc4jjJvRECd4W4l7Mo5/V0jZy8jAMdAfLGp8BjADQWXFF8L
         1jIudAeHFR/LIBLuzw+Q7HvJZAvZp9Yk8ekG8A7h7fs8td7/ev5Wleu+iSvTISxokzju
         vVhLM/JFaAgTzNt5pTy+Ts6HuaAS92Z/09SLc9pYWEofCWMhKRywlQhGPAHSc9VX+H5M
         BeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696677; x=1751301477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri3+Ap4cqoeDbRAUlcrZd437nBvU+XraT/8Lh4iGeK0=;
        b=ff/01j3yZVNjILbLB62QTpEvxQNwXvF8sOf00OYVlX/rbX1rX/tBYO3RMH8BL0gaeQ
         4EMe0g7+hUakHnPfMQye6w0UKAXwtFSGJjUeVLgnCkn74NPg2fPuTtFk9SFghq2fah+t
         nYk08isgUGsVKBhoqs+/eqf/K5atuUKHSf5hA0bSuQHoKPepr81V1k+pKVetLB/2FHdA
         V5ZiTKrAGFlk3QlaZYrHNkvUkjFV+0UvLqwRoU+YU8z2T1F4dbkENjFfX7qmLM0tHBVL
         DaQQbCMuOnG8ebkjtrGY7vnvtxbY79ry/5LTbwyLXoEtTsKh5Si6N9ozLbb8gVBnDf63
         wI1A==
X-Forwarded-Encrypted: i=1; AJvYcCXppJxHUBBh7yznEI5XJ0Xx2yPKF2JNf4dSq+89Irvir5cZBDFV4MZ8pzHUkIOiiZfgsCHxcU4q6cz4/1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhufiivM6KHkU4IrYcJKWXmbGJkygPUhxtpCfAO6nFQG3TjdU9
	+9MUZr155pIhmudK3iVPdu6WS7/hPZmt5SPTYjwnsBqH2Gx9GsuXkK7h+Q3YaQ44H1rH1SxGGH3
	jND0KDMr4OvoQ8jyXLvArwh7tSfnkaScNh3RQQ/8u
X-Gm-Gg: ASbGncuaUys5iJ8qe4Q4Ym53iGHm+Dn/x/fusbeZfP/PkSO5BqD4UoZawcxnXOqBtyY
	fcnfxVxh8TegWveTx0x8YZtZxwf/DEjLFBFkkn/2scnplTojviLqXINWBencuNzv+GiZ09xoWeF
	kNMWl+ZY/wiZt6DoBqr7ZaN4yceuy2x68Gx4UMNI2k+3PWLwQgpqTElAu/OnPUWtUB8egQXozr
X-Google-Smtp-Source: AGHT+IGdxgr8P+XalPte1GIMEXQlB83/Ff2yJxb0FI5ykWekoHN3CN4Qry4jy0ooIKs9GE80H/Wjo6lwAjGkNsxfkb4=
X-Received: by 2002:a05:6e02:3c06:b0:3dd:a7f3:a229 with SMTP id
 e9e14a558f8ab-3df0703957amr6032785ab.4.1750696676770; Mon, 23 Jun 2025
 09:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org> <874iwa71mo.fsf@gmail.com> <6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
In-Reply-To: <6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 09:37:44 -0700
X-Gm-Features: AX0GCFvasLURCKicqFzCPNy0SCLEOxEQZz8PHex8H2GTWGdkfSVmQ_yM79QpXxY
Message-ID: <CAP-5=fVoya-X+BBBuVwZQ527WKyGwC8tirk=gj37t2H_BBmwVg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash dialect.
To: James Clark <james.clark@linaro.org>
Cc: Collin Funk <collin.funk1@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:10=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 20/06/2025 6:40 pm, Collin Funk wrote:
> > Hi James,
> >
> > James Clark <james.clark@linaro.org> writes:
> >
> >> If we're enforcing bash style with static analysis shouldn't we also
> >> change all the hashbangs to bash? Recently there have been changes to
> >> change sh to bash in some of the tests so presumably the hard rule for
> >> sh is no more?
> >>
> >> In the past I've had to replace bashisms that didn't work in sh but it
> >> would be nice to have only one language to write tests in. I doubt
> >> anyone running the tests today is running somewhere without bash, or
> >> that changing it will break anything. If anything it will fix more
> >> bashisms that have already been written.
> >>
> >> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
> >> tools/perf/tests
> >
> > That sounds reasonable to me. Writing portable shell is a hassle and if
> > we already assume a working /bin/bash in some places, I don't see a
> > reason not to use it for the others.
> >
> > Regarding this patch, shellcheck will use the file extension or shebang
> > only if it does not find a 'shell' directive in a .shellcheckrc. So tha=
t
> > change will still require this patch.
> >
> > I saw it was used in other places, so I assumed this patch was fine:
> >
> > $ find tools/perf -name Build | xargs grep bash
> > tools/perf/Build:     $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S=
 warning "$<" > $@ || (cat $@ && rm $@ && false)
> > tools/perf/trace/beauty/Build:        $(Q)$(call echo-cmd,test)shellche=
ck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> >
> > Collin
>
> In that case:
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
> And I'll send the bulk hashbang change separately.

I've no objection to switching to using bash globally. It seems
sub-optimal that we've copy-pasted the shellcheck command across many
different Build files and that this patch will cause the
tools/perf/tests/Build one to differ. My preference would be to have a
global definition probably in Makefile.perf, then use it consistently.
Alternative all shellcheck invocations can pass "-s bash" for the sake
of consistency.  Fwiw, I think the 'tools/arch/x86/tools/gen-insn-*'
which is to some extent taken from the kernel's 'arch/x86/tools' is
okay with the change too.

Thanks,
Ian

