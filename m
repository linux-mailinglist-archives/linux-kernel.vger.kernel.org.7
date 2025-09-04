Return-Path: <linux-kernel+bounces-799668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640AB42ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18950580919
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357E1F1313;
	Thu,  4 Sep 2025 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLfVWE40"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70C1EEA55
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949200; cv=none; b=TF8lGsw9ApDlcwtNQiGdvAAmgzv1fRhgWqbLaNnt2xcfsOjkAyIH8A+2LpWqurKLKjSsGEr25aZraCiPOILkFZ/xHyBhS3ClP1OSOV73w5Q3qB//KTk+p3H3deeWonVlCgr2DZgrTDf4nby5cf6Pl+ypgfB0k6wOtOlLWYJOrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949200; c=relaxed/simple;
	bh=ZIDFMuE4M5pN3hNXaXhKSfNWI42Rb3epwAfW5TFj8CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jr3C5UuLlDBm/9EsaI/nA1YpuNNtaN6tDysHFCgPk4CtAOT3IDeHu3Nd3IDOtfDmVGqqLhvkJA5iHG2emyPPRVYZ4w3ovTiMIgIb4S2dQ90OyHcOHuk0KnB88CKoRq0R7TV0AH5w+4Gm3iKX/q4E63Iornop3iG52TzfnnWlrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLfVWE40; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7222f8f2b44so4225726d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949196; x=1757553996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=nLfVWE40l2xO6Velgmhf46j33ktCUN3Qgme0a8DllecYRrzE3JX3HPLXIfI/8QuVKb
         OxF3nA2c0YVahRioWihW77bzGXeqMnvxx0ZaHyAX6SqYpVcFB5RVihFKjxPFP3sBzO90
         zshPuhPMIIXmrPOcUrQ3W1Pgtl5HYMe3lAZG4DrKB0E9N18qrca0BocNPFB9c/cQRXNz
         eVCW8OGfVZThTDBUo5325dYfFBjiuRyLdLpBoMKUcykDfayW1q4FSNiy/fg67aD2F/Lo
         Q5+QWYp+8RRbq42NCOg+bCuJyVevFxD3Eyf4Y7sfVO7DQaGolZ7fnXK+feNcWl29nrai
         hz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949196; x=1757553996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=puLVgmEgtnrU2hDR/8/ueB0v6gL7XLQ2D2uqMz+LVt9itroi8ASjeaBtkSWzaQ5ix4
         vtd0opo8jb/Z2+PWau5Wccwv54d40+zaHguckUKo5Ee3wr+BFMlFChnygAXNrXCWTrkN
         RE3E2KuYQ1GIZ8Y5FLLpDQCl/W4GCJz/ZeK9YJroyyn1PgwNzhwMVFdOq/pYzW7SQhzB
         uc4mFhJEtc/wr1wdChXw3EmDejFxXjobbcu9rElz6B5sEhjB0MB9Gh3qoU7AQF3/JWOk
         DuW8O4JbannjqHzACWTTGIsWHPPCrNkPbQRtLLi9o4ju2P27fI9fU5OvxRRdRE4sUtTI
         uccQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2BWd8QBNJ+qyr7tulLhIrPLce60uIrtrBBCbsVfFf+VfEFSh1hlAWuCrr8Ra+yJ8yKZF8FBuD39TrM4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1sLyWBnbDF8II9ICP81qkEkIFfsKOoowFWnsyuVjiX7ja9GK
	7/8X6QYXmKtK3ecb7PMbAji6L03470BQUVRBC4rl2JHxyYox2ww7mHcf
X-Gm-Gg: ASbGncumnbdv30vhX53AuJoOnAbxsDnnIbN4T/nHk26RuqAVRm8LnqTp9wM3AzjNzi3
	SNTmutYFAUWbbnzc7Xyn+l24Mr9FTIEIEmKs4DWaYm5mVt+tM7TJ5o1jun6zC9rvBS4JIAZQAFU
	PCqf95aN3LvILYx/oI0sL7GGSUO7qnGcyvaA8INlT3HJ0oRYTjnO/xYNbcAorM8NzP2XMiyvFy2
	+FvfHmM7XcIo4gKrw6Lhp/yAXNT3qcjb+ksgHXeZ9qeUWTGVT8guVdC+yqYuNkZybY7zIoAMOhW
	MTMxchInSsacnyVW5oKuX5891On48loWcPuttFKO31mdcMuNReuiza7D+4BmxGO8bb9rtj6tbtU
	v6TI7NF2iozpDY5RBo1SsqOEQDlQ2/SdGvToGppREFd+mi2NGDAc=
X-Google-Smtp-Source: AGHT+IFbDToJ7AUXbhetPYcmB6/Wb5TL+pzH1QYk/b5j0SDArnwQMHzR9WJxw9tq5MNSVAKVt4Fhxg==
X-Received: by 2002:a05:6214:c21:b0:70d:ecf7:2102 with SMTP id 6a1803df08f44-70fac76e538mr193808096d6.15.1756949196611;
        Wed, 03 Sep 2025 18:26:36 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:36 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 08/16] staging: rtl8723bs: remove space before semicolon
Date: Thu,  4 Sep 2025 01:25:28 +0000
Message-Id: <20250904012529.215521-9-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary space before semicolon

Drop the extra space before a semicolon to comply with kernel
coding style. This change affects a single line.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ab626c88e7dd..d05ff073af2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2236,7 +2236,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
 	/*  adhoc no 802.1x */
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0);
 
 	pdev_network->rssi = 0;
 
-- 
2.39.5


