Return-Path: <linux-kernel+bounces-824621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B533EB89AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193163AD674
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660502F83BA;
	Fri, 19 Sep 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ip4GicFK"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2C1E0DFE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288802; cv=none; b=sqWvDn8yPDctVRTUCOZNVCBb4WUH2qax/j9yYDd2Vz152RcllCynqI5qc0BmKs9wpWHHN7QhAakmhksKhKwbek3Dk23u5hLxFvxdnox+Wyd8vfqMEF1OuGvXYk/ZOsOfGAYoq8j33YygSINZyXLR4bRqAc4pM7tL8d7TKyyEQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288802; c=relaxed/simple;
	bh=yhbCLGwVnGVY3jbaYPY86vLAA2Yd+Leim+F9sdQwRrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UvYMcnIGWsJ+ZHhcxJE+0OCS3nz4ZWyqcU2R+ic3PoVT5w/rLzSiYz+DJi80gxCDYDIAWNbl1LWDgabM2++lnnfUcRb9zJxQWB6ekw6hd5LfyxzvaIR9YJH7h2ofkyrpWFNDKmgMr0DQ0CYOV6bKFl9KnDVu0lJ28Omw2m10clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ip4GicFK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so1464644f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288799; x=1758893599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4GdfKGjcAjHO1Ow9QOdPWWunxjlWYABEGKDu3CoN9g=;
        b=Ip4GicFKuLCySQHlKBUtwNcqPiqVHwS2+ncon41TJaEkJlQA9lMS/27PuOmV+onTER
         iEY2tvkncFY3myYaPhX5GQMK2ZKom4mhE2tKzRvy/OuDWT7yH7k50Wf+16HhEfJS7PT3
         wdwmOoYrVEzTpg0VCjLp+XqhyIUMcKWDdx6bYJhXNn68Y9DmJSCxcx2lg7+h2U8w9mZM
         aoWPZm4JbEmYgy9/iJltbSs1YdaCrPROEnLI4WHhvhC5t4YvX8XdSFmV6WvAJSTwQuyu
         CLDmaelLlp4d5ORpH41BVGQZc0a//yEZeecekVS3q5hxrxtGi6kd336lg/ypTnmNesdh
         NNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288799; x=1758893599;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4GdfKGjcAjHO1Ow9QOdPWWunxjlWYABEGKDu3CoN9g=;
        b=IfR5R4kYWJ9QiDoCmucKRy1Ad7xCcMQf2rujecY/ROSqGcT6Fivx0NGR1sUNvB2e5P
         V1I8sL9RLxUtb2FrTsOCOEzHD/TkB5CCLoURveb6ep2yKoWJfaF3mXm6zWPwQGedvaIx
         W9gi2rr6wxOF6QMxP1dxBc/k27RUyub0x3lG2r1xS7qBFRLWbma6MDCMCbLvTfqmHsGq
         1rGEKpgyZ7XbBWN8aIrBN/xY9jvA2dOcNZ5+jZKQ+8NpwRo4Ls9ITiZ5pOqgTrIpWuRo
         B1X+HFFDk1fTR/DDO7bs9CJuuoa2jF9O/CEps3CfiX8lP+3tWwEtFo8y6MiS+Srm65j2
         /CoA==
X-Forwarded-Encrypted: i=1; AJvYcCWN0IVOXdus+tPLFvNbCy5WDIWaH8P2yeOZUUInsAqVDaV5I4/1FqCT0+6+qiHwlg+x7gW80JIBisQBCjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAB+MxdJL7s5d0DOnX489Nk+B/r+Mbnd1waDiPS25eUk5xYRG
	Qhw+afmYwRQVRnYKKM/gVPhl1rpXOeYDVL24BNoixn+cXQtdcHq8aHQo9FdHsTfKV71Ak/wOc8y
	yrBXb3vIxXSB9kg==
X-Google-Smtp-Source: AGHT+IGBtth11hKgSJrPU0wa9yxisbbeO9r+lcZZZKAbsRwiycsMuFxXsib0bL2/MaLbfaWsBZv3sfUavT1taA==
X-Received: from wrbgx5.prod.google.com ([2002:a05:6000:4705:b0:3ec:b561:7686])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f95:0:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-3ee193f90f1mr3383557f8f.17.1758288799288;
 Fri, 19 Sep 2025 06:33:19 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-1-smostafa@google.com>
Subject: [PATCH v3 0/4] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch is a small clean up to reduce the depedencies of the
test before moving it.

The second patch was originally part of the SMMUv3 KVM driver support[1],
which needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can be taken out as a
cleanup, and a step further to convert it to kunit.

The second patch just moves the code to a new file with no other changes,
so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D

The third patch converts the sefltest to be modular, that is useful as
kunit can be a module and it can run anytime after boot.

The fourth patch registers the test using kunit, and converges some of
the APIs, some notes about that:

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
- Also, to make the test changes minimal, and the fail messages similar,
  =E2=80=9CKUNIT_FAIL()=E2=80=9D is used to fail all tests instead of using=
 KUNIT specific
  assertions.

- Instead of using faux device, we rely on kunit_device_register()

- The WARN is removed when a test fails, as that doesn=E2=80=99t seem to be=
 a pattern
  used with kunit.


You can find the instructions on how to run kunit in the last patch commit =
message.

A failure at the test with the new implementation look as
[  191.675985]     # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010=
000, IAS 40 OAS 48
[  191.676057]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/i=
ommu/io-pgtable-arm-selftests.c:91
[  191.676087]     # arm_lpae_do_selftests: selftest: test failed for fmt i=
dx 0


Main changes in v3:
-------------------
- Move back unused code
- Simplify printing based on Jason comments + some renames
- Collect Jasons Rb
v2: https://lore.kernel.org/all/20250917191143.3847487-1-smostafa@google.co=
m/

Main changes in v2:
-------------------
- Make the test modular
v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa@g=
oogle.com/

[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/

Mostafa Saleh (4):
  iommu/io-pgtable-arm: Simplify error prints for selftests
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftests: Modularize the test
  iommu/io-pgtable-arm-selftests: Use KUnit

 drivers/iommu/Kconfig                    |  12 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 222 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 204 ---------------------
 4 files changed, 230 insertions(+), 209 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

--=20
2.51.0.534.gc79095c0ca-goog


