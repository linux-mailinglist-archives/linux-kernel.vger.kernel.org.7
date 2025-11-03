Return-Path: <linux-kernel+bounces-883626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EEAC2DE90
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31A51894842
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB392E090C;
	Mon,  3 Nov 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex0PRf40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691072701B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198373; cv=none; b=sQynZrZRd7LDz4fo+6yzjfNyp/fNbERyY0RujXYpBXvbeIk51TdanqssjZhDZtrBgYFv1q4b8HIzpKAV0umz7mSEgjrGg20G9hJhiaoRosOvdQI06rmSN2sKesxxjZwdAE35VagS1ABQN2QBdWKPJWiAefZjfUCsteHJB9uh5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198373; c=relaxed/simple;
	bh=b7XT+188e9vv9BuXv78bbP3kisTc44VfJfmaeV8TtbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OkGkbh7aR+huKqaRJ+ezLZ6Qz0tHfYQOfwauP0lE/Oktf4YMPV3zZmgSOEIQrFDjSA7ZtThA7IP3qADZKiRTac7ckjK5ZF5AMNzKNT2tzbISfmBUgR/bfvwJa7N1HFgg0qsH7wZBJg82cvdlIIglbxQVIGFbGMwIcHZdWnubf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex0PRf40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00B3C4CEE7;
	Mon,  3 Nov 2025 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762198372;
	bh=b7XT+188e9vv9BuXv78bbP3kisTc44VfJfmaeV8TtbA=;
	h=From:Date:Subject:To:Cc:From;
	b=Ex0PRf40TWUMrWJAtWz8WogMjIJi9Ve+PEu1xaV23wDbu7lJSjbL9tYWZQvGKqavQ
	 maLhpxNiNv3W6GCSd1x4P5qs9I5uXqNe/TeVLwm2F6+e09LFQBDjRVNCMeMKwS3he0
	 Caz3qWT6DZvf9ikxZJL4paunYoMn/qe6tBfd6fW8cmdIRgLfYCJBw509I5CAOh7SWz
	 wC/dMR7txXlpMufeC8p5NJxVQLHLK/xggpSZXHqcfz84XUFoY+rHmKKzkMs7Ht+kcr
	 ilkl24K1SBXGcXMcOChg5z+gIIktdV4lBXz2jZ1kFc9jFp/ci+P26/CBWdPOzseZmI
	 n404KuhxiwBMA==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Mon, 03 Nov 2025 20:32:41 +0100
Subject: [PATCH RFC] regulator: core: fix constraints handling if current
 state out of range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-regu-fix-v1-1-c8a46581c850@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFgDCWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3aLU9FLdtMwK3RQzUwMjc5PEtEQLSyWg8oKiVKAw2KhopSA3Z6X
 Y2loAvUSCq18AAAA=
X-Change-ID: 20251103-regu-fix-d650274afa89
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=b7XT+188e9vv9BuXv78bbP3kisTc44VfJfmaeV8TtbA=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJmczNG/PnuorFjQlKS7oCd2wfvqed8XJ+cfefN694lDE
 mFhX3696ShlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAi514w/NPYUbTm4jz9xe1z
 p7c1Tzide3bNgX2uLDeO8G70qHk83XoPI8N5W+Z4pwY1mSmlYn8jJj4T9ds8o4jrzRE7v3tbFmt
 vVmcEAA==
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Given a regulator set to an initially out of constraints value,
which cannot be set to the exact voltage given in the min or max constraints,
current code tries to apply a fixed value which obviously fails.

To fix that, allow a range as a constraint in out of bound cases.

A practical use case for this scenario is if there is a quotient
in uV_step which needs to get rounded.
The devicetree should describe the hardware and not depend on the
idea of a specific driver implementation how to round things,
so a small range need to be specified.
Instead of rounding uV_step another user of the devicetree
might be specifying uV_max and uV_min and therefore only needs
to round the end result leading to slightly different results.

Stumbled upon it while creating a regulator with uV_step = 5000000 / 255

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
Fixes: fa93fd4ecc9c ("regulator: core: Ensure we are at least in bounds for our constraints")
---
not tested yet to avoid magic smoke in case of errors. I rather prefer
having a second pair of eyes on it in this sensitive area.
---
 drivers/regulator/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd7b10e768c0..6b491c21ec5b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1238,13 +1238,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 		target_min = current_uV;
 		target_max = current_uV;
 
-		if (current_uV < rdev->constraints->min_uV) {
+		if ((current_uV < rdev->constraints->min_uV) ||
+		    (current_uV > rdev->constraints->max_uV)) {
 			target_min = rdev->constraints->min_uV;
-			target_max = rdev->constraints->min_uV;
-		}
-
-		if (current_uV > rdev->constraints->max_uV) {
-			target_min = rdev->constraints->max_uV;
 			target_max = rdev->constraints->max_uV;
 		}
 

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251103-regu-fix-d650274afa89

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>


