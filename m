Return-Path: <linux-kernel+bounces-732384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BEB065FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8394E1AA21E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7072C158D;
	Tue, 15 Jul 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwmLnEnH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226A2BE7B4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604117; cv=none; b=PWeksJn2F+2BTPJ9bxxPNA6S2X6KkhweWqtR/5gRQEFDL3lxdalTHd+CIbpvn3vZ6ROa5X4hoqB+N1hyAu9BRXFfTgtGnMUMEZHLbAq31u4/2whkgO+orsu3C0HVg8lBflqM1kvxRnJoUMatnmBW2P8wAoWxZTdOyJUb17vO7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604117; c=relaxed/simple;
	bh=ZndwHlsXoOEq87MYFPcyULLV959fWfCpTZu1ZS9F1Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AO5p1+gC6swOzHd+UwMsV211cPg3dr5TLWQvnMV+X/BQ3WHRYpQY5Nk7Rs1Q5P2QfU02pKej7PeIZpSdNuL83w0JrYf51rYaXJgyU2dDWisnmcuLUjVWvcMB//iR2Nv2HeNaCixruK3oQtrGLe2wGYDV/ryVGd70CEnRPu+EXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwmLnEnH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1148531866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604114; x=1753208914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQldTtAKMIQtxzVD+5dWQI6iWAw10lsHzzaGm1uFOEE=;
        b=XwmLnEnHEVRdeJdoryxkmTCgtHTdJsvX+f/cAsf05UMPZYJKSBTRL9zAle34DN/N9t
         T/t/QWYv4TL+ub9Y+nlBDJxlrQNi31Hh6pDa9vMa3zfkrJdU9rNyug4SMq7mbd2vbw6p
         Wg2FJ9jky5qcN14gSI9PpjCXC04CObYg/WLvnAqejVdoHHQpULgQgCyxJMuiCjJMv2SF
         ZKpt4eUkMzpKiVOhC8pkzaKCwCTuHTEa4bEKSfdUpZSoutO+fegbxjQTsl9HHOmsU58/
         CGjOHXFk1mZ4J/iNOyOzn/p3aXY8o52olU7fnLQ0NYMQFwjGGJLbpPBUg+RHrPakGTWV
         FKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604114; x=1753208914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQldTtAKMIQtxzVD+5dWQI6iWAw10lsHzzaGm1uFOEE=;
        b=gL59/MNsPj7I/i1xdZ64YIugDlmfo0Y365EOhqwluKIA6J8vV47IGFvCqjVYaccHkf
         GGnN45iDjQJT/VexNNRY22xVTIVGgVlQk5Tm369AP1p3QeIkRzrU3S93TZt/kdBXnMBK
         Woz+rlzxLwP6cG+vXUz3lmJqaZS9RltpkbNCYVNmFSAH17n6XdxZOYGyOWDgPbC4G9yW
         GSySWZl8yhcWqKDMNYEizyT3pnVppKeXAco4g4grx/uPdLcE3upw8E4C9xFtNw8ZCG/I
         OQQ3udDa9oEIrGvSpRvX2B/zoBXHFR9JA5Mm8Q1/XP1Er6hiNGCJUZXnyEPzTbzjfgYT
         FZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUybtvWq4RyBUUvZpf36hfKli4fFsMVMenQ04XFLhYXodoKmnlnek22yRgxSljpW6PrHWwFtfLOvLsc6EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLZkus90EpKbcFlTB3FSHrLxY1gcyV97qbFF9mzvB/0UA5+c3
	O8Bvysp9bWNMEKYZ6oPV/1ontPxA7VhyZhoYxfxZf6eDvM9dlcKG4xa1
X-Gm-Gg: ASbGncsZl/Pw1iURdCqpn9wc7sfB5dZPjsdk1KfM54/aGF0fZWJkCiftsGk2FHRxoSA
	GGvXNVWtWskqyCewkh1UKe3QYg4GXDtZPnbLXy+xHtM2pOuH4RQbmf+I0kjyJxrep4tTKE1x/wt
	6gXvFp93EMVcGNFD2IM8nOEhbklEM+n6NRkMQifYnLHm8J4j/tI/OL21ivgry5LNJwtNUKa4P3N
	t9dpmRlTAfveq/GcUISXYIE0nVPDmUH9hvX7xWK592U/r0odXEbCNpS6uGy7ys8fpMqMrTioHQw
	IsKcAuZMCjcI+BeWxS7yXRH69pOIhNNknFNpOQug1TC6EDZrxflhcnctmS3Ei5DLH4Nz7eonUxj
	1I4PO0LDhQQ2LLAmIuwSdwhk=
X-Google-Smtp-Source: AGHT+IH2IHr9Qgp69STi9QpDuKWBS9ethTg3YuTY5YBLmdKPPLj0dxlj0qG01IAXsoKFY27yZbY0lg==
X-Received: by 2002:a17:907:72cf:b0:ae3:b22c:2ee8 with SMTP id a640c23a62f3a-ae9c9b161c0mr50161566b.37.1752604114000;
        Tue, 15 Jul 2025 11:28:34 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:33 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/11] staging: rtl8723bs: remove macro hal_xmit_handler
Date: Tue, 15 Jul 2025 20:28:10 +0200
Message-ID: <20250715182814.212708-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the macro hal_xmit_handler and use rtl8723bs_xmit_buf_handler
directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c6fda239d020..11d9b9031215 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1315,7 +1315,7 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
+	pHalFunc->xmit_thread_handler = &rtl8723bs_xmit_buf_handler;
 
 	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
 }
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
index ac4ca7e05b9b..ddf868c7899b 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
@@ -414,7 +414,6 @@ s32 rtl8723bs_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 s32	rtl8723bs_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe);
 s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter);
 int rtl8723bs_xmit_thread(void *context);
-#define hal_xmit_handler rtl8723bs_xmit_buf_handler
 
 u8 BWMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib);
 u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib);
-- 
2.50.1


