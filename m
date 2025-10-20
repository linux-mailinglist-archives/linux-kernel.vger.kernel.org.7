Return-Path: <linux-kernel+bounces-860527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF4BF053E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D353A6B64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3072F549F;
	Mon, 20 Oct 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyPbAZ/+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17B2EBBAF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954117; cv=none; b=BnwjuSKRb+IFdykMioMA1SnVb5GHL5w0MD8sRjzwG6u12g7ZKMcBdOJ+wLMAjn1cUjJ5lArGmj0EiywpNMMPLQnF3xgIGzL7BApB1MchNRYUlNFBD7rDpr3ef4oO2cd+Y98bYc+ZGokNENjaBps0U6yxCspiF56I+riZUJi0Dzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954117; c=relaxed/simple;
	bh=/qnsErc5VX3wSm2PY+usCao8ksKbiyyMWqGMwdn3Yus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu74+nCkRwH3UQ3MPEOAWpISh+ThVr9n1xKTBS1WJS8KPtVkTDqxRwMs1ndZlu+lsCfv0KINIrvEmx/7sNTIgEfo2jl9eEplXwO3SLRavpA927l15MAVTkx687OlZr805Vi42/Fdj78qspLag0icdqJE/XZ0LdHbdrRp8CAbOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyPbAZ/+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f343231fcso2735254b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954115; x=1761558915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMy7cvAKkSRQMgDlES0oX2LPH67n4kgF18iyVVK4oHw=;
        b=QyPbAZ/+tR4x3f05UYg1eznF0j5khwbFZHcYHUY3lkgWzXTnWumh19QBnQPwZHHAJP
         CZOlFnTyvJ/IdPZ8zjLxnri48JISxHtz2ymTlGbvo1q8EMqxIERA6qq59MdGYZREpILR
         JdQiHmKtbf7wEpBtijBbL2JwzSjiKX2NWezuQgEFfwzGMF1jSQ09sHklxb07iOjcnumR
         0VblDv9YteDrGWqEmF3/7ucwsGXxe3SI5r1K9faMW9QSN7YkTuXzKeh6EJXKOJWk5ksL
         IIOdk9NfYRjkgLH2daYWMdfHANPLs3DYdsar4Cs4wvAtWE+0uHCjDyXuPQ7V9baEFYNk
         XL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954115; x=1761558915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMy7cvAKkSRQMgDlES0oX2LPH67n4kgF18iyVVK4oHw=;
        b=ewsjJE4dutWzRJJk7FcZUzS2W/c6/3d+zLkBhEJG2Vn/LVdEZwogyLoAYxY3NfttIy
         iymiZ4b98GuE3KTpPyeVDzBuxxbVFYRpqySSHshLSYGKj3K3hNQYOG+w4+Cv+ennASYo
         bSzfaqva/iejZ8t9QE61XLMg+FIJZIyX+3THKHW4ixzdoXmxkbrJGGrnIZvtUe61TLjR
         1T0F8YfyDeev/5cHozX0EQlcoZNcOimRR341T/O/44R1rk4uc0ZnZ0ZVIPf1LA34lvhh
         4kJQQo68ttjmMtOYqIAnlrUAyY029Xhjg7E/9CkBavVqPuuNwK5gpuDKQSaZY1fHCxOI
         DrPA==
X-Forwarded-Encrypted: i=1; AJvYcCX3QV/p+1hHBm0CCytHNRV3SoSYWOBieNN8/oHDb3ByJAsGy/RMi9qS7su/YtacJcq0CxyBe01WI/e3fVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiQZ867PPMGt4yBonQBFRAIVNUt5LxUgZQJJtkA/9hpcI7No/
	Aik2S/wr0x4nYR9GFlywbQcZLS1JOAVnhGVtnvoMHSezkynTOjdXIBD7
X-Gm-Gg: ASbGncvXUuv9azbD3WYvbjpHNe59ENAxlpHZ4Yq3odcxRPPDLK4wIgrrTsRDIrnr/WU
	Qdu1oHoZLmgj4GGaNvE186pgH27fhSNsx0FO03nMpxqZFGLNowILdXSBs451ZxGdO2QviRqNwCn
	/63zDK/D3Qh/Vh3BkwAfiwHDwNmCMg2SFVuB+wAI+9RT9PKM1Hg6V6krhF2jSw+g6CdwKytasLc
	5r7y8K6LXfqT33+SCyroXuFjRd/XfhsCCUhLEcm2U5Y0Zxu8aSroQKvQwaKMbYtfbHylJ0Bsqz4
	xvEgz5ggtF/B12yBRy9fRERrP22LPyHSsIMXQSXMGQ/Su6DEvQRJ3wxfs3eNecwGJztcjcIEZGH
	Brc1vaU18VcZ/nQaF5kLTF+kzewlA43oYnGTvvhOIsdA7R27c7nqDNKf4PNJAeGIIVptpSCYSAx
	6G
X-Google-Smtp-Source: AGHT+IEgNjCLwH9jnOtF50+wmm//PGeZnCT/rP60wZrNs3v7YACWnHnFouvSbowCzzk7FowyoXdKEw==
X-Received: by 2002:a17:90b:2fd0:b0:32e:3552:8c79 with SMTP id 98e67ed59e1d1-33bcf8face6mr14790843a91.29.1760954115057;
        Mon, 20 Oct 2025 02:55:15 -0700 (PDT)
Received: from localhost ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5dfc89d2sm7654264a91.23.2025.10.20.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:55:14 -0700 (PDT)
From: zuoqian <zuoqian113@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zuoqian <zuoqian113@gmail.com>
Subject: [RFC] net: macb: enable IPv6 support for TSO
Date: Mon, 20 Oct 2025 09:55:08 +0000
Message-ID: <20251020095509.2204-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New Cadence GEM hardware support TSO for both ipv4 and IPv6 protocols,
but the driver currently lacks the NETIF_F_TSO6 feature flag for IPv6 TSO.

Signed-off-by: zuoqian <zuoqian113@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 214f543af3b8..a154c9f3c325 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -78,7 +78,7 @@ struct sifive_fu540_macb_mgmt {
 #define GEM_MAX_TX_LEN		(unsigned int)(0x3FC0)
 
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
-#define MACB_NETIF_LSO		NETIF_F_TSO
+#define MACB_NETIF_LSO		(NETIF_F_TSO | NETIF_F_TSO6)
 
 #define MACB_WOL_ENABLED		BIT(0)
 
-- 
2.49.0


