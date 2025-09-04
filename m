Return-Path: <linux-kernel+bounces-799669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DDB42ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F156F163C56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9FA2116F4;
	Thu,  4 Sep 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6KGGnkB"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86031F9F51
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949201; cv=none; b=S9u0CvXUJ2aGQc1BhRlsaU5XkN24D1kwrHEWfirSThKtFh36HnQPMMwMEiIXd67XIpsuqXmhrnCQGDtckcgdn4gUhW8+wOaHQJWoeSVfHpd5YAcFPxsJfZga6M7QINaOp4pQjXKuSSzauhb3suE26FAmCeUARSliYAuPJa7HZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949201; c=relaxed/simple;
	bh=8er5g/JdtGmDLwAxnKtTLLBjMA31RvembXwPpxkN0eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfRom64azk+9LVyyjN3Aq9ipQfvwj7gAPzT/uyW1j0o3YbXBIUJY6tBNoW5gvUKlC69LBoZQFTPJmN3tV11ZTrIPEumGtZBuQKRH/BtU9YTX6l40+vqREe85CYZMXHz7oXfTwzjgHXwvg75Ye9qL3f7rzTSxCz2dKBFBFqIK7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6KGGnkB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7209bd264f0so18146276d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949198; x=1757553998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=k6KGGnkBDE7KJjy05cMz4DRwTixVMl4Jxpnea6Wib9gcMSSZyi2ymzsogijSScN9iR
         khAq7eFYWzXAQ2zMDc6QLXIruiK6uaQ3SCdoTqW1n93lic0VCMWKLy5MCRJbilSFPomV
         mledJmp/umCaeLieKDOAnCquOThPMz2ysk1bGTaTuCOosD0zNPXwq8Z1Jfq7j/zPH9pI
         thoxgzq13jDom5V/LzbpvM7ZjIr23+gymxiIEva4Hjgb8XJmcT6KCCLUp+LBdxLlGxD5
         W9IdvmuTxuNjJFt4B7u3gGyzrMHoRQv1bT+BMm64eKH+mlJlw3H05QqXNGIOiCOWBfh3
         w31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949198; x=1757553998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=Jw67G5FHcudi0BJT5b7/+pGxzm4Bdell94ETUdL8ROlLnp+E/95yciSw1I9Pzjqfaq
         CBoiePCAHG4AF8H/zyv93lGDFHoh3ZnxbDdgY5DgBVAU1TzLzJk8Cu8Yxd+8hIPDeMRF
         0k3Qh1qc0X4J58kDbDjxEmQ9s9Bu2t4WUjnjaUYuNptSYHCf8NB2RaJNICs0Uj56lYmW
         kimthtEs8HEJk5AcrWRAGgeWWyfZMphKr5PJjf2FyD2uC1BsOpV+SLs0C+j0G3Rb4PGb
         U+RPzIsiuRvZQfJlmN7tYJN0IUWO4cqIKhTGgpPRxErM8wIvU/1TrvgvNUTcyv2cqciq
         bGDg==
X-Forwarded-Encrypted: i=1; AJvYcCUf5Ax/T8jwbKD6BiPq77j7OFr5cLhPEX6W+oyjxBtxsHD0SvMFRRGDIfk4aczuECrHwAGfRK4EdNeKQeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFQzsG6Vd66pHVTeZBc5e+AKVzV0AkcgUWWwN4FKQ09E2lrzW
	IDlZW1DZCueh6tIgVGNO7w8UAjIZJ4qUOruCfBwGggdbM04uo+GKEWuj
X-Gm-Gg: ASbGncuVTDEtW4jFA94NQLLT1cSGU6xMXh72zDqHIb6rptuXCLGjq16+2CU3tjDJb5e
	7cZ2RMbOcY47FT1aTSfGt+07SWvL9f+N4iWxzhruPQicK1d/fOY8LvC11UCYQo9kiYF3wrwiITG
	tHrS6SQBqIVMw6/zza4FS/sjsBE2xFYUL3O7JCD2B7InDAMaY/x3qwrgsL85w9DhVhyUklle9Q9
	wFM7SbUGKiCsER1l8v3eg6xSOl1qzQCJY0Pt44bqA4aI2s5Gp7kEDf6vtHwcN3afe3UwFbpqLpz
	ONnfwlRZcrXW4WSsDDM1LiNhRZ3xFkNdc7gX4+XqtNgQ8NNufHE+gOGwX4qKzp7CEwS9fjDszzq
	a99qm7v5eE6iCp7OYausJT5ogKvA/mGycHztVnhHU1dogjRMPGCU=
X-Google-Smtp-Source: AGHT+IFk1TVsSCJ8A21b22SubGn1oSGpNm18Ik+70VD20c0toeBsR6n18+JwNbOelGqbb7bRZYXVwA==
X-Received: by 2002:ad4:5c47:0:b0:725:760b:d2ec with SMTP id 6a1803df08f44-725760bd3edmr58332486d6.16.1756949198595;
        Wed, 03 Sep 2025 18:26:38 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:38 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 09/16] staging: rtl8723bs: fix excessive indentation in nested if statement
Date: Thu,  4 Sep 2025 01:25:29 +0000
Message-Id: <20250904012529.215521-10-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust indentation in a nested if-statement to match kernel coding
style and improve readability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d05ff073af2d..a2b1e34765ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
 					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
-						if (ptarget_wlan)
-							ptarget_wlan->fixed = true;
+					    if (ptarget_wlan)
+						ptarget_wlan->fixed = true;
 					}
 				}
 
-- 
2.39.5


