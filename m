Return-Path: <linux-kernel+bounces-899355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BAC577DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12773B4A77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B434DCEC;
	Thu, 13 Nov 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HooQ2oOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44D10F1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038146; cv=none; b=Nk63/cUhPb49fCls0ocMYY5SkKiTPw4F6ClUHvMjYM/F2pbnw2sxGuWj5LgN570+g4HZIheU/bezEjS5aFGeUwCZTMN99CCNVK81y6nCzJ76AM7vcw2hgGlzFubZEBKRuonMNVrof+Ul9bSKThdBP4z1Gy00FhDjAzVv5e3V0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038146; c=relaxed/simple;
	bh=2PHr334q4M2fPpkKP3XSas/Z95d58UhCd5fP0UAVURk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3j/LdtR6OH541j4JnVU3ZhPAsHQzLj94mEuH5/A1w7IAV+6boIAcDBdT1KQdofzMp8AxZSuyYkffE1ADsJifCxYZmaqbv/DL6fG/9bc2WBNOFfz9BO4EiCADcyiIjsQKfgV8QkeBdyaKkyOV7b0yMYH319JTKqBEEP2GE2kHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HooQ2oOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF7EC4CEFB;
	Thu, 13 Nov 2025 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038145;
	bh=2PHr334q4M2fPpkKP3XSas/Z95d58UhCd5fP0UAVURk=;
	h=From:To:Cc:Subject:Date:From;
	b=HooQ2oOzH1XyBrTw1OyApq7/NJQrUlbiSLKgKy0YYjEzxOcD1r3UZ+DcJTihGrUKI
	 wwPsl5V/9XMmSkQuE2ZQnWLedPlocCnpZYodQl3xlX//Hge/4OFqkPOiJsgTU8s1ku
	 HCWBjP7isCuIT7CuYhTUEZYdlIMKB+Yuaj2HGwbXOTZ2wa1caC0t7mVL5VO8rLX3jh
	 1JLvS23oh9C+9lPLsPuuau/S5axYBHRQQ/sph5Yhn+CLrhWzRJrmlS9euJbf+EJTCl
	 IFOcHRtSrXjEMkqKeXGVmn7k9CLJcy96SdFW+ByTUcBa1MS2AJMgCPHDw8nkMqrdR/
	 HRaSOQB6EoMSQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] firmware: stratix10-svc: updates for v6.19
Date: Thu, 13 Nov 2025 06:49:04 -0600
Message-ID: <20251113124904.326480-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_firmware_updates_for_v6.19

for you to fetch changes up to 4f7ffdfb9928a70debc6b019a68a6e068745e937:

  firmware: stratix10-rsu: replace scnprintf() with sysfs_emit() in *_show() functions (2025-11-13 06:32:58 -0600)

----------------------------------------------------------------
SoCFPGA firmware updates for v6.19
- Add support for voltage and temperature sensor
- Add a mutex to memory operations on Stratix10 service driver
- Add support for asynchronous communications in the service driver
- Replace scnprintf() with sysfs_emit()

----------------------------------------------------------------
Khairul Anuar Romli (1):
      firmware: stratix10-svc: Add definition for voltage and temperature sensor

Mahesh Rao (4):
      firmware: stratix10-svc: Add mutex in stratix10 memory management
      firmware: stratix10-svc: Add support for async communication
      firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
      firmware: stratix10-rsu: Migrate RSU driver to use stratix10 asynchronous framework.

Rahul Kumar (1):
      firmware: stratix10-rsu: replace scnprintf() with sysfs_emit() in *_show() functions

 drivers/firmware/stratix10-rsu.c                   | 279 ++++----
 drivers/firmware/stratix10-svc.c                   | 760 ++++++++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       | 111 +++
 .../linux/firmware/intel/stratix10-svc-client.h    | 100 ++-
 4 files changed, 1109 insertions(+), 141 deletions(-)

