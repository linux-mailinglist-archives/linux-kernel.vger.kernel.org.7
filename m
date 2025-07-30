Return-Path: <linux-kernel+bounces-750593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A715B15E71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BC65A454D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466C298996;
	Wed, 30 Jul 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm62gee4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224B2951C8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872316; cv=none; b=psJtAZ76JmhkuoBDjZ4FknYq9WVWyLb/PJ7qY7obfokLQl2eBp0GrId1Fx8F8gXl6876pGIsCJsTgMeWyvxPx9S2Uf+Ub1aU70DRnXBUOhoaBXrhoKg+ulo/WITlHJKx/LtVOyJ/TjlwLnH7ZHx7zHUpHmQNQwMI9wqoFMGrdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872316; c=relaxed/simple;
	bh=1k5ncuPLYLjmJSNvSn6S3vq7O1Ze6ESSHk8F+Z6n0nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rik/mtlKI+/xS6FpzFZVfUzDvNGm3KGbnFblEJjZtZHqUrpBV75qEDrew6GRADS67xJpjjL3cIpADQLS3GiG1h8klUVfP669kJlqZPKGRdvguxa3VBjv5zNmcZSTdWBvUR9BlhYesq4e/wMvKxY8VUi8GrrJMNeD8IXC4o5Lxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm62gee4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso1400296a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872313; x=1754477113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnAv1OGjpNdst6+omDSot3tyUGyzMvpWfnjJwpDwNOo=;
        b=Tm62gee4nHngNaP0oJdaeZnCTqYjeEadUsUqPnXLTkgiealqF2c9vcQRWlsV7d/BVz
         rYvcHs4rW6FJkY1lFodFxyUis3ZU1a7W5pqeottXwjCLuyPu2r6fkHY5xw8dDxgPKh+N
         tjKfE7U8wTn4998uwsrCXHQ2bz1hUP1g4IsTcXTJGS4gIrzVVlmCyvgYOG35/UQ1ve8O
         ZJnWLQH+8WJ5IUhF/XmDE7ytpwhVPkDZLZ9FQgOf+trUZ+W6OfPU5cKsCNAtPsd8Q+G1
         2wBBhZNFa3HS+aaBBzsrY7iElFCP0SD8QmYPgv3RWCoAa/S2LZ9OIWgpS8nnG1e4NgpQ
         Hzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872313; x=1754477113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnAv1OGjpNdst6+omDSot3tyUGyzMvpWfnjJwpDwNOo=;
        b=lKZpiNzKe3OFi/F1FADFhdWA5MV1Rw88YJ9EOj6bTUmyhe2Odxi0gtgHe0o0VmH32g
         WWE1fiZbh4iT7FHOVoiS/Wp9k8ov+L2KZ1HqBeaQOkaZXsOQHf8/5aLUqhrTtCK+wxQb
         69ZnKX6kVkilJI6whwSxRIg6/lM4eI1dDT/a/Nxrm8g4jPr1IwsdAyLFxkVopKRmtkgZ
         hEARmZ1wZBF5FvAs1CuEfZqrdih0zvZZ/FVSe9xjptzMQ12poZMOoJ/3au5HoXHshcHI
         FXMpc5jbp9SU/KcZU0mw+vHhvvr17XCPLB5KMEQPC4JVWKokv7LOSSLbl0f3YQ68S4Eg
         6lzw==
X-Forwarded-Encrypted: i=1; AJvYcCV1nVfXTzLeNDqAJ4i+WbcphThyp9yp9gKaP/A6lIomr2a5NmkGn0lQLcp7lWgvRt6Cb4mK8okrXeJVZ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGidZCj1XeRjMdDzNM5EjvDcXfhT2k/BqO/xrHd5zASeaNq5U9
	rvURSG9J5DHaXZSynLJIWMuuY1FsvXCpWpubVWoTp6JjrrY5TOTeVE2M
