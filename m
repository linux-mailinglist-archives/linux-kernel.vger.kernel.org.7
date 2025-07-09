Return-Path: <linux-kernel+bounces-724010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15972AFED85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47887545A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC82E7196;
	Wed,  9 Jul 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxwkSP2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF652C3242;
	Wed,  9 Jul 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074259; cv=none; b=p4Rfct5YbYrSX4bDLJ79XaKHC6XI41gBsOT0ATNK9EzQAMO+R+VVax7D3WWWgKg54GKrW2Cy+ECHmxwUW29QYu8xlSS+3BSUbJtQG0SqvrKwH8UrAdV8Hp9BiRYWpxnPaFUii3ETmAGOvPVQZ+jVn/oxhYkMqOzh40hN0PwkeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074259; c=relaxed/simple;
	bh=biijjrqVXTPUyczrqI3oFT5OL7RF+tbYJJRJdTQ19bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMzZBopWKxKuta2Yaha4CC92w9kkRuE7NtQ7bUz8a56AzgY0nobnZZUNagaCAtLT9m/dECHakWFA+0AZosUeCYygWTVaVvGvUGoMuNmHF3W1+EIVlEV+yDVmW2fVNqikUqp7Z5fA2KcdT0VS0dt86xX+g4nw6LFBn7NEaqZxDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxwkSP2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976FC4CEF1;
	Wed,  9 Jul 2025 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074259;
	bh=biijjrqVXTPUyczrqI3oFT5OL7RF+tbYJJRJdTQ19bE=;
	h=From:To:Cc:Subject:Date:From;
	b=mxwkSP2YAFQOxne/DBLeA/7XeKIzPWD8Qizc3aiqQwyWTjYwYi5R+zpa8/N3yamTF
	 dzzj1dq2AnmKcMFLW7MogzB6AAE4m9m8bKWT2KiKcFdv2isXF8IjEns+BoyKY3CInm
	 RzjSWgvkU/fYZL4Rg6OyreRuZEV8WsnYnVggjDmX3l0IHLwu5hHbwVMRi/WDzp4xtF
	 SP+AJ7IusoLWFhPG52iKMiykpMOBEkIfQRI31cDYHSL21cbb7jA4a0EFzBvCRaQEQ3
	 xsAMRB12Cpk55+t3bN1mxBkKncZw1Rlh/A4Wf+k4sCfCCz5jlQSSzl3GS5QWpTdUis
	 ykod++ZMXGnyw==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jelle van der Waa <jvanderwaa@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: lenovo: gamezone needs "other mode"
Date: Wed,  9 Jul 2025 17:17:28 +0200
Message-Id: <20250709151734.1268435-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Registering the "other mode" notifier fails if that is disabled:

x86_64-linux-ld: drivers/platform/x86/lenovo/wmi-gamezone.o: in function `lwmi_gz_probe':
wmi-gamezone.c:(.text+0x336): undefined reference to `devm_lwmi_om_register_notifier'

This could be fixed by adding a stub helper, but a Kconfig 'select'
seems simpler here.

Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/lenovo/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index b76157b35296..e9e1c3268373 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -250,8 +250,7 @@ config LENOVO_WMI_GAMEZONE
 	depends on ACPI_WMI
 	depends on DMI
 	select ACPI_PLATFORM_PROFILE
-	select LENOVO_WMI_EVENTS
-	select LENOVO_WMI_HELPERS
+	select LENOVO_WMI_TUNING
 	help
 	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
 	  platform-profile firmware interface to manage power usage.
-- 
2.39.5


