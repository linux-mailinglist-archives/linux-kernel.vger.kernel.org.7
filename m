Return-Path: <linux-kernel+bounces-727855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EEB020AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4A81CA4E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425D2ED853;
	Fri, 11 Jul 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IgLLuKsJ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E92ED861
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248551; cv=none; b=o4Hsp4e8slP6+HkZAmyWqtPAHEZLk6YfzdwrQ8kdsJC9Syw9kk3w19SW/FCFYEnUCnDImqo/qv08uzaF4eCNFd2F4BdZDKMGAzw+bJX8h46Pza2sw8sS3WBN7msdPSLEVImAXt5xEFnLJrytxpmnahvUnt1/xzbZHg/sNE2e158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248551; c=relaxed/simple;
	bh=p0QT4HPaY8OBtTEZP93RtyKH7AZULc6D1K35xfZC+fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFuTVG+kXZIZHgSMUy2k5YPPr5zytZnf6RWpGEG6lmNDj8YBDZLntSQOmJkCkwtnuxMyfJjMAnzNUE3IfAGfIS/XksSipUyClA57GlJKrO7OehQATv8DdK6snvh2Hdgq3yW7sbyKBbZlasLuVnqPxC+GxRX8vp6vbiz7dw+HK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IgLLuKsJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3030301b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248548; x=1752853348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwufIkKlgwPmaoI7EtkILOQ2opwehMJ+nCT/MIXFWY=;
        b=IgLLuKsJ+ZdAXWukZ1LeM5iq4bn05qezw/cYJXSBFnR4nvtGpHJv0cI/uojRkNe2jQ
         GBSR6JyehL5tvQ2XFHvszQ82U/mXJGKE7VCGjqIb18KzSzIvklGbvqSW0yz73w3VV/5l
         U+KoESFtIa5GavgsVpXEu6hRdS7hJY9b+uONs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248548; x=1752853348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUwufIkKlgwPmaoI7EtkILOQ2opwehMJ+nCT/MIXFWY=;
        b=lhmDCTq4VOG94kWCtdhHWg176SpMCOxunbmgcdTOKqeo654BRiaM9uvpnKZsNyMbMJ
         tODdQas6SLm69IPWCcsFnmA53UXCYaVbI7XG24rsAZDmQ/fmJuZZGhdd+L9DmmPL8O/u
         q+Oxuw1ZzNuBZp1n1dycoPBt2GvVA38ybUJCjdDCHsL6lANSwHDWU3yi7eh+rBUc9VGQ
         ZbNz/G2gt6IA3s7tXGCcks25eLJaHcDapt9fEzujvEGjNit/v4qPwMq6K26mS6wa4hDb
         6+bIl1E39aqbKciDB7lPtYaDJDUl+pRaS09m4ZYEyPwsZsfqi2GVUFuQHGqGEeEjSdaC
         MhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtWYSqt/RKO2qgLYdyRk3u1wykFFOJtYI+7dtwtvKc7He/1tKtiUskIfHOeKNHKk2DZZEUHafFyombuFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq30Ul8qFhNu7zEy7zypiCJ3sWeynicMK5E29lkFhcSzahP3/P
	uqwa27hOv6p5MMJ5b+077y/0i+4AKNE3G3Ep9rwVLyRMs0uIxgLb43kyaQtUNAWGmw==
X-Gm-Gg: ASbGnctxCuPURcLPT1pbITlfnZm5sEAN8n+Az5lrLKyYTDE8WwAeYks6jBg9p5PH39h
	9n15+3DvpNNq1cyt/ZiB/dJsFjqG2zvGHZq37uR/f2Pn1BGLqLKgPzvC3pseey0YVRgDdIcKZQa
	zbZBD8KKk1H0xejquWNxrS3cZX/JxIlSccLuyXVZ3+D/xyxksgaWGPS1EH0yOAP8mnMjTirtqXn
	TVPKoRftgXHF3iIkx0Kwaeo6HZ5n6bssWs51+cuSL61j+gri5QgjJsBWfDUXOTdyHZPDVh+HfRW
	YcZLXmtDzmtuP8kyfTd2s3M+kTyQYwTuBLDzWmv7NrhpG37M+dL9wXmMKsJphOKEawxwB5AO3CL
	eqEFy6UX7jkIm5f3DBpmDIdd3HVplD0rx8131GHeh6FCm9tUVmHVyA4971w==
X-Google-Smtp-Source: AGHT+IHFZKUgGL0wxuQrtMVNJArFfFZ4ZiEznQy74X/s9Jn/0gsJzLOGIMGF63s8wwcASQkDocGp0g==
X-Received: by 2002:a05:6a00:1743:b0:74a:e29c:287d with SMTP id d2e1a72fcca58-74ee244a366mr5107688b3a.11.1752248547651;
        Fri, 11 Jul 2025 08:42:27 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:27 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS
Date: Fri, 11 Jul 2025 11:42:16 -0400
Message-Id: <20250711154221.928164-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support to claim host for TZOS RPMB access and synchronized
access to the controller hardware using hwspinlock framework.
To achieve this Linux OS and the secure TZOS make use of:
- shared hardware semaphore register
- a set of SDIO shared work registers and
- IPI interrupt registers 

The currently running OS that needs access to the controller puts itself in its
slot of work register and if its next in line it can try to grab the hardware
semaphore and complete its mmc requests. The shared work registers indicate next
in queue to access the controller, and current agent in the queue. Next agent
queue state is changed under the hwspinlock is owned by the current OS accessing
the controller hardware before release the semaphore, send and receive IPI
interrupts between linux and secure world are used to indicate completion of
transaction to the waiting OS. TZOS has its own RPMB driver which accesses
partition when it wants to read/write RPMB frames. Current implementation
assumes Linux and TZOS as the two work agents.

This patchset is an alternative method to initial RFC patch:
[PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support	
https://lkml.org/lkml/2025/2/6/1711

Kamal Dasu (4):
  dt-bindings: brcmstb-hwspinlock: support for hwspinlock
  hwspinlock: brcmstb hardware semaphore support
  dt-bindings: mmc: add brcmstb share register and hwlocks reference
  mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       |  36 +++
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  29 ++-
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       |  98 +++++++
 drivers/mmc/host/sdhci-brcmstb.c              | 243 +++++++++++++++++-
 6 files changed, 413 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1


