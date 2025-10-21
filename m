Return-Path: <linux-kernel+bounces-863095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E6BF7002
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B19A482625
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1133C518;
	Tue, 21 Oct 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="Wio5EAu2"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251A33B969
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056028; cv=none; b=jLoi29hzKhghkMYVTs5ypAajLqhlqt6zXlzaX5aTLUkUxaww7Bzfea24QcQPiza88xDtzUpZhw2TUc0NvVRI5u80yI8MVPPtO4kNVTeZNp00buglcXY7x+qcoxlye4cA+f0days9OvSDuhLcid65kqDGuXcabLDEN/k1Mhdlmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056028; c=relaxed/simple;
	bh=gqE3IvVVDXYtcDlpFajrVr+GpzXq1zM6R3b9RzN1g1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7DPLQUc5L+jBgQe6wAu2NK7q9QYsFdVPUiXJnM3aebGpSXGgTowl9y+rFhEPFrEe1/yyO4BzWGXV0YTC0oX/9qFXf6CBih50mwW4or5zjMsTAVln5IILL6ToTGAuj6K+8k4nT77q9o9Gr3MrlHJNCmJG7OJjve3MhtmmMVFMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=Wio5EAu2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so70903365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761056023; x=1761660823; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hlQLgMfHWSF1PqY9AiQn6HGq8QPbKKPzlpsaPyA3LVE=;
        b=Wio5EAu2yZYLTuxrucIMWL4vjmfGDSSmifsxjSosKTkpapFZEANHJkhv+t3MSoKXSO
         nqH98R5rTQwsBYAjzQdhAwhJyoz1az3pcq9gwm2ePrJl0ONFyPuVoIjtMNAE2sE7cOuh
         Z/Hsr4UCVhrh5W2UUDv/GkOLjZxP9hjZEAuQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056023; x=1761660823;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlQLgMfHWSF1PqY9AiQn6HGq8QPbKKPzlpsaPyA3LVE=;
        b=YRmumUog9ywsN+b+EtMS8e+7N/j7E411mWH1lEkO4Y9KoZlx0XgyHpjFlX8IPm3tpo
         P2+1OStWPRKRUr/6jpzsLIwpi3/gN9z2peuLHCMg7IJTQ7Ft75ydGqz693tiL9GC3wic
         sEZ0BYtkd9gQ/Hnr6bT7Bf75GiChk0SA0wej9d00QEO+dAjx4gQ19tB1n1boVKR3sqzX
         hBVyHN1yzb8NQzGTK28Cdwuy41nK2q1KRax25+An/sl+T3aKcChgWWgwBw8lQzjr+DtT
         ElZp6uEIoyS8n8+votUH/Ezo9ZtPHtvZd/l74W4fmK9P0V/F9rN4XW52clnaZJHKNdpL
         j6rw==
X-Gm-Message-State: AOJu0YyrZUfxrzyVwyYDdOd1P1jDvqYByZRg9/bNQNhSGtzA4YkpgLT2
	EJI9A5tbj5TD+14uqA3b8ixKR4wvpZ5u/oPZ+lKk8kKXvYUSU2ZSTPg8sVe0QbhE5Zw74BH6HoT
	95MdTXC8qx+2LN92cB4hnsNoyBYSPqBegIKS6lj7iCnW01B9XiinTp54d72gKBvLPVhVFrsasHm
	I7OQ==
X-Gm-Gg: ASbGnct+Zl0VDeock2zjkorl2TWhgZXYt2Mje6AecUc2RxA2g+BmuwL6+rgafNnHd7C
	CrtEOioLRnJPpJFNifVlLi7/oZbo7SxtH5LUInjyvEFIeRpDzHEOCra++h3efMBaEIN1oNWD2cQ
	JeHs12hXmNMc3jAJ9AFQgAQ1SPkix2SFFsXRY4YpsdHgexnD1eYHV7l1SJsE8M0XS6Glgi5Wa4q
	5TxpIllVisb/1AhCcv98seLQdATSMFrPE8rSyj0nVzsaUj2xp7oUyQ+q9Zc+nFh1kXTArtXoL74
	yLqtZx2cRCSaCM7YPO8MKWJYsouEa9Kr1DQeeq7u6Yj/BNfwn0wpZlxajKreiBIrY0I+chIKvwh
	lRmNSZI46cijwYbCiOqo9aYtLR68cH0y6XwHkuN1492maC6dNhs5W0V/14mIdtDiHzd1aoHhEaM
	mxUMUwXBLX7XPwc4uEGNp88gW0lfDg8hncC9XI2fG6rvVLBm5iUPRm6+fyMMc4rkkKGe5gtzYB6
	tpY96aSUzkUY8Q=
X-Google-Smtp-Source: AGHT+IGojDeHMnxXKq7DykgYly4jQB1hFjBRtAPz3ypmCv8JCdph/x43NxG5uQVD6lzcpKl9T6Xryg==
X-Received: by 2002:a17:902:d492:b0:25d:1640:1d59 with SMTP id d9443c01a7336-290c9cf8e12mr181170335ad.8.1761056023177;
        Tue, 21 Oct 2025 07:13:43 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fed21sm110653965ad.80.2025.10.21.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:13:42 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] ath9k_htc: fix WMI command handling and improve message sending
