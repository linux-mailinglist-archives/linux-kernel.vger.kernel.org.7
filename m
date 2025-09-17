Return-Path: <linux-kernel+bounces-820961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27023B7FE43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F09541789
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3631BCBD;
	Wed, 17 Sep 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKd4I0fR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7C3195FF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117749; cv=none; b=Yw57hNT3Xhhj/wuJpNPvcug/aA3PfhBl9Weqhqq9jiVTLWmQVk0HSVkdGhfZxQ/ffIqNH6f55uG88k4hcfOlv8LPzvtRIuimpNIunO+vk8k4KvZEX/jIVLkwpw+PQ0mrjltCDjpDa3OYc8jn+PTyrJLGKCVyylg/zhezbYk3nCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117749; c=relaxed/simple;
	bh=fslEfQVFSDy3MdRZz+1IJQFEJXxKgiBQB/ipShdsiCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p27Zm/hSEwmpl9JhqsBf+Tr4KYJgXHpEeHMao6P5vMPe4lJaNnWCpG/MfPyvrExlHSfXPyAxKNM2Ssr13c427ckn4nUoPWnWCMt6Xtx8X41YB1eAE6z9ystJF0KEC9lAiYnAGKRiAW2BHUVaEzLKKiFUcXq0yIQeM9Gj6i8KvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKd4I0fR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45df609b181so55653355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117745; x=1758722545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngN4kxVQKLMv2TlOZWI2DrSijnc3KpLfGOwuclV4Snc=;
        b=bKd4I0fR6kmV30EqwHa1ENLk2HNSzES4SaP2a2OELm28QkLHRp1Z9cHcpeT6omZUFP
         hf/gZuOtPEf8A+RlBn+dwWsbsolzF5I2XYcFTBRrdzWpNBtWj4r3vtBQ2Z5cf+Fy5KEE
         KwOFls6Yb/Mq7NUSNshUigg+AbyQmrul/GUBTm7W4kuqSHxOYdw+XQaHYZOlSwd8Umhw
         hQn7qwsdN9f5ujmXUjJ1PU9XOSl1ysZN65V3Bf8lYo7nqlswikfPA0nP+BNX7oLDlmtX
         Tp4PSGcWzGMtN/0n0V76Sx2zqCiB5QMt2k7j0/VYLNFOjWhf+OMEgSW5jvkxM621E+GC
         OZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117745; x=1758722545;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngN4kxVQKLMv2TlOZWI2DrSijnc3KpLfGOwuclV4Snc=;
        b=oEVHDSjx+YMh+Gxpns3LvtuZIVdp5Ud6n/XuUMtkEcC1w+P8KrlvY0pUkijrt2P/I1
         bYvHnWPdO8q/wdoT6yMAnPmxJvRlXBxy1l7tl/x31NCaUxl9LVgBWIjjquVDPZWMJNR4
         G+5jLLKIv0HtNYFv7caC3kPmeq26MgilIy6CG6lh6HAMMnk1TF2zOcqKmonh9qOJr2Ca
         hkD2f5Dy8bCMLCnhjxzBg5RRXS4KsNt1T0UrYkOwSa7N5R/q5cZsQhYCe/+mgkMoMd0I
         DhO0BWuuGA3LRM3lIDRfoop6ulwgoMqd6MkAJ/UC8fmdgy+zmPhu2l7usLRiOOVOL+Rj
         f/gA==
X-Forwarded-Encrypted: i=1; AJvYcCXKrTNJcicyx8ZMn3zecevu9dI61ccvDLR1XIlCPRiwka6NLmE7mvGXAhzQ85Hv558FcXDarNvJazZmFmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw8Fju4LLQcsoIMRiyuJ0khoflX8jMa1ZRDzuIZxwFBMJkWwa
	iVz3mtcRYrTah8jrEgCyehNv3r5R8yQArLmxG3oHRqL0R1Je54wvb7bbZECvKzzDikX5DijTAIP
	LzqgNBS/Flk8p5Q==
X-Google-Smtp-Source: AGHT+IFdG0Nhhw1O1UF5cygDkCqoxwKDzBO775bZilL9ZTcI8tzFDCdOk8xitUr+etVtXwIkoCMI0q6cwt5MfA==
X-Received: from wmtk6.prod.google.com ([2002:a05:600c:c4a6:b0:45b:89e7:5038])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354c:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-46205fa5930mr21477245e9.21.1758117745343;
 Wed, 17 Sep 2025 07:02:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:02:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917140216.2199055-1-smostafa@google.com>
Subject: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch was originally part of SMMUv3 KVM driver support[1],
which was needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can taken out as a cl=
eanup
and to converge to kunit.

The first patch just moves the code to a new file with no other changes,
so it can be easier to review it with =E2=80=9C--color-moved=E2=80=9D

The second patch registers the test using kunit, and converges some of
the APIs, some notes about that:

Dealing with __init:
--------------------
At the moment, all the test code and data are part of the init section.
To avoid changing all the functions and data and removing them from the
init section, we can rely on the kunit =E2=80=9Ckunit_test_init_section_sui=
te=E2=80=9D
to keep the test in the init section.
That will make the results only available on debugfs (there is no
possibility to run them after boot) unlike the SMMUv3 tests for example
which can run on-demand.

As the of results are saved in the kunit structs, they can=E2=80=99t be tag=
ged
as __init_data, instead they are be tagged to __refdata to avoid the
modpost warning, as it=E2=80=99s guaranteed that kunit will only access the=
 results,
not the test after init.

Instead, we can remove the __init constraint, and be able to run the tests
on-demand, and possibly compile it as a module.

Granularity of tests:
---------------------
To make the series easier to review, the series changes the test to run in
kunit without making intrusive changes to the test itself.
It=E2=80=99s possible to refactor the tests to have smaller granularity (al=
though
I think that would make it less efficient as we might create the same io-pg=
table
config multiple times) and integrate them in kunit as multiple tests, that
change would be more intrusive, if you think that is the right approach,
I can add a couple of more patches re-writing the tests.

Other changes:
--------------
- Also, to make the test changes minimal, and fail messages similar, =E2=80=
=9CKUNIT_FAIL=E2=80=9D
  is used to fail all tests instead of using KUNIT specific assertions.

- Instead of using faux device, we rely on kunit_device_register()

- The WARN is removed when a test fails, as that doesn=E2=80=99t seem to be=
 a pattern
  used with kunit.


A failure at the test with the new implementation look as
[    2.115982]     # io_pgtable_arm_test_run: EXPECTATION FAILED at drivers=
/iommu/io-pgtable-arm-selftests.c:94
[    2.118381]     # io_pgtable_arm_test_run: selftest: test failed for fmt=
 idx 0
[    2.118501]     # io_pgtable_arm_test_run: cfg: pgsize_bitmap 0x40201000=
, ias 32-bit
[    2.118863]     # io_pgtable_arm_test_run: data: 3 levels, 0x20 pgd_size=
, 12 pg_shift, 9 bits_per_level, pgd @ 00000000a15afb2d


[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/


Mostafa Saleh (2):
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftest: Use KUnit

 drivers/iommu/Kconfig                    |   2 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 223 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 243 -----------------------
 drivers/iommu/io-pgtable-arm.h           |  41 ++++
 5 files changed, 266 insertions(+), 244 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

--=20
2.51.0.384.g4c02a37b29-goog


