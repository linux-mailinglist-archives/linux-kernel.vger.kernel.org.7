Return-Path: <linux-kernel+bounces-792126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B1B3C07E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68238568296
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC77322DD0;
	Fri, 29 Aug 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="QZA79gKm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E35326D60
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484553; cv=none; b=kfwmMk+KJWWTqKBWezXf/UJtQx8sdhtFlczc4fYp8ijgzm+UEb6QcT6vxNEwqQiL3l0YFnsngI5q0WiJkZbd1Iayr/uL3stpm2biJMaS3Y5z39YQBK03WjTdJeDlvdz8LO4hroT5qQmNLKdLlabZS4doXFKscR+jZ14kgmMNGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484553; c=relaxed/simple;
	bh=PrJ0Kpwt2FKgUlVRISAX5fdIxqANZWL+k1X3dwszi4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTuyVW5iocTxECkOII3fvM/CVB7tLJ5gxpWTSqywwGKr4n8n96wlTDSTxqnO70szgSaIwTLWc5gJUjorlXiQ+hbFhnQvQuoOlzPByZ5xRkL3PP6beK/EAA4VCMc8sARemt01oMEn1xlqYyzTRHIng7p6Us8X5RbyuCW5t1WlCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=QZA79gKm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b618b7d33so19944385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756484548; x=1757089348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq1giWJsUjnprgL3GS+9dVU3raENqscOMd2Do9VTPCY=;
        b=QZA79gKmP552r9/5oFU2izXlreyhx2b5nhJXTccf1ZfCOG19EjfH+1oR01nblnO8ia
         4QpOkfZNC3Qz5gxhpYpYzmLAUfFNFejr+rcpZaXjDcacXtKhuMAT2DzJZFrinaVb1Aoe
         1xHV0yMXOIyIA4CRDPs3Gc74jIoKcvAqjoR/6nHYmsfDdXD8e7HApzyeTaL3n7LOb+oP
         ZbpMF2Dg1NXZkqhXEXEavJ1FpYij+HNVkO1sVem3PNaleuKTIh6M3fkGMN61UI5ocXxi
         XfHFU+ZD2fcoejGFWohEX2B+wQOTAa6hLT8oK10j+mLQ3w4AqoAxu/WgL1gqdAs/Ue84
         sYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484548; x=1757089348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq1giWJsUjnprgL3GS+9dVU3raENqscOMd2Do9VTPCY=;
        b=LRD08WUvmw7RlY0M+fzlG2tpCiRqtOjwgdbOMBsNoiqRX0pumeMQ8btel9Yu7BFQox
         vS1gYxOXI8NBJwSvMzV8SVyMrKbUfzEPySmjKYx98OwMcowt205dl8F3Ip8HTxyPWIk1
         hkEVmOULsSPYiLqXQ82TCoiO02nOF5+kzkS7ah6QOg/yPFBPOx7PR8LuwzLpxe03Xf61
         n/w4QRCpMciMf/lZT/Rkzht++le1enttoSy9FfC5JO5cSKsAhuiiZqSTCAsMeFTSQNqX
         vqL2xGMzTwqBNTFeNZ4vprtI2PEVEgZXNn0uPL3t3T48Vgyz7/nF94bukgW1qX7oVUto
         iVUw==
X-Forwarded-Encrypted: i=1; AJvYcCXp2wXHBPNiDoCizv8vtF40iX/8QAaq3oLIhg00GYx45D8sHNVktWAqvn/eyp5RssFwwV5v0EaA/MxM8yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJUYIClNLXE/amCSiOPThGd8Z+Ta89E7WhMLRTct9ruQ3Hpv2
	LJxUmUgCe/bHJT9tAQ75NvX2B96R2qvnsk2IjbFbjEib9wu9g+XS3Qjzn56yx2XvRAQ=
X-Gm-Gg: ASbGncti4Rr2zBs7NRDLeG1RVukFX2w1bJxxdLx7CfvO/ifJCXdK5EwJQCY51AEsiMQ
	gBCanKyY8fK8eMNn/uupX/CfGnYJLKdK1EKBEP6XQm4NoP8oHZXLZ5uqQ1kmLXyj60dYnWL2XW+
	FREoF/T8UHJmMLZ/h3N7a9Ui08+KiuZeLVbfisohhgZoQWlIA2eZSdLkVBZS62bB/CQTdqIWtTl
	AdRyU9/x/EQW8uz3txJlQ8YaayTfrOCVxkk2sVqqTzFbLNfvUdyrVftbUN9YiGLbmKld5bEnINb
	xLuAMhjgjJvfshwhrbieyXx+VFwDLYDpCxcYL7rLTWEPMjUnG9rnV7msyUbAhP9Gc4MRbumy/d3
	IrUs=
X-Google-Smtp-Source: AGHT+IHZWIfqgvYtW19pUMdEmDIw2QMzqT/iN9KHitqW3NbObqaxx+9cBOKOGWjP5SKNXmxENmlFvA==
X-Received: by 2002:a05:600c:4f03:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45b5daacd8bmr160920075e9.2.1756484547804;
        Fri, 29 Aug 2025 09:22:27 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:954])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6ee66bddsm125489115e9.0.2025.08.29.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:22:26 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: remove zpool
Date: Fri, 29 Aug 2025 17:15:25 +0100
Message-ID: <20250829162212.208258-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zpool is an indirection layer for zswap to switch between multiple
allocator backends at runtime. Since 6.15, zsmalloc is the only
allocator left in-tree, so there is no point in keeping zpool around.

Based on mm-everything-2025-08-29-00-23.

 Documentation/admin-guide/mm/zswap.rst             |  33 +--
 Documentation/core-api/mm-api.rst                  |   1 -
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst |   2 -
 MAINTAINERS                                        |   2 -
 arch/loongarch/configs/loongson3_defconfig         |   1 -
 include/linux/zpool.h                              |  86 ------
 mm/Kconfig                                         |  49 +--
 mm/Makefile                                        |   1 -
 mm/zpdesc.h                                        |  14 +-
 mm/zpool.c                                         | 328 ---------------------
 mm/zsmalloc.c                                      |  79 -----
 mm/zswap.c                                         | 202 ++++---------
 tools/testing/selftests/zram/README                |   1 -
 13 files changed, 84 insertions(+), 715 deletions(-)


