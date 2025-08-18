Return-Path: <linux-kernel+bounces-774547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0193B2B406
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D12F5839AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276927B50C;
	Mon, 18 Aug 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zpw4eu5c"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCD1EB5B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555248; cv=none; b=mEycVcGILXpl5lPknJxbUfOeqIqB1Uaf7WNjD0s4Dhu7zySCgm9+wSqs+ZoMunEbJIvM7FvsfsOL/SMZWJP0zfkzBGli08fSUnBWnryjMGtuRY+l0SNcD3AIfwqfC29mRZPzm4ivJ0uzjEckJ3jQmD1dvZopar32ESH5gq+jcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555248; c=relaxed/simple;
	bh=yuyUWIrHlk726iukrTnuC3m4orYUXuVxTKXClqesZf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFyArk4CW5DS6oy1bupPGskIHzIL+qQrNCKM2K0TfqgoP259An7b4bCrtyieoaoEEaDVLDLRN1ratYde/fDlP8/xZUNRWwGY503PyQiJCVSQXX/ieYtWTMAKEf8X2ZwXIjvGvqormMucCR5eoQ9UbihQqx+cYr5PMep7PazJUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zpw4eu5c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-242d3be6484so28945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555246; x=1756160046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/lJMjzbbXxKNMh4XwHrQEXwJcsfmOC60pL7DbV7z8c=;
        b=Zpw4eu5cKnfdb7wDGlOlu8qNhdVu+9Qwl2HUb1xrUKk9zOunJhv0m7bPMb7h/250ct
         aEqcmpG89z2pHrJ8h67K4MzTnT7rphuJDGGJhn5w8SIYJ1aDr4aqlG+VcKugu9ILsOB/
         eOb9yRoVAuIlu+FpK5FaQqyh+5l44oM7dHCbNmtJ+GBCA8FGoxnIgZS3OQg+F0qvapYA
         pOcOtvJBexzgrbULEogR08a72uUNSvBf1VvhCHLXlYrCIvMFaJMsj6t0xdyj3P7R7Utf
         Wf5nosx/7ZKwbYh7MHOcLS4glQ1U8hSSVbhwxdOUnzD2QXu4OjpQ+1D0CLkEQpkq+mGc
         +2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555246; x=1756160046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/lJMjzbbXxKNMh4XwHrQEXwJcsfmOC60pL7DbV7z8c=;
        b=vnJoMU/r4jKBM5MUbmXrpU7pdJ4YitxusqnrUUbdGcvJxYaQhfVjeuc7li87LD7orU
         1NJZ58BzYNue+G5EFy0gT5EWj9zfVOumIJ+0ptbs7UDDi+dA3eD9pvLyF4Yt0csa8Khz
         b5owYm6RvZGWDkQrEWKxDa6LrTK12Ntjfs35U48LGBeGUeCGqAdmNdhAYaq5EzaLhT/e
         kVIn3YqlA5mDhZheB7dbEpijSnoIe9ADCh4hJdCBCs4bgHAS8VAp15CtfTH0oh6QhmLp
         q32ak6FwhwT/OJCntBduDecfh6DTSNZBGtAnGMLZT7Rco0Mb/o433BpypfLixUhDIGZl
         85zw==
X-Forwarded-Encrypted: i=1; AJvYcCWUYzcDAQaTSi3R1l7xIXvWSWQ+CmZEPmkMSdl2ZLuQKj05aj4dkAhKs/txK3i0E42YsnUNb+dstvIX9uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1Wi0pieHuSGNKsKyw5nhsii/UZITrlwl8esxIrysY+wtoCIu
	me7XXOirac25CLrUeahS6q5c01HsTBA9UypVH9y4t3p0dmZAltD2F3frcMga3SjtKwnHYT0Twet
	SHZy222F59ATJHnPQQHTUpCaWfmbmCK8qWTiZ0TmG
X-Gm-Gg: ASbGncs0U3SEbqFkPyPLd99gmZS1X/c4Vc2kM9qr5LNKSGuhJnL7jBtDBgSS6mBPptd
	Tt7r1CdUXjmUxZUeEJODISA2ypdMFKc5yMKLFxq3Rnnz+2L3r0F4KJhtqZywkDZ1hizLs47THD/
	ZwfNZWTr13oVLQowayUTWfCY2wJXroGCzWCmcpF+YVtQp92wsGZYyTs9iIpYtnIvzmYTsMYBzLz
	1AbSaRjzKrcDQkrPIjM6FDEuSP7yIaoRivNjeLqUTc=
X-Google-Smtp-Source: AGHT+IHJBfKs+GCXKbEvUmxD4IayOe5e9zs6ItzjgZhqF305o8tVymI9Bvrvnxldc31209qIRiFYfYayuBpBxiOMJyE=
X-Received: by 2002:a17:902:e741:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-245e06356b4mr442255ad.5.1755555245623; Mon, 18 Aug 2025
 15:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com> <20250725185202.68671-12-irogers@google.com>
 <CAH0uvojXcxp-GCF6JAcAvATvKjySQ_Wo5ciUfQoPotqA7+7YOA@mail.gmail.com>
