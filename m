Return-Path: <linux-kernel+bounces-746611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3CB128F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF08DAC611C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA031FDA61;
	Sat, 26 Jul 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVfvPZDH"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E44205E25
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504419; cv=none; b=d6ETBiNrtz1xB563WxOwgq8QbeRqyHg+DNE4Dy++mt8JoOKldoBdTxOo0DbWrUO0NWjDhPjXCXPNLkJcI/CwiBPgIZL/s5Q4W4hiPqsMKSfI9MAfebXMKuXYT2aGZRGyxHCWl3EyV9sMgv5+fz0xEcPCGWSOGGjl70qkwSxLqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504419; c=relaxed/simple;
	bh=xmYYMyOZJwjwp2JTaH48jAKSP1kH73X0D1fbu/mH484=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp4OebVlKupCBDS7ciDmlxR1vYCJZg27HsOoF7S49iGWiElXAHoE7AzWZtWP5xzWVZOLi8F0rPvPeQunZy9sEbwF0PeoD/JSLzRgqXlNQCOa7J09RBIkbjLq/ZeWS2SKLMpYy3I0pBNRe+cvOxjwGnGBv0hkT0U23Vu1sgYEpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVfvPZDH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e33d36491dso383512785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504416; x=1754109216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nah+LM+soUeFmNwfK2IEfdnCoc7CZm0auXL4WL3rki8=;
        b=VVfvPZDHJQj7C2humbjh/3XD6T5EubxwvZis3mq2MTmLA+wEMOgyGRoUnNK+dZ4Vde
         WeY6fpm5KLP4QyQMUo3wLrdWKIMNQckXiEkXBqcwMr0DvKqQaxqpZJ/b0gvmupkx5HJK
         dT3tjIUt3j/7tyqLRsaEzs1xRlbD4EbccLWaAa8zSYxLlHEcEl7ESybhzAM1b0Mkfbxi
         fIYAqhmCBDREa+CJU9CsL3vqa5Z7mIAYiwp1jJy1mR6KF+Ss6O4TAfA0GvP9Uj0N2hQq
         BNvzcCdj5KgPMwU0oZA7Qx4eZ2QmDdnOPtJiqV+1VkzVDCM6lhgWGjgvKAXVqHntkgJj
         /+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504416; x=1754109216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nah+LM+soUeFmNwfK2IEfdnCoc7CZm0auXL4WL3rki8=;
        b=J4yXiWvPD1RaWkhX4u7XmV2v7+ojZYBD+Pi1rZRlDyMlPif8Vp9siFxYKaLgjo3U0H
         n0keqgmM4hbSVfM7waGh7wJUX1AOK5naSM4IgaxDidIV+l3e9PtS3wCJ+fOqseFKfOYc
         nkFbw3X8EuM8pu4cK98i71mpfU6P2dqQbw8GL4ISXsaOfhU2V9YGvcwaYQIELMf0p0GN
         8N1kE+afiHhmLgQ2zQDCiUjlX8oJxOjuG387MPirZ5cUhF23Ptex5tn/rz4xQbOK0mol
         wd3F08iipNtR9FXAizptDe+/UcaAuhgFZqpetHKe7cEgWxIdw1OXEWXAr3pQcM4CjtCt
         kwvg==
X-Forwarded-Encrypted: i=1; AJvYcCXZLnx1tpMomfPSnvVllUfvzzW18eRUVug46nYLOys1RcNPLiRJ2r6hs2XbwJCYvbB2aUrBGcZeAHBl0+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyel9Q5SBBF8R26q6onOasHHbSUBgRxmkS5Uznd/FbVx9A6J1N5
	/hiwkHv+J/mPw60meylicYQC71+YLVraqK0AVjWLSkdXJkliHBhSMJCsagCHpg==
X-Gm-Gg: ASbGnctFeX/LP6wv2BXzqh0uKIWPbbh6NDE66MW2htHwiavgbne0KAF0XekQBuCnnfS
	O/c9Zy0g3gnE2+25u/RKo1KRQX63V5mBurIdH9LGEPDXn3SMV7WGEhluz1oLP/qYnhw2pj0r5X1
	sSKBL5a/vYVMaGLs/L/LXGMDm15Glj8SAjRmdkgDpQ2zJHQZOoXiMVVFfNn44ez9FsZvVzRIjff
	/mc/CgQ9TSa1F+qTjcb4XWYZOi+zVGDlo5HCisa5HOTugWSGr7T7wcsaD4A8j0snof5v1tRqGZu
	byeBUJ4O1CFVvbXt6QGDMHkoBUHyK92qvGNlMsng4oU0rEwTwG2IadU35iFf4Fr0C6IyiEifpOZ
	7O7Rlxx0F9OppRel4S7Kf8lcJyZXOYPu4DxFj9NeczljV/1pQiQI=
X-Google-Smtp-Source: AGHT+IHqImVx161CnR8opFPNvrqp44DGum14iIX4WljcQ4qQP0d3IMEZTB3jJOmQ2Y80Ec/Sak268A==
X-Received: by 2002:a05:620a:4591:b0:7e3:463a:5189 with SMTP id af79cd13be357-7e63bf53d4bmr614021485a.1.1753504416552;
        Fri, 25 Jul 2025 21:33:36 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:36 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 05/20] staging: rtl8723bs: remove space before tabs
Date: Sat, 26 Jul 2025 04:32:03 +0000
Message-Id: <20250726043218.386738-6-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed occurrences of space characters preceding tab characters
in the codebase. Spaces before tabs cause inconsistent indentation
and are flagged by checkpatch.pl as style violations.

This change improves code formatting consistency and adheres
to the Linux kernel coding style.

No functional changes made.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 536b6d036e88..f8680124ce24 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -559,10 +559,10 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/*		 (2) network_type */
+/*		 (3) WMM */
+/*		 (4) HT */
+/*               (5) others */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -1819,7 +1819,7 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 	u8 keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &adapter->cmdpriv;
+	struct cmd_priv		*pcmdpriv = &adapter->cmdpriv;
 	signed int	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
@@ -1922,8 +1922,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
+/*		-1		:if there is no pre-auth key in the  table */
+/*		>= 0		:if there is pre-auth key, and   return the entry id */
 /*  */
 /*  */
 
@@ -2073,7 +2073,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2099,8 +2099,8 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 void rtw_ht_use_default_setting(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	bool		bHwLDPCSupport = false, bHwSTBCSupport = false;
 	bool		bHwSupportBeamformer = false, bHwSupportBeamformee = false;
@@ -2174,7 +2174,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2294,7 +2294,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	int len;
 	struct ieee80211_ht_cap *pht_capie;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
@@ -2414,7 +2414,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
-- 
2.39.5


