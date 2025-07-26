Return-Path: <linux-kernel+bounces-746618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EA2B128FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E51016BCE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685521A424;
	Sat, 26 Jul 2025 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vme20EAt"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF821885D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504437; cv=none; b=F7ZsTUTWhxG32PJIzfhqOVmKJv2gKbs3AYDnViuW3rIXYXwIpwD2bjp8rZjjQpCdiKnypIn+32sbd+tOJe5S+AehfZ9Zo16SDJIGyxqC0qDEQ2gBScBaxJK8g3tG9TJiod/9ISeq0uzvFdEYU+uBRaLoAQ488nlCSdfgJX33Au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504437; c=relaxed/simple;
	bh=WvWtSSG1WQ0XnFbhnhRWLKw4dnXHRNMYRUC6Kw9zqM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZJYszzZGdsJJSHvj99JONWh90vU8Jwv/buUJscqedQtaSc157GKzw/sq1CJmr9MetJMQRrGQYEruuPX0zFLg1Q3Rb1WeXLVj1EbQul02eGiDi4Y3e5q8o4t3KOu2NZGp5Zk6bt6t4x9WLxtNO8VYylPlx0V2vUue9rdHe3nMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vme20EAt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e2c920058fso386257685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504434; x=1754109234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC45lvNfo/ER/85bNnioTazhn/jQr+yHb1t5QvafK14=;
        b=Vme20EAtllB0fD8Iq8SsxE8rV+J0C4zQrTRxZ1bjokeFURXC//SCg6DFVUHOWCKmeO
         z1Se3QSPIbP0AP85hSzQdqAJNeomoYSyWSSWVJ7SBEraz5RWsyRWXIrDHZ8RvUAiIOW9
         PJzCiUVl7c4l5zyVStwb/6RCm0GlT0ZsqP+sppkMIIiJPjEuy+Y8mGd86WLGyXfReuYf
         oeuZaMJYX7L9VcLwwIBFYS2hTRvwUiy9N0n6sDs8upuq8ZqOUwPbFwJHPknx98XoiGHc
         E6XNciBnuRexRINupYrckhEObu/yDEepWjfJPfH10EmJoIn1O08FDUOKFAwVKhxgKxRc
         ZJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504434; x=1754109234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC45lvNfo/ER/85bNnioTazhn/jQr+yHb1t5QvafK14=;
        b=hQq3gu0/SqoFNSGGNCAWcpDoC819qkfPuNYAACtHRYv7VYIFBbvx1BEZY1hpYiMet5
         8W+/ZnMmXMkc94xEtu8rCtPtagosT28mfAvzk29ItjCfWiE/LWVrqgBQiK4HYcQ1zfVP
         CnbwGhin0VcfXstQzKhgBdK4DMcasuIS8HzAAzPspgpy76j9Qy9BT0pam4vvRt0wf7+n
         1xypS1jUEg3nYKXSSz9FvKEE3FpUVsOvUpYcLw2xtnoIzQba4UKe9RWFugCmPq7mCnMR
         S3MRQjTwXpiE47E4FGTlhQjNP7wdeloZ/9mAlWcyr7fVkoYb+7DhCNec5+/qrqGNxpwf
         X1/A==
X-Forwarded-Encrypted: i=1; AJvYcCWsMoHGUONgzwTnRn5w9rgT1s2NoC1278O8dxyKE46e6Pzhubi1367+XciTgZGif1N0ht5VAMpuCxYz8jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPg/lg8oskc0ThsmexcPG0HY6qTQJ9JjMbJvX70x1NHhka2yh
	38I1zTVctS/Kq86kYlDlVLXlEEjr8LTs6NzjXzBYYFOf/WoEJUpNOXowDc/wYQ==
X-Gm-Gg: ASbGnctDhNh4U406ZaF8czXzp2RZ4/4RWTm6PS4pE3dkjAkrEzSVvllHatxvMSsT9Aq
	2fhy2sqfwFl3yJAuHBMul6Aav1AE+RS9WaJZuJrhjBlOGGcUEB5lP74XkAA1MXRcRCGNxvtJIdr
	kbQrl+V2naFmMbbbbHnrSDrymi4fn1QFF2g1y1Fu2rdq0cjiQqKbAdDTtZfzToR0bNQESQgVmpy
	P51SRQafCxUtB1/Zmm76txQTg7U1Rfr2UO5otgSgXFyVG9UJMTXEZOsvQVUv5TGH0glxZRYx5Om
	FeJVdWpOchzQMSElIrDJ7RwoXmP8vQUMJgTn4XMdiDVWoM+d03zXo0LKa9mbILLl3nDJ3m+xy3D
	sFrvScmxiUvEULT6FDgQlCz7TIQG7O59+P3uiIt8SBSC2QXnK+x0=
X-Google-Smtp-Source: AGHT+IHeiQLQMrg9lJ4rQcscOTGZVVaWggM4N+/ThoNuwNXhuqUMPhFd9JyXB0i08pGlDPbIypg4pw==
X-Received: by 2002:a05:620a:470d:b0:7d2:189a:5949 with SMTP id af79cd13be357-7e63badac12mr611023285a.28.1753504434208;
        Fri, 25 Jul 2025 21:33:54 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:53 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 12/20] staging: rtl8723bs: fix excessive indentation in nested if statement
Date: Sat, 26 Jul 2025 04:32:10 +0000
Message-Id: <20250726043218.386738-13-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduced indentation in a nested if-statement to match kernel coding
style and improve readability. No functional changes introduced.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 547734f5492e..0679253355fb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1160,8 +1160,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
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


