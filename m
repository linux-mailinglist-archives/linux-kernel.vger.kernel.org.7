Return-Path: <linux-kernel+bounces-814861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18645B559D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCA01895CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565B24BCF5;
	Fri, 12 Sep 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5CQp2O6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F72550CA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718594; cv=none; b=AbZxaEyHdMebRe3F9NX6uZeVvUtTUmODmNR5rAxmEpvlA2l8fe1G08dGxNGEQ1vVQzZrasLAwr+u3f1QuUvPsjnyVgRxRwhtQRh/0n13XlAplymFj+rLfoRTJqJ+uQEkYavXwiSULAxf9h3imkuT7wbwFWYZ8upI+d8Gr17Cfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718594; c=relaxed/simple;
	bh=GRUOPBmcHG5rwny33Aqll6uFm6c2yeYTGyp3ev0i/kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlCnO2XoaiPZIFyDICxPxIhmNRMwRIzQPz1nZOVpmTFdJx+RAkS8zIFSL0DHm4YF01rQwXK0NJbGggwTqWSn4sBwdk2RfjtIyLjr2YR4BP+gK6xLYgsfbqiG84JlK2F9Fq7KkM+ljQgmAhZ5PyoDNGSP0tQguiMEVe4aJxOD0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q5CQp2O6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2467747b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718592; x=1758323392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=Q5CQp2O69f1yH3w5fW9x9Vrg84tpfjAUvhJtgMCnUCzUFeFvlm813v6Sr/CNWCF63T
         0G+cA2SxVWsib562VIodjvXc6z0nYLTbGJaAlK6AU3sQ+Hmx2hvSRDEJsnJZ5sMrYRAf
         EGkdmHL6Z2/XcMOqmHTAFbLl18ZZxFRVnI1HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718592; x=1758323392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=tnwIBDBbltqGbi4BxBenL8komgvH4EpjUKXkIsqvLwJSRRbVmwrvE9bSVTqBIrGCPc
         Jfc777nL6Bzi7JTtD8llrW30Tup5JnM5c8aPgtofxCwSN8SjpcIy+LmSKE4YDPvj7EjO
         ja8RAcGjvjEo5LaNI6Im7GP0lxB1Qa0OVuz24Ay0Ac4ONEUJGIj1TIXpg1n1b6IP1AhM
         fe9mmqNSy36FnLURIoFLEwmmYZOoydkna4I3F9RgR+L9hzlr7l4dooW4hClV/HYcCt9u
         NrjuY8N6QHNamSQP017saMeO0jVId5H4orrr4lJrFNAIVl2lQFgx2vobvUWMaSxCKzSv
         2YLA==
X-Forwarded-Encrypted: i=1; AJvYcCVt8CqMOHHt7EQxeKNuPXKAwX47NwdFWLIBj7azkBIzrMHV8W9EtNXKJKNWXtuNzNdrsIzaOUkdEbl0hLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdxVfASZjNbySsYO9Wngc7XQRr407MDR/hX9TiRgOhXuktq5D
	+Zv2tBE1+giRUxiWKQ/x1VnuxcMXKNXn6rGF7Wl23jEXGIr01JnLtpGH5poz3nzBPw==
X-Gm-Gg: ASbGnctf7Qv9Fr4CAzN47/jKJnGFstdcys2AidtwaaIfH089RpE3YCm+fBdHF79kwYm
	1xchhHlijUJybavbafhypj1RZwNxYF9Qyqar1zpwJLgN52rICpwI67ZaAU9kQX/zHPWalqHvJXW
	tku2hnhCA49XD5HPmeKKVoqt1KK+H1pOvVxnhOI1P3zflqOoH3vaW1+G2RH0cbGNMpAVjjpoz1+
	l7gxASB/7U+GJy8yEl8E0mCINBNaxUZWwSBSIlWy0rOHcTc0LaRc6hXPqAACg50aQjC1ZT7kCZi
	0Xa0tlnzalWoI3NOLnDESqXCRDglIOwSUt+mwAGYQYxLeFPBGtkbrLpuqOZJibq6eGnXSjQwqku
	SwEFPTqgihV8yQUYl47bvzsUR65grslbj4/jNbAaCZK1ZZ0r+SWObTA5Gklw=
X-Google-Smtp-Source: AGHT+IE5DR0gvGWUro9z10EvotDyakdL5SHVeYZ/tNuNggcehVsLSaHVKcMNLMyAhxmQVoCyYfqTvQ==
X-Received: by 2002:a05:6a20:9147:b0:251:9f29:454b with SMTP id adf61e73a8af0-2602bb59347mr5854185637.39.1757718592010;
        Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32df97c3b9csm1227762a91.11.2025.09.12.16.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in modules
Date: Fri, 12 Sep 2025 15:59:31 -0700
Message-ID: <20250912230208.967129-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
There are a few drivers that already use this, and so they are
presumably broken when built as modules.

While at it, I wrote some unit tests that emulate a fake PCI device, and
let the PCI framework match/not-match its vendor/device IDs. This test
can be built into the kernel or built as a module.

I also include some infrastructure changes (patch 3 and 4), so that
ARCH=um (the default for kunit.py), ARCH=arm, and ARCH=arm64 will run
these tests by default. These patches have different maintainers and are
independent, so they can probably be picked up separately. I included
them because otherwise the tests in patch 2 aren't so easy to run.


Brian Norris (4):
  PCI: Support FIXUP quirks in modules
  PCI: Add KUnit tests for FIXUP quirks
  um: Select PCI_DOMAINS_GENERIC
  kunit: qemu_configs: Add PCI to arm, arm64

 arch/um/Kconfig                           |   1 +
 drivers/pci/Kconfig                       |  11 ++
 drivers/pci/Makefile                      |   1 +
 drivers/pci/fixup-test.c                  | 197 ++++++++++++++++++++++
 drivers/pci/quirks.c                      |  62 +++++++
 include/linux/module.h                    |  18 ++
 kernel/module/main.c                      |  26 +++
 tools/testing/kunit/qemu_configs/arm.py   |   1 +
 tools/testing/kunit/qemu_configs/arm64.py |   1 +
 9 files changed, 318 insertions(+)
 create mode 100644 drivers/pci/fixup-test.c

-- 
2.51.0.384.g4c02a37b29-goog


