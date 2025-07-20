Return-Path: <linux-kernel+bounces-738271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF2B0B688
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E01B1775BF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDB19644B;
	Sun, 20 Jul 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtvX0G39"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB11E1E1E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023392; cv=none; b=SI4fWCezohfO0iFKCBkD9mUc2QyAgYGbDydkIU7Yp+qq1olqR1KEodpI9gcyd9qq7WChIMjs2tX6GUWYGOTbRlpgjx7tquCNFGqBGNxj8F09Bnchq44B2PFjMd98oKLZwRpPq5qgiz9bHPKgOuYH0xDNOGloRbQ/zHUiluvsIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023392; c=relaxed/simple;
	bh=mWyrTWsnTK7eVL2ucLwWqpg72terTu+CfZahdXbXO8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQkAcd13mo1RXG/9xxA7VjUAXlaU0s7MDoOVn836vF39ZIgpXliG9IsvDM+I6K3JudTjxlnUz9+Ke0604xON9jCHzxdR5xH8NHSdbfHwr9JdGOEuUZGsM9AauI7kOdna7RIKQsYNHYMUJ0skCpj+JqAv9EvK0RwuAnMB5hMhZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtvX0G39; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00283a5so21182155e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753023389; x=1753628189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRdo3LqdiuYxa0l565rnPZPszxyhOzRNI2kuLRN50Co=;
        b=DtvX0G39L6M9i9FUZw8f5q/rFX6M+ZQsf0BzZlP+QqGY7JiTWI8jprGj4OiHoewkSa
         tacE0q2PxnL6ATXqdHsZ3bCI/RFKrOKHfW9xfEcfamk8TCp27xMpuX3sNSthLP82NiKa
         X+SnD6EjQM+dyc46bN/6TxptpqEAb/EGhYYSeSxskej5YzvbTr4cp5reUCohVVYwv3DX
         i8Zyr2FaKF1drMWu2qtCln5TWw50Vbro7Do6wYywU/NL7YaltHwJrpznAiDDWtBBWHKG
         GR2+0+58J0etUiODEAj+UlGAZn9hzKHfexOkJsSjPrt21lOfMj9VlL1ncJsJ9iwQTeFw
         xNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023389; x=1753628189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRdo3LqdiuYxa0l565rnPZPszxyhOzRNI2kuLRN50Co=;
        b=LBwsnyEBtFC9asaYSvkO8P8E2pQkuLJOER0OtmzbOaCM4qBbVhEqPOwR3qMfsOekQE
         7mFbBTyyulSHR42yGS4c4mpyyJk40O4wzbTLYzZepTUMJKlSfvobM1KcvPeV+VyNFeOy
         HEE0fZ5Fdh6q26TXwKVDQUDi/j5drMFXR2j1iNMHQKYjSTTyGAoljxxTjn9rPf9B9Blc
         92hpQ622/SIJ/jPqmQkzlY6+1A5ryHAsl4Pgn1w0MPfAfYu14QsF3zRWqpESfYkn29o5
         9IP0pGO84EF94qHE3NMJpU7kSGfwluDYGwjhl1mC8dZ8ENq+0vnEeQLeIyNG/fWjAU5Y
         roMQ==
X-Gm-Message-State: AOJu0YyJZQUy+7uq2v/1OXvLQSvE7WEcpRTL5EBjAUh+flHMw8y4XCBA
	7LWyp0+Pqe9iRQb3Fu3o2wToHYSNaizhLi0sMlyY6LOCnBBJ65H2329h
X-Gm-Gg: ASbGnctTUmtVszCO5lotAPesEnVQs2hj4CeKBlSa63DpxILfIAjLR3SyTAyLLZRPVhE
	/OB2Qvjlp1gErEsWxzoVcuBzVyzTRJCkxM0YrXXo50wCV8knuGqcsX/KGkgun4E1abN8F+eIXQw
	8BN11cxBLCsspmfv486HSD6rFdH1kbv2sxtRjHIwEcKrXuwQqDCdeQzkkYc2fygVWVLu+QySb2x
	HNTisU81wYzqKT01M6W9W0iASvX0UQjuezMuR6Z6A1hfM4wdX+Ts7Jw7Jp7u5VSBXCZ3wH9ei/s
	63UVielZl4ryVwwecJ9HQELA0SNbrgb7OHjpbX83f3B9sv5nSfWoks+oAwQWYVka9lWqKJVwCjh
	q7qOfXi+FUmXSlqrIjUo805oHZ89mWBk=
X-Google-Smtp-Source: AGHT+IG8e1KtQzYSLx0BPesPFUjhuIJ7UDeJpFPe7u5MvIMjFZREUEhHGw4SPCYps+xOIW03s3F4nA==
X-Received: by 2002:a05:600c:8205:b0:456:2020:165d with SMTP id 5b1f17b1804b1-4563b8fcc48mr93798435e9.31.1753023388967;
        Sun, 20 Jul 2025 07:56:28 -0700 (PDT)
Received: from zephyr ([77.237.185.246])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm7770550f8f.59.2025.07.20.07.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:56:28 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8723bs: replace unnamed parameters in hal_btcoex.h for consistency
Date: Sun, 20 Jul 2025 18:25:24 +0330
Message-ID: <20250720145524.9733-4-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
References: <20250720145524.9733-1-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update unnamed parameters in function declarations with explicit names
to be consistent with the rest of the functions in hal_btcoex.h file.

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_btcoex.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 525cce3574f..df58b11605f 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -22,7 +22,7 @@ struct bt_coexist {
 
 void hal_btcoex_SetBTCoexist(struct adapter *padapter, u8 bBtExist);
 bool hal_btcoex_IsBtExist(struct adapter *padapter);
-bool hal_btcoex_IsBtDisabled(struct adapter *);
+bool hal_btcoex_IsBtDisabled(struct adapter *padapter);
 void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum);
 void hal_btcoex_SetSingleAntPath(struct adapter *padapter, u8 singleAntPath);
 
@@ -46,9 +46,9 @@ void hal_btcoex_Handler(struct adapter *padapter);
 s32 hal_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter);
 bool hal_btcoex_IsBtControlLps(struct adapter *padapter);
 bool hal_btcoex_IsLpsOn(struct adapter *padapter);
-u8 hal_btcoex_RpwmVal(struct adapter *);
-u8 hal_btcoex_LpsVal(struct adapter *);
-u32 hal_btcoex_GetRaMask(struct adapter *);
+u8 hal_btcoex_RpwmVal(struct adapter *padapter);
+u8 hal_btcoex_LpsVal(struct adapter *padapter);
+u32 hal_btcoex_GetRaMask(struct adapter *padapter);
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen);
 
 #endif /*  !__HAL_BTCOEX_H__ */
-- 
2.50.1


