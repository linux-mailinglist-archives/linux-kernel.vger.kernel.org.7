Return-Path: <linux-kernel+bounces-836493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E4BA9DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC6219216C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5330C0E8;
	Mon, 29 Sep 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJQd7Z7x"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A119F40A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161010; cv=none; b=Bq12rkIdLPcSsCo53tyCwztWTPP5OyMA/pWGRFuJOsFvPB4Sl09my7ETbDWRZCH3ltJKbWz5YHoovLPcm/bLeTnd19TepMXLelWSH0JWXq3dglq7Upwi69BwYS4Af+uKFEL6m38MXu2MO6FRDrHmmWhSzwa1G248lWV2fys7njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161010; c=relaxed/simple;
	bh=TM00Q67lZErWUQoxa1jS1p9j0/eIwOVnpK328AUsNfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=roJPdVubpHFOi/gyRAPrKo218r6pbIFjv3A6rgNHjPJaTj/3fPcIKPKxndBVvq+1F3oprsPItzlfmWqaQiE8IOdbQ4t7x6pdANzD+kAbkXmQiVK8T1cFszJoaTx7mEcG8+3Ts51IuoTKbEjh8NP3j1cCPbST5zW1I3jSMgadGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJQd7Z7x; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso2406536f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161007; x=1759765807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeGiAhQBgE5SioCpTqIS2Jf/K9QNAbJm22HCuBejOhw=;
        b=IJQd7Z7xNBR0kWWIILq8dMU6RDUZq/rOmXUBAUgjrb4yOWopaEufGyf78hZKritAFr
         HubV6eFeZlxPmqjONvBgrZxuiVEDkuBW2DTYby3k4MdOaUMSpvWKU1hZW6265CksjExX
         teHpjQA6qUlPHlhj7DWuuTb5rSsrBGqWpfbWv1fRwiRxsqrd/zYB8q2mo7wgxTXn7EcP
         l8yJp4nVYs46fzyH5CcoHgiP0W5w5wF+HBDMnoBizV49+kH0HVQZ48PdZYm+tI4MRDy4
         5aGdO+kFVOG+9D6vbr3UXd3DfC8EJT2bMIq+lr0Eqldn6ehnc6ANLQKqqQdsZu9cFHxh
         SCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161007; x=1759765807;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeGiAhQBgE5SioCpTqIS2Jf/K9QNAbJm22HCuBejOhw=;
        b=awKzXQwSAZ16MUR5zLbliyYTVtpOqr+uqv6VrEFE2Dmy1YBr1PIsnbiZ8nReQt3Lyc
         FCLfnVPGYhDufdZ7x2Cy/gjN3qJDvkp3F4SDpz/+tW3nr6Q/+RTdcUaOtAZqum84c0L5
         UdNedXMXKhz7XKTRJWp8cSLiG2d3GnWduABboHHE7uemTT2wG0wzjhKWmU6G2P3i7cMe
         FfAKh+RzlnqB5i6B7RaiUhtUwUuwuv7fhiUkLnOZNNsyLwE4Oc7CP5zMUVVJwIPdYyJ5
         O6NHeVg/07YCEBnmSYsniuypYqezfp5zyOO8/6ZaJFriNMoiXEoITY5RKtwLUtiEKjx1
         ee1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhRFKIl2bbzjM9xBc+oR3TOMDwLhwcugqcK06jDVyIXmXPizqj3T83XcihmsUP6OuiLzivZOHblv0/ATk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmodMsrXsT+ttPoQISn8BHPqoGyoZC9ygKXeZDg57qDjqfnDE
	s45w5/K5iqQ8pZBxGXyPQAxBYoD/bkJkFNzneEtkZCTcc7HkpP9wv2qUBhQ2lsKzZB7MXQi0UTf
	jpWG17qDYApeD5Q==
X-Google-Smtp-Source: AGHT+IEICyelSc+dhdigiShqJvTBGgipfMzl1NQ4eObmUtfk5GsCQRpuD8i813yQYt9a5FCkGAW67AoXY8BgRw==
X-Received: from wmoz15.prod.google.com ([2002:a05:600c:78f:b0:458:bdde:5c9b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4024:b0:3ec:d7c4:25d5 with SMTP id ffacd0b85a97d-40e4be0cb3amr13969388f8f.50.1759161007523;
 Mon, 29 Sep 2025 08:50:07 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-1-smostafa@google.com>
Subject: [PATCH v5 0/4] Move io-pgtable-arm selftest to KUnit
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

Changes in v5:
--------------
- Rebase on iommu/next tree
- Collected Jason and Praan Rbs
- Move back #include <slab.h> to the main file.

v4: https://lore.kernel.org/linux-iommu/20250922090003.686704-1-smostafa@go=
ogle.com/

Main changes in v4:
-------------------
- Remove one missed __init.
- Change the kconfig dependencies back as it broke ARM
https://lore.kernel.org/all/202509201819.f369wBHc-lkp@intel.com/

v3: https://lore.kernel.org/all/20250919133316.2741279-1-smostafa@google.co=
m/

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

 drivers/iommu/Kconfig                    |  11 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 221 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
 4 files changed, 228 insertions(+), 208 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c


base-commit: 5f4b8c03f41782f37d278946296d9443a7194153
--=20
2.51.0.536.g15c5d4f767-goog


