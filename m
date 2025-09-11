Return-Path: <linux-kernel+bounces-812857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2771B53DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AAA1BC5D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD902DEA8E;
	Thu, 11 Sep 2025 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGta/Oa0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C02DCF6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625982; cv=none; b=lZi+ohdjVxM95AWY41ugjo8tgSSPcs5wWwV1/cPJ10GeOiqVMqjwD1siSJegaT5U7DcDgktajWSGXNaJOLMeMfiOcxIHJfT2u1NPlOmJdTFL5HXcYeRA8wZfUmoiNNNPCE8/KJ3YulHHrI5JrQbLflrsCoF5SNFMqq1y9Qco8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625982; c=relaxed/simple;
	bh=dUv4JvV6x0fHtU1K2HHnsgdI31cJjWCk0GrPCxvFWAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVP9BrS8AqbqtPbXZTDErAxJLqDYZERu1i6pNIy15pktA9ie0SXaljVi3igvftxBx5P6Ci1TIBFgNpPUtvo9VZVUTBohHPPPQWB/a34KRQdfyYFLuEG2+0+3Ibyd2m6ZfRveW0PfZJvj649KCoixk4Ok4sBhpSMczY7Q+KTr2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGta/Oa0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so7365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757625978; x=1758230778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muvx9qdyEE3ghxoAMYPt3hoTct41JTKDZsOlOaOPEAU=;
        b=uGta/Oa0zSxJXMvEqbXhFVOvF3e+4qcy7BI6eKg6gY2epyxV8vH/AC657K2Z3yBRto
         Msi7zY+Q4yUV/6BEVZ889ly6yq6+ZJFdgptA26EzZ7VUzLZBbrCSLGCmTwpHBbdgBqIY
         2IZykEr8yi2QaIOTGZEnqOxBcCFpL13iG0glzfWQYkfXIjv519y1TSLcdHCUqxuEtdDE
         UdsjDkTxQoVFugx15SM1Ba/Iy4HTiMlOT1itlzYjCS8sg435CIHRPexaDsYb7VGrfljD
         87gkEFz5X0FQ7kK8VOj0oxL1dG+WDeaeii437ug7SDIND3vMWDbqR0SeGwbRS6aD707L
         FnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625978; x=1758230778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muvx9qdyEE3ghxoAMYPt3hoTct41JTKDZsOlOaOPEAU=;
        b=sUG0dK82AC00VZJMTPuPqe3bcjeX4tEOHA/2k/7pTYFVTJXfr3ghmx5muHLOVlckgP
         FzT0HPy4TX5Mpnm3S6kA8MpM4OXFvZIN4F34gWZncHyIMhqAts06Yw6a0cBsZkBSz1lJ
         a4yGH4djWE8EmZU8Xeq4ATVeTvrJboQ2sWluUpRcArrPzHEO88vtVzXBjKy1Tyo0PBKv
         6xtKYWh4TFRneQ00k4b48WLlhnJrQJuoavAi6d99+ZtFYuv+24uGIgiNM9hyCaOEK5iJ
         K9S35ji1Cb5gVteU/pKb8Rcamn1DQYtmeGpEvQzb5QJNkuzUSe38T/9yM1u+Py0+8edT
         MP4A==
X-Forwarded-Encrypted: i=1; AJvYcCWhPTGhOvUQBlhSltnjVqlOAhz/eADOCJpnm0pFUKkNEfykv7fNmC4AAe8EYhJhEMkNN9yOmjuIPaBLYvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHr8+gwXTexRaDqKyMZTtuHwEOxmmYXeOui76xK1ABAtxXsJLM
	nLzhe8w1a7mgavdsX9klbgEDx/89LwWoPI0N8y/xC20aVkZKniBZwsUkrmbM9OPD9N6d14wtAdU
	aVLzS+oAQ4wvUq0AGtgWk387he1c8KFQ93E0g852q
X-Gm-Gg: ASbGncsAQObmK7tFG2u9Px3sSuNB7zkqxGdsoHguBragtWDvSQ9NUIYxzOaD56uUjEz
	z/3PuXtlceMKTybR7R+AU9fySbEmK7HiVrCFS7Q5UtyqlsE/AjT3J2ba/zcU2wVIv3OD/TY6+Sq
	H0E0l995xqPZSwiiP51KvZteEQzeJ2Hu6h2dHWNOyw+NQ0MzRTKtv9r056NmpTR1HN0bB6/won6
	+M4LrCDoJ2nuRifbJi60dACr8sk/iAM9bM4YRAP8JD449UrybYpkqQMfQ==