In-Reply-To: <CAH0uvojXcxp-GCF6JAcAvATvKjySQ_Wo5ciUfQoPotqA7+7YOA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 15:13:54 -0700
X-Gm-Features: Ac12FXzdYbQlfO06qq4f4hn8X5BJAnv60QyaqRHQLlelOu7qSHbq_7-hL55TCj4
Message-ID: <CAP-5=fU9=UFojCtoKMMLj-dt9NqmWWou588_jN8gVuexMm0k7Q@mail.gmail.com>
Subject: Re: [PATCH v9 11/16] perf ilist: Add new python ilist command
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:05=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Ian,
>
> On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > The perf ilist command is a textual app [1] similar to perf list. In
> > the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
> > the events within it. Selecting an event displays the `perf list`
> > style event information in the top-right pane.
> >
> > When an event is selected it is opened and the counters on each CPU
> > the event is for are periodically read. The bottom of the screen
> > contains a scrollable set of sparklines showing the events in total
> > and on each CPU. Scrolling below the sparklines shows the same data as
> > raw counts. The sparklines are small graphs where the height of the
> > bar is in relation to maximum of the other counts in the graph.
> >
> > By default the counts are read with an interval of 0.1 seconds (10
> > times per second). A -I/--interval command line option allows the
> > interval to be changed. The oldest read counts are dropped when the
> > counts fill the line causing the sparkline to move from right to left.
> >
> > A search box can be pulled up with the 's' key. 'n' and 'p' iterate
> > through the search results. As some PMUs have hundreds of events a 'c'
> > key will collapse the events in the current PMU to make navigating the
> > PMUs easier.
>
> Maybe display sparklines on-demand and when not displayed fill the
> whole window to the left with event names, this should make
> parent-child relation more obvious, and displays as many lines of
> event as the classic 'perf list'.
>
> >
> > [1] https://textual.textualize.io/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/python/ilist.py | 385 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 385 insertions(+)
> >  create mode 100755 tools/perf/python/ilist.py
> >
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > new file mode 100755
> > index 000000000000..22c70a8b31f3
> > --- /dev/null
> > +++ b/tools/perf/python/ilist.py
> > @@ -0,0 +1,385 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +"""Interactive perf list."""
> > +
> > +import argparse
> > +from typing import Any, Dict, Optional, Tuple
> > +import perf
> > +from textual import on
> > +from textual.app import App, ComposeResult
> > +from textual.binding import Binding
> > +from textual.containers import Horizontal, HorizontalGroup, Vertical, =
VerticalScroll
> > +from textual.command import SearchIcon
> > +from textual.screen import ModalScreen
> > +from textual.widgets import Button, Footer, Header, Input, Label, Spar=
kline, Static, Tree
> > +from textual.widgets.tree import TreeNode
> > +
> > +
> > +class ErrorScreen(ModalScreen[bool]):
> > +    """Pop up dialog for errors."""
> > +
> > +    CSS =3D """
> > +    ErrorScreen {
> > +        align: center middle;
> > +    }
> > +    """
> > +
> > +    def __init__(self, error: str):
> > +        self.error =3D error
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        yield Button(f"Error: {self.error}", variant=3D"primary", id=
=3D"error")
> > +
> > +    def on_button_pressed(self, event: Button.Pressed) -> None:
> > +        self.dismiss(True)
> > +
> > +
> > +class SearchScreen(ModalScreen[str]):
> > +    """Pop up dialog for search."""
> > +
> > +    CSS =3D """
> > +    SearchScreen Horizontal {
> > +        align: center middle;
> > +        margin-top: 1;
> > +    }
> > +    SearchScreen Input {
> > +        width: 1fr;
> > +    }
> > +    """
> > +
> > +    def compose(self) -> ComposeResult:
> > +        yield Horizontal(SearchIcon(), Input(placeholder=3D"Event name=
"))
> > +
> > +    def on_input_submitted(self, event: Input.Submitted) -> None:
> > +        """Handle the user pressing Enter in the input field."""
> > +        self.dismiss(event.value)
> > +
> > +
> > +class Counter(HorizontalGroup):
> > +    """Two labels for a CPU and its counter value."""
> > +
> > +    CSS =3D """
> > +    Label {
> > +        gutter: 1;
> > +    }
> > +    """
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label + " ")
> > +        yield Label("0", id=3Df"counter_{label}")
> > +
> > +
> > +class CounterSparkline(HorizontalGroup):
> > +    """A Sparkline for a performance counter."""
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label)
> > +        yield Sparkline([], summary_function=3Dmax, id=3Df"sparkline_{=
label}")
> > +
> > +
> > +class IListApp(App):
> > +    TITLE =3D "Interactive Perf List"
> > +
> > +    BINDINGS =3D [
> > +        Binding(key=3D"s", action=3D"search", description=3D"Search",
> > +                tooltip=3D"Search events and PMUs"),
> > +        Binding(key=3D"n", action=3D"next", description=3D"Next",
> > +                tooltip=3D"Next search result or item"),
> > +        Binding(key=3D"p", action=3D"prev", description=3D"Previous",
> > +                tooltip=3D"Previous search result or item"),
> > +        Binding(key=3D"c", action=3D"collapse", description=3D"Collaps=
e",
> > +                tooltip=3D"Collapse the current PMU"),
> > +        Binding(key=3D"^q", action=3D"quit", description=3D"Quit",
> > +                tooltip=3D"Quit the app"),
>
> Some people use the terminal in vscode, where ^q is occupied, I'd
> imagine for emacs users ^q is entering raw characters, so it doesn't
> work in eterm either, why not just q?

So it is something of a textual thing that ^q is always used as a way
to quit the app:
https://textual.textualize.io/guide/input/#priority-bindings
You can use "^p" to bring up the palette menu  and then select "Quit
the application" too. I'm somewhat agnostic on keystrokes but was try
to follow textual's norm here.

Thanks,
Ian

> Thanks,
> Howard

