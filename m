Return-Path: <linux-kernel+bounces-739645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14467B0C91C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA0A3B5D53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902E2E091F;
	Mon, 21 Jul 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ofOcuukb"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3329E0F4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116838; cv=pass; b=mWfidJvI10IOGVphFlx5e5fFCrL+GNBbFoO9ynSOo6Bha6DSN4nuXFe6y1dKEZYBbaSYQMEs3GHYjVk8L8ZjXugqpa4c2RlQF40dIPdCN3YAAR2Mr7mw5Tfi8kT7RpDhN8HC2ZeG5FCJkBESKKc0yZKgp0+ELf3eeI3G5BJFOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116838; c=relaxed/simple;
	bh=19jOsKrKtynMRfxEP0aFVCM8oG7JBgUvsydmWunvLQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ebq8jYjRYVLzJG8fe0ZE8tMahC7ORq0X0j0EM5ZyDVJfLrnYSZAEXPzQwhot+tvPi/oCfAHo/6fATY3qT+2JkFCfhXodB75PciwRbqm1fFa/sdBO6TTQ05eeHvbFUsf3jZhMggPJxjhb1TZNCMHxaP/YjZOXQTEQjnlUGz2qV24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ofOcuukb; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1753116821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iUvIANf/UohhbAp9WLb3mxlfflIZVgugomZL7H/7/D925ABL2YUJwBpRMW77ZNebNxlAoO48tv6HOqldadqNlujzs8Id9wZbhCYNQCS/BDKT9UeDJ2fZPwHpV7bMbmyuzMZ/2hLIoV4Yt1cWIN/VyPym8pSwFaPTK0+uRZeolDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753116821; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jK9MI/i332eSghzqERwT+oHGxGUIkN8gQxI+ICWuRh0=; 
	b=jSUIsc+od0rqIuzZpO/yj5m+l60G/a0hFq3fuMHUFI6/XebZPuTU1zDn7SlrH5713vQ91Df1EMc9533Sd8j5kDyJQ1ihJKqeihYlwCjelCDaHcQEU8P9pB1EvHIA0G6hQLe9hHES2FwaJ0gNEVmxdMj3zx/tWoMlCHj/qF3T+sk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753116821;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=jK9MI/i332eSghzqERwT+oHGxGUIkN8gQxI+ICWuRh0=;
	b=ofOcuukbYdfeHUw5ctjHaiqkMjDzMog9JxCKEe6Mech40Z9eBc4a0qtVmD3D+UWX
	8C+2f+eTw7BBaT+mkuYz6Ds1EbdK8lV4Pb03IOkBPA8fztNoHRCKHjnE/ULAu/IyS9r
	BMNPg90PNNuejQwx948e+1zK6G5kATRhMb23uMg0=
Received: by mx.zohomail.com with SMTPS id 1753116818500238.90791555807152;
	Mon, 21 Jul 2025 09:53:38 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/2] riscv: mm: Use mmu-type from FDT as SATP mode limit
Date: Tue, 22 Jul 2025 00:53:09 +0800
Message-Id: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVwfmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nj3eLEkgLdtKL8XN20lBLdZCOjZCMT02Qj81RLJaCegqLUtMwKsHn
 RsbW1AGANRSxfAAAA
X-Change-ID: 20250713-satp-from-fdt-c22c245c27e9
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753116810; l=1644;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=19jOsKrKtynMRfxEP0aFVCM8oG7JBgUvsydmWunvLQA=;
 b=iQ9Sejx7hOZnVqg+hrtYgFd0q5I5kI/dsYk89Xm5dNG1f1KnKUIO9Z5zHZ1cFpNQClN8aaWDx
 vfEUHXIWdxAAmmKVGaAt3RqnJisMwJhH9hxGrWEDjllNw/zV6f7YJqU
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

This patch series improves RISC-V kernel compatibility and robustness by
refining how the SATP mode is determined during early boot. Some RISC-V
implementations, such as the Anlogic DR1V90 FPSoC with a UX900 RISC-V
core designed by Nuclei, which I am currently attempting to run the
mainline kernel on [1], may hang when attempting to write an unsupported
SATP mode.

To address this, the patch determines the SATP mode limit by taking the
minimum of the value specified by the kernel command line option
("noXlvl", e.g., "no4lvl" or "no5lvl") and the "mmu-type" property in
the device tree for the first enabled CPU. If only one is specified,
that value will be used as the limit.

- If the resulting SATP mode limit is sv48 or higher, the kernel will
  probe SATP modes from this limit down to lower modes until a supported
  mode is found.
- If the limit is sv39, the kernel will directly use sv39 without
  probing lower modes.

Link: https://lore.kernel.org/r/20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech [1]
---
Junhui Liu (2):
      riscv: mm: Return intended SATP mode for noXlvl options
      riscv: mm: Use mmu-type from FDT to limit SATP mode

 arch/riscv/kernel/pi/cmdline_early.c |  4 ++--
 arch/riscv/kernel/pi/fdt_early.c     | 40 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/pi/pi.h            |  1 +
 arch/riscv/mm/init.c                 | 11 +++++++---
 4 files changed, 51 insertions(+), 5 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250713-satp-from-fdt-c22c245c27e9

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>


