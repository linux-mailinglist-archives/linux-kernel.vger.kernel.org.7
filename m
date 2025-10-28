Return-Path: <linux-kernel+bounces-874466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33713C16673
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11694FD5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAE345722;
	Tue, 28 Oct 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmhhimQX"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7A257852
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675010; cv=none; b=VKZ/Mw7Zqk/je+ppd99kaXwKZPycw6DWfv0VmX4Z/UlngZeu9mun8Jiia1BSyA2wWINlOVHqQKvKce9P1YpJPQa6+NemBqfo1rPr5cUasuhtA7Ao4Dbuoect73BsQ4lRkV4By5ZKJxqhKFXSdMYM0BPBDzhs0bMkFo34qwkbjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675010; c=relaxed/simple;
	bh=uSUbl7xYmXs21tUPfi1JSz7wlqW9pe5nEGCQmgCQBwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX7CUQ4k95F72M15bIdXNu0Gl0Ed443PhX5w68cSOlqe1W4Eyb92YCrhbrPARqhHygEGixfPN36N3Rvy1JSS8PD+PUa0xL27C1NLcBIZukA6S70qyt1mTiSN4RC6OzQO5W8Bg8cqSOGYTFZ5/kzWGuGk8C5i1hJTvpTADBr2q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmhhimQX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4283be7df63so3076058f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675007; x=1762279807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bf7O6qD6pyoi5mQKiDO49WRuqlvg7ySasyy9Hdupzs=;
        b=JmhhimQXe03M2Er0FLwCuYmlGYyXZpcxBm2oLeGf1lzR9R0VcygzgH/e5yCyRsGCQI
         ZuDUiKH6tYDwGsK3IIgD3SVJhDKCOinAqwRQ7yNTILlvZNOVDX5V6cac+P+2/vM190dv
         n+nNnTsS+q+BcT3nGRb4APdtak83MITDVk2bBBOr++exYtK/gsli47eKWAuhEdTjAdE6
         ErCoIBXGvbSb+sDmpUhbY8HQOYnNy5qvDBnoFhmxa3ohxuCtyFGgtmkX69PHOuOU///a
         GcvSUbKRyhrstszEIVnuVYpxAv93BVxzaKT2K/JIBxy846yP9abkvRhvkvJX8TOSiZJ0
         kDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675007; x=1762279807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bf7O6qD6pyoi5mQKiDO49WRuqlvg7ySasyy9Hdupzs=;
        b=ctehb9K6tSpc86m00rbU9dKGZ64gooH4Tq9JFkDGqkoVqsArgOEfOEyF31dfxEQd87
         YWTGkEkcRgeX/Jx54Kv8fXUsIB7Q3o5C6PL5AaHfckCCrW9++adgJIgPlYPpxSZtaCaz
         HSMF6NhCwaWl7xp/7Ep6UtxTwywmlNYDxTbgnUgle7TX2pNqyTBTVe/gCYXp7XiRvyTD
         wMQpGVCTw9uIHPkrcP8xQsn37xO/OG9vqVGh0nrRdveUSkMHj6sp/Ujp5KxI0PLWM4aK
         bsPPTKigW1biMUWgKSGpEmJdlR4escnxGaPBUMg1qkXNwDTWtfoICGcsIxmcrkkD6i4q
         gCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWixQD77U/mfFbS0rRHTV2wWFBO/up+09nT4h5nw9Jlq5sXdxPhE2wCZegsBp8KFVDimR+E/PJIGk7umHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLgDiikkur6JflZl55nIQRC36pcX1itSD684nO9r5OPW00pNL
	UjVc+LqT12AlR4Y1cYyXoW8UHG2oL6kAQddcieb6cLnjmh+erwT8kvOjCm1hsrtu
X-Gm-Gg: ASbGnctVykECyPcI/Sfjsqcnp1MGXuol2oRp9Wo/RpdtCoJXLhCqYlt+NsEcPGi2dOI
	kEBF+RMC8xuHc/zpsvvGLmcBNYwhNdXw7+O/ob1d/ACR3XxA+siX2+tkcPWRhbLwz2lbKbPkzdW
	7CWDRzhE1gHif/cO75HjY4oZLJqpcL01c+twjeuTpausrhQ0RGhTyhGhXSKssBNeOKn2wIoUay3
	iVw+jmpMeb585yW2EMqr+3W0aFHEFGEARDdLlRAI5POe7uzg/9REfCtP7FTRAbSYmIkDDCwz5KZ
	ypQdXxAnt4mZUnBnnEHT4Orb+sfFOt95m3lW62ghUJDUCtHOb5xUkUKqfEYxCN2rKinFIID8F+s
	u5aSHh86iUFqQWrd1AC+yb95ADXhluXJJNBpspewkNBtGfPCemFeytRFBt7+AZyAeDEkG34IJvs
	GJNZU3WO7mLVdm899fAioHAmhA59XUTqROhQAS7sMFwG2oatYzTLcC+g==
X-Google-Smtp-Source: AGHT+IEFHgPaq0qext4HFNUofyr/NDNb0DKgPyi347E/iNoCCS1FLhcKMe+kdFKCV/27Upe7+HsZ6A==
X-Received: by 2002:a05:6000:2f85:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-429a7e7c1a7mr4625274f8f.40.1761675007242;
        Tue, 28 Oct 2025 11:10:07 -0700 (PDT)
Received: from localhost.localdomain (178-221-6-74.dynamic.isp.telekom.rs. [178.221.6.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm21650411f8f.41.2025.10.28.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:10:06 -0700 (PDT)
From: Lazar Aleksic <kripticni.dev@gmail.com>
To: kripticni.dev@gmail.com
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY
Date: Tue, 28 Oct 2025 19:09:05 +0100
Message-ID: <20251028180956.10753-1-kripticni.dev@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a misspelling of Xiaomi

Signed-off-by: Lazar Aleksic <kripticni.dev@gmail.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..c122016d82f1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -432,7 +432,7 @@ config WIRELESS_HOTKEY
 	depends on INPUT
 	help
 	 This driver provides supports for the wireless buttons found on some AMD,
-	 HP, & Xioami laptops.
+	 HP, & Xiaomi laptops.
 	 On such systems the driver should load automatically (via ACPI alias).
 
 	 To compile this driver as a module, choose M here: the module will
-- 
2.49.1


