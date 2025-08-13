Return-Path: <linux-kernel+bounces-767138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D9B24F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1545F7A1F81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC5286417;
	Wed, 13 Aug 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjfjjjTU"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991326E6FE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102123; cv=none; b=dl7UNCRa8Oxar6+GLySaKEmsvx9oiUiFQoL5efiOnj/g7OHzfJOSdpiK0Q2stirrkA87FaxNvby+dBuj8eCJ0jnsbcu9cg97AmycgNoFxLg48ynjle6kXhS+4P9yGgoeTGCiU1BLrlqhInE701RpNOtqaGh3WmZ4jUSmsBL8CvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102123; c=relaxed/simple;
	bh=FCtBWS7G7QSfGS21fNpnoOvL2XzwY20HFRw2SobIDWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOcm/qplsmwfK0w0gA21+RM3+JYIw0BYS7lbkBlnqb+sNdrCPUX8qR359oEXdb0sDSA6I9V22wQow+VjbUhRh8wT7pjCk36mWqNsCEB9EfCB2kd3LKBH85JVU2C0728FslbHwY9vWx24+uoBrz0FZ1MoAfiHeJAINyrxKmNvujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjfjjjTU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0bf04716aso343931cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755102119; x=1755706919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QinmQQFXomCWAaJH8CKN0I0il8aAmJNtIteVH369jE=;
        b=hjfjjjTUXhEx74ETrH26k53+U9I45rcNMOqNAot3nLQdCc1C2ebG1u60Q+j6AVYxEq
         o4fYN+V+2rbZdn7xM16NFlWL/195RPaTKYyzUCzECK9Xr15ZzHcNcK19Q4QvWi52F3Qk
         JPToC2+Cd2MXhKkfpR1aY787na+MLSz2IY84myNPxQ3NFUJ2+473c9K+R0H7LW5e8lFD
         pTAqL3H+NJJp44WOfNLejv2vPhhFXZbWe2h8j8HccQKO86dEZQWGoVcXlMM13bW4gOl+
         luwYpmPJ0X6RVk7zCqJL0bP9FFxweSVyg+KChB90SFf812c/J9C0rrvsSB4aviuzVF5R
         3sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102119; x=1755706919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QinmQQFXomCWAaJH8CKN0I0il8aAmJNtIteVH369jE=;
        b=n87+r2/d+Q3igh2pzbSNAFx3dCdR2D1y+hfzPzeXm9bPvkFrOYKsIA8NSVTLAG03Ph
         oMfkpIZ5nyU8KSQOOMY05p9Q2CGngWzQ8Nj0KAKxWpmc/5cqGlYGzvV66r670wgmJhZp
         v7N9nGVkfNiHkAMLd8cjvoHR3a595/g3qCSyZQcCiDbLZPjCq7twVeM+/FXx/NKmJlRE
         OLFnpM2nC/iNkcguY7kpRcD4iQq/xPOPm5SJ7JV4OTV0Sq700u65OsYhcCEPJkCcbg3C
         Mm+O3LeUCnWg/v66x0/pm+41Y1p+se4Dky3RlvC85kf71Yi2SzNmzf0p8v68gHvEMwfc
         9G7w==
X-Forwarded-Encrypted: i=1; AJvYcCUjqBO5xrBUm8ul4bsXGe/g00HrpqhSv4Wz8yX4WPX9oj2g4nb5LDxL6tpO8t9r1h4qnwzLgGgdHb7ciCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclF9ZyiUDlbV39wwK6EtbLwAXzC0KRNStqmJASxwVbH35qiz5
	x43t5HEkAeauSEDbdbltSDQUoqxf+wDa5baLACLzgNVaOzVWHKwJU1An3qKPm1O3UnSv+kXQvxz
	++bnQi+N0uXVrotAk1wwX6n6pNThmatDmkBRAyS2D
X-Gm-Gg: ASbGnctTW0JJKR08HZPN6hpceiRec1wA4ronp7h3XVJuK7YPkbGZKNTWYeV60QdcwDK
	F6lI/lUPVejkGoDymB3euibd4vC6UnHyYodwtjMzvsV+zET13z32tfa5PW183T32OqLW9H5Adu0
	SOo1uMwXj6c1SYK8/sL2ft5LuAQ8gPpfT347bTFaSzcGSEgmgvGBuN1plPAXwiblL50VouAs4ae
	1z9UI3uy0nOPL9+2cCr4ER36FKq4uhSEpOoCrgyFOTGDc1V0sTs4EfA
