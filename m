Return-Path: <linux-kernel+bounces-843383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60BBBF12C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9844E9E16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1532D8789;
	Mon,  6 Oct 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBXtTvZE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D227E1C5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778030; cv=none; b=N1I2vsxRQpgIgLT6on39LbcUt4pTp582mMp5pEgjwwriY4mFoimHDuPQ9XqcpQkI0z8lJsZKFvqmXuT/4B/fsOSmqVEYrXDBbE8UW0KW5yeESu6oq2BaGU1BPOhbwPWr8tWQ5LN8zarwXAZvmxep3MQdorDbfe3xQMb6ynMc9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778030; c=relaxed/simple;
	bh=hsSGQHlJQgA9xoqDSEerkDm8OlpIUb4MXP+dAWtmrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idASOYwXcG5ayi96g8b/FIjL8OB7lh5vKd1R7FEoK6oVoX215Pb0gVvcKgN+crxQwapGIwue7kK0LmjCJVZVN6T+eujASCMKEh3sRy9/eQJdMB6m/LhfdtK6YZHQneeH83b+66fjXySC3J805ngZIMhZ949cEUWtky2h0bTYJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBXtTvZE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so3404897f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778025; x=1760382825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMcBBIOQ7oEULc7Z+X61tqPmJ8i34RpbaRVflxVnH4c=;
        b=SBXtTvZEnJLg4a9FT/A7QlCMDzClQji0pjX4M4uylhNxZW+/Z0X0PMm90yGlrYQjmM
         X6nEYd+fIKQrlAtTa936BzBIPRHMQS/Vu/nSXfM0tvY9z115qdKFcI90ouqrYV7bd3AB
         A9M6AgxqfhtXvhKxERg7mlgs5su2hBjsh4d/7RloVonzP9UvYy26PbuSBNO1aHcZQfsK
         mgBVV4K83odTXqzQYXy6IWw6eLKZ7gnOmFPJDOg7IU3K+XmdWLSdKqaZovslEcEfkGQ1
         WGrbAth3TLVUHFztRSQLuv9KzMiC/ANLXBSJtINW5eZ5HfTcP1Objkaa6Nh1M5zWPWVe
         zfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778025; x=1760382825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMcBBIOQ7oEULc7Z+X61tqPmJ8i34RpbaRVflxVnH4c=;
        b=I6upW8OO0QaFyBetcXbweI0y4PC3pdEX5VhF2NLxkl6Weux36jxG3N4MczafD4/X7W
         AQx2FevBrM7fw1JBKjAGpJe3FyzzVxHfMcd0UGsInP0RbXrL1og2y1bQ8w/FQCYFOGP/
         n16EHxMr8BIhQVtBJAgJ1ALqOf0Og7biAp0Ef3J7lQifEVMRCB3gxTXwKyj7tq6SvE8P
         EIgPHACCID8MSeQEKgFOLT5GoeJ0L4IUGMvcF4meXtueIRluNHNfMC1NjAYoWhjQrgG2
         Wk6SMbDS3ULFh+cZODXrWY9c2GwrNWo22tFouMlK7q/zV761hx0k3M0+cAIPOZ2y7eZE
         1XMg==
X-Gm-Message-State: AOJu0Yz7W6Q2czTrHqXjbTwbACQjI5K+FSFVrijHZhVHPg2rHBGR3LYl
	mRdenzc2JPIikEd8PIOBiA+9wL+mxDE07mSop3ZlHF8I+bMmKlMu6jAksV2fbw==
X-Gm-Gg: ASbGncvmtn4XBCoJf6Oll5l1sjt5+m7fIAbhntkGUFH3oNH/vtEPRG5XY4I6OOxewLT
	3chO9OvZ/yOnIQnI/iy6cKGLpelcLM9eWR4EOTb6ZNsTW12JLJUwQztt+DVmn0Xm/XrnIIkGujh
	2F0tWIUuDr56osTBVH/AnQDH6zasWEiG64Vp+SAFWn48tnCpHO6SL5cSoab0V3Gxupd5hEGSf6a
	Gui0ECiRL89hM2FdRepZuS8pOl0yDP6A+Vz7uuBjjCwBNk0S8Ddme9oTKQYY/MBwjf4RMRxIKjH
	Cgzi0/IhqiBJC/RFXnM7k/9jTmUchJRh929hJ/O5xTqL2fnahvyx9UUhByT59tKJ6R9dzMsi6Fi
	fi6NmyKjQ9Qsq0ijQ3bwaz4uVzGZJuSJuRgZBAGcbOrJ9rze5FXR8y49uODnuMP1/4nlC
X-Google-Smtp-Source: AGHT+IHV/nfCCK0RCczv7rc5MaQoZEyJWv13YoEqaPNyFNBNdO0E4u+kR/nXuPC982b+no5YRADjmg==
X-Received: by 2002:a05:6000:25c3:b0:3f1:ee44:8bf6 with SMTP id ffacd0b85a97d-425671b2af0mr8518969f8f.51.1759778025107;
        Mon, 06 Oct 2025 12:13:45 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:13:44 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 0/5] drm/nouveau: Enable variable page sizes and compression
Date: Mon,  6 Oct 2025 22:13:23 +0300
Message-ID: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new VM_BIND interface only supported 4K pages. This was problematic as
it leaves performance on the table because GPUs don't have sophisticated
TLB hardware. Additionally, this meant that we couldn't enable compression
on the userspace side as the HW supports compression on larger page sizes
only which was a major (>50% in some cases) performance loss.

This patchset sets out to add support for larger page sizes and also
enable compression when userspace binds with the corresponding PTE kinds
and alignment.

Ben Skeggs (2):
  drm/nouveau/mmu/gp100: Remove unused/broken support for compression
  drm/nouveau/mmu/tu102: Add support for compressed kinds

Mary Guillemard (2):
  drm/nouveau/uvmm: Prepare for larger pages
  drm/nouveau/uvmm: Allow larger pages

Mohamed Ahmed (1):
  drm/nouveau/drm: Bump the driver version to 1.4.1 to report new
    features

 drivers/gpu/drm/nouveau/nouveau_drv.h         |   4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 106 ++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        |   1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  69 +++++++-----
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c    |   4 +-
 5 files changed, 131 insertions(+), 53 deletions(-)

-- 
2.51.0


