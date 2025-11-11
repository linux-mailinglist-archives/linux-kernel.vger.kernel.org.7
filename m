Return-Path: <linux-kernel+bounces-895031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD7C4CBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCFEC34EE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B982D47ED;
	Tue, 11 Nov 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOHbFPeh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234622A1D4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854333; cv=none; b=CG+Ur/hBEgjhOhOLjAa8McalbRP2tYtPwwrL257vLzGdGGNfQG+zAN7K3Lz7ukEpkeWv89NY83oKJCvrClZfE55sqW2NXT8Qa0R1sdDTuRdoJN35jotKW/EPfeCHV9xqdYqNj2lG8eCRllIX6iFHxv50pB+rVupjv9cPmRjD7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854333; c=relaxed/simple;
	bh=g4Tvg2v3uaMjRivXYkTBo1k4N007uj1PtJMvrWlU9fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7JKVEErhfI8WapnuWbT4M88fYv8SL2+OUuRyN4rDpHJJQ3JhITWSU+BSeQMgtT+Q03tS0zeAZFTTzPq+8gBKdMQQaq2hP5v8DPofOuD12E2kyMABF06mScXiksAjE2fmpH725Q8eiwAKvIdtvhqFxoLEgtNmRiuVaAnPms+its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOHbFPeh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so30149745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854329; x=1763459129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1g24wLuzk0713nPetylKIaxUF4rWkrCCQ8cmdPQSuac=;
        b=BOHbFPeheCH4PO2t9t2ZROuv0g20wltELCNcx2uwYir2wq5Py7f1agecX3SW49QDqm
         j/niZbJRV26CKv7opgyvaO8QBhbOYuV44eT9tXf4dOmVmsRzgPZv5ZHFnQ27+Lia8Ss3
         8v0fPRIa/HgwBxZ2luu/LakdRzbDq46iNYqkbn/MY7CjViBX4nVKlCcgVGogHInnYyQl
         jbGQf54hHWxr/iTXwsGzNZ2ISNVNuDWoNsc9r6BW90E96vs7Ars03B6FXq8M68C3tBxI
         Ytc1WWzVXy38+loj3UJTldxSf1m5AXAeCElxpn/3DViYs6NJek0PYsr6qIsD5rpm5WCT
         qDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854329; x=1763459129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g24wLuzk0713nPetylKIaxUF4rWkrCCQ8cmdPQSuac=;
        b=BQfomBOHLF3Spz7TS4p9BdAa11KDxhUUJri5s9lQ20X4tDWB+OXVZ8i+TL2aZqZfo+
         73UDay1V+Jt+v89DrjLGBPgS1MzhGocH9Ief3oH1PS9mRUbBQGxHkIRKTh7X+9F3HHqD
         uugFDBxUi89xxZZg6YxnMUuEfP9qwMnrsGbaO+YDLj/tNQBjUnXiZgUnhEz24c1nF3Vp
         hk2ytUzwOM/rO0sxjQUtJ2UYbgSMbywxAYBnl1T2OxQhp3mIfdQIDItMqdKapnu6Q8Do
         OfpNhcXIZY96ztDbCEyci7gYoy+YKVaRIm50gsNTGuP9i3TQiqJrmPsm55/kPIiSawe4
         QT0A==
X-Forwarded-Encrypted: i=1; AJvYcCXcOSbkkynVYJ3C7RYCs1NSsTLV0HufEmkoK4AmN4AtLRdZoQFOe0JCz6Fju6QExiP9MG+2wjobR+MkdSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa54kXJb0e8fClmm9Vu2S/CxP7Cjv1j+5rmSYYFlrMmtCk0Vzw
	gGgYIQFQHysUssdvn/ydLfToxZYHaartCCEcEuh73CTTF5tv9LPl1gtK
