Return-Path: <linux-kernel+bounces-892621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B3C45777
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E3347616
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF492FE05D;
	Mon, 10 Nov 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3vg2ila"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16858A926
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764961; cv=none; b=Rdd6dLtudVYUPGlfslaUv0LxdxTHfwQdks7ma/K5G47xgRGRoIou+qzjB4tNxO/ewzJlbaiGBzomcxeXPYDSB166BpzXoeHt5MbUmhTVvHVHEn8X4KZPcyJFuqJXQ/3M5LmOelT0K5P47x64tL8/7MXsjfCRXeryhrQvfRiByBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764961; c=relaxed/simple;
	bh=2LCdArWEwWTdN30303pBPpEKqQtf6O5CcmuVlRGn3QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WYzRF+QEX5qaqKz0C51dvinZdrvhxQ3xd8sBHa6nbbTix+5OzjuI03YeuhoKZOHsR37ZdGq3pMaPfQsKvVy0oTOYLpxp1fvfMhzooDJfOEKaD4S4b97b6KtGjZl9u54jXzx1zongOw2ma0ovr/eoN3NnknG6y4VrAIPAs7dVZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3vg2ila; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 874F3C4CEFB;
	Mon, 10 Nov 2025 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764960;
	bh=2LCdArWEwWTdN30303pBPpEKqQtf6O5CcmuVlRGn3QM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=B3vg2ilamgq/qZZh6lfxIqac4n8jrv/5wTvyqaOfp/4KeaoNAnOohZM2WVBw8Mfqz
	 vYXbnv9cccLlXaXQgXnlv3ruf6uNwAXGvFecL1bXX3RKFSOZexmEMNrw1bdmEc9MAv
	 OWedkbjpam7nP+KMfuJy5kKtc72lZl5YvrBwXKH2dCceKd9aFOn/x0yHN60bT6ynjH
	 AjomgJxpy3C+hzazySSjHsz4vd+6XXD+0xziwMrDe5uPVPwOLiBcdZswPhFWJA6Yz/
	 R00K0s9U7yC2d6Uqi2Kh18hc7gEcwfLb1p8a2U+Un9H9zbs30pQCkNKepU4txc84Ou
	 SAqQhSNoWMnng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DE0CCF9E3;
	Mon, 10 Nov 2025 08:56:00 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Mon, 10 Nov 2025 16:55:59 +0800
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
Message-Id: <20251110-checkpatch-v1-1-d7ae9d46a376@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAJ6oEWkC/3WOsQ6CMBiEX8X8szVt0ZY6OcjqoKNhoO1f2xiBA
 BIN4d0tjKLj3eW7uwFabAK2sF8N0GAf2lCVUbD1CowvyhuSYKMGTvmOKqaI8WjuddEZTyiXQqY
 StdMIEagbdOE1l13hnF2y0xHy6PvQdlXznjd6Nqe/6npGGLFpqpRMVMJdcXiW8U2Hxm9M9ZgWJ
 oxRusR04SgKttVK/MV4ssCckwnaGEkrvrB8HMcPSpY1Vh4BAAA=
X-Change-ID: 20250919-checkpatch-0276787ebfbe
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, niecheng1@uniontech.com, 
 zhanjun@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762764959; l=1809;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=FjYTg08j4724SsqIOglF1kA+dOmAY6fiyRP1YcvJG9I=;
 b=rTvKvZXykNbHXYZkAOi1/37E0BNa04HyXdwPxvJxULHtnHBMqRXBqkel1I8P7CuwO3SzW+Ttp
 tPm8Xlw/g+HA94YOXxKws9sUiKkG7agt8m5MCv3sAdyAW2Szwtp7uy6
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
Link to previous: https://lore.kernel.org/r/20251023-checkpatch-v1-1-ff73ed1027d6@uniontech.com
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..01c4e70b19a0 100755
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
base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
change-id: 20250919-checkpatch-0276787ebfbe

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



