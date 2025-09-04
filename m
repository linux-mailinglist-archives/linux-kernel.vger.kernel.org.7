Return-Path: <linux-kernel+bounces-799736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA9B42F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A322D5672F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E19223335;
	Thu,  4 Sep 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpxScZ0l"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9B261591
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952126; cv=none; b=Tkzyh+ivCLdp4NsGrZHSfe015dqvRtY7Ox64U+Wnc4N2izutNsno+o0diMQLh+CtXkbmSNIJIUOAwpkSoIZFVAh1NqRXCvC0oiZ3Apr8VePU/0I/SbeUBsbBuhE/GBB/qOr0Ay/24D6OVTs0B04L1HGmjtCBQUrpPq1fzVG+5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952126; c=relaxed/simple;
	bh=1L6YyzW3erKcj33GY/6Si2DL2c5yax3FQGavbAJ0Bgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHsMobtFv39DHXDHqPDVDgn1w9sHzMpWa4Ha24lgn+Hj+VFPVE2wUhmDdIDBEhfBFCZtRk3WGvcCmHF/ELvwcOp3V0YqcKQAg359tp4Wj0Fdiz251qBu5uZ9OkwmRMM0V/4xbvNGVYnYYJareA4H38WDWhi9T8GuZ25iYh4AyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpxScZ0l; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7220d7dea27so4219406d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952122; x=1757556922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d01B01AXVKk9If9XJH5GhITUvVOiKXQj/np/FqkF0PA=;
        b=MpxScZ0lakn6M9yaT7anatQ4skwq7KZYX7kWPfbtadch0EUzOpl1ec8le5NuobXUW5
         kKkn2uNFypjYcb8fZWXK1NcDkOdk2MgBl3nK7yRSX1hF5AZvpuLLVLqzEasPWmWtVyF6
         Z8Fo55JIWSLtRGo702R9i8q+V6b8m+VMKHrtVVrUiByfOpzeRdDyAefAfTtOOvo2p0VR
         52nDza8kfTAoILtbUIcfsLNmeanCzeEBhSChNeZflnhcuXoCGrV4CwW+LEaT9IuMXLr1
         Ux2llrbTjCTwoOgS49wUxsqR36OJ3w1kLlVhqNMjGxZL7sC3BlTKG3WlLC6xJpP8AMHi
         arlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952122; x=1757556922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d01B01AXVKk9If9XJH5GhITUvVOiKXQj/np/FqkF0PA=;
        b=ionVFwP5C/nfcjylKcwoEOSZ+DGcA4r21jzz6nAdGnfG6w/O8kQP7LkdBkFlgdEOd1
         rdMF8HgCQ1dbrnQk45+uFLMNtCjNPnjF+iDaRQgxDindoujFAzQwY2NWDaZXQg7q06jF
         xnMTeT+/esTWF1ljiVImFCK8EQB+Cw7e3cUIcTcYSPqGXk0jzQRjzQgqYw9gR9BTAtTl
         SHNT8jJE1UIqyAH0w9oVz4SS/MIkC7ql6qug9giDav3/PPEQE9Lfg35EBnAhWkPbhsSP
         SUOAi/5cbYXpgn908szeJhmVKQLxHjpBSYyjSoG5SYre3u+t0b7kp2CFLxqnrHHADhf2
         2zEA==
X-Forwarded-Encrypted: i=1; AJvYcCWefuGe2KNX8U24lbpecenqnp5/DH0JH59pnZjw0eAzv4E96NLmue6nAajDQAWO4dhPyqzXELdNV0rskdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNxsYpq5WErVNArMIgsMInBQQZz93v4h90NQknSqMCBlP/29h
	L8Jv3bJYRRlI0Ea0MrzYPX8ikpDvKQX0M3JwEOSxg9wZ2GOPaGgcFpD8
X-Gm-Gg: ASbGnct65lDlFv6zKO6r9bXWFiP8pQtJskSGh4Ce4TEYJyUK9GI1jnoSndzyoQJ0t/H
	EqStXW4EfPyicCxVnRdAV1pcLmzjXyqMO6ZKSXiGLAqaRcGt91tD2QpwJFsjr+UW2/YNTMKFw2u
	s5zh++8Rpt5dptfO1v6VdndZRAFtzSIrOZ7WOIJEubUVx/mjYaR5HCXWayZyhw/uYcETIg0M9ae
	ZGZlD7gN0QjPFwOLJ35HBAdv3+kGfJCTIvcd7bafjsWtud5UrQeIz/mBpNdVWEzLJ0aAWNWhtRF
	2T2HaRZbxd1LKZqGDkm+vjJzIVIPw4LwR0moxrzt00zySYyvp13oSYf8iAj9gNcmlw5BE9ELTJv
	TwjBP+7BZNpWbD0CxkQkYrBTtrmi3IgRgvjnfxDdbZsa93KkclQhVmu8LeWnPltnfBFVgJni/
X-Google-Smtp-Source: AGHT+IE/tUJ9vfI6aUgaIW4xBiaNLSkbKStwg2MrLA4uw1dqu7ZuCFfGQy7h0tzdCA+NyxZBtJEgdg==
X-Received: by 2002:a05:6214:1945:b0:721:812a:e6f0 with SMTP id 6a1803df08f44-721812ae721mr104620036d6.38.1756952121976;
        Wed, 03 Sep 2025 19:15:21 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:21 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 16/16] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
Date: Thu,  4 Sep 2025 02:14:48 +0000
Message-Id: <20250904021448.216461-17-vivek.balachandhar@gmail.com>
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


