Return-Path: <linux-kernel+bounces-753072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E46B17E57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9305F179ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C75221729;
	Fri,  1 Aug 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz5XI4Eq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA173217666
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037161; cv=none; b=rxzOx9DxdQgaGnPyxCSzd/G3M+vMhDbebQALQwCl6USRNkD5OFkakR8M6KjM+1w3o6PVm8RQgSu3AMzhSItzieKy7+rlxGlJHyT+f8GgodN1BgKH9wKe4bCgzdM8c/UgMt8xFYu+cgooSYxS40ys3L0+cJQnlVaorZT9bXeH5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037161; c=relaxed/simple;
	bh=429Dsz1UXCl+tc4Qfhqn6rxGh5DaOcSImn2Rmb4v8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTagSf+ftWWcm2CD5fyiQsHjzaBK+22jK6ibR93YNoxYtRwxfU0rRa8SROiKEbLYx5Vl+E2f4mtLW60z1idBHfG8d1S/AZgVwPE6kSmiHzqrTojXvkb0EVYGAambECNVnKgKcXsIyOOo6ZJ4JDQUD88QNikxuwqzUgT1jRoRUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz5XI4Eq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1184864a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037158; x=1754641958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvAoNTM7MhnTBXwN9OXdWpK9Cl2xaDI6Blg0pAmiyvk=;
        b=Hz5XI4Eqt9g9p6dAC9qY0KSvxEXa4bz/wABhyUQvTddmzAPbkJufXmaNJqnSy3ur9X
         b/IPVfycmqCZYXgzjGo8zX9DoNMOp3AXwepd9fr3TqmG4D+BGtBUhp4rxYs8V+TocX8z
         5PUup0X8vrrXj7dNPcQmzQacXgqUyCPPqAJ3tO1gQP6mYYCIowe9nti822Q/RVgQ0RJQ
         ZoCV4RawKzqMKyzNIzqafsBGCgTxSx0Hfz5O6ZjqIY9Xs+0AJE4FDprJGeAprgC9FfRS
         tkMwaacpDXzkhQiOCKCWncDQp+5VkoriokP6J/gQD1IKh0WWw9fkaoO+udUmJvk/3Sat
         fyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037158; x=1754641958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvAoNTM7MhnTBXwN9OXdWpK9Cl2xaDI6Blg0pAmiyvk=;
        b=sFMo1yP4J8WIbXXyPOPbcDtuz35AYIvJSH027PD1VMTpomTjNehNTHluurL2pqOipz
         XrQhzNByto26zxg8C7AacmSgBNzC3giRjHa3cspe+YGbvqOt8ZMTrKSpGv7RCsQvY7OZ
         jgWj/dkYe22v5EAHsCCV5XWl3uYsDx45srvAWhlVhktN9BrK5r2DLZ8MNMAJCZ823lRe
         /PAXcovi/k4hUqC34CAboUO1JRETE5msFruZ/qwjWnHEI+0eNih2wWHT7lNaLH0G1r4d
         EQxjM0vgTa28+m6fXhcjoPy4I1X/eLv1bRl2luPN/kpr/4uOBlLlsKo1Bju230B/TUuV
         6DZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwFU0afT8KcH17qrOezpug6KDwfjR6rodci/7zAiwBMWH5XJ1Qg6NcfypWfm4/DtdHA+Ua5ZnVTuhpm0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNp8iTJpGjSmAgeqUrfKiEidDJr8+SxY/9EuqKi+wm2EBSEPV
	GGi2TnC8yLcN4OzTrTCxg1QyLsDoCqsTnYBH4cUyUW8/blcUGcGXxqA7
X-Gm-Gg: ASbGncsSCyFghNzCkLVFRfQjpOf08Qi5cDdlbnZkWsNu8XstHWmD8WwbxYnxeiy68PL
	CNm6fGwzSZchU2tdMiIlH0fy8weAewpCHLLRwl8f+g6qO84ry/3133OqHDSuwg3RbYAMhhEWvUQ
	ui9WXV9FOiZpA3YGEyNQjB7pZ0PTkJ1w0Ne/lSCrB3bcQt9JWRRKaTvIbZv5AxqFQ/g6wKytic0
	qGh7dJWjoT6oGTlYrx9ojvD6xQs9PBpu97JucXeGcpC50nozuRFVTAWFw+X0qD8Bf9mlvgbGMiO
	KbPj9fLrzn0ydRAOfj0otF5+8w+k29QnQxF6SzhQoHIeeP60fwDRucCPB1EB97/MEZ7vqf9ABdv
	eMmVxPOFXu3CTkIZRpQA0GDYK7gK+6KUBx7K2opKRsI3Ufu7uf8QD4nlGUt+xhw==
X-Google-Smtp-Source: AGHT+IG9UtA818tUQyzTBxmyycijLf90jRyxH1yIxm+p2IBSQn5NV1nmQ8MpIGTh4noUUEDvN6MmGQ==
X-Received: by 2002:a05:6402:210a:b0:615:b6b9:d859 with SMTP id 4fb4d7f45d1cf-615b6b9db0dmr5281972a12.3.1754037158132;
        Fri, 01 Aug 2025 01:32:38 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:37 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/8] staging: rtl8723bs: move rtw_init_mlme_timer to core/rtw_mlme.c
Date: Fri,  1 Aug 2025 10:31:26 +0200
Message-ID: <20250801083131.82915-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801083131.82915-1-straube.linux@gmail.com>
References: <20250801083131.82915-1-straube.linux@gmail.com>
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
v1 -> v2: add back accidently removed tabs

 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 30 +++++++++++++++++++
 .../staging/rtl8723bs/include/mlme_osdep.h    |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 30 -------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ebc4bd6ecce9..2e957f00bd75 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -9,6 +9,36 @@
 #include <hal_btcoex.h>
 #include <linux/jiffies.h>
 
+static void _dynamic_check_timer_handler(struct timer_list *t)
+{
+	struct adapter *adapter =
+		timer_container_of(adapter, t, mlmepriv.dynamic_chk_timer);
+
+	rtw_dynamic_check_timer_handler(adapter);
+
+	_set_timer(&adapter->mlmepriv.dynamic_chk_timer, 2000);
+}
+
+static void _rtw_set_scan_deny_timer_hdl(struct timer_list *t)
+{
+	struct adapter *adapter =
+		timer_container_of(adapter, t, mlmepriv.set_scan_deny_timer);
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


