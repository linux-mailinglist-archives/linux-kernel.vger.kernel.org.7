Return-Path: <linux-kernel+bounces-746962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8635B12D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3248F7B03E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554917A309;
	Sun, 27 Jul 2025 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh8XEbgN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EEEEC3
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583525; cv=none; b=A+k3AbPO5NVAQQ4Dzyi/9b6eHUFV3RX+zlJ1ORu6DUl16qh3lfkgdgmSvxZkYjjKoBrexq6KCjBpW0sefhUuV7TxPn2aAU0FIwzGANladVowJS9gFX4ArHKipJnxGeBnFxd/ykeeYONSWB8TIdvvQNGi4eUPfPKVB4iBwPrpxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583525; c=relaxed/simple;
	bh=5zH3r3EFo+tMewtNWfLHlfSC95jMuMyOjqY7TLVBrYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odrr/oNHd2BS6iWt6cvfSYv4KZz2bJxIC0SPT2JR2sYEqR+NBj0Mw2wsqBZJlExfegW6gRyJZzxVgQ5Y3xXHVg+vBYJcCeQDmnoA5BJclaiLrGnm6H2UO9OVonUL+EwdlkTx3wUa8zlPanMzviDzBUY73zoLXWkKBvyS/MrkWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh8XEbgN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234f17910d8so28833355ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583523; x=1754188323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUxSWZSvuSYF1rtOH2W8n/wcUgp9pVxNin8aUZqTXdo=;
        b=Gh8XEbgNJff0pp/qJy/Tt7Dxb67CZ0U3rBaHvRlyGgy+2/BTpfFhuyNpcHxTsVbQMA
         lVz4zPd3tB7iexiRwuHgO22CZXIhijbOy5YqOeSbQa5ynHhPGK838T63gD28qcA+KMqZ
         O4Y0dty8FjzL5y0hT+Kdvqs/N5E4wrxvVNMgujqJU93V7/DrpfMPnqyzXEG2laTxvGGz
         yaJcmPfqib+75u2QRxRUaMcO6j3CjvKNHO2Oly4JfVFK0Dc37YiG87gv9l/G8dEuM0bM
         vffsUo+Ba1ToaCU6gmyWMqaoZgZWGaS/awCElw3uT3ZmR+X8WUd1pf27VK7pL9UraEOD
         0mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583523; x=1754188323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUxSWZSvuSYF1rtOH2W8n/wcUgp9pVxNin8aUZqTXdo=;
        b=JiMntN3QkjckkgshfjdQDuLzpVSLXA9++cy87g/Yi5p1KuOYDRmNyWYxb25bXGXIJs
         esFFzYmWltEVlxZaijR2AMwMHkw8ilWbFdnMjl/cIbErCTydULhEdBQhWH1gP65LzWps
         chFlhYLDSgiz3izvPFfv8zTX9hJ87Tkmefm97QhyIzKfV3czBRBX7utngGiiqZfc9NLd
         jc6sT8zjegA4rCXz3LlBV4zCFIGLT6eX8dIX5sINvYsnrsC+ioX/rGIRFysDA7fO5o+m
         oJVnzw6FXxLaylVh+hS7LvuOkngXnkL8NVGRb90VZRaUgdVqar9ck5/98Hl1x1G9mhI5
         FGaQ==
X-Gm-Message-State: AOJu0YwCVZGJtg8Lto8s3x+RXhoOs1EyJIj4ZvrHHzgrT7Zw37zPKixs
	ZL/4wm1lcgiFAv8VTArVOS3Y6gXZiMp7NABkhrLdG5J7QyvVIrhjDUHF4dmK1N1F
X-Gm-Gg: ASbGncu/2Xfi6BO1rUB5xPQ3Gf5jSd/OSJb5/zfhav5eZfd0OmeBC5VQ70yPXJE22gj
	5TjcpSaGp4IzqVSjLYZeJ0qEqvDA3694nknD31QyrcnueqqiXroSu6PwzNRAfKLsGsSrDEMpbNF
	M6jtK81TMYS5N0T1ZC3jTkfHgZhgLhUIX1t/sf3d+SJE9B9kynBdAMurlyLN/StqYuTRNs38hqK
	Vfx23xJZmj17kC9OftcvOYOOJdpuR9Qcz0vRQTYP70ixcjj3zr6bh4U9O3FHQ0qbpT+4GPix6hc
	m8f3M6bfE9esAfaeraHkYMofHLq07yCsjXEfpkZELg5e0AjfFPeLa+ApIJa0/rv0Nf3AzWlUqcF
	mFW/o1TZ4haIhhCSCCfz2hIOPGKbLfD8k1vdtSHRvzSt3fgSjFvG4x7N2OwPHcKiPC5s=
X-Google-Smtp-Source: AGHT+IEJjDB72AWfgtdv6VO4UmSxv/5sA+qKEToHbe2mkRvRILHZUa9rs/5SLQ/NesYrqYYmBbH6+w==
X-Received: by 2002:a17:903:2291:b0:240:a53:dd37 with SMTP id d9443c01a7336-2400a53e1bfmr6575975ad.21.1753583523251;
        Sat, 26 Jul 2025 19:32:03 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe5eca766sm14485205ad.211.2025.07.26.19.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:02 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/net/wireless: Fix typo 'neccesary' -> 'necessary'
Date: Sat, 26 Jul 2025 22:32:07 -0400
Message-ID: <20250727023207.82674-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
index 8b6352f7f..dfb6273ff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
@@ -220,7 +220,7 @@ static void _rtl8723be_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 	    (ether_addr_equal(praddr, rtlefuse->dev_addr));
 
 	/* YP: packet_beacon is not initialized,
-	 * this assignment is neccesary,
+	 * this assignment is necessary,
 	 * otherwise it counld be true in this case
 	 * the situation is much worse in Kernel 3.10
 	 */
-- 
2.50.1


