Return-Path: <linux-kernel+bounces-826928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE19B8FAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4B31895373
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3F28507D;
	Mon, 22 Sep 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLEkbcyN"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC9283FE5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531609; cv=none; b=nMufVSWO9QL2BaXvoYlXLm11IB8x5V2HKsP59b09/snDIk8Aew7IJrjmRe2YZ11qKTNMdzjrR0pw0qF1lczLMC4kyuSBcg4eyMWCVljjDfSOAldCNj9dqXDKpq+i4ZskYEO6ngI4ouvjGH5sFsAuxQ3plM6J53oC6tZvv9Tm2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531609; c=relaxed/simple;
	bh=w3yp2JrNnsSF3+6X/xTHjw+JwtJyjw6GCrUHlSgXglY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fk7dceSCWU5u250Kkeqle9JxS17pBi+Nq85FYwnYA+nqz+YOKmJuUywNI2+mcm9MdU0rwKu2LXZHEPMkwjTrW6qMOD1FuFml9EPppuEgfMQ46EaAhhQ92GtVK+0qzMpxcy/xJuWwqkXE7Ll5cpCFj1oI9qlnUt2HhHqoeBSFvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLEkbcyN; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b2e9e07a887so11527266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531605; x=1759136405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJqhgJyvnD5d6YT81nFGxO9YqrSRYT6f3jsmSzdijO4=;
        b=aLEkbcyNN1WH0O5YTKWL1yxKGpsOBWlbP2h/keD0HHYcPCwidbcLkj1/qVB4xVmRb4
         NYknK6o0gAwEbu1ac8LDhuPKcIhvhzyNxQfeTpeEfN+0j2vIG12ZuWjGk6ispIC+JXa1
         rCKMTJxpnvtpnxD42lPuugdliojSYJWK6wqTCv6b4renLeBplIUnR8a24poYAzUvFDTp
         ldvj/ZQZjSXapVTI6ugfQPx05YudRKl6wg/fwQCqrNTY/BoqmF3QtcbWkpSpQ5M4rySB
         BD9i2m+XcO6lPGuZUeBEdldwP7bcVes/F9XlkcZ3/+CC6gFuDSLx3erkjpdspT/DQNwT
         GofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531605; x=1759136405;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJqhgJyvnD5d6YT81nFGxO9YqrSRYT6f3jsmSzdijO4=;
        b=e9d1/2PtOeWDdTKVmc0wb/l8pQLpb9y08MGPVGw21xOHEmERRCPj2p3uIX1M+IQ/if
         Q+s2NdnyZqyIOwJ1frVa7RFRmf97F5f2jJZsMjDprC9c2jk6xtHtqm0CFeMRa555vH5C
         GI3B9zZoKb4WjQRquo1wbqDLThW2jsTfnflGnVoGbK4eCzSTnkCt8D2OgnfzRMPcl3nw
         GVNvEJEuGMGxOj+9V/gtZ2gxdHXPnGGaqDVCOB3UTok6MwqLuuSnUF32RlSyEWElEkih
         ubVn3/G1vvXl94r73qAREnGsnHIiA/v1ATe9Kd048gFu9mM05DmnuTYO9cQ2wcMubFa8
         Km0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrKwLGXCProZHEJd8V1+s3wHK6p2ksiJvbQec3QonA/2nyMrFkFQFLmWJS+kdKi48yfBRzY7Azst0OGHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXbxGCjnWgrsH9qKQZcYClDxGFvoXr3pww8MFyjV1QHZ+Fd0C
	S34tMg7mVErPAoOHtS3U8snx7u2gdfWQ3XxVenbaFnU325GI3MhSSlYoIkyrpcMWuaWfO5bwfBq
	K+l4reP2une/r0Q==
X-Google-Smtp-Source: AGHT+IF+yNxN8u0Kn/bBdnRnggKLG4SBwNB4ClzRlBvae+pc7iApwAt2kx062VQ8LZ+b/9dnodHumoEI9ZZgHg==
X-Received: from edf16.prod.google.com ([2002:a05:6402:21d0:b0:633:2fbe:a0c9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:948c:b0:b14:53a0:5c61 with SMTP id a640c23a62f3a-b24eca014ccmr1430032766b.12.1758531605450;
 Mon, 22 Sep 2025 02:00:05 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-1-smostafa@google.com>
Subject: [PATCH v4 0/4] Move io-pgtable-arm selftest to KUnit
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


Main changes in v4:
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
 drivers/iommu/io-pgtable-arm-selftests.c | 222 +++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 204 ---------------------
 4 files changed, 229 insertions(+), 209 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c


base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
--=20
2.51.0.534.gc79095c0ca-goog


