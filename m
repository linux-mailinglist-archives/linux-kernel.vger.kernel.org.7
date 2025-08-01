Return-Path: <linux-kernel+bounces-753074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C9B17E59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8291717F89E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9D223322;
	Fri,  1 Aug 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhdBl5tt"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEC1FA859
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037163; cv=none; b=tUGaa0TGvK6wHETlBMza4pepbxUwNXIvD/EsTzD4TlFpNSpw2gfvLshXzOdcp3/ju1TR2bh5hqZz9VYH3QaX8zEDwSJG+ESdlp14ylPe23H/8A8WUtg6rIseZhNIfnR7XHLjm21aqOjF6Oc5C7KFk+aqoh4cQ4zKIsfr08H0RBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037163; c=relaxed/simple;
	bh=/+vcYsI4ZQyJ++t1I38Ppuj4VT8P+XooHoXgtmskaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETWImjyEeAK4Q0DjPDCxMfXU3CpOwaNu8bOgzSvxhTL+hDgcRZFeGXr2WsE6SKARLjdXtCCnOszJsV54qdWgYp/KXi50bsf/IuE7bGNupMrz/hAya3nEFZIeJTgK4IUSs4c8cDQe5UzhEtSl3hVSKarYHhD6PddGiXWbvx7sjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhdBl5tt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so3914850a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037157; x=1754641957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6jMC12tEugVk5aruwhIYXcetQLysBmEwE741CRW/oY=;
        b=YhdBl5tthZHJ8Yntpdn51aUJg297VzNvKVitU2kL7TAM28tFggwX27wpfz/OGnCeO0
         U715ayMdWy52+RooGmRDKVnjUAKyLuByvEzOCZtzwBLGd3q3xwQCgeFqrOd3CSRaTO9g
         ihjUIeejaywSI1zdB5LFuZCca1Q5yQo8g9x9o3Tvrm3AtIOG51ADAVrckl9K1pcb1iOz
         xFGvuG2VouwJ7gln3BlsBbRy+zPpLG0K0s+hjALQsy9fjBWLrDUXJ4EkPjw8wceVtPAp
         nArx5COsjHclXgy16EoNG3O8mRBrfCzMHv+Kd41IF2dZKCbgNfI4E2UeOVxIwas2ivhi
         U76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037157; x=1754641957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6jMC12tEugVk5aruwhIYXcetQLysBmEwE741CRW/oY=;
        b=AhwpCOkFvOxhqyxHxlTtKddBIG+vm7fmBiUMZrPCKgSeiuK27obM5PYE+qUn4XvzPi
         VaO1hCPEy1AHrZBPn7uPwyG5EmOImYyq1el1fgF/tC+5KsAWf5KjMFXlBAIY3BAnCrU2
         BR2hx/HSbeA0edsmTFIUElCXmmFWUHbmTcKmv+xKR9cgZiWh/Z0m0//BNBX+pqJIS37S
         czKIvnBeQtGwYIhyRKTUSch8NpRyHpwlS+mtswxZHHscEhWPKp8Hktg8iItnu6FxWVWX
         6w5f1V2FTbbJsZJkLlJ0tYrqHfNDwTHnFkQHN1oDTiW+3W5wEIx7rqo9k09fVQRvaxKF
         0qow==
X-Forwarded-Encrypted: i=1; AJvYcCUKqsE1H6ww7+1Qo5gwNvAlyuJB0hcBxoAt1Ol9VSALxY7cU1kuQUGbRgfU6Hgb/b7pLNGuhApWImo3FD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LkeMVSNixHI6ktozEkOj/QYaZhAXdnlscjhBqAc37dfxxZun
	VqtvbIh0oEv/tF6n2AXFL/3GR8p+eCYoJA1cgAYzShi021OSlJaV+ogPVDjmCg==
X-Gm-Gg: ASbGnctWHOoR0RpyOvmFQRMLwR9dSns8Z0B6m5WxEYKwkXvoZxjIIC1NpNiF/Q4j1zP
	CV4qfME1N0LGnSdY4v6xppnIoDz5aOb2DTv8rWJhOBAhxWn0kFR03vKdy1zdNd/UxISHszwNTQ8
	aMkbxkJqOOAKcbIY7ox5ubeC3ycsP2Wcmavv9m9HZ///yesipeXZvXUGl5XENgT/8p7sLHpXK+I
	MHTc4RcDVZ8QEGV0T7S0bZ+Ppirdpm6n2ir3QC3KcPNeZ0OrAdJepF4W6i3NbVWNiBoPQQTDiIN
	/zOX7oDwKmvJtcGalLKjtb1vV5CDMyZqkHskpQYXq5ZY2OUBXeimvFOMLLWnLr3MGpmZAH0bX/S
	yxrP9la70JdtWilwMW7mfGCYSpL/vZACRn/AW1RHyGYD7n7eSv5U=
X-Google-Smtp-Source: AGHT+IHciq99BbuZpWhzmGyVurHmceDhuGv0VyhSlty1GL9uJXllpooZ1oSHCxPfXsLTyOQc240QsA==
X-Received: by 2002:a05:6402:2809:b0:615:4c85:47a0 with SMTP id 4fb4d7f45d1cf-615ae19999dmr5006820a12.7.1754037156991;
        Fri, 01 Aug 2025 01:32:36 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:36 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/8] staging: rtl8723bs: move init_mlme_ext_timer to core/rtw_mlme_ext.c
Date: Fri,  1 Aug 2025 10:31:25 +0200
Message-ID: <20250801083131.82915-3-straube.linux@gmail.com>
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

Move the function init_mlme_ext_timer from os_dep/mlme_linux.c to
core/rtw_mlme_ext.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 +++++++++
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c    | 8 --------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bc980d21d50e..0e685c0f2f2f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -374,6 +374,15 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	return chanset_size;
 }
 
+static void init_mlme_ext_timer(struct adapter *padapter)
+{
+	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+
+	timer_setup(&pmlmeext->survey_timer, survey_timer_hdl, 0);
+	timer_setup(&pmlmeext->link_timer, link_timer_hdl, 0);
+	timer_setup(&pmlmeext->sa_query_timer, sa_query_timer_hdl, 0);
+}
+
 void init_mlme_ext_priv(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 2080408743ef..58e2d8e159d6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -426,7 +426,6 @@ void init_mlme_default_rate_set(struct adapter *padapter);
 void init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext);
-extern void init_mlme_ext_timer(struct adapter *padapter);
 extern void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 09bf363efa8b..d22d6cf3cb11 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -164,11 +164,3 @@ void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
 	timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
 }
 
-void init_mlme_ext_timer(struct adapter *padapter)
-{
-	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-
-	timer_setup(&pmlmeext->survey_timer, survey_timer_hdl, 0);
-	timer_setup(&pmlmeext->link_timer, link_timer_hdl, 0);
-	timer_setup(&pmlmeext->sa_query_timer, sa_query_timer_hdl, 0);
-}
-- 
2.50.1