Date: Tue, 21 Oct 2025 19:43:37 +0530
Message-ID: <20251021141337.33268-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 139 +++++++-----------
 1 file changed, 56 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index 0d6272ac0dac..1333b90ae425 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -349,93 +349,66 @@ static void __ath9k_htc_remove_monitor_interface(struct ath9k_htc_priv *priv)
 
 static int ath9k_htc_add_monitor_interface(struct ath9k_htc_priv *priv)
 {
-	struct ath_common *common = ath9k_hw_common(priv->ah);
-	struct ath9k_htc_target_vif hvif;
-	struct ath9k_htc_target_sta tsta;
-	int ret = 0, sta_idx;
-	u8 cmd_rsp;
-
-	if ((priv->nvifs >= ATH9K_HTC_MAX_VIF) ||
-	    (priv->nstations >= ATH9K_HTC_MAX_STA)) {
-		ret = -ENOBUFS;
-		goto err_vif;
-	}
-
-	sta_idx = ffz(priv->sta_slot);
-	if ((sta_idx < 0) || (sta_idx > ATH9K_HTC_MAX_STA)) {
-		ret = -ENOBUFS;
-		goto err_vif;
-	}
-
-	/*
-	 * Add an interface.
-	 */
-	memset(&hvif, 0, sizeof(struct ath9k_htc_target_vif));
-	memcpy(&hvif.myaddr, common->macaddr, ETH_ALEN);
-
-	hvif.opmode = HTC_M_MONITOR;
-	hvif.index = ffz(priv->vif_slot);
-
-	WMI_CMD_BUF(WMI_VAP_CREATE_CMDID, &hvif);
-	if (ret)
-		goto err_vif;
-
-	/*
-	 * Assign the monitor interface index as a special case here.
-	 * This is needed when the interface is brought down.
-	 */
-	priv->mon_vif_idx = hvif.index;
-	priv->vif_slot |= (1 << hvif.index);
-
-	/*
-	 * Set the hardware mode to monitor only if there are no
-	 * other interfaces.
-	 */
-	if (!priv->nvifs)
-		priv->ah->opmode = NL80211_IFTYPE_MONITOR;
-
-	priv->nvifs++;
+    struct ath_common *common = ath9k_hw_common(priv->ah);
+    struct ath9k_htc_target_vif hvif;
+    struct ath9k_htc_target_sta tsta;
+    int ret = 0, sta_idx;
+    u8 cmd_rsp;
+
+    if ((priv->nvifs >= ATH9K_HTC_MAX_VIF) ||
+        (priv->nstations >= ATH9K_HTC_MAX_STA))
+        return -ENOBUFS;
+
+    sta_idx = ffz(priv->sta_slot);
+    if (sta_idx < 0 || sta_idx >= ATH9K_HTC_MAX_STA)
+        return -ENOBUFS;
+
+    memset(&hvif, 0, sizeof(hvif));
+    memcpy(&hvif.myaddr, common->macaddr, ETH_ALEN);
+    hvif.opmode = HTC_M_MONITOR;
+    hvif.index = ffz(priv->vif_slot);
+
+    ret = WMI_CMD_BUF(WMI_VAP_CREATE_CMDID, &hvif);
+    if (ret)
+        goto err_vif;
+
+    priv->mon_vif_idx = hvif.index;
+    priv->vif_slot |= (1 << hvif.index);
+
+    if (!priv->nvifs)
+        priv->ah->opmode = NL80211_IFTYPE_MONITOR;
+    priv->nvifs++;
+
+    memset(&tsta, 0, sizeof(tsta));
+    memcpy(&tsta.macaddr, common->macaddr, ETH_ALEN);
+    tsta.is_vif_sta = 1;
+    tsta.sta_index = sta_idx;
+    tsta.vif_index = hvif.index;
+    tsta.maxampdu = cpu_to_be16(0xffff);
+
+    ret = WMI_CMD_BUF(WMI_NODE_CREATE_CMDID, &tsta);
+    if (ret) {
+        ath_err(common, "Unable to add station entry for monitor mode\n");
+        __ath9k_htc_remove_monitor_interface(priv);
+        return ret;
+    }
+
+    priv->sta_slot |= (1 << sta_idx);
+    priv->nstations++;
+    priv->vif_sta_pos[priv->mon_vif_idx] = sta_idx;
+    priv->ah->is_monitoring = true;
+
+    ath_dbg(common, CONFIG, "Monitor interface added at idx %d, sta idx %d\n",
+            priv->mon_vif_idx, sta_idx);
+
+    return 0;
 
-	/*
-	 * Associate a station with the interface for packet injection.
-	 */
-	memset(&tsta, 0, sizeof(struct ath9k_htc_target_sta));
-
-	memcpy(&tsta.macaddr, common->macaddr, ETH_ALEN);
-
-	tsta.is_vif_sta = 1;
-	tsta.sta_index = sta_idx;
-	tsta.vif_index = hvif.index;
-	tsta.maxampdu = cpu_to_be16(0xffff);
-
-	WMI_CMD_BUF(WMI_NODE_CREATE_CMDID, &tsta);
-	if (ret) {
-		ath_err(common, "Unable to add station entry for monitor mode\n");
-		goto err_sta;
-	}
-
-	priv->sta_slot |= (1 << sta_idx);
-	priv->nstations++;
-	priv->vif_sta_pos[priv->mon_vif_idx] = sta_idx;
-	priv->ah->is_monitoring = true;
-
-	ath_dbg(common, CONFIG,
-		"Attached a monitor interface at idx: %d, sta idx: %d\n",
-		priv->mon_vif_idx, sta_idx);
-
-	return 0;
-
-err_sta:
-	/*
-	 * Remove the interface from the target.
-	 */
-	__ath9k_htc_remove_monitor_interface(priv);
 err_vif:
-	ath_dbg(common, FATAL, "Unable to attach a monitor interface\n");
-
-	return ret;
+    ath_dbg(common, FATAL, "Unable to attach monitor interface\n");
+    return ret;
 }
 
+
 static int ath9k_htc_remove_monitor_interface(struct ath9k_htc_priv *priv)
 {
 	struct ath_common *common = ath9k_hw_common(priv->ah);
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

