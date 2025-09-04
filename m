Return-Path: <linux-kernel+bounces-799673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42DDB42ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C537C42BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153D1E1A3D;
	Thu,  4 Sep 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1/2M190"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46531DDC23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949359; cv=none; b=cfV1jRkMXSDD+SXiNWPlRuZ2Qa6vyynlzLuVgtgNyr59hsTiQOwrrCmCFDIxLsDrslgHC7CkJdRg/FpThexABOMG+qQcpCalc9qNNY86dBsBDdr3wbHlteqZ/Ia0Xu1/4ZIC5pRXZ8f7b++3faazu+u+O6OWC9dpfbVOQrONoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949359; c=relaxed/simple;
	bh=VNfrpgpxpbyw8ERke3BpjHKuLSWG1u6qfMBqfz4ZVu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEU1tTh6l2V5wtD8b7urbymoeNYfNCXVUn/fBpR+y6tFkobOMHX6qNt4U6Ljh57RiShE2/in+PGy5KHYNKeUA48S3h66wjcj1hx0Vsj9N/KSrFsDJjlku73n1H4/A5ZQ2J0a5k3PfIVRXopXpWvbQrmmVTsp35rmUDFY+uR9jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1/2M190; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b30d09dab5so7438611cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949356; x=1757554156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYBVwg0qNAIsIE/fwzqPoC8Ske/D+V21MDnSh+sC2qg=;
        b=Y1/2M1908E+qi6kJT6LCQi6PvL5FFSfRcgsYnj+k5XeyEZMUBEEUukG/lWrpSFsjwt
         nZehLGJJJNo8S77vuTNDWgewUfuhTM3pgTKFzuMRLW38UApDo9tY3T5RbcaoFkdp7+iJ
         Zykrea/ggp1ietNsI+K8Y23Ct4Z40McG/3zn67BUaavLEd3YZlxUUxsb9uRe9DOaGtnI
         5cmyXAJ9C7IPxeI/oQiXmc/ILDT/s1XKE/OpK0BdsRlLDb8Sg3DEkpYFiaeabxJsd0+I
         JdAVjKNv2ObPv+6AcAVGxdWedwQjFqFCFQfl4oFwkJhypYHc7i4e48mS7pUtr7VNm/xk
         4Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949356; x=1757554156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYBVwg0qNAIsIE/fwzqPoC8Ske/D+V21MDnSh+sC2qg=;
        b=AGZYQZtDht+P5Tu3U43LzwRYEm5IinnUTVT+/pc8W3LVvGtlQiK7YXFhAkpQAiCf6Q
         9im2KLoskyMjyvky5unLOGxIXtCHX+jLASn6AAK+WCgDq3ZTASbJvdvgY6VAlLtvL9x4
         bG64ML7E1Fad7ck5EPRy9OaGz6thJ/bMf84W7z0EEfzHsoOg3cHsuo9eXwNpC98owk72
         KvgDWzLoZFYA5K3q+AUd3rm3kHEle/X5ahpaIkkgtQiDvtb8NEnO9KMLPzELYFvZU6aC
         0KaDninsoaLz01hjuQuFDno4DSjq+QFQFCy1Xsywh1oLMTlUXP2wq1ZxbmFZHIVuDdT1
         XDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSlsaSwEUm5f2y7RO6mxPrxOoNBzUodXhlHUvBIbsNh5XaMmGH4sRRiuQLh1MI6K2rz/Sm0okas4RmdKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhN2BgvM8I5OvoZZZQ8SedvGyXuqOLFFNosu7ksieiSCs6+f+
	Fs56ltlOCWDlzpoEZwKnMk221v3EAG0X9oB5dvMkUsjLSURlPxsJKEQu20a5kg==
X-Gm-Gg: ASbGncvueVmhilFkwAC5su6WP1VauyGvsp9y0uLUsh3pDfhePMRAbWEY5YgNmvJTsJR
	CS0yy0qcmC2Cm4QXnyaDLGmyty2HLyPtJOnYZNiZzB3n/m4+9riN8BfLeylJ1ur0CmyFTn6I3UN
	hmxF18eimsq/jjrCT9QVE99POnr7MQcxs4/9VgWv9MUfvk9Z6o5ucU+u4aFfR5PiWV8YeME7Gwq
	w3il3xdxbnJr/uqfbBVepKTMPpt366bgE4WtW/Ul1RjZoSKb+t6vBKEaObbxqRwkkQDekrfoRkb
	dG34ax/6VahWJvh9i5SmTPLZD2pvSkToO6T+EtQu7JVLc3YU+e3EffE6gogdEzQVEOlqmBrCE3F
	X3z+oo1i6qPGhmPnaPttT7TH93G8fdIDoGw0mi8bB5cvtBZUx4JCzEJh0lTrppQ==
X-Google-Smtp-Source: AGHT+IEJYaFPK/iZ58a14wwtY2v9YBfzLVSz3C0zNtSZ1Fq1cnoSwZvA2/w97/vlw5MYkIWhKT2jYQ==
X-Received: by 2002:a05:622a:5909:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b31d8a3aeamr195370551cf.26.1756949355730;
        Wed, 03 Sep 2025 18:29:15 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:15 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 12/16] staging: rtl8723bs: remove unnecessary braces for single statement blocks
Date: Thu,  4 Sep 2025 01:28:55 +0000
Message-Id: <20250904012859.215565-3-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
References: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
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


