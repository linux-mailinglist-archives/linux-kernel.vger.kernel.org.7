Return-Path: <linux-kernel+bounces-844015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B11CBC0D48
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C96189C992
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0BB2D7DFB;
	Tue,  7 Oct 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+mS8is0"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B62D77ED
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828424; cv=none; b=gFDszzcgBnPhT/ZDiALJLpckfbGTrL3UEVDd4eS00Uis0DuJoJooEg3faVZQ6y835A0UEE78OFOyLIOyAUctvp1HjYlPq85jJAT+1tSuBf4WYwgSeJO/dcpM0SgvU3/GF6MgKU10Fqo/y9P4eQr4BtzAFSWwIXrPw/BvUObPqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828424; c=relaxed/simple;
	bh=W3oQ3to+FMnGQ9BafXS2UUWpjBiT0ItRQvarpFfldVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbRD0cyJGJQbTv1XapbvZEJqMXFioKWcRGxANtDRPEg9twuODAxf0953nx5oYrlN7aDYxLXDIxmtUoKPUhkEhRCry92lRZ5wOjGky7rIPbSVFEMp3bMaYB4GWIbL7N4GxidX6RQx25nFGHb1thz6YPtbzUJc/4cI+GowzQFRTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+mS8is0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so7700901b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828422; x=1760433222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok8Kw/gCdmxhaSwkgke7jAlluYrp/WVGFRTxV/5g2XY=;
        b=k+mS8is0NomKrAlp70ElHt6j77GPwiGGFx/lqXXfgF10PpSrdGtEgnvj5SuFmVCeze
         urqG3CbkEgvLGebblKCXeraijcVFmqNCVZ7WiWATkp6EjjgLvrvH9kpIR9ANDUNOnaEa
         fCAG32JMBQtgIcLuZ8wQNJNiaWQEddXI+lOo5TN+52ax1hEHNd0g9G+3ObIn7VbMHLqC
         9ipWXl0iC9iK+u41O2SMlLSvrdunGqs41HrtXJd/j9Pzez0fD8m8uBdKMLvWiuTIjJYC
         wSd5pZW2aDfTBaEO306NQiiVo3Ic7uT7N+5YBI1h/zWLekDgdvSlfrLuy3EhPpQYMd6G
         ZdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828422; x=1760433222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok8Kw/gCdmxhaSwkgke7jAlluYrp/WVGFRTxV/5g2XY=;
        b=HfFGBePiyqSyTq5LNSvKlH69WRF4orQIbJ7BqJBaZ76ONFletBbRWlDYgRioAixgPg
         7kT1NOSNbjMx2Jb+zjDTT3GAT9u0QLao4FSl9AeqiY9PaQVqZ6oo1nbiPt/mZnbggICg
         HHDW//sjMzTVbVJ2oauMj963+ZBHMgV0CuAWRZaEgjnH0HKzduJC3zcXudqwWdiEfjsR
         ikYsP0TySwaUoqDBvdxiWovt8/8B5VQfrlWbrqsLKSl2jEibehBRa0soVofxyQhRJMoG
         qP0+mJG+RuWNAUg2r2YiIHprH1IsjHXrXJfj43q+yh1LybPk498VwXgZkjo6/QwiJiwC
         mV8w==
X-Forwarded-Encrypted: i=1; AJvYcCUGSoXSTXUmfMk5ojAzpX/GegVeJhzSMihyCZPSCoKDR1chQbDONshZSXKevTVZUtxpboyZO7AQgNOnceo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2m3JkcqVcMe2SE8BDSXmh+LHi5Cw5y6I21yf/ysebpjIqCkLg
	doTRLXthLwsmkP7ta+YKX6JrkXxEVbKxNDgA4OeJ7FLz/v0prkHbdxRz
X-Gm-Gg: ASbGncs5Iq0ovMnyEGtNKQ2fw+zL7epX7k/Ac8oXjQ7bdqdoLvcAGKyxxXHCAvok/JK
	aKXHPWd8e4ZtKRv2hHqISSep11KWojRYUUGWwPAtCGyrL5zGnzaAqgDnHSKdiARq++66M80hCmv
	2hOciw9AYQcARJOBg1fiif5APp37jIvUcbAQvAmhiAj5qTjqBsYihUR/wnTeG7UWhJ5VcPwl3BL
	t/kmUw3uwGzoFUIGmVVFbF86uPxJi1UIS6UXKspsq6ViSBJxc1xlVEZx0A76+oq6z9voFv02onZ
	2GGqLJTFfQAigQz0Jifpd5A0PryXa9d/DC8emHrf3CaCsvCEcKny5XrmVyPv6JTqI04QMXeLzrS
	ZW/P6uB9P5Tb4mr6k4bCRNTRkAxeSNrlFIRTgqiLmQg8vDkQAMAJG6DZxcH/T
X-Google-Smtp-Source: AGHT+IHTfTG/o9nNH2EXHwmE6IspdXH9kK4au+zeXCw0++u3/oxx7BOX5ELRWAH42ociywdxWodTYQ==
X-Received: by 2002:a05:6a00:399d:b0:780:f727:7958 with SMTP id d2e1a72fcca58-78c98d32d6cmr18866770b3a.7.1759828422376;
        Tue, 07 Oct 2025 02:13:42 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm14941784b3a.13.2025.10.07.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:13:42 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH v3 5/6] staging: rtl8723bs: add spaces around '+' operator in rtw_ap.c
Date: Tue,  7 Oct 2025 05:13:02 -0400
Message-ID: <20251007091303.491115-5-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007091303.491115-1-trohan2000@gmail.com>
References: <20251007091303.491115-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes instances where the '+' operator was used without
surrounding spaces. Kernel coding style requires spaces around
binary operators to improve readability.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4cd9b7a74313..121b9db76711 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1445,7 +1445,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen+2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
-- 
2.50.1


