Return-Path: <linux-kernel+bounces-753078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D7B17E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D56563230
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75422A807;
	Fri,  1 Aug 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVDi3yqq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE52264D0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037167; cv=none; b=FcYIBBdD3oFM/VGVHzy9E342MCmuATeca8o5YyvyqDxNJZhuyVVQLdY+CpBVDxgLMlkzVwwQMlqj1h3PJyYZEAWPLtFDbyn0czQpi5hkJn7KYWH53FnpBLPV3NFJeaIqheRTPJrlBoIyRXtDs5etNtCAKCXgfoCdsC/vGSvPtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037167; c=relaxed/simple;
	bh=Fem8ko9lSvGHfgnIOnh/NvK/frr+MZh+mvHCOWVbchY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HssmBsgwGuAlRfREf11at696rWzYI3QFdL8sZ5SkuKEVYSo8qh8SqaUggLwHb2piF0AF49Uv4nqH5zwH/qQ+F32cGs+os5hT7l6FTZUgx/8SUV7V9XeEmWYE6NJ6DoZyMYL6smBDTrcmFQaYUZpv5+/4Br1GMinFDiEsncmf8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVDi3yqq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso2196046a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037164; x=1754641964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bBtvdWNzSZQGm09QORxMyO31qGjWa8u8PjxWCuc9as=;
        b=cVDi3yqq1ZqcaF3dL7SyswVZnvZ3MHB0ClYqhGhx4AgiIkK2RspXoeOJvf7d20FUXF
         QRs9Ffo/lo8TRMxJ0751zFZoSnLc+WFkKi9MBybiQVr9wnfXanK/a7Lk9MMljp0U+bqG
         zrHmi/jkm5akZxSZv0t3SoBlvAS0dqcpct4kDiL2LT530uhFCco70repZplpATIbysZu
         Ahp52wXQWil2f5zVwPivU79ya96+8pwVgz3RdPC2kO7RAXIg5luFoYgnLXM8XTedgY1E
         XQsnBFgK8K2VAZ1ZscpT1utRbaz/8lHH164R+47SNyP+2B8UOAB6R7sjTW+UTpDTNtHX
         qD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037164; x=1754641964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bBtvdWNzSZQGm09QORxMyO31qGjWa8u8PjxWCuc9as=;
        b=e+GAHU9XYYBXhj5HIpyQYovT86jD7CnN2Mgrzvp1HLax6UxQ9frQ1uqDjHXBSuzO6t
         vBu6ZqzcvME3wZWASjUhsW52r0NAoTwS/SvmHyU/Qe1vFWs7yy0kNsFK7sN/W0nlMMpX
         NTjfd6J80w+1MoSjSKvr8Sf1yhWypvyvEAF7ryVfXK221wLtm1NqU9LyY3nzRUp5MAYu
         xXr0jF8GwC7e/weeAW+bllzWTJ9tlBHttQJKYsblMrbGjpcZKlfCcaPM3W8PJm43uHxz
         O60C5o0a2MfOIEaJ35VIfWJUWE5SGQQZpbJXssrBwsmD6DfuZvFFQoWEjCtkaBtZebl5
         C5sw==
X-Forwarded-Encrypted: i=1; AJvYcCWFq+bl+a1tDROGWakLAGgcoepWqLAtbGhaOC3sgSNKhAXusTyX9ZxIH2TytxHysbetkD4ZxZoCx1Lz72o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQvLgTRCWGUfk4hPewdnQYA+EP40TpeMzBJs6o21kcdCfxhY9
	geefAEu9xnyttyp/6uoo5Rse3An2s4WGRWGBWXPcFkD+GWYTe6QvLJos
X-Gm-Gg: ASbGncsyIBSHrlURi76Vf7MHmAShdUYaOvdqM1ZcCYlQ13MhRAT1DdGTXdd4u5t3wdY
	WTRCVQGvKzhK0Iow0rb++3JTkSDJd1AGjEM7d+ewkjtAruVHotGWqoxiYKf3kRu8AY7tUeUUusU
	N3nGJncAvwa+WyIZ3IWdoUL7j7e/fCi/HqIKenbR8tt7YoNzfXrXI3IdV2ZA5c1lF5xbd1U/RFK
	Upv0PBRBcLRAsy3NVzTGe275rOxeK0flNDygpA8M9xevhIbq+JxV3nIKz/N2RMIfO9y2LrkM9wB
	UnCE+RflVIjU0DX6ygTALcofwnl6OQqh4PbqGGMsi7vx8Kmj5defPpaGSttu3N1owo+Wr/Mbg4h
	AK2PmJrt3iBpTgRTX/Vt3xDLKX5kIna5JKZODWUDaasdZzJYh2XpmA1iWalbYYQ==
X-Google-Smtp-Source: AGHT+IGUM2Trs7GoVAhrsokBw8hYDQtQNMKPEPAcNZUU+WeRHA1SHQYaNhbpGznOVlfXrE/+PtCNbw==
X-Received: by 2002:a05:6402:5cb:b0:615:4d3a:9330 with SMTP id 4fb4d7f45d1cf-615cdd06d80mr1766661a12.14.1754037160476;
        Fri, 01 Aug 2025 01:32:40 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:40 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/8] staging: rtl8723bs: merge rtw_os_indicate_disconnect into rtw_indicate_disconnect
Date: Fri,  1 Aug 2025 10:31:29 +0200
Message-ID: <20250801083131.82915-7-straube.linux@gmail.com>
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

Merge the functionality of the function rtw_os_indicate_disconnect into the
function rtw_indicate_disconnect to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 12 ++++++++----
 drivers/staging/rtl8723bs/include/mlme_osdep.h |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 12 ------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b0384244a950..839496aef933 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -930,10 +930,14 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)
-		|| (rtw_to_roam(padapter) <= 0)
-	) {
-		rtw_os_indicate_disconnect(padapter);
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) || rtw_to_roam(padapter) <= 0) {
+		/*  Do it first for tx broadcast pkt after disconnection issue! */
+		netif_carrier_off(padapter->pnetdev);
+
+		rtw_cfg80211_indicate_disconnect(padapter);
+
+		/* modify for CONFIG_IEEE80211W, none 11w also can use the same command */
+		rtw_reset_securitypriv_cmd(padapter);
 
 		/* set ips_deny_time to avoid enter IPS before LPS leave */
 		rtw_set_ips_deny(padapter, 3000);
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index 00c0a44c125a..8e8b5de285dc 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -8,7 +8,6 @@
 #define __MLME_OSDEP_H_
 
 
-extern void rtw_os_indicate_disconnect(struct adapter *adapter);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
 
 void rtw_reset_securitypriv(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 326acbd8dc84..d2f4855e9d9d 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -66,18 +66,6 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	spin_unlock_bh(&adapter->security_key_mutex);
 }
 
-void rtw_os_indicate_disconnect(struct adapter *adapter)
-{
-	/* struct rt_pmkid_list   backupPMKIDList[ NUM_PMKID_CACHE ]; */
-
-	netif_carrier_off(adapter->pnetdev); /*  Do it first for tx broadcast pkt after disconnection issue! */
-
-	rtw_cfg80211_indicate_disconnect(adapter);
-
-	/* modify for CONFIG_IEEE80211W, none 11w also can use the same command */
-	rtw_reset_securitypriv_cmd(adapter);
-}
-
 void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 {
 	uint	len;
-- 
2.50.1


