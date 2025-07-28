Return-Path: <linux-kernel+bounces-747548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09282B1350C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FFC3A8A87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AD2248AE;
	Mon, 28 Jul 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSxXmx8j"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E50223335
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685024; cv=none; b=vGgCZPOELgtEUVoFpA9F+NBoJC54/SV147hXjIGt3AvKzvphkvKKgkBZPevOkY3WbzL85aKFk6DOXt62CGZlRiNiKZc98kmIrbB+yezg0yDkIQ8An99LGY/Hngksx/loL3PRRX5s4h77cSY4ZgcVvDHrVxt1Wu1nxTkeH4yl2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685024; c=relaxed/simple;
	bh=ICkLCQRNWkIQwQfoaVtdgQfsexMdUfuuMixiPal4tgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbZSzpqVoKN6IwsLRszU++Z0Wrw0plA6DZpHme2Wu4ZsQNvM80+yOPoxSPGzn+1huZLh0h5aD+Y0BeADAeThlHZXaapZi/lIW80EyXqphc1kiJFuwR4425klfnT9a5rbv1+d/QDh/i3qZbn1KPTXHFn1K10EjbWYG/mfI0gTPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSxXmx8j; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso36532426d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753685021; x=1754289821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5snVPivmEg3Xnsr7kWQ2OSaRpjExflTHsvK9SmeV5Ic=;
        b=kSxXmx8j2xSmRidEf8/GqImVz350BS70L1CZX85F3UcXXKq/aD2Mv41whv+vYQw9Om
         Fh6mAg4VWX3ZCT1HKJ9rIlU1Q0tYQn9tDdgrm0BJoJcSw/+XKXHMJwGYs0R0kCyYISnR
         7YAsRkjs6QmMl6Q1yGwZ64rmpZBuAiIrRMJtCU9k24HvwYpCpqpR/LMGXMoy8jny9k7p
         alnMQWYGXTtkqty2+stSlSBzb6ku2cCXswBOGk4BCCw4CvzWLS0ftdTEmKTl/G8IaKqq
         Al9czjTs5hiv9GXugT13gPBmRGLqWx8ExA7rJfiHe68zVnCV4yD4rvoRhP9aLWik/Jv1
         rHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753685021; x=1754289821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5snVPivmEg3Xnsr7kWQ2OSaRpjExflTHsvK9SmeV5Ic=;
        b=wsj+W8y+I3q9WDoc7KvXhPaMoxUeSsJ4AbPjO5gKyKoJfVJMjcLt6ULLKsbI+Nyl6T
         WVOJdDIMFLSx7sT0SEdDtJUKE2mmORomQS3yCy7gXjG/f1AM6y1l/Me8uwAYtV2T5fdZ
         hMdMXAq4lXHw07ohKHZ5TN8rsqBBRucW18lLE5VWnk+HqHEv/qUKuHBCQCsUwfFZGo3Y
         +Iw6TH5jblfZ5LuvGvqS4OS8kcZVzM8/rlPCHH0VOiu58d1FjyiqNeje7CshQ4jTEaB6
         0vuaO6d8DoY/UEseubUAs+ob3vZgPfqoOg/r6Dwu87GKqPR26kfggL+PHbWKM5EMUjAU
         pxlg==
X-Forwarded-Encrypted: i=1; AJvYcCWaJTXH+useSyOQWJT4wDbdsH+7s+c+7q/WNvv8ZrSZKl9c+rmcdVc1LGVKfMb6h0lU8Bd9rm4wJCb9NAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlNpJUEQHumKWF9Vmq4feK4TEgp95NRkBq3N/vNfsbNhfWxMp
	2ajx2mWcKcNE6d8gj+TqG2fPoHtEEMEe0oSuvUl1py2ZUWSEws1SB5Rz
X-Gm-Gg: ASbGncujiH7bNwMN9qDnoe9riCpJJ+iMwudCSUdB+C0wS7mnhz8TP3myI0i0hV6OL6e
	MRtW9w+gO727+ASOESp3YF6+IGp4Vn2B/0QI+MXlFSA5BJjCct7LcbrqBlew45DwgQvuSsmnsAr
	DUSdZ7BqZ3n6L+6Ss6zbfdPCgxM6sb29n2qV8EY8e8Hf7FKz+JJaXhdHBbYhbX6HCTKz5vLiONh
	Z7WkkaWUjzPBQnHjoyPEDcUh3brhbvAKg+CkYEQOYT7ZUWl8mghROZX1G9EBiofdFLURUJ7OOul
	yieDZ2BJYAEF19uHUTYQoLWBHnOSquMW/pJwO9bh+B9/VxWhYTO9mkiL851/jR6HzxvyiFy9yFX
	0UBkL45rXAtEMiSBXSX9ZtqBYcGmqb+Z4Ej0nzm6FZEShvk6N7uM=
X-Google-Smtp-Source: AGHT+IEXelpE8W1diOtr0Axo883c8NWykGxfuDdek6Bd2yUucxkYmKbL0ViQNXdCwhj+pY4ZUFOwUg==
X-Received: by 2002:a05:6214:b6a:b0:707:4c0c:5316 with SMTP id 6a1803df08f44-7074c0c542amr21984906d6.46.1753685021058;
        Sun, 27 Jul 2025 23:43:41 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c15a4bsm28349946d6.60.2025.07.27.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 23:43:40 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Mon, 28 Jul 2025 06:43:28 +0000
Message-Id: <20250728064328.423024-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728063510.422849-1-vivek.balachandhar@gmail.com>
References: <20250728063510.422849-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed superfluous parentheses around a function call inside an
if-condition. These extra parentheses are not required and violate
kernel coding style guidelines.

Cleaning them up improves code readability without changing logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

v1:
- Fixed incorrect wording: the change was not around assignment
- Addressed feedback from Markus Elfring.
v2:
- Mentioned the wrong version number in the previous patch.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 3702d7e7a954..d845eaecd615 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -700,7 +700,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


