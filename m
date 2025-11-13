Return-Path: <linux-kernel+bounces-899170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F7C56F88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA2CC344392
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64C33469C;
	Thu, 13 Nov 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXjQMaNv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E033343B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030749; cv=none; b=mGxNBOBPXtD17tm8qEAI7TAFVq6SmvGQf96ZtjJvxNsBo9mbwPBUNwjNcpso293OPa+p5yBM1o2MHUX0YeqYKBi7Xt08Qa7elQi54gzckbEmFZKzEsB2u5slqrxbuz9hhS3OTL3AhCCinQ+5kEZfQ/tpIY0LfB1N7I3R6ZCwV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030749; c=relaxed/simple;
	bh=vwKxN349ATo3V2sNVJl1gEHvQM6lroaY8Zc7FhvHnWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mb1bX20c8wmx6eOzv8FVn5zuWxIhbiNb29FcIMa32G8xUGBASoVO79MWu+FGlqD+F0yAKqsFNe7t4LLF/J3c8pfI3jau6sL9K5ONbyoN2zkv3G4iyaLYRyiUd1r3pQ82gH5Vce0S5Z0db/HI/0W9BX4AAYQPW91mThDjacrXUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXjQMaNv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so14327355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030746; x=1763635546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztWyJTjfbAQ+qY2kswNUdM+lwH0vxOrggkmQeY3FcnE=;
        b=JXjQMaNvDJpIXS/E72fB35IVQNBWclrM77bsgqCcLMqNxhDdy4plRNTH3uNux+6KKX
         DlapgxL+fBh5//l12pnHdyXpS4ppBN61NCtzMhKNOJBp/lSbIl7xo0/4bM0CwEJK0XS6
         7MmUgZSGw+88/VpUy/8OR8/pT3PxmZ9FDRLCEnxBtyw1238JOgHKWXFmMjSpJv6fuPmf
         8fOrEHK24VAi7X9GSyqlx0Vv/9P3Ffh/OZZTLhWj20/nf7vfNAQScmJUwDD2C45jDXDG
         bHK2Uci+GTpXESQQDW+GUg74M68CdLi536m3DK6I8CI9SEDx9hZ2IM/5kY6Y+Wqj0gtA
         X5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030746; x=1763635546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztWyJTjfbAQ+qY2kswNUdM+lwH0vxOrggkmQeY3FcnE=;
        b=LsAmSPphQWbYadO79P8l71LZycOjOUtL2cJ/yT7UFnL5FzgqDz3VgDTRf9TFwXla8v
         n+RhBAnMFmRk7kueZrrci9Uu9jSdt6RWHWKh1Keq80XjP4Pp9r/CRSO60Qsu+2qCc++I
         rZHDSwUpsVDMXBdBdXtJnttCJ8Kywg4LdwsJjttdrtT3Pks6vNcU/FFs9wXIkxEi05gN
         SkdcAc+O2/9maq+TBcnB4wt5ZU8/DJi2BZiCoh2S675kXAtLRGKS7PTcCLewGsb2BMN0
         DrNn+DwfJjCxmEQEih3do+mtfXkoEL0TGU3f+PX2fYxP/SV/1dRmdlclGLsA75xdxh8i
         4VHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGQtqTPHaBwH0b+T3yzuPaNfIUGJAJskrvpVWVNraofaxo2qOZfFg9MdqIUEuWrBY3G0yjUQGvQhO4yrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHN4R8lyCmxPiwVssEsYPtuegMqJIGLd9f87a3auujlMIcuzV
	9dLAg2jrF9RKgvK7ZstFKlHYS3w3FDxwV3r1h1WXfEdV+Do/74zrdU5N
X-Gm-Gg: ASbGncuAaEFJ5IEJVnBG0u6AVc/f17hiem+Ie7Lz+/WyVlVEeMrIzcpRXJ+Ol0/MI5A
	daAqwI/vm37QdcBfyUVPXNFHn6eOVgNGVctkQ1lNB98LihjIGckR0bvRhNaRzMX6eepd3nCzxwP
	3Zh6Vb/2AcIMMgvAm+z0cuHcXstY0uXfzqaq4ICqkdrmrurGUhaLzcTK2umu3+H9LhB07fC3Pg1
	XKlYyEpqSU9SM/In4UcwNOwASUbeskQGdTA/jxDsss4Wcm5bLxmZJDHlJIawzzk+V8tKiI9UieS
	+4UeT5/TblypOLjPD3W+T4QvDj4nbM53y2XOXJz7+Q/voCrisLbiTbAIjTIqC228rR1TXKFSdOO
	OD6Acx1R0mfhOXs6GAIJxRHmPFhqMo/fnuIoTpVZWzN/s/Gku2c9M6Mif1N5hGRmxgS30woVd3F
	cR37oCt45gSDsXFGhjWyZJxSsjGaU=
X-Google-Smtp-Source: AGHT+IFORQOsW8Fx4p5YWkhcYsffqQYcuhXJaRHYwuKhRNKy7wq+LEYqFg+qbBSUDuo4l/7EerKT8g==
X-Received: by 2002:a05:600c:1e8f:b0:477:7d94:9cf0 with SMTP id 5b1f17b1804b1-4778bd7015dmr22854565e9.12.1763030746014;
        Thu, 13 Nov 2025 02:45:46 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm1444975e9.5.2025.11.13.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:45 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V3 0/6] Destage gpib drivers
Date: Thu, 13 Nov 2025 11:45:37 +0100
Message-ID: <20251113104543.5875-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is for moving the gpib drivers out of the staging area.

As many changes as possible (patches 1-5) are done in the staging area
to prepare for the move. Patch 6 does the move and completes the destage.

Patch 1: Remove gpib from Kconfig and Makefile in staging
Patch 2: Remove the gpib/uapi directory from include search path
Patch 3: In the code change the uapi include file paths to <linux/xxx.h>
Patch 4: Remove comment item in TODO file
Patch 5: Add SPDX syscall note to uapi gpib headers
Patch 6: Complete the destaging of gpib
      - Move the common gpib/uapi headers to include/uapi/linux
      - Move the gpib tree out of staging
      - Delete the word Linux from gpib Kconfig option title
      - Add gpib to Kconfig and Makefile in drivers
      - Update MAINTAINERS

Dave Penkler (6):
  staging: Remove gpib build from staging
  staging: gpib: Remove gpib/uapi from search path
  staging: gpib: Change file path for uapi headers
  staging: gpib: Update TODO file
  staging: gpib: Fix SPDX license for gpib headers
  gpib: Destage gpib

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

Changes V2 -> V3 Combine the destaging patches and Kconfig title
change into a single patch: Patches 5, 7-10 -> Patch 6
     
2.51.2


