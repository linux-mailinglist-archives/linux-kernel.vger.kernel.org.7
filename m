Return-Path: <linux-kernel+bounces-758428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2FB1CF02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451535614FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9822AE7A;
	Wed,  6 Aug 2025 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m13tuVNp"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B58219A79
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754518326; cv=none; b=UD8hWNMCgysUd6pxgMsJn2JOyu3BZBiAUgP5abBG0Sps0GGGsW2LtSgFMku8srYvQtvWNYTlCEYLeZiHllXi5HIN28usnHnK5M8eEHJ5Ccb8JdOZdTeiewjHnAYNR7A4ATVvQmDEyhjZACvINC/wffbkijwDqvEY3vvZuMDhJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754518326; c=relaxed/simple;
	bh=+Ox9zRYolOnHtwT3PUcx67G94JDxZP2kTORZOpqtIMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTFYb8TIPKrWDNMaW97D6oglvFe5e5gUDb9WNWD3VzijcWbHL742SGfXgK6tLqdY4ZutwZIwS0lcLvwkLc+Y504vw+oXp9Rm14hjShk7nG8Yrlka88+6X14Cdhyu0U1Dz5ibAj1+pkO6b6hV3pxRXHjGDbT0milCxCJ74rDJ7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m13tuVNp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso137591cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754518324; x=1755123124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FiWvRl7qqXkQNDBUdlT6ON4d+ifpSBHPrNy6qGGUHk=;
        b=m13tuVNp4wL1iulVqvCbGipbqXBm1HmZaOy1EHfHjwqeZi9iB1ZHen8t0QolNfnkOT
         6OdckBM4mOrUl74rxJaf6FdypPqz/fGc7Cc+4B4aAtF77sDoYTwDEdd1IvqW+UBNn9uX
         nXKPN4n47WHj5ixzbdtUzeUCADkilBzZLDvGocZ76KWZcEJZIUMgebPMdKfy0lVWcrD8
         YJvrdRVk6z3rCZ23x6EyaooEErvXPe8hhXmmZIl6rH+E4wJN0JuDfeZqg3t5GrpxvqYm
         +pxiqb5pXYtUEy3DDhWAP49rO4ra1D0d9hY+dP2NLrZMULloSleudOVGLTMiaQVjWBWq
         50xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754518324; x=1755123124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FiWvRl7qqXkQNDBUdlT6ON4d+ifpSBHPrNy6qGGUHk=;
        b=hgmHCkfMAZkuXcxYN1BGaTdgooc+k1A0/R7F7/KTEWracedUz04/Cdkdn9Fd7r4g/H
         ujKKn4P8Sif6PE+J08xTx6K+cg6ca+TK19NqV+G2w8GuXpUV0b2hYpIB9GGsQxb+vwWO
         i73Q4JAy5+i8za4SgX9erwqF1ly0K+RHnHDn1hMclWurU53baAu2F7vzyemXYJyAWs89
         tI4VHZ8UaIiCh+d5Fc0EqSOkji49Eq9E0egkpjxhvDPa3KpSTQ0coxPeB1uZZAMrhIpm
         16l3PljqIAWumcnIPMV5q8JSUrT7CoabwcqMr3ZVzLU4kgquLx0GNMhoR45UjGbEYw2V
         8xaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHuOvs9/9N328fZc1Un44dnEMTc56TVBRcCv7M1qD+hwnJH6aCArZXNLzM10EuqOPLfg5cGLNfIzEVPZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqYL+OwiSwP7Pe9c7InjSXLpNgXionJ92ojzpo0zcCt9n+QDv
	TsVnDJMB5qfSEWdCjWOFSh2PPS4V2hjZczqubSZC15vIAojJ+cw6/uA2KzlSGsB7Vj+kDMXx7Iq
	iq20+Z9avwC25TotvGBji77ySs3Dj9yY7trSaNmUV
X-Gm-Gg: ASbGnctrYJFJvMr3NPSc0jxxaUy8gHlcy5CU5SHHx8j6tXSeRnTQv2SOcUlck9l9Mhu
	aAbTT/uloI5Dvayw0fg6K7uc3Wpe5jmNILXzJqQ5cqxZ1bnwTh3mgqvwhdyJWPEk44PI7B3PH6+
	ep4abdcFe52NJgGuzNU7eTppDKIWtZ1VDqznmuFT6F3LNqJSz/N0PlYm/pSMExw7k/gh5UPLMyf
	7Gn/axLfv2LXo0t
X-Google-Smtp-Source: AGHT+IE58c8RrLqWVAWSA89xnMLA58Wcvs22tjEvVXSzyBbScgVGdTpLFJhTGLaInSIHVWyChoGSfE8AA7WkFHFQ4CE=
X-Received: by 2002:ac8:5a42:0:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4b0a372b51dmr520041cf.9.1754518323701; Wed, 06 Aug 2025
 15:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154015.769024-1-surenb@google.com> <aJOJI-YZ0TTxEzV9@x1.local>
 <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com>
 <aJOaXPhFry_LTlfI@x1.local> <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
In-Reply-To: <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 15:11:52 -0700
X-Gm-Features: Ac12FXwLQmNTg-sw4wFVsfQATsP_wqhDZus6Cjpz3UpRH3cR-tLTiKJsZP0WDZ0
Message-ID: <CAJuCfpFhcfK4E_Q8QMqG51GOMrJPehddeU4pt3uo1qNfVU5__w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:21=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 6, 2025 at 11:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Aug 06, 2025 at 10:09:30AM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Aug 6, 2025 at 9:56=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES an=
d it
> > > >
> > > > The migration entry can appear with/without ALLOW_SRC_HOLES, right?=
  Maybe
> > > > drop this line?
> > >
> > > Yes, you are right. I'll update.
> > >
> > > >
> > > > If we need another repost, the subject can further be tailored to m=
ention
> > > > migration entry too rather than non-present.  IMHO that's clearer o=
n
> > > > explaining the issue this patch is fixing (e.g. a valid transhuge T=
HP can
> > > > also have present bit cleared).
> > > >
> > > > > encounters a non-present PMD (migration entry), it proceeds with =
folio
> > > > > access even though the folio is not present. Add the missing chec=
k and
> > > >
> > > > IMHO "... even though folio is not present" is pretty vague.  Maybe
> > > > "... even though it's a swap entry"?  Fundamentally it's because of=
 the
> > > > different layouts of normal THP v.s. a swap entry, hence pmd_folio(=
) should
> > > > not be used on top of swap entries.
> > >
> > > Well, technically a migration entry is a non_swap_entry(), so calling
> > > migration entries "swap entries" is confusing to me. Any better
> > > wording we can use or do you think that's ok?
> >
> > The more general definition of "swap entry" should follow what swp_entr=
y_t
> > is defined, where, for example, is_migration_entry() itself takes
> > swp_entry_t as input.  So it should be fine, but I agree it's indeed
> > confusing.
> >
> > If we want to make it clearer, IMHO we could rename non_swap_entry()
> > instead to is_swapfile_entry() / is_real_swap_entry() / ... but that ca=
n be
> > discussed separately.  Here, if we want to make it super accurate, we c=
ould
> > also use "swp_entry_t" instead of "swap entry", that'll be 100% accurat=
e.
>
> Ok, that I think is our best option. I'll post an update shortly.

Posted at https://lore.kernel.org/all/20250806220022.926763-1-surenb@google=
.com/
Thanks!


> Thanks!
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >

