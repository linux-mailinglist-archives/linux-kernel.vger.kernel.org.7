Return-Path: <linux-kernel+bounces-819604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02135B5A397
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7577B18935C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B0284671;
	Tue, 16 Sep 2025 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mASVOgPN"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F028F1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056913; cv=none; b=oIk9KKu9EFg7BY4Yl39I28J77m5EeJOixvP+tkI8sDnYj85V1xt6QP6PrTYGnNIvQiL/ZtAqz41zmxGEALgQr2AiIVTFZu301O832LL0YpsWzAEE4jwJhabl+tUqrqPY+QFQ4ytzE81jRpRJl5PJIkcttSfnO6pksQq9AaJJY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056913; c=relaxed/simple;
	bh=b0tvp9HkVoVWUGRoRD92AJ6HbI5HFdHK3HGpdescOZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N8DOBVACGy6vRnhrBPT+WpPGIV3yP2MD8s9Hk1SflxfilWxajJLgA+SxFMSvzcoQ2v2dgGalZ83BDKOuHGldY6h3t0Gn5ZYg30LgLS7u/7jcBY9LMnHMnRLJiu04vzHUrMIE4eIZe+ygEKamwd4ktfmVq56maiZvlVP/QqRIE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mASVOgPN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54dd647edcso1386238a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056911; x=1758661711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnksU2SwWU4C6GidGC0GSw5ecTfl2Qc9jjuMTd5CwuA=;
        b=mASVOgPNrzAURm/1wxM3M24Pn10bU41ftAlhMY6AbRooMGVL1UVgYKjaFttgUVYkSy
         2LpAmFNGF5fK5RpCGmkVYLOQXj5YFIc2Ss78q4mJQLMkjYA4Ax5pVbujjhSgBTxgtnHE
         lAKqEZ7F2/AMXHKI6BIDKdCAAusaOy95Br98qxKsAp2kvx5q916f4v7lA9kAW6F3UCle
         4Ye/jxvnLCrccdiYfkShsI1LNeimgimzRMyipHi6BoO114vSk5EvkPamoqgQD7hny2Rt
         PBErfSZ84DHSJMQnEkq0WUan9gGQRLk1x9linSicYyfPIOfy/D5pKn/S8HQsbTKX0sfW
         3K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056911; x=1758661711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnksU2SwWU4C6GidGC0GSw5ecTfl2Qc9jjuMTd5CwuA=;
        b=GpxdDYv2QQN0mXUyLzQcFkEYT7m34ADvl9e6cGOOK5/yhQ1L+AkUwP4/NM+66jdWGc
         XFFQ9bfjxQioVURA+lBEo3hn8PuwAQzHMvK2Z4uvTTtQ/3bcCA6Rt7ZyjkaXKBWwJ5kd
         uBZQl3hKgOKMUSb72p0yJxHulJibxf2cg2HVW3yPScbhkxY0z9+07SW4YgJJJRT5mnxO
         FYEzABwY3MKZRTkL8shfwxQSxMKrwrLb4OyGaPzYi7cn15ZuWPI+6INaptlpU8dT5TIn
         4PPii060QCPuWVA5teZzHEOllCM2J/yG65hBiKMq58nGes7zWhv9s4LLPebrNPoIbmlx
         /RHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6HjAqINglY0b0OCuRwo6xWfM6Dlm/XljcLqSqco0TGkIiq6Z0c51LVf2OqEC38mD9Wh2iV9pELVAQII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX19hhlt/Plmfl/vvFPMwv6yk0VTP/wJvYrVZbPRcKKC+V4/JG
	6W7h+qJwyntZzchcUysyruoYGlF1kllopXYjzN/juTh7SqH3ZD9ZM4gt
X-Gm-Gg: ASbGncvtQAluK3kOlwOn0xzOAjUggtqnj91JJAeUMFNZM64c9biKStL6NLF5pDBAqpM
	Aebg+Sd+Xa2PH8epS0nEjQEoudIevKWLL7PHoNZqIax6znDSePT7TloOrx3stqSdhYGAJWv8Pkq
	XCNllP7UG/HQL4hyWyLxE2XAqgfTKBWcrlSqK9/y2DbjPaKieZ1vLnSghezESV1+0Ob1qy0HAx5
	z7a1VaR+aYsYs8wzTgDWP9l4Uff0Txcm8CZHDSqavFkqV18FnD7D/MCZTEtQCpH0r1Dkg/nSx7U
	Yv645iH9PTazao1qGhdVdDplbfw1SkVHGWbIqkvlcTtnVr0VXCRybTP2ziWAnmmcQ6SCl+ceqZ+
	4YJZpwkacrFZkmCkNDjfQfULHE9+U/A+z6UclpCUl4txKvvjnfzkAPdAFyVYAZstLgppVAjCe8i
	R37rTc3aU/Cw==
X-Google-Smtp-Source: AGHT+IFDCNg8RT7iyB/b9XWWvWDI50pwmmPAEJl2QkoNSyYP2rCXRsOqrvEryw3II2ggN4h26fj0GA==
X-Received: by 2002:a17:90b:5583:b0:32e:6858:b503 with SMTP id 98e67ed59e1d1-32e6858b70dmr10303623a91.29.1758056911296;
        Tue, 16 Sep 2025 14:08:31 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35ca2basm14988737a12.12.2025.09.16.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:30 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] drm/panthor: minor AS_CONTROL clean up
Date: Tue, 16 Sep 2025 14:08:13 -0700
Message-ID: <20250916210823.4033529-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs minor AS_CONTROL clean up.

Patch 1 to 5 rename and document AS_CONTROL config functions. There is
no functional change. All functions are now prefixed by mmu_hw_ for
consistency. All of them also expect locking. I choose not to suffix
them by _locked, but I can be convinced.

Patch 6 to 7 eliminiate redundant mmu_hw_wait_ready. This is the main
functional change of the series. panthor_vm_flush_range no longer waits
for UNLOCK to complete.

Patch 8 to 10 give mmu_hw_flush_caches final touches, to improve error
handling, simplifying code, etc.

Chia-I Wu (10):
  drm/panthor: rename and document wait_ready
  drm/panthor: rename and document lock_region
  drm/panthor: add mmu_hw_cmd_unlock
  drm/panthor: add mmu_hw_cmd_update
  drm/panthor: rename and document mmu_hw_do_operation_locked
  drm/panthor: remove write_cmd
  drm/panthor: remove unnecessary mmu_hw_wait_ready calls
  drm/panthor: improve error handling for mmu_hw_flush_caches
  drm/panthor: move size check to mmu_hw_flush_caches
  drm/panthor: simplify mmu_hw_flush_caches

 drivers/gpu/drm/panthor/panthor_mmu.c | 157 +++++++++++++++-----------
 1 file changed, 94 insertions(+), 63 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


