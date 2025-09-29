Return-Path: <linux-kernel+bounces-835850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EBBA8317
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CFF189C2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D52D0610;
	Mon, 29 Sep 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikoLRbP2"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B12C2368
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128663; cv=none; b=k7EQ/yOKKXaMIchrQpFauLp+s6bbwowBxKKKd6kEph6wSQKHgMmM0JPQO9wX3zcyXlHZP4v0qkYXMdfR3KuQtY3k4l4ftE90G9FAsVpMITewHQAEppmIU+ZEoB8igtttZQekitqMTGUhN05O7rR1BKbwlR/mrXbmIAaOhzsFHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128663; c=relaxed/simple;
	bh=j41yExCsKaaUjcSIHJe6r3UBHZsX2oLK1/XLveL5/Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPa1ETEoOLB57J5GGuL9C/1mDkf0wxVtONIlYm+IYGThBTFXR74i1Q5BCRwRx4O+j9c1OEuL1ArCBwPLIKQgYjo57IuNDwRWO3cQKPMSnRITDchsb1QhPHEjciVupmNA+gLjk9I6ZMBXwux00i7PZjO61Mdy5Fib+YqZ6MnjF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikoLRbP2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-858183680b4so577807985a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128661; x=1759733461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PyA5YFgx0PLE3LSarm56xsDTtWVM1hBOP7X/Svx67I=;
        b=ikoLRbP2uWTw4CaP7PWIeGbeUzjGUNqyEsHI83mifIxDRBeNChgfKO0GcPoUO9hoSK
         4U7GYNFDVSW9xDkImKNTXaXwGh+V3HCl8x/L/bCs/s67u8Pdj9zSfwBBFZ+9CNHH8PRU
         cPINpyXdot3SleBeKlmrPRvi0BwOl1fPCa4jTRvr2KbujJabnmBKdiV0ooorBeBsGl/e
         bv0/555jrLRXO2zEV2yxkfmC2g7pul/KpyhDM4fEgX4XSYgahf8PZ0E90W5xCbfqG0Ab
         YLbWP7nhLkKSjQaRfGPDYU/IU5e8qWbwv/UoFpNmpoDTgkY04vawza6S4XvRHZ9mpMT3
         FOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128661; x=1759733461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PyA5YFgx0PLE3LSarm56xsDTtWVM1hBOP7X/Svx67I=;
        b=vWw+eZ+wq/mXzdQoDrZDR+WIp6fSlCej0pwzJ8UdldWTfwk/dbmX47qF/uc+H8kAZt
         MxsVzLNL7gol1nl6KiBxmgoLFyrtLjP231/rFtWyeTxWRXm1AB+qqBSVs1rUfrgBjw32
         Jw1+WVwOf3riqAucqWP22LYrJLwkCm385e5ltabaur1OQ6PyNnARwdSJksuyQDdLmt+l
         LVnrNhJbQW4l5Je76rbfLzBOU07KthnLZ39YZkVukcE4a7unIVGp10oTy9FB+ienrnCc
         U11/zlXc/kMlnWP68RCoqvWJ1DiAd8TeQ5HaFxgksoIPZ6oMSCB4UmAMACSc4aC8dWae
         P0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUxbSaJd46K7CEWWHGqnzFBZ+VGLKDhPZD+1F6aBfn7MwO2YXgaFbx5GYapth7BpgMJSdn7dfuNUt9g0pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++Ts3AJ5YF99obEWEnqIv35teE9LR1WXOCis0SuRYJRxVBUL0
	b9MI2FMc+MUrHY3n8PJV/CvXwwLberMTdvpS1IUJBBo71IASG0kWphZp
X-Gm-Gg: ASbGncvej47c7PGe8qNmDOTE2950TjzQUMGP0JZC++iZusaJRvHR5pp23DGVoeZDY1h
	nJUAtbKrEGGn83rRzls7+4DrC+WdhIFHmduQkm7knysOKS5QGIXRYM8RN13/C/h01NREDUPpzeZ
	I6DcTud1bga57tALaYAwMnoKBcWXded4iX5w4rJQJ7xlILJYhVBetlZWbPs2eVPDxxu6Iw60Z9L
	VDZ+3PbZWXzsLmLHYkduiTIF/NZ6Rf3WYXchUBxOCRJoxRxjHuuN24NgGJonj+4YsZ+NzW0x7XI
	WHc8WCyM04N76B7LosC6sGuAHP72ms2MsJcDLKc41uhj5Q5bC5Nv6huqGf0vM2xW5J31ozqRVR9
	UvlPMcTJrKXpCsvSEAI+uOHLjgbpX1WtVNUnCVJPy5TqS5mAqj2c=
X-Google-Smtp-Source: AGHT+IGVZ+6+uYWljd9/v1KclebPlFys/+ZUCb3LCNXleY/oBGrohXf0aFyBGBAY1P3g3+Pj/SY/3A==
X-Received: by 2002:a05:620a:a498:b0:85d:aabb:47cf with SMTP id af79cd13be357-85daabb5028mr1185750585a.9.1759128661026;
        Sun, 28 Sep 2025 23:51:01 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:51:00 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 15/15] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
Date: Mon, 29 Sep 2025 06:50:00 +0000
Message-Id: <20250929065000.1010848-16-vivek.balachandhar@gmail.com>
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

Combine nested if conditions for clarity and fix tab indentation in one
place to match kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d9483594afdd..56fa51a7774b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
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


