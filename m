Return-Path: <linux-kernel+bounces-895039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F113C4CC61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4021842432C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA32F7AA6;
	Tue, 11 Nov 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j90d5G8Z"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A122F60CB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854342; cv=none; b=RKd5Ju1RJIQv7zpinKTvw0oqmpd4j72PUqdTE8Tbt9Sm11NZlWiG0gAGxIK1D9JdQQnWa2/TjzGb78DMq+5NCFSTxYOf0xo4Dwhdher2TE7Evd0gEP+S0wHnmm5LpupVjhuwKPBQ0FbJ/EtMiBbfDVk1pxkCN+L/sQcbXtfsLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854342; c=relaxed/simple;
	bh=cPvTYylPKLhkKyBx+zQ2OYOXqgBlnW5y7jofZng3bDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MccbSdpHBvi2CtzNqf2fbuvisamJYSU9ypbRV42NzSwkJl4Lf37yd15u4i23EqVJ/NYEp+K4j/26ZAdwGaTEUGgbsXb+TZsY+HQaCvkKFoTMdPgy5e2+reN0NKGULmyEUi2srQ+C31rTY5AQMXS6Lss4qOPWjtGZmcaefAf6yhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j90d5G8Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47773cd29a4so15353765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854338; x=1763459138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN17KvwoftxF9+1uJg9AnA6ZLgm5xMfMqT1THoFVmUs=;
        b=j90d5G8ZugphZf0rIhlErbPJntbL+TdrZfddL53yrpDVnD//FWWmbM+hP4MSy7WMOm
         kpniUn/JZCq/UiuUZr9qB/TwmJJ4CAQxI1LVfExMuW7Fh51eaPWr3ww2TVq8/wQplOFV
         2+M1nQ9MbkZh/qo4f43mqfV2HljpeMfeiAU6PEV2cLcxTsuvV5GGcCEKA4tP9H7H54B4
         URHYkGKEiUlAcfvGTllduLKywFDIsz1cfPDmfhKBby/rhrm8M/PtJcyOQC7i7xjpk2pk
         n5VRqvgXJsYpP1bozs7GegLlTAF6lCZMI6ZfQUagKzkOswrDHcUKeP1vNGxVwk2kkrXa
         qVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854338; x=1763459138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QN17KvwoftxF9+1uJg9AnA6ZLgm5xMfMqT1THoFVmUs=;
        b=avQUu2nxkuyTVkvgcFnCWAQsaVsBB25iATPZLrgbmjvF/0MM3Izp7MI0CqA7HhiMiN
         VhBHUQzKLHDwzNvJ85k7bxm2CAVdr5Vcs7rFtlauylb48MfkxzeNLJOkqMtAehTtV7gX
         xbpIXeAU0Zdv8CJtIrkrLkesEfMJ3vOTD6KGWhu6P0l+UC67hBo61H8YfBvcDynQdX0c
         7aLp4Gbd5doIxXY5NVktQgdWc2PHBYxOlmPvSbcecVV59OQopfrMFOo3ql0lFzW3qnO1
         6UCyclCQXwUOZ9XlVLBH2AmlZe8/kOOS+V6lEEVHXuDksastpIdHXt6H16WjgSJ4fHo1
         dHfA==
X-Forwarded-Encrypted: i=1; AJvYcCUYN93QCpcT0yg7JSVVOfJoC2S/Sr96v7MTVu50XC/tjEKGbppl/+N9vtAjIvQlgXsaOMC8k/KUgJ0dmSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzurku8oCbwA8880zC+plmij9Y9Q/Jt0g5rzUXzXwBLh/LcBQ0x
	WqsR2zk8qs0daMFKwatAGMH/on9w7Ijd7TLbQHFAtRbiBSl8z7waD7mB
X-Gm-Gg: ASbGncuKeQ3rpZJw6IOQzW2m4nIfByjNjat3vS118WQxf7RDR/2VThJDyA3ha0cz3Px
	OK/h22QjU0xyOL4GRz81dSHFptGCxgeH/6FPReNNmTsBgKCULJ5FsUcb/8aEGFnKLrmo1DiLeEZ
	hEo6ekPyrBz3KJAUfKiGs3D9xoxXkGV/xIb+PITzCcqE8LyIAbUGhFd62JfBimOGbiGrDKx6M1W
	zK+HtthGPkp9PGwyYDWY+lZKsm4VeiLbwNaiCLkKvijuoqQHSed/moBpGICVPG/+knzcScSXrqU
	nu9lQ0yLcKABAJSkXMesK6wFaMWsCCEjiKAanO7wYhRaiGOL2wT1Kp0UM1rcpLrZqRd9lESqoxo
	ui+UICOADLtvfhsKOIRYPlLeGH9Ym7+uJ38EyAr2PnhoXPdSNB4KKQVEpKBF+UD4Js4sdp8qGqv
	7fFGj7OiSO+Ut0I3zr1K9NVmfd+XKLcg7ykwxAWQ==
X-Google-Smtp-Source: AGHT+IEsW/N4yi7F+eg+cTnh6NWnyWFSQhXsFWYV1TKfrbSntxBedYHODls9iUd3rIxpAT2cYlk5Bg==
X-Received: by 2002:a05:600c:1381:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-4777328643bmr113869625e9.23.1762854338210;
        Tue, 11 Nov 2025 01:45:38 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:37 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 08/10] gpib: Move gpib drivers out of staging
