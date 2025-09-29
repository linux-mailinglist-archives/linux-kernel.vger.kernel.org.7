Return-Path: <linux-kernel+bounces-835844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2807BA8311
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C262C3C3E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955C2C026F;
	Mon, 29 Sep 2025 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Sox47H"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440C2BEFF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128651; cv=none; b=Czt+4IT/4EsBwiJRgSmO9F0MwpUcY0pAuE6QCupQjGW1Wmp4hgdS0H+zG5pnxjTFXAZgPSZLx2JV2MCazpkygDPBHYwrrtnjXqfn4xSGzq3P4erAJY86ZZbCDRew8rUddURluajhtsaR20nG91S/bTdP3FruTnUVLCsF8Z22icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128651; c=relaxed/simple;
	bh=8er5g/JdtGmDLwAxnKtTLLBjMA31RvembXwPpxkN0eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfDN884eP0NoHIj5X1hZ6zuFvzcc5MOkqusA2EGFOPVCIFP0ft7xrqiHEO5DtzRKWju6/b1dNkgzaC/T5SPImd1b01mBsFvt44Dtey5nU7WkEpJPKfUO5pKozAHBSB0zWgRhaVFDNOTaV00DuzRon4KmY5H9wPC0srhSsUORLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Sox47H; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4d142e9903fso28349251cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128648; x=1759733448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=m0Sox47HtriYNN4/u2r5nS9NDtwZLDtLGpkYRfl2t7XY0yGOnVloPIitxeCGUqaent
         Q4q3Ox1fqstrAVnsZOr7RhgJSeFVBnQ4vhhCAOtgqPKrteCRM5rFGEMlhj2EWQK/HcDx
         MxN0E56JATHtUQdpwnZ2ASAnmuOgmeanGMn1fyYFbHMopY+/Aoims4anOHBBtuK/1veC
         KhhIdRCPMjyaXaiaM6UMkeG2IJh/+2x3rnyK7UbrCgjffk7Nrj+Rsmm3dkEHHlEZTnyp
         c4rYi3k1We+/TYYlcONEeg8ng+17g26ikXJ1r5bjqAggPzq7DFWfyLb1CYbu8TiG9Bw6
         eCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128648; x=1759733448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=lWX3Gs4bHqJqfgWHTCEJwoH/UsMkHTl0VZ96QmmhyN+6HLg0++n5xRdoauqZ9puMFQ
         IkPPaNoAF9XAaMBQ+og+BuS/b8PsJtvonJdJU/Werj8mheRwGmu52Qh/KG0pCJYUX2Gh
         5kXFtvD6OzJuWCV2XLBvtaS2eOrsyXpjaY/FJC9gwfU0hXiHTXjBDRyaBiDn0X3J6ucX
         YCLnu8UshI53aY+gZn16ZnUvCxkRnnJ3OzyIcFH2FKiBcYR0vRbpo4mkISkP84HGkncF
         tFMp6lLX6b8fd4NubkH0OoD0/FJIdIEbQ7vliJCYoq6Lvl74Z43tufbZaEA462fABLyX
         MoDg==
X-Forwarded-Encrypted: i=1; AJvYcCWGyfCoJ4QPyHmsSUcq6k6pR42l3Drm+kz7afOeU9S/XlFNWMvKHlxYTP4cCfVfxqrpmG3no+qEuB9SHRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgdm6M8N1TXoql8nd57lWmD38isTCjrfuWomX6nhZk2RBcDgFH
	yz5TS6gJClnV6ZB/GatpLuEcOayPEK/l1uuBsZyFryU0Qn/20NyD5EIF
X-Gm-Gg: ASbGncua1iGHIjvYYFo376Frhk9BdPFKfQ+6EcO3sMMponcnfzFWAlh5/6vHKcGZ5Gz
	5up0S0eSBjsq5NKOx10AJtO8FSSmORmDMD/xx3dhwOjrupkehFQ4vv9yT+nQmJABueY4alqTWPY
	h/2Rt9CjOGLpEeXdjOwqWdndtDPoL9VuwrrAzxZFWgidCsmt9z82yv0KpcwB5ICGtLGCOyWwsax
	LCtOsAtffvNxDZMrICVJdG3lowKVoFEJzPoepKtmRSzk3Sjt0bLKic7tMEZdl5F7Tevw3Jewr3O
	kZWaOp1bjRroJt80zLII+sK1QnO791Xh9U5Rs3IOLd5IlU2WlQMtfrBfLN7GzHUEUrnpwMbp0Ey
	o5iPnb1kVgMM/5EsvLJu35mXrIxbQR+llZBAXTzx0yCbXJD/UHqg5MBn6lwWz3g==
X-Google-Smtp-Source: AGHT+IHJDdHmmS3a9PUHcJC4ws7x1A1sX+MEycaSbINCX8m8jxAVL3NxscjrVx7k3N22CtTBeQLfiA==
X-Received: by 2002:ac8:5856:0:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4da4735508amr200457451cf.8.1759128648449;
        Sun, 28 Sep 2025 23:50:48 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:48 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 09/15] staging: rtl8723bs: fix excessive indentation in nested if statement
Date: Mon, 29 Sep 2025 06:49:54 +0000
Message-Id: <20250929065000.1010848-10-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust indentation in a nested if-statement to match kernel coding
style and improve readability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d05ff073af2d..a2b1e34765ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
 					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
-						if (ptarget_wlan)
-							ptarget_wlan->fixed = true;
+					    if (ptarget_wlan)
+						ptarget_wlan->fixed = true;
 					}
 				}
 
-- 
2.39.5


