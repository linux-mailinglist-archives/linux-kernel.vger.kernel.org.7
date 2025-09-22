Return-Path: <linux-kernel+bounces-826838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31FB8F776
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D37717FA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015132ED16C;
	Mon, 22 Sep 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkZMndsS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05C3208
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529214; cv=none; b=EzI9oqtTFHGSsKVeOasjcOv4z6ngpJsGtfu+x0P7qf1oD2alk3gKqWnLhTcl9K7bKMlZDI9pp2R8zOMQ76ialcJ1hzLtDaBWHZxu+LTVXSvtCpuQnaY2zrWHnmarH/L3tJvAg7Rzwsv6p59EIybfHMn6l5515s3z0QPxJsYfHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529214; c=relaxed/simple;
	bh=k7LHQaAqQB2O6eeT+FSaJv37gsGqHstNS+KGeKBNKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rO1VVGiK+eOA5hZxOOmM4bOlmFvBAq6ia00fHSADHMNbqE27TW0Oukag0md1IYzmpcTmIlGLehDeIg5iTXGkl7Gzg/6lMBolKFjry1RDCMSNkmbjISwqGUammwtoVtoCyFgOcCN2BqwmBZ7DwEEiN2gehl/5qZs4Xs3DLalOaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkZMndsS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so43409025ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529212; x=1759134012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQpw+mpVAsvBdtQIBEFkOZLcYioW8i+5zjuZhWL6i4g=;
        b=lkZMndsSGYOcwpwLi/mmNIY6je3qpux2J2MH/0aAf4zqTiF5EAE+xNEhOkmgd/oIJf
         qLZeeItiDGVlq3XxgzYtHDMKY0kiEOgOVzk9APPfw89aSXlDi915QFwONqt/1wYe5Rf7
         +nuftGDlEtFWUQzGU3F9IaGYzWN6sBBSlZkH0OSqxYT4RoFgyauTYTDH9+QQHLOzQByM
         UcGBUxg3Yoc5L43kQ/fb3xgFhmI7HdJDnaFr5nJo8/ufgVO0taIqpgoflG+ZnylIpLj+
         5KAK9PcNUT6Uh9qGZb77l/Jcxplc9sNLoYQCmS3wtyIRpOP1hxXstWuvl4oXKwbVu9ZW
         M/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529212; x=1759134012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQpw+mpVAsvBdtQIBEFkOZLcYioW8i+5zjuZhWL6i4g=;
        b=jfs+aoHvmIMjV0wxCO0K5RnlehaeImmFVftvgY8Xm5OUsTJfEpX3b6+B6ElN9JZ3wW
         tzHaZF4aIGa7nnD2tLGns6/vgu8ZGntHb9bqwlsZ6726Yw5Sv5ppRQD26LHmQvK/ENH2
         TvflnPtF1wfSRzoRtUsUNK8eBfJR4SWYjUKpn784AroEM0BsjaV4lo4Ldn1YIlxQiAsp
         6zQzSBm5G67RrnTKwmTvMmqj5N65CMP67xr5Ax9864vXDz3AIN6CHu4qlpIROg9/88wz
         S0OwARH0xxLWAC5RgUAzu6YsoJzpqMEx0L22cVbavzq7h5fxn0nnAgsPeIDF+SV9LKcH
         b6Wg==
X-Gm-Message-State: AOJu0YxuHFHVdVzbkEsQvWrDF8OOLYh6ZeupOvsDcIBGiWPaoeRr8zSI
	YgJb1jumqfd1Lv8Q5LQjQPkygF6u3UnYnOSoRg0XWJpE4ofGa8DYW5L0
X-Gm-Gg: ASbGnctAyQpqmYL8eU064Z3oSZ/1Fnp9D7rn1bm5wCUa3vyfwuqJLOA1cV5FKlHSzxP
	tJfs2d+PyY2NgiEsTDDIX/7G+MgG0mgnaR7njF4lbsYX2VVpzEnPlAu6bOWtdQ44NR5PEmjEFle
	ln9QCF+DZ523zdFpWiNIaKSHQDpzw82P8IPYMiQ+z2CoDsnGnQQN56Vq9+hDOiPn8RIYDKQ3Vfz
	CAVYY2OwJPWDYkYZA9Rg5RpY+dZ1jHUfgbKfdza4gaCY5+Ul5oUVXNOuvhgb6Gpqc1h7GxQ5TBf
	4ntnpVdOJ0Ao7MEVKXZqQN7g9hwVwCgGxrUOAU4NbTS0gq6KsI6Alb6mRCinCGnXqcPiRPh9z8X
	5QbyVCTNhgIH8PHiyM9HpYA==
X-Google-Smtp-Source: AGHT+IF2a3PSxs2bxKScnwskkO0GAHaWv2ekgx1ekGZgO5VTfxyWgSGB0bcGAJEx/TYLb/Yjr6JF4g==
X-Received: by 2002:a17:902:ecd1:b0:267:af07:6528 with SMTP id d9443c01a7336-269ba50848bmr151819735ad.35.1758529211786;
        Mon, 22 Sep 2025 01:20:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26b59d6538bsm89333815ad.82.2025.09.22.01.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:20:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 35184423FA7F; Mon, 22 Sep 2025 15:20:08 +0700 (WIB)
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
Subject: [PATCH v2 RESEND] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Mon, 22 Sep 2025 15:19:56 +0700
Message-ID: <20250922081956.29481-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566; i=bagasdotme@gmail.com; h=from:subject; bh=XSbt357ND7lSdI4W7HqeiIfehFqa8m3jg5LexXIM9g4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX2Xw7rHJ2FrQUHFvKUnW+6v45zwNFxzevU85leH6l6 kg7p3B/RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSn8vwP56tO15i+tynK3Qq mpSKBC//OdER+FK6i9Nhkb3dLGcvb4Z/lub3pon+vWxY/eyO547JnuHHNS1ZhcV+PD7zXZ6DzzS EFwA=
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

base-commit: 348011753d99b146c190aae262ee361d03cb0c5e
prerequisite-patch-id: 1cff30305281c1f018f9e5dbd95f0c6a2d1db116
-- 
An old man doll... just what I always wanted! - Clara


