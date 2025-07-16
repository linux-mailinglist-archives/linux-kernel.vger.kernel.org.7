Return-Path: <linux-kernel+bounces-733788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F5B078F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED58C16EA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00826E71B;
	Wed, 16 Jul 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RM4IULYd"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC9262FC5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678177; cv=none; b=apebyW6j/nd8RWpjn9jIKChyyXEQuu35GHvhyOzK/S9TDcrcCs4Izrh1A0VUng9DDLh2xiIfyt/HNCnwJ4bUD9IhrZNiWndV7op6tDGImckMCYqjq0IbJcAfI1E/HoESxFEL89rcbZs1hSe02r2VV3gl1y4OyAVpsNFZo2e1uoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678177; c=relaxed/simple;
	bh=H/6LF+iyqlB6WdJMGv+zhODFsSfPB/DLQ2p+t7Osrp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRnre5a7bHcC/bY5FFTDoEkzpcLXWYvmCxpw57aXWZVj15U78gX7PpB7nn7aZzWWotCp4K6Wum86pACQsRdC4Tq8KcJlCoNn3XokRgBUYP5UAnVDVAmudeR5/X+g85zKgQAy6jFNiMm8wStiEP+0EUm5715xmz9/2c2JtRJhD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RM4IULYd; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e283b2d065so227955ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752678175; x=1753282975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XeI4y6AwbVbBI9zJk5QvguTosq6+VRIDRyatWXbmUE=;
        b=RM4IULYdR2L/UlNxCnR7JC6Jy+fjppKVAMmsAFTkLpXIpNF4aav6RT28OfHJAeoIJh
         powK/Np5aOpAxlGmWVLrV2aOvdYsfzWknSI1sT70BGB9adrHXJC/BuOR5s8orydmFblG
         OF95U5H15JI9VoRTimEiXBD4TsmuuyvW3QMG7UuU8in+iQ83Xm0c7NLiVrKf1yx9nJAN
         XJTs8d7KQzm1WcaV2YGKPSqwM5N9tklD1eO11ByNY0kZ0ms5X16I4zqlSdev8NS2YppN
         /hmZqaKUeLFifFeeQLwOHUK016j/M0zPEZI4iHczob6XMNI3kBC9gdfRHIWVPt8JppOf
         g6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678175; x=1753282975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XeI4y6AwbVbBI9zJk5QvguTosq6+VRIDRyatWXbmUE=;
        b=ZP922KqCAJCSV2weGJI/2VzjG02JkI96WSCACJMO+gUbeTuG0f741dmXtFmsZoc+wo
         3l6Z2WuTsD42R+IjTAGcQRZrwJrBUeFcyzRXjsxRycLt5CcLLpO8qJaYE5tZDUIPijcE
         accjTpXgji0Arymgj3WuX2XXr/Usn3sLaNoTD2lWvgH4wZGAbcHGFAcKvt2VWMwxf9pk
         M0eEcns5ILmww6RJpO788mYDJ3dTmjQollauEpypYqsLkQFB3bvh+fpjIxhZpjfcknwD
         ZZ9bjUMFNgugmOJUxg0NEd49krRYDeYHFr/S+5HwKoEE+wYRbAYGCFBGWWpAB50h7nwm
         3BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzQuESDf50ZgawxTwTPVmXqiT8vZhXQX2WXYXA+27oZIZ4gBReFVOE8iHbNTjXUeJMlZUuNjC484WX+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2gHzFubmvmPgMbicnUQVtEfvRjV8F0B42d5hCOVpmcdqcRVF
	+PK+wfXyHf8FT+7cVElBbRTWqH7bJ98k3gaYa/75lhbrdqChozeUrQ2tIDkCUrsvqfG77lsY6rr
	98CRJvLt1YBAdvZkCe5KyH1grYUdbYFDhUMaLEPpb
X-Gm-Gg: ASbGncsJjtpqJN76UxiP8h/dXUlaa+E02sL5HTfT0S9LOkvSLiAfwliAGd8VL9IzLbV
	ZOornLitgokB7g3gxKuByyzAwdve1yOnWgjWgUuLRDX2F2QVUiSiR9IVmfdDDQD0qPB03rvq2+w
	QjKlSKmbSl3BcY32b4ycM9WMxW4PwDgdozE1TqkBxWf6IozSszn0M5FzG+tmtvxqENiSuFU75gd
	ksoXFk5cANZTEM4QS1uAjoON0WDcsfSXw==
X-Google-Smtp-Source: AGHT+IEabtwYOt8rm3YI3C0FkV4NnosV35yDgcOcSkRAsSS0TRnyL8foTBS2OU/EQDy76fqwehyL8IT8hljwpLQJMdI=
X-Received: by 2002:a05:6e02:4503:b0:3e2:865b:6b62 with SMTP id
 e9e14a558f8ab-3e2865b6e64mr1897195ab.1.1752678174505; Wed, 16 Jul 2025
 08:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716050054.14130-1-namhyung@kernel.org>
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 08:02:41 -0700
X-Gm-Features: Ac12FXwIOgTloU0VMFTU3qvt-L3PqdHLEbOTbvhHknx6mvbSQWqnHz5ffR786pY
Message-ID: <CAP-5=fXV2pz9ba-2riHubGsDzh4X3m_vuD=0o+D0vDt56o8hhw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/8] perf annotate: Support --code-with-type on TUI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> The --code-with-type option is to show normal annotate output with type
> information.  It was supported only on --stdio, but this change adds it
> to TUI as well.
>
> v3 changes)
>  * hide stack operation and stack canary by default
>
> v2 changes)
>  * use 'T' key to toggle data type display  (Arnaldo)
>  * display '[Type]' in the title line when it's enabled  (Arnaldo)
>  * show warning when debug info is not available  (Arnaldo)
>  * fix a typo  (Arnaldo)
>
> Actually the command line option sets the default behavior and users can
> change it by pressing 'T' key in the TUI annotate browser.
>
> The code is also available at 'perf/annotate-code-type-tui-v3' branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (8):
>   perf annotate: Rename to __hist_entry__tui_annotate()
>   perf annotate: Remove __annotation_line__write()
>   perf annotate: Pass annotation_print_data to annotation_line__write()
>   perf annotate: Simplify width calculation in annotation_line__write()
>   perf annotate: Add --code-with-type support for TUI
>   perf annotate: Add 'T' hot key to toggle data type display
>   perf annotate: Show warning when debuginfo is not available
>   perf annotate: Hide data-type for stack operation and canary
>
>  tools/perf/Documentation/perf-annotate.txt |   1 -
>  tools/perf/builtin-annotate.c              |   5 -
>  tools/perf/ui/browsers/annotate.c          |  66 +++++++--
>  tools/perf/ui/browsers/hists.c             |   2 +-
>  tools/perf/util/annotate.c                 | 157 ++++++++++++++-------
>  tools/perf/util/annotate.h                 |  27 ++--
>  tools/perf/util/dso.h                      |  11 ++
>  tools/perf/util/hist.h                     |  12 +-
>  8 files changed, 191 insertions(+), 90 deletions(-)
>
> --
> 2.50.0
>

