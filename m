Return-Path: <linux-kernel+bounces-875032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8FC18101
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7FF1A28041
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B852EA156;
	Wed, 29 Oct 2025 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiC2FtWY"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC32DAFAC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705107; cv=none; b=L7Y5oNu6+I/AApY8PjEdWwmm4HCUUm3uGtFJfxnRJ0aJ3QOhDrNNsV4dlniwsQ2aFjgFg1VYu9hzqCbuFInF+G2eTPiEkoLGWmd1cUR87wND/TJLwZrMsjWEG2JuaqU2P5tkQdickyq9sCQedw9BRTCj67MZM4as4EnsgATwDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705107; c=relaxed/simple;
	bh=08YTXj9mOsdd//EznP6ZHWbSRLCqtaFI6qDk4G3Bc7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qyXCsycOimkTf/f3tSM4C0a3EtQ+A+a9bhddhvHfDJ0OteDMqG/KylzdA906a/hNjHtFogs8TZ5L8nqFUCizVsllh88lUhjHlDWk2kIR7Ni7ZHURgVs3BXZnLWTczV5xh+rEqM+c/LXIpYBLRULPynvCykVpFO/fhzI/k8VtMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiC2FtWY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33255011eafso6281291a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705105; x=1762309905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgNes+rqtOn5I2bD84BLzzymTajy8GTlzB0Zxoozedc=;
        b=PiC2FtWYhNKq6RTBeudntxfHUD+HRLDIbcTLoJ+oNf/5EE7uxmYkGPHwUlyGr9EWgV
         FNIxFMmnVT4N4NjmaV5387MfRLIlogc3DdbXzA48IJh6sW9MxYssUdmjpDZoDf88cr48
         jlEa6rAfzpIPHTtHrJFroDnaETQ1vTFHvRdYA5MPFBPzwd8tPq19R7kZdGECF4Hh04Fq
         cJY5fZXkmrzGRHo08qpWUgxiZ9y+5LurOSeavLVwTuA/+9/+r7/pFMBjpI1HXQTrFw0M
         iK4sucH+wR5Ce9Z9pMD/vcpEWLL5Y68gm0k20DOSRfNmfm4Hyo7cj+gv/q60zPBqipNp
         TWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705105; x=1762309905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgNes+rqtOn5I2bD84BLzzymTajy8GTlzB0Zxoozedc=;
        b=Bp4NK3c8h+mptVq1LVFaezRVIFncMWVG7UF9tUw87RSSAqpfbcAdV43gAxDtzQy+6H
         6qa5Q+myEGLoRby5odhUOu0rm2YgNNKA96PGzgYXTJfOG5tlIM36GePUUDSGJwbW414y
         x6sxawjofVFAnofD0DNHLJ8wj+nQhFiBKAEVxOS1zMxaQXVky/1Pu4snqaxFIxt+JkR8
         774PeGx01amWhH18t6syZ8PnSnnNH/tpKEe6wbOEZueKJ2OdXDBCryCTqp4UVOBUaLcb
         J9NIOI/9UwNkpNA30IjMYXYRMBOZ1rLfWjr9YHCJ+SMYKQASgXGRT+vDt9cAvKgzM2X+
         f9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCURle8dlMGFFZGYaUhbvJqgli7ccoDZO23g6LugtYSJp5qZ929yjSuzWVkANbpxbh+Q+7/xGWQ+624y3Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxG3fHghBJVol0YOsCMDAV1EfxVJGKIhiG8yVnTrYp5/AFVAt
	QcSfZb/Tak5bsUskxqOP2M0GHuZI8LJoEtDuwV+zbb1x01EvM5FwYUQf
X-Gm-Gg: ASbGncu+VbL8oNkC6Ik1+tn3Clh+18+/1poVrvYEYD0ASd+XnHt7updXKsNHHTzyjiJ
	4eBlZzhHzWUDYNJdalEMAl324ARYsGd2cOBvMCLQkhgLMvjSaBPwItArkAvYTpaalbXtzTa+yfc
	hE73Uzk0Cxjx4wjQbQkTXYpvXaghN6HSzW93AoZnlcQIdqZtI+mLrs/vyNXE8MSj4d2adalYraN
	Z2XBvJiQVt2NZJiikT8o+zaVXRWucviqAOwfFUvpSaqOs1fOO7AxFOOZOHBhTzMX1tA+HIKz6cv
	Vwi9/obEaj54+gZRPPOyrNtnqAACNhf4kdpCAezRkpMqxqasvIAHHXk/LtcfUdYh70nYd8DKmbf
	RdkZhi3TVnoGbfnFbRBDBDgH7heNEkdx5QJoBeFKDQ2ZTVpItNcH4H1DSFzIZFVUFMXE0BUlPei
	KeNxlsWl2kBtqdB94SVnn4SdrylW3hQNmeTu6vF/oqAEgq3oIjXoInr02edzr4dIBxoemt
X-Google-Smtp-Source: AGHT+IFLYcFzOLyMWt1s97dTAlOlW5cqBgpRGPsdw/0wrh7IMH63MrfiPstec7cpC1SUbgQjmoUXXA==
X-Received: by 2002:a17:90b:1c8a:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-3403a15d128mr1207767a91.3.1761705105142;
        Tue, 28 Oct 2025 19:31:45 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.31.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:31:44 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 0/5] dma-mapping: arm64: support batched cache sync
Date: Wed, 29 Oct 2025 10:31:10 +0800
Message-Id: <20251029023115.22809-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Many embedded ARM64 SoCs still lack hardware cache coherency support, which
causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.

For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
sync APIs perform cache maintenance one entry at a time. After each entry,
the implementation synchronously waits for the corresponding region’s
D-cache operations to complete. On architectures like arm64, efficiency can
be improved by issuing all entries’ operations first and then performing a
single batched wait for completion.

Tangquan's initial results show that batched synchronization can reduce
dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
phone platform (MediaTek Dimensity 9500). The tests were performed by
pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
sg entries per buffer) for 200 iterations and then averaging the
results.

Barry Song (5):
  arm64: Provide dcache_by_myline_op_nosync helper
  arm64: Provide dcache_clean_poc_nosync helper
  arm64: Provide dcache_inval_poc_nosync helper
  arm64: Provide arch_sync_dma_ batched helpers
  dma-mapping: Allow batched DMA sync operations if supported by the
    arch

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/assembler.h  | 79 +++++++++++++++++++-------
 arch/arm64/include/asm/cacheflush.h |  2 +
 arch/arm64/mm/cache.S               | 58 +++++++++++++++----
 arch/arm64/mm/dma-mapping.c         | 24 ++++++++
 include/linux/dma-map-ops.h         |  8 +++
 kernel/dma/Kconfig                  |  3 +
 kernel/dma/direct.c                 | 53 ++++++++++++++++--
 kernel/dma/direct.h                 | 86 +++++++++++++++++++++++++----
 9 files changed, 267 insertions(+), 47 deletions(-)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev

-- 
2.39.3 (Apple Git-146)


