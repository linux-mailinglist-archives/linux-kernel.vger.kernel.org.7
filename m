Return-Path: <linux-kernel+bounces-774500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD104B2B337
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97754E1B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1225F7A5;
	Mon, 18 Aug 2025 21:08:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CB21171D;
	Mon, 18 Aug 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551331; cv=none; b=KCYZeVsoypiUzxasCsGlxd4d4iFdK2zQvuvdpUVkD/dQtw6f9mpeDMrfl1zIjXcyaKsKFYFrrOQT2jj70Uwn42Q8pHYffpC9ovVjyI3Sr9ETl7u2xl2+CqZFD0mxrgXNtNzeufGAfsJ0ym42TVvzDOsGA/tW5s6hDbA7uwDC9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551331; c=relaxed/simple;
	bh=aJz7l7FHXHkaF0nDNQxwlSMNFWvwBnerb1KuVZ1xiOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TcmY0go7rDqUQC2MOEtZL4n8/DY2tTe8Jvcn0ELBajAuF+oKL8kUljhlPscVicduamMcJt++YsfzdYWw818JxqPw1RSGSTP391CZSyCtaIkgxApIyzgoNEOkgBTgsbCV1p8QAhuqWgCHtmkTDgNqmbUHhO2f5zIKI+7basLfSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D761C4CEEB;
	Mon, 18 Aug 2025 21:08:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3B3DB1807BB; Mon, 18 Aug 2025 23:08:49 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 23:08:04 +0200
Subject: [PATCH] MAINTAINERS: exclude defconfig from ARM64 PORT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com>
X-B4-Tracking: v=1; b=H4sIADOWo2gC/x3MQQqAIBBA0avErBNUaoquEi0sR5tFFiNEIN09a
 fkW/xfIJEwZpqaA0M2Zz1Rh2ga23aVIin01WG17PZpROTmwU57CdqbAURm7rhaxIzQD1OoSCvz
 8x3l53w+8fOGiYQAAAA==
X-Change-ID: 20250818-arm64-defconfig-12bb2664e617
To: Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=aJz7l7FHXHkaF0nDNQxwlSMNFWvwBnerb1KuVZ1xiOQ=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoo5ZgAmVP37Tnju4oHv4sKrhNnHv75HvFUxH8W
 V346ULgreeJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaKOWYAAKCRDY7tfzyDv6
 mi18D/9Kw+cUmAxrjOeI48QHiUv4RBU8c0W/8RRLD8HvO4RKreMZSai0VxTenHCYN6SqeKtW/Xe
 1g2JA8rezdb6ZaDYO/SrOFaACoQjAEzJXO8FyrU18g1hopF4/ZBzJ9bXx9sP5BOqYaEfJOt0lp+
 ++FT1TvDE8CftnGRerSR4RbjKeZqTrlG+sRWGRdzedT0OTg1FAHfYNGULwoMZfLtBA9SvyjBcB8
 UVPRkjdwG9MRMXA5FQN1hVsSfAcSPV6W79iDvIpQNgre+Ht7wMVggfsdbG+XVr6it5lBibCYCBo
 i78g1JwH3wYE01KmhSvHdA8XScpxxdmTvgdjsmZgUykE9feJ7tTliINyc+vutLn2WhdjEtXWm4q
 K+iIbpYZlUcw/1M69Y+SECHB3qLdrI7g2yUlVFP7TPLfyJ7pU7Sl4W2mVUvxceQkChEHVNqbb++
 uFlx6HUGN3MqpBSMPc1Ud3P98kTtTFPv9v7SseGFIDKA5q4BgVyflmAXEZAsn3Qpdczf3qWr/WM
 s2fTsUejLh4oU4v1HfGf2J6QqXsAyMGtG8L26o7jd/8EH9lY/Z5QDv6vAy4d5YlYULhnK0ViBlS
 enLu/Ln7WyL+J5FMpWnJgJrvHpY4jtf6FDQ0W/RTWfwQZse6oQULxGhu7L5/r5vA2p8XZACEqBt
 FMcYx+gZR0toDGw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Patches for the arm64 defconfig are supposed to be sent to the
SoC maintainers (e.g. a change in the generic arm64 defconfig
required for Rockchip devices should be send to Heiko Stübner
as he is listed as maintainer for "ARM/Rockchip SoC support")
and not the ARM64 PORT maintainers.

While we cannot easily describe this in MAINTAINERS, we can at
least stop it from giving false information and make it behave
the same way as for the MAINTAINERS file itself (which basically
has the same rules), so that it just outputs the LKML for the
ARM64 defconfig.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6a991c0160a96620f40308c29ee0..b6466a628381bf40ebcf7e3638ec65fabf6ad357 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3667,6 +3667,7 @@ F:	drivers/virt/coco/arm-cca-guest/
 F:	drivers/virt/coco/pkvm-guest/
 F:	tools/testing/selftests/arm64/
 X:	arch/arm64/boot/dts/
+X:	arch/arm64/configs/defconfig
 
 ARROW SPEEDCHIPS XRS7000 SERIES ETHERNET SWITCH DRIVER
 M:	George McCollister <george.mccollister@gmail.com>

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-arm64-defconfig-12bb2664e617

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


