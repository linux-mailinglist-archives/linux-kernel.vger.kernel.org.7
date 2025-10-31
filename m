Return-Path: <linux-kernel+bounces-880049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E79C24C07
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE418949C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697C3446CA;
	Fri, 31 Oct 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsKuwkQL"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46D306B1A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909457; cv=none; b=DguOVo+DR41m3wk97nU8UKJ4bOl0luAHsbnePuqfcVP6EhZiNvyJKrJsyEq1qXc6k22S/AGFyXTuC0FM/3LKKkOs3lIrSeIjPPG1zavYVKij0cOqhaMy3oIUHFEP16UU55+PsMPjbiYAFTdth/gOWiIa6OkVmcl0dTsELYjJPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909457; c=relaxed/simple;
	bh=rCLJ6hwa9Lj8OJwfpuGfm4VjzDMM2/dDqWVI+BgYPmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq0lkLimwa8bglDZh7jajInXMKZg1F2UYI28NnmHxvsPBqsDAnfsx8dcHcnkD4Y62l/faxtYS8iP+j/O6GCusEJhruhvtzvJyk0woo2bPbTLJImSNz9rmtTAxF+z8OjhkKus1ODSd12xtyAc6iHsiek6b7jvYx9JNGYzH9a2qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsKuwkQL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2483308b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761909455; x=1762514255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FW9g8tetROcy3bzpkRVbdV9vmDjQkA5zzLWmu49/bA=;
        b=gsKuwkQLNSK/gpFijuLadkyGIUOeXMjjNdSI2E1K+UNoNEf9V5uqbVqhZ0KDQSPpnS
         WGLWUBPntZYTwagF5mo3+6yooQjYe1orGlZxEtFYi1siQ8ldAThNH6AVAlBjQ4LOWFrF
         I5vRVczBp3gpsHzLwtgc0teIbh3ooggHaSr1ylwRSrvFrRcwcBO92pPs4h1sJ0R53e8p
         cT2BNh5Z0c92lD2qCnyiVyX7jsIPtic1prBKvrBzzHjTZTrjWgOP4xKNtt59pKKtcPIx
         ncwA2/X+954EGmh6cj3MEgA0+ozhZHmsyYuw3cLQ70Sf5w64LsAQSwaoSRxi3/5fkY10
         oe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909455; x=1762514255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FW9g8tetROcy3bzpkRVbdV9vmDjQkA5zzLWmu49/bA=;
        b=PxfN5PAepuME5kt4mXmhHmgHMjxLuIC7HK25RaPlllgjs2P47SZ4ccxOe8I2dQzz28
         d84Ckk3E2RxWm33iSUiiqVTt6yoaBWGHLXI2xDfNbuH46fuLyZPqStl5ogWLUUduUPQp
         ofALEjhQjKMtV2pgX7YO50n1zBrV+SzsfxtA88ODJgUz4szdlguiGLqDHSuWYQ+VpZ26
         0o8HvsBrWftsps8gB0TcCEXYAr1ruzNnVxHQP4f+asu6j4qbEhmcuSoLsTXVSMvQEC07
         rmQueI4yOHk3jP2bAFQEKvmh6wr9+8KdWdpKnKNgBpjmd2ugk2+MWeo4IfS7RePc36Zb
         7i8A==
X-Forwarded-Encrypted: i=1; AJvYcCVrZX32LIRczt0JVYL7zRrJ6kXMOxmWWzO6eB0Dk1Bbjq9nyqY0NiFfgJKJckANWLxokZdXftHcV7urk6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45XIQwvaOk/CuLmgJrWULsU23Aj3RGM1nhskXXdtBf0vo1wXv
	zWVww5CiOpn28jSnIq5+zzBuzkA4hkyGRvfDHpirHySJ6klrwEx02NYH
X-Gm-Gg: ASbGncsrTBHPKsxHZbD9tLYF0RU3kJvRkGhMt0Is/ivzf9LHmzO0cur9SNKXiU+pWY/
	JZSA5OHyP7puU4HFmX2N2DfvoCdZrRSo4nEGKQYUGDNsmTjc1Aozbya+AFjtVYg1rwcqo7vE3BC
	H61Ce0PRrlvc9omPXhuNI+RO2AtUg/61gimgFWG1Sz7hxKC4UP6WOggwbyLYDuxWhyiabH/pO/R
	xDiB59QzdZsfXLA9UKVmDOWcw5yKtzODp8i3wJjxsOKnvXijLBLwc38Qu6dln4zUtG2GEsNCQrQ
	5uydJc/pRw8DaIr6Plv5wYFyry+CcfiNUPZiIdjG2E5j9lR3UZImDu+4Dx2/wpRErRl/g2E9J5F
	RtnOIolzPhnLz5/mk6pXJ4rCnu5YOBnXm363a8GE65Ih+26T1qreFs3csdL8jqyqQQqd5xp9PW9
	L2660bUDb3OyEXU0o+PGu3Tht4XcYG27so
X-Google-Smtp-Source: AGHT+IFlhnYfXMSj2T55Ss8vnR2jwuezLPVcKwc/QgNEa6eU9nUkToSG449YGCbPZeDNO/OCtRrkdQ==
X-Received: by 2002:a05:6a20:5483:b0:32b:7220:8536 with SMTP id adf61e73a8af0-348cad92443mr4451995637.16.1761909455133;
        Fri, 31 Oct 2025 04:17:35 -0700 (PDT)
Received: from tpp14s.i.sslab.ics.keio.ac.jp ([131.113.100.7])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a7db197366sm1896707b3a.46.2025.10.31.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:17:34 -0700 (PDT)
From: Hiroaki Yamamoto <hrak1529@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: hrak1529@gmail.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list
Date: Fri, 31 Oct 2025 20:16:34 +0900
Message-ID: <20251031111641.33653-1-hrak1529@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BUFFALO WI-U3-866DHP (0411:03d0) is based on rtl8812bu. I locally tested
this patch with a retail sample and it worked fine.

Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 44e28e583964..2769b86ce1b2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -79,6 +79,8 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFFALO WI-U2-866DM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d0, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFFALO WI-U3-866DHP */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.51.2


