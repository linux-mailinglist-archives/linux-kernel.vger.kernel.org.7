Return-Path: <linux-kernel+bounces-794597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F6B3E3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF49B3A6FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6E32A3F7;
	Mon,  1 Sep 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uru6o/JA"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A784BA3D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731061; cv=none; b=hKlUY1WN2NwthkWp9K4d/QzWzacSj7z/jTxXeelvLNE0O4ZJM5CCJmJuH/MthSPZdv50sGHP3ImQjbO9Hn1XxMGLFsL1I69X6+RH3RTH24K0quOkRJs0a5WKCdoIxnw34BCSG+ueGJouy2Vckvlj2JPjjp6260SwSQW/Xk2Qs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731061; c=relaxed/simple;
	bh=SFLY856JaK+DPw4da8ArP2uz/kcaMmLaqGMn/UNQ4QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj6u5eN8wobWo0nni71KQijr7NZYDnjQXouQ8DCqY5utxziKj9G12CevgD5aYdySpuimpzoz2Fz480AyUBczxKDwRLgvvK8LrEioMigUDWdgY3SH/aNNNWkUAuS+EjsZ0Ctszsyu1QtO0iE5fEkgvxcON8IBsM9yGeBKg3NilQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uru6o/JA; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-52a80b77d41so1447067137.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756731058; x=1757335858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RojBF6ZwlxZFZwX/0b1dSoMQba7iu3ojoy33z4p+HaQ=;
        b=Uru6o/JAk9AFWovJhxQ9QupxivVbSko0ZyJf0OoP0lboryJC9dVeURBWQDPISewhOi
         5iZUt+oz1qcKfkhJ1kKLa74GJYW3HebPNc1A1w5wANcAYcwBgrhUyhGZ6mEyYbnLqBkh
         nbYVja9Dy1dyVWLt7IgsS2ug/s3PUklLy1WPqfYm//tI66rjRlYfyR1+fl7UvuJ+lk6N
         Y/3pyTnQe6sF2J3rW51k1QZVAsvLJIJFZMfZu87e8Ff4Iq7DgWilNoKUL1sX0WdAWOJZ
         gJdbn6b2hiWdBrVzYjeMr6lFwhBuB4yuYsAuxiObgyiDGAkIo2TqrJOC9yiOtFjr9Kat
         KtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731058; x=1757335858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RojBF6ZwlxZFZwX/0b1dSoMQba7iu3ojoy33z4p+HaQ=;
        b=HE5PEXPozlNy9MldTARqRwFgKkLdKaNk9qHboT4Ym5udHctx0GO1GjKfR4+rC5vWWZ
         gj2kqMXKXh7Ywf+eT7za9VY0LK6ygGoTunMIu23ni/J7C/pwzDmfzd47HcRyvPZ8Y9mX
         y3cfH0lY4lFqqe6/o0rZXaSim2WV19LmyR9hh2KYvtk7QNMLyL5I46Szjsj1ZJuqG4DI
         8CLY7Uev2jElK09iykpR01l7QAQqqNBA11lo8jI0ZWP+qAuV19pG71BCtMzq+XmLGBQZ
         h4mmzMfObZnoUPMjvfQjOcfLWm/w1j19rAHOaBR3USn21/DVfCKrAh/Di4RdDH33J4Vx
         v92Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwcDPd3Bm/0EWq1Du+zzbSLebiEqABI5CWEPXSQH9UGkQN+V89nzxb3Dl70AvIdCtY69wwJ58uFfho2aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkfswLAmEI53DOoVO80AuuqqwnWmqKyVgmbZMorZUscKfIjJG
	xr4BbwtVDVJhZgCytZ633ZegWFfMsMN2Oluanb00RZPsL4NVjR2z3198huGBaGeyrznGrmKq/yH
	bVTBNCHTd5rwlZB18Ip6ZPrfXFjlpmkJEYOgtTC1Kag==
X-Gm-Gg: ASbGncvmydvY8WjCK7Q+wcw0NKQV30ctorhpjAytGbV/mQzyNkk1Hogv/DItGY3k0aH
	WhZUcuRXydbHSgdFcXzUJvYpbYibLgUrs43ugxDStHCPEumCIu/NnzhTkbiNR45xkA7+GeSX9dZ
	sh5MXUxYlFACFPJPaGX5h/WKvy8nuVrJ+pJHiAiERSf6Tls3vaA8i+H0o+XZvkNITNjWXPO3Zec
	SdF4zKb//FXrHsB5WrXz4BkvWqZV4M=
X-Google-Smtp-Source: AGHT+IHr9UCL19brxa2iKAokFlw9VR4MD7FOmMAqfdtgQT+g1vRFoxL2i+IO+GvaPMnobuW4oatWNjOm6C5v2o0ix98=
X-Received: by 2002:a05:6102:6447:b0:523:6f5:5b18 with SMTP id
 ada2fe7eead31-52b1b2eca8fmr2157651137.9.1756731058441; Mon, 01 Sep 2025
 05:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145719.29455-1-linyongting@bytedance.com>
 <20250825145719.29455-5-linyongting@bytedance.com> <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
