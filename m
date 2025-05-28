Return-Path: <linux-kernel+bounces-665981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019FAC713C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3EB7A93FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C8217663;
	Wed, 28 May 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peuNCJDc"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81A81724
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458707; cv=none; b=h7mJGd6e84/dl1MUjIzejLEUaeyVFKJ+Adc31SatcRzeWjxEuMTWwjUmhxb1DN5iqFapfAmAa7gsoldN5t7Lt8baNVkDXcqLHqGYUv2/VQpv6hSvkUyWiuouYv65YJsrDUtW1HNl31rS4fXXYnl06z8/5VYdMIZnbC362qWUarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458707; c=relaxed/simple;
	bh=gaPL0v8nEKkNSQ8LGZZSy3Ry/HNfytnzxhOkPaPWBXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozPy53jfJTaWqyt9MAM2lPa87N4a15hXxtiEJ0H15t9ZsqwkwdgzNRiSf8igUdJaGipWTYCrY6vSyMcC7qwUGjDH5HyyePxhoNJ3O5WYDDp5YJmJcreT0RtaPUNudjvqhYqvXXGS0fOY2E6QG2Ci4cSVRcrFrTaL4yqysTL1ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peuNCJDc; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dd745f8839so24155ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748458705; x=1749063505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw/8L0cxS+bRy/+krjmRvgo/N9nxwpWPmbf44DvJ4aM=;
        b=peuNCJDc2jYE9PIN4+WTYVEsC+ecofY4yKL1m3TT08bKnXEMuXHTs9agR1PfMe0Knj
         1US6wk0/iQhYH6db62Wl0NfFvXwooryjTOpsv3RXtOwYcRlNgMzeDP/QQRDZNmRe8pR2
         dbBfYP5q7F42TgirLT5GcwvdGHxLtMRqXUQ0f2JraLFBUtON/hcZLxkq4Xg+q4uQ1jSG
         JKPJgwGusr6Guv59iMnLVkOv6zgXyluzygnsJbpLKOiukewZ0d8/CpLgkJpoxWySGbRH
         F/DW2/m+aXXaqHSYRBg1/ymrR7mZgN/RPT4yJ75+xe9QmRGOogFraa3wQUb255BATkDa
         GqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748458705; x=1749063505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw/8L0cxS+bRy/+krjmRvgo/N9nxwpWPmbf44DvJ4aM=;
        b=bKICQE5GBNRVbnwva7NfHWJoufOR2OCc5TWIpZPql0i74KhLnZELLpq9M1N+LHnFNs
         QJ9r16H8/w28qfaSlTRClkm+aePOHefi8ZkICTRr7M00tO4q6E7dSj/ypkL8HHg8oPO3
         8HL5ussT97QP2oLXukDyxMjwkPJG+jMdYJTGJJcY1Ke4U7rz7Wf3Ro9sZNjgbZLJ6ZeA
         MdCZgQyQgwDRo1VpFHOEnyFptTzGptjr7l0XUdOAja3fBwevZ5C8ZUNR1pGr22yDASSC
         PHUskh5oNpRfHhcqVnXFL076eJ6qFWjZvvHJLNOwibhgKtMb6yBmerwygy3AvMMQE1pD
         N5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUJr8Nve8syGke+qFnwP9oYk/wh6FlLbexDWJggbJ38qPMQpXXoO45WPlZNZo3atUTDTAjKMQHvuZNzYhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloCWaY/fgsDooiZJ4b6rOtkf8X20Cff0Q06337MkvBtcTOJYr
	VeryNK/WgwUeiQWSwjq1XAgfnwOGKedosVefOoBm4ztChZ4fRP+BHbbgGDjjmLXXLj9cN/X4pfy
	+ZoYz645cZOPkA8pzeOTis07MJEeMIIoFHrRWcN6D
X-Gm-Gg: ASbGncs0cPI58izuB2E8tgcgtno7feaHqMhYutdrWK6JmNEVf5WFMU72Wn53SWN8tVP
	4RrjYBSL8SR6yu4LVhjAwU+vqEggABstP6f7nxfWRW8MywIeQG75f689oKIaPil4rpyMPGixoAB
	Z1ZnDkAE9RtcFjzeN0f51npuTW6sZ/AJtZ9A14qoGDn25vZPQ7llEwoXlgPgW1r1tNPnOY+1X7
