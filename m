Return-Path: <linux-kernel+bounces-854487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8FBDE800
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D0D18906EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6F1AB6F1;
	Wed, 15 Oct 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5zTPNKA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD851E515;
	Wed, 15 Oct 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531862; cv=none; b=lklbOxApa+XtimXOdtbKPKz4Nj6VFvZdJEio8SircngKBiL6hPWsTiRw/LIMMig5Rb0tGofFnC3R/55Jkov5EJxqFHA+D7F4istPTNjGC/b3fkxXZ8TfGYkJT0MPOg1O5+OZgLs+HphHSE2ZkNuZyDirdvjhtYMhnmWPq99rG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531862; c=relaxed/simple;
	bh=L2PUHm3lghaAQknIHbz+ddE31Qd8tExMzKPCl40aq+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=frFTyYjOEGLOmxHaivbrA+dD5f8QIAiwWNepeelwRNr0YuJoh29oQTZIcAw3jSWwHElTT22ghIRFDRRpdGRCnHIGvtR1xN12gfdeWHtTrA/HmVGO7T199abwAEWPwmNnZMu2WupjS57aCsQFnfT6O6j7BHeTI8VRhYFhGw9UynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5zTPNKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE56C113D0;
	Wed, 15 Oct 2025 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531861;
	bh=L2PUHm3lghaAQknIHbz+ddE31Qd8tExMzKPCl40aq+I=;
	h=From:Subject:Date:To:Cc:From;
	b=M5zTPNKA62srnuHARXcmPypcoosbC4L0som06SHh4EKdKFQh48OBi13iIXXXHF03R
	 gLnsrozmPmmUJcQsUKphbep+RUR+1ht0En5NqV1z5R0DAcPRmd7d/f5KBhcDSH1yD7
	 NaN/IxyrVRg+XodzB46N7lzdd8aq8sXQxlc1yKoXmEBXepCHfGM3gHPQrTxobXa5qX
	 hSnn6swcsOQMBKQXIlNsY6c9gH9QfMASgdumor8LPM+mwnNM5WwOSXxt1RsljgPLuv
	 G7CsCeeWDjaiQjJvAPG94++AzWfrjbtcyovHWTdb6fs5m3NcFOkoOzs/PjrhHl/oDz
	 azYMtdea1uX5w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] selftests/fchmodat2: Error handling and general
 cleanups
Date: Wed, 15 Oct 2025 13:36:24 +0100
Message-Id: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiV72gC/23OSwqDMBCA4atI1k3JQxt11XuULmwy0VBrSiaEF
 vHujUIpBZf/wHwzM0EIDpC0xUwCJIfOTznkoSB66KYeqDO5iWCiYopzijDaCBiRWj08vOmioFo
 yqUot1cnWJG8+A1j32tTLNffgMPrw3o4kvk6/XrnrJU4ZvanSSgBmWKPPdwgTjEcferKCSfyQm
 ot9RGTEClPJmkGTv/tDlmX5APBdOKn8AAAA
X-Change-ID: 20250711-selftests-fchmodat2-c30374c376f8
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=broonie@kernel.org;
 h=from:subject:message-id; bh=L2PUHm3lghaAQknIHbz+ddE31Qd8tExMzKPCl40aq+I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75WRzjAi9Nc87zdC9Xbz2XyJbD1HkdhT6Chbd
 ckFaUUM83KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+VkQAKCRAk1otyXVSH
 0AmtB/9trlqdWJ5/oBrDt7/Oy3uvoQgr+BJJT+piXIT4zmxTVKTNe4zJE0XMSaqzAuZhdoNRfs0
 zh+9mD0dMVxYSZfln2DnqrGDqkxG5/YocP40441kPNXnccPBUdCPznmvTFOAQz/LujBysuecUFP
 ivQ/ZF7k5pu1/kg3bV0xUKMGKWUnF2OBzREi2XxcMp8AuzjjZiSm8QFRC894bOzJP0IpGObn0X8
 6dXgyUkJSHh6l4uWQLie2+L6NSRVyqsTKHIrzMECxwPjKJTCvvSaUYS9Ec7+9mrcPl1epO3k90K
 M1QNiuGxnkxoclQytG/t8hYbqqVQREnoV5yF9dl/lQ+AzZHN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I looked at the fchmodat2() tests since I've been experiencing some
random intermittent segfaults with them in my test systems, while doing
so I noticed these two issues.  Unfortunately I didn't figure out the
original yet, unless I managed to fix it unwittingly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.18-rc1.
- Link to v2: https://lore.kernel.org/r/20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org

Changes in v2:
- Rebase onto v6.17-rc1.
- Link to v1: https://lore.kernel.org/r/20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org

---
Mark Brown (2):
      selftests/fchmodat2: Clean up temporary files and directories
      selftests/fchmodat2: Use ksft_finished()

 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 166 ++++++++++++++-------
 1 file changed, 112 insertions(+), 54 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250711-selftests-fchmodat2-c30374c376f8

Best regards,
--  
Mark Brown <broonie@kernel.org>


