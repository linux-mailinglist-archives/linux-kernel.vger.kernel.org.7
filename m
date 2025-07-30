Return-Path: <linux-kernel+bounces-750592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A73B15E70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEC018C4A72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFB29616A;
	Wed, 30 Jul 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvBeXTvi"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44368265CA2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872315; cv=none; b=Lj4lDp8WKmE5apSLUGHTyd8/JW3mont0V2RArkxmNfUkcQ5AKVjZYIWr3ZUy+avmy8Fy1CXJQ68LmNv0GMTWjto5UlnlRd5eve95FA2hwQfT5Q0UoGKcazH2fGUdiHrEahL2Nu2IU71Ifhe3wXao5cEPaJutk6sqw1QIKOhGnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872315; c=relaxed/simple;
	bh=4WM+PaTJkQfWtbrVRkv8jeEKfAmMzADF55xsjqGy7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbJBb0CW1kYabQPiPLJJWlG5792jZKH8sAL3th46l0VM/O/ANe7Ybr+YuTsxepJiuIAvL8pE4NuVtdCGjfD39W6TBdfvL3UJHszVjwFHY5A15rg5OjI0cu2OALEqryNaAEJuP9cflfvrVFz6sQuIdDczZThs5e/FtQZFpKRNVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvBeXTvi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1661146a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872311; x=1754477111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3ApnJqgQPyyaOo/pksd04vUviI4gdkXDx5i9fd+KII=;
        b=SvBeXTviK4Pe4a4ylWzIlfJ0yf1jK6XLpopdPVTG8npderHF6m61us1nyXvOC7Z7uW
         toCLVUwJVBVaw6XHfZZ5j2++jvuCZkFhbLcEg8IYr2IJXsq9k5ivlAxez2nRAJDjnIsH
         rDOgAp4Iyx4Ek0UkaCNwKfMk3tEdjXeOv18d77lzzxAY7/66nH4/GdssQb//X8i740Od
         5++N/9NUCILltyrlMKZamWncipx2/nJsFBGGEQVdTbDz4u5IudMCGFOu6C6gRuue2XyK
         5AoPaw4v/wrkmzbTwlHtRN18yE8Yq/J26oz2LoF0eP1mwjPbuI902Z5xaj/Z/9q3c7Id
         AZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872311; x=1754477111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3ApnJqgQPyyaOo/pksd04vUviI4gdkXDx5i9fd+KII=;
        b=sou8L6Ksvn00jKVywMmN3jezPEj0FOYhwzOKVrEb7yUJax0OKM9ItiE8Nxx4hvtRkk
         DZLNqnOAIWzhE3qJ1xvlUVwSvjDQbd2mzamp/SmKYhgLxnSpEJc52ZHDJCaG5ZhyEnG/
         BYeLm9o1Nn83JgF8O9CZ3ckoLyc/zl8gJgbK6d7vIngnW3znPtLFuJZZY0g73rTQRyrT
         MSF/BLOF/ZdPVWQi114wHAzgKTbe5S15PML6yp4dwuR/0xzw/LVDVCL+FEwJJ3BbwSxK
         vVLLTj9ejhKlBUG52AxmtqbPaNnQBVrkKDLp6Bia5LHveDJjI1uaQGV4x4FIEiVlRJ9+
         E5qw==
X-Forwarded-Encrypted: i=1; AJvYcCWU2cB9w75n9EMPxuDCKeiCkrB5am1Z4/A6x4mzoMMONZMshQJf6/qRKL4JnP/nXo6KsnJ/E1OUcziDab4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKh8nJFW891uAuSLKVQISMQF4lG2jChVEx678thU3jIUtXEy5
	tpnFlJYJYFkWJmgG9kVbDVRkMZ5PbvgW+Y4UbNknPfAQBeNsDodtcu+Z
X-Gm-Gg: ASbGncu6KI5SJCqkcrmnQKlsFT1MuE0knC6nBXvky57OX7kX7Wlj2L3kgc4bmh+gRPq
	OvzQRdwGWaHF8rFcIrf8UNgFYcCMGc5XzcUXoBX7AzpQGybqPoR3Yodqf8lMUF7/xG0KKmvOo9w
	KDkbI4iSq386w/Enitkf7ie6kTYHIYv3Z0MYCWoDhYtgGhHc/qt5KQV5JV5li2iGwx9/JuAtwrV
	5Dxljrxo7fX6Mg/nXuu4XqEUeuHwjjzkV3FngtdKxYwqsp7cKUaU7M3sbrxc4l9Y9JEl3wBPgtu
	dXVrfAsIcOB43ZadKZfvctOihQq6vWAHkfFwHuMCXaqia0AtijjufsCs+bYFN+kMUFE6eY2nqkl
	cfz6Ggg9EWFpEkQEZFQ/lPKfRWUlNZP5giT8nfL0a0McyjhPhhlGWOlmo
