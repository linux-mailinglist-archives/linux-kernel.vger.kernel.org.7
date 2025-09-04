Return-Path: <linux-kernel+bounces-799731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03519B42F98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FF57BB045
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF122836C;
	Thu,  4 Sep 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlk4ujDi"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78D1FBEB0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952120; cv=none; b=Tlt43BD+ijSEg3xbBSSli6MeEsge2MHkT7W/BElLBNgo47oWCNJE2G6bChul9jfH6uDAd2FevCgE5l1NRrFttxNwx2Y3kvRnIwjqq4OFKXgCxVx2U1gg5NtwTOxfcvI1h4G7Oz8KyiEdRNyTWWsU4wn6SoBIcCF6iCAZcyQ0M0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952120; c=relaxed/simple;
	bh=VNfrpgpxpbyw8ERke3BpjHKuLSWG1u6qfMBqfz4ZVu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9a00oi4vp1w1M2QwOLCG95yLcEyzO0B7ezZwkm4hwa6ILtcE9zfcAQk/M993V7s/s09oepQTbfEKGDFZdOY6DVbJXtteZECZbKSFWZjPrhS2pyh8GIGD7ABEBhk68bqUjjCisRs+H9/DggWxx3OHCU4vHAcFbq5AiFnSSYKoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlk4ujDi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-726ee1a6af3so6441916d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952117; x=1757556917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYBVwg0qNAIsIE/fwzqPoC8Ske/D+V21MDnSh+sC2qg=;
        b=dlk4ujDiH3pW7YfIxGqHcQkBTFJGMq9IjLxHg6ZlGut+Zs24JSKjoI/VSctPgfYuhn
         DkLTFSujrPP4sgvcgSU+0gbhfCdBOa/vfO1DKUKdx+Q672q4fgwwheinwzotWyaKMPGb
         au9ZDuSJKVpHet+WVTQDatZHG9YuboQcud0t82UMKQjYr4NDWGtk9PhFLYwqYNs/LR/U
         H28YaZCRVuUqGQM3e7H5p8K/I9Bxrbwthbmd3LN1W0iRvWMytqAts7wzRsjELPtJ9Y5f
         RV98I/lJwIZbPrQWdaDUVMZP729/Hv2ulNSj1h3IYIDJ+wdbgO6ASGEf1pPcUBhpKkrE
         AG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952117; x=1757556917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYBVwg0qNAIsIE/fwzqPoC8Ske/D+V21MDnSh+sC2qg=;
        b=Mlefg+mnySPFohg8qhw25q3DeND9znmPWRbjKfKnOkPbV64+WI+h26lKIrNql6pSof
         ceMnwFkp4llfhj5NR+AlGtyKCdUIXmjschzfuzN2TgUMfVeDz6LAuI6y5Tt/7qJchsE1
         zRYQLkMhYTnt3G4a5JIB8FnTmu/Z+yRWqEFl3pE2SvsDQLHxiCN260/IGwCmUkfLUgn/
         mUBME6qRLZiT5vUByVwDvPoG/R1GGavaM+bDojnv2m4AUeppiMkEG0ODAjeGL7nZwO79
         1slT7y9vq6c1ZNhzSnVrpTK7vHv7ODmjfzj0orisi5BQxkNZt+FdKrtxUAxnxmABitiF
         kCcg==
X-Forwarded-Encrypted: i=1; AJvYcCW+8F5xrXZjHi5uqEgd9zJhIZZHGBOWrC9QQYdNY1t9cW5l8IUeqIvsef004tKCVDx1wOXymwRQciZGWwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudtsFAzZsl8ZxoIDn8sYOJBa+qV0q0lR9OWndRfQkGuK2m2+g
	lvQZU3hhWXFXYqqynYiIkDNrcGyd2P8fnKfjheeeIrixY9T6H7zsLdWX
X-Gm-Gg: ASbGncsUJeO3yFhYNAl+mOSijVHhByu50iEnzv2hTCkmXQ8xflQcko+NXcwNKagqf45
	O59OiOYaz+RkzA5Yj8fUM5QVlECHpsrAfZy+DD3wd/pU8ux1XXCNoxmRnqUjqUOGe4z3z31spIu
	/f4cXRqtN76P1c9spCSq0H1JXdegXn3g+gKubX4Vj/6RC+GcZFxwbsd/v33KujOzrC09clHqt5k
	DzfleRV1rE0XCY0FtSJHMNmd08xZBeNG9zpY/x0lr2EUMW2xbAHuSgQCwu5o4Yq4dvVELGN46iz
	iNqVpZlvmcVz92isQrzrC4rgy4j96x5NL0o2SKiK88MnF68lAzpA7UT48t8qXoCTt3mN2HpErGk
	fQHOLDoXILyCptHF/xcl1bBMcSA6bJj9Wl6mboIrWC3qb2L1Tzf8=
X-Google-Smtp-Source: AGHT+IENMrBTynZbyGyfB8q+/58Eg0BHsH4+RQH1e3wRvk32JEjJHIa0gL4gEN1SYR8DTi/CwrZA5Q==
X-Received: by 2002:a05:6214:3d89:b0:710:2cc7:83ea with SMTP id 6a1803df08f44-7102cc78feamr216822476d6.32.1756952116936;
        Wed, 03 Sep 2025 19:15:16 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:16 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 12/16] staging: rtl8723bs: remove unnecessary braces for single statement blocks
Date: Thu,  4 Sep 2025 02:14:44 +0000
Message-Id: <20250904021448.216461-13-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop braces around conditional blocks that contain only a single
statement, as required by kernel coding style. This enhances clarity
and reduces visual clutter.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ef9057456768..27be46c11b65 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -514,9 +514,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			break;
 		}
 
-		if (rtw_roam_flags(adapter)) {
+		if (rtw_roam_flags(adapter))
 			/* TODO: don't select network in the same ess as oldest if it's new enough*/
-		}
 
 		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
@@ -2546,9 +2545,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	len = 0;
 	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len,
 		       ie_len - sizeof(struct ndis_802_11_fix_ie));
-	if (p && len > 0) {
+	if (p && len > 0)
 		/* todo: */
-	}
 
 	if ((pregistrypriv->bw_mode & 0x0f) > 0)
 		cbw40_enable = 1;
-- 
2.39.5