X-Google-Smtp-Source: AGHT+IGeI5npxi7Mgjv/AQZyj20ErEgsxJ1WUGm5ufWtxl66DRT2cimFQlPKpRNZt6Q0/CjVOtAFU08N/DTZ4T3ULi4=
X-Received: by 2002:a05:600c:4b94:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45df74aea3amr3235725e9.2.1757625977823; Thu, 11 Sep 2025
 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMGkAI3zKlVsO0S2@hpe.com> <CACw3F50yTvMphcp111Qzh3PKm+FYoXX9g_sLpV5TPuubqK2+Qw@mail.gmail.com>
 <aMG6SRckMsnQH7ov@hpe.com>
In-Reply-To: <aMG6SRckMsnQH7ov@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Sep 2025 14:26:05 -0700
X-Gm-Features: AS18NWBC4uuIS2CzvlC033iuGSPukXC1VYLzEEUeHNx8bxP_6fELZH6vPU6FTTw
Message-ID: <CACw3F51TsnT+QK8eYKHRcy==_vLsa+N3Btz_kzpfH=6mkYbHxA@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages
 by default
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com, 
	linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com, 
	Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, 
	jane.chu@oracle.com, joel.granados@kernel.org, laoar.shao@gmail.com, 
	lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com, 
	nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com, 
	rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com, 
	surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:50=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wr=
ote:
>
> On Wed, Sep 10, 2025 at 09:44:24AM -0700, Jiaqi Yan wrote:
> > On Wed, Sep 10, 2025 at 9:16=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com>=
 wrote:
> > >
> > > Soft offlining a HugeTLB page reduces the available HugeTLB page pool=
.
> > > Since HugeTLB pages are preallocated, reducing the available HugeTLB
> > > page pool can cause allocation failures.
> > >
> > > /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> > > disable/enable soft offline:
> > >
> > > 0 - Soft offline is disabled.
> > > 1 - Soft offline is enabled.
> > >
> > > The current sysctl interface does not distinguish between HugeTLB pag=
es
> > > and other page types.
> > >
> > > Disable soft offline for HugeTLB pages by default (1) and extend the
> > > sysctl interface to preserve existing behavior (2):
> > >
> > > 0 - Soft offline is disabled.
> > > 1 - Soft offline is enabled (excluding HugeTLB pages).
> > > 2 - Soft offline is enabled (including HugeTLB pages).
> > >
> > > Update documentation for the sysctl interface, reference the sysctl
> > > interface in the sysfs ABI documentation, and update HugeTLB soft
> > > offline selftests.
> > >
> > > Reported-by: Shawn Fan <shawn.fan@intel.com>
> > > Suggested-by: Tony Luck <tony.luck@intel.com>
> > > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > > ---
> > >
> > > Tony's original patch disabled soft offline for HugeTLB pages when
> > > a correctable memory error reported via GHES (with "error threshold
> > > exceeded" set) happened to be on a HugeTLB page:
> > >
> > > https://lore.kernel.org/all/20250904155720.22149-1-tony.luck@intel.co=
m
> > >
> > > This patch disables soft offline for HugeTLB pages by default
> > > (not just from GHES).
> > >
> > > ---
> > >  .../ABI/testing/sysfs-memory-page-offline     |  6 ++++
> > >  Documentation/admin-guide/sysctl/vm.rst       | 18 ++++++++---
> > >  mm/memory-failure.c                           | 21 ++++++++++--
> > >  .../selftests/mm/hugetlb-soft-offline.c       | 32 +++++++++++++----=
--
> > >  4 files changed, 60 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Do=
cumentation/ABI/testing/sysfs-memory-page-offline
> > > index 00f4e35f916f..befb89ae39ec 100644
> > > --- a/Documentation/ABI/testing/sysfs-memory-page-offline
> > > +++ b/Documentation/ABI/testing/sysfs-memory-page-offline
> > > @@ -20,6 +20,12 @@ Description:
> > >                 number, or a error when the offlining failed.  Readin=
g
> > >                 the file is not allowed.
> > >
> > > +               Soft-offline can be disabled/enabled via sysctl:
> > > +               /proc/sys/vm/enable_soft_offline
> > > +
> > > +               For details, see:
> > > +               Documentation/admin-guide/sysctl/vm.rst
> > > +
> > >  What:          /sys/devices/system/memory/hard_offline_page
> > >  Date:          Sep 2009
> > >  KernelVersion: 2.6.33
> > > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/=
admin-guide/sysctl/vm.rst
> > > index 4d71211fdad8..ae56372bd604 100644
> > > --- a/Documentation/admin-guide/sysctl/vm.rst
> > > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > > @@ -309,19 +309,29 @@ physical memory) vs performance / capacity impl=
ications in transparent and
> > >  HugeTLB cases.
> > >
> > >  For all architectures, enable_soft_offline controls whether to soft =
offline
> > > -memory pages.  When set to 1, kernel attempts to soft offline the pa=
ges
> > > -whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP=
 to
