Return-Path: <linux-kernel+bounces-883640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F60C2DF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC4914E48F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D522BD031;
	Mon,  3 Nov 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi8CNnaz"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156F238C1B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199780; cv=none; b=Y7HVAznYdEJu3nFFsKH5Vz2VEssMmJQs+dPtC2bfx31axmMWgSdBK/xMsjM9Xoa1w8TE3tAGdMEOr44UBYAJ/tqvhwpyDVAZ38hU6A4NHyQLMNpq2Yvh3wPenDPH3a5QY9mz4jqn7wMAbIUonDTU5V4NLDgCbt1CfnqaOtMtJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199780; c=relaxed/simple;
	bh=lvQE9IXDjViYDaZqGsXBfbyMcW8IDJzareNHsQ1mwz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJhCBv7Sg5LpuauRH+BgKEpJrAd4rc9ZXA4eNZomD89HAukxCTJnpbdKphQSNKf0gNoE/rNZ+zXRcZu82jrpwjaFJWGOh7ahHNnDqoNjQdc7lecIiDCVeB385pK/Rw0F73Two7ZwF+v02fSxv0XvT+wRBKs2+kpn3kbRAAHMDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi8CNnaz; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b0f54370ecso33651285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199778; x=1762804578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCNIkCfDGhzdHNevSGLa4u02mQfcHltPe0YUYtYtgr8=;
        b=Vi8CNnaz+3rRH99TDTiJw+e6WztwnefucKI6lfr302cWROE1oL/tmtBOjZBryrFp3z
         Sa/auLfQoZe86wK7rnANd2Tz/GypT7VenF3aN08GUPTTODZ9WCXRjmNtRFilZNVZpoQ4
         dQcfVsAWsASeugTL8zHKGaD812KEPTm6clttBs6e4uQUVIGW43SceHi1riCKCCgilUNC
         5BST7z8pMrbWfuOA1VRCdf5IRHUIZSA8mQehB1BOai+JTNYXvpDECck1MbkZGq8si75B
         zbezMk0R7g2vvLpBLaVSFRuo3Z+l1UNUBvCDH5j6V8vQbz168y1OBa1TCSxYI6uF0KbS
         FbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199778; x=1762804578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCNIkCfDGhzdHNevSGLa4u02mQfcHltPe0YUYtYtgr8=;
        b=Mpgm5edJQ6TGUvm5YMvUWxw2uWP+YcAK/jeDqAWWWUXDyDC5Pkg2XrIuUAP18On9dc
         6sC9wA1bZqYfdb5nMJ81dSSJK4ZvM/fouc9lMvFkYAsK/5R27RBrxfGphbtVxwmrjZcl
         1ZvXcOylvbCH2DN9k9TjF4kXiYtXstBcqG6jDjhEOy8OIaW6UrHbWW9zPHpZ10wYq4uV
         pY3pUiuJfXEikw5QlcSyjefUkR2pSBkz8Vg4R/1EvcIp2wFKssOc5eI9/Q+NYQIAiFmA
         bgLE1no/vefi+Wb90W11K/KTmMQ9rnueimLtCmZoyRsUa3pF1v9T0xSb8qWkhqP43HcZ
         8qSA==
X-Forwarded-Encrypted: i=1; AJvYcCWVOREiWArtbIsHyZSFYoA9yL4QGMhRQHjyTaMkDWuYDU9ZB4IVy/1ozFIJzKiEzM/x9eKYNWkpg4Pesss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBMQFhIjzXXNJ0f6BOlTqRCvWwSc9LuIOtYpZsiSPbCk+thOB
	oLy9s7DJc/OaUbB/opx3Lgqcp6RfimUjTqzFmaXhtcVpbSIJpzUlOtbY
X-Gm-Gg: ASbGnctneMwKlsDJGPKk1Kbs5CsueW1C16GE15xR3ZGVr4eYPgvW5OrYc9tNsD+Hxu7
	67Cbh12JCinp/L8GOk5GBRQEL601PlkCrX+8pLc9pDomve6e9S8EAFrAG0EF99axaJHwzeqsiE1
	/RXBusyV3+AcuvBaSHb+sYqPflpJr9AlEK+0yPU2AqYqPWOknA/QfzoMfQjMC0kCBBZIGAtQt1g
	xZytWIM5ni4vsE/E+XjXlHBxrxLgE26gmmiV5/0BDCvo3vP7yTvTGja9x3AmeSI2+QZugAtMBKP
	BLsZp1zErI+6F/aA1EoQ9bZG06ZyP/lgs+SaVdAYausUAgGFXaeimWq7ruWZlZCEN6ljM1W+COA
	hn1NBrzWsu8sp2DK2bUF51ShwsN2oQPWNyXXGiPSyDhs74EoiainZvofRwdkJU09RIz+AIitUU9
	EwgBg6sK+umi/v68P4HOcJkmZkMnLg0O4bcGuzRwkUUSNhTAf8SN8zSZYiBYRfuu9nIE2zsMIB2
	WtXkQZgf1mUCJE6KGwJOSddLhenDlnp1ZnQya9cuYU=
X-Google-Smtp-Source: AGHT+IGoVRYSbVBd89q40CWkubpNIEtt6jIcApZg1DKN4itrnqMDZ3LKzFY5+VURygVr+d/v4qFT4w==
X-Received: by 2002:a05:620a:7118:b0:8a1:94de:cdc4 with SMTP id af79cd13be357-8ab9b883c55mr1524316385a.83.1762199778179;
        Mon, 03 Nov 2025 11:56:18 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f543a01csm47274085a.15.2025.11.03.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:56:17 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Pontus Fuchs <pontus.fuchs@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ar5523: fix integer underflow in ar5523_data_rx_cb()
Date: Mon,  3 Nov 2025 14:55:20 -0500
Message-ID: <20251103195519.3152385-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In ar5523_data_rx_cb(), the `rxlen` variable is derived from desc->len,
which is provided by the USB device.

The function checks for an upper bound (rxlen > ar->rxbufsz) and for a
zero value (!rxlen), but it fails to check for a proper lower bound
against the size of the descriptor.

If a malicious device provides an `rxlen` value that is positive
but smaller than sizeof(struct ar5523_rx_desc), the subtraction in
the call to skb_put() will result in an integer underflow.

This passes a very large unsigned value to skb_put(), which then
triggers a kernel panic upon detecting the potential buffer overflow.

Fix this by adding a check to ensure `rxlen` is at least
sizeof(struct ar5523_rx_desc) before performing the substraction.

Fixes: b7d572e1871df ("ar5523: Add new driver")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 1230e6278f23..dfaccf241560 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -589,6 +589,12 @@ static void ar5523_data_rx_cb(struct urb *urb)
 		goto skip;
 	}
 
+	if (rxlen < sizeof(struct ar5523_rx_desc)) {
+		ar5523_dbg(ar, "RX: Bad descriptor (len=%d is too small)\n",
+			   rxlen);
+		goto skip;
+	}
+
 	skb_reserve(data->skb, sizeof(*chunk));
 	skb_put(data->skb, rxlen - sizeof(struct ar5523_rx_desc));
 
-- 
2.43.0


