Return-Path: <linux-kernel+bounces-842151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6DBB9173
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4FC1896532
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F6284671;
	Sat,  4 Oct 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7j348sz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91119D071
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759607925; cv=none; b=fhpxqYM5ysOugVBpj8/4DfPFGVEvIH+yBmvFjChDqWPLLH5B/jphgwMkBWdyhLtGYiruFfPHHZd8zMpDl0xbVF3f/673I9l+x+ztfCq9XyMmDjAL6YreHYf81uY+HndB1dNcZ9bZds7g5QW7DSYka9fW6zf4cxTBrjJtChMiC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759607925; c=relaxed/simple;
	bh=pMCt5So7d35T+EQJr6XS6fKwbUBcfWV1tFGLm+0+fk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RPB49vEjx2O89SjMB4G4gtVqzBXMP9uOt2NQiMNn5/ibHLG2zYAFLsShHM0/hHzzrCfU1RJvZEaxlVElaTyZHj+HeP5kzrr9YdmPtZNDCjhqmYPN+hCw3/q3bcbmxl0G2hnuuq/fDZB/ZVvuKGml6mmEQolFtJIuszNDZYFwXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7j348sz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-789fb76b466so3117661b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759607923; x=1760212723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDUXnOisudwg4cuwDop3UH0IpAiy5MdQyAMUD6KrYSM=;
        b=h7j348szm1hWErHr3oj7cyDHNZE6gQzOervWE7vUVMEOpx8KXr1P36oN6hjvDvVvUc
         A/FrI8Zyvp/uokp3q1pGAd+xiIAttFY7aacVmVi5wX8ItyoGe6wGVBm5NAnBBADcJq3f
         7zxFCyMIJBORyylUK2SQj68wExaNzebQSI2NS46fFu2SQ6+ORh0FpPwekx+CqVkU65+c
         WT8nTePV4NeoVU/IMN5w5QVENpMU8k7M6DXPhona+KksS8BUttHIaTBKr3Adxm/WgbfO
         7Kudi+3t7GT+gvgFzCdA8R5YuGV/uVxPngE1fmw2ZKpyqyTvGv1RWIGLT1BlwaJZnwEi
         i6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759607923; x=1760212723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDUXnOisudwg4cuwDop3UH0IpAiy5MdQyAMUD6KrYSM=;
        b=cu+IXtB9dqaDOcb4YRN/85comaI/2NUuWdUMcLGYmQduFITxaWDY4fwdKE2cbnt/ub
         qTNluccQWWBJYg3RG9WeYece8cw1uESRPSfB6wvlE7r3C2J3Ya2F307X56rUuFt5bZK0
         YNiUin9buE+FVKbVW0Ha7RgPeG6pFAA5PlRF6SNUd+ambjQngVB5m/upK1XPiMj+zZsO
         HoEMet3fD3dB4Q5+0cgH6/kIiUWTqJxkXR3zZolVDJo9fjMxzT9iyBbTTW0PGPuq6NTI
         WUD0of4LpnQw0Mw4IjAZEzTigKyPLllA93uCk5IW7A8JuG7ZlJApPlSLkrh4uF/LAQVK
         Eo2A==
X-Gm-Message-State: AOJu0YyOJXnaoZ70svldo/0Yc3cLAD+veUhG3VBp7rKmroCPdfD6uvbc
	Jo/jNLFiTz+t5kImJPg1LisXW9kIWBv3/MhV62f2vyfgHP59pnq1CfmX
X-Gm-Gg: ASbGncsHyzfmLBWSSXyE9NaCAW3hABVKEi2aDJYeySVlFX+ZTIbRSZXgSE2jJMXoqil
	iSOnkv720KkkunIW5ofGh63nSI6Rf9Y+SIx08NrmuLH0pn6OYMA1N3v7JPIblhOJMGVJo9tRHym
	dOrvr29dAU772pQ+0Q0a3LCRdWliQDwCXAGbiumo5/tHJMPsz8zWCXQPqFmJ+5fDsKIB9oUW5Dj
	z+W3f30Qivlk3eHWJT/L3mmqp+o9BVEh959EuSYM+xzHzCfgCNfiw1FIQBIKEv14PWiz8t3kN1I
	NZ8UXg7AM/s6z9IA260VVaeU2bhz8rooxPU+cOHj6ebDZ6y+arKvezGMdtoVGSdG4NOIG2zVTMy
	ELph6C9E+egJW2xQK2nhueXc1fJ0qCkRXeicYPA0Lh7opIZky
X-Google-Smtp-Source: AGHT+IFnCzzPoXkuwM4lENEctJ1L5p07eqsCrfMj5TPd3iUYnbW6H9x+DWodOKi+2J1pOPfJsino0g==
X-Received: by 2002:a05:6a20:4320:b0:2fc:a1a1:480a with SMTP id adf61e73a8af0-32b6209594amr10097686637.38.1759607922770;
        Sat, 04 Oct 2025 12:58:42 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e121e0afsm4482536a12.25.2025.10.04.12.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 12:58:42 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org,
	geert+renesas@glider.be,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] samples/vfs: Undefine conflicting AT_RENAME_* macros in test-statx
Date: Sun,  5 Oct 2025 01:28:34 +0530
Message-ID: <20251004195834.1415468-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test-statx program in samples/vfs/ includes both <stdio.h> and
usr/include/linux/fcntl.h, leading to redefinition errors for
AT_RENAME_NOREPLACE, AT_RENAME_EXCHANGE, and AT_RENAME_WHITEOUT. These
macros, defined in both glibc headers (via <stdio.h>, likely including
<fcntl.h>) and the kernel's usr/include/linux/fcntl.h, are not directly
used in test-statx.c but cause a build failure with -Werror due to
redefinition warnings like:

    In file included from samples/vfs/test-statx.c:23:
    usr/include/linux/fcntl.h:160:9: error: ‘AT_RENAME_NOREPLACE’ redefined [-Werror]
    160 | #define AT_RENAME_NOREPLACE     0x0001
        |         ^~~~~~~~~~~~~~~~~~~
    In file included from samples/vfs/test-statx.c:13:
    /usr/include/stdio.h:171:10: note: this is the location of the previous definition
    171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
        |          ^~~~~~~~~~~~~~~~~~~
    usr/include/linux/fcntl.h:161:9: error: ‘AT_RENAME_EXCHANGE’ redefined [-Werror]
    161 | #define AT_RENAME_EXCHANGE      0x0002
        |         ^~~~~~~~~~~~~~~~~~
    /usr/include/stdio.h:173:10: note: this is the location of the previous definition
    173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
        |          ^~~~~~~~~~~~~~~~~~
    usr/include/linux/fcntl.h:162:9: error: ‘AT_RENAME_WHITEOUT’ redefined [-Werror]
    162 | #define AT_RENAME_WHITEOUT      0x0004
        |         ^~~~~~~~~~~~~~~~~~
    /usr/include/stdio.h:175:10: note: this is the location of the previous definition
    175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
        |          ^~~~~~~~~~~~~~~~~~

Since test-statx relies on other kernel-specific definitions from
usr/include/linux/fcntl.h, this patch adds #undef directives for the
conflicting macros before including the kernel header, ensuring the
kernel's definitions are used without warnings.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 samples/vfs/test-statx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..17332100a2b5 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -20,6 +20,9 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/stat.h>
+#undef AT_RENAME_NOREPLACE
+#undef AT_RENAME_EXCHANGE
+#undef AT_RENAME_WHITEOUT
 #include <linux/fcntl.h>
 #define statx foo
 #define statx_timestamp foo_timestamp
-- 
2.51.0


