Return-Path: <linux-kernel+bounces-787217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BBDB37321
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDE11BA623A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C026D4EB;
	Tue, 26 Aug 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENfEVuOZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD018276025
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236837; cv=none; b=kGy4z6YgB8+VFwQBVzqa+bpX6dL0o2g9ARjrsvJNQwuEf31eBA+HWJ9qWFnBYUH+4Nj4/qsl3co7imP7kqHGKC4gWM99w2za3DJKrtLzy2oZSnb4h+GmuCDThHfFMeVB2U4kBysIiWzUlPf65zNCcfSS7vkg8grlo6931FiFAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236837; c=relaxed/simple;
	bh=r8PsF1E3JOrI1bgrDUpIgCipEjHGGfteVwfhTPWJTDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVKWwl7vicD/f04zgXCJ7SdWpRrXU0BDEqLahp+6Rp49enbW0Di9idpZH/1tpHCcpKP1Jg2vYZ0nilO+GGqzLcOKa4Mgvg3Fha4L47gh+M/hRRSHF9qsqQpJrMiaajtC+loe6gAIDfJn9MTZDTjnyKOsRBMNdAo0CT4rybJyFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENfEVuOZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77057c4d88bso2540060b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236835; x=1756841635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm1ThjdiITpVs/5qNYlAJVlYwS90i9/utLl/sZfPekY=;
        b=ENfEVuOZUvJVdNF9gYz+6pafI/RAtXbuVFr8MpucXkwXV+CvHAZRgCXHhmGRFxN7UI
         68gKYCjAGQ0wfVd/tUDQYVl+USji8P7qU7IU3KxDEDPUd+cPWJseZihq/tr+spgUnoag
         uz/nZHy5dC4VK8wLpqBN1DzrsjYq1U6KouH0+p9E8/BRjK/0nmpNqFcBvPA8SdfwlwBl
         wRnDjwFwKy5QITl/VX24ptP+0MXYoP9Nh8aK2RxX5HQuuoPvGAXLEdcVp1L3V/GwoXnY
         xSe0hE1fvP+YHQvDJc2txOJmaI2IetsIEafMRVpYO8OoO5B+2WRCKqMyUATBcFMgfaGA
         XWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236835; x=1756841635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm1ThjdiITpVs/5qNYlAJVlYwS90i9/utLl/sZfPekY=;
        b=FJ3t9GofTWhsSw+zwrjeveU/Z8gBV5qziOn49pkhMugScYNyucgQUNh1uNA2gjCvuZ
         cLQnSahFS0R0K0nDMiAOkDpt08eFPTbDopexeESiSwRQqAa5PQiSIQYkw40T+Poihr4B
         tLFJEcBiQLoVNVVNf4NPWFfVFjYGHxjawyxRY3ulEvNH2ig24RwXE8Yh2ZPjbqBWpJzs
         XjJyN6DJhRoid+sz4osJ+T/dwJJhD5HdIpA9MwkPlbOmWnFLCPseyCX87yiOIDOF86uw
         7baTrs3NT/7T8Yr6x+XFQmvwd3/8u3qbVCbsaJxJCH20gSD6knhgXiczHG7/Dfg9xao3
         AokA==
X-Gm-Message-State: AOJu0YxTCc4YlRejR7gyS/+xTYzpHE0PZsY1Y3esZXPIZ2CciMa9KKDu
	zP5hYdZoA2Wpdyoyl/JAxcP64U6TKnn2GvIam6NKt1Po5Zw/wybhhAmy
X-Gm-Gg: ASbGnctQ8CsAQMhz8v8QwCe2HnSg7u3C0j+gQ8k4h/loUxBZzfrCNeZ514AQAtq0Mlx
	cK/Blv3xktJKRMMDbAtxhrXenWgKuUMhjd+ugrkrES/+Ve85pKWus475nKC1djgmCtsTd55EFMI
	INoGNGGt46EZqOuyxlUi6ExYSHnvAW9LCs1SiPDmZUtWCUCkSR5RUv/S9vmYFlUDMnYDO1HmwiT
	i1pIYNlAnF9fwwnq/X6IaK3EXa6nvJ4FLnE9z7mRfGtefdZRipjJ3a1dTq0YOCMrPiB3bZGr/91
	LJqEjS3gxFEXIM5CtriYtcNzbFmX3B4ouZ+BJOZKgwXOhjTAdXywnkB9Ha6l8X2m/70QGIMdwsL
	j/o1PcO8dtMbWsm9Cah/3rQl9kpGGNOiV/A+SHjoNBRAmQEsAAvPXSQ==
X-Google-Smtp-Source: AGHT+IHHTKmoYSq74wYmgloh2oD/kfF5gandE6B1MYti56iY3wYs5IrguV2FzqTpRZlmU+WxRG5VRg==
X-Received: by 2002:a05:6a00:338d:b0:771:ece5:f3fe with SMTP id d2e1a72fcca58-771ece5f870mr7298702b3a.2.1756236834503;
        Tue, 26 Aug 2025 12:33:54 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:33:53 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/7] Cleanup free_pages() misuse
Date: Tue, 26 Aug 2025 12:32:51 -0700
Message-ID: <20250826193258.902608-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() is supposed to be called when we only have a virtual address.
__free_pages() is supposed to be called when we have a page.

There are a number of callers that use page_address() to get a page's
virtual address then call free_pages() on it when they should just call
__free_pages() directly.

Add kernel-docs for free_pages() to help callers better understand which
function they should be calling, and replace the obvious cases of
misuse.

-----------------
Based on mm-new. I intend to have all of these taken through the mm tree.

I've split the patches into separate subsystems to make it easier to
resolve conflicts, but there aren't any functional changes.

Vishal Moola (Oracle) (7):
  mm/page_alloc: Add kernel-docs for free_pages()
  aoe: Stop calling page_address() in free_page()
  x86: Stop calling page_address() in free_pages()
  riscv: Stop calling page_address() in free_pages()
  powerpc: Stop calling page_address() in free_pages()
  arm64: Stop calling page_address() in free_pages()
  virtio_balloon: Stop calling page_address() in free_pages()

 arch/arm64/mm/mmu.c                      | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 arch/riscv/mm/init.c                     | 4 ++--
 arch/x86/mm/init_64.c                    | 2 +-
 arch/x86/platform/efi/memmap.c           | 2 +-
 drivers/block/aoe/aoecmd.c               | 2 +-
 drivers/virtio/virtio_balloon.c          | 3 +--
 mm/page_alloc.c                          | 9 +++++++++
 8 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.51.0


