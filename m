Return-Path: <linux-kernel+bounces-899176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E0C56FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 181C43437D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07333B966;
	Thu, 13 Nov 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsX7NZ4m"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CD33ADAE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030759; cv=none; b=PtvqgX+LgUvlfmc+eKEgoSYnyGusQLAsBaUfOdK0ZG1Z6fEBXT0gSaUYFFvXI8KgnCk3/XHlxNqjAb55fAANAndWnBzgQ4Dab2hsxPzEeHHcu/dqa3wkZAxslVboBERFmPGSNiKyZITomjamRnnxFwjgzNb9ZqcfsFYf0Yljvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030759; c=relaxed/simple;
	bh=VOE2mrBRSbKJggM7luiOsOPrz2ctoXRXBLlNgQe8dZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdHGDp3kiUx+uT7t1qIQgG8mjlSfFRvO1+5eLCGfUsZYTqv9IPSDLXEsJMAnobIFDCvabsziOfP7+uGr/zHXwFEv+bFiVrDlo76O3gHTO+7hJe3Cp2rn6E/XshGeperEBADv8Tw40LtmTaIb+SUHcoX90A828q6Xy/qhI7qUUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsX7NZ4m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632b0621so4228335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030755; x=1763635555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp1VRC2JEKjPuru2Eyj6NZSpUbm3X6pTulMabwLhdU0=;
        b=YsX7NZ4mfMEFH+zaL14JBthfl7NcGr2pMHHOXlZOn6GeEpZkUgwMg/Ug2YalnNKfGb
         wz1m121w/X4QnrbTIdO8hDDrPwKM7EgCRKmb7wgyif2XCBCyLTSTC1bOR+OTvHdBEi3t
         DQOYi014SqJGPNPt/K+7b3OkUDg4FENzBkwyz1MdzGl0hOnNBe8Gx907oZsGWKrUmJGM
         ScQQucRsOEsxYP7PRs7xYxkp8G+ODGS6qn1RlsAccc/mqlGqDoVIupWeIzrnP/dJyic6
         dr4/9jjJ27FRanqxG9l81QX55opUTUGoIesES+qXeZkbGDWWC2tAQMJNQf5iynA3i3lo
         evrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030755; x=1763635555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cp1VRC2JEKjPuru2Eyj6NZSpUbm3X6pTulMabwLhdU0=;
        b=Pu2yoJi6MH4uI9NdEK5fuaut6wAtBC7LlP7/Ji/lWUMClqNOeC2QIv7Gr5rEkWWPuJ
         hLmBjbjxiLA2+QVDjOW2//rqcfBIRcYqNs5A+M5nSBNAwSUxwylizjd/X/2yU+hbeQpK
         xOxAj2T1FXbJ+cre+wKy+gi26OBVDG51G6hmCNklQi9tzM5uPkTcNiSqtlm5gnt7cHVR
         1VBDoxZNfS8i7ZOWTo4l0r/TJ9VXn1Ki8yce0wRrJ34jjYJdeSKvxTHva6sy8P4xIEfN
         nxHk+fLDSzkf2qOHXzGETMGd6zgfUQhBn9p0Et5KIHW1uOwLAAnpwDNS1aXtM5R4NIr9
         /XUA==
X-Forwarded-Encrypted: i=1; AJvYcCVsNYiXzqb/idGqfYqks3xX98c6fzia9om1EctfSbwRPsvG59vRoPy7CX/QzUc5VIqpoX4MXxdtigMihrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JdzoFNnpVVnKVHfnG2LsOZtX5z9MnAs4seYe1jiMeUwC74xO
	TI5GgQMEhjLo548vCkfZdaGmLkKulwfyTr3OE5v52k8//+rqKxv8QzgX
