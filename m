Return-Path: <linux-kernel+bounces-821509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC9B81723
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577D37B95D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498392C327E;
	Wed, 17 Sep 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzmpWfsz"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973A288C14
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136313; cv=none; b=PUd1fq2y/i9iPBH7iMKKp2HgTXL+9WfVw4oCjBuKXHg7Yg43f2Y5KmM8dJ8d7IxzXDJkuq5Qd8EC1kgd5StUw4aNlZ/XfuuV6+LjC92e4rj4tryuM9PtZqqM38TguaHNpMY0vrJDMCPEutSwrCVJArQ7gQYhjz2hfhFhg8C0rrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136313; c=relaxed/simple;
	bh=zyYW8dcPF6nH0CH0mjDbF/3PaopVMstsvWyWj5xGv1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GWBQPaRTDSqftVnWUfcfX4rozXLK83nikNyz5sGMG9Vu5WgcEuhvaju/J2r/7uATJJLCrNvc6SK8p6H1M+hq6eCnWwzxX3q5CGegJXBMa+2wAcKyGp1hPKWfqCM4/h9nCH6PfhS0ztOckviRpUm4ypD+tH0Ge2nSkvQWXtCJbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzmpWfsz; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e997eb7232so25826f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136310; x=1758741110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrARdai4TIWekf9/RUNeq+VchPKlvV4Ou8tril+TVSA=;
        b=QzmpWfszXmv2MC0yPdBThG/W6I32JVYwraklF4TyNTB/qye7elQu7ryHnXPme7vQ23
         2UMmbZn+9OrldzKdg6suo19qZyJji3bxUiNYrQhPTWGDrd5drxVJJuMC9gs4By3Jj/nq
         yOvfn0tLCPWF/cmzNeR+WUzTj2lHOMWKTzM+NlmD1FevsSovQFiZxRlXo218tvI1aUkz
         0HP1whzLC03/4AfKkPrrRiGDOypmcYpBZBp6J49tkCFA53bVs1UgdCaJ197iy2x7Awik
         LzKN2LXQ49dW78eCpUOiNuxJnwFujSAk73pmNwLyuaaR1Wk+FhEeNxaLIHSt0r5ejEy0
         KF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136310; x=1758741110;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrARdai4TIWekf9/RUNeq+VchPKlvV4Ou8tril+TVSA=;
        b=hj1Z3qGbHBJookt0cRLhRt74AgzjFRLw6TYUk9V8MUA8fFLLKG96qxJnVHMrC9e53O
         WdTYo2Fnnq0CszqoycC16kM10y+8N/P2mZiQlBcNA7G2HBYWJIvrqqKzuir0iTzYj2/2
         D0HTWfk+F2f1XIH0g8KWX6WxYMoBD06R4cejqUqp/01SbTGA839LfAnCi49Ry92sQm3S
         EDYvKua6KnnbBMtyJElDfV6uQ33859Rb3fXZaDf0xMqptSOak0Mzum8rfQ6HagomEWg/
         cl21ZO++EzxcrsBSQtOUmgXDoLJKr3nmSndUpidw9HwPybeSMUmcybesHaKQCehUUVUT
         9I2w==
X-Forwarded-Encrypted: i=1; AJvYcCUTHTPhFhiVleNZWH2DF6n+D5PHhDQtWoIrJO0QU2Y39s0+nee79NOSONjG7DicfUBUpkxVw76dMUYDyHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpDmFib6d1+L2kXEYdvGYSnBUqMsXLM31GPAdD2exwguj6Rk/
	LeE68A/wFC/Hb+lMVVXYB40fYzj6fhCLq5/EHcY5v/bfEk1cx9sobeyrnrXorK4Irg+cZfYaIkr
	BUq1+9Orn5mnRFA==
X-Google-Smtp-Source: AGHT+IE/wSFEaSIOL/io/GqUMdS/4N3/l1Wv9TP9hRQ2M6LcztpPNng5dXrReb1gF9DuJgNotR8IDC9W3BF9Qg==
X-Received: from wmlv10.prod.google.com ([2002:a05:600c:214a:b0:45b:9c60:76bb])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186d:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3ecdf9b8549mr2676797f8f.3.1758136309966;
 Wed, 17 Sep 2025 12:11:49 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:11:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191143.3847487-1-smostafa@google.com>
Subject: [PATCH v2 0/3] Move io-pgtable-arm selftest to KUnit
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a small series to clean up the io-pgtable-arm library.

The first patch was originally part of the SMMUv3 KVM driver support[1],
which needed to factor out the kernel code from the io-pgtable-arm
library, and based on Jason=E2=80=99s suggestion this can be taken out as a
cleanup, and a step further to convert it to kunit.

The first patch just moves the code to a new file with no other changes,
so it can be easier to review with =E2=80=9C--color-moved=E2=80=9D

The second patch converts the sefltest to be modular, that is useful as
kunit can be a module and it can run anytime after boot.

The third patch registers the test using kunit, and converges some of
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


Testing:
--------
- With CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=3Dy
  It will automatically run at boot as before this patch series.

- Otherwise with CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=3Dm:
  1) on module load:
     Once the module load the self test will run
     # modprobe io-pgtable-arm-selftests

  2) debugfs
     With CONFIG_KUNIT_DEBUGFS=3Dy You can run the test with
     # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run

  3) Using kunit.py
     You can also use the helper script which uses Qemu in the background

     # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --a=
rch arm64 \
       --make_options LLVM=3D1 --kunitconfig ./kunit/kunitconfig
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D io-pgtable-arm-tes=
t (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      [18:01:09] [PASSED] arm_lpae_do_selftests
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] io-=
pgtable-arm-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      [18:01:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A failure at the test with the new implementation look as

[   66.624469]     # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/i=
ommu/io-pgtable-arm-selftests.c:154
[   66.624505]     # arm_lpae_do_selftests: selftest: test failed for fmt i=
dx 0
[   66.624524]     # arm_lpae_do_selftests: cfg: pgsize_bitmap 0x20010000, =
ias 48-bit
[   66.624669]     # arm_lpae_do_selftests: data: 3 levels, 0x200 pgd_size,=
 16 pg_shift, 13 bits_per_level, pgd @ 00000000f200237d

Main changes in v2:
-------------------
- Make the test modular

v1: https://lore.kernel.org/linux-iommu/20250917140216.2199055-1-smostafa@g=
oogle.com/


[1] https://lore.kernel.org/all/20250819215156.2494305-5-smostafa@google.co=
m/


Mostafa Saleh (3):
  iommu/io-pgtable-arm: Move selftests to a separate file
  iommu/io-pgtable-arm-selftests: Modularize the test
  iommu/io-pgtable-arm-selftests: Use KUnit

 drivers/iommu/Kconfig                    |   4 +-
 drivers/iommu/Makefile                   |   1 +
 drivers/iommu/io-pgtable-arm-selftests.c | 226 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c           | 243 -----------------------
 drivers/iommu/io-pgtable-arm.h           |  41 ++++
 5 files changed, 270 insertions(+), 245 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

--=20
2.51.0.384.g4c02a37b29-goog


