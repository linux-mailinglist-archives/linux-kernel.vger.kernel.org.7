Return-Path: <linux-kernel+bounces-753076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09667B17E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3367E54117A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678E2264C7;
	Fri,  1 Aug 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXzzf0kl"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D12222B7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037165; cv=none; b=qC8iNE4AcDoeDLD3j44N5N0XXUE+oJ/a5NSLWBNFFVCFjH6qskq3EOheXbveyCNOVbtn1xE6Z3Ycr75edZCwjkeEtHBAUPY+qlxfZ5sIkLpuz34/585TLYZ5RVhgOT2ZMM+nzbVosU9yDA8GShfwsWWhwRagbVhn5XGFDohKa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037165; c=relaxed/simple;
	bh=6LAp/b/lldOK3zVDh6jZuxdHhcUanuF5F6aqTdw7jeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbomr2vGsoKdMXh0JdVydlG/NGkhOl+HQJjdebhK/rI+HVIdvYM60g0WWD77qq8J1QgadtRiuNr+OQZxYmokYTi4GQ1juRrqlUrEyGHFIfZaQzHo8CIjMo/ASShS6CFJMWu6+9LCXJv4zUW0kCh+6baMS5FpnT4hOLjc2C6V+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXzzf0kl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2371514a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037162; x=1754641962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQd4r+QBAQ7livBvDF2Cnl00jX0+lsRk4nu46EPRFUo=;
        b=AXzzf0klp5atScB639XBwbI2TVuxvcpibITFZ7zcVc4BkKQEJ7jJvObEfU/ObC8wg3
         XiB0p4/27qUCZFHxA8YiInfV+sglELSahbqLuV2UsI0S0EMUMBVZ466uzQEA/Ttim5KI
         O7aDg/3mvQ86FTTRqIyZfJqrYgt10b3xtdyBEklAOFsCJXwO4JIxPjVSVuZLU6+TJA1p
         oAPp6tqCoBUd+SeDNzH8grVyAx36R1962jKgOoqfZ451J0cTNi1OL84/B7H9mj6GJX1B
         HcErxmYXgpS6KBrvnkmSJITLWVSio9Dmm7ioq/oWzDvNNolS+I93A/lFOKOt9JBTcf6k
         x7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037162; x=1754641962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQd4r+QBAQ7livBvDF2Cnl00jX0+lsRk4nu46EPRFUo=;
        b=qfvqsoRMc+6FiVpsHHs9Ct3OlqlFXcTse7RViHPD9Xa6aeJm+n4kGCzo3BRuI7KMx4
         arBOkN4R5CgD9tsZv2vbtMBV+DD1vQdGc14FfX57aGID750I/8yOp0wllQQjDI5Aby1N
         jUVEUQBEHerdOrUz6Z+GjxYFB/TExSkYVwx2FWeOt+uxncZ9Q+BQBc3SPV1MNUgJLimM
         OyLoqDQlVzKXmvzJmJn677MelGJ+MmJ5j0sK0+O/+z1pE1+Lv/hnELfC62MCLwYvfZkU
         foE37LVn977MOIPdgqQUHI5nXw6fFRodjYtcNWeUcDd7RJ+S/gJ04aNzz85qq+gCRExe
         B0lA==
X-Forwarded-Encrypted: i=1; AJvYcCV4GyQq6B+j/jJjQw+TGBIYBYg9+ZkQa30M0VsWCynLuaOsGqhYMrZyv54RX8UM1UgCQW+dy9AWIwc0Grs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BX1Cgq4LFXKfooVErd5hCjsKsVDpE9/c+AjxhbKTZJWRytJe
	m8tFOaZ9LK5J/eo/a0Gxm1/DWlYv0ZZFqTHqld2gtzgqhtrdin3g2aJD
X-Gm-Gg: ASbGncuO23JppWuMV6NTr5QMkzU30PMYfLn6ckvyHSGOkOJTN2DSo1SsyPq7TbRgkC3
	0TYM052aUQRrwjzb9ubkNZTDTHCP2sM593cL2xzc78PIEjaqjE1hHc0BzNL4KDBMuweDJsX5yCY
	xSEysukM16TNWClytogJGtcWwo/O0UaJFjWoF0afEYZ3MgFUYrgtjfKxEZib5hP8HGYIHJaR4gW
	6n+di7MFuN5w83vgCXisUBOXig0T9N3gmqSh2YY2SSO9SxQ+kfLf4TzPZvBEyBP630TpwVGH+h/
	nR6NdSlS8Uofawu3XnWaWvM2AJkrhd7tR/q9ygNulu3o3Qbb7C6snTqzkYaL85SDTQMWzrz64XT
	2JZKoUyoii67PYFgEIbPyu5pbF6ae6OtEB9hgw+1YYubUdWpd504=
X-Google-Smtp-Source: AGHT+IFdiZMkESDQvAHlWboTh1xfX8SBJwb5SyD9HTM8E4Akk3n6TQRRiQnVUbtrqMJEogjKUM/rrA==
X-Received: by 2002:a05:6402:2802:b0:615:f76:9408 with SMTP id 4fb4d7f45d1cf-6158727399bmr11228509a12.32.1754037161545;
        Fri, 01 Aug 2025 01:32:41 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:41 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 7/8] staging: rtl8723bs: move rtw_report_sec_ie to core/rtw_mlme.c
Date: Fri,  1 Aug 2025 10:31:30 +0200
Message-ID: <20250801083131.82915-8-straube.linux@gmail.com>
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

Move the function rtw_report_sec_ie from os_dep/mlme_linux.c to
core/rtw_mlme.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 34 +++++++++++++++++++
 .../staging/rtl8723bs/include/mlme_osdep.h    |  2 --
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 34 -------------------
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 839496aef933..4c816fb2500b 100644
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


