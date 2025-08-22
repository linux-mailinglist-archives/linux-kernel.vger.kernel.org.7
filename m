Return-Path: <linux-kernel+bounces-781092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA4B30D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676447A6988
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F19285C9C;
	Fri, 22 Aug 2025 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVibCK3p"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372128EB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836344; cv=none; b=GvnIVGpyJufRYU9InzTIETWbZFjr6yUjer5CvlQ6tcBICN7JXBNV1khXo7NF9KikUHTuVarEmXf5a7piU6rjTW06xdZPGhnsLoyw032UirBxHOZ0wXks1ccHvvGIDGQk7nLslSJjahQGybxby0i8RIoOSKMl8GhkI7zvezRArks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836344; c=relaxed/simple;
	bh=t20bQGuZfD1Brmy2pwwwSNbJa+85KfDCPuS98k5iRcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgQ9cOme8U97PhaSwCX4TlHsm3Am/o2y/G/fOviwoHQUMHH6XBsn6g1s+XDS+wdLzQ7NEz/C+3eVXMDJEqnCPxm5aijnt9uhL91BFOjpAxXzXdIz70NLFWHQDbY3fXoqNtPbfZ8g8V6GVoSUtQer/MrGMQLqzSwE8Ic1o6U6aao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVibCK3p; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1671468b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755836342; x=1756441142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/x+QZypm9fvyoAG/ZmXxUFMkpYfk32s2LMp4va6ct/0=;
        b=JVibCK3p3tcKke3vDMbjrfGe/df2sF4SEcGm0wHyJV/uwJoPgVNq+3OrenMgdIG16k
         K4CEYtIeEr3rlP7AFE7LPJbTTliOgYeL/TrSqFe8lzculUrwgJzBAJ7Kj+cAM93HWUBD
         YmA3ewcbvSSSH0NxVi5u59T/+TNMyXowE2X+gQxmxlw6QIkZ2HTsU/pT9l8kEbD4fWfK
         xswZ7OCTZs+xjllWeCc1nS5Oi9/0Em9DD0MvhFgV5RjGCNXgTHO0WQg7Ay+cp1OllD7y
         12roFIDoM19pO9q5gN2MQyk70n5GApYxT11EseWKkz+K16kOD4p8v96ydeteiTWMFCNE
         UPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836342; x=1756441142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x+QZypm9fvyoAG/ZmXxUFMkpYfk32s2LMp4va6ct/0=;
        b=KWZH/map0xVRpJPvy9aF4Ghw7MCTUdJTEFIlHoweYDWQMuba3DHRVCn0hy5qvx3QvM
         Wgn3f4PleVvl28CkTWIgtROhaXg/0+iRf0NiTpaZN0j9TMm8735IwW/4sfWKJ0Zg3IQ1
         8t187Z/i269XB3daMBxOpb3gVq0/2Y9jicDne3BfarHg2y2S7B/soA4EcHg27pfsXmiQ
         YAYagZo1HtmXnnni0JJA6LZfdRP3yf7HJIhGepQJnkACzHz9JOOWfmf3sStCpYv4bfCs
         Fi9/hS42VKwPvDgFWLHVh7i2LueOSqD3eUubttTNXxWbK7YcRxYLUQXrxi+asEdIJbxP
         SHFw==
X-Forwarded-Encrypted: i=1; AJvYcCWS5pEcXgY5+G6jPo2vunsA9ju2fRuvK4a/AScZd5uroXOH6jeBDbG6RSSHaMjFJFtQRYzPiGuaR8DKz1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yTw+b1KHuEx3FWxYqcDrz/phbYG/oKqMOpfXEMbyeS5VhLwx
	kIa0jnqO3AcjD6S+Hd1I/oRYSrcX4o2THc0h4esnofCe+DRLOYX06XBp
X-Gm-Gg: ASbGncvjSyTd1Rk+SdHNQS4dCk8zj+t5oEmTTu0tebAyDZ53ovcoVyYYzXgHJ6Jutw1
	jKVkhT+9VlQMCAlLDGxXVdW/jRdnt1sDCoV1tOli787Xkw4lMnDtTZJW+Wy6FJRRgKZpF+QZ2cz
	Anyw+9EELoNqnQsFzMk9o7uJKJTI0ZAOJ0i8d7d3brIsEf0XaZCDNSdVckOPDGLe5DkTlplP5vu
	dCpq1F15l1z34svcxgf60aQUX6uKQcElOmCRGV919ZHtV8qIyi5eJooLvJgoToLVZLzktIkcDZ5
	hmmLpP3hfsWQSDrWHodL7SrYvj39RuyV3ZFqBoNAw2FwT60kyMk0AQajZwCghBas7RD1ZuQCedu
	63sWXl0kJ+cFCJi7+rOfg/IyNJqqMexY3A20lknRd8jUiVU6o2CwAin/uLSzYCw==
X-Google-Smtp-Source: AGHT+IEKoSR47Dk2l2J6zVwmnsYTxTjpXFUqClE3wvNa6dUMQxX8q0ptO6ER7RqDaLBBloH+cqNQ+w==
X-Received: by 2002:a05:6a00:2d17:b0:76e:7aba:cb42 with SMTP id d2e1a72fcca58-770305d5f8fmr1791225b3a.14.1755836341937;
        Thu, 21 Aug 2025 21:19:01 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:ba38:b533:dcf5:1e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1375a3sm9534559b3a.43.2025.08.21.21.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:19:01 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/3] Type correctness cleanup for ARM64 MMU initialization
Date: Thu, 21 Aug 2025 21:15:35 -0700
Message-ID: <20250822041538.467514-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello list,

This is a small series of type correctness and readability improvements for
ARM64's MMU initialization code. When I first encountered this code, the heavy
use of u64 to represent both virtual and physical addresses made it difficult
to understand where the demarcations were. I made most of the changes in this
series while troubleshooting a different problem (fixed in a separate patch) to
make that boundary a little clearer. I am submitting it now in the hopes that
this will improve maintainability and readability for others.

While nothing in this series represents a change in behavior, it is not merely
cosmetic: I believe these changes better align with the kernel's code
standards, type discipline, and common C idioms.

Happy Thursday,
Sam

Sam Edwards (3):
  arm64: mm: Cast start/end markers to char *, not u64
  arm64: mm: Make map_fdt() return mapped pointer
  arm64: mm: Represent physical memory with phys_addr_t and
    resource_size_t

 arch/arm64/kernel/pi/map_kernel.c | 41 ++++++++++++++++---------------
 arch/arm64/kernel/pi/map_range.c  | 20 +++++++++------
 arch/arm64/kernel/pi/pi.h         |  9 ++++---
 arch/arm64/mm/init.c              |  6 ++---
 arch/arm64/mm/mmu.c               | 17 +++++++------
 5 files changed, 50 insertions(+), 43 deletions(-)

-- 
2.49.1


