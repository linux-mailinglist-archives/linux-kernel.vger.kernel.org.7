Return-Path: <linux-kernel+bounces-818275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1E3B58F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC01321D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC912E62C0;
	Tue, 16 Sep 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Qa4Ijn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A02E62CB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007972; cv=none; b=Wc/o0ao5IOFYQHCWBZdJpnRIxyyaKvuyPTkNj0opFgCYBzYcS7uTc0BH76WaJFSlSD41TVglKnFaK5mPm6rornGl35j0bia2ucd11sl6o2JW6hmUnBPcH/Hiq6bmFoGa8la4MXjkfERRck882psN27XlpWCNBxbykt9R3/fRXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007972; c=relaxed/simple;
	bh=N9FJ77KjbInqACHNXJGNItslR4IJ1lfdL0wiP4soTAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIqWZQW2aCH27w2Eb0G8z1kDdO9uXAgKqFQ1igPEqRj0lxop1g4yiiw6tRn7a17NIBNfDXn0C4INggdZU6HgxMe8NnuLYG9syeVS78XEt4Zk/a2pmvhGM0KpCLM7QQpCiyWxIWi7Am4f+YoZrRj+HC1Kb7zZZBLQ61SolltAvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Qa4Ijn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244582738b5so42349775ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758007970; x=1758612770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qd6DcxlmgvS9aQ39BofpAaJyzv4vGOwbyL9YtDUN+E=;
        b=m2Qa4Ijn2mxy8enfCvmeaMmg9GFqbOHxXc3MuIU/4bMbexqAKgaZbnX9tSKVw18hk+
         8gfSxH9ZaJyXKZbMMvdo0LlR07vf7W8fzD8k7gF1JvChlyPHO/AtrWTj6bjWNdck05U7
         7J870ZLkA6DnxAvjl0VcxPLC0OktYncMk2CHJlcGVJaUvo4mDi0zhuPa+DQ5H+Ry7L1X
         MZOApOBQMuIm8zart8vdAEQz7CFR39hwkU5iFSDXIhZWVVuCEqFzkPnAidiuP2Mjjwb7
         KCniv3rHwEu7i57aG1Tc22Oj3aQb9sChE0iywl2qPlDVCOQlFUaf0TGtWsOVAtW7ZZd0
         mmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007970; x=1758612770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qd6DcxlmgvS9aQ39BofpAaJyzv4vGOwbyL9YtDUN+E=;
        b=CAKrWhO9B/iDtsvelA7k1Aoepka4Xrq0ycSApfn3rPqrFe/tFiqSOxmCwGqn+qHcJI
         lzqenmcV8EounJrd+q5ofI4L0LRJqsnDgj1NtvP/scmHS5JfG0oVafOg45qIERR2xDYf
         dysOVCYUv/sI/4GsoRDOHnQyOlAEM9xcxDltlt2iJZIiOlSmN4Wfr9uhfUoSz2izA33h
         nAVjxi+NprkgqHKKa/AWIVZhy+NkGssMEeh3d7Ta/sOJuwG988UZOST1uo+mJDSQRzZs
         kUE3WjuNjH2pf2QqeT2jbXXS8grQaMrtBpZfD+qEmY8dFZVAweymYkw6gvcEcfup09ax
         OJzg==
X-Gm-Message-State: AOJu0Yx7kEY53p+wnX85NNOmKSdY1/Ge64TMLx5KuDj2yT1kMrzHdCzq
	ypLoENlUN1naxCJxHKuO7dihMNai9Pz1qorilRI6jt0ezPgBH8IwfrPQ
X-Gm-Gg: ASbGnctTJGUD//Ru6vznvAq8/BWzKf5ngVAbzuVS2dzN87cRVF1o0euhQkpr9juihKx
	DfOWXkIsmC1hfZk4CQiHj/qmyb9zaqEdNESt9yMFr1NcJ/KZQqSS3z1RuhzxvY8rQMUFrLoJXlL
	Ju8xmG00mJEHGEwaun2FN5TFbeFNqAVAkZkpWCZPdfKQrNH8fOvyIt2xuGalyKmndYx59uC2Qju
	15tOmkJGCzpoDiHkWtbaW7LfbvnEpkAQVWKun3AiE1yafjkyV0khMbRIj/tPrV5vxEbmM/8XXZi
	9/uV1T0od5z+ApccPXXEg+mrG4G7BXVY7EBlQJU3xXRl85xqL2lRzNBX3eXiP2Od59vx3mHHk+u
	MlYG7q8qPhEMAAiZAkJmLu4xWJA==