X-Gm-Gg: ASbGnctWJZ9cvVEjiUjL1liS6GFNg5V7FZkYDGLOkfiQaTUpwf4TMGQhbwJnr59lI1k
	r3ufZwdwRs+S4qrYwJmaFxRBFKN51p6FVaybWvMzgbSAKv/bm/aDjVxoCisZljV97pboTaQND3c
	nufWBQo4xF6/PDkSYeBYBVWXvFRK15KH20iInSd57ECTk8Mh8nlKJY5iztuTgSyB2ny/RX60AD/
	joR3Zi/5hTnWG3ROOWuXcEAzHpRioCIShIyV6CJF0nw/drVglqyQuH5oEgwcFALY035a3m1E4Us
	IPeL8zE0ajITx8Ejv7uJ5IxnrFVBefS55YUXjR2iljgV0bX53mqEPLat9E9I1k7kUfwQPcfyfC4
	QrHZiGfYaW8+naWPTG5NGZBkI3CxK6ZksEdrrsxnWzc83ndRHB7U9pwV6
X-Google-Smtp-Source: AGHT+IFegvOXCvA5sF0jNFm/UnIAP1YzQ26yl3/5ZrWK+EV9rktXxZYfEire4zGPtTBYLO1vFpq5AQ==
X-Received: by 2002:a05:6402:2751:b0:615:5b45:2eb9 with SMTP id 4fb4d7f45d1cf-61586ec4393mr2799100a12.5.1753872312832;
        Wed, 30 Jul 2025 03:45:12 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:12 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8723bs: move rtw_report_sec_ie to core/rtw_mlme.c
Date: Wed, 30 Jul 2025 12:45:00 +0200
Message-ID: <20250730104501.150270-8-straube.linux@gmail.com>
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

Move the function rtw_report_sec_ie from os_dep/mlme_linux.c to
core/rtw_mlme.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 34 +++++++++++++++++++
 .../staging/rtl8723bs/include/mlme_osdep.h    |  2 --
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 34 -------------------
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 27f775d8f9a8..1c720947955e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2033,6 +2033,40 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
 	return ie_len;
 }
 
+static void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
+{
+	uint	len;
+	u8 *buff, *p, i;
+	union iwreq_data wrqu;
+
+	buff = NULL;
+	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
+		buff = rtw_zmalloc(IW_CUSTOM_MAX);
+		if (!buff)
+			return;
+
+		p = buff;
+
+		p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), "ASSOCINFO(ReqIEs =");
+
+		len = sec_ie[1] + 2;
+		len = (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
+
+		for (i = 0; i < len; i++)
+			p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), "%02x", sec_ie[i]);
+
+		p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), ")");
+
+		memset(&wrqu, 0, sizeof(wrqu));
+
+		wrqu.data.length = p - buff;
+
+		wrqu.data.length = (wrqu.data.length < IW_CUSTOM_MAX) ? wrqu.data.length : IW_CUSTOM_MAX;
+
+		kfree(buff);
+	}
+}
+
 signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len)
 {
 	u8 authmode = 0x0;
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index 8e8b5de285dc..3930d9e6dab7 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -8,8 +8,6 @@
 #define __MLME_OSDEP_H_
 
 
-extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
-
 void rtw_reset_securitypriv(struct adapter *adapter);
 
 #endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index d2f4855e9d9d..918d9496d7cc 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -65,37 +65,3 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	/*  add for CONFIG_IEEE80211W, none 11w also can use */
 	spin_unlock_bh(&adapter->security_key_mutex);
 }
-
-void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
-{
-	uint	len;
-	u8 *buff, *p, i;
-	union iwreq_data wrqu;
-
-	buff = NULL;
-	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
-		buff = rtw_zmalloc(IW_CUSTOM_MAX);
-		if (!buff)
-			return;
-
-		p = buff;
-
-		p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), "ASSOCINFO(ReqIEs =");
-
-		len = sec_ie[1] + 2;
-		len = (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
-
-		for (i = 0; i < len; i++)
-			p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), "%02x", sec_ie[i]);
-
-		p += scnprintf(p, IW_CUSTOM_MAX - (p - buff), ")");
-
-		memset(&wrqu, 0, sizeof(wrqu));
-
-		wrqu.data.length = p - buff;
-
-		wrqu.data.length = (wrqu.data.length < IW_CUSTOM_MAX) ? wrqu.data.length : IW_CUSTOM_MAX;
-
-		kfree(buff);
-	}
-}
-- 
2.50.1


