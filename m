Return-Path: <linux-kernel+bounces-841762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED5BB82ED
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8574C43AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E660264F8A;
	Fri,  3 Oct 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rScLPhSR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F725785B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526755; cv=none; b=CqRdXDW/A/Wn6Gk4URfglUoWt3ZLQeAQ97WzKqVEn4qkt1IjBYaAKKhbchq8MotvDPo6/5NIuLHKJrCp81clL/lHyd2tG7J29EnN8FbjTLS9QvurQ4CA8Pd1uWHKqE/O4xbMmV4dZOm1paYldW9TYbNCCjRomFtQVfzZgsVlHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526755; c=relaxed/simple;
	bh=57pLtc5rAmyyS/wQyFbPOMpl7eLN+4lrTPENsmASPAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Zn2xvOdQNM4Xoivw/MaaDL9ZICVqG3ddVzVfsYF5HEyDqSg50l/xuHA1r2f6NnNxahlF/F+C9gPtiPaG5+ioFYSZfhWl62defuQ+hwCm8FwXdkqwVhZXPTsdC+LY4DeKDr5d79vd8eyHuEkrUXfIZXdZpqz5djCuONM422HBedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rScLPhSR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2681645b7b6so21535ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759526753; x=1760131553; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4VT0ieB0jgGlNp2juozLPJwl8qLI4qMKjBM+yWFQxQ=;
        b=rScLPhSRt8Je1BfTMWncRATd1mIxxhPm3BnUpMz+E7JJuSVDYj3Mgd7ilFDhdmUEvv
         +ZdXNsJ0oSuy26SlCFouBgshxfHZLU1h1usbjs+TAQvX+kFuJCGpkMqzWZFLAzIoku5J
         usml5UmJ7FMtBSe2KSB/pNm1stLQvHvYhr3OJLwC2jBTVD0iUJ+cTIuueTdbURaWDQNK
         csAuRN/5TJS4uzJiPD78tmCTY83TcDwTBHf/i4i/Y5U8BaPzNcTUET36lIbJmMFbC8g9
         cLGYI+P+kdYLbYxjcU/aDePvHYXkwRIvyTewTeqbxMeJPOGRnIuTdkLQ+LLOwupRNjhg
         KL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759526753; x=1760131553;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4VT0ieB0jgGlNp2juozLPJwl8qLI4qMKjBM+yWFQxQ=;
        b=eT5QqM+6gm1V5Bwyqg0/LUufL5VWkY47Ieg+ByhEVoNH9A/JLETUfTexLuJyEbkz2E
         zUSSNVhcKJl0L28lsTGmy8WXd7uyURih/SLaEcFDy8YELIugKRc0bhliZFHQewCr6nwy
         qFHCwkcrGGwje43bnTs4f3icrrMhcAIQiJPLZVmozHC+OAdpsGAPUaAlxWEL4ih50TAk
         MhoZ9PDgobDFrEEPisnhK/o/1bZ6Gk4BJhoodY8AeMhnmr8BIaj5Y8GE7FGGQG+3AAuX
         opImB9RzdU3aTtcuo0IPbLqg9IXBsjBrV4dg6zVgjPO0Ij2TtDpCakm6zpmTOv2Uakr+
         Up+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZrfzQS958i8PzhtuQRL8m39757vCGPsQnW9a1uBbRkSwncsTI+ONjwAG38PYmSYj7BW79gTiZls5sf64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgsDZUkt1UeMg8xR8y4ALcxO6rzMrQijgibD707ENV1Idu8R1
	LUAAXLW+Nx0TYgzO8RV7gd52svkqAr2vL6dqME6unstkJeTOsWtkw24A3LDpbQIJcy1bI/WJWvn
	d7MiegjKkPWh/oL2iZoyvBtKqU3r+eo2NbiiNmMRv
