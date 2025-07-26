Return-Path: <linux-kernel+bounces-746624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617EB12901
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B4177829
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9BC221578;
	Sat, 26 Jul 2025 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6vcNaU3"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7561220F2F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504453; cv=none; b=mCTLRfbYMau45bgEhnEwxoWSSVFM3mCaArgKksKQhBlrE4LzJtevi1jOZZcNaOYURfaaNJLkeOKzp9VccslF1o++M745BqgTVS6d33g10qfGKpjuuJgSdumZR9dj50HVLsYHvKErtsl2tV30hQNdZYiHcB6kLsegFqxgKK/llH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504453; c=relaxed/simple;
	bh=A2/8GWYF+QSMZie/dthNKmgZayVxmihhCGf1guv1yBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OelKn7eZuy7bZldw0BO/8h2vUATmvsNLlsq0LUzvYUZT0sOHxJ1rqMW+v2lbGaizqUkt+tPR6z8Av1ixUTkkBBdetRBQobxna3VMhNNF4AMQ4y8V8Ty1gJcaBGHuKfuz2APbl7/bYl/4n3YauLbrCRxeIhoAaALB9QB6t5Z8qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6vcNaU3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e32cf22fdfso258981885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504451; x=1754109251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=godtxK4YgpknghXRHE2/UoeuQcLZlCjOGnevqfxGStw=;
        b=Q6vcNaU3Kuu8jSYZhQVp1QtXsCq9+Xs0Y/gZT3yTaC/a1qgvZP1nhaOB7bCY4jXmUl
         CsZDPGFwmP0qZBQli+b0kWKCFOs9B6VEz84f93TANFRahHx5Usc7diqxQ8r6/EgtfBeL
         c0uNKKNnV/Vk1ur+Cmuvuy6iyNZMB/8e9U5sv40D9vHegq08rnoodCGGxPl9ofcPZBe4
         kWZQK7KFMP9/f6RSUahc/PYXnTvFrx8MorvlzeeGpMTS3fwI+5pt3N194HcH4Pyc0scS
         li3wEaBJHzA0Q1MUV9aLEd0xB9SwZvs5AjtbN7tH1TSuHC44mF2mZ7rOgV7RInKjcteF
         ePDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504451; x=1754109251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=godtxK4YgpknghXRHE2/UoeuQcLZlCjOGnevqfxGStw=;
        b=Q7zYd8huDvu88kH3CT0CYBCbAEa4Yw05fHzNw66rrbEJdPPtHYAqWTI8xs7vexpKuT
         maJTBtjdFiJ9JrilnmWEfkTR7IcW2VSqpBmR34K7FjGW0PeHMGSahRyodcepgkMh1SXI
         WAHm+Idw0SSWxVptnhhYGiNn3+ZF05vSeGf6Obtpo98Ei0OQb3OCN1J7KgDwRm7paoNM
         A8Ymgxel5mfgT8+QgWc6ttEIah4+3SXZt7j/mlGpg6iSXUkcOkgzMloblykIfzljO2wo
         mCgIZSa70VBqLrMbjjKhj/OHrm7hbgC4YcYeIAvnQ/u7+6r/9OGZ2oKOZ8bTE+gDJMHG
         CCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8fefg6CbP2ENqiDy2NV/M5PKFsEblmOCOHVBAZRUENZi//q3LnaO8B/tFK8Cl2wT+rJD0Wtfk5sHj4LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkn/jG2xcPpmTU16QX0v4DXsPQAVS40+k5jpokpNfK+VV+umn
	OsA5jqXdCkTEKomgTe6vOe+TWkNeehA2s96cYaQYKO4htmhOQtCXHIXe
X-Gm-Gg: ASbGncvR5ozG7UeYip+hG8JX9es/BqZUicuEHbziLudg6q/i5gvUIGUnb+Qr1Qt4t8I
	N3hjp3vIQNZMr8W/TP+x3emdI7JNq2VxO6g+gOMV6OeGEHT9NmLdNk+EJV/PJfEJ+97ZbNh6Jot
	gUSP1xOR7P10K0juk3dd+F08jqO1kgXToeXkTvWvTZFHXsgZ2HzfSVTaWc+Hv9wuh5UGylNiExN
	WI1z1vAnqUuol7h3a5OqTzYhQ/o1VJ889LwSqEEkMwzYlRhFO4JEGvvEpubKLKuN1peWwaX3lp+
	F3PLEg1mOLwmaxDK36b6QvA5Cu6OCo0C21nmY1UvGGZg3FxP2YE3gmTNBT7kRTREmbpaIL1Mttx
	+CNAtVs0mCYhpIR3ch1B2Csa3/fycnnlsxx1sL3QhlIAEoQ3B4To=
X-Google-Smtp-Source: AGHT+IFlRrWov5o//lGeMP1IXBjemW48lt8HRdPARmz3fKpiukwPkFA3HSPqzwF9A2FesESVi2k0QA==
X-Received: by 2002:a05:620a:710a:b0:7e6:28a9:daf5 with SMTP id af79cd13be357-7e63be3b659mr536419585a.3.1753504450787;
        Fri, 25 Jul 2025 21:34:10 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:10 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 18/20] staging: rtl8723bs: fix line ending with '('
Date: Sat, 26 Jul 2025 04:32:16 +0000
Message-Id: <20250726043218.386738-19-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a line ending with an opening parenthesis '(' by adjusting
formatting to comply with kernel coding style. No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index acacc2806dc9..ecb7b3823010 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1071,8 +1071,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter,
 	 * we use ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
 	 */
 	padapter->recvpriv.rssi =
-	translate_percentage_to_dbm(
-		ptarget_wlan->network.phy_info.signal_strength);
+	translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-- 
2.39.5


