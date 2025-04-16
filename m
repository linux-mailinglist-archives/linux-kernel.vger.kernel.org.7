Return-Path: <linux-kernel+bounces-607725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E5A909D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A3319052E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1A2163B6;
	Wed, 16 Apr 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YVdlkZq5"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01D17A304;
	Wed, 16 Apr 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823904; cv=none; b=hjSkLKhRDOq0brkFsYW/nZCNQ1MiPz2o3lvoz5XpiVF0iEjXOzl8fzhbcSV5WKmvltia1NxmsiyIOzw8aIX1CFedQLhj7nAArE3vH7mJ2NLoYnWyU6IEoItb0kjGTC8XxcEUTNa6AbJa0MGhRsVyhzKSNPkfcAWWJcb0f8RhwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823904; c=relaxed/simple;
	bh=+YBuFYAR6x4FRDUwZCODxnhFFMcfji9j4F97sKMfm8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLyb62wmFWDMKJjVqunIVAflpeL/VqGx54Hu2ZDpPfDOGV7qu5Gb9wYKJ+NUghnBrJs1VL4rQ0QHG5DiHv5Z89AM3ihR2vK4eNz+5XAasspG3J67AW0p55egk70c4tskHDG2B4gBsrX0Hp8mtZfsc/u15H/kN4N/+1Ju84Ptfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YVdlkZq5; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 02EEA2FC0083;
	Wed, 16 Apr 2025 19:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1744823892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lzbjAoW7HYLXRRfm3mYcgt67Tuq6NhBWMJxWpaxLorQ=;
	b=YVdlkZq5hk9v1ggqKxTYenrHHQCez1gD44YQjtpd969EQ86CIkD65GyMZZQvhzdehMf5Uv
	sdWeLUWEmcJ8vcPnt7OnxqxuypiyHfIwv0Slvwm0XwaD61H0T7MWGfEjxV8uIKElQAtWuY
	XDdLCxJlAxC87aa+iMzL2gnN3WIShR8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v7 0/1] platform/x86/tuxedo: Add virtual LampArray for TUXEDO NB04 devices
Date: Wed, 16 Apr 2025 19:11:35 +0200
Message-ID: <20250416171809.557674-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover-letter to include this list:

v2: - Integrated Armins feedback and fixed kernel test robot warnings.
v3: - Fixed borked subject line of v2.
v4: - Remove unrequired WMI mutex.
    - Move device checking from probe to init.
    - Fix device checking working exactly reverse as it should.
    - Fix null pointer dereference because,
        hdev->driver_data != hdev->dev.driver_data.
v5: - Move everything to subfolder nb04 in preparation for the eventual
        upstreaming of other tuxedo-driver parts.
    - Integrated Ilpos coding style feedback.
    - Use dev_set/get_drvdata() based on Armins feedback.
v6: - Integrated more of Ilpo coding style feedback from a different LKML
        patch-thread (less files, local functions prefixed with a short
        string).
v7: - Integrated more of Ilpos feedback e.g.:
        - Use cleanup.h
        - replace some if cases with a pointer in driver_data
        - coding style oversights

Werner Sembach (1):
  platform/x86/tuxedo: Add virtual LampArray for TUXEDO NB04 devices

 MAINTAINERS                                 |   6 +
 drivers/platform/x86/Kconfig                |   2 +
 drivers/platform/x86/Makefile               |   3 +
 drivers/platform/x86/tuxedo/Kconfig         |   8 +
 drivers/platform/x86/tuxedo/Makefile        |   8 +
 drivers/platform/x86/tuxedo/nb04/Kconfig    |  15 +
 drivers/platform/x86/tuxedo/nb04/Makefile   |  10 +
 drivers/platform/x86/tuxedo/nb04/wmi_ab.c   | 919 ++++++++++++++++++++
 drivers/platform/x86/tuxedo/nb04/wmi_util.c |  91 ++
 drivers/platform/x86/tuxedo/nb04/wmi_util.h | 109 +++
 10 files changed, 1171 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/Makefile
 create mode 100644 drivers/platform/x86/tuxedo/nb04/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb04/Makefile
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab.c
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_util.c
 create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_util.h

-- 
2.43.0


