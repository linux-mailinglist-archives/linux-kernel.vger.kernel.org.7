Return-Path: <linux-kernel+bounces-881148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B0C2790C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 651BF4E21CB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD5299923;
	Sat,  1 Nov 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxTH9xjH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47634D389
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761982483; cv=none; b=uDWTXjhbZirgvbAegH3dtw7/ATIitWQRq54BUV4576Al19EMfW++KQZDpUr/g6wUFJJiIIiceGB0QG1th/onJUfpAFy/vdBy0mySd28ldmbF8/F/oy8pc9Hp5enfl3rsDvY5xiCNV8piuLdAZzKb/I/kTmkf6Ze3DPau7RrFUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761982483; c=relaxed/simple;
	bh=tbIlqcUdt4K/0Wbd5er6IiYuRxDgb3ky4LwFPVHhFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB+aOanbtKbF3hX9kfyFu2V492q64LUTTBSuPiY8a6r3uBu0oUH/dF01bflUrqlOc4vf3U6iA6DgUKNGKgI9t+3ZWPlR2zwevVdEL5I5UzmBBA6vU3MMunqmGaWFwMfVPOF7+XSGRrD2T4i5GHYW8yoQvIe1JF730ws41vhip7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxTH9xjH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso30340891fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761982479; x=1762587279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ikyUkEuAIUj+HxEe8beF0cjcpPgN6wIzeDAnASkpDU=;
        b=HxTH9xjH/7cMaU10KBJ7Z6ArqeGpXNAbsZn90cCliiUynz3Urz/m19JH7moAV7/WcS
         b1XghfROG/cpgzunJSLObgYpkr0EfiowE74eQt6O72MHGriXtdyub/4PkrVcpJCEXuG5
         9HUAdtEHtKiUzB6aVGvnR1X3mjNSrWg4oHp166jXXUdNBmSaY+U5a0UG4kR2LLppJJji
         cH9RjWEYEKZLL6ckdlLQsvsxVojBXbFv6pSs97dD4FKfdKMkUF3JROoB8MaA8rE5GXId
         KT7gkKzCFc8qWlcL8wh7uXoYlHCU+lSbFw9bR666H9su5K71862X7DVbowu3TR7BlQtV
         qR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761982479; x=1762587279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ikyUkEuAIUj+HxEe8beF0cjcpPgN6wIzeDAnASkpDU=;
        b=dbCIjO2Mmlu3ulN9aMIJFEls5QXXX3pqSjEttMaxCbCR/8IlC85B6JleLLOxRUyOhP
         +8akGdkQEKQA6OuQjZ058KLU6oEi9BiY4+rJ7LEDeav+n/soKHezJFtqFCUpie3W87VZ
         6ACBoQhAtP/Jp5XTO14KnTn/aM1Da7dfddazR0XVX5bHb8Z2aSBWUsgOQYkbLv7mMMhK
         q2Cs6QDllx4L64bKYARhAvyUkeyph15iNu7If/aPr08nxK0wbiQpnLU3bMLK4vzg/Wxh
         PBFJ+6z55AmYPiW26nJrvVnIwo2EyeUQKACCcT5EM/NFRPMMBtHffeQ2TIBS6oMVTOs6
         bdUQ==
X-Gm-Message-State: AOJu0YyTnZLaj3U7LceYdFjTQHME7TFD6GkMMCwrhvr+G5dMmFVs1X10
	r14CAYk6lmwsRqOO5bCVHtEIlBKnDaHY9BBnqAdfOqEJykkFwk6832V3/sS19hSt
X-Gm-Gg: ASbGncte+O3l0eNhcsfy2tPcDNYgel8w1EbKkhcFdk7qOy5KnjQxllFd3UG2IYkcgl1
	knpf47Iq9Dd/KyAs4pbL5Z/vP+YS0pw2WoMg2jwQM11Y+rbaPh14f6U+Vx8L7zmpWO0Dn2vwCnI
	de+mLYUZDzmcgnoqVJ8tRVOK2i3W8hoXtnYwlXEXaUcNTqOWPEzqkOM1XRwPEmk4xa6ZD8sEvvX
	7DF+MzGFlgUXIh6o20joWZU6hA+3Vpd6Xs3DOVOO53AVBYr5B3/OSuqf7FQcSsqoFbtzmpEIxu8
	9Qn03ajJNkuhEbBZz76p6/F74fF4DuDhdaYKkcnZKpvo6pZLFjYoCiM1GpMWGzUisrVVNM1/YRu
	UOIIfQ86hniEtEL2EbKWYgDz/xw0kkMr1bga0WrvepQHsDdnZZrLOYpHcHMJQOc4wPZqSWgh8vj
	NHEvwfwFDb0gIARw==
X-Google-Smtp-Source: AGHT+IGSi1MaERRSeAaLh4wNzQnSFVO7/v/mdkdzZiR4yeubPQLkUoJbtY78vIGcHgt3adn0ZKW5FQ==
X-Received: by 2002:a05:6512:10c3:b0:591:eb01:8eeb with SMTP id 2adb3069b0e04-5941d565e05mr1735327e87.46.1761982479195;
        Sat, 01 Nov 2025 00:34:39 -0700 (PDT)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39d2c0sm1046152e87.46.2025.11.01.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 00:34:37 -0700 (PDT)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: greybus-dev@lists.linaro.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH] Fix tiny typo in firmware-management docs
Date: Sat,  1 Nov 2025 10:33:45 +0300
Message-ID: <20251101073345.10520-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


