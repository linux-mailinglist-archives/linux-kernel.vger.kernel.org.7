Return-Path: <linux-kernel+bounces-799677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D4B42ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BF33AE629
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABC202976;
	Thu,  4 Sep 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL6XZtOM"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE11F4C98
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949366; cv=none; b=TE8n/gUYC3EyJYeOUNllnXV2TWZYHef8uJm0qYXzDZ9W5uYoyBV3aUHeDvNXYyZcg+I+HSQIHrZJY7T7q3f8n6ETFDM/7UZf04xhjLvgsdQYQsiuAQdpAccN8oP7J6+fI+Bm1XKFMSt1c9rbo7YyufsJuGwbo/qeieLlJ4GoPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949366; c=relaxed/simple;
	bh=1L6YyzW3erKcj33GY/6Si2DL2c5yax3FQGavbAJ0Bgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOFzkEpQP5Okm0u/xLB4JN1ABEnrQGKpeC7a5xvUEHKIFH2LzK4d4ihxUcA2tClthnQ4Wu9/Auq4stJ4eVumyi73eWfL5ewiTuFp+/48M1mwCRLXd4CPESrl0sF8g7GeX2lFwkHe7W/MRX21x5WejHp0L4MI4CV+eJ7NLM6mAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL6XZtOM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b326b6c189so6886921cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949364; x=1757554164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d01B01AXVKk9If9XJH5GhITUvVOiKXQj/np/FqkF0PA=;
        b=iL6XZtOM8Wsy//NRu3mNhLSiKL0yexB3OdQa6XNl9d4PM2fSTEheu6htJDgX0uUtg1
         PRXPZoEBUFPpQJE9iX4bIRnaOuOVHquQxI2Yn5LIY7kTa+TY+065fnQ0Yyj8w7u/ynIv
         54vZT/k3zcEZZKF9eVQgA41akNxyyy1pvH0Clljcr+nMhI1363aITxRxfRewmcHxERsl
         cwXYfdGTabknQE0r5BTUjg+qRQSul9sP9Q6GZq58U3FORRUXX+Dx7NRUTUxNTtnmzZDX
         ZKW6bOPRcKOLUbKHsm8gKfLfYvNXY/2kjagKhE/Dj5sV/h//EaQ2piDYO14y9PUU1juz
         +Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949364; x=1757554164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d01B01AXVKk9If9XJH5GhITUvVOiKXQj/np/FqkF0PA=;
        b=fk8L8WxeFk/IdCPD13+17TFYOyW2AogvDYvfdCPEJc0P3Tl1saeIpNABB5rz0/996t
         11SV05A12MSCDtFARMjOYz1haEG8UgEE0lCqFAxv2AbHjqrNvlB3IEM5VPZbg3i79I70
         /KX2m1WM49FyzWdA9j97yM+2mfNavRcA6DWhntKOFmaElYyg/ezR6dKPygVBXP28ipcJ
         IY1k04AumAA1NzBf6oTdjkCv8MaE3DvaC9/CunktRprIlLjyrMlnbYkas/zJedBGlW1H
         YWCCmnIA2zn1hbJ1WTAa7QTo7L7TGMFo2pn2JrRJ71RaxxjUDDeq7GHP4kZhPMcnob49
         6tHA==
X-Forwarded-Encrypted: i=1; AJvYcCVRS/Pqvvdosgk7/fkAv7SnGKqI7DJSmXLSPua1z/Sh1gt9jTLFKucheZPtYLKXNZfz9NSWBZO6arYuEXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgoGe9G9SI6zemPPvQRWyZFLTxF1HJVP8JS7yF6xT4s2VKAGNQ
	MbKFxHCPZ/pI0EhVECv8Xg+4OVPZWP4IM3eXTRbb3ITyf6y4PtFBUXG3
X-Gm-Gg: ASbGncvXUT+HU9IdfLoFUoCgj90cYoeTpKeREFbfuxjmdaWPdwOqtJBzEPUlC3raoPE
	T+mjY57gGUBCDhyJhEWlzEcolrjWsUpaOMzsurvsU8jFOKxsRukBeTorEkXx4Ydk3FqoVAGi/cc
	J808kcK9NZYNsvm8ut8sFw6xkLTYQR48njGafLDcxKT/W/Nc/rmtHEnsWcVAiiyM3MMq79yBYJJ
	aUCTaw+7jnLnde/CHlvPLEsoYhFm5nhecM3GpslYRro4GJSB419wXqQmFxwuKs2XTrsM6MEABqD
	2aHw+lsH8WkIqB/PUqiXtF+rFhb9ZaswB/B2anKrkMdtzczdEAOiEHhnmx70SW8OgMZte1WQC4X
	uAEQRddmKVQ3B1kWzZl5cAyDjC/6nPtxj1avVujVCbF1NUAkdQxM=
X-Google-Smtp-Source: AGHT+IHDNa7ZJksOVETNfIHr60YU5IWFtrsWzQgmzDu0ISrjUT6IbIEYQbo5/u1SRfpfeRz7Z/LlMw==
X-Received: by 2002:ac8:7dc1:0:b0:4b3:775:ba3 with SMTP id d75a77b69052e-4b31dcd0f3dmr218186741cf.49.1756949363780;
        Wed, 03 Sep 2025 18:29:23 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:23 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 16/16] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
Date: Thu,  4 Sep 2025 01:28:59 +0000
Message-Id: <20250904012859.215565-7-vivek.balachandhar@gmail.com>
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

Combine nested if conditions for clarity and fix tab indentation in one
place to match kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 80b4dd1e8353..4fbb180398b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1253,8 +1253,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 						rtw_free_stainfo(adapter,  pcur_sta);
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
-					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
-					    if (ptarget_wlan)
+					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true &&
+					    ptarget_wlan) {
 						ptarget_wlan->fixed = true;
 					}
 				}
-- 
2.39.5


