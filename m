Return-Path: <linux-kernel+bounces-846494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACABC82A4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868E119E71F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B72D29AC;
	Thu,  9 Oct 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3RRB8iX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85610F1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000616; cv=none; b=tHYkzv4LdJfi+KNEvNqzNs0L7kNpj0yUTnTGwboWdadLoVaUECRaYaEYNpBgecTuWM3jPALad4JaD/K6Yh5L9AGe6inC/o7sYBQAS4ZJsyzCcWl8G2DjG0p8yWpJRzgQeyhAQtJzpp0D0nM93A8eEiliV3G4zOCSDAnq9C/TvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000616; c=relaxed/simple;
	bh=FoTZEXQcIgIMtFxDJPHe8cDks+/3aiPKFcdTwoxQrKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uqRzk+Yn+G0t5LPIQAvT5QDjcODFVRMlSXRKaIND3PcF8+0yQ4ekcsu1T7CJRsS/YWqToO6ecEoZwzonoW5Di/suE5ugl+wv8uOIYqjYxtNkn0Eizjj+sKbiRBaqSu9YB99RRa7I15JjdEnqaBYpg7hkiduJNiRiU3CXOrJiQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3RRB8iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DA50C4CEE7;
	Thu,  9 Oct 2025 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000616;
	bh=FoTZEXQcIgIMtFxDJPHe8cDks+/3aiPKFcdTwoxQrKA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=V3RRB8iXUAhFRA+KvS3burxRNW//s6acwSLZIQ04Lz9n3UWAty7WhtNh5OAVqViey
	 7EwHRjWnIwByFqrZ+MjcKwNeP7xXWmdtIcIJce7PZC/2NW1vlRFm2gVeK0mlQYM5Dg
	 d9lSKkfGbMjJ01hY3+eOz1WU5frF0QiJo/KVtSJTAE2Uu+BNKkC3T282hy+wqo8Pqq
	 +P0lVNSiO5+Rc//A+eCE5Xa2kH974vBsIPU1zeHSh7Ke+lWZi3QqhECZw96VxrAad5
	 x1VCL704uVFAlkKhogj/dqwHvlk/qzUvolNLL3YM5Rp1Co9c31nZGmvnfTMa0Sb35B
	 hiY/P88rkCEKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A327CCD187;
	Thu,  9 Oct 2025 09:03:36 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 09 Oct 2025 17:03:31 +0800
Subject: [PATCH RESEND] checkpatch: Suppress warnings when Reported-by: is
 followed by Link:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-checkpatch-v1-1-baf0e614b96a@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAGJ652gC/22OsQ7CIBiEX6X5ZzGFRgEnB7s66Gg6UPojpLFtA
 Imm6btLmB3vLvfdrRDQOwxwqlbwmFxw85QF3VWgrZqeSNyQNbCaHWpJJdEW9bioqC2pGT9ywbE
 3PUIuLB6N+xTYA27tvb1eoMu+dSHO/ls2Ei3pP1yihJJBCCl5Ixtm1Pk95TcRtd3r+QXdtm0/n
 G1MG7AAAAA=
X-Change-ID: 20250919-checkpatch-0276787ebfbe
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, niecheng1@uniontech.com, 
 zhanjun@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000615; l=1986;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=GglgwOO4sGxm/0cSmViQByo3JCllbsUslkPqrpN9emg=;
 b=Zh6nWoXotL3I2+RstXgrvRLgEvdeD5diRbxWeBBiU8VsOpFXfPRXdeWD1Py/cm2GTgeuVZ16J
 1BM/EAVNjALCUzPYURiB8Tcokbu+EeFMujIByKIKGrOQDnmdnteKVq6
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

> The tag should be followed by a Closes: tag pointing to the report,
> unless the report is not available on the web. The Link: tag can be
> used instead of Closes: if the patch fixes a part of the issue(s)
> being reported.

Accroding to Documentation/process/submitting-patches.rst , Link: is
also acceptable to followed a Reported-by:

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250919-checkpatch-v1-1-d889973932fa@uniontech.com
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..01c4e70b19a0992c2f2d56347be9ae73005be025 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3205,10 +3205,10 @@ sub process {
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ /^(closes|link):\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 		}

---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20250919-checkpatch-0276787ebfbe

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