> > > -the request to soft offline the pages.  Its default value is 1.
> > > +memory pages:
> > > +
> > > +- 0: Soft offline is disabled.
> > > +- 1: Soft offline is enabled (excluding HugeTLB pages).
> > > +- 2: Soft offline is enabled (including HugeTLB pages).
> >
> > Would it be better to keep/inherit the previous documented behavior "1
> > - Soft offline is enabled (no matter what type of the page is)"? Thus
> > it will have no impact to users that are very nervous about corrected
> > memory errors and willing to lose hugetlb page. Something like:
> >
> >   enum soft_offline {
> >       SOFT_OFFLINE_DISABLED =3D 0,
> >       SOFT_OFFLINE_ENABLED,
> >       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> >       // SOFT_OFFLINE_ENABLED_SKIP_XXX...
> >   };
>
> I don't have a strong opinion on the default because there's a sysctl
> interface, but that seems reasonable. I'll wait for more feedback before
> putting together a v2.

Yeah, no strong opinion from me either, as long as
SOFT_OFFLINE_DISABLED is still 0 (used by our fleet).

In case you don't need to send out v2:

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
> > > +
> > > +The default is 1.
> > > +
> > > +If soft offline is disabled for the requested page type, EOPNOTSUPP =
is returned.
> > >
> > >  It is worth mentioning that after setting enable_soft_offline to 0, =
the
> > >  following requests to soft offline pages will not be performed:
> > >
> > > +- Request to soft offline from sysfs (soft_offline_page).
> > > +
> > >  - Request to soft offline pages from RAS Correctable Errors Collecto=
r.
> > >
> > > -- On ARM, the request to soft offline pages from GHES driver.
> > > +- On ARM and X86, the request to soft offline pages from GHES driver=
.
> > >
> > >  - On PARISC, the request to soft offline pages from Page Deallocatio=
n Table.
> > >
> > > +Note: Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> > > +
> > >  extfrag_threshold
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index fc30ca4804bf..cb59a99b48c5 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -64,11 +64,18 @@
> > >  #include "internal.h"
> > >  #include "ras/ras_event.h"
> > >
> > > +enum soft_offline {
> > > +       SOFT_OFFLINE_DISABLED =3D 0,
> > > +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> > > +       SOFT_OFFLINE_ENABLED
> > > +};
> > > +
> > >  static int sysctl_memory_failure_early_kill __read_mostly;
> > >
> > >  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
> > >
> > > -static int sysctl_enable_soft_offline __read_mostly =3D 1;
> > > +static int sysctl_enable_soft_offline __read_mostly =3D
> > > +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB;
> > >
> > >  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(=
0);
> > >
> > > @@ -150,7 +157,7 @@ static const struct ctl_table memory_failure_tabl=
e[] =3D {
> > >                 .mode           =3D 0644,
> > >                 .proc_handler   =3D proc_dointvec_minmax,
> > >                 .extra1         =3D SYSCTL_ZERO,
> > > -               .extra2         =3D SYSCTL_ONE,
> > > +               .extra2         =3D SYSCTL_TWO,
> > >         }
> > >  };
> > >
> > > @@ -2799,12 +2806,20 @@ int soft_offline_page(unsigned long pfn, int =
flags)
> > >                 return -EIO;
> > >         }
> > >
> > > -       if (!sysctl_enable_soft_offline) {
> > > +       if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_DISABLED) =
{
> > >                 pr_info_once("disabled by /proc/sys/vm/enable_soft_of=
fline\n");
> > >                 put_ref_page(pfn, flags);
> > >                 return -EOPNOTSUPP;
> > >         }
> > >
> > > +       if (sysctl_enable_soft_offline =3D=3D SOFT_OFFLINE_ENABLED_SK=
IP_HUGETLB) {
> > > +               if (folio_test_hugetlb(pfn_folio(pfn))) {
> > > +                       pr_info_once("disabled for HugeTLB pages by /=
proc/sys/vm/enable_soft_offline\n");
> > > +                       put_ref_page(pfn, flags);
> > > +                       return -EOPNOTSUPP;
> > > +               }
> > > +       }
> > > +
> > >         mutex_lock(&mf_mutex);
> > >
> > >         if (PageHWPoison(page)) {
> > > diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tool=
s/testing/selftests/mm/hugetlb-soft-offline.c
> > > index f086f0e04756..7e2873cd0a6d 100644
> > > --- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
> > > +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> > > @@ -1,10 +1,15 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*
> > >   * Test soft offline behavior for HugeTLB pages:
> > > - * - if enable_soft_offline =3D 0, hugepages should stay intact and =
soft
> > > - *   offlining failed with EOPNOTSUPP.
> > > - * - if enable_soft_offline =3D 1, a hugepage should be dissolved an=
d
> > > - *   nr_hugepages/free_hugepages should be reduced by 1.
> > > + *
> > > + * - if enable_soft_offline =3D 0 (SOFT_OFFLINE_DISABLED), HugeTLB p=
ages
> > > + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> > > + *
> > > + * - if enable_soft_offline =3D 1 (SOFT_OFFLINE_ENABLED_SKIP_HUGETLB=
), HugeTLB pages
> > > + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> > > + *
> > > + * - if enable_soft_offline =3D 2 (SOFT_OFFLINE_ENABLED), a HugeTLB =
page should be
> > > + *   dissolved and nr_hugepages/free_hugepages should be reduced by =
1.
> > >   *
> > >   * Before running, make sure more than 2 hugepages of default_hugepa=
gesz
> > >   * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048=
kB:
> > > @@ -32,6 +37,12 @@
> > >
> > >  #define EPREFIX " !!! "
> > >
> > > +enum soft_offline {
> > > +       SOFT_OFFLINE_DISABLED =3D 0,
> > > +       SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> > > +       SOFT_OFFLINE_ENABLED
> > > +};
> > > +
> > >  static int do_soft_offline(int fd, size_t len, int expect_errno)
> > >  {
> > >         char *filemap =3D NULL;
> > > @@ -83,7 +94,7 @@ static int set_enable_soft_offline(int value)
> > >         char cmd[256] =3D {0};
> > >         FILE *cmdfile =3D NULL;
> > >
> > > -       if (value !=3D 0 && value !=3D 1)
> > > +       if (value < SOFT_OFFLINE_DISABLED || value > SOFT_OFFLINE_ENA=
BLED)
> > >                 return -EINVAL;
> > >
> > >         sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", va=
lue);
> > > @@ -155,7 +166,7 @@ static int create_hugetlbfs_file(struct statfs *f=
ile_stat)
> > >  static void test_soft_offline_common(int enable_soft_offline)
> > >  {
> > >         int fd;
> > > -       int expect_errno =3D enable_soft_offline ? 0 : EOPNOTSUPP;
> > > +       int expect_errno =3D (enable_soft_offline =3D=3D SOFT_OFFLINE=
_ENABLED) ? 0 : EOPNOTSUPP;
> > >         struct statfs file_stat;
> > >         unsigned long hugepagesize_kb =3D 0;
> > >         unsigned long nr_hugepages_before =3D 0;
> > > @@ -198,7 +209,7 @@ static void test_soft_offline_common(int enable_s=
oft_offline)
> > >         // No need for the hugetlbfs file from now on.
> > >         close(fd);
> > >
> > > -       if (enable_soft_offline) {
> > > +       if (enable_soft_offline =3D=3D SOFT_OFFLINE_ENABLED) {
> > >                 if (nr_hugepages_before !=3D nr_hugepages_after + 1) =
{
> > >                         ksft_test_result_fail("MADV_SOFT_OFFLINE shou=
ld reduced 1 hugepage\n");
> > >                         return;
> > > @@ -219,10 +230,11 @@ static void test_soft_offline_common(int enable=
_soft_offline)
> > >  int main(int argc, char **argv)
> > >  {
> > >         ksft_print_header();
> > > -       ksft_set_plan(2);
> > > +       ksft_set_plan(3);
> > >
> > > -       test_soft_offline_common(1);
> > > -       test_soft_offline_common(0);
> > > +       test_soft_offline_common(SOFT_OFFLINE_ENABLED);
> > > +       test_soft_offline_common(SOFT_OFFLINE_ENABLED_SKIP_HUGETLB);
> > > +       test_soft_offline_common(SOFT_OFFLINE_DISABLED);
> >
> > Thanks for updating the test code! Looks good to me.
> >
> > >
> > >         ksft_finished();
> > >  }
> > > --
> > > 2.51.0
> > >

