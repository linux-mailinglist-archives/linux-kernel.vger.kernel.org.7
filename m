Return-Path: <linux-kernel+bounces-793491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A25B3D43E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776953B0693
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543A2580D1;
	Sun, 31 Aug 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkTuZ2S+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6671BF58
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756655713; cv=none; b=g5WaZGZZ5GtdukUuNvGkCZX3xhGuYIY+dHa02uAxzhKs6L4TAolheUdA9zDpPPpQW52htjcbIZw0OEqlN8nKNWzATr8Z8YkYfkPauvNqgTw7Hk6Jq1+mS0vg21lo2sXhpVLI0Bvx3Hh9gu5mzeJMlZZ8d/h/WJAqC/NsgZp5lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756655713; c=relaxed/simple;
	bh=vu7OB5WCFRiIsU5hPqmzDabAlwcJjVGYZr9cnnXb0ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMkK49W+Uv+xPzNWZOTrqgs6nktDyw2lgmkRxxpBhiaD3zaVn6WLaSv49kQLBzCOn22CN+VpexL5DmJ/VOVzEo/2oxla6RAQ9Lf0ufhzD4tN6/Sx2QZyWvhqnfwTXgB7u6gOWK6Oz6Ojl74CqAYeZD3i+5Xf9+WOx6MlCX6ezHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkTuZ2S+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aff0365277aso327807466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756655710; x=1757260510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu7OB5WCFRiIsU5hPqmzDabAlwcJjVGYZr9cnnXb0ls=;
        b=gkTuZ2S+331sRy2DriNeq7QHUWDYWQAXlvDZNkFvuNhOvAHSiAtqy5IjbHAk2BtyOb
         Cstjjgezi7AO17XWaA1iuP3X173mxidA1TGtSRjBrY95rUTeLplXgBvnO5e+qOrGmgR6
         sq5knc4ARr9OJAshg+hoUvKGuI4Vh3isGJsYOiNt8ksGmXMSoF4ePAF80XTQPXm0FBZu
         QRkIuRy7i6PjP+HfC33n/8mbxtNpBWEEiJZKsqxrUfYk8J6izBv8g2nzNErubYVfo0U3
         OhRfCgVHeJQDqoHy7vcF3uE7In9DiBsVSzLmaQ+AmTUaB3hK1CXDzLc4ETLcI9KtWdYa
         4kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756655710; x=1757260510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu7OB5WCFRiIsU5hPqmzDabAlwcJjVGYZr9cnnXb0ls=;
        b=r0M4G8rgO/x9+sIfmzTUUgM9whEladYB2pKUnyKxlErkt5Gt4UjS2PHsF82CVcEIxC
         9VNwn99c9EtkOM4RYAry6ibihZyS15ZpKO93VS3Ll812Ra7LX/vZNAXGHjzGKZ6zwp6o
         A24onlk8pc7wgmFLPFFb0lJHLfxuyyzPrqG80zKWIueBNIn7fiHH65NUZUI9zdt4rGSe
         C66mg8MpctNPJZBvdSmNcxaWWdJhf/CgRXMzKhfi4+kx5SHAQ+xPBDML0Ow237HoXlw3
         WSrf66DJ9L7ANJb/wJPm+vzacZyxBq4NZ8uuOJT26evfRIWuZUuC9Pux0aDyMxblOeEQ
         dFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmp4tEr10+eHvLzX8YCLU6xradxmGQoNuW+Ab+XYzS1IHDzJ+mVsqP1rHNOilSFCdg0wpjWHJJeaAs2rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbbreQPhuk4nYla336wOJT1AuBbI+PxmSOTb/DrYW2swOBJ/C
	Je0ySJp5iEJsg15KxWeRnHJ9f1ubg8HfBfmIP4R75f2A1pOaQdMWMZBUYDebqx+X3JEdjbIvw2P
	7dv8hFh+Idk2QF3tt0W/w3vqg9/8+c48=
X-Gm-Gg: ASbGnctppja1O/LlKKjpe3HxUlWd9N/lm90HVdImCnFxDp0e8UXPH8T5vimnbpQIgsB
	vHC/aTbSjOQ1Ng9gyZO/qwBsmxl1xlIAqLAlZnAg69hu7M6X93cd2pAETsaleOUwS0fSEax1ycs
	OAJkI4ecGP+jR8A7jS/u1fvIBTczIBxBqiDrfP3YFT36ngmpxKPYXd4Gr62K5xisuggXA9abnHp
	J2XZ2Q=
