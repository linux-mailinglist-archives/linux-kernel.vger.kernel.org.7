Return-Path: <linux-kernel+bounces-799729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D3DB42F91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2A51C23D43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520182356B9;
	Thu,  4 Sep 2025 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIuebuWi"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF422129B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952118; cv=none; b=AYFEdxMt18uRBB/Sk2ilZ7RE+MMDl48X6kAEunnSzDs36/DTGy5SDQp8Uv+SnFDf+23SftY3NuU3KcDQF9xT9b9vw2Rlfasy8RQdNTXwLjuqPbaj/VvUWHV58RnI6V/CdGFmcWjAdMP5WUVd/kyiFgBR3/+Hgls65LrKO1sqhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952118; c=relaxed/simple;
	bh=8er5g/JdtGmDLwAxnKtTLLBjMA31RvembXwPpxkN0eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1ntsjmThUdv6bx9CBQdkaTTxV424o8LGoWGIAHw/PK24Bl6D76Wbmn4L3Pc4vKnvHII1uc59PxY0DB01/Qyo+iTaBVACx2LSj0qbL0vEBmf9pAz46GBB4T+02zis23iD6HFXdmmjfRZIaOhP2iTcE3lUP5mj5rxjX3pJZfWiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIuebuWi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7209bd264f0so18527596d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952114; x=1757556914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=jIuebuWiBYbWtCD+4TGz99cDPPpo3q0MOnGot4jSgLm2mU3CJIT6A9tsUT+sRBh168
         dTbdXVRVbdQ2AFwabgTkh/ddIK2InsRcbPcIUF0u9KXKnTuPeRy+v6fPKkIKNp4Fuyxd
         6SyMZMWm7ppvs+RmtNizHO4v2rZ3/3t6iReFBZQbNZ2a/TGNoRWxNyJ0ljprzkW+nUkS
         1V7G31apUH/C0dwK/LOMRVxRsC7+OU2MQNAiMBKRz1G9okyHz3IsTN9PNsu+mybYgouD
         vE5G9QT49lFLX7cXaUNfST/rhR8OSVskXXMaewfSGqrpvQ91pQqnoLSH+qioWQ7ynrgK
         wxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952114; x=1757556914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNzQSvDGcgGcsxPnJpDh3vO9RZGdTNfhmCnJqVlYiLo=;
        b=gTsc/cy7zXy2i0GpTzUcA2vmbfqYvQcO7bNhRjug+XMv1/43s2M69deHXy8aUbzX18
         cOwv0u6Ditzsn0M4c2r0VPT/L2+dW/jxM7aVWsUACO+vAWAvIZro5D0ArfaISA8Q2raL
         KrO0+dqemwHzvkGfExXkw5HrHBqkD5j3nJLzd9BpdvKPBZbueCPwnW+qV2JxsRwzy45U
         wKRshw9dk1RP4ZR9BBTRn43lmHAtgERwKiq6irbR5nWRBJd3aDizYbezsA3/e0B1POZb
         /7RyLNbw/rPJKkYrWMlFdwGAmhWsecUJlIpavXdxWPETUKKANiRHsw4GPH5IEQRJwy3+
         CqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEJXhBqOwahKWJwbqsRM9oYa6H1cS8e8eIwNGANBNm5Zh2TM7yVpaN6Tm/2kZWofeiOGjFIblhLMeqDV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtS9Hh/8+XvAICvWMVIPCDW+q93kL6+ttXoEPebOC+6shSBxB
	/d2JslRUKPISq61wqfFJGVhIfSXD055LRvrUiELZPCZIATMb75FANKHy
X-Gm-Gg: ASbGncu863fCEw3DPAqsOoIKLBA42gpzG6HBXdEGWpEEzF4EdyOmxVMSF0S4D5zDuLn
	Op+WgBGjSlIbo+kr2z2nACZDblaNfr7ZlMlYHsp2cyNUctZUPdqGe4rZ1SJMSRnMunyjmc7AoWU
	0VSDJjYuS83jpBB2L0P4/aWVEV8OF1KzO4AprGXDlZQorewwoq3Ot9AGoAvAgiP5iJftbysu6A0
	mFnV2CbtGW6q3bMdN8M5UEr1n90AFo2/uCaBGuKMDLIbjFkQGcKyN+dg3EsLMTzHDlv0uwR7a1t
	lIM1NRQfC/bT73Zib0oY7iVY71WGrU5ZDm2iDUJ1tx6S9eIvxpTZbWWib4vsTv0itiXmVRb4yhb
	nF72DUsWs2Pyyo1J5DKJ5HRqJ39H+u1k+mxFPo8zHjxyMNlIBYo0=
X-Google-Smtp-Source: AGHT+IHo7xXjUVODo9Ez10j7toTQhtdvMKS4OhVCgEvCdMIv8BCF0VAwky/AFMCNc4z/W12P3DF9sw==
X-Received: by 2002:ad4:5c63:0:b0:716:9f19:88f7 with SMTP id 6a1803df08f44-7169f199f20mr209931666d6.4.1756952113683;
        Wed, 03 Sep 2025 19:15:13 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:13 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 09/16] staging: rtl8723bs: fix excessive indentation in nested if statement
Date: Thu,  4 Sep 2025 02:14:41 +0000
Message-Id: <20250904021448.216461-10-vivek.balachandhar@gmail.com>
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


