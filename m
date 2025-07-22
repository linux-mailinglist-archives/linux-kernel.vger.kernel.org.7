Return-Path: <linux-kernel+bounces-740620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A5B0D6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10FA3A87E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC92E0907;
	Tue, 22 Jul 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQcTP3it"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FB23F28B;
	Tue, 22 Jul 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178570; cv=none; b=Ymqrgoosk5sCbq2EUKZ8JiiZYcO2HBB03ICsVXI5YVuI4V6psznSVfMmIQJ8cSnrPdYKxy1Mcw3v0elj5e+Lf/LFN4x4qFOnu5JJ5Izybr1QbklJMsTqG1eol0vPRQW83O5ROpHiPzOGGnOu7EZ92SfIY+AFLP2oh7ZdIIqx7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178570; c=relaxed/simple;
	bh=7x/MblA9hDrEH8tsts/ya4UsiNQfzuJJXKVBSxrh69E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Maoj5LFR3z21elo0unI1+rQ1S9QVDqKzx5mfUBHonP86XgqsF4sMF3nbwTv6EcJNBVkCMMC0TJ4rpLvoTWgjzdlIqBWLOZTLY2WSVPvdMpfV4ewCjUfUDBQt4iiXDxEt40Ln/IGaosu/RkOerEODFYeHDbs+RfDC3GCzxMrdF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQcTP3it; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45619d70c72so48398135e9.0;
        Tue, 22 Jul 2025 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753178567; x=1753783367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJLkThqv/dSOl8n/5REBMN665eVsmLLXtOyGbSyEBng=;
        b=EQcTP3itgGhq4XHwoF8il9QaIawIB5uotLYyZcXvVCh8A4iC9aeQILRRa1lwtA1huC
         mUsMrO8DS7emAQSgFhKyEk6mv7j3KqR/LZybs2P8XC+ZQMOxxdTZzwf3ONCiOZgwixY7
         36FdmokxM9aNs+7h+ADjoJzbZNekfHj9MKzT6PtAJjwr8ZVZ01ybsn3jMppEMpAI8qFU
         viz8XntStUPNvJOzUpnhW0cqi4GxadTvbkWHUZihjSACm7Q7mUHlGAdWTM0vKExesw+7
         uGXMqUwi60Cdv+bTD62DEvoS1uWxlf30YOYOQxQdq8l4Rv+BAT6prOhhYgolrFb6NdsT
         eGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178567; x=1753783367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJLkThqv/dSOl8n/5REBMN665eVsmLLXtOyGbSyEBng=;
        b=JLyccIovY+qXHOi/IU53DkqxPnXWc4X3EXFHKmNEpBPq2u0a6iJBzA9/AIv5fVBQr/
         zvnSItCsffRnxdeA5aOmGMMMPoyMA4J1hzP6Dd469asNmr0jdebYsMtGI/BJZC0z2+97
         MiaMVjN8Tw4hG5YI1oLJ5OkqddIyzlGJQcaUYj7P1z//41O3xOKGDAHQ/RiwwmheK77J
         UkIWdZPsGmtqZGempVSc1DFI34xRdavpzN7M+PcwapKuohelg/WTkbL+Rm8ekwrpTfVP
         AuMlWwC4EZfS2Kmn7mpTGxEtwo1LljajJRZ856+DNrvZkjrlhLAknQAYOzy+2Z2/vFEc
         gSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpKjvWj7cZpiOcSlukU4fLoJxIWV5qv6gF93NIrbFqCALHcGugxXTBcpKUju+kYKkuk14tuwJASjUe7EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4xAUF8prnJQGgJmxmK4z8WdZBYshq+DZTVIng19m1ihq4AoW
	vnICwwfFcOI/cwHZVfcCMNpESdx4SQ22IopPIC3oKZdG4p4+gQ8odAvW26sYxHWLbqA=
X-Gm-Gg: ASbGnctHHKdCVTjlkLeWjVlZkOHSAvez+yRuCSkrxfR4Sr/DIR5/3m9He1FeaJLU+M3
	m+VNx++15ILFzFrnvlkaTad6sMBSa4Jo2Ek4cR+gEbgLbPWshPLSufTGhIndQEqynlYDeO4/eS/
	JKy3nAMYB7t3aEgygxlm54E3kpdyhXuSPGX1CD8oDFNd4HMEbKGWAa43sfY9rUSDI3RThQQcXWv
	AHaaUITujNRTUsbb7S7EXpO03Vd7APHM5/zALHfNCULrywLyPX2JEV8tJW8qJz+Dhfd5EPmiN5O
	PaBdTaoi4sJjHwFbjPMp7tckYTr0CH3VngZKDWvKxiSYA3MD5wlW/GoIMFwj/NKjPfEuNWOBXcy
	zezXE2z+ORBKlEMGKlj4dFJfpyvTOHEQ=
X-Google-Smtp-Source: AGHT+IF0laoKtKkFN/t6ngrLWQPIvWKMXmimOZe8OVNH0SnTJ2DeY5aDhhTHsNtNElR2dVPijh5fDg==
X-Received: by 2002:a05:600c:48a2:b0:456:22f8:3aa1 with SMTP id 5b1f17b1804b1-458626fe2c9mr15146055e9.2.1753178567181;
        Tue, 22 Jul 2025 03:02:47 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e89c308sm184216065e9.30.2025.07.22.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:02:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mailbox: cix: Fix spelling mistake "overlow" -> "overflow"
Date: Tue, 22 Jul 2025 11:02:14 +0100
Message-ID: <20250722100214.3792075-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mailbox/cix-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
index 5bb1416c26a5..443620e8ae37 100644
--- a/drivers/mailbox/cix-mailbox.c
+++ b/drivers/mailbox/cix-mailbox.c
@@ -346,7 +346,7 @@ static void cix_mbox_isr_fifo(struct mbox_chan *chan)
 		/* FIFO overflow is generated */
 		if (int_status & CIX_FIFO_OFLOW_INT) {
 			status = cix_mbox_read(priv, CIX_FIFO_STAS);
-			dev_err(priv->dev, "fifo overlow: int_stats %d\n", status);
+			dev_err(priv->dev, "fifo overflow: int_stats %d\n", status);
 			cix_mbox_write(priv, CIX_FIFO_OFLOW_INT, CIX_INT_CLEAR);
 		}
 	}
-- 
2.50.0