Date: Tue, 11 Nov 2025 10:45:10 +0100
Message-ID: <20251111094512.6411-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes within the gpib tree for destaging have been addressed in
the preceding patches.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/{staging => }/gpib/Kconfig                         | 0
 drivers/{staging => }/gpib/Makefile                        | 0
 drivers/{staging => }/gpib/TODO                            | 0
 drivers/{staging => }/gpib/agilent_82350b/Makefile         | 0
 drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.c | 0
 drivers/{staging => }/gpib/agilent_82350b/agilent_82350b.h | 0
 drivers/{staging => }/gpib/agilent_82357a/Makefile         | 0
 drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.c | 0
 drivers/{staging => }/gpib/agilent_82357a/agilent_82357a.h | 0
 drivers/{staging => }/gpib/cb7210/Makefile                 | 0
 drivers/{staging => }/gpib/cb7210/cb7210.c                 | 0
 drivers/{staging => }/gpib/cb7210/cb7210.h                 | 0
 drivers/{staging => }/gpib/cec/Makefile                    | 0
 drivers/{staging => }/gpib/cec/cec.h                       | 0
 drivers/{staging => }/gpib/cec/cec_gpib.c                  | 0
 drivers/{staging => }/gpib/common/Makefile                 | 0
 drivers/{staging => }/gpib/common/gpib_os.c                | 0
 drivers/{staging => }/gpib/common/iblib.c                  | 0
 drivers/{staging => }/gpib/common/ibsys.h                  | 0
 drivers/{staging => }/gpib/eastwood/Makefile               | 0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.c           | 0
 drivers/{staging => }/gpib/eastwood/fluke_gpib.h           | 0
 drivers/{staging => }/gpib/fmh_gpib/Makefile               | 0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.c             | 0
 drivers/{staging => }/gpib/fmh_gpib/fmh_gpib.h             | 0
 drivers/{staging => }/gpib/gpio/Makefile                   | 0
 drivers/{staging => }/gpib/gpio/gpib_bitbang.c             | 0
 drivers/{staging => }/gpib/hp_82335/Makefile               | 0
 drivers/{staging => }/gpib/hp_82335/hp82335.c              | 0
 drivers/{staging => }/gpib/hp_82335/hp82335.h              | 0
 drivers/{staging => }/gpib/hp_82341/Makefile               | 0
 drivers/{staging => }/gpib/hp_82341/hp_82341.c             | 0
 drivers/{staging => }/gpib/hp_82341/hp_82341.h             | 0
 drivers/{staging => }/gpib/include/amcc5920.h              | 0
 drivers/{staging => }/gpib/include/amccs5933.h             | 0
 drivers/{staging => }/gpib/include/gpibP.h                 | 0
 drivers/{staging => }/gpib/include/gpib_cmd.h              | 0
 drivers/{staging => }/gpib/include/gpib_pci_ids.h          | 0
 drivers/{staging => }/gpib/include/gpib_proto.h            | 0
 drivers/{staging => }/gpib/include/gpib_state_machines.h   | 0
 drivers/{staging => }/gpib/include/gpib_types.h            | 0
 drivers/{staging => }/gpib/include/nec7210.h               | 0
 drivers/{staging => }/gpib/include/nec7210_registers.h     | 0
 drivers/{staging => }/gpib/include/plx9050.h               | 0
 drivers/{staging => }/gpib/include/quancom_pci.h           | 0
 drivers/{staging => }/gpib/include/tms9914.h               | 0
 drivers/{staging => }/gpib/include/tnt4882_registers.h     | 0
 drivers/{staging => }/gpib/ines/Makefile                   | 0
 drivers/{staging => }/gpib/ines/ines.h                     | 0
 drivers/{staging => }/gpib/ines/ines_gpib.c                | 0
 drivers/{staging => }/gpib/lpvo_usb_gpib/Makefile          | 0
 drivers/{staging => }/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c   | 0
 drivers/{staging => }/gpib/nec7210/Makefile                | 0
 drivers/{staging => }/gpib/nec7210/board.h                 | 0
 drivers/{staging => }/gpib/nec7210/nec7210.c               | 0
 drivers/{staging => }/gpib/ni_usb/Makefile                 | 0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.c            | 0
 drivers/{staging => }/gpib/ni_usb/ni_usb_gpib.h            | 0
 drivers/{staging => }/gpib/pc2/Makefile                    | 0
 drivers/{staging => }/gpib/pc2/pc2_gpib.c                  | 0
 drivers/{staging => }/gpib/tms9914/Makefile                | 0
 drivers/{staging => }/gpib/tms9914/tms9914.c               | 0
 drivers/{staging => }/gpib/tnt4882/Makefile                | 0
 drivers/{staging => }/gpib/tnt4882/mite.c                  | 0
 drivers/{staging => }/gpib/tnt4882/mite.h                  | 0
 drivers/{staging => }/gpib/tnt4882/tnt4882_gpib.c          | 0
 66 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/{staging => }/gpib/Kconfig (100%)
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

diff --git a/drivers/staging/gpib/Kconfig b/drivers/gpib/Kconfig
similarity index 100%
rename from drivers/staging/gpib/Kconfig
rename to drivers/gpib/Kconfig
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
-- 
2.51.2