X-Google-Smtp-Source: AGHT+IGGAjAQlJAs/6fOMgvF3DcusMKTQOaQbjz9ZrFKQ1wo0Qm87n6yg3dhd+rsJGWsOVYpbpOk1wnlAHiH0dZ6fyQ=
X-Received: by 2002:ac8:7f92:0:b0:4b0:83a3:9bac with SMTP id
 d75a77b69052e-4b0fdbc7fc6mr3865131cf.17.1755102118775; Wed, 13 Aug 2025
 09:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com> <20250808152850.2580887-2-surenb@google.com>
 <7d3b4b0c-f905-4622-95a8-e4d076dc71d4@lucifer.local>
In-Reply-To: <7d3b4b0c-f905-4622-95a8-e4d076dc71d4@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Aug 2025 16:21:47 +0000
X-Gm-Features: Ac12FXycH4KgQhHe2VKUKoPE6OrMOaMbLer1JM-gxVxQlhmfWUD7HLZEVfP2gtE
Message-ID: <CAJuCfpH+Mg7P--sP7LmhhUgGSU0AwmoJLYGyvft5fPC0Mz1P6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma
 is concurrently modified
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:39=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 08, 2025 at 08:28:47AM -0700, Suren Baghdasaryan wrote:
> > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl opera=
tion
> > correctness while the vma is being concurrently modified.
> >
>
> General comment, but I really feel like this stuff is mm-specific. Yes it=
 uses
> proc, but it's using it to check for mm functionality.
>
> I mean I'd love for these to be in the mm self tests but I get obviously =
why
> they're in the proc ones...
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: SeongJae Park <sj@kernel.org>
> > Acked-by: SeongJae Park <sj@kernel.org>
>
> The tests themselves look good, had a good look through. But I've given y=
ou
> some nice ASCII diagrams to sprinkle liberally around :)

Thanks for the commentary, Lorenzo, it is great! I think I'll post
them as a follow-up patch since they do not change the functionality
of the test.

>
> Anyway for tests themselves:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

>
> > ---
> >  tools/testing/selftests/proc/proc-maps-race.c | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/test=
ing/selftests/proc/proc-maps-race.c
> > index 94bba4553130..a546475db550 100644
> > --- a/tools/testing/selftests/proc/proc-maps-race.c
> > +++ b/tools/testing/selftests/proc/proc-maps-race.c
> > @@ -32,6 +32,8 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <unistd.h>
> > +#include <linux/fs.h>
> > +#include <sys/ioctl.h>
> >  #include <sys/mman.h>
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> > @@ -317,6 +319,25 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_=
maps_race) *self,
> >              strcmp(restored_first_line->text, self->first_line.text) =
=3D=3D 0;
> >  }
> >
> > +static bool query_addr_at(int maps_fd, void *addr,
> > +                       unsigned long *vma_start, unsigned long *vma_en=
d)
> > +{
> > +     struct procmap_query q;
> > +
> > +     memset(&q, 0, sizeof(q));
> > +     q.size =3D sizeof(q);
> > +     /* Find the VMA at the split address */
> > +     q.query_addr =3D (unsigned long long)addr;
> > +     q.query_flags =3D 0;
> > +     if (ioctl(maps_fd, PROCMAP_QUERY, &q))
> > +             return false;
> > +
> > +     *vma_start =3D q.vma_start;
> > +     *vma_end =3D q.vma_end;
> > +
> > +     return true;
> > +}
> > +
> >  static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
> >  {
> >       return mmap(self->mod_info->addr, self->page_size, self->mod_info=
->prot | PROT_EXEC,
> > @@ -559,6 +580,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split=
)
> >       do {
> >               bool last_line_changed;
> >               bool first_line_changed;
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> >
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> > @@ -595,6 +618,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_spli=
t)
> >               first_line_changed =3D strcmp(new_first_line.text, self->=
first_line.text) !=3D 0;
> >               ASSERT_EQ(last_line_changed, first_line_changed);
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
>
> Typo ioclt -> ioctl.
>
> I think a little misleading, we're just testing whether we find a VMA at
> mod_info->addr + self->page_size.
>
>
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > +                                       &vma_start, &vma_end));
> > +             /*
> > +              * The vma at the split address can be either the same as
> > +              * original one (if read before the split) or the same as=
 the
> > +              * first line in the second page (if read after the split=
).
> > +              */
> > +             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > +                          vma_end =3D=3D self->last_line.end_addr) ||
> > +                         (vma_start =3D=3D split_first_line.start_addr=
 &&
> > +                          vma_end =3D=3D split_first_line.end_addr));
> > +
>
> So I'd make things clearer here with a comment like:
>
>         We are mmap()'ing a distinct VMA over the start of a 3 page
>         mapping, which will cause the first page to be unmapped, and we c=
an
>         observe two states:
>
>                 read
>                   |
>                   v
>         |---------|------------------|
>         |         |                  |
>         |    A    |         B        | or:
>         |         |                  |
>         |---------|------------------|
>
>                   |
>                   v
>         |----------------------------|
>         |                            |
>         |              A             |
>         |                            |
>         |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A)
>         7fa86aa16000-7fa86aa18000 rw-p 00000000 00:00 0  (B)
>
>         Or:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>
>         So we assert that the reported range is equivalent to one of thes=
e.
>
> Obviously you can mix this in where you feel it makes sense.
>
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -636,6 +672,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resiz=
e)
> >       clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> >       start_test_loop(&start_ts, self->verbose);
> >       do {
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> > +
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> >               /* Check if we read vmas after shrinking it */
> > @@ -662,6 +701,16 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resi=
ze)
> >                                       "Expand result invalid", self));
> >               }
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, =
&vma_start, &vma_end));
>
> Same comments as above.
>
> > +             /*
> > +              * The vma should stay at the same address and have eithe=
r the
> > +              * original size of 3 pages or 1 page if read after shrin=
king.
> > +              */
> > +             ASSERT_TRUE(vma_start =3D=3D self->last_line.start_addr &=
&
> > +                         (vma_end - vma_start =3D=3D self->page_size *=
 3 ||
> > +                          vma_end - vma_start =3D=3D self->page_size))=
;
>
>
> So I'd make things clearer here with a comment like:
>
>         We are shrinking and expanding a VMA from 1 page to 3 pages:
>
>        read
>         |
>         v
>         |---------|
>         |         |
>         |    A    |
>         |         |
>         |---------|
>
>         |
>         v
>         |----------------------------|
>         |                            |
>         |              A             |
>         |                            |
>         |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A)
>
>         Or:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>
>         So we assert that the reported range is equivalent to one of thes=
e.
>
>
> > +
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -703,6 +752,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap=
)
> >       clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> >       start_test_loop(&start_ts, self->verbose);
> >       do {
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> > +
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> >               /* Check if we read vmas after remapping it */
> > @@ -729,6 +781,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_rema=
p)
> >                                       "Remap restore result invalid", s=
elf));
> >               }
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > +                                       &vma_start, &vma_end));
>
> Same comments as above.
>
>
> > +             /*
> > +              * The vma should either stay at the same address and hav=
e the
> > +              * original size of 3 pages or we should find the remappe=
d vma
> > +              * at the remap destination address with size of 1 page.
> > +              */
> > +             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > +                          vma_end - vma_start =3D=3D self->page_size *=
 3) ||
