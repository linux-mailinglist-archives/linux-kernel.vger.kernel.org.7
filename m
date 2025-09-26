Return-Path: <linux-kernel+bounces-834022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BCBA39F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2401C03B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F62EBBB7;
	Fri, 26 Sep 2025 12:32:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16352DC765
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889942; cv=none; b=QcfivacejTzELakscZNnkw8vFCl1OMGW+511Oh+e7zJtJ+9O2BUP0dzVSIHTCUM0KioxNYCSSRBRKpZOTNa9g95IZz1XHQnjwmLszAMBGppvUJB6wvdrki/O91ZTNlJMhZmifT4sFk2ev1DtInUvFRdBHtJUl35kNEZ6f0Omj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889942; c=relaxed/simple;
	bh=tRDPzWnl8Y5b4vevP83CSJEcH/w/cjQDgATDQVHHiuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKq+loEMTxb088bUaLvFn5WM2ppCWcpWW7GWE2NFKzYcDYInvwA5N6WXVozH+56s5tiZoRpF097xUtCk3FT29qVldfNpLTgptu08lpHos+C3iQkdnUeFmjsstPXDeR3k1A8QT3Crey1f23jEuRB55gpc3Hdy67xquWKp37OXUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E58168F;
	Fri, 26 Sep 2025 05:32:11 -0700 (PDT)
Received: from oss-apollo7005.oss.cambridge.arm.com (oss-apollo7005.oss.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497733F5A1;
	Fri, 26 Sep 2025 05:32:17 -0700 (PDT)
From: Salman Nabi <salman.nabi@arm.com>
To: mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	andre.przywara@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	vsethi@nvidia.com,
	sdonthineni@nvidia.com,
	vwadekar@nvidia.com,
	chao.gao@intel.com,
	ardb@kernel.org
Subject: [RFC PATCH v2 0/1] firmware: smccc: Add support for Live Firmware Activation (LFA)
Date: Fri, 26 Sep 2025 12:31:44 +0000
Message-Id: <20250926123145.268728-1-salman.nabi@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch addresses some feedback from the previous RFC, and fixes and
improves some shortcomings discovered during internal review:
There is now a new sysfs file to waive the kernel's CPU rendezvous
requirement, if administrators are sure that the firmware's brief downtime
has no effect on the kernel's drivers. Also the firmware images are now
handled in a linked list, as this provides more flexibility for upcoming
changes. For more details, see the original cover letter, the changelog
below and the patch's commit message. We are still looking for feedback,
also from other architectures, on the best userland interface.

=====================================================================

this is a proposal for a driver for the Arm Live Firmware Activation (LFA)
specification[1]. LFA provides an interface to allow "activating" firmware
updates without a reboot.
In contrast to Intel's TDX [2] approach (which seems only concerned about
some confidential computing related firmware blob), and even OCP's
"impactless" updates[3], the Arm approach just lists a number of
"activatable" firmware images, and does not limit their scope. In
particular those updates can (and will) be for firmware bits used by the
application processors (which OCP seems to rule out), including runtime
secure firmware (TF-A/BL31), confidential compute firmware, and
potentially even UEFI runtime firmware.
Initially we have the whole chain demoing the Arm Confidential Computing
firmware (RMM) update, which is conceptually the same as Intel's TDX
proposal.

So our design approach is to create a directory under /sys/firmware, and
just list all images there, as directories named by their GUID.
Then the properties of each image can be queried and the activation
triggered by the sysfs files inside each directory. For details see the
commit message of the patch.
This is admittedly a somewhat raw interface, though even in that form
it's good enough for testing. Eventually I would expect some fwupd
plugin to wrap this nicely for any admins or end users.

The purpose of this RFC is to get some feedback on the feasibility of
this interface, and to understand how this would relate to the other two
approaches (TDX + OCP "impactless" updates).

- Are GUID named directories under /sys/firmware/lfa a good idea?
- Shall all three approaches be unified under a common kernel/userland
  sysfs interface? Or can we live with separate interfaces, given the
  different scopes, and unify this in userland, for instance via fwupd
  plugins?

=====================================================================

v1...v2:
 - added forcce_cpu_rendezvous hook for skipping cpu rendezvous for
   firmware components that supports it.
 - changed the static firmware images array with a dynamic linked list.
 - the activation pending flag is retrieved directly from the lfa agent
   for an up-to-date information.
 - added a mapping of LFA error codes to human-readable strings.
 - kernel error codes changed to more appropriate ones
 - comment fix in call_lfa_activate()
 - the "bitfields" name in variables has been refactored to an
   appropriate "image_flags".
 - change image_flags variable datatype to u32 from an int


Many thanks
Salman Nabi

Salman Nabi (1):
  firmware: smccc: Add support for Live Firmware Activation (LFA)

 drivers/firmware/smccc/Kconfig  |   7 +
 drivers/firmware/smccc/Makefile |   1 +
 drivers/firmware/smccc/lfa_fw.c | 455 ++++++++++++++++++++++++++++++++
 3 files changed, 463 insertions(+)
 create mode 100644 drivers/firmware/smccc/lfa_fw.c

-- 
2.25.1


