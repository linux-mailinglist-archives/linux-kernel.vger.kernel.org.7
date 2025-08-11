Return-Path: <linux-kernel+bounces-761854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2FB1FF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195261736D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0862D29D5;
	Mon, 11 Aug 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YupnHtbV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E92D7818
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893384; cv=none; b=gYskl1B+s126Zx1SD4vin1N9se1DSLe2RGWjFuSvrvdrCBrN2ASRaO64K/rXxr2TJGtYr8peAJZgppBtR7gGYmNNQt3cuwqgV9gn8exkFJ4DSKWEBduen0mUsfbd/84C4Ai1hDYHVf6yXb76SqYE6Adu6pij/RzocX1lsf24kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893384; c=relaxed/simple;
	bh=bcfYnlCtdr28EEOLAbmZKjtSdxMowufDuiy32UHD3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZwac2dHLw0eLrh/UpCH/Ua2og5LYJ0WEVHFDW5okAlTQzAFowzVZQfsODz0BdCdNoq0PtRDZst3nvv9evR7thcWhmrnbKzjmAUveWUxRzY+z9VmE/gcTTOZqTGYK1ECbpnuTx8+wjNmfIUrWQp/i2h4IOyrQREdzSRLIMCWKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YupnHtbV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so3059110b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893382; x=1755498182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/qUrSc7klQ++8ep4smyxivzCQGJ/HAqWCkX0/tJWg8=;
        b=YupnHtbVwSdL4hRlDmrIXcwv423Ny3Aue7bBiQyezbOtVZRiExAmERBCc1mAq/dC/O
         2Dg1cltVxZLrqsY40BEHn46cTISeJulkEj2okEhDYrEPulcZD19DoAvtbV2YMvrQylhU
         M75w0iVzu1Bfc26/Le/AhSlzLR4QE/B5qTguTfE+Scc3uQzPdjH7qCPSTdD7rKB8RuQ+
         HNMsq2NVi37fBc7EzuujX8rfeHhwaVfQDGNM5A1m5waINJ7JHNxMsBn9q/WHOwPwk8UC
         6k4JZ/REjkMYUyK20R9nULw62wsYjBwQe2Pd1Hx8Pu/JmTunNH2I648XJOArLvX+dv+x
         x8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893382; x=1755498182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/qUrSc7klQ++8ep4smyxivzCQGJ/HAqWCkX0/tJWg8=;
        b=YBbCEcwB0vA3n6z3uU03qjaLkcMvNiRLxEzyzfGpEBA9rr4l8/EotuZyFqV86XmGSO
         5nxGm0fAzAms4zmei8Mna/2Vf8Vc0OnriBKx/HZ0cB/t4orWUq96lt55+7wp0X63vNZ8
         zgLIi4ZiyxvQIgVAqlq/G9mvckV8GcZMa8bPsuOogmxTBVEOY+k8l7O2VhKKiMmuS5iq
         eTZAmkYnwtTKgPrFPUAajgL/iSq6t+V2uIryl+45BNNgskjsWdg+7hdEpkoae25xGGO+
         F1gEhiW22bwm5dw1TcArVDVx0tEtSEGlFzYspMl7I2nkqK3HtyKruVC8hTydrynNvoMQ
         sm5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkdO/Fsa+mONCNMZr68t+FMdBfUvp8qiSy5e9djjHjt+Oy5pWW1fn6JO2sXMCngK9BVvI4omABT54y7Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuljtiXJL9KzMBDcjsx7Buc/FRsMw0GIoR8LfY0T62QQikUU5
	MGci7vPg714uywK5c3LIpLlaq4mYv3yAC6spPqdBEZQHtphQHqDXlAni
X-Gm-Gg: ASbGncuzoEdIs1cfl9XCjXvq0u0Xd2qXS9iUvuEV7L0oNoPMng29Jrq6vrCM8TAQ4Yu
	ciLF0Jqe4vsqGtMwFMrnB3fbzAh8cgW7+vI5KO9o7U+CcvIsCmf4tGb/385YX5oU19+OmEWtKfI
	S2SLV+UkNybQpr0WM9sCqr+sWnignSGUGz4/sQksTz71/fnP0FUNojYxIGiulnqfzVbN29WSrhr
	w4IIuZfz4KzDXgbrNTaU+uUPtpoaGWQRzdkx881Lj3caP1+zY3Q6hV+adG/5sVHhANlEXEmiGXJ
	dXgGJAZN8XL/g2QsZX5vpiReYJovhIYHH+19uzR2JxnnRW4NJr8pRZw/+M1w1qe6y3fSWkvMoky
	Z6CG102IVsdYncPuBrcVQaLeXxP5quQRtf/tod5UD7PwpwWbJLfqj7PAu0qP29cyPF4IobtdR0E
	8g3D5BBnQFldaL4SBlqiSwidmkdGyXkYeMsMG1m01A
X-Google-Smtp-Source: AGHT+IHmAj7XXdb91si+5GhMmPI2SmLuMySZvkdteZI3w95BBfn7ypdMwr7ecuO5XE179G4GMgcBPg==
X-Received: by 2002:a05:6a00:10c6:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76c4603e0d0mr15737000b3a.4.1754893382271;
        Sun, 10 Aug 2025 23:23:02 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:23:01 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 06/11] staging: rtl8723bs: Remove redundant comparison to true and false
Date: Mon, 11 Aug 2025 14:21:29 +0800
Message-ID: <20250811062132.102525-6-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a coding style issue by replacing the expression
'if (var == true)' with the more idiomatic and concise 'if (var)'.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 919581965015..09032131e35e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1015,10 +1015,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 		rtw_ht_use_default_setting(padapter);
 
-		if (pmlmepriv->htpriv.sgi_20m == false)
+		if (!pmlmepriv->htpriv.sgi_20m)
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_20));
 
-		if (pmlmepriv->htpriv.sgi_40m == false)
+		if (!pmlmepriv->htpriv.sgi_40m)
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_40));
 
 		if (!TEST_FLAG(pmlmepriv->htpriv.ldpc_cap, LDPC_HT_ENABLE_RX))
@@ -1160,7 +1160,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
-			if (paclnode->valid == true) {
+			if (paclnode->valid) {
 				added = true;
 				break;
 			}
-- 
2.43.0