X-Google-Smtp-Source: AGHT+IHL0knIYLnbl7lC08Uit4krwIaZS45MIcoCyeKTOyiEyaLFw9XaXRXYYogwQAp7QTeq+R44jh1JGCIAFaPiSuk=
X-Received: by 2002:a92:cda3:0:b0:3dc:7c30:c6d4 with SMTP id
 e9e14a558f8ab-3dd920f560fmr423955ab.20.1748458704947; Wed, 28 May 2025
 11:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com> <CAP-5=fVy6J+d1aoQwv6TMuybXWAhpeaJOvMmr3-jbsz5ig66kg@mail.gmail.com>
 <aDdaZ0TMA5kwZ-iV@x1>
In-Reply-To: <aDdaZ0TMA5kwZ-iV@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 11:58:13 -0700
X-Gm-Features: AX0GCFvdJ3yReKQ2ZI90oGeBXJrGASy3ES2rkApCGXTixl6CW5MPdiV15BQuNso
Message-ID: <CAP-5=fWk=HFojgZi0eXCuBTc8WLJL1c6vMhow7xHfPmovXpxuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] perf: Default use of build IDs and improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:48=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, May 27, 2025 at 01:48:43PM -0700, Ian Rogers wrote:
> > On Mon, Apr 28, 2025 at 2:34=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Build ID mmap2 events have been available since Linux v5.12 and avoid
> > > certain races. Enable these by default as discussed in:
> > > https://lore.kernel.org/linux-perf-users/CAP-5=3DfXP7jN_QrGUcd55_QH5J=
-Y-FCaJ6=3DNaHVtyx0oyNh8_-Q@mail.gmail.com/
> > >
> > > The dso_id is used to indentify a DSO that may change by being
> > > overwritten. The inode generation isn't present in /proc/pid/maps and
> > > so was already only optionally filled in. With build ID mmap events
> > > the other major, minor and inode varialbes aren't filled in. Change
> > > the dso_id implementation to make optional values explicit, rather
> > > than injecting a dso_id we want to improve it during find operations,
> > > add the buildid to the dso_id for sorting and so that matching fails
> > > when build IDs vary between DSOs.
> > >
> > > Mark the callchain for buildids and not just the sample IP, fixing
> > > missing DSOs.
> > >
> > > Fix sample__for_each_callchain_node to populate the map even when
> > > symbols aren't computed.
> > >
> > > Other minor bits of build_id clean up.
> > >
> > > v3: Ensure the struct build_id is initialized empty prior to use as
> > >     read paths may fail (Namhyung).
> > >
> > > v2: Make marking DSOs still the default even with the defaulted build
> > >     ID mmap. The command line option still disables this to avoid
> > >     regressions. Add callchain patches and jitdump fix.
> >
> > Ping. Thanks,
> > Ian
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$        git am ./v3_20250428_irog=
ers_perf_default_use_of_build_ids_and_improvements.mbx
> Applying: perf callchain: Always populate the addr_location map when addi=
ng IP
> Applying: perf build-id: Reduce size of "size" variable
> Applying: perf build-id: Truncate to avoid overflowing the build_id data
> Applying: perf build-id: Change sprintf functions to snprintf
> Applying: perf build-id: Mark DSO in sample callchains
> Applying: perf build-id: Ensure struct build_id is empty before use
> Applying: perf dso: Move build_id to dso_id
> Applying: perf jitdump: Directly mark the jitdump DSO
> Applying: perf record: Make --buildid-mmap the default
> error: patch failed: tools/perf/builtin-record.c:3349
> error: tools/perf/builtin-record.c: patch does not apply
> Patch failed at 0009 perf record: Make --buildid-mmap the default
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

Thanks, I'll send the rebase in v4. I saw you had a branch on
perf-tools-next.git.

Thanks,
Ian

> - Arnaldo

