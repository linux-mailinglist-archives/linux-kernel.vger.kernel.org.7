Return-Path: <linux-kernel+bounces-767599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B796CB25692
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433FE3B296C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560B30275F;
	Wed, 13 Aug 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkjwYuqz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41349302750
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123859; cv=none; b=AHHoKFrAlhkYFClWygmogMGQMb+xPQbWZ9hMuUF4Ix1zvqxdnZRrfw24TSNecUy5BVNriHE7g1q62hy3V0+sjEUxf1aPWZArw8MbUh3mNg05EuUp4aixYgSfigjR+DMu4bb15Z4N+6eM1/CzWuO2SnYZvyLy6cEpUWOm4lJoSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123859; c=relaxed/simple;
	bh=TBuriLyGg6Pmpqe4MLdQ2ZnLG6gcsE5Zsx64IXskAfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCk7O2WW0j3XVifUXjJnijy91e2GF8wWlqHQ2BaOh6LLMTUtnHnALj6e4ufiOxn0ooxzL/kvRPM0//9uHizXtBDDm12HlwUoWycu+pcnCMAU7IbZ/uev87euw62ztV1++n+MBaT/cKQGVfROvylD2JzVas41gEir6PkygjD8SY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkjwYuqz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso4216a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755123856; x=1755728656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBuriLyGg6Pmpqe4MLdQ2ZnLG6gcsE5Zsx64IXskAfQ=;
        b=IkjwYuqznH54h7aO1lOR/tw9jpotdnmjORlkObfhRsTiy9c7G4OE23qLx8/k7BBkNC
         SCHnt/Jn8OTwa1VYzeB30BE1xdwMPvz+eBr1rmrnq3jaVM8mfnp4NoJdzHCJQ5EH4DZn
         aBIx65nBZmBUD8WusnfNGE3PTAdnWrcNOtYYSgYezpQWCy5VtMP23Cdk9e39XOuSBy/+
         7SDHphGdjl2gJDW2nSHaYaREA5rgHYOTF9IDdn2xPJfbUC1CR/JWryYihUe4J4hHeCgw
         aLbw/ZTOMmcRkjfY9sNPzVEYjOx4UzA+xTtR3zjeIm75pJOo2uaSOkCYkGVy6BLc0oJW
         dVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123856; x=1755728656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBuriLyGg6Pmpqe4MLdQ2ZnLG6gcsE5Zsx64IXskAfQ=;
        b=ReVvAQAyI1S41i6pNVvPVscEvgvt6NU5vJYCtLxtiZ3/RZvCX3cd/FQjWAfTmT6M/9
         UoqogyzyZtBdkB5E5bvwjxsYvGqVVh4iVswIeiNGUcahm3ZlaxB3I3Khjg6P6yBtecqT
         cbGQZJKXNP+Z18xq2BCGIuJSli/tWRFV8lEMX/L5a/BSIfk3xR6r9CFl3rfB2qjZ9a26
         yblft+gdp5/FwZZJ1RY0OAy+LfOAwI8T4PHN+ClFAqM7P56UrhikRi570U6sA5mP7qNH
         uyvH/OspKqfaH2tIsHwQVIiQTSInYayGHj5NiMKGCpxDZhwO/UguMjnYHIjuA2wPTD5d
         pLuA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4VKQeryhuQlFLr1M7GHe0tY1ESvLrNuAAFiKuEet5l1Lsk0jF3QAcxo9nmv9ClKxW097H0N2++TadeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ftYb6JLaOSAbXx3cGGAKv0Lw+aGzTFGIKCnpNtR6AZZbZUf7
	HC64gh6pxy3TDW1ENJZB4Gsl/9OKGkagluN3mHuQLqr+tQHlaZ9HCMqOubybYgQviMEBjQGHXT3
	RbW3ddSbKR8KTQfUwKRE/X/Z88FeESJ0EzzmkZ5Br
X-Gm-Gg: ASbGncsP6s+xhn4xN2KFez0dh7g3o/+dvhSxFceDfsWX/6PRkuFcK9j+A11zDaKggk5
	Ku5FD/jk6J/VSnOY2yGUY6/zJTs87I2bNfAtD6npnR9P+Kavh7zpYKSgwbwDtTrWURQ/QqCy/5G
	X37B1EY09uoi6hiSI+AHL6zH99aFDN4/bN0S7GJR1VcMxCDH8xXhg9/OFn/Lb5ecMG10TI2y0QZ
	rulbLj4ZiIPwIaFXxH+oPT/oyLAxHgwc8MNKQ==
X-Google-Smtp-Source: AGHT+IENbqcS2gMv7BJVYfjz2GEXbyOWPRtRgNavUBGaPR2MOtKnq13f86SWbkCCn2Shm0q7D0JeWY4FXMixuTM+h6I=
X-Received: by 2002:a05:6402:438f:b0:618:8373:30f0 with SMTP id
 4fb4d7f45d1cf-6188c4b0c88mr38852a12.2.1755123856394; Wed, 13 Aug 2025
 15:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
 <20250813144737.c3f388313fe13ff44856daf5@linux-foundation.org>
 <CA+EESO4rMS5ot_wJfWVT+7rDKYgk187xnZJ3NNZsFgUXCbG1yQ@mail.gmail.com> <CAGsJ_4w2L6ztZZG9aypa7DVpSEt5vJWPgUuDj7WY5KYtZRFvuQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4w2L6ztZZG9aypa7DVpSEt5vJWPgUuDj7WY5KYtZRFvuQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 13 Aug 2025 15:24:05 -0700
X-Gm-Features: Ac12FXyAW-Ox_idR1AP2BNQ5--lukWi7vwsrQTQsXefehnnzmNrhmxlWy8pHtSo
Message-ID: <CA+EESO5vjGHvCkUQPgfm5HZi=WyJD0nPMbK7vwNWsrxNqzBpzg@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 3:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Aug 14, 2025 at 10:02=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Wed, Aug 13, 2025 at 2:47=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Wed, 13 Aug 2025 12:30:24 -0700 Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
> > >
> > > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is requi=
red
> > > > for moving present pages. Mitigate this cost by opportunistically
> > > > batching present contiguous pages for TLB flushing.
> > > >
> > > > Without batching, in our testing on an arm64 Android device with UF=
FD GC,
> > > > which uses MOVE ioctl for compaction, we observed that out of the t=
otal
> > > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), =
and
> > > > ~20% in vm_normal_folio().
> > > >
> > > > With batching, the proportion of vm_normal_folio() increases to ove=
r
> > > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > > includes TLB-flush overhead.
> > > >
> > > > When the GC intensive benchmark, which was used to gather the above
> > > > numbers, is run on cuttlefish (qemu android instance on x86_64), th=
e
> > > > completion time of the benchmark went down from ~45mins to ~20mins.
> > > >
> > > > Furthermore, system_server, one of the most performance critical sy=
stem
> > > > processes on android, saw over 50% reduction in GC compaction time =
on an
> > > > arm64 android device.
> > >
> > > Were these inefficiencies a regression relative to an earlier kernel?
> > No, these inefficiencies existed since MOVE ioctl came into existence.
> > IOW, the patch is improving performance, rather than fixing a
> > regression.
>
> It would be nice if Lokesh can backport it to older Android common kernel=
 such
> as 6.6, 6.12 etc.
I plan to do that after a couple of weeks of soak time :-)
>
> Thanks
> Barry

