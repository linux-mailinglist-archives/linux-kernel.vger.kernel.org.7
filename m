Return-Path: <linux-kernel+bounces-767440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D179AB25438
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A909A1CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE52FC236;
	Wed, 13 Aug 2025 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgcarzCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005502FC224;
	Wed, 13 Aug 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115547; cv=none; b=MWAMNhKmvs/AidkG9OM41bMVteMV8qgXCi+jg2BIyhce68sYSzVgCMXBEcIsEx539yY5qbnG1TBc5rHJnssh3dAtuQ8ubMHGa55esDDLWtcVKE2kaIVt0lxtCfs6k0KGbLedWB07Zym8585msPBoqpZuZ8lelzl8jdDYW+nCLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115547; c=relaxed/simple;
	bh=j1QC4N9+5u44LDovSKAMF0Yz7QCpk/1J/EbNdodHWbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs8slI9LoFVauyNCH4/jcatG4Hf0OYe0H+WsJ2ItTryKwdCCDYgB3F1Zg83Q2UJ9sE6Yh0zxSAO5r7wjnPhCcBgzhZ6lYkzuKizAiMAswNby6JOvAnULR2/BT62UGXcJkx7xhu+a9nnzpAxYRAhnGPDiO4/oz/rS78pvVrKJraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgcarzCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B433AC4CEF8;
	Wed, 13 Aug 2025 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115546;
	bh=j1QC4N9+5u44LDovSKAMF0Yz7QCpk/1J/EbNdodHWbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgcarzCuafm0RtaxuKO2IbC4QLig8bSSea8d+/RbdRWKfZdTK+MvemL5Rydr8CV2e
	 pfZk0Y4WpCv7oxxlffN/RWze3leS/sPqAnM0SD4xvPBGwkTCdgyK+UhvPUSuOO+h79
	 cyAWItvF2N+D0BkyfLEtnriqBpP/AWPTiukcDH6Dvp3DuB9fLOvlEV39d3rIZ2/okY
	 9gAaUgOALJeRn5qNO6I9OVJdyU4B6JFLikVKMFhYNLnqrSnLhwrk4IrOxpWs/mG8aD
	 sezzN0eBrqyeoyhnw/M+ZZ7o31OdAXqXtV1ReR7BQ2V8VtCupCcla/J4HGCV3gaAKb
	 yMUrT/i0ypeNQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/9] Documentation: Fix power typos
Date: Wed, 13 Aug 2025 15:05:03 -0500
Message-ID: <20250813200526.290420-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/power/pci.rst                    | 4 ++--
 Documentation/power/suspend-and-cpuhotplug.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 9ebecb7b00b2..38e614d92a4a 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -472,7 +472,7 @@ in the device tree from the root bridge to a leaf device contains both of them).
 The pci_pm_suspend_noirq() routine is executed after suspend_device_irqs() has
 been called, which means that the device driver's interrupt handler won't be
 invoked while this routine is running.  It first checks if the device's driver
-implements legacy PCI suspends routines (Section 3), in which case the legacy
+implements legacy PCI suspend routines (Section 3), in which case the legacy
 late suspend routine is called and its result is returned (the standard
 configuration registers of the device are saved if the driver's callback hasn't
 done that).  Second, if the device driver's struct dev_pm_ops object is not
@@ -544,7 +544,7 @@ result is then returned).
 The resume phase is carried out asynchronously for PCI devices, like the
 suspend phase described above, which means that if two PCI devices don't depend
 on each other in a known way, the pci_pm_resume() routine may be executed for
-the both of them in parallel.
+both of them in parallel.
 
 The pci_pm_complete() routine only executes the device driver's pm->complete()
 callback, if defined.
diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index ebedb6c75db9..641d09a6546b 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -13,7 +13,7 @@ infrastructure uses it internally? And where do they share common code?
 
 Well, a picture is worth a thousand words... So ASCII art follows :-)
 
-[This depicts the current design in the kernel, and focusses only on the
+[This depicts the current design in the kernel, and focuses only on the
 interactions involving the freezer and CPU hotplug and also tries to explain
 the locking involved. It outlines the notifications involved as well.
 But please note that here, only the call paths are illustrated, with the aim
-- 
2.43.0


