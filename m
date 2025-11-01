Return-Path: <linux-kernel+bounces-881152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9BC27921
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E353A2010
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CB1F872D;
	Sat,  1 Nov 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsWvjsWy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF14219E0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983211; cv=none; b=PrbGSslpcR3OpMXEZHTl8kTVet2tGoBfZ4fYNq4gjmhCZtZNu27g+ZIW7FnaxPAlHAD2NlPGcu8nyT1CKmAdLbtMkpX8jhcnjhVWUL8wWUVQGEaWXXtGwd0eJH4idRuL8akt4SImi0zMoVgzn3ONRYqTkFhNmqiMbi0nH4eTi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983211; c=relaxed/simple;
	bh=FO8B+XSbG8/tNz7UwdzRHKt4zk5YCDQOjGbVamOS/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cajK5qmna7ctrjguxbZiEgo9OZCxex2OqGFbJAxjWIfCevphQxxhuFOWlXJlvrJ8d0reRyVYsc/uI/ffYrIW/T2YvfOXJ95gSXy/KuWiVg9mPdpFLjR53ZdRHicyKVeYBLM4GStWhnUs31rbV9TrFmd0F0pwcc9EVCbS260NobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsWvjsWy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f7e50da2so3736646e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761983207; x=1762588007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=dsWvjsWys9Dv0gm6Le7vUKkWekoMoghEMDZW3k4Pvd24PRuoDZp0UwKD/gFWt9Hu6p
         aTbILLXhkW2X05EOZp705/7EeFQfyoM3Pbuw+Px3qRFK8yuQ8XYBoZC8Ss58y1h4HVql
         ISNXDx9zkoXVkbAGMZh0Hgo6uMwSmXsGW0t3Fdqw2viEQVekLsqZVImoFj4TeR8l/N+P
         Bjw0HZsXK59GXh43uamlU7UppeSKaHiX1xU5NIeoVfN6yhfwZ82F5z2Tk3pKSAf1rlmv
         0VvtfNzpo7YK2+nXEfv6/DA2avjMh8bFErn8tQUE+OqRUZ/Hs5k47cwD4VIyypLoq1Wi
         EnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761983207; x=1762588007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV8ILjCLbAd6Rh+u+y5fp6wN9Ns1g2oLwKcbOPZD8ow=;
        b=H8KxU7fXLJ1P4NSz4UP1kJiUXuKyxA1PFXidKoBwcs+Uu7v0c5EUKoAQYdRyYY65bf
         42bM70C7P6j0+9+Dkkqr6gjwhstMA+CiZqHsuNpoRsaeZLGWI0v9uzKc24pnuGXXNhGi
         QF2apXp+llWCTzllg+TVwcqC/OyCECDspROOPuAgFUuwMCg2Em8DcO4GXmOB2ooLmf3P
         HqRw6CkpIqIS9mBlzYKqpKOsPXCJFmnUZAlMrVilPF5XerfPCkp71UTJZSS5DIKLKjj8
         ZB5f7d8IY5qf13fLWwetjWXmQXGOMNBy81OeocoBf2v87uuV5473RE49IHDVOQda2khS
         4Mcg==
X-Gm-Message-State: AOJu0YwcrYo50opKNOSHGjjoGHYrfboDalDs+RN9jkBQrnx7edVz2RsT
	WSMp0Qfctv9f8nmklBUxmev/oToeYskzcDbb1UrjpXRLpZzIITgylPI3Imv/xFsB
X-Gm-Gg: ASbGnctDW6P5UEJ4xkqORxXdnO1xFdSxAmfei06/8WBEM688KaFCBbginaSKsqz2r0Z
	S+rj7lahmW+/f4IygXvdhfdaHI3nmKHbCuomPASxDYufHYgnAscGUrXl5xuh18Q8tPS/cx2PDHz
	/m8ugZ0DX2zWxDiQWBIHgedn1o2pJeevtP6qSPufaufM4ugnYzofTGpOOGjuV/r59uPCijLyV9J
	qxprpuDt9iySSaqXa29L+OabjcEIoTgDrDKS2tH5hOimfnY9BkH0CmBmw4Uhx1NyD1FgiS52o+e
	48s/x6gRj/zNFK9x58L9Q1SwfaXecqywBNJ+6tTCh3r7Vz82TtiYMni7KLMiX0CNVtpG9BfnbZd
	dXqEhNJkDmR2aWPhElfEFYgBTdw2j1OAIapEUwFd7RCf+owuuvuMxTOGNhy5NFWnv/tW48iGqGU
	S2DBBcG9tbA++hEQ==
X-Google-Smtp-Source: AGHT+IHymJOP85Ntx/hZkcSgPuiaTMncBc5HzJI10xt4SlURooyxsUYKP8HyGqOGX3S39upKyzjXcw==
X-Received: by 2002:a05:6512:1149:b0:593:6b:520c with SMTP id 2adb3069b0e04-5941d36e428mr2100693e87.10.1761983206760;
        Sat, 01 Nov 2025 00:46:46 -0700 (PDT)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5c2782sm1027604e87.107.2025.11.01.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 00:46:45 -0700 (PDT)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: greybus-dev@lists.linaro.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH] Fix tiny typo in firmware-management docs
Date: Sat,  1 Nov 2025 10:46:16 +0300
Message-ID: <20251101074616.11211-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
index 7918257e5..393455557 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware-management
+++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
@@ -193,7 +193,7 @@ Identifying the Character Device
 
 There can be multiple devices present in /dev/ directory with name
 gb-authenticate-N and user first needs to identify the character device used for
-authentication a of particular interface.
+authentication of a particular interface.
 
 The Authentication core creates a device of class 'gb_authenticate', which shall
 be used by the user to identify the right character device for it. The class
-- 
2.51.2


