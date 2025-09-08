Return-Path: <linux-kernel+bounces-806869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28BB49CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9669C3B1834
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333E2EBDEB;
	Mon,  8 Sep 2025 22:35:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A732E0B5C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370936; cv=none; b=WvOt0Aut8bUqE6C26oTi5oNnKISKLGPvkl/hYASztjuk2RJMwFBMqJxcwfqiOhFcwNuvAvUjywK7PX2wUP8NQkbJVB4lLWy8N8LS6I0omiovC2AbEOZqQaktxoUeXPyrRzce4uqVidSqBldnSUz71kYBPdql5cvRzU9NxeCysB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370936; c=relaxed/simple;
	bh=teEvz3YaOLFviJV1IoQM7NLsuKMFrLU4NeVZ445UWo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk7op+FqWkwsR7izIeIgM+RGnmHNZ0B8ZE3i+paufWlyTE6FOgKFOFXpvk3C4H3hhUt98cPzB6OV+PU16/xrsWn4jOzJzkEoRqFFabxf4iXsUzysGXWujIHJhl6xL9S4yfS3PvWLUP7P7F4wYwFH6+vY7/6z6Cgha9nS2+TdfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AE3F1691;
	Mon,  8 Sep 2025 15:35:24 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 84A4B3F694;
	Mon,  8 Sep 2025 15:35:31 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	gshan@redhat.com,
	aneesh.kumar@kernel.org,
	sami.mujawar@arm.com,
	sudeep.holla@arm.com,
	steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 0/3] arm64: realm: Add support for encrypted data from firmware
Date: Mon,  8 Sep 2025 23:35:16 +0100
Message-ID: <20250908223519.1759020-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confidential compute firmware may provide secret data via reserved memory regions
(e.g., ACPI CCEL, EFI Coco secret area). These must be ioremap'ed() as encrypted.
As of now, realm only maps "trusted devices" (RIPAS = RSI_RIPAS_DEV) as encrypted.
This series adds support for mapping areas that are protected
(i.e., RIPAS = RSI_RIPAS_RAM) as encrypted. Also, extrapolating that, we can map
anything that is not RIPAS_EMPTY as protected, as it is guaranteed to be "protected".

With this in place, we can naturally map any firmware provided area based on the
RIPAS value. If the firmware provides a shared region (not trusted), it must have
set the RIPAS accordingly, before placing the data, as the transition is always
destructive.

Confidential Compute Event Log is exposed as EFI_ACPI_MEMORY_NVS, which is
reserved for firmware use even after the firmware exits the boot services [0].
Thus map the region as READ only in the kernel.

[0] https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#memory-type-usage-before-exitbootservices

Changes since v1: 
  https://lkml.kernel.org/r/20250613111153.1548928-1-suzuki.poulose@arm.com/
 - Collect tags
 - Map EFI_MEMORY_ACPI_NVS as READ-ONLY, update comment and commit description


Suzuki K Poulose (3):
  arm64: realm: ioremap: Allow mapping memory as encrypted
  arm64: Enable EFI secret area Securityfs support
  arm64: acpi: Enable ACPI CCEL support

 arch/arm64/include/asm/io.h          |  6 +++++-
 arch/arm64/include/asm/rsi.h         |  2 +-
 arch/arm64/kernel/acpi.c             | 11 +++++++++++
 arch/arm64/kernel/rsi.c              | 26 ++++++++++++++++++++++----
 drivers/virt/coco/efi_secret/Kconfig |  2 +-
 5 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.43.0


