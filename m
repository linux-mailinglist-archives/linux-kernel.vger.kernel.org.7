Return-Path: <linux-kernel+bounces-730135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEC4B04098
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30E4188A33B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC7C25332E;
	Mon, 14 Jul 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhy.me header.i=@abhy.me header.b="bfODwRDB"
Received: from hosted.mailcow.de (hosted.mailcow.de [5.1.76.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27F24DD0A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.1.76.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501187; cv=none; b=ndNNag2kTf3Ki1i8w588imXRRaGBTvUidiPUbmvyoFuZgFoSCmm3ZtixkpteCsZX5GXop4kJVN1o91QaMPBlERJjLP1m4c37XWHnPu8/r8bTCzYPo+wh7m4w1SaNv08krmcVP6J8IBIiwSwjlR0p3GmS6NnARPyxfeXIdXenr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501187; c=relaxed/simple;
	bh=ZpvaDQ6D1LgO7scU7GaRUpWvzJdm4Ccx4HXyYU2xtl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aipHCdJn3ROLEL9N+gWbmLJVVyrFdUWwU4qSZ/ILsHZwlKVE/NNo2XKQv5e0fcNNm8JMLiTTs4ggrStuzrq4RJ5R25HckvdulJ6Pg/vmmHBctApwAlHAuDd5odcSyZRBXDolqAlw9NCdCBhWN8lfGptvrsX8fHdSkWDGsoxPSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=abhy.me; spf=pass smtp.mailfrom=abhy.me; dkim=pass (2048-bit key) header.d=abhy.me header.i=@abhy.me header.b=bfODwRDB; arc=none smtp.client-ip=5.1.76.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=abhy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhy.me
Received: from mail.abhy.me (mail.abhy.me [156.67.110.73])
	(Authenticated sender: relay-abhinav@mailcow.de)
	by hosted.mailcow.de (Postcow) with ESMTPSA id A968B5C0264;
	Mon, 14 Jul 2025 15:46:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05A7DC1609;
	Mon, 14 Jul 2025 19:16:37 +0530 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhy.me; s=dkim;
	t=1752500805; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/XW1mZMqwG9RLzu6IY65wC4dZ35utOaJ0H/k4M8fGOs=;
	b=bfODwRDBe3IiAcXIsEiNlTmjA9vYfcWJrO2wxd0sSjcq/SyD3ggjk0oLyk4TEw/LmPv61R
	6gNQcZYE4djG0UlaAt1TFwtpuORNWzzKf3tT2LPeVmLRHhj3urThSB1hXb+k3lL5lLqsnh
	6tzdpA57iRXOzoPME8zXpjVeQFcRwdaIeW9o02XarQJTbs98zFmS5jaWlZZ0kM2PZzT5+g
	SFj9L3h6Rvu0J/16neyLvLEo184VF1qRuMJM0ZIw9rF7b6+D6OGsZzHhH9kDth7RLPeKCi
	X+zSGnnbNaPQf3usvaWDkksU0I/mYHEu+JGlipKJ7XnSUptnr2P5nsiYAQtnpQ==
From: Abhinav Krishna C K <me@abhy.me>
To: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	elder@kernel.org,
	johan@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Abhinav Krishna C K <me@abhy.me>
Subject: [PATCH] staging: greybus: firmware: Move logical AND to previous line
Date: Mon, 14 Jul 2025 15:45:32 +0200
Message-ID: <20250714134537.59218-1-me@abhy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fix checkpatch CHECK:
    "Logical continuations should be on the previous line"
 in firmware.c:123

Signed-off-by: Abhinav Krishna C K <me@abhy.me>

---

Hello, this is my first patch, I appreciate any feedback, Thanks!
---
 drivers/staging/greybus/Documentation/firmware/firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware.c b/drivers/staging/greybus/Documentation/firmware/firmware.c
index 765d69faa9cc..e8fb2f575cd5 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware.c
+++ b/drivers/staging/greybus/Documentation/firmware/firmware.c
@@ -119,8 +119,8 @@ static int update_backend_firmware(int fd)
 	if (backend_fw_info.status == GB_FW_U_BACKEND_VERSION_STATUS_RETRY)
 		goto retry_fw_version;
 
-	if ((backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_SUCCESS)
-	    && (backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_NOT_AVAILABLE)) {
+	if ((backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_SUCCESS) &&
+	    (backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_NOT_AVAILABLE)) {
 		printf("Failed to get backend firmware version: %s (%d)\n",
 			fwdev, backend_fw_info.status);
 		return -1;
-- 
2.47.2