X-Google-Smtp-Source: AGHT+IGWU/wsTdjnZJPNKAQvWWzNnWEbPVDY8n7oO8LLEmzwufwLGHZVPqASiHpxwHCaSZENKL1K5d3MELtSENT5sCA=
X-Received: by 2002:a17:906:4fca:b0:afe:ac57:f0be with SMTP id
 a640c23a62f3a-b010832f5famr574635066b.31.1756655709313; Sun, 31 Aug 2025
 08:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
 <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com> <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com>
In-Reply-To: <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 31 Aug 2025 23:54:32 +0800
X-Gm-Features: Ac12FXxioZkcEglVFpgNmclPXqeabDsMMCPYtygfFc3dkhi9MFV7CelcKDtuJqM
Message-ID: <CAMgjq7AdauQ8=X0zeih2r21QoV=-WWj1hyBxLWRzq74n-C=-Ng@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 11:24=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sat, Aug 30, 2025 at 1:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Kairui,
> >
> > It feels so good to remove that 64M swap cache space. Thank you for
> > making it happen.
> >
> > Some nitpick follows. I am fine as is as well.
> >
> > Acked-by: Chris Li <chrisl@kernel.org>
>
> Thanks.
>
> >
> > Chris
> >
> > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Swap cluster setup will try to shuffle the clusters on initialization=
.
> > > It was helpful to avoid contention for the swap cache space. The clus=
ter
> > > size (2M) was much smaller than each swap cache space (64M), so shuff=
ling
> > > the cluster means the allocator will try to allocate swap slots that =
are
> > > in different swap cache spaces for each CPU, reducing the chance of t=
wo
> > > CPUs using the same swap cache space, and hence reducing the contenti=
on.
> > >
> > > Now, swap cache is managed by swap clusters, this shuffle is pointles=
s.
> > > Just remove it, and clean up related macros.
> > >
> > > This should also improve the HDD swap performance as shuffling IO is =
a
> > > bad idea for HDD, and now the shuffling is gone.
> >
> > Did you have any numbers to prove that :-). Last time the swap
> > allocator stress testing has already destroyed two of my SAS drives
> > dedicated for testing. So I am not very keen on running the HDD swap
> > stress test. The HDD swap stress test are super slow to run, it takes
> > ages.
>
> I did some test months before, removing the cluster shuffle did help.
> I didn't test it again this time, only did some stress test. Doing
> performance test on HDD is really not a good experience as my HDD
> drives are too old so a long running test kills them easily.
>
> And I couldn't find any other factor that is causing a serial HDD IO
> regression, maybe the bot can help verify. If this doesn't help, we'll
> think of something else. But I don't think HDD based SWAP will ever
> have a practical good performance as they are terrible at rand read...
>
> Anyway, let me try again with HDD today, maybe I'll get some useful data.

So I tried to run some HDD test for many rounds, basically doing the
test in the URL below manually. Test is done using nr_task =3D 8. The
HDD swap partition size is 8G.

Do the preparation following:
https://github.com/intel/lkp-tests/blob/master/setup/swapin_setup
(Make usemem hold 8G memory and push them to swap)

And do the test with:
https://github.com/intel/lkp-tests/blob/master/programs/swapin/run
(Use SIGUSR1 to make usemem to read its memory and swapin)

Before this patch:
Test run 1:
1073741824 bytes / 878662493 usecs =3D 1193 KB/s
33019 usecs to free memory
1073741824 bytes / 891315681 usecs =3D 1176 KB/s
35144 usecs to free memory
1073741824 bytes / 898801090 usecs =3D 1166 KB/s
36305 usecs to free memory
1073741824 bytes / 925899753 usecs =3D 1132 KB/s
20498 usecs to free memory
1073741824 bytes / 927522592 usecs =3D 1130 KB/s
34397 usecs to free memory
1073741824 bytes / 928164994 usecs =3D 1129 KB/s
35908 usecs to free memory
1073741824 bytes / 929890294 usecs =3D 1127 KB/s
35014 usecs to free memory
1073741824 bytes / 929997808 usecs =3D 1127 KB/s
30491 usecs to free memory
test done

