Return-Path: <linux-kernel+bounces-757220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C9B1BF59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D903B07A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB541C8610;
	Wed,  6 Aug 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl9UvN1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922F1FC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451265; cv=none; b=WcofdKc2ptSz3lVUORokx9Eym5lW0lFkkBgw9mljXRMK9rPHAyPKoRuph7MeAsPkSj9+TKg0Prx1UWUN04XKv3KaCYUco/yiGyDCwfFbqCQPaUWU3TTSEzdvNH0XWqoYsp0IGQyfd714JbDm6nDmUFx35Xap2PhNDaFJEeu6G2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451265; c=relaxed/simple;
	bh=ZgLpn0RkxXS+6QqKuQSilpnYfvlfFjajaKMxreUiSDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ku5aLcPz5s+o2hWck9xViHt86PkTIaRqhCPTCQ9SvphhUOLQDu/Lr/OFpegwS8JYjblLgwFiHEUqmGg9kC5ZLFJGcc8pEUb5TMG3Mj7kowR2nZnZD6jkoGnRwUYdjrj6h1HI6VRScDEjbOvL44jrpf/wm/m9uhhgYfKxnPBE1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl9UvN1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B71D3C4CEE7;
	Wed,  6 Aug 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754451264;
	bh=ZgLpn0RkxXS+6QqKuQSilpnYfvlfFjajaKMxreUiSDw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Bl9UvN1kUwMBKLHGp5XuK5DL6ATFs6DRpretX1ZpSOCOxBARTnmPySmsaSm/2qnGN
	 mRQ4giRamkh5vC3aSh+AWp9N1dJueA/hUrAn2vujENkhR0Z/WOsXdh5as080DDExIV
	 KTi6QtHO85L3IwgUFF8Y+3Yp4d8c1oUByXnXH9ihQ7TRfuEfh4xwcueVntumllGfo+
	 /RWmIF+qrIx+7fy7YEdc3BZqYA3XnEG9i8kUYaZrkgeN8DM4H6iF+s7RdzSLWKfPBd
	 T6PjF2+cjOCWbwhl27ceiaEutb+C/urSCkyKT+ZFRNCJZjxe4JUSGeCxV6b/NnSG5T
	 IpkmPRhVh+a6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9DC87FD1;
	Wed,  6 Aug 2025 03:34:24 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 06 Aug 2025 11:34:18 +0800
Subject: [PATCH] drm/amdgpu: fix incorrect comment format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-amdgpu_typo-v1-1-b5a3cb84ce26@uniontech.com>
X-B4-Tracking: v=1; b=H4sIADnNkmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMz3cTclPSC0viSyoJ8XQsDCzPLJEMjo2RjMyWgjoKi1LTMCrBp0bG
 1tQACdEg2XQAAAA==
X-Change-ID: 20250806-amdgpu_typo-80869b122c36
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, wangyuli@uniontech.com, zhanjun@uniontech.com, 
 guanwentao@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754451263; l=1198;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=k+gY44TRXxHS44Et5U7hyAbjjywRyysMNE2p/m6W2bk=;
 b=scrrcR+qucYdJOb23SqbCcLG/aPsSIlZavZRQjljyvWN3luE7E0YF0hYRvtsZC7q8Fb2wsGPL
 6J7+X73na1/CqDc0X1MznKWPaBxmB5oEOA62tx24u1QQCfiWEe5UnBy
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Comments should not have a leading plus sign.

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index d5002ff931d841994ca2c70cdf5b989f5b3c59d6..860bc5cb03c81b5346743b5fb46a7dcbe5a201a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -151,9 +151,9 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 		 *   BIF_SDMA0_DOORBELL_RANGE:  0x3bc0
 		 *   BIF_SDMA1_DOORBELL_RANGE:  0x3bc4
 		 *   BIF_SDMA2_DOORBELL_RANGE:  0x3bd8
-+		 *   BIF_SDMA4_DOORBELL_RANGE:
-+		 *     ARCTURUS:  0x3be0
-+		 *     ALDEBARAN: 0x3be4
+		 *   BIF_SDMA4_DOORBELL_RANGE:
+		 *     ARCTURUS:  0x3be0
+		 *     ALDEBARAN: 0x3be4
 		 */
 		if (adev->asic_type == CHIP_ALDEBARAN && instance == 4)
 			reg = instance + 0x4 + 0x1 +

---
base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
change-id: 20250806-amdgpu_typo-80869b122c36

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