X-Gm-Gg: ASbGncsAedlDl+89PkJGStpL6ic/WgPIxnxVFpga7TdUwNsXdkFsfbo4igI9wzbHrp0
	R19ZEoXVUdTxIo7zPbaL1s/sB2Fo3cSI2dT5vBzQHTx4QVu4M+QPs8P1zqf2RJdaaTREvk6N9Ah
	nZGM8KzPRAJb1RFWoF7gldesGDrtF9QIo5Tc8sH3ey5G6GejJKVH7xjNHp5ZnUl8tAHVBy2Cs3f
	7o8VuTLTWqCrfgacv967N9tjgGoEcGjxVbugFcOgLBQSCjxK++wg8/aWyREiOluK/tZNbr2d6bk
	U8N0NyBViGAj9HiIuI2cMdB7yK10Qa85p8QEHtkJ3h2b9gwQTGQQDWwWGVmg/bdv9c1ySNNX5dl
	+f8KRiOF08/1VdbjXTqPXw7avwm+OB1AEX/lkE6cGTHO8j7MKvOTyo5j2Ft/26QqGUFMQXj9uJn
	6SQKzTc5aP+2aiGLGT
X-Google-Smtp-Source: AGHT+IGNUdYMnPQSzULTTDvc4smQFyDRy0LQORWZ45UYHS0koumqlMFBlV0yljo2tH8qvP2vjZVdRg==
X-Received: by 2002:a05:600c:4706:b0:477:3e07:217a with SMTP id 5b1f17b1804b1-477870be036mr56075675e9.36.1763030754948;
        Thu, 13 Nov 2025 02:45:54 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:54 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 6/6] gpib: Destage gpib
Date: Thu, 13 Nov 2025 11:45:43 +0100
Message-ID: <20251113104543.5875-7-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113104543.5875-1-dpenkler@gmail.com>
References: <20251113104543.5875-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib user space library needs the uapi header files in order to
communicate with the drivers. Copy the common include files from
staging/gpib/include/uapi to include/linux/uapi

Move the gpib tree out of staging to drivers.

Add the gpib Kconfig menu and Makefile build rule. The gpib Kconfig
menu has been added just after the related comedi drivers.

Remove the word "Linux" from the gpib Kconfig option title as
it adds no information.

