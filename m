Return-Path: <linux-kernel+bounces-844012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF4BC0D41
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 206B24EDBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19C2D7806;
	Tue,  7 Oct 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSq6OYIm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE32D73AE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828412; cv=none; b=q40G3GLr4H/kftU8AocjBsTdN5IpC6h9dnnoTa0AQrHKDFTmdZwJdVDMF4HJ32ZRXH9Eiw5kVDwjy0Rl+usNv/ZwlhpFiqAx+zKNIsElyrZsMBc1dKEo4jQCgZ0MChVQdnLStZ6hwAn2rGMegTp3yWRFFMFq97bsJsHhrBrPcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828412; c=relaxed/simple;
	bh=4jY+le6EasXP1TQgY1JwK4qzgMhVV14ctQrElh0wVbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwFS8UZ33mfMD6ilhk2yIMWGMPVlW5VrKKifoQueRtswiAyIkMBQtC0aFowuYVwU6ScGzDVv9t6nmVUSWbWEej46pPO4vOV111+Rov1tuUFgJivh5FAD3iUz/PzjU+29yCAzee7qTzhgijIMC/XAkhD1Hue/t0FGO4uQsJOjqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSq6OYIm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7841da939deso5500437b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828410; x=1760433210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he0x+ArGIfe9sei2xIwGpd89TEm+/O7WdTY5n8gdRlE=;
        b=WSq6OYImgXSil9EIUQPFyTMVzlNG3W+1vF4GeItIzM/Q2q/XR6PyvHWSw9FTogdRGC
         ETdkeGGwTqRsJ92sk4ex/OXNskUMr+NdwRy6572euod7TDJOuZuYjKWlUFnBwZtwiMS9
         lQSh1w5KgBmu0Ykxgu3A3YF3TBk+k72scq1NfPj5Ztshf/PoDYNudJOeR0V0IEtkRy7H
         LOoMuTVaZMXmLZVzTqLk0KcyYR1gVktMDEX+nsphrPWtIjavKzPaPdgSLrQBMKlSLCyX
         jtWMCxuNSjJhAHRyGvoObeI4eh/5rDYVhk3Tza/QUrKT0s66O0YAK2dbts6B6G9Q9Yzq
         346Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828410; x=1760433210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he0x+ArGIfe9sei2xIwGpd89TEm+/O7WdTY5n8gdRlE=;
        b=aqvB+THiR9g4wNxl4K+1mpPeV7/ded8mJ1jAdhQ+I5hZzqG47GDrUH6zu4lH3khEJv
         ZHyr9TBr6wiIZlFC4l/HGeoPDnrxButuyg8tFeQQWCHnsSQiA8Qxum39RIKvO4Yy8Sv2
         krsPuBdG8pkAD3PlqeT8e8LbMocW/BBwUrl7c9/I4GhHt2uT6j62hzKKNkmSAKYEziv8
         9EmYlhm3GamfMcDgiro5OjwSQmdDvsogeoyWu5lCfVtyeEL3w1QiR5pTyksan51Ywyt+
         JM/hh2t3/NhdlMP9TrubhmHwLRCHl2R9wktwJF9AJckd0t8Pvk56fbgqdlZGcLQV4CJJ
         elvA==
X-Forwarded-Encrypted: i=1; AJvYcCWdF8NAWrlk7NrmfTWSGN2sB7XjqM/3u5e3OzAZc79XyOD/cf17M9iYOxUJQgC/uWfCyvJ4NyrJSZKtuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mjhX9BEqypu7vEH2jYNZdmXmbU67NJKwIKZDg1NTjTZ3OJWp
	Gbxol/9Eim6lyQVMmw+23bj9oOioySCfjiG7Wx+QiCdi1vjwSSTa85pvyA1RKOR0QFA=
X-Gm-Gg: ASbGncvZeX9boTAAZ94ARyzM4l33JRyFajmgV/A2lw/C4HBiebGvzlgUVvJtpve1sZ5
	VDQsbljg2dro3NvrHAkVJWmk0P3lePD9ktb+tsVS1MhedFpX5ZsdmGol0sG4CSFbB4sTjdRf7O2
	fAYpds/Kh7S5ZqMqpFHPREWJkvd8NAb3Xm3nBK6Yrkjk8hPxgiZiIBB0UtPFU2UaQFpH8TpOTr3
	vhJAB95LC71gOG/tVC7OdUIwEKVej/gr4lAypZY9yHCbCbCLgbrwv/Jqn3H3YaRdNGzl17j2/fA
	3feNz+jVv3GNWiahQo6qPcuuGAp+envEfbRK6CZw1Ech2z9hX8KqjPBujw1y+sWYk0TyZmQtfsm
	lEhwuAdhKDZgpZKC1fJFAL8Mp9Za01TReuaDjcLADEq9pAvi0Hk28daIE3feY
X-Google-Smtp-Source: AGHT+IFIq2Xtg33AaO+XWR66x0UiKmUHmFMF8ff1XYtXgQsBRzi6FeDK5PoORmJG3qQgIC7vJngOzA==
X-Received: by 2002:a05:6a00:8d3:b0:781:1e08:4459 with SMTP id d2e1a72fcca58-78c98cad8e6mr21721027b3a.18.1759828410250;
        Tue, 07 Oct 2025 02:13:30 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm14941784b3a.13.2025.10.07.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:13:30 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH v3 2/6] staging: rtl8723bs: add missing blank line in rtw_ap.c
Date: Tue,  7 Oct 2025 05:12:59 -0400
Message-ID: <20251007091303.491115-2-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007091303.491115-1-trohan2000@gmail.com>
References: <20251007091303.491115-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a missing blank line after a function to improve readability
and follow the Linux kernel coding style guidelines.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
v3: blank line added as a new patch
v2: previously addition and removal of blank lines in same patch
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 373718cbd6b9..4bfae77a5fa4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1991,6 +1991,7 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
 	}
 }
+
 /* restore hw setting from sw data structures */
 void rtw_ap_restore_network(struct adapter *padapter)
 {
-- 
2.50.1