X-Gm-Gg: ASbGnct2OxQyvas93rq75zVSsvl6yyetTrtM8S6N2NMSTUTPOT2GuwREkePTlhpKVN7
	A0rQbu7ZEqhYUJg0a/eq2BhgPEWmfa8958hUhFhLh/9+e+EgXTzkkX63oGRal1Q5G3Pbvxl2vUb
	+bfmQbYyQhOjRISxq0vqqsroNNyo+D70zUU+LqlHDcf9kQfUPSwBO6S/1pPdp5KIbH38wR71Xrt
	wUS7duTDIqPn7YbewKMrG83f6HlvBlsbEnbVnM=
X-Google-Smtp-Source: AGHT+IEvKCaC7A5Ml4aKvLTF08Kw++5135k1T1k0ilEsn2gPqKa3Flguj4PYlUgxI0sPVl1oU0SnhaiVDHYI6+mcv8I=
X-Received: by 2002:a17:903:37c3:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-28ea80b6848mr1092635ad.3.1759526752412; Fri, 03 Oct 2025
 14:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905042643.1937122-1-irogers@google.com> <CAP-5=fUSuh+hKVg_1owmzPAZka3DGmhr6FzN__n_Cb2XUET3=A@mail.gmail.com>
In-Reply-To: <CAP-5=fUSuh+hKVg_1owmzPAZka3DGmhr6FzN__n_Cb2XUET3=A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Oct 2025 14:25:39 -0700
X-Gm-Features: AS18NWDQKFSXIfHLXPhA-wfzscMqdhhpbLO_pw2mKIg7osIY2y1fwdMgsm4-1E4
Message-ID: <CAP-5=fUOpiJypozewCSi6Avg2pQnjmvNcFMM5iUsbTR1P_47zQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix parsing of >30kb event strings
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:05=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Sep 4, 2025 at 9:26=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Metrics may generate many particularly uncore event references. The
> > resulting event string may then be >32kb. The parse events lex is
> > using "%option reject" which stores backtracking state in a buffer
> > sized at roughtly 30kb. If the event string is larger than this then a
> > buffer overflow and typically a crash happens.
> >
> > The need for "%option reject" was for BPF events which were removed in
> > commit 3d6dfae88917 ("perf parse-events: Remove BPF event
> > support"). As "%option reject" is both a memory and performance cost
> > let's remove it and fix the parsing case for event strings being over
> > ~30kb.
> >
> > Whilst cleaning up "%option reject" make the header files accurately
> > reflect functions used in the code and tidy up not requiring yywrap.
> >
> > Measuring on the "PMU JSON event tests" a modest reduction of 0.41%
> > user time and 0.27% max resident size was observed. More importantly
> > this change fixes parsing large metrics and event strings.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping. I think this may have gotten lost in noise about things like
> hardware json and the python metrics. It is a small change, bug fix
> and performance win. It can land independently of anything else. PTAL.

It'd be nice to land this for the v6.18 pull. I don't think it has any
visible implications and just makes stuff better.

Thanks,
Ian


> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/parse-events.l | 17 +++--------------
> >  1 file changed, 3 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 2034590eb789..1eaa8dbc26d8 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -5,16 +5,14 @@
> >  %option stack
> >  %option bison-locations
> >  %option yylineno
> > -%option reject
> > +%option noyywrap
> >
> >  %{
> >  #include <errno.h>
> > -#include <sys/types.h>
> > -#include <sys/stat.h>
> > -#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> >  #include "parse-events.h"
> >  #include "parse-events-bison.h"
> > -#include "evsel.h"
> >
> >  char *parse_events_get_text(yyscan_t yyscanner);
> >  YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
> > @@ -222,10 +220,6 @@ do {                                              =
         \
> >         yycolumn +=3D yyleng;                             \
> >  } while (0);
> >
> > -#define USER_REJECT            \
> > -       yycolumn -=3D yyleng;     \
> > -       REJECT
> > -
> >  %}
> >
> >  %x mem
> > @@ -423,8 +417,3 @@ r{num_raw_hex}              { return str(yyscanner,=
 PE_RAW); }
> >  .                      { }
> >
> >  %%
> > -
> > -int parse_events_wrap(void *scanner __maybe_unused)
> > -{
> > -       return 1;
> > -}
> > --
> > 2.51.0.355.g5224444f11-goog
> >

