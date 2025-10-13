Return-Path: <linux-kernel+bounces-850230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B1BD24E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C034E85EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67F2FDC3A;
	Mon, 13 Oct 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pm+glSDC"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA252FD7D2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347961; cv=none; b=Kr7O8QOtV5pX6zmvpq3NBT+1poeIHNOXec3W5px1LRxL/5wz07rntBqrCE8JlGnnfUvKviwxP9MCYUxT0B8FGYIN1u6i7yBPN2sT+cwggDOe2esyeezRx2okbzg5jGs4grQTvsofa95EKcacNvvKfFqQEtPVNvgKModSBqXN9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347961; c=relaxed/simple;
	bh=/RdAf5lc8yISn7YJzDBYoS5c95yTpesCdkfWXNuZnG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQZP3Q1MNwNlHDvu689gBEFv6coQ6ouiNUKDB6hZ/KypUhebaKrEwQhu3qiW3gnUA5BXJxVDX5aN5iSUglTZHjrxayEJU7jPYqJtymj+Qn9Y+f6evR29Bre6mMR0qEiTXOMp0lxJdK/okBEXo6IPP+E68EPK98Yv87DYGOG1YFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pm+glSDC; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4308afd43f0so1102955ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760347958; x=1760952758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cY5pJObfGgpMBLjEh34BMdDJO3is2w6d+mwNZItIM0=;
        b=Pm+glSDCqcD4tsvkHKnq3AoXx3/DQxT/iesQHtiTUGGFjB1DNjo53s2FN1IKoFDYaq
         tZLEDz8JpBUNyWM8i4Rg63cR5A3dMwdfw+y7WKP+b6RMe2ajq/uti6FtPzgPrz+xm2Rh
         ZptZHGsGjPWJPFA0mGwvj4TDUuy7t02N3j5p/QRjRdnHp9FrMHueE6NpRxk8XMiBzcsB
         U7sA89WKbXReaZH51hg89nObBdDlk1HzUwgWNltWU9gD5ye+kK5lqO8oYTcJ7H+2Xf9V
         /o53PM8S97Rg9/w6sQ25WKK5f8kNWFVWhpHQn5eOWzkHmislkKoexQgmXmRCHJZRgm0K
         h/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347958; x=1760952758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cY5pJObfGgpMBLjEh34BMdDJO3is2w6d+mwNZItIM0=;
        b=k8GowTTuLcWVoZ96zCuvh+Uv4rsLIJx1bdp7u2qcUgpCTF/TIsX7jberFS4HRIOZCD
         yWQivq2HAYmAQX7CnpUqpeBV9O0RKPnKFuqzWkH0v1bVedXzC6u/YyHW1/ID2JpyGUjS
         29/HRRquKCtQealP+2K29ctDCaQpsq0uiXcg/ITl108cFEgO7xLAEOuZplAYcXgqZMit
         FoMHkcHTl9jOU4bFSXxqTuC91uKil94mfYnC5iEKOi5ujeSGbKjzIMrVE3bQ0B56GkR7
         NjVGpt10XKJscBsTst9ky+d1tPqv4rmGU6AeEiiZM535Yntq/mOvoX71CfkHpM9ClV3K
         pEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1T3JScbjTbjhDs9YF7fZY5fA6pKQxOK2/benIVNRruJI7Wp7vBv1HRcL75/JJBBI9e3hRaqsWtpjESg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNKM8qehHkSQ2+3hx2+iuf8sthBk3ZX1cknJYsTfcIrOPvd/f
	BtjRl2xJqk4h9kFlqeWNDjy4EbtYcpanl3/rgXAoZXRhTa2b+UJdSe/8aLmtEMWmhCRDmBbYeQn
	ict7t76yxHb5bpP5YqxxtpsahKOlgnWAQINNZTnr+hRIbtAAziO74ilcE
X-Gm-Gg: ASbGncuFuRUgUYAvT1Zs6uuotwgum/AS1qhqyoxC9O7Pmmk3WEHfdQqPDC6SUkuPV7B
	BkJcJ8Emp0dIlUAx9pVgI9z5Hdl5KSeWHUc9TaPz/me20i7+q28l39y6VgWJfSyTs2IYZxFXkAP
	zHKUapwbzKS/j9crIkZWU2Z6CDZJBXuqeee6lJoQFz38y22bOC67ebymshPQT3ASirY1MWAHOfs
	dTPJBZqXLA3CIMnycp+/qc3HWxg9u5TJlVDZmesva8yO9eD156Rm/C1YdYrSoSTqfTUBfs=