X-Google-Smtp-Source: AGHT+IFTVX6XeKgtp2r4MdAeKZJlv6B2mqWPnNL5IkVLc/0B1kD4lBQR1D9Vcurb6gmXImN8GTYAMA==
X-Received: by 2002:a05:6402:2813:b0:615:539b:7acf with SMTP id 4fb4d7f45d1cf-61586ec404cmr3036405a12.2.1753872310269;
        Wed, 30 Jul 2025 03:45:10 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:09 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8723bs: move rtw_init_mlme_timer to core/rtw_mlme.c
Date: Wed, 30 Jul 2025 12:44:56 +0200
Message-ID: <20250730104501.150270-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730104501.150270-1-straube.linux@gmail.com>
References: <20250730104501.150270-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the function rtw_init_mlme_timer from os_dep/mlme_linux.c to
core/rtw_mlme.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 30 +++++++++++++++++++
 .../staging/rtl8723bs/include/mlme_osdep.h    |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 30 -------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ebc4bd6ecce9..bc74c7838a3b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -9,6 +9,36 @@
 #include <hal_btcoex.h>
 #include <linux/jiffies.h>
 
+static void _dynamic_check_timer_handler(struct timer_list *t)
+{
+	struct adapter *adapter =
+	timer_container_of(adapter, t, mlmepriv.dynamic_chk_timer);
+
+	rtw_dynamic_check_timer_handler(adapter);
+
+	_set_timer(&adapter->mlmepriv.dynamic_chk_timer, 2000);
+}
+
+static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
+{
+	struct adapter *adapter =
+	timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
+
+	rtw_clear_scan_deny(adapter);
+}
+
+static void rtw_init_mlme_timer(struct adapter *padapter)
+{
+	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+
+	timer_setup(&pmlmepriv->assoc_timer, _rtw_join_timeout_handler, 0);
+	timer_setup(&pmlmepriv->scan_to_timer, rtw_scan_timeout_handler, 0);
+	timer_setup(&pmlmepriv->dynamic_chk_timer,
+		    _dynamic_check_timer_handler, 0);
+	timer_setup(&pmlmepriv->set_scan_deny_timer,
+		    _rtw_set_scan_deny_timer_hdl, 0);
+}
+
 int	rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index c84c84c68286..4bb7a01caf4a 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -8,7 +8,6 @@
 #define __MLME_OSDEP_H_
 
 
-extern void rtw_init_mlme_timer(struct adapter *padapter);
 extern void rtw_os_indicate_disconnect(struct adapter *adapter);
 extern void rtw_os_indicate_connect(struct adapter *adapter);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index d22d6cf3cb11..5cb27ddab769 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -6,36 +6,6 @@
  ******************************************************************************/
 #include <drv_types.h>
 
-static void _dynamic_check_timer_handler(struct timer_list *t)
-{
-	struct adapter *adapter =
-		timer_container_of(adapter, t, mlmepriv.dynamic_chk_timer);
-
-	rtw_dynamic_check_timer_handler(adapter);
-
-	_set_timer(&adapter->mlmepriv.dynamic_chk_timer, 2000);
-}
-
-static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
-{
-	struct adapter *adapter =
-		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
-
-	rtw_clear_scan_deny(adapter);
-}
-
-void rtw_init_mlme_timer(struct adapter *padapter)
-{
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	timer_setup(&pmlmepriv->assoc_timer, _rtw_join_timeout_handler, 0);
-	timer_setup(&pmlmepriv->scan_to_timer, rtw_scan_timeout_handler, 0);
-	timer_setup(&pmlmepriv->dynamic_chk_timer,
-		    _dynamic_check_timer_handler, 0);
-	timer_setup(&pmlmepriv->set_scan_deny_timer,
-		    _rtw_set_scan_deny_timer_hdl, 0);
-}
-
 void rtw_os_indicate_connect(struct adapter *adapter)
 {
 	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-- 
2.50.1


