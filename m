Return-Path: <linux-kernel+bounces-746964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB7B12DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32817B069C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC47188596;
	Sun, 27 Jul 2025 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwHnk5uc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAE157A72
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583543; cv=none; b=lxMM+q1w9QUYwjfusmoEhkUdm1k/gYBAsU165cRT8SLjiFBreP0vznvryzewTHyic2SlwC+Vh9scfmbjBSNoHf22e0K/bNGzupUzcVcAZ9mVrDCw+BQKuZf6PnPBIQLZqb76+F8EO9bZOHQm5l8hpZHwfT4lHMzFbu50NV668u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583543; c=relaxed/simple;
	bh=TjaQFayFeJH1be7gp++jOfDk+rRBP3Y8ciq8gzmqr/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dk2KhigRuYmR24aDsMG2Rx1s5FTRWCs6LfZJNFl3ZrOIRtXQwng5MfWpd3CDwqmXCx/L1Rdj10IqmX2FbOIRg/B7ARhi5y7rtdSXBrCLwbKjabSUCVWNbttus8WzCOKIzZrY46na9T1vvvsUCHyhpACctLcAAkbUrCM68aZiHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwHnk5uc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23694cec0feso30116105ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583541; x=1754188341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oO979skyP/4ELP7MCIR4Wmue/sdryWtrxc/iVRG4X8Q=;
        b=fwHnk5ucR0tnBBz1GuUsy6Pu6so2stz9sEdN2/6g5oEh2UG4ThpzGCeOl/2OMeyLxJ
         sh0wsbac5/DREJTTpBhuZsV9yIKkzerk8k2+qHAL8UYn6TJ8Vs5qu6tjHm0ECvC2T8v3
         VHDml6oTClh+F7KEJKS5f5BW/K5fl09SZWtjdfIGcDYIVSL0xQ2R2vRxE8V1tiQOkyD7
         6ZiG8FPUZFwiwDn4GG2IRMf0Dh8jsFhMHcrL9EAivzDPOiF10DyWK8mZW1hcetu1htck
         MTiRY+4yaunI41a768zJ3xz7tsXFvLp0Atu8JMVqQU52NNrDwaUTC1aSzy5P7ZFOtaFG
         TF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583541; x=1754188341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oO979skyP/4ELP7MCIR4Wmue/sdryWtrxc/iVRG4X8Q=;
        b=SiYxBTSLVgDPpHWX0LCtva6l0HFeDHdXm7LUhx15aUmsk2SHsT9gG6M4kCtU7hbaZq
         bbTp3ab6s1heTB8qBIomyp/pXTPlHY4FaTdwCAn0UVYkD19stYxFiRGb/BLmVXCzAv3s
         /XSE/yf+6M6oOag1ihQGW1OnvdGZWCYXaDUFtjRoKNKRgx+VT7wy/1sLWt2LJqFOBq36
         00zrfvBULOvZ8YpUy9zu8VC97uwekKedjmVKxr7mfziMzS0vNEIKksYfUa0xKgN/vqD4
         l39NvwmoppYxOyCQ5UOo7dj9QFFiS1TYqlg0fy6EZjpQgVcK/tqE40DE6edNpxhdDNgk
         hfyQ==
X-Gm-Message-State: AOJu0YwJVUA+WCLk6yVy7FA2E/cZnIGGIVw/XARo4jl2iTURAxn1Rll9
	Pa4Y1N5c5PQCcR+Tzw90F1zy1w9GUbJ69+WT+tx50HBNTwe68HClDzv95t921d5D
X-Gm-Gg: ASbGncvL9tuJDMl9SHSTseMTx0ceeGOFAIshmTyKaDnqWcKAIomm1rFToGKZJBZwHkh
	xbRs6MFosPbG6yxqAhmAwA6Ty1xnfQY59TcRl0z1X9Mw6hjX/6K++0DX4/PdlZGUzipF8o4WvrX
	mQTcWQmoGbaDnX7cRbaMEOeuzzP91R8KaHUY1bLccPC2nsohXimIEJjYT98CLRcUEBUykYEvLoZ
	T0ytrju2qZjm5zwp8WGOTePnWi1ioCjRaOc2Vjyre4EcSq75sDqoY/y23/+23CyY4kFAYXsJqGx
	eimmUEwBpv9n8A8rOKFWCuoCNZ3fRY4Fb7X5F6o4yHpE+uFjnJIa1uS2iGEDUVNT7L7yyduAZhA
	2RNcDBfscgWlVBft5AWJijJgXdT/29siGyYFn5I/uRC787wDnXVegWfRV
X-Google-Smtp-Source: AGHT+IFQZeJjrinfpCN4UriZZ5YDyRU2nG4F28O/HuwOZmlI4CykRUXLxBMNIG6iIaImzeaUJJO6aA==
X-Received: by 2002:a17:902:e54b:b0:234:9066:c857 with SMTP id d9443c01a7336-23fb3041de0mr121441575ad.21.1753583540664;
        Sat, 26 Jul 2025 19:32:20 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008d8e9a2sm2990275ad.142.2025.07.26.19.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:20 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/net/wireless: Fix typo 'relevent' -> 'relevant'
Date: Sat, 26 Jul 2025 22:32:25 -0400
Message-ID: <20250727023225.82743-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/net/wireless/st/cw1200/wsm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/wsm.h b/drivers/net/wireless/st/cw1200/wsm.h
index 89fdc9115..ad1c0140a 100644
--- a/drivers/net/wireless/st/cw1200/wsm.h
+++ b/drivers/net/wireless/st/cw1200/wsm.h
@@ -878,7 +878,7 @@ struct cw1200_wsm_event {
 };
 
 /* 3.18 - 3.22 */
-/* Measurement. Skipped for now. Irrelevent. */
+/* Measurement. Skipped for now. Irrelevant. */
 
 typedef void (*wsm_event_cb) (struct cw1200_common *priv,
 			      struct wsm_event *arg);
@@ -1151,7 +1151,7 @@ int wsm_set_uapsd_param(struct cw1200_common *priv,
 			const struct wsm_edca_params *arg);
 
 /* 3.38 */
-/* Set-System info. Skipped for now. Irrelevent. */
+/* Set-System info. Skipped for now. Irrelevant. */
 
 /* 3.40 */
 #define WSM_SWITCH_CHANNEL_REQ_ID 0x0016
-- 
2.50.1