X-Google-Smtp-Source: AGHT+IHlbmq3NUjDyNUWNQ8tAOhUsvQKoh9Ue8wE7ppuENj9P3s/gzDN/spStNwgHsIAuFNeDLKPCw==
X-Received: by 2002:a17:902:d552:b0:260:df70:f753 with SMTP id d9443c01a7336-260df70fbdcmr155594815ad.38.1758007969606;
        Tue, 16 Sep 2025 00:32:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm62519565ad.45.2025.09.16.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:32:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C3A3D420A809; Tue, 16 Sep 2025 14:32:46 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Tue, 16 Sep 2025 14:32:44 +0700
Message-ID: <20250916073244.590483-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=bagasdotme@gmail.com; h=from:subject; bh=aM5ZPpX4fqugAwD2VJ1FrGnAK405eAtLfQy6ZZ52Yw0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknhWZFd3WWtGtoM9yXDbww+3fr66cpFqfUHhvJL1B4b 7c0WJi/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZvIThn/Jabq7HecJ/DS5a xCfKC2cIWgRuZtcsXP5+/05pNakER0aGxudvNxw2E3l3m+NU+fddXTwvq9hfbvN+dO2vn9LuFda FDAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>

Since the Handover Protocol was deprecated, the recommended approach is
to provide an initrd using a UEFI boot service with the
LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
approach has been no more than an admonition with a link to an existing
implementation.

Provide a short explanation of this functionality, to ease future
implementations without having to reverse engineer existing ones.

Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
[Bagas: Don't use :ref: link to EFI stub documentation and refer to
OVMF/edk2 implementation]
Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  * Apply wording suggestion (Ard)
  * Replace candyboot reference with OVMF (Ard)
  * Invert patch subject prefix

[1]: https://lore.kernel.org/linux-doc/20250910015738.14848-2-bagasdotme@gmail.com/

 Documentation/admin-guide/efi-stub.rst |  3 ++
 Documentation/arch/x86/boot.rst        | 38 ++++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e1897..f8e7407698bd2a 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
 which understands relative paths, whereas the rest of the command line
 is passed to bzImage.efi.
 
+.. hint::
+   It is also possible to provide an initrd using a Linux-specific UEFI
+   protocol at boot time. See :ref:`pe-coff-entry-point` for details.
 
 The "dtb=" option
 -----------------
diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 77e6163288db08..32eea3d2807e1c 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1431,12 +1431,34 @@ The boot loader *must* fill out the following fields in bp::
 All other fields should be zero.
 
 .. note::
-     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
-     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
-     loading protocol (refer to [0] for an example of the bootloader side of
-     this), which removes the need for any knowledge on the part of the EFI
-     bootloader regarding the internal representation of boot_params or any
-     requirements/limitations regarding the placement of the command line
-     and ramdisk in memory, or the placement of the kernel image itself.
+   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+   entry point described below.
 
-[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _pe-coff-entry-point:
+
+PE/COFF entry point
+===================
+
+When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
+regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
+implementation details.
+
+The stub loader can request the initrd via a UEFI protocol. For this to work,
+the firmware or bootloader needs to register a handle which carries
+implementations of the ``EFI_LOAD_FILE2`` protocol and the device path
+protocol exposing the ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.
+In this case, a kernel booting via the EFI stub will invoke
+``LoadFile2::LoadFile()`` method on the registered protocol to instruct the
+firmware to load the initrd into a memory location chosen by the kernel/EFI
+stub.
+
+This approach removes the need for any knowledge on the part of the EFI
+bootloader regarding the internal representation of boot_params or any
+requirements/limitations regarding the placement of the command line and
+ramdisk in memory, or the placement of the kernel image itself.
+
+For sample implementations, refer to `the original u-boot implementation`_ or
+`the OVMF implementation`_.
+
+.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _the OVMF implementation: https://github.com/tianocore/edk2/blob/1780373897f12c25075f8883e073144506441168/OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.c

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


