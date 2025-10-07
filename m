Return-Path: <linux-kernel+bounces-844011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E5BC0D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C634F34AABE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D72D6E4F;
	Tue,  7 Oct 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+6XD9is"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1D2571BD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828409; cv=none; b=UISOIAjAGDWSM1QgIDqJ/5hhNjpnpXou849fh9cUD3xc3cgv/oOxsXK6nEN8vYN15O+1/dWjhmq8G6xnurLq0fOykokhnEb+7Szoooq+G3FEBbwPcPUTnM+O/1wdR2Wgb6kYkEZgEnVAXbgoVcbVPsXhB1zFtK6JotTVefjos9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828409; c=relaxed/simple;
	bh=lAVDGc2LK84Ub0jbxmUjMOcpfOBmY3qrd6eZ2zJcTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOqss0CzdKytZ6gZmoFGo1M5bJIwNLzsBnNTphE5nd7/U1SKNclk5EoLsKsStzstAXmA5f0PzEhx1fipcdGqQ/X0zqcSaFFgKRlMtP/mIg6B4zH2V2Yr70FSq7KZBzDbC94vb5Rt6oAPezb8h0n/lvElJwmTquC7tUZ4IHesXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+6XD9is; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2245563b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828407; x=1760433207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJtapFc34rZOz8eU7l/AxCg1WyZd+AeqhYHeXbqdkZQ=;
        b=A+6XD9isPMzYrzaVPPc52eSKNWxrvBSrp5Hhkd0QHQh6WgcVulAiXlXIlyr8MiYOhv
         NYv6+9vcQ6zvwGoHIXPp4ZQHxH+lQQVlIOKD+R7dLMWmX/1wanoMDD2X5sNRFmlt6skJ
         39Zo5G5gqPty3AnsMDfrUh3AN1Upk9HKNJAT6Te+CvRmn0ah3RX5rXXm+meVRPY6bf2G
         8R99g6eb8lo3lCCB6im2rW0xKBRQ6cJg3cIcqIqpjzbHZ+zHYkto1nC5BcY/aPS+fCpU
         K7upBIiwB3Iu4MKx043SwV61s9p9bos2lQrHrbmoBy0ZlNDihuC5WTxaHY7tKujKvskD
         TNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828407; x=1760433207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJtapFc34rZOz8eU7l/AxCg1WyZd+AeqhYHeXbqdkZQ=;
        b=g6DDgcinmlFrPttYG4lzWR5HVMyUR8AT735oAd8/fllDAM99qPrAjaBt5lNNBiHfL7
         SSdw76j9WY7pdKzqDfpvD1MI5vqPVaDyvQg08pZNdJEpALvxV/I+hXgVuRslaJ8Oa0D5
         gWXVI0Gpgzp4LN4GQ09MuaGMnq2jRJYEYgLRmHbbM7mdgIbkyC4CrFXoDj9B0KtTAqRx
         9whYBip82VGyASEV3k4EqVueFM/nnJeD1lQwJscSK354oAuXi24146bQ8xy/7gQBYvHj
         73CyWhc3scg9xiOVtW39PR3nfyLmXpyOmxCB6kUnLTYQX3Drj/IMc0RpzATMoDxfE8t8
         NJRA==
X-Forwarded-Encrypted: i=1; AJvYcCX/6u8kiiYFfTmFHzQgKMqt3T+89jpYmFX4esdDqgvJTSnQqH+d3w9jjotoAl748ZD7Bc484FajCCjgqfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zgbNkeRkFJXAJM7D9mhnwgOAyDx/EDvdIzrt2MqWm39VhTLY
	3OQAtUFeo9gGlq2dt/yWvhV1LQi5ufKp7ZOQj5QfTEThc4lXUyf1cTTH
X-Gm-Gg: ASbGnctMd5F57LqeITE2rpV6Is8lbsaW5fpw0Qi2CBbKdTz64T0JtWTUG3D3TYvhkt6
	zEI6XZFYhlgzWWK7tLkgsq3vSnpOll9RKdAt4OmnB4Sgw2WPlCq/WSBhQM2OzVV6GOxPIBpctnC
	aBFComOinNrVa1pAVV/EOhNFNrWI1QheL/Bm+CalY6/mKtWE2gv+bBeL5pmPV/6WmqGiLxJsXXS
	jAf8p+Q+Zgxun5nLbWn6U7RFMh5tN4d0oSF8dp0FEHaSsK68OjEt8tBIWbiDUWz9PkT9Ym3z+Le
	rL3mTP9adbiTonsaZjhpPw2RKPV2kvxDL1aHcF/1YXjoXVaDQ1iPX5BarvAEvWMaw23Mgyb+HGW
	dgPEtKk3Ju6DL0COOHCLXcPu6EHQaevnDVH7CxjBBFTIG8495R8kx4EeaiU/T
X-Google-Smtp-Source: AGHT+IGsCw2HiJs9AwDg2O1EQNO5zOmV3sAvt2f8shsaRr+S4pyGyvmsnnhDJznLDazcP2/9Ze2ZgQ==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr20785655b3a.1.1759828406742;
        Tue, 07 Oct 2025 02:13:26 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm14941784b3a.13.2025.10.07.02.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:13:26 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH v3 1/6] staging: rtl8723bs: remove unnecessary blank lines in rtw_ap.c
Date: Tue,  7 Oct 2025 05:12:58 -0400
Message-ID: <20251007091303.491115-1-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes superfluous blank lines where appropriate to improve readability and match kernel coding style.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
v3: blank line removal only in this patch
v2: previously had an added blank line too
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 0908f2234f67..373718cbd6b9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -436,7 +436,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -1252,7 +1251,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	}
 
 	spin_unlock_bh(&pacl_node_q->lock);
-
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
-- 
2.50.1