In-Reply-To: <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
From: Yongting Lin <linyongting@bytedance.com>
Date: Mon, 1 Sep 2025 20:50:47 +0800
X-Gm-Features: Ac12FXzEc3BxXpFrvQO5A4KgSDp4VDpvBoAfQRVXMGVwFUBvUT7kQaY8ahX-wSk
Message-ID: <CAFuXZ_UY6RrOVmTayW-DdxQX9TE978LPx7ad=Pzr01j1cZ4o2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/8] mshare: selftests: Add test case
 shared memory
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: khalid@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:00=E2=80=AFAM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
>
> Hi Yongting,
>
> Thank you for doing this. This is a great start for testing mshare.
> I do have some comments below.
>
> On 8/25/25 7:57 AM, Yongting Lin wrote:
> > This test case aims to verify the basic functionalities of mshare.
> >
> > Create a mshare file and use ioctl to create mapping for host mm
> > with supportive flags, then create two processes to map mshare file
> > to their memory spaces, and eventually verify the correctiness
> > of sharing memory.
> >
> > Signed-off-by: Yongting Lin <linyongting@bytedance.com>
> > ---
> >   tools/testing/selftests/mshare/basic.c | 81 +++++++++++++++++++++++++=
-
> >   1 file changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/sel=
ftests/mshare/basic.c
> > index 35739b1133f7..2347d30adfee 100644
> > --- a/tools/testing/selftests/mshare/basic.c
> > +++ b/tools/testing/selftests/mshare/basic.c
> > @@ -3,9 +3,86 @@
> >   #include "../kselftest_harness.h"
> >   #include "util.c"
> >
> > -TEST(basic)
> > +#define STRING "I am Msharefs"
> > +
> > +FIXTURE(basic)
> > +{
> > +     char filename[128];
> > +     size_t align_size;
> > +     size_t allocate_size;
> > +};
> > +
> > +FIXTURE_VARIANT(basic) {
> > +     /* decide the time of real mapping size besed on align_size */
> > +     size_t map_size_time;
> > +     /* flags for ioctl */
> > +     int map_flags;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, ANON_512G) {
> > +     .map_size_time =3D 1,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, HUGETLB_512G) {
> > +     .map_size_time =3D 1,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIX=
ED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, ANON_1T) {
> > +     .map_size_time =3D 2,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(basic, HUGETLB_1T) {
> > +     .map_size_time =3D 2,
> > +     .map_flags =3D MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIX=
ED,
> > +};
> > +
> > +FIXTURE_SETUP(basic)
> >   {
> > -     printf("Hello mshare\n");
> > +     int fd;
> > +
> > +     self->align_size =3D mshare_get_info();
> > +     self->allocate_size =3D self->align_size * variant->map_size_time=
;
> > +
> > +     fd =3D create_mshare_file(self->filename, sizeof(self->filename))=
;
> > +     ftruncate(fd, self->allocate_size);
> > +
> > +     ASSERT_EQ(mshare_ioctl_mapping(fd, self->allocate_size, variant->=
map_flags), 0);
>
> The tests should differentiate between how much VA space is allocated to
> an mshare region (i.e with ftruncate()) and how much memory is allocated
> within an mshare region through the ioctl. While the bounds of an mshare
> region need to be aligned to 512 GB, the memory allocated within it does
> not. Right now the tests will try to map 512 GB or 1 TB of anon or
> hugetlb memory in an mshare region which will fail on smaller systems to
> due to insufficient memory. Better to allocate smaller amounts so the
> tests can run on more systems.
>
> Anthony

I Changed my code to allocate a smaller chunk of memory (i.e.
4K/8K/2M/4M), and these tests are passed.

But I found something different:
step1:  ftruncate a mshare file to 512G
step2:  ioctl map 8K
step3: but after that, I am going to mmap 8K to a process but it
fails, then I have up to mmap 512G memory to process.
step4: Accessing the memory within the 8K boundary is fine but get
segfault after exceling the boundary (as the vma of host mm only holds
a memory region of 8K)

Should the mmap region keep consistent with the ioctl map region in
size? (currently, ioctl map region is 8K, but mmap region is 512G)

Yongting
>
> > +     close(fd);
> > +}
> > +
> > +FIXTURE_TEARDOWN(basic)
> > +{
> > +     ASSERT_EQ(unlink(self->filename), 0);
> > +}
> > +
> > +TEST_F(basic, shared_mem)
> > +{
> > +     int fd;
> > +     void *addr;
> > +     pid_t pid =3D fork();
> > +
> > +     ASSERT_NE(pid, -1);
> > +
> > +     fd =3D open(self->filename, O_RDWR, 0600);
> > +     ASSERT_NE(fd, -1);
> > +
> > +     addr =3D mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
> > +                    MAP_SHARED, fd, 0);
> > +     ASSERT_NE(addr, MAP_FAILED);
> > +
> > +     if (pid =3D=3D 0) {
> > +             /* Child process write date the shared memory */
> > +             memcpy(addr, STRING, sizeof(STRING));
> > +             exit(0);
> > +     }
> > +
> > +     ASSERT_NE(waitpid(pid, NULL, 0), -1);
> > +
> > +     /* Parent process should retrieve the data from the shared memory=
 */
> > +     ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
> >   }
> >
> >   TEST_HARNESS_MAIN
>

