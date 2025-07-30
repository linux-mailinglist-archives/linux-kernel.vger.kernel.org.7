Return-Path: <linux-kernel+bounces-751230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE63B166B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0408C4E5CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A12D8DD0;
	Wed, 30 Jul 2025 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSDnGIlu"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEA202C2A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902390; cv=none; b=mANvj0cki3LDaQx3Pw7sy3LOIp8Rmieeta7h8R2EagGFbYX6UPLyyikBXAfPLH68IzuHsfNAzhQwu+ZAN22EDgqrEZ9w/hlSAQDjaXbKYoWPnwrS6sLbRBAkx4EDkYoZSr+4nBxzq4FgbWlrZX4MDBreCVF5oP9EzPV5RbQZOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902390; c=relaxed/simple;
	bh=6KVv13hT5JsR6YdNzNX5uk/jXpAm7CYMxH6SaNm6F2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCz1MspvbrucWkMlamJwNyVtr1hLooKuxT6qsU4Dj5bLVc1hYaeyS7cjABzSvU742CquBeDCeYQwzj5RwfG61ig9At5PlTdTR6HGd8cvVLkwKEYkR1tWmOqWW12TF/uprrvW57oXSr5KkrGbDKRTh1H3lrY4HmQAxZHIS4DogsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSDnGIlu; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e62a1cbf82so16660785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753902388; x=1754507188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybVQcVFyEdYnpN12omIpuUPF5pVwuzWEDeaUsFMkJkM=;
        b=BSDnGIlu5chqo5lKX50eeJG+e2+xcZlX4IYknOEZF3rD0RTVZ+w6Dd/FPYjOzOeWXo
         wvGiYpGOrUK7PguBIzYJ14HUMF1OYYm586X9btLYQugLyi81SbjrhKvbdmot2BmLdW0k
         G9yt4svyf89q6rakvt3+cYxKGUoQQy2iL7Vb1jZAtB2Mo8ZnXkFX5o6hLUGTMUPhf/6B
         BqI+QWH3u5yXeeNwmQkSgbO0W/1yl8QRiGymp+89VtbftXwVNZPytVCGudwp4veRz3Mc
         oryKd+syp5dUVN5/djfUvee1FFILpe/R0H0cugiJ9kP83PoM2ikvbeJFbWj6q6y/mOKU
         pVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753902388; x=1754507188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybVQcVFyEdYnpN12omIpuUPF5pVwuzWEDeaUsFMkJkM=;
        b=JjKq3hi0oy6y4+aXJ3zhaEyQuM5uxwaiil5Y7r2cA98MuJDZs7Z/MPehBZw46aDsTj
         eMKDLfOloBlItq0D/XXMEguTMUNrCQjOUOBxWz49fODPb09/vMO4mkDuKFdlJNO8+a1Z
         NclKSBXZjpEfRJIgAXGlEhfbakhx9I3P+vg+G140MnRydYp1FOrEp9xj8UkfPr/v6kng
         j8aEEEcC9jKa/z/EEEqxIr/uEQRtHRgjPMwey+80ACbpTSaxOIrrpOR9mITyg4v2XrIl
         m4s6G9+uzVYfs3bb9H9/ZObxugEPfZd4BjWZUQ6c/PIgdpHEV6V5U4eiPL1OTSLWyIBl
         Hf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzq0NoBB+2id91a6/F9s/07WHPBtYlpodY0ErSfS19JP+rldeV7D/yL19gC4aEc7H0tqccdJMLQjZICTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjQZ3pD2fU0FP9mulR/YuE+Q/AyKR3+NZJTEcadiR7FhNIg8i
	zwHTKIflf8XX1zcf/IL4KLM6OeWGL8tx/ErxwDrVRaJnLAKKY5fMblO9
X-Gm-Gg: ASbGncsGxS4FB7HoX4TdmK5+2KHfzld4BCkKJb3p0EnT3ETVOuP05If4GpIejzKv3qc
	O2Rah5itEJWPScncZ1PrAOH7sMtXEYDk+Bot6sixVQCRtsmNRNZ3ZEBq7tgZ+h0TpO58YfB40Ms
	BFd9rf20K5zW5gqTLhusXGfzgrolQVvlW8gnNzlhVeelpZjhUekCCTR/ty/jfM9OOkR/3aT0wwK
	rDKik9T3PRs3t/osVpvpIKimvyKF6oh0pczqwBFiEsl7BCDkp+ek4mc3vo43pcF/V6eUC32xsju
	Io+EqO/nfZP+4ara9htXFF2zy8U3qVJZsCSzPg8WmHt05sgCMRu0HXT5I5HFuCFrwyS5OoPps2O
	ima2yYImQc9/Jo/xPAFR8ZYcA7LcRpZvpe0hc3lBB9y/tkIP38xE=
X-Google-Smtp-Source: AGHT+IHLclzYu0Z5jQH82f2rH2WaZHw9fp1kXrSjViyulmKi/bc1CxAr9BwKnxR6p81aGiAVZl86dA==
X-Received: by 2002:a05:620a:4720:b0:7e3:45e0:ff41 with SMTP id af79cd13be357-7e66f3637e0mr622267885a.38.1753902386470;
        Wed, 30 Jul 2025 12:06:26 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6438a1345sm618286385a.82.2025.07.30.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:06:26 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: vivek.balachandhar@gmail.com,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Wed, 30 Jul 2025 19:06:15 +0000
Message-Id: <20250730190615.500904-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730042032.488456-1-vivek.balachandhar@gmail.com>
References: <20250730042032.488456-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
v4:
- Reword version note from "Changes since v2" to "v3" for consistency,
  as suggested by Markus Elfring

v3:
- Move version notes below the '---' line

v2:
- Place the '---' marker below the Signed-off-by tag to follow patch
  formatting guidelines

v1:
- Improve patch description for readability and better separation of
  function definitions, as suggested by Markus Elfring
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 357fc6a56c27..f8680124ce24 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