Test run 2:
1073741824 bytes / 771932432 usecs =3D 1358 KB/s
31194 usecs to free memory
1073741824 bytes / 788739551 usecs =3D 1329 KB/s
25714 usecs to free memory
1073741824 bytes / 795853979 usecs =3D 1317 KB/s
33809 usecs to free memory
1073741824 bytes / 798019211 usecs =3D 1313 KB/s
32019 usecs to free memory
1073741824 bytes / 798771141 usecs =3D 1312 KB/s
31689 usecs to free memory
1073741824 bytes / 800384757 usecs =3D 1310 KB/s
32622 usecs to free memory
1073741824 bytes / 800822764 usecs =3D 1309 KB/s
1073741824 bytes / 800882227 usecs =3D 1309 KB/s
32789 usecs to free memory
30577 usecs to free memory
test done

Test run 3:
1073741824 bytes / 775202370 usecs =3D 1352 KB/s
31832 usecs to free memory
1073741824 bytes / 777618372 usecs =3D 1348 KB/s
30172 usecs to free memory
1073741824 bytes / 778180006 usecs =3D 1347 KB/s
32482 usecs to free memory
1073741824 bytes / 778521023 usecs =3D 1346 KB/s
30188 usecs to free memory
1073741824 bytes / 779207791 usecs =3D 1345 KB/s
29364 usecs to free memory
1073741824 bytes / 780753200 usecs =3D 1343 KB/s
29860 usecs to free memory
1073741824 bytes / 781078362 usecs =3D 1342 KB/s
30449 usecs to free memory
1073741824 bytes / 781224993 usecs =3D 1342 KB/s
19557 usecs to free memory
test done


After this patch:
Test run 1:
1073741824 bytes / 569803736 usecs =3D 1840 KB/s
29032 usecs to free memory
1073741824 bytes / 573718349 usecs =3D 1827 KB/s
30399 usecs to free memory
1073741824 bytes / 592070142 usecs =3D 1771 KB/s
31896 usecs to free memory
1073741824 bytes / 593484694 usecs =3D 1766 KB/s
30650 usecs to free memory
1073741824 bytes / 596693866 usecs =3D 1757 KB/s
31582 usecs to free memory
1073741824 bytes / 597359263 usecs =3D 1755 KB/s
26436 usecs to free memory
1073741824 bytes / 598339187 usecs =3D 1752 KB/s
30697 usecs to free memory
1073741824 bytes / 598674138 usecs =3D 1751 KB/s
29791 usecs to free memory
test done

Test run 2:
1073741824 bytes / 578821803 usecs =3D 1811 KB/s
28433 usecs to free memory
1073741824 bytes / 584262760 usecs =3D 1794 KB/s
28565 usecs to free memory
1073741824 bytes / 586118970 usecs =3D 1789 KB/s
27365 usecs to free memory
1073741824 bytes / 589159154 usecs =3D 1779 KB/s
42645 usecs to free memory
1073741824 bytes / 593487980 usecs =3D 1766 KB/s
28684 usecs to free memory
1073741824 bytes / 606025290 usecs =3D 1730 KB/s
28974 usecs to free memory
1073741824 bytes / 607547362 usecs =3D 1725 KB/s
33221 usecs to free memory
1073741824 bytes / 607882511 usecs =3D 1724 KB/s
31393 usecs to free memory
test done

Test run 3:
1073741824 bytes / 487637856 usecs =3D 2150 KB/s
28022 usecs to free memory
1073741824 bytes / 491211037 usecs =3D 2134 KB/s
28229 usecs to free memory
1073741824 bytes / 527698561 usecs =3D 1987 KB/s
30265 usecs to free memory
1073741824 bytes / 531719920 usecs =3D 1972 KB/s
30373 usecs to free memory
1073741824 bytes / 532555758 usecs =3D 1968 KB/s
30019 usecs to free memory
1073741824 bytes / 532942789 usecs =3D 1967 KB/s
29354 usecs to free memory
1073741824 bytes / 540793872 usecs =3D 1938 KB/s
32703 usecs to free memory
1073741824 bytes / 541343777 usecs =3D 1936 KB/s
33428 usecs to free memory
test done

It seems to match the ~33% swapin.throughput regression reported by
the bot, it's about ~40% faster with this patch applied. I'll add this
test result to V2.