X-Gm-Gg: ASbGnctoH7IZt+X0KDgHETSDqzI6Hkm2DumrILt5gcJrSXZWEhWsO0rAFBhZPxOiisF
	88G00J+6WFHEYjtLTKdMZpaX9CDWBR9tq0mMljrS+UF555Atb2dlZG/eumxVuUBP1vIgToHJUXc
	o1SmkOWBK08rcq71XCdJFCP+Uz/xj7KbUveu1UEFy+6ntxtXPSRqYSjM5ckCpv4U0QGTOXtKy/9
	caFCotv+23PE1MD4H8ULtmhYQZjMmmXz5cxuU2vzAFu7N7LExIIvH1TggSd/0uxgcsVaUdxbAZr
	m9hrqfozHGSNJ8cwxdJLSIJW+4F0sPjKvBxX0I+RHIIn/MswREQ7+wxa2PJBagaO71I1Fx3bk1G
	015X8QbYnO0RKVyWooYyW48KEQr2SPt0sVDiCz58TaFbnaxJGVMNhlQ/i8f6j32/B7fJj/2QV3e
	hlVu5Ka9HUH26bXH+SPR3HF41MgdE=
X-Google-Smtp-Source: AGHT+IHH9CMNVraz2iiYocNiW3E37mR3fiBjV8xHSNldxyp2T4ZRTo/OOCUrEe25W1TrrO+B7vuqRA==
X-Received: by 2002:a05:600c:4f8b:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47773271a62mr120100945e9.23.1762854329061;
        Tue, 11 Nov 2025 01:45:29 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:28 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 00/10] staging: gpib: Destage gpib drivers
Date: Tue, 11 Nov 2025 10:45:02 +0100
Message-ID: <20251111094512.6411-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is for moving the gpib drivers out of the staging area.

As many changes as possible (patches 1-6) are done in the staging area
to prepare for the move. Patches 7-10 do the move and complete the destage.

Patch 1: Remove gpib from Kconfig and Makefile in staging
Patch 2: Remove the gpib/uapi directory from include search path
Patch 3: In the code change the uapi include file paths to <linux/xxx.h>
Patch 4: Remove comment item in TODO file
Patch 5: Delete the word Linux from gpib Kconfig option title
Patch 6: Add SPDX syscall note to uapi gpib headers
Patch 7: Move the common gpib/uapi headers to include/uapi/linux
Patch 8: Move the gpib tree out of staging
Patch 9: Add gpib to Kconfig and Makefile in drivers
Patch 10: Update MAINTAINERS for post destage

