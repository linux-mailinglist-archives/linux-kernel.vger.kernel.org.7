Return-Path: <linux-kernel+bounces-840561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E47FBB4AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6B01C2C68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F32882AF;
	Thu,  2 Oct 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itIqJK42"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49314285041
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425858; cv=none; b=fRBuTWSHfce8BJURtFlkE0GwF493pKNcP0Iqw25wW/uOad6Ra5qngMjRCsTOlcVLIidh0/dAgIfDo6EkG22y2ZkI8lYNYKA2uI4mgBG5yJT6MJ6KxIeqG7vYPrF9Y7SICueE1KOVsHeBwu+5nUwJnuNbBqiuZ4NiTBcRdx1VXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425858; c=relaxed/simple;
	bh=TnKLTRJJ6lErK4Ayj/2b3UMGvx3XBSAiFViCHcE3muY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjVYWy3jdycOQtrnFJZ/vfWqyQ7RXeMCqxG3GB18t+2lwIvORJRcx52l8L2nZvGkXLhjDYEJsav0z85dxsXm1gg5OVaRLmtKVdiRmCxeUbN+T1PU+NGyshyXU94DtybynXY1iu973jjizBvnxZE4ZrbS9gvi98B9NJUydWO4ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itIqJK42; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4df0467b510so17253111cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425856; x=1760030656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YZZsnVhuRhLrG1wV8qp8NzWiX9JVa/qmSszT0l1J7A=;
        b=itIqJK42C2TDVGiOUQlBlnm1YcKesikaRFOSxTq3T9bOsEUzBxaHCrrMeqnxO95EyA
         j3A4GQW53Xc/s+419v2/OXqztZqEJj3i6GmP6sQxsIMBFK95GhrYQxE8jzVh2scW8Mxe
         nzM8IcunA1ieVyduQCbZF4zi6SVbS5tBgAB10da6j7q4N/GIveXHI9qdM6ra/lWH62zs
         aG31WvgcyX+lpZm+FxuLzmIOF5VCPhMvM9mKFOB7vbXGbF2zsZjRgqe2iVbDYzrWyyWU
         p1Sf9y/kaX5+vJQFqS9Ly/znt5+aMjpbh1TExHtVuqK/RiEQEe/9lJ5IAbWTl0XhH84b
         CbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425856; x=1760030656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YZZsnVhuRhLrG1wV8qp8NzWiX9JVa/qmSszT0l1J7A=;
        b=r89Dg06KzaKS0bZFJFyn7+aT1SG1DISl5l1/fVmlqWjkKqdsU5sOIXk/cxgK2L0Ed2
         elx14nfGkb/bZgLy2ztTG3zInT2LguBm9zRXlr+GmOdQCCpjI8CW3OE4dLMI0ILHJM7G
         kJ+lAvNpge4bazZMXj8GIuPouVxR9FeT/qXvFUdhn5RE2eONXmq4lxcG64Yt8vuJfmeJ
         OoNu8kFNwy9m7r/TleMdWKABNaiRZk6weZ5hUeREdXXCOfCGPZMysPpdV2P9lSWli0gZ
         amYNMk1n2hAW0KUHqO9Ym9ntm8KU/WuzltfTkdgAmhS9FcmYSXXzWxlktwGeliZhpcfe
         uijA==
X-Forwarded-Encrypted: i=1; AJvYcCXAUVNC1iCntpUocuODu28G4+2fntFY9aY4ssh8255DUXmrI2NtwEOYHbCREDB8ZnKIe3AKgRuUxkpXe4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3nHgR6VwONGlKV5jJIkwQWxG958e05WP3QTmx2Y+HUC6UWfw
	Ip7aPDCP9S5zpe32B40VQdSh4Uzbm01CnQoeoktW5JdZxujsgnM1LHKO
X-Gm-Gg: ASbGnctabyNPaGoQ/TZCi6zcOjNhYif9njC+fRtokyE0qQ79/TYkG1n1MeBDuQ11Itz
	AHCqKBt8rgQHpTaa4zOgNrRlUFbN2kbt/7VcFU0n2LSVVzJZcxy0iQzBo3irjrDnKLGwfScR0dq
	WkB+foS1iJMMAvbg7AlbS0dIx1Q5I7dKcWlAhfbxGbdTZTUDUZjgsbWEfaykzQMiuo6EUBLtdtx
	YOI+r3PtxpmhQYoz0/MawbPc81MZyEYtUPBVdsnlOsq3pkJOwrh1q1YJy/kqlexnii3SJz9a0tL
	PnVaWPxb615r7RJBf+1k71yvcyZytXvzkmZY5KMD0pSYUBv4XU7B84k4hJKrhGwjbng5u+GkW15
	Uy7zRSGgsP9HsuUBCe++z3acc8CYfKof0WVEdoPzklqH6Izfa/qwrPVdKPe8dtt00k+FXGVRO8M
	M=
X-Google-Smtp-Source: AGHT+IHq/nu6xvYLrVY5dOYgmICAlKGmpDqj/EFzgjuYKt3fMSL5t0Ss5zZJjr2Z3fnSAa2wSTIJgQ==
X-Received: by 2002:ac8:5744:0:b0:4b6:373c:f81c with SMTP id d75a77b69052e-4e576a7bbadmr1431871cf.30.1759425856102;
        Thu, 02 Oct 2025 10:24:16 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:15 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 15/16] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
Date: Thu,  2 Oct 2025 17:23:03 +0000
Message-Id: <20251002172304.1083601-16-vivek.balachandhar@gmail.com>
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

Combine nested if conditions for clarity and fix tab indentation in one
place to match kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index aa842905a467..f17b16fe8819 100644
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


