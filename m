Return-Path: <linux-kernel+bounces-840555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4AFBB4AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1260F2A56EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD51279DB3;
	Thu,  2 Oct 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt85SkPu"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50D2773F8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425846; cv=none; b=ebJ2sf6fdGvhGw5nrcWVNmKbIyTTT1noryv7XhvkAEd+h9FRrchPUAlcPuM4XSFrA84KseJCUP8/qMCmApr9Bud3ADZHgCRk7lloIB+7En6COUrf7vn4LGku57CPgeGpIZZAYJ7SycMWIrGsBxvyOhR9nC3thJFxIaEG/LLNKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425846; c=relaxed/simple;
	bh=ATTvKT9SOu1K3f90qlHNHHc8Khy2lA/f7wW9AaZ37Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYgyX4g0hSxVuvXIchMipf0a9anfc10d/xAMkuV/K2hTnaiLYH0+uhYj7KhPu7EEwuzZFthZTjkG2Are5yrHVqkQ5wpCxI3s09MU1XCBX61sT9i5enlD72JlD9QWrlQSzW2wsNYQG2yiOZNMVU3kuCxeOiuaoO3j7PNBDho6tO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt85SkPu; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e4f8122660so12808621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425844; x=1760030644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AXYwmv6wCEmhlrvJWgDw3Yc98hZP8kES5b5UPbVfCc=;
        b=Yt85SkPuQQkhSFKN/F84/+RKu2IqdB+sptBuEV0jbv/jRG/VY+cYF7vfKfmCkk3n/2
         Xh97o6gjrGjDy7dhrFszDDsMeTefPKI1aDm6OD+Ic6SnZ5tCBFIT9vWCkYHtwZKmuO8c
         wgJ0hF5B6jZE9TesPbP0ggDGjqRRzEiyFd+VQ+vuEqbf8Zh2pKVGPmfJtXwFRfJ+w3f/
         SFjHUGsKQBfkmXRxLo7NLPwi/aZIAxZU2pPHa+n7sDix7slq3ROPdhoUlMgSyihPC00X
         HpQ8R7trK9rvLVKZr0ddn/bgF91zgCc7F+0zFdCBis07nzCk0sly5b0eoiYQ1eY06RUB
         1BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425844; x=1760030644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AXYwmv6wCEmhlrvJWgDw3Yc98hZP8kES5b5UPbVfCc=;
        b=mfZYSPqtqV7fnBAJM7M2rkh2DMJNcuFbO6nQ/0HyJysv/fdZp/rbRffExsLdsx+zQW
         3ooBFVQain6f8V3CkEbvU+1I2pAcvRlvucLfxLCRDfeLievzKudQEx8Ma08pxNJg7L+1
         sF+S/KqJZdyQfKkOI8vCT98IKzUqeglDPWQS7jkJndoVQE+q2ygprDQHT76MC0DCEOxB
         ZgfpCiLT0+qRuR7zzGUbkuaQtCvV0mVJrVj5Jmos9WQwkq0iHLzlL5vdVLe+SJe7XeyV
         kITLtU4uMgvPboi2vQUL8PTFT5sEWG3cDt93Aw4YMokFl8oZ0x+/aveJt/k6f+gsiMPk
         syow==
X-Forwarded-Encrypted: i=1; AJvYcCU5gLBWEV5tZHynSuEhR+wwYCvUzirj+Y4F8KYO3McSSOIOx8uu2XL/xXnGozHDTVXu5oXOETvdNn71ibQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvY8o4O8DRH5EUGwj4+gwV3cbqMOCaHT+Pb3vpIzwG1M1vDVKM
	8OdJ0ntARfCtdrPqOebmxnnU01yIMr5mT6bdrYVcnos/apxGLJnDUF2U
X-Gm-Gg: ASbGncvZR6jt49bMJKnGG3ksIm/ic8v4HBN+UeiiUkRrPqJunY1xVw65/5ZEx4O4pK3
	VZzaoMfGj6YEokuIjWh4+aaxpYvfUhcpuY88acjKPaHIeFjp9+qVFyCteL0uGCeTyplHQ7xREcW
	xXEzGVCHKBe2d4cK7k0Oh0rOuJxhEHpt+IILsaqoZB5mcg0NxdAU+YH96V/M1uGcWDTrxzPDFtF
	SreeFasA5jT+nq/9mOJmny0S8A8x+LKMG3YxnqmBWDwj5zkjR7DgOvPSUDZ+hiw6iJDnY1MUZ0L
	ATJemhCmOC147gTiYt09jMgtfIrroHxenRlvUbb7P26N3uALTNvV/XZ4o2h/QYD0405nhTnkTFq
	jDPyPPta0PW98ffzGbbNiVajAOhDVIIxcGjylnhwrvYrM8pczxdxb2/MbAkYBNWXn2sgBYBfUER
	/Cf1WLDRUYrg==
X-Google-Smtp-Source: AGHT+IEomTNfnx42+U8ksyK7456yz5jewC5upkUGjz4Pvkg3DTOJTuu9oYqPgnImEhEU3m+EreC23A==
X-Received: by 2002:a05:622a:5914:b0:4cf:440f:86c4 with SMTP id d75a77b69052e-4e576ae9f5fmr1124441cf.41.1759425843717;
        Thu, 02 Oct 2025 10:24:03 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:03 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 09/16] staging: rtl8723bs: fix excessive indentation in nested if statement
Date: Thu,  2 Oct 2025 17:22:57 +0000
Message-Id: <20251002172304.1083601-10-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
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
index 5d31684c7cf3..34fdef878b51 100644
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