Dave Penkler (10):
  staging: Remove gpib build from staging
  staging: gpib: Remove gpib/uapi from search path
  staging: gpib: Change file path for uapi headers
  staging: gpib: Update TODO file
  staging: gpib: Change gpib Kconfig option title
  staging: gpib: Fix SPDX license for gpib headers
  uapi: linux: Add common gpib interface headers
  gpib: Move gpib drivers out of staging
  gpib: Add gpib build menu and rule to drivers
  MAINTAINERS: Update for gpib destage

 MAINTAINERS                                        |  4 +++-
 drivers/Kconfig                                    |  2 ++
 drivers/Makefile                                   |  1 +
 drivers/{staging => }/gpib/Kconfig                 |  2 +-
 drivers/{staging => }/gpib/Makefile                |  2 +-
 drivers/{staging => }/gpib/TODO                    | 14 --------------
 drivers/{staging => }/gpib/agilent_82350b/Makefile |  0
 .../gpib/agilent_82350b/agilent_82350b.c           |  0
 .../gpib/agilent_82350b/agilent_82350b.h           |  0
 drivers/{staging => }/gpib/agilent_82357a/Makefile |  0
 .../gpib/agilent_82357a/agilent_82357a.c           |  0
 .../gpib/agilent_82357a/agilent_82357a.h           |  0
 drivers/{staging => }/gpib/cb7210/Makefile         |  0
 drivers/{staging => }/gpib/cb7210/cb7210.c         |  0
 drivers/{staging => }/gpib/cb7210/cb7210.h         |  0
 drivers/{staging => }/gpib/cec/Makefile            |  0
 drivers/{staging => }/gpib/cec/cec.h               |  0
 drivers/{staging => }/gpib/cec/cec_gpib.c          |  0
 drivers/{staging => }/gpib/common/Makefile         |  0
 drivers/{staging => }/gpib/common/gpib_os.c        |  0
 drivers/{staging => }/gpib/common/iblib.c          |  0
 drivers/{staging => }/gpib/common/ibsys.h          |  0
 drivers/{staging => }/gpib/eastwood/Makefile       |  0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.c   |  0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.h   |  0
 drivers/{staging => }/gpib/fmh_gpib/Makefile       |  0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.c     |  0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.h     |  0
 drivers/{staging => }/gpib/gpio/Makefile           |  0
 drivers/{staging => }/gpib/gpio/gpib_bitbang.c     |  0
 drivers/{staging => }/gpib/hp_82335/Makefile       |  0
 drivers/{staging => }/gpib/hp_82335/hp82335.c      |  0
 drivers/{staging => }/gpib/hp_82335/hp82335.h      |  0
 drivers/{staging => }/gpib/hp_82341/Makefile       |  0
 drivers/{staging => }/gpib/hp_82341/hp_82341.c     |  0
 drivers/{staging => }/gpib/hp_82341/hp_82341.h     |  0
 drivers/{staging => }/gpib/include/amcc5920.h      |  0
 drivers/{staging => }/gpib/include/amccs5933.h     |  0
 drivers/{staging => }/gpib/include/gpibP.h         |  4 ++--
 drivers/{staging => }/gpib/include/gpib_cmd.h      |  0
 drivers/{staging => }/gpib/include/gpib_pci_ids.h  |  0
 drivers/{staging => }/gpib/include/gpib_proto.h    |  0
 .../gpib/include/gpib_state_machines.h             |  0
 drivers/{staging => }/gpib/include/gpib_types.h    |  2 +-
 drivers/{staging => }/gpib/include/nec7210.h       |  0
 .../{staging => }/gpib/include/nec7210_registers.h |  0
 drivers/{staging => }/gpib/include/plx9050.h       |  0
 drivers/{staging => }/gpib/include/quancom_pci.h   |  0
 drivers/{staging => }/gpib/include/tms9914.h       |  0
 .../{staging => }/gpib/include/tnt4882_registers.h |  0
 drivers/{staging => }/gpib/ines/Makefile           |  0
 drivers/{staging => }/gpib/ines/ines.h             |  0
 drivers/{staging => }/gpib/ines/ines_gpib.c        |  0
 drivers/{staging => }/gpib/lpvo_usb_gpib/Makefile  |  0
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c             |  0
 drivers/{staging => }/gpib/nec7210/Makefile        |  0
 drivers/{staging => }/gpib/nec7210/board.h         |  0
 drivers/{staging => }/gpib/nec7210/nec7210.c       |  0
 drivers/{staging => }/gpib/ni_usb/Makefile         |  0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.c    |  0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.h    |  0
 drivers/{staging => }/gpib/pc2/Makefile            |  0
 drivers/{staging => }/gpib/pc2/pc2_gpib.c          |  0
 drivers/{staging => }/gpib/tms9914/Makefile        |  0
 drivers/{staging => }/gpib/tms9914/tms9914.c       |  0
 drivers/{staging => }/gpib/tnt4882/Makefile        |  0
 drivers/{staging => }/gpib/tnt4882/mite.c          |  0
 drivers/{staging => }/gpib/tnt4882/mite.h          |  0
 drivers/{staging => }/gpib/tnt4882/tnt4882_gpib.c  |  0
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 .../gpib/uapi => include/uapi/linux}/gpib.h        |  2 +-
 .../gpib/uapi => include/uapi/linux}/gpib_ioctl.h  |  2 +-
 73 files changed, 13 insertions(+), 25 deletions(-)
 rename drivers/{staging => }/gpib/Kconfig (99%)
 rename drivers/{staging => }/gpib/Makefile (92%)
 rename drivers/{staging => }/gpib/TODO (56%)
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
 rename drivers/{staging => }/gpib/include/gpibP.h (96%)
 rename drivers/{staging => }/gpib/include/gpib_cmd.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_pci_ids.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_proto.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_state_machines.h (100%)
 rename drivers/{staging => }/gpib/include/gpib_types.h (99%)
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
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h (97%)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h (98%)

--
Changes for V2
Combine patches for Kconfig and Makefile
      Patch  1 and  2 -> Patch 1
      Patch 10 and 11 -> Patch 9
Add patch for MAINTAINERS      
2.51.2


