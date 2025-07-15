Return-Path: <linux-kernel+bounces-732386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F7B065FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5877566CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC292C15BD;
	Tue, 15 Jul 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwuamPBd"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552B2BEFEF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604119; cv=none; b=KgSSpfp7x3LJlnF9EdnLHEhKHFKhTAA4SphQEC0T8hMpQKO0IvHkkkAwRoCRhwHDWwp0UUoNfGNu3YwnyGkSYNLaW8CiBOik+eGa7C/AvMsNbBbUrIwAxK8ZdRLSiTOLFKtOg528hhgZXT8etHcI+XD+XGVRWIj4uYZY/H132OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604119; c=relaxed/simple;
	bh=HsVsjqp96CSAE1nxdnYGYSAYKEodowUNLTtLTEqWEts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n25TYvG0MG/3sjFrjtfMVXy05aStyr/3K9pYkHpgEAFKvb86+Od+OcWZdFJJOnYa/1AwD+TzbE1wOXw+pFXOb2MQDjrUxLuljK7Qk/QgHStwiTITTN9Ae6uAiBhZVsYUs46Olap6cqpGEMC0KpE3nN6VzqT3xOHAf9wFSPKZbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwuamPBd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3a604b43bso959926866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604115; x=1753208915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+N6rloDa/so6c0e23OdQ2WgufzjgMtOG65qPmjeMIo=;
        b=kwuamPBdKHpzGrnRs/Y2XnpgnD9rc6EiJs4uNh04wcH+Wn+LqGymnc/i36T8ca9apU
         iRYEmjREnsMDnqNhZfn24ZUPNtdlmYcAEsUhlWqsgx021MkP3HYNegrlhcL+P78P9qGg
         c9Qayt2z9Ucl16o3JDOf75wqH5DDYugAywJL1PSoKZJt6B6JyDuY1A5GHgaW8Gij0hw+
         Qb0lL2nFBR11P5movNqEes5z23a3y6tgmTu3nGG212uuGKUfVFPof4Q0x34FaqfJ57jW
         RyA4CXxtKiUQ/r6Yiw70tKYIK8UrZ2StYTxHeEw+lyEDoRtbfOIhf5rRjTgMKmdbGjRh
         CcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604115; x=1753208915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+N6rloDa/so6c0e23OdQ2WgufzjgMtOG65qPmjeMIo=;
        b=sCgUPNmwde/0SJP+E4RQrG4iWVc8Y6TNlwmg4/d5/y4zGGKFIEitignJlMUcazQwmA
         BKNveeQiAyncMz2PggWnASiD2hwEgdLInF5NnfH/g7mG9AacAn34OG+No3f9zxzD4u6A
         /+m1OuFm4qQTh/XSCY+jqo6FYUGnuLdpmRgpfXhBseNE4H9gIkstvaYTX07BSo2GG9yv
         crLBrzGSm9CfAHJksXJNTHRy89nVemaM4YvCjFds1fpdVOOjQ+kz0pqGibc9ZxF7359Q
         ER0gm/B19vvVRankVYVZtyA1PnpQ1YKl9zea1UFxPT6fKK6Q0G/R/hU2bhaFJxs1s27j
         gtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxQUOfytp8t/PKzqwG/p5sIlAtyx/kCPmUUUSFAYYs1bZIUTJM+Q1sobTXqM1eWEaAlkS+YxyXftioltM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPPD8MggyIbapo0zvSUqexjtP3tgYjol6t9S+zl1+rDu5BzRh
	QLbOIBQg9zq/J6d+GCEQU284sNNtAb4i05txQOjUDlR3XZNz891cd7Xj
X-Gm-Gg: ASbGncs8MYINVNCxp51IuhcQqtuCpvVhtywRknwuMeVMhsEFxChD+EjERf+/qm52HQB
	WNmn3TO2MnshfiygHH+jXCIgr7MEvfJvR/f88WrUIAsW5mhDfXlvw8x8jT0e3volzODpzNvPsLm
	d2Latj567tuqpWM2Io2ouN4FYfLSniq7eJ/k2neSEwr5ljJ6Pnxdf2uTB+WjNuzKL6lFP9myP9z
	F0y+3O9ZcNk4pxdYTpjXToC2DRoe/nUrTeAjCcDnjBERXohHgby9Mp7ol8XJWenE0MfTyObOcKU
	OPmf1U/psERzBnqKL346f85KBa5iPq9KqkiXCdtlLwqfk2Y5out9XcDmnDlbY4hyI1MUYAZy6d3
	/UIZdRFQOhBwX3BPnVFPI46F4/1A2cZpLZA==
X-Google-Smtp-Source: AGHT+IF8E1sthRTUzxGSYoXHUh8aLAnMGYJZQWgj4FEF9Mhm8qlktL0bfOYTpUvIq2JQTzfnPCMYEA==
X-Received: by 2002:a17:907:3c89:b0:adb:2bee:53c9 with SMTP id a640c23a62f3a-ae9c9987eebmr59823466b.3.1752604115154;
        Tue, 15 Jul 2025 11:28:35 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:34 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/11] staging: rtl8723bs: remove function pointer hal_reset_security_engine
Date: Tue, 15 Jul 2025 20:28:12 +0200
Message-ID: <20250715182814.212708-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pointer hal_reset_security_engine is never set. As a
consequence, the function rtw_hal_reset_security_engine does nothing.
Remove both to reduce dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 8 --------
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 29e0610f72f1..dea38bb8424d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -73,8 +73,6 @@ uint rtw_hal_init(struct adapter *padapter)
 		if (padapter->registrypriv.notch_filter == 1)
 			rtw_hal_notch_filter(padapter, 1);
 
-		rtw_hal_reset_security_engine(padapter);
-
 		rtw_sec_restore_wep_key(dvobj->padapters);
 
 		init_hw_mlme_ext(padapter);
@@ -293,12 +291,6 @@ void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
 	hal_notch_filter_8723b(adapter, enable);
 }
 
-void rtw_hal_reset_security_engine(struct adapter *adapter)
-{
-	if (adapter->HalFunc.hal_reset_security_engine)
-		adapter->HalFunc.hal_reset_security_engine(adapter);
-}
-
 bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf)
 {
 	return c2h_evt_valid((struct c2h_evt_hdr_88xx *)buf);
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index ce3c6de8a325..d6fd692aedc8 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -161,7 +161,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*hal_reset_security_engine)(struct adapter *adapter);
 	c2h_id_filter c2h_id_filter_ccx;
 };
 
@@ -253,7 +252,6 @@ void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter);
 s32 rtw_hal_xmit_thread_handler(struct adapter *padapter);
 
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
-void rtw_hal_reset_security_engine(struct adapter *adapter);
 
 bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf);
 s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt);
-- 
2.50.1