X-Google-Smtp-Source: AGHT+IFD0U0uqRWglh/byx1FjKPjMX0/8ojaak8mgzvQHmpOzLLzkC7WYtfOUF9FNclcN4ih9bpH9zBVGTGC6vHRbs8=
X-Received: by 2002:ac8:590e:0:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4e6eabcf4camr36864821cf.9.1760347957508; Mon, 13 Oct 2025
 02:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 13 Oct 2025 10:32:25 +0100
X-Gm-Features: AS18NWBnoAflrsPjZ5od3RG3GtAXLBcqTt1b7ZmUjAfG8TvaxEyJScccM8v1Vt4
Message-ID: <CAFgf54opaN2GciRzRv_BJ2SJZybSJ6ib+mkVvHY0K5A1h0-5pg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Move io-pgtable-arm selftest to KUnit
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:50=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> This is a small series to clean up the io-pgtable-arm library.
>
> The first patch is a small clean up to reduce the depedencies of the
> test before moving it.
>
> The second patch was originally part of the SMMUv3 KVM driver support[1],
> which needed to factor out the kernel code from the io-pgtable-arm
> library, and based on Jason=E2=80=99s suggestion this can be taken out as=
 a
> cleanup, and a step further to convert it to kunit.
>
> The second patch just moves the code to a new file with no other changes,
> so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D
>
> The third patch converts the sefltest to be modular, that is useful as
> kunit can be a module and it can run anytime after boot.
>
> The fourth patch registers the test using kunit, and converges some of
> the APIs, some notes about that:
>
> Granularity of tests:
> ---------------------
> To make the series easier to review, the series changes the test to run i=
n
> kunit without making intrusive changes to the test itself.
> It=E2=80=99s possible to refactor the tests to have smaller granularity (=
although
> I think that would make it less efficient as we might create the same io-=
pgtable
> config multiple times) and integrate them in kunit as multiple tests, tha=
t
> change would be more intrusive, if you think that is the right approach,
> I can add a couple of more patches re-writing the tests.
>
> Other changes:
> --------------
> - Also, to make the test changes minimal, and the fail messages similar,
>   =E2=80=9CKUNIT_FAIL()=E2=80=9D is used to fail all tests instead of usi=
ng KUNIT specific
>   assertions.
>
> - Instead of using faux device, we rely on kunit_device_register()
>
> - The WARN is removed when a test fails, as that doesn=E2=80=99t seem to =
be a pattern
>   used with kunit.
>
>
> You can find the instructions on how to run kunit in the last patch commi=
t message.
>
> A failure at the test with the new implementation look as
> [  191.675985]     # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x200=
10000, IAS 40 OAS 48
> [  191.676057]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers=
/iommu/io-pgtable-arm-selftests.c:91
> [  191.676087]     # arm_lpae_do_selftests: selftest: test failed for fmt=
 idx 0
>
> Changes in v5:
> --------------
> - Rebase on iommu/next tree
> - Collected Jason and Praan Rbs
> - Move back #include <slab.h> to the main file.
>
> v4: https://lore.kernel.org/linux-iommu/20250922090003.686704-1-smostafa@=
google.com/
>
> Main changes in v4:
> -------------------
> - Remove one missed __init.
> - Change the kconfig dependencies back as it broke ARM
> https://lore.kernel.org/all/202509201819.f369wBHc-lkp@intel.com/
>
> v3: https://lore.kernel.org/all/20250919133316.2741279-1-smostafa@google.=
com/
>
> Main changes in v3:
> -------------------
> - Move back unused code
> - Simplify printing based on Jason comments + some renames
> - Collect Jasons Rb
> v2: https://lore.kernel.org/all/20250917191143.3847487-1-smostafa@google.=
com/
>
> Main changes in v2:
> -------------------
> - Make the test modular
> v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa=
@google.com/
>
> [1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.=
com/
>
>
> Mostafa Saleh (4):
>   iommu/io-pgtable-arm: Simplify error prints for selftests
>   iommu/io-pgtable-arm: Move selftests to a separate file
>   iommu/io-pgtable-arm-selftests: Modularize the test
>   iommu/io-pgtable-arm-selftests: Use KUnit
>
>  drivers/iommu/Kconfig                    |  11 +-
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 221 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
>  4 files changed, 228 insertions(+), 208 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c
>
>
> base-commit: 5f4b8c03f41782f37d278946296d9443a7194153
> --

Pinging, as this has been reviewed for while, Is there anything
blocking it or any more feedback?

Thanks,
Mostafa

> 2.51.0.536.g15c5d4f767-goog
>