MAINTAINERS: Change the gpib directory and add the uapi include files.
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 MAINTAINERS                                                   | 4 +++-
 drivers/Kconfig                                               | 2 ++
 drivers/Makefile                                              | 1 +
 drivers/{staging => }/gpib/Kconfig                            | 2 +-
 drivers/{staging => }/gpib/Makefile                           | 0
 drivers/{staging => }/gpib/TODO                               | 0
 drivers/{staging => }/gpib/agilent_82350b/Makefile            | 0
 drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.c    | 0
 drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.h    | 0
 drivers/{staging => }/gpib/agilent_82357a/Makefile            | 0
 drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.c    | 0
 drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.h    | 0
 drivers/{staging => }/gpib/cb7210/Makefile                    | 0
 drivers/{staging => }/gpib/cb7210/cb7210.c                    | 0
 drivers/{staging => }/gpib/cb7210/cb7210.h                    | 0
 drivers/{staging => }/gpib/cec/Makefile                       | 0
 drivers/{staging => }/gpib/cec/cec.h                          | 0
 drivers/{staging => }/gpib/cec/cec_gpib.c                     | 0
 drivers/{staging => }/gpib/common/Makefile                    | 0
 drivers/{staging => }/gpib/common/gpib_os.c                   | 0
 drivers/{staging => }/gpib/common/iblib.c                     | 0
 drivers/{staging => }/gpib/common/ibsys.h                     | 0
 drivers/{staging => }/gpib/eastwood/Makefile                  | 0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.c              | 0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.h              | 0
 drivers/{staging => }/gpib/fmh_gpib/Makefile                  | 0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.c                | 0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.h                | 0
 drivers/{staging => }/gpib/gpio/Makefile                      | 0
 drivers/{staging => }/gpib/gpio/gpib_bitbang.c                | 0
 drivers/{staging => }/gpib/hp_82335/Makefile                  | 0
 drivers/{staging => }/gpib/hp_82335/hp82335.c                 | 0
 drivers/{staging => }/gpib/hp_82335/hp82335.h                 | 0
 drivers/{staging => }/gpib/hp_82341/Makefile                  | 0
 drivers/{staging => }/gpib/hp_82341/hp_82341.c                | 0
 drivers/{staging => }/gpib/hp_82341/hp_82341.h                | 0
 drivers/{staging => }/gpib/include/amcc5920.h                 | 0
 drivers/{staging => }/gpib/include/amccs5933.h                | 0
 drivers/{staging => }/gpib/include/gpibP.h                    | 0
 drivers/{staging => }/gpib/include/gpib_cmd.h                 | 0
 drivers/{staging => }/gpib/include/gpib_pci_ids.h             | 0
 drivers/{staging => }/gpib/include/gpib_proto.h               | 0
 drivers/{staging => }/gpib/include/gpib_state_machines.h      | 0
 drivers/{staging => }/gpib/include/gpib_types.h               | 0
 drivers/{staging => }/gpib/include/nec7210.h                  | 0
 drivers/{staging => }/gpib/include/nec7210_registers.h        | 0
 drivers/{staging => }/gpib/include/plx9050.h                  | 0
 drivers/{staging => }/gpib/include/quancom_pci.h              | 0
 drivers/{staging => }/gpib/include/tms9914.h                  | 0
 drivers/{staging => }/gpib/include/tnt4882_registers.h        | 0
 drivers/{staging => }/gpib/ines/Makefile                      | 0
 drivers/{staging => }/gpib/ines/ines.h                        | 0
 drivers/{staging => }/gpib/ines/ines_gpib.c                   | 0
 drivers/{staging => }/gpib/lpvo_usb_gpib/Makefile             | 0
 drivers/{staging => }/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c      | 0
 drivers/{staging => }/gpib/nec7210/Makefile                   | 0
 drivers/{staging => }/gpib/nec7210/board.h                    | 0
 drivers/{staging => }/gpib/nec7210/nec7210.c                  | 0
 drivers/{staging => }/gpib/ni_usb/Makefile                    | 0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.c               | 0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.h               | 0
 drivers/{staging => }/gpib/pc2/Makefile                       | 0
 drivers/{staging => }/gpib/pc2/pc2_gpib.c                     | 0
 drivers/{staging => }/gpib/tms9914/Makefile                   | 0
 drivers/{staging => }/gpib/tms9914/tms9914.c                  | 0
 drivers/{staging => }/gpib/tnt4882/Makefile                   | 0
 drivers/{staging => }/gpib/tnt4882/mite.c                     | 0
 drivers/{staging => }/gpib/tnt4882/mite.h                     | 0
 drivers/{staging => }/gpib/tnt4882/tnt4882_gpib.c             | 0
 {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h      | 0
 .../staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h     | 0
 71 files changed, 7 insertions(+), 2 deletions(-)
 rename drivers/{staging => }/gpib/Kconfig (99%)
 rename drivers/{staging => }/gpib/Makefile (100%)
 rename drivers/{staging => }/gpib/TODO (100%)
 rename drivers/{staging => }/gpib/agilent_82350b/Makefile (100%)
 rename drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.c (100%)
 rename drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.h (100%)
 rename drivers/{staging => }/gpib/agilent_82357a/Makefile (100%)
 rename drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.c (100%)
 rename drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.h (100%)
 rename drivers/{staging => }/gpib/cb7210/Makefile (100%)
 rename drivers/{staging => }/gpib/cb7210/cb7210.c (100%)
 rename drivers/{staging => }/gpib/cb7210/cb7210.h (100%)
 rename drivers/{staging => }/gpib/cec/Makefile (100%)
 rename drivers/{staging => }/gpib/cec/cec.h (100%)
 rename drivers/{staging => }/gpib/cec/cec_gpib.c (100%)
 rename drivers/{staging => }/gpib/common/Makefile (100%)
 rename drivers/{staging => }/gpib/common/gpib_os.c (100%)
 rename drivers/{staging => }/gpib/common/iblib.c (100%)
 rename drivers/{staging => }/gpib/common/ibsys.h (100%)
 rename drivers/{staging => }/gpib/eastwood/Makefile (100%)
 rename drivers/{staging => }/gpib/eastwood/fluke_gpib.c (100%)
 rename drivers/{staging => }/gpib/eastwood/fluke_gpib.h (100%)
 rename drivers/{staging => }/gpib/fmh_gpib/Makefile (100%)
 rename drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.c (100%)
 rename drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.h (100%)
 rename drivers/{staging => }/gpib/gpio/Makefile (100%)
 rename drivers/{staging => }/gpib/gpio/gpib_bitbang.c (100%)
 rename drivers/{staging => }/gpib/hp_82335/Makefile (100%)
 rename drivers/{staging => }/gpib/hp_82335/hp82335.c (100%)
 rename drivers/{staging => }/gpib/hp_82335/hp82335.h (100%)
 rename drivers/{staging => }/gpib/hp_82341/Makefile (100%)
 rename drivers/{staging => }/gpib/hp_82341/hp_82341.c (100%)
 rename drivers/{staging => }/gpib/hp_82341/hp_82341.h (100%)
 rename drivers/{staging => }/gpib/include/amcc5920.h (100%)
 rename drivers/{staging => }/gpib/include/amccs5933.h (100%)
 rename drivers/{staging => }/gpib/include/gpibP.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_cmd.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_pci_ids.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_proto.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_state_machines.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_types.h (100%)
 rename drivers/{staging => }/gpib/include/nec7210.h (100%)
 rename drivers/{staging => }/gpib/include/nec7210_registers.h (100%)
 rename drivers/{staging => }/gpib/include/plx9050.h (100%)
 rename drivers/{staging => }/gpib/include/quancom_pci.h (100%)
 rename drivers/{staging => }/gpib/include/tms9914.h (100%)
 rename drivers/{staging => }/gpib/include/tnt4882_registers.h (100%)
 rename drivers/{staging => }/gpib/ines/Makefile (100%)
 rename drivers/{staging => }/gpib/ines/ines.h (100%)
 rename drivers/{staging => }/gpib/ines/ines_gpib.c (100%)
 rename drivers/{staging => }/gpib/lpvo_usb_gpib/Makefile (100%)
 rename drivers/{staging => }/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c (100%)
 rename drivers/{staging => }/gpib/nec7210/Makefile (100%)
 rename drivers/{staging => }/gpib/nec7210/board.h (100%)
 rename drivers/{staging => }/gpib/nec7210/nec7210.c (100%)
 rename drivers/{staging => }/gpib/ni_usb/Makefile (100%)
 rename drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.c (100%)
 rename drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.h (100%)
 rename drivers/{staging => }/gpib/pc2/Makefile (100%)
 rename drivers/{staging => }/gpib/pc2/pc2_gpib.c (100%)
 rename drivers/{staging => }/gpib/tms9914/Makefile (100%)
 rename drivers/{staging => }/gpib/tms9914/tms9914.c (100%)
 rename drivers/{staging => }/gpib/tnt4882/Makefile (100%)
 rename drivers/{staging => }/gpib/tnt4882/mite.c (100%)
 rename drivers/{staging => }/gpib/tnt4882/mite.h (100%)
 rename drivers/{staging => }/gpib/tnt4882/tnt4882_gpib.c (100%)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h (100%)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index df07d1a3c28d..a6055a910be6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10628,7 +10628,9 @@ F:	drivers/platform/x86/gpd-pocket-fan.c
 GPIB DRIVERS
 M:	Dave Penkler <dpenkler@gmail.com>
 S:	Maintained
-F:	drivers/staging/gpib/
+F:	drivers/gpib/
+F:	include/uapi/linux/gpib.h
+F:	include/uapi/linux/gpib_ioctl.h
 
 GPIO ACPI SUPPORT
 M:	Mika Westerberg <westeri@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4915a63866b0..01602581b880 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -161,6 +161,8 @@ source "drivers/greybus/Kconfig"
 
 source "drivers/comedi/Kconfig"
 
+source "drivers/gpib/Kconfig"
+
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 8e1ffa4358d5..d275b1526cdd 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
+obj-$(CONFIG_GPIB)		+= gpib/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 
diff --git a/drivers/staging/gpib/Kconfig b/drivers/gpib/Kconfig
similarity index 99%
rename from drivers/staging/gpib/Kconfig
rename to drivers/gpib/Kconfig
index aa01538d5beb..2f42aa2d55fd 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/gpib/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig GPIB
-	tristate "Linux GPIB drivers"
+	tristate "GPIB drivers"
 	help
 	  Enable support for GPIB cards and dongles for Linux.  GPIB
 	  is the General Purpose Interface Bus which conforms to the
diff --git a/drivers/staging/gpib/Makefile b/drivers/gpib/Makefile
similarity index 100%
rename from drivers/staging/gpib/Makefile
rename to drivers/gpib/Makefile
diff --git a/drivers/staging/gpib/TODO b/drivers/gpib/TODO
similarity index 100%
rename from drivers/staging/gpib/TODO
rename to drivers/gpib/TODO
diff --git a/drivers/staging/gpib/agilent_82350b/Makefile b/drivers/gpib/agilent_82350b/Makefile
similarity index 100%
rename from drivers/staging/gpib/agilent_82350b/Makefile
rename to drivers/gpib/agilent_82350b/Makefile
diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/gpib/agilent_82350b/agilent_82350b.c
similarity index 100%
rename from drivers/staging/gpib/agilent_82350b/agilent_82350b.c
rename to drivers/gpib/agilent_82350b/agilent_82350b.c
diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.h b/drivers/gpib/agilent_82350b/agilent_82350b.h
similarity index 100%
rename from drivers/staging/gpib/agilent_82350b/agilent_82350b.h
rename to drivers/gpib/agilent_82350b/agilent_82350b.h
diff --git a/drivers/staging/gpib/agilent_82357a/Makefile b/drivers/gpib/agilent_82357a/Makefile
similarity index 100%
rename from drivers/staging/gpib/agilent_82357a/Makefile
rename to drivers/gpib/agilent_82357a/Makefile
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/gpib/agilent_82357a/agilent_82357a.c
similarity index 100%
rename from drivers/staging/gpib/agilent_82357a/agilent_82357a.c
rename to drivers/gpib/agilent_82357a/agilent_82357a.c
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.h b/drivers/gpib/agilent_82357a/agilent_82357a.h
similarity index 100%
rename from drivers/staging/gpib/agilent_82357a/agilent_82357a.h
rename to drivers/gpib/agilent_82357a/agilent_82357a.h
diff --git a/drivers/staging/gpib/cb7210/Makefile b/drivers/gpib/cb7210/Makefile
similarity index 100%
rename from drivers/staging/gpib/cb7210/Makefile
rename to drivers/gpib/cb7210/Makefile
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/gpib/cb7210/cb7210.c
similarity index 100%
rename from drivers/staging/gpib/cb7210/cb7210.c
rename to drivers/gpib/cb7210/cb7210.c
diff --git a/drivers/staging/gpib/cb7210/cb7210.h b/drivers/gpib/cb7210/cb7210.h
similarity index 100%
rename from drivers/staging/gpib/cb7210/cb7210.h
rename to drivers/gpib/cb7210/cb7210.h
diff --git a/drivers/staging/gpib/cec/Makefile b/drivers/gpib/cec/Makefile
similarity index 100%
rename from drivers/staging/gpib/cec/Makefile
rename to drivers/gpib/cec/Makefile
diff --git a/drivers/staging/gpib/cec/cec.h b/drivers/gpib/cec/cec.h
similarity index 100%
rename from drivers/staging/gpib/cec/cec.h
rename to drivers/gpib/cec/cec.h
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/gpib/cec/cec_gpib.c
similarity index 100%
rename from drivers/staging/gpib/cec/cec_gpib.c
rename to drivers/gpib/cec/cec_gpib.c
diff --git a/drivers/staging/gpib/common/Makefile b/drivers/gpib/common/Makefile
similarity index 100%
rename from drivers/staging/gpib/common/Makefile
rename to drivers/gpib/common/Makefile
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
similarity index 100%
rename from drivers/staging/gpib/common/gpib_os.c
rename to drivers/gpib/common/gpib_os.c
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
similarity index 100%
rename from drivers/staging/gpib/common/iblib.c
rename to drivers/gpib/common/iblib.c
diff --git a/drivers/staging/gpib/common/ibsys.h b/drivers/gpib/common/ibsys.h
similarity index 100%
rename from drivers/staging/gpib/common/ibsys.h
rename to drivers/gpib/common/ibsys.h
diff --git a/drivers/staging/gpib/eastwood/Makefile b/drivers/gpib/eastwood/Makefile
similarity index 100%
rename from drivers/staging/gpib/eastwood/Makefile
rename to drivers/gpib/eastwood/Makefile
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/gpib/eastwood/fluke_gpib.c
similarity index 100%
rename from drivers/staging/gpib/eastwood/fluke_gpib.c
rename to drivers/gpib/eastwood/fluke_gpib.c
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.h b/drivers/gpib/eastwood/fluke_gpib.h
similarity index 100%
rename from drivers/staging/gpib/eastwood/fluke_gpib.h
rename to drivers/gpib/eastwood/fluke_gpib.h
diff --git a/drivers/staging/gpib/fmh_gpib/Makefile b/drivers/gpib/fmh_gpib/Makefile
similarity index 100%
rename from drivers/staging/gpib/fmh_gpib/Makefile
rename to drivers/gpib/fmh_gpib/Makefile
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh_gpib.c
similarity index 100%
rename from drivers/staging/gpib/fmh_gpib/fmh_gpib.c
rename to drivers/gpib/fmh_gpib/fmh_gpib.c
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.h b/drivers/gpib/fmh_gpib/fmh_gpib.h
similarity index 100%
rename from drivers/staging/gpib/fmh_gpib/fmh_gpib.h
rename to drivers/gpib/fmh_gpib/fmh_gpib.h
diff --git a/drivers/staging/gpib/gpio/Makefile b/drivers/gpib/gpio/Makefile
similarity index 100%
rename from drivers/staging/gpib/gpio/Makefile
rename to drivers/gpib/gpio/Makefile
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/gpib/gpio/gpib_bitbang.c
similarity index 100%
rename from drivers/staging/gpib/gpio/gpib_bitbang.c
rename to drivers/gpib/gpio/gpib_bitbang.c
diff --git a/drivers/staging/gpib/hp_82335/Makefile b/drivers/gpib/hp_82335/Makefile
similarity index 100%
rename from drivers/staging/gpib/hp_82335/Makefile
rename to drivers/gpib/hp_82335/Makefile
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/gpib/hp_82335/hp82335.c
similarity index 100%
rename from drivers/staging/gpib/hp_82335/hp82335.c
rename to drivers/gpib/hp_82335/hp82335.c
diff --git a/drivers/staging/gpib/hp_82335/hp82335.h b/drivers/gpib/hp_82335/hp82335.h
similarity index 100%
rename from drivers/staging/gpib/hp_82335/hp82335.h
rename to drivers/gpib/hp_82335/hp82335.h
diff --git a/drivers/staging/gpib/hp_82341/Makefile b/drivers/gpib/hp_82341/Makefile
similarity index 100%
rename from drivers/staging/gpib/hp_82341/Makefile
rename to drivers/gpib/hp_82341/Makefile
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/gpib/hp_82341/hp_82341.c
similarity index 100%
rename from drivers/staging/gpib/hp_82341/hp_82341.c
rename to drivers/gpib/hp_82341/hp_82341.c
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.h b/drivers/gpib/hp_82341/hp_82341.h
similarity index 100%
rename from drivers/staging/gpib/hp_82341/hp_82341.h
rename to drivers/gpib/hp_82341/hp_82341.h
diff --git a/drivers/staging/gpib/include/amcc5920.h b/drivers/gpib/include/amcc5920.h
similarity index 100%
rename from drivers/staging/gpib/include/amcc5920.h
rename to drivers/gpib/include/amcc5920.h
diff --git a/drivers/staging/gpib/include/amccs5933.h b/drivers/gpib/include/amccs5933.h
similarity index 100%
rename from drivers/staging/gpib/include/amccs5933.h
rename to drivers/gpib/include/amccs5933.h
diff --git a/drivers/staging/gpib/include/gpibP.h b/drivers/gpib/include/gpibP.h
similarity index 100%
rename from drivers/staging/gpib/include/gpibP.h
rename to drivers/gpib/include/gpibP.h
diff --git a/drivers/staging/gpib/include/gpib_cmd.h b/drivers/gpib/include/gpib_cmd.h
similarity index 100%
rename from drivers/staging/gpib/include/gpib_cmd.h
rename to drivers/gpib/include/gpib_cmd.h
diff --git a/drivers/staging/gpib/include/gpib_pci_ids.h b/drivers/gpib/include/gpib_pci_ids.h
similarity index 100%
rename from drivers/staging/gpib/include/gpib_pci_ids.h
rename to drivers/gpib/include/gpib_pci_ids.h
diff --git a/drivers/staging/gpib/include/gpib_proto.h b/drivers/gpib/include/gpib_proto.h
similarity index 100%
rename from drivers/staging/gpib/include/gpib_proto.h
rename to drivers/gpib/include/gpib_proto.h
diff --git a/drivers/staging/gpib/include/gpib_state_machines.h b/drivers/gpib/include/gpib_state_machines.h
similarity index 100%
rename from drivers/staging/gpib/include/gpib_state_machines.h
rename to drivers/gpib/include/gpib_state_machines.h
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/gpib/include/gpib_types.h
similarity index 100%
rename from drivers/staging/gpib/include/gpib_types.h
rename to drivers/gpib/include/gpib_types.h
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/gpib/include/nec7210.h
similarity index 100%
rename from drivers/staging/gpib/include/nec7210.h
rename to drivers/gpib/include/nec7210.h
diff --git a/drivers/staging/gpib/include/nec7210_registers.h b/drivers/gpib/include/nec7210_registers.h
similarity index 100%
rename from drivers/staging/gpib/include/nec7210_registers.h
rename to drivers/gpib/include/nec7210_registers.h
diff --git a/drivers/staging/gpib/include/plx9050.h b/drivers/gpib/include/plx9050.h
similarity index 100%
rename from drivers/staging/gpib/include/plx9050.h
rename to drivers/gpib/include/plx9050.h
diff --git a/drivers/staging/gpib/include/quancom_pci.h b/drivers/gpib/include/quancom_pci.h
similarity index 100%
rename from drivers/staging/gpib/include/quancom_pci.h
rename to drivers/gpib/include/quancom_pci.h
diff --git a/drivers/staging/gpib/include/tms9914.h b/drivers/gpib/include/tms9914.h
similarity index 100%
rename from drivers/staging/gpib/include/tms9914.h
rename to drivers/gpib/include/tms9914.h
diff --git a/drivers/staging/gpib/include/tnt4882_registers.h b/drivers/gpib/include/tnt4882_registers.h
similarity index 100%
rename from drivers/staging/gpib/include/tnt4882_registers.h
rename to drivers/gpib/include/tnt4882_registers.h
diff --git a/drivers/staging/gpib/ines/Makefile b/drivers/gpib/ines/Makefile
similarity index 100%
rename from drivers/staging/gpib/ines/Makefile
rename to drivers/gpib/ines/Makefile
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/gpib/ines/ines.h
similarity index 100%
rename from drivers/staging/gpib/ines/ines.h
rename to drivers/gpib/ines/ines.h
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
similarity index 100%
rename from drivers/staging/gpib/ines/ines_gpib.c
rename to drivers/gpib/ines/ines_gpib.c
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/Makefile b/drivers/gpib/lpvo_usb_gpib/Makefile
similarity index 100%
rename from drivers/staging/gpib/lpvo_usb_gpib/Makefile
rename to drivers/gpib/lpvo_usb_gpib/Makefile
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
similarity index 100%
rename from drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
rename to drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
diff --git a/drivers/staging/gpib/nec7210/Makefile b/drivers/gpib/nec7210/Makefile
similarity index 100%
rename from drivers/staging/gpib/nec7210/Makefile
rename to drivers/gpib/nec7210/Makefile
diff --git a/drivers/staging/gpib/nec7210/board.h b/drivers/gpib/nec7210/board.h
similarity index 100%
rename from drivers/staging/gpib/nec7210/board.h
rename to drivers/gpib/nec7210/board.h
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/gpib/nec7210/nec7210.c
similarity index 100%
rename from drivers/staging/gpib/nec7210/nec7210.c
rename to drivers/gpib/nec7210/nec7210.c
diff --git a/drivers/staging/gpib/ni_usb/Makefile b/drivers/gpib/ni_usb/Makefile
similarity index 100%
rename from drivers/staging/gpib/ni_usb/Makefile
rename to drivers/gpib/ni_usb/Makefile
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/gpib/ni_usb/ni_usb_gpib.c
similarity index 100%
rename from drivers/staging/gpib/ni_usb/ni_usb_gpib.c
rename to drivers/gpib/ni_usb/ni_usb_gpib.c
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.h b/drivers/gpib/ni_usb/ni_usb_gpib.h
similarity index 100%
rename from drivers/staging/gpib/ni_usb/ni_usb_gpib.h
rename to drivers/gpib/ni_usb/ni_usb_gpib.h
diff --git a/drivers/staging/gpib/pc2/Makefile b/drivers/gpib/pc2/Makefile
similarity index 100%
rename from drivers/staging/gpib/pc2/Makefile
rename to drivers/gpib/pc2/Makefile
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/gpib/pc2/pc2_gpib.c
similarity index 100%
rename from drivers/staging/gpib/pc2/pc2_gpib.c
rename to drivers/gpib/pc2/pc2_gpib.c
diff --git a/drivers/staging/gpib/tms9914/Makefile b/drivers/gpib/tms9914/Makefile
similarity index 100%
rename from drivers/staging/gpib/tms9914/Makefile
rename to drivers/gpib/tms9914/Makefile
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/gpib/tms9914/tms9914.c
similarity index 100%
rename from drivers/staging/gpib/tms9914/tms9914.c
rename to drivers/gpib/tms9914/tms9914.c
diff --git a/drivers/staging/gpib/tnt4882/Makefile b/drivers/gpib/tnt4882/Makefile
similarity index 100%
rename from drivers/staging/gpib/tnt4882/Makefile
rename to drivers/gpib/tnt4882/Makefile
diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/gpib/tnt4882/mite.c
similarity index 100%
rename from drivers/staging/gpib/tnt4882/mite.c
rename to drivers/gpib/tnt4882/mite.c
diff --git a/drivers/staging/gpib/tnt4882/mite.h b/drivers/gpib/tnt4882/mite.h
similarity index 100%
rename from drivers/staging/gpib/tnt4882/mite.h
rename to drivers/gpib/tnt4882/mite.h
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/gpib/tnt4882/tnt4882_gpib.c
similarity index 100%
rename from drivers/staging/gpib/tnt4882/tnt4882_gpib.c
rename to drivers/gpib/tnt4882/tnt4882_gpib.c
diff --git a/drivers/staging/gpib/uapi/gpib.h b/include/uapi/linux/gpib.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib.h
rename to include/uapi/linux/gpib.h
diff --git a/drivers/staging/gpib/uapi/gpib_ioctl.h b/include/uapi/linux/gpib_ioctl.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib_ioctl.h
rename to include/uapi/linux/gpib_ioctl.h
-- 
2.51.2


