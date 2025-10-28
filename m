Return-Path: <linux-kernel+bounces-874419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64236C1649F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311993BBB82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8834D4CD;
	Tue, 28 Oct 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="VF6Ns1kW"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18DF34C9AB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673437; cv=none; b=bf1F94RN6ZqdUGYLU7mNSq5kWgsppsGefvYib3gHIu2LxChULx7itrfmgylWGemvIHnLywrugHn7iX55HfrioGqZftEoS2d2u+5PLwXojxPvBeCkemCW+klIfCbpZSisUszCuNfEILzGjm6E7uj6owy8YAyEcE9dNYOubsKEK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673437; c=relaxed/simple;
	bh=0bwjpb3oxZU8XGM4NxNdpBSzF6jrx93O+BlgTEXd45E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJSXtRW0opBSTvnAe1/1DhDFwj50uBeS3I6YHp58TjvzkV6ea51fKDscj1wjaaThJ9+Z+CR/WPwFj14MKAZ1ZsFoKsw55G4VzuVnOaafMV9XYMXP7ZPhuvyw0YaIOALVUJ1SOBPEDPfBRQSMOwVNxJX1nqbIkPSeQPWKMkBqtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=VF6Ns1kW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so6012654a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761673434; x=1762278234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0qpkbmtmAPne10NIF9Jum+PYmUB8FRAdbJ18tTQPmQ=;
        b=VF6Ns1kWQErCawMzWz79FnujoEvchjAM/2WH60PcreDrAAC+NRmzRi380byQH5k0k2
         MRd3CLgdFURgLCdYQ20k9VsoqSFwUtrPonO847ArxgP95y61qhl62OHHAmwU/DFUnued
         P4J3T9cDFprxpS2OsGzPNw6sWz8KUAMfPIc1Z3krQkPjqZ74+p0CWYzo02E79ld0aFAl
         LAw48WyDLrKHYgAeHAfiaVYqVJvaw7IhoShEKBbTvVfup4TIFBgjQleqVOcU57nRfhnz
         /eThJnsKIq08feVDza98zsKw3UizxcV7p9VILEoCNKCkCzJ+LA2HFwX2GSxVlASuv/Ip
         cYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673434; x=1762278234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0qpkbmtmAPne10NIF9Jum+PYmUB8FRAdbJ18tTQPmQ=;
        b=O2SyPAFitoYs597bc5KIirzyhlrrD2pmYoAaAq8OBk0o5SxSPU52VrfJ38hbb2tsTQ
         ahbtFEkjyEdG9lZxan/AbxA+FTyLM7HMbr1divczJaHtfakfsYyePevEsId/iuUECEIN
         H6eKgyiYn63Qv6NGyitn8W4gOMDblsoCwx8tnkiQT9xoF2V0zEXxkW7J1G1N4kKaHnjN
         Ok7BUJrvYCNAcsw55aUhQEcCf+Rthf5hHAMGvBx9MOSnRUkQr+9ljKhZANHg7G64SskR
         9o+CuGfQDxkmE5bnSu/bhwnSNpO7ydApT48NbsX4fyUQ4+hJWRlLVylf32IGTsrxDRYs
         XUww==
X-Forwarded-Encrypted: i=1; AJvYcCVjFWiNYCdyJFc0Ap4/A9ejiipiO8c/Q+IoPg+eEzpqhgc6QY29laFJfZTh3hsEON1yHvjSzYTFHRQjjpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR72SrehEbQms5wh3qwZRRHnrRygr5Wyb2SRoKdQDVXPvSx5Dj
	DaQmXslcVRzOPd7krWG7//cHHQxP5XXA7LhSwJKzZ+qgqBulPwf5IK9kytUSNwSuRwQ=
X-Gm-Gg: ASbGncso1Oc+uydA/hroQaIk3bl+EhQNDhiRFP1pMi+hFZUPFH2W0KBH8s3icRhM2qj
	OMsY7I1b4ItWPt5CHA49TBgfvn7tmxb9Li0i537ZBSAbYV533KMX23KdSoFN3aPudgWJu7AUEOQ
	dzxlfUDsNm9A6wYlqH4oNuh7JWh0F8yh1uLR7czlXvV/yvr7b0q1nOrRnGfdHqv8AwtgdQN2RtS
	3m0GHD/FUOxiDPkNGl2tceT0ISDbB8WY4HzSZjiCljnMxAr3WQd7Qf2keRCPXL9J0eCcE2iHZSn
	UMAubC6LR66JhESsqlBMhNMXf/y5V3qQxU2U4oaVMXMZP5BLfjkTua4aqqpGe2i+57Zrhs2a1XT
	S8cbZlawWRMSgl2h4Gej6ScBIArqjwO1CASH+vkIXee0TcXAHnc/akCBBG4zLYFN7Na39Id73jY
	PNhU2RuFibnmdLusPTXAS1X8c=
X-Google-Smtp-Source: AGHT+IHjSGUgQEqomu07pS1jduR1pgMItt8Lc6mHKJe9u9dK5Ny/DjdsS7jZxwcxklB8xXuRkgkFpQ==
X-Received: by 2002:a17:90b:58f0:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-340279e5f8bmr5853372a91.7.1761673433797;
        Tue, 28 Oct 2025 10:43:53 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-340292c0d81sm1560989a91.3.2025.10.28.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:43:53 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linux-wireless@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()
Date: Tue, 28 Oct 2025 23:13:39 +0530
Message-ID: <20251028174341.139134-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for urbs with kcalloc() is not freed on any error
path. Fix that by freeing it in the error path.

Fixes: e85d0918b54f ("[PATCH] ZyDAS ZD1211 USB-WLAN driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 2faa0de2a36e..8ee15a15f4ca 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -791,6 +791,7 @@ static int __zd_usb_enable_rx(struct zd_usb *usb)
 	if (urbs) {
 		for (i = 0; i < RX_URBS_COUNT; i++)
 			free_rx_urb(urbs[i]);
+		kfree(urbs);
 	}
 	return r;
 }
-- 
2.43.0


