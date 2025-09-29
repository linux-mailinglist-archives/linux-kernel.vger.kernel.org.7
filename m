Return-Path: <linux-kernel+bounces-835847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A014CBA831D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9E3AD2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED92C2374;
	Mon, 29 Sep 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7CMxSA5"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0E2C2359
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128658; cv=none; b=W1QprMPPw0lvtyLA8OpfsQ7cNkE1X5jdaR6OGeYiXX0rDy+NrJUxoS2Ep536WVHwWrXHNdTyWq8nPFIUa/IZb/gBcQyNLarI+5a9xb5wumyqYZ3XNoNn3D2LHBuutlS7YUlLmxyMltIsH8pv0jG0sZPG8+sjXsCuPEvThh68zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128658; c=relaxed/simple;
	bh=3hU0mJSlz0a3Lg/lIIjKdyRK66MzpbbQLwinLi5C7Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHi1VRyskJiJ9qqP8S89WiErkpyQ7S7JV9VAsDe/qX9D4CJQx9EZry66hsRKve+9YV/+ly2R2wb1YMRchvUUkc2AsmX7TeHpsP3cx+I7tJoDGU5tb7JK4Bi7vOC6Hfe9acC13EXtgvmF+WbeIT9Knvs7mIVhGu8sv7pU6J5n/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7CMxSA5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4de2c59796aso23182791cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128656; x=1759733456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urZ132At0Po/LpA48SKHNWLuFOtj5UrmYX1lmPgIIK8=;
        b=m7CMxSA55tZaCRIkOCTQt4OTMa3Lg1tJEmuH/ARyExGzWS/AKXuHkapu68S8XyMkzP
         GmLPGHuRkp8NDksVk0TPqv33a+bYsH0SdPcauTP2c+U3ECmnXgFbq73+2pQb7ERgWPCI
         g1WqUwG8TadPSUX2tr/wYdmAqeQfCd/I2QVjUQgFMxRgoAJ1A3Q9v3FgtU44VU+VoM4L
         gf2+DjvvuagBqSAj4NyvcTEuYD0IylT21LJVh80pL9xfsz1sOXwJUlSMFnt3Mr7+yFid
         S0c/2EhmqfwWz9bKs0EqaALzWCJmHON1eHU0A3vcEv+72QwrWdCbhW5K8bTS+AOXiTLW
         8mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128656; x=1759733456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urZ132At0Po/LpA48SKHNWLuFOtj5UrmYX1lmPgIIK8=;
        b=aIBAz3BqkYmeo0xtHPzYAMR6A5CtduwvSURLDd6jS2ZGnXtcf4+O+ZeKsNl+fqzGGX
         ilsCCKXSnH2JM6ppmw+0YDGvpC/fUpqob+fwgsNjVl/+YTVeifxYWQ/JJOLRajcrNUgX
         966oZt9kjPStnzpNhmzvhqUTLlAvFWtFl9aEr6TPixigi4rOUCD+khVkQBV4EXklfnL9
         YkUvh3CxnKpDLbSYPGmYQAc87h58v0u0gT8SfEVZNHAI7D1h+E6PsWFnodDyuf8LEFLs
         1xf1Pg5ZhY3xgQbdNqxBWN2V15A0xLZF8SgOlVX2NczEqgsKb2UPVFiqs/KpOePhOwen
         1A5g==
X-Forwarded-Encrypted: i=1; AJvYcCWTWS1oQF+Cfe4wDfiXLO+5i3yMm9L1x2Cq7pydVxlu6vlTven4ZP2jBCzcBOrUGW56zA6DTH7xAMajFlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DX5Nhkr50YLoe8nkeEi/ZE8pcTW6SO7+XgsT6b3fNhorGrrY
	hInF+rCv/+YQmMPHshtZSgtyfeVSjmFcv2Ig3GC7OGUTrm8/4bl0ijJv
X-Gm-Gg: ASbGnctUc2A/crKVFC6tvflGHpDzU/mfvetKQ4vY44NoatXC1Hnm9fGCobVnc4ng2lf
	lG/3n4WyLXX6D4bcpbWWAEMTA5oT8BiLqM3rJSj4VWj+ncyXCL+RMREGRzY9qY5n2PI0+AxmBjp
	MXNpH0zdtOihU6m5NqxurGjYMB8g6Cf5OAN72FJ+y3VwyLqU454WT++M4ZVdinQMJkMVxy9NKra
	XtlUkqEMrHZgNCSRb2EpmgvCWRG8XPVa+tqn+lnaAPKfZ3pRqLXNFjseZO8uHLjdCU9QDsFKz8U
	OnECidjgnz8P5JvwjGAvLNjWVX+A9c2PO21Ur/+rAFwTSH6wX/q1PpV3hnk/0qtgPElzswbOJUc
	Ijj9DK/1PrXU76pPRRl6NL8xdTV4oJZSoY4O7mOfDciaR8PDlop4=
X-Google-Smtp-Source: AGHT+IE4n+KCbqmRxlHUMQ+S/dHgHWRi5PxE8e1izWVyd/kArNAL2MExOFV6mZp47X//llRpI2XnyQ==
X-Received: by 2002:a05:622a:109:b0:4de:9bac:84e4 with SMTP id d75a77b69052e-4de9bac8846mr89001481cf.78.1759128655771;
        Sun, 28 Sep 2025 23:50:55 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:55 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 12/15] staging: rtl8723bs: add braces to all arms of conditional statement
Date: Mon, 29 Sep 2025 06:49:57 +0000
Message-Id: <20250929065000.1010848-13-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add braces consistently to all branches of conditional statements to
prevent potential future errors when modifying or extending logic.
This aligns with kernel coding style recommendations for clarity and
maintainability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ef9057456768..8879d7056324 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1668,11 +1668,11 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
+	if (pmlmeinfo->VHT_enable) { /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
-	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
+	} else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true) {
 		mlme->auto_scan_int_ms = 60 * 1000;
-	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+	} else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
 	} else {
-- 
2.39.5