> > +                         (vma_start =3D=3D self->last_line.start_addr =
+ self->page_size &&
> > +                          vma_end - vma_start =3D=3D self->page_size))=
;
> > +
>
> Again be good to have more explanation here, similar comments to abov.
>
>         We are mremap()'ing the last page of the next VMA (B) into the
>         midle of the current one (A) (using MREMAP_DONTUNMAP leaving the
>         last page of the original VMA zapped but in place:
>
>       read
>         |
>         v             R/W                            R/O
>         |----------------------------| |------------------.---------|
>         |                            | |                  .         |
>         |              A             | |              B   .         |
>         |                            | |                  .         |
>         |----------------------------| |------------------.---------|
>
>         This will unmap the middle of A, splitting it in two, before
>         placing a copy of B there (Which has different prot bits than A):
>
>         |
>         v   R/W       R/O      R/W                   R/O
>         |---------|---------|--------| |----------------------------|
>         |         |         |        | |                            |
>         |    A1   |    B2   |   A2   | |              B             |
>         |         |         |        | |                            |
>         |---------|---------|--------| |----------------------------|
>
>         But then we 'patch' B2 back to R/W prot bits, causing B2 to get
>         merged:
>
>         |
>         v             R/W                            R/O
>         |----------------------------| |----------------------------|
>         |                            | |                            |
>         |              A             | |              B             |
>         |                            | |                            |
>         |----------------------------| |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>         7fa86aa19000-7fa86aa20000 r--p 00000000 00:00 0  (B)
>
>         Or:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A1)
>         7fa86aa16000-7fa86aa17000 r--p 00000000 00:00 0  (B2)
>         7fa86aa17000-7fa86aa18000 rw-p 00000000 00:00 0  (A3)
>         7fa86aa19000-7fa86aa20000 r--p 00000000 00:00 0  (B)
>
>         We are always examining the first line, so we simply assert that
>         this remains in place and we observe 1 page or 3 pages.
>
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > --
> > 2.50.1.703.g449372360f-goog
> >

