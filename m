Return-Path: <linux-kernel+bounces-810700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858CB51E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB40517B1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708B25BEE1;
	Wed, 10 Sep 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8nCrXqR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705F329F1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522749; cv=none; b=HkWMr2MZO32REJ1B2nOkwey+ICBFmBe0Mv6FsLJourwEcyCH7weGLIlmxsXWPmUm6KRez/PWuqRJxR0m8v6pR8LMveXt+U68oElQ4LV92+5pIlDKipD/K7dptEw0SAxPzahkwlPv+uOZ6thufpvfJKEJosJnPDOMCBbdDIHk4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522749; c=relaxed/simple;
	bh=3DoVvAkHKzlA55dWX7469yZ7NdqVmb2RDHnFOvW9QuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo1Ab7W30y2I47aDySSpeC83BMOViMA9Y4YH8VDKOvIwUT+6BjGwFKaRVUvDFemhTyYgBJ+6p2cwfuOjzKLU8slxKK3jQ2i69WNlND/27JfNqJfScn91o1+i0IoVaqLSjYA3vG6qZbqIS63eOBcdyjz4sftzYW4JTdSql1M8o6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8nCrXqR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b2337d1bfso5665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757522747; x=1758127547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awcUZJhrSr7vk/FN6/yazFNso0WDtq5kIuzjKcXy7dM=;
        b=x8nCrXqRuFl2oDmuSyJJC7KYbgbAl1Y4vxGzkStTfJtsCG8+0Dcyd6+E/Ve/dKzQAi
         e78INYFUrTEDkEiUfIk94FLYYFqUJMmIcBEQfhGNI/tfIxmrW5pkLUDHF/VvTMBmWpuc
         dkRMrimMdTe6k9XuS6rliBnawRqOWo9EFDqVSLA4hv41PwSRBg82/2vvGlJPNoG8F3rg
         4po8rKj2l4iLFbD6/duExlDnKRfpW1q7TKKZ4KLI4jmAmikJelYHuRMJj5TUcZBY3YFh
         XZRckaKGqN+ApjZ/vJ0KkYbSSif3r5HDHvZf7EPwSeLv5jwdMfw2NcYUYe8xDJPbsQ00
         NfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522747; x=1758127547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awcUZJhrSr7vk/FN6/yazFNso0WDtq5kIuzjKcXy7dM=;
        b=NIXgA0JVXJbPYGo4SzACF306AsbMZePBeklUSVVLdKT3KOoGu+oo8K/tqUEib5JL6n
         Mp2N6/IgeQdl+HuF6kvek0RxP12x3mk9V5x3+0XNed7Pu3Ns16Arm+q6BFjM6Yj5aN2j
         UanQ+YTHK1g0PnZNyIt7tg6q9/K/8USDXew0S2g6na+yJSYUDZYRWVrq5ZyY5PUdQpN5
         ZPTc1L+Gk2g8CnLnUebWMmUs7DjnM6Snw2oDLIO4mQxRmxR2RwApc0LlY46iW3sKD+FF
         WQc9MibphAvZt7/TyZHOYWDlKtETWE/Fl0LDIbkfgec8bZ5RS3oknXMIhYxpFYbQnO32
         efJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBIpglP6H35pOUe+o/lVoXDVut5kgd6q+8p93nq33saO/VnGGTpqT26IYn2OqxqW+5GyNstP9ymf+QFo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUB/IkYalPIGk2xUPsh6a9AWPizUvquhNNTEXCfqCJ6t8oI44r
	6fkVgZplq+pjPrTi0liUYbsXcrUjWX8ke9BXAueTywC+ksSDbom7Ul/y47RdmSnMvMavSf0kWEb
	1m7BomnYSHl41R0rSICaSJEVOUh+86amdmQ6ffIEZ
X-Gm-Gg: ASbGncs1PzZ91i8pVPnEaOxj0joA2Xd3xxtUeUumh+Zva6wNvRBWDZ6eKNnEQgk2DED
	h/ftr37KnaZKZ5DfakcGOVw8uIdLJvA60cghAAMm5N/nPC72bl6bTB9/0yoVT7lRDtYl/q17234
	k6nCbVs3+PrEyxCSSwxhffEZbkwI8wqGN3CTXhbfR/Yrh/lyAti7zA9928sqwqy5HEoiRM7pDI1
	/ImZZwgrySSXBOeaigOCXU1SH1978apeGdD90Lp4a1b
