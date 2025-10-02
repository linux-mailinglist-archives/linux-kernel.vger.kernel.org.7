Return-Path: <linux-kernel+bounces-840557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B9BB4AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD3E188ABF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA327B35F;
	Thu,  2 Oct 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqyu0Xoh"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C7270542
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425851; cv=none; b=ZPvNQAnNfaDHM/hbK82f2mzjpRJ8li1i8vDZFIN2kqfC088wM8YQx9W+gW5cnaN5ahEy3QQk3mqeg7z48HNVPtS4yFlEBsJsd5BL5O8pwCfs6pDxZUI9qIiPuk3T9Iz+TKX1hGbQ3EH4paYVkTFt8bdZTyltAgwF0TgHQ+c98Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425851; c=relaxed/simple;
	bh=QcdnnanrGSpwQX4VYSwIT+JnCxCACo/jJV3o7tYIyeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLZ5li+vrNm7AlA+/H77NMg10uIW7yDhKfA/BOY+QSI6JXIAI5NzXUdo6BhRD/JC1mJxLMXT1aQZh1rFjN7m60RjfurpgOOaJMvgW0PbmARiSHl9/adJ9axdhSZRr+5dBlBQKiw+Yy8MpmMaMcqErJp8sTtlodXvaKf0G/CSE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqyu0Xoh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4de8bd25183so19158531cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425848; x=1760030648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+azu5dgYYVnMo+ufve9uRrNqQVbZy8zuGrcAJ/1+bmE=;
        b=Vqyu0XohvCTDNcOS69AJL5/+ladMzhQwsba1/+XfFscWAkP2KVqJGWQWONVgVsud8V
         VPD3Krm/H8TFcqi+8MjW6YGHq618JjXHP56Zyz1D1bGnQSnW7UMxZVJNzZ3FPNqHhjMI
         yOjhkelPWeUJC+PR4cTeXL1ALEHpGXrIB3wgMppVtugrIuLOkWbCF0E8/SNfYS8js3Dl
         QSR12whRUBimf6GYnyaE/JbFqnd4Z/n6zm3OJCXUkB2wmeadgtY1Ro9LDHPmLNyVfVDU
         3wW7qSBnf8ywGpsdD4sLfQmNxBdrWFTdJdxNyhDBH4R9lkGYRqiOoqeK5FWl8WsUI1rm
         BHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425848; x=1760030648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+azu5dgYYVnMo+ufve9uRrNqQVbZy8zuGrcAJ/1+bmE=;
        b=TRqt0t/6kbb+uU6RmWwGCM50RfmcWCRMm0gue5zhQ1hOicSNJ6Jr/GZMP2msjyk1Zv
         5NOeVHkGa6IaVXtZTya6axmFt3CPQ19AUdOZEVOiCspc1dmtPYcz7ukNhRC8OfHwsQpc
         Ocy5BK7wCynWYcw7O72OK0DF9wemammmnumg6p0pxe+4zZd+cvrhbfk0/Vr7Lm1JjzHU
         gGdJOk/Z72nhtMGowKW5m/7F9Ssrg9rm+ofyJ/aclnm7/Ea7BIrcHFQSgXx0lnqvtbh8
         g0ieFi5rvWuYEyZnC+UmDS+cn8dNXydGBjyV0vuEjYrfYxl3jMSIS0K7aW4BUt9RvNkv
         LVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP9VWlouAi517I5t3sxSDr4saV0Pan3fu0ndgbd9tGPasRgIiw2G0mHIVLyu1vk/brBpdZc5hi1MJQjYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZG/gw4LE8+XWHBaPN4qqA8ezX42Va2Px0AzbJ4dkt/f7TVBz
	dRbhaX74xxiIhqMYsCoe5AOEfUywhV4xrW0Ag1ONgFGac48W+CaKO8H8k/gTPg==
X-Gm-Gg: ASbGncumW0JlN+9bf0kpmvYBGvTPy8w2oPun3ZEiXdHTXCSBqYAg7B1ZyXv3nVL1X41
	cqdWiScficdBvikbfrHG4EkGfkWTdGS1/Hw7di9g3dHtZPTrCqM4FiMO5wQ5An6p4rIeurcxsoE
	EIDnpYW3nrkdxzLD3Ihc8sdRhV3rKB+7XMiSkLUqy6cerzlDNIiFwohXrOdQMWgbb9x6hlfVl9K
	bxXRf9NiCgctTq3G0GEm8/BfEJo6+CMdrlFStTP1OcxOGfRX4desPADI33oYzKi6g3CdVXDkrkw
	e8Ui9PJiftdRQ4fTWsW5ODLImZ2aqmJwvkEqhg8oDUQdGcZUUTGIXHP0g8ErAIHgXEYtldr6cNf
	99uceNm14z/dwAKr5QpcWhDvnQm6W+d05Mg+/kpXb4Xh9KBM8m3Mb72EuK06XcWSNGboS7DZ2Rx
	QWG3F/EZDUGg==
X-Google-Smtp-Source: AGHT+IExJ3Y6vsO4n4lk5WP0EcJLY+A002SLr5TqSrJhm/5JkLkja+DaB3kdCtON/5vWHf9DwT0sbQ==
X-Received: by 2002:a05:622a:1a82:b0:4e2:f1b3:345c with SMTP id d75a77b69052e-4e576ac1313mr1169361cf.50.1759425848090;
        Thu, 02 Oct 2025 10:24:08 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:07 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 11/16] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Thu,  2 Oct 2025 17:22:59 +0000
Message-Id: <20251002172304.1083601-12-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant parentheses from a function in an if-condition.

These parentheses are not required and violate the kernel coding style.
Dropping them simplifies the expression without changing its logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 14015541557d..74dfbc7a0c26 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -730,7 +730,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


