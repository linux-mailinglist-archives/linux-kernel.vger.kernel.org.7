Return-Path: <linux-kernel+bounces-732385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A729BB065FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C54566C54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7A2C159C;
	Tue, 15 Jul 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5KDeoWG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F92BEC31
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604118; cv=none; b=jU7d9JzZ8lXk1T+6HW5hO9fs6ML1KQAx9MCTqb3L6qEjcXRkcETnFA1jWVzbCp3y6qgOvOwCRlG+nnwzA1LRuG831bz6UBX3Nz6/BNBjaZQ7GYvxqWwVGWMkZmNCGxNLKnSe6Ea6DiEKF2nclU242ytEOBrSzyR8Cij3G0U1NxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604118; c=relaxed/simple;
	bh=jZXa93EnkKPsER3v2eQGqokw1yYueS1I2clvseSv5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPCtkbgqHCsHOTjdNguzjzKqOQOoBaWcfgr/0BR1U7jnRveRY7BztjubTykcdBzYUWVL2RSRERV/60igHflTpHu2oxSne4wECZhHnP4B7UcUkbZAJRg9T+WiMaxsEwD0tC44M6IkzD6HGluqBOU5BFWBl1ArPO8U7kCTyJlpPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5KDeoWG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae9be1697easo32031366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604115; x=1753208915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IA/PW/XrIS37fLIlQkAaqHqkiJ709xrEkI5utPy7XI=;
        b=B5KDeoWG5inhZ71RSl02SYYAW1c9AgbUxamm2Kfl1f6FWZXBYRyaHAUY/C8jXu/ngY
         TvOdUKBhtGJSztEb5FNrHMQWEhomP/RVBK8aF2hLI2WpbECsD13dm24JgLUFBrLYN1rX
         NIFZRoKqLWoViYmY6Pvo7bBg8O6j7/V/Fw5bI7kl/xnACu5E3eciLHRgbqFv7/+EHK5Y
         uX3kW7cLO09bUnKoQArCO2xIhryhiT10MAhLsx9L4O3nl+fjEGnTYP1bT80HZPBODTua
         up6RZ5VZXkPG3wXwXt+AzclfwcpZKVorfr25QS9TRxtnNoHmD40IIUrQqQXJWVRzyLBc
         a7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604115; x=1753208915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IA/PW/XrIS37fLIlQkAaqHqkiJ709xrEkI5utPy7XI=;
        b=a19WquHGiWojKUzWI3nNF7nWmiSMYI8LtOeUd4zGR+wqpDF+cPLKv4Vv3wpV5WaXay
         c+p8Z/3q/DRdjHSZlFOAqWug2ZOTNrj6P/JqrY3t3EuH5XGZvUJCMrYZz4n2sq/apFLg
         3pjIkDAqh7nLLVHaywgFAib0M67X8BgJAecrGULJfdY6DstiHOWIp5q9ttbYI7OjSSO1
         YUPBp99f0/XrZCtITR4BA4pDh9xfHJFeEHF+eFPbwGmJeYVbB0lNkmnx77M6quLh0Osf
         3ZLBs4HwC41RT5hRIQx/mSTruHYaH21xCl0O1eLWU3xExIx+dqEaEuJcvKWeq10FHXb+
         iYYA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cuEAg6jOTA3kywrjsxdhuGOSo9wDyFwFQjxIu8vZcJjQXS65/nLNtC9hZmsQ+dhz6FejVosJL8MvtZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/CCFtGTK1vcMMSZl7CF3NZcq5CIUV/zYVHEsyf8gSq5PGjwm
	lTZPZZdYFuj023247uOVxMDx/qw2372BQe5VfTG00nk/oUT24rtJZ6c5
X-Gm-Gg: ASbGncvJ6IlMKf2mdUEsTuaCpykJlbVZB0F2wzJu1R0d8mq+HYAhp1divV4s0Y6lgg+
	mJ3Z45dWJ0rDGwPtoGYpkjhU3ntAlwxm6sOXweGcVZIjhzg4xscaPFiR17HYSjhAyRmKC5vrB0W
	NrMFqDEJWZUIE81HWYotwQBe8cDdeHnAGfwxr2ZFMzp328tolKvSFGxizeSZErdWZXjIj5k6Ttw
	QW0v8Te/wfJsLV6DrRXwELYJys49yHihl5Qq5n1POk6SR0Dfg4eCtt1WwNSr9ZklxPOwtf2Q3AN
	Y1IItlEjq25udFBjefFPsgt8I7n0sn4NVu6pRdakspYXy3C94h0frL3RcERk8sWvZVfIZeDiKdE
	x4CFAPz/VTGW/EaUfFHALSbk=
X-Google-Smtp-Source: AGHT+IH7BOifHjuscVWUuNkqokWkmiGzCh2TaQtOLAGddCuuQZlRz71WpuPCz6g5MZoRlm/6h/u/rQ==
X-Received: by 2002:a17:907:3c92:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-ae9c8f61583mr78675166b.7.1752604114572;
        Tue, 15 Jul 2025 11:28:34 -0700 (PDT)
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
Subject: [PATCH 08/11] staging: rtl8723bs: remove function pointer xmit_thread_handler
Date: Tue, 15 Jul 2025 20:28:11 +0200
Message-ID: <20250715182814.212708-9-straube.linux@gmail.com>
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

Remove function pointer xmit_thread_handler and use
rtl8723bs_xmit_buf_handler directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 4 +---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d9791027a2f5..29e0610f72f1 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -285,9 +285,7 @@ void beacon_timing_control(struct adapter *padapter)
 
 s32 rtw_hal_xmit_thread_handler(struct adapter *padapter)
 {
-	if (padapter->HalFunc.xmit_thread_handler)
-		return padapter->HalFunc.xmit_thread_handler(padapter);
-	return _FAIL;
+	return rtl8723bs_xmit_buf_handler(padapter);
 }
 
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 11d9b9031215..c35b0235d3c1 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1315,8 +1315,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->xmit_thread_handler = &rtl8723bs_xmit_buf_handler;
-
 	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
 }
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 7b634180c6c0..ce3c6de8a325 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -161,7 +161,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
 	c2h_id_filter c2h_id_filter_ccx;
 };
-- 
2.50.1


