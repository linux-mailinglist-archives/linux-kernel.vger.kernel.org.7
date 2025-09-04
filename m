Return-Path: <linux-kernel+bounces-799728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACDEB42F90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E747BA83B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEBE226520;
	Thu,  4 Sep 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHmT1nfG"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560191F3B89
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952116; cv=none; b=JTgUx6xNay64Ja2l16bLrR4ZgQQYJ1Mr85PGC2uGF98zKZ/Cox8FwFHXWHu9nPPdaNQJS6PXhDsb77QKyIctEQqH9tApP4d3eKyXQECRLJ8/6EtWC9FyoJ9lTClB/jgghJa0VAXnTjX4ZSiDy8C9AaUvzECuvYmPTa9ywXUzMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952116; c=relaxed/simple;
	bh=ZIDFMuE4M5pN3hNXaXhKSfNWI42Rb3epwAfW5TFj8CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvcuX1tCW8X0BDdpXQ8TtSySZi6DqAP0a0dYY4m8RFZXlmP1JJc9ElFH+mf+bozjkEuO7LxIxcIu8GE0HvyPHmddO/BhqUpY/GwAsrusQXuoe2+EdlV8m0No/bPWH/pXH/9F61ikbyaHWjv8Hq5r0rtayP2+cze2RnMzWEhr2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHmT1nfG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b32bbefa14so7133221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952113; x=1757556913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=AHmT1nfGBkhqlO4++cYOqVx2+RqUJJ0NtzQDKwimUy0JfyguQULYsDzjaxcs6PH5VH
         Bd1LIxPxtX7fpo+mYCfprN45kL2amAkjyaCjy5YoI8qi7LrhLBfrRFKdmHYTeTT+M36i
         Y8nJ+E+J++4vvGRHED04m5uXHKUWLZXW3AQ6mWsELf5bYH+Ecy8jQkkERGHda1vjqb5U
         YT6GBG5mnSOdfspjkZy86YoxmXNAB+/WoII9Y96wtuiEPnOu1laG8aeE2ccsTYo+Dz9N
         kw/2dqs+ksNT0WDXzrdswqjtPHESGbI3kkZdtlFhnIfZd5N+YLNh0yD8f22j6eIbRBO6
         8law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952113; x=1757556913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=PAwa3kcjbKY3lzXJHL8TnCfDEUALjW9PiQmnYi3v1SmLAeFl9puCqqt6frLCQey65a
         zsmPqhP4KT6OrcEF+Dv3LcjT8J3ZonML30KiNXXRbGBIFzBvUldglp6Ke/iiP1hdcYjL
         aal0ftWRKT9/MbGIlSX0SNdbg+1LALA73V2hCQ+IAZKiOvAFCph9pbvQY8qO1B/VlSWq
         Cp7tHaV/uOM0AWVObEJbppfG7zyzrrjmXLn+FZOKzDNEt2EsXf/nA7MJe6E+eyxE3suQ
         oaEKhdV3Mkw1amJYRJ2Vcp88sPpP6UI5cPGp7/oL6GkgO1YCuvNcboKbhILI0cvAve73
         QxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjeg62szX52TX2QlZJ/jc4qWhdWd7skRO09WhraxYIqymMltvd9fv44df633+ZFPc7W2mv37Jw3i+viaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwg8BVT0sIw29/YXFnGjlTBdtr9CMKq73qITDTeuBSMWKWPt64
	IRZoMt5ut/GRCCPEMcuQzy7xriNimsPGmHjD5GSQsJHphMmMK6ukd9R/pqzGHQ==
X-Gm-Gg: ASbGncuSaNStSdbhu9yfrGqVBBRIQL9NNXXmeW6GNR1Imh+VmnQZFw17/u0Gnc0BV16
	wXYjUL0IP+qbkS70js1PgxGFLQQFC8q58ecZqijBheSDi85oGlbRYxyDZxkXn2CSefX8VrrZhfZ
	ro2AU4ownDTBHvs1NEHGWm/BHwleodOETBXFRVtc1vI1t2UwN14zjbU+hk/ZhnpGB7soeS8NR74
	6njKuyA/eNEl4YBqVPLDGCXQ4li1oiteVOPwnIvJYDz1daQfSUkE6ZHzI6+b/7k3Ze2ZPgM5f5q
	qQxzUuVxFMhxlIVjNtfy04xYgDlNnkQIj+NBpy4ltFY9Wu/Xt/9IwVMvMTKFkAQq/Uq72JbzSRg
	OGM4XeLk30nb+MKOLa7GfUVwkDAb/jA7KpHVHgnNrxFu87KP3kgE=
X-Google-Smtp-Source: AGHT+IH1OzsHKnsRTKNcbM75tFjAQ6CqdQzyruBeX2Ebd/9VaKjatOzLZIdX1H7CZm9Qbdqt1kmUFA==
X-Received: by 2002:a05:6214:dc2:b0:722:30ad:9382 with SMTP id 6a1803df08f44-72230adb888mr71558806d6.5.1756952112802;
        Wed, 03 Sep 2025 19:15:12 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:12 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 08/16] staging: rtl8723bs: remove space before semicolon
Date: Thu,  4 Sep 2025 02:14:40 +0000
Message-Id: <20250904021448.216461-9-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary space before semicolon

Drop the extra space before a semicolon to comply with kernel
coding style. This change affects a single line.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ab626c88e7dd..d05ff073af2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2236,7 +2236,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
 	/*  adhoc no 802.1x */
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0);
 
 	pdev_network->rssi = 0;
 
-- 
2.39.5


