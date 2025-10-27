Return-Path: <linux-kernel+bounces-872535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D783C11652
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1283556222C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A831D75F;
	Mon, 27 Oct 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+lYvu8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C12E7648;
	Mon, 27 Oct 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596935; cv=none; b=JDJunbYfNbbGBbIxLR33VemG6RjnTzYLYtPUycDeDm8CIIuMPRHMITQ5iBubo9m/kreDQkKa/S+HVkZGQlxwu650nUfayRDxfs1WVDHD0J/8V8sKIgcZrto4fi1+qaIAuZh6ng4wd/3wYwYjdoZh8uiOMCv1795hs09LbYE1IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596935; c=relaxed/simple;
	bh=dIJVLQ1e1brD1KXcrYOnxXcA6YmCJaOgAp94MOR1zJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cE0f0NoLWmf8yEnT/i/URz1H1FcKe/ITL8b0U1jAposyLe2IuuqgZ6rcap6Z3sCDdxiqZnw9pv4/7DSZ07YqoFV6YJDA9MVrDPuNajvDfOeLwt4fHKqd+zvOdPeyzlvhDtSFkh+R8XtibsmjHyVbDkq5xKEXIqk49iWBD54abUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+lYvu8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDACC4CEF1;
	Mon, 27 Oct 2025 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761596934;
	bh=dIJVLQ1e1brD1KXcrYOnxXcA6YmCJaOgAp94MOR1zJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V+lYvu8LJ8loTVXHPIKbGcpaMUVOg/HQqo45+pRSE4kVlMRUsHyLsnrkVAa21nNdj
	 KEOL8BzAMp1OLu6Mxq3cfcjzXYcVtsuWPWe2fVSBX6pGP45DXA7FD/BL3LLTUTL2DD
	 RPahHfhc1V+ZtrGiC4YlGqDqhedEPmxsjIdaI2FMpPkHH4aknoyBNbIF88w4B9kE0T
	 yPZjCNc8z2VW8bp02f3LmcPPxrXVdOasCuGVI6KjG4DWCtAMCJgh/9H+17I55e+vdL
	 N/N28a835F+4776GiPgtgkYwiuasmMY7C3zCkjVlOcXcvfSpduxV6McxcG2f/8MRIN
	 qgoAcVml5SfDA==
From: akemnade@kernel.org
To: linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <akemnade@kernel.org>
Subject: [PATCH] hwmon: sy7636a: Fix sensor description
Date: Mon, 27 Oct 2025 21:28:47 +0100
Message-ID: <20251027202847.119707-1-akemnade@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Kemnade <akemnade@kernel.org>

The temperature is not from the die itself but from an NTC. That was
verified with an IR camera. Fix that.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 Documentation/hwmon/sy7636a-hwmon.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
index c85db7b32941..0143ce0e5db7 100644
--- a/Documentation/hwmon/sy7636a-hwmon.rst
+++ b/Documentation/hwmon/sy7636a-hwmon.rst
@@ -17,10 +17,10 @@ the Silergy SY7636A PMIC.
 The following sensors are supported
 
   * Temperature
-      - SoC on-die temperature in milli-degree C
+      - Temperature of external NTC in milli-degree C
 
 sysfs-Interface
 ---------------
 
 temp0_input
-	- SoC on-die temperature (milli-degree C)
+	- Temperature of external NTC (milli-degree C)
-- 
2.47.3