X-Google-Smtp-Source: AGHT+IHYwRpB3J9CuictAomIol7aeL11ghkSN0Km+0mTWaChVAO1NMeXp/i3VR4zUg4scx2cFOoKZZYNX2kyXd2Cqxw=
X-Received: by 2002:a17:902:d50e:b0:248:aa0d:f826 with SMTP id
 d9443c01a7336-25a55af0c4emr5769095ad.6.1757522747028; Wed, 10 Sep 2025
 09:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMACaOmneDrG8_pQ@gentoo.org> <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
 <aMAtqNq55TZEuaKn@gentoo.org>
In-Reply-To: <aMAtqNq55TZEuaKn@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 09:45:35 -0700
X-Gm-Features: Ac12FXy0jWTEx2X8QZ0NZCANfJE8Eof_psH73gdEiZeY_JHSOHjsmrlsDgL6vC0
Message-ID: <CAP-5=fX-GG_pUH+1Eak8dsoTdNh=vRU+00scBxbRt7EhXZosiw@mail.gmail.com>
Subject: Re: Problem with perf report --gtk
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:37=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> On Tue, Sep 09, 2025 at 06:04:42AM -0700, Ian Rogers wrote:
> > On Tue, Sep 9, 2025 at 3:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > Hi Arnaldo, Namhyung,
> > >
> > > Since sometime we have a bug in Gentoo's bugzilla about perf report -=
-gtk not
> > > working=C2=B9: https://bugs.gentoo.org/937869
> > >
> > > I know this feature is not used very much, but I thought I'd report i=
n
> > > any case. The problem is easily reproducible as shown below:
> > >
> > >
> > > $ perf record -a -g -- sleep 1
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> > > $ LD_DEBUG=3Dsymbols perf report --gtk 2>&1 | grep '(fatal)'
> > >     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol =
lookup error: undefined symbol: hashmap_find (fatal)
> > > $ perf report --gtk
> > > GTK browser requested but could not find libperf-gtk.so
> > >
> > > I tried this with perf 6.16, but this bug seems to have been there si=
nce
> > > at least 6.12.
> > >
> > > Please let me know if it's better to file problems at https://bugzill=
a.kernel.org/.
> >
> > Thanks for letting us know Guilherme! I suspect I broke things when
> > trying to fix python things. The code linking libperf-gtk.so is:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n809
> > The hashmap symbols are part of the perf-util library:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/Build?h=3Dperf-tools-next#n197
> > So maybe there needs to be a libbpf -lbpf for your case? Alternatively
> > we may need to reorder the libraries here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n464
> > like:
> > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_=
UTIL)
> > becomes:
> > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPER=
F_UI)
>
> Thank you for the suggestion, but just changing the order of linking or
> linking libbpf doesn't seem to fix the issue. I still see:
>
> $ nm -D libperf-gtk.so | grep hashmap
>                  U hashmap_find
>
> at the end of the build. The function is in util/hashmap.c, so the
> problem might be more involved than just the linking order.

Thanks Guilherme! I was able to reproduce the "nm -D" output. Adding
"-z defs" to the "$(OUTPUT)libperf-gtk.so" also fails for that symbol,
it fails for many more. Even though the symbol is undefined "perf
reprt --gtk" works for me. Attaching gdb I see that the symbol is in
the perf executable itself. I tried the following change:
```
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_=
LIBS)
+       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^)
$(filter %libperf-util.a,$^) $(GTK_LIBS)
```
or
```
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_=
LIBS)
+       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter
%libperf-util.a,$^) $(filter %.o,$^) $(GTK_LIBS)
```
but the nm output shows either the same or more undefined symbols, not less=
.

I'm wondering if perhaps the hashmap_find symbol is being stripped
from the perf executable. Maybe it is an LTO or stripping related
thing?

Thanks,
Ian

