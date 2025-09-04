Return-Path: <linux-kernel+bounces-799735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAEB42F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222C07C1913
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6A26A1D9;
	Thu,  4 Sep 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnxLuV56"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218BD1F874C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952123; cv=none; b=lUBU0cZnxgUHOrvjJGe5ODEzPIZj4jNa1jm6xcR1/aClcv8AhV4KH7JSZjZtukmZcGe5GyhBBpKH6/A31ypieIMrub19mhfG4yOUUnjdJpU4RqCegeh8W5pSFTvTmd+D8uO6+2jGTrZynZei7MdwCthMyRLaG+t0KGjj+dCkXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952123; c=relaxed/simple;
	bh=jBqMxmVAmMDEYYiw51Q/Ns7mTaKe1/YemzM5cwPGyQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1xDNZnBOMP3wcTtZRlJMs7JGjY+87GxCnoKZiqqje2b4g3FLFr/FCiKW4EswFv5nGAGUPLlI7eib+v8hsmpUGsdN99gTk8EfJO9EfUBiky79gHT1pgRAF3/Ih3Z+UaOwRFWcwRlNvT4hIU0/TkgWv866Ir905fdjvjHB2M04Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnxLuV56; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-72374d6a6caso6108146d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952121; x=1757556921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z93vsxuF9UuLH4nsNHNXy3fXQ+B/Eo/YGql6jpQcpLE=;
        b=NnxLuV56VUWdoA1vZPkv1jai7Kr+UC48mjtBMs1PZmyRSmpADaQmcSkgmkfO3kagon
         97HkRtLaJNenCldzxRwKrAwLGm1FM2Nj0843bTvkuB6dsf0vQ7WD5ESAwFh0DdjmCLTw
         H1EAdb2fa5Qowxm71b4Rf1CRrp2RwkiYhsGSuQ83XJhhQZ0qAvFgZ5arOTN2v5W8xFNX
         kNItRX/gj+R9rj583a6KeHZS1xf8Kg625hXA2OQhp9MwFVqlrozbsptax6ijm1bs3/bM
         G+0+A7/NGE/19mfNp3ninhYwyZSnSpFqv6qS22hC15wY6fclkta2WfbdCr+Gdb2bGoHG
         Y9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952121; x=1757556921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z93vsxuF9UuLH4nsNHNXy3fXQ+B/Eo/YGql6jpQcpLE=;
        b=qa62jIBd7J81zfzAENOQCS6/HkfSoNjUGkVmdkQ1uztlgUuuYEpDGgIM1C/U+5fDGP
         8nfpdCwBCf2X/0NF++KdPWbateyavtBahbSHHObounb2gpfOC4SbLyqmsSyO5akyI+RN
         eJBOGGAYEX1LL67wB2siRV50kBPsc+y5jDOIxDnI31+c4ouwEC6pj5z6/5FjbEFp7p5I
         Rw3nkAk9dsNnX2O+Eoju1Oyq6hgQGWZvsoRBY0YqmaQcAD7V+uiPfdidyBbqxGOIZa76
         xvZMSPIGUzZm5odFvBCOjUQK+DBSZ7AfFyiGrvn4xlUShTJ9d0BzF7+IcehzguxitCQm
         60nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAICChK7ubgc3d9Jmg32Xgd268YYiqP1WOxEUeiUDiRTLqoyPydnRbeaU02/33HcHcqKU49qro6+Ve1cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuGegZu4FiIPDgQtjHavIciPVlYCF3oqCmRjGfQN6I2/ZDa4V
	VXOqIqnDLV/385tsCvwZLW+zQRfrHueKOpgOsV5zq4YvdU5fYEkmoLi5eXDjkg==
X-Gm-Gg: ASbGncsZAJJUk408j4GnE5MvwOnBxndZk8zrjenNYsg8xeTWRLpS2ffuKLIPbjpBv2M
	bUdvT3FfJbpZ0suv5nAI+6JaZqy8yYVJQ9A4cHiu+Yx84AyB4LQ7VZRmbQBhIPFfOUhOvfc2osL
	Tfk49f/7RPX1Hfo2IyJkiEiypn7Zgd+r/PJwx8ROPaHrniZ1kjyqPCbfg8s+8r7SDJ0GvP2DOuR
	TbC2XNaUpljbdCxhHYU9p1JDk6U4JsEmhYttlDGnd5sPVp4zMAm+JssS8h5PoKqzQYpgeB1O2w5
	HpFeo4BDEAu+k1UTcOQ5XwyzmyBWsTTNcj65k1M16dv/kCnxv0KMaazwqMBxlODNOzuDvl1vf2t
	7pUyTKcJsuhNszShXWgebQ9ZncSqDHCiMR7aDXDXujK7lPn+eBi8=
X-Google-Smtp-Source: AGHT+IE9l+VNwTg253DcVZl9r1B1XEzkHxQ684beQjKzjt/9e85EwGCeLnyjO0W3FlXMfGJGDUhNkA==
X-Received: by 2002:a05:6214:765:b0:70f:4416:ce2c with SMTP id 6a1803df08f44-70fac8940a3mr206043676d6.40.1756952121055;
        Wed, 03 Sep 2025 19:15:21 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:20 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 15/16] staging: rtl8723bs: place constant on right side of comparison
Date: Thu,  4 Sep 2025 02:14:47 +0000
Message-Id: <20250904021448.216461-16-vivek.balachandhar@gmail.com>
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

Reorder comparison to place the constant on the right side, in
conformance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2c34b68f1d60..80b4dd1e8353 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -775,9 +775,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
-								&pmlmepriv->assoc_ssid, 1, NULL, 0)
-					) {
+					    rtw_sitesurvey_cmd(adapter,
+							       &pmlmepriv->assoc_ssid,
+							       1,
+							       NULL, 0) != _SUCCESS) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
-- 
2.39.5


