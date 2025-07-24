Return-Path: <linux-kernel+bounces-744727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6942B11054
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0816E5A1B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797B2EB5D1;
	Thu, 24 Jul 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ERBh47"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65014286
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377977; cv=none; b=JOsrxF/NJrAgkeicdg4lc/it6p019uxGH2u8Fqnb4mf8ML6fpUM3TzcIFbvyc0eVvk4huE4FJ8+oEHlXrZk1iM2Um9PYjX68hVZeQoe4DSMOPXJ8zd+pVOLBLyqCNblC092JQiOy1IMf3zlGbm33v87Dix28dKjf6DAjPk3GlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377977; c=relaxed/simple;
	bh=KAeYHbxC1lS7s7cwnmvwfKOqD25berE2Ks0kTgjzGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ncvw7W9D+ra1ZsJYYZAw9krndhFEYdQ04bEnZhVWap8lqdKYVEyGD/g3Cvo3n7Gu8axt2qD0PB39ttJYiccILUlDhQivWRuEQa0RnmTkIXyBQmuDJ8uI4EjHD5fILF/IpT03IW+VU0TJFgiqmp/AvMSmET9zUwl47RpsbGEPQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9ERBh47; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-75ab31c426dso1125684b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753377975; x=1753982775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUe9u1KCQnirtd227P6w1BmHNBfUepiJPaRAQLnBBF8=;
        b=i9ERBh47pUog8hQAskg57tq4OykkqhSLbDUiL6LkT9XLUuJPLxJFbLKoextURPFwYf
         t1eMA1oGMdpvqp//GLiE0VEthBO8LuJidOODBjok1gPG22f/u9U/3uZhR/EM/AACGJQs
         UAgtiwMx0/NpEQA9UgVOfOnGy32hCAh2InD5B1BzdWIEuh3uiduOvnrMNxeENfO/6Ubu
         0NnhP6uXnM96DgfPZV6Jd507gLR8j54wHWVSUKP0mrkBOfvfPEHU4tdCgObIc2+jjuax
         s5efT2ta7OnHeayviiXKHKmSrdh2BsR/BCoBxaWO/CZavO99w6HxHOImzt9YAWX3BYLF
         tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753377975; x=1753982775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUe9u1KCQnirtd227P6w1BmHNBfUepiJPaRAQLnBBF8=;
        b=Nqx/QrhdIpQi0ZCLBzOrF8FD9XlJzsBsrOdyKcqooHahIybqHmEBAAkyfOhOPvmbRm
         ZrlCZWLcwV56HZuy0McmjBEUahgILPhGBvWFraQ3SpExPS4au70+kFnIPRcMlabFf3LC
         3Hle/N1haigyFkBAuAaRV/gTREqAsxZzn+aW5hoKOVqWhzBTJN3QLeH+LimE2r4+zUY0
         JafyFEqwahtgKNbvv+wSGo6sPXmQNi7d92ssg0iuDueWwBq10uzJA999GbwXmyBPVFiz
         XFXk2mhDUJ2FoJw3/HtlPDfVuRwoE3r0Zu2LHhef8spcsDxHB8AwnmdFP1IxTTC3RaEB
         ImjA==
X-Forwarded-Encrypted: i=1; AJvYcCW62pg/j0Eh7NnejT12H5mwVIJl5RrmpxOR3lUmgTta2QBXI7oR3HRi1JvuELbKjvYoO6DnnrJw3g3KpN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqidugaQu2LxOR2xnfwwBNVQwmBlHll8wsoKadHlyGdB3CIcxA
	bSMJagMnmCBMrQKmunR+SuDzvs9L3veMd/vo/6R8YGBNSuYD0WYRMyXV
X-Gm-Gg: ASbGnctzUB4y3D4Djzu/xruenbJD3dlOqlpKK8nLH8iExhPJNMIVKqqVV32YHSoG3Nh
	HUqnOdVVHs1udpQL6kmwoQ9m1p+XAXnudVux9n82jzUvXbxh1v+VDwyrXMl4IXj1QkCUaPK73aq
	3uLYpcw5PvmJ3jsUbLixNIZvQCFRvnosAUQBkCj1X5+yrjIkbFZzIWsMB9tWYN1uxhBX+9/eiIh
	LiQOJodwcefoCKP5wtbs8fIHbljoCluqRl1XqLK5zbF4BmisG53NuIiI7mnBVTnYviXOWXPhtbf
	Qn7b1kLhJmn3gfHb08Y+AuxKoWQsFS7lcWKdOc45wsLJcRICxcVcO4pILeCj7q5se7yTUdE+UmC
	IEdynTNSO6/w7ylyhOgGsnBQw4BAKSkgFb75eNx756A==
X-Google-Smtp-Source: AGHT+IFcNSsyYwzraEG8EbrCJ0la1lFa1eFwIPy+bqFr6TTzxI3z6TYAGO2SmResKfllx+bfdd26bA==
X-Received: by 2002:a05:6a20:a11d:b0:23d:40b6:3f9 with SMTP id adf61e73a8af0-23d4903ffa4mr13812559637.13.1753377975343;
        Thu, 24 Jul 2025 10:26:15 -0700 (PDT)
Received: from archlinux ([205.254.163.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae1584bfsm1999495b3a.38.2025.07.24.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:26:14 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	ardb@kernel.org,
	linus.walleij@linaro.org,
	ebiggers@google.com,
	nathan@kernel.org,
	lumag@kernel.org,
	dave@vasilevsky.ca,
	ruanjinjie@huawei.com,
	kees@kernel.org,
	liuyuntao12@huawei.com,
	linux-arm-kernel@lists.infradead.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] arm: allow single CPU configuration by adjusting NR_CPUS range and defaults
Date: Thu, 24 Jul 2025 22:56:03 +0530
Message-ID: <20250724172603.18701-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the NR_CPUS config for ARM required a minimum of 2 CPUs.
This patch changes the minimum NR_CPUS to 1 when SMP is not enabled,
sets range to exactly 1 if !SMP, allowing only a single CPU setting and
adds conditional defaults:
    - default to 1 if SMP is disabled (uniprocessor)
    - default to 4 if SMP is enabled (multiprocessor)

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 arch/arm/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3072731fe09c..23acee38721e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1063,11 +1063,13 @@ config KASAN_SHADOW_OFFSET
 	default 0xffffffff
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
+	int "Maximum number of CPUs (1-32)"
+	range 1 1 if !SMP
 	range 2 16 if DEBUG_KMAP_LOCAL
 	range 2 32 if !DEBUG_KMAP_LOCAL
 	depends on SMP
-	default "4"
+	default "1" if !SMP
+	default "4" if SMP
 	help
 	  The maximum number of CPUs that the kernel can support.
 	  Up to 32 CPUs can be supported, or up to 16 if kmap_local()
-- 
2.50.1


