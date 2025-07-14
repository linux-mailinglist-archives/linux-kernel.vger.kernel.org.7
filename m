Return-Path: <linux-kernel+bounces-729603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55DB038FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E537189DD00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB023B612;
	Mon, 14 Jul 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P64ao80Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BA2343C2;
	Mon, 14 Jul 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480964; cv=none; b=h6mo1iwQJ9Z44XTzpGh5PcaQTriRm/0s9CddKNxiuhmi7TddyOkpNhbYlyrxm4IsVrIRfgi0ca8AN7KCy1IiLQoXYK95QMsM08Wim3mSQ60b0b3I4nR6IWvz8wcX5SwRoJtkN+E5+iWEEq2gm3PRjPi6s270ZVGp+DK3m81ln0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480964; c=relaxed/simple;
	bh=VUCkFWGlNjZRGe+zHbksIQrn5M6PivU0Nf1tCQHaFIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiyRUT/E8+ahIquBoI2ljMGpO402gccbEiqsUYV4jw6syfg5SSqF3exznBtPo2koT+XjFXldV7GXX72PE5NjqIVZ447mJioNw4I7bopSoCzyoK0jQLMhPu9TmTT0NfmDE4WfNdPXeJPeaHwTg4camdipx0RBTG+EMlch5/QvqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P64ao80Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DA0C4CEED;
	Mon, 14 Jul 2025 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480964;
	bh=VUCkFWGlNjZRGe+zHbksIQrn5M6PivU0Nf1tCQHaFIg=;
	h=From:To:Cc:Subject:Date:From;
	b=P64ao80YpTcyJXdxpk6L9+ya5e7Dk0RJ7cigSqF/1laL41vnZSeDyRGUXZO+5K7zO
	 iRR2JXTh/w6VHIZyDl7Vp32tw32xXUHSw6aM7n4RNRzyho4n97z5KIei3v4nHkMDDl
	 7z7fDbupAFs8BTGbkh4nUoNV4W+02vcAbXhN6mmqVEkrKE2Hxo3gqEKZTXkxb9sYMt
	 BIB+PCI3269F2Rkf2b++SCL+yMWRZ7wcn9P3klhPkhgLLoecXnZaw5uMVx4I4hLM6t
	 87nX/uqJC3unkBIzgmyqcvnxWlWVrRWH39CVCwTM8zQowBEb0G3AYnofpI6UEonTnA
	 J3gMh3iODIlSA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmt: fix build dependency for kunit test
Date: Mon, 14 Jul 2025 10:15:43 +0200
Message-Id: <20250714081559.4056777-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When INTEL_PMT_TELEMETRY is in a loadable module, the discovery
test cannot be built-in:

x86_64-linux-ld: drivers/platform/x86/intel/pmt/discovery-kunit.o: in function `test_intel_pmt_get_regions_by_feature':
discovery-kunit.c:(.text+0x29d): undefined reference to `intel_pmt_get_regions_by_feature'
x86_64-linux-ld: discovery-kunit.c:(.text+0x2c3): undefined reference to `intel_pmt_put_feature_group'

Add a Kconfig dependency to prevent this.

Fixes: b9707d46a959 ("platform/x86/intel/pmt: KUNIT test for PMT Enhanced Discovery API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
A simpler 'depends on INTEL_PMT_TELEMETRY' would work just as well here,
not sure what the more logical variant is between the two.
---
 drivers/platform/x86/intel/pmt/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/pmt/Kconfig b/drivers/platform/x86/intel/pmt/Kconfig
index 785c206e1beb..7363446b7773 100644
--- a/drivers/platform/x86/intel/pmt/Kconfig
+++ b/drivers/platform/x86/intel/pmt/Kconfig
@@ -55,6 +55,7 @@ config INTEL_PMT_DISCOVERY
 config INTEL_PMT_KUNIT_TEST
 	tristate "KUnit tests for Intel PMT driver"
 	depends on INTEL_PMT_DISCOVERY
+	depends on INTEL_PMT_TELEMETRY || !INTEL_PMT_TELEMETRY
 	depends on KUNIT
 	help
 	  Enable this option to compile and run a suite of KUnit tests for the Intel
-- 
2.39.5


