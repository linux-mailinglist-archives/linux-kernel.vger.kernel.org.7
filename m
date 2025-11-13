Return-Path: <linux-kernel+bounces-898970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4DC5672F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D027C4EC2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462E3321B8;
	Thu, 13 Nov 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BIWJUEyo"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B993321BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024058; cv=none; b=f7otUQ+htIsiFpQFBd7o0kW0yJYz+b7e/Vlw0mvXRQWBzRqedLnyFc8mPF6rqg/hTjJvYXYN0Sj2egEdgaS1DHeJX/Gssjcn94eNx87KoiTnTudY9g63qyyOE2vT0LMKWb7ju5VXbEClX8QwMLftA3JlpPV5XR4AMlMhyoIFR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024058; c=relaxed/simple;
	bh=Cy9k5PTF2jHawTbczSDqjkd6lnnaXLzDfsP+BCHK13g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkg/tolloKRIJMwM+apyda1BW57dcNTtkdIT24KdaodqTJVBVjCmyv1EFO2aMMvqF+r6FE0ABK8iZsrbrkl9Q4yhhP0/sl6FlspEjf2KlRlZNIw6EV9HgplEl8pUKwPVOR2zB5X6Ts9Kim2t10yNHZpNie2L8diDTALog8XxHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BIWJUEyo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298144fb9bcso5646315ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024056; x=1763628856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpTnA2MUAj836lGOlG7UmadHMuhVvcz41++jJ9KkuhM=;
        b=BIWJUEyog4nkC7sB3MSt3OiOQ+PE9/ncxPH4Wqp5zmcfF7aBPD0ngPrjTgfydfqGt8
         i5Vyq3lqr2guYorcBhZC9pZRcIOieZ4bnZ54iqhsQ3BfCeWAAGtXhmfExKuuJk5wKxnP
         LKaYK92TP2NmRVDFz7oLcCFi64rvfQRM37uYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024056; x=1763628856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpTnA2MUAj836lGOlG7UmadHMuhVvcz41++jJ9KkuhM=;
        b=qtQaJryIg7eZzUN3pecduq8wfsJrRayu9sxPJZ1Wky9qqSVs7gQ7gJmadSx4G2ZdQ4
         eSaznwy7VhGSC3fm2ur/EukrCEC1N1hqKWkNxgbzRFL2YZXHicpSjuMXsos2flbprqNT
         PJGaQZwCI/lfGLX7Asfk061ndeNleNSbdwtNYXVTdPKHIfhZRnfybWCeaFbcvlaPux+r
         Hd2x7E8QQHmnPpTcCLoSB1cvZTtgKGC6Zq7s9lZGnhhOH63hm+cY57mZcZG0DzipXF9G
         zHqgP/iIOOql1MBu1CKiuYo6qNjBqGHwYCH2p2IgsMoYWsk6QthizyYX/sqkzb18U/P2
         U3og==
X-Forwarded-Encrypted: i=1; AJvYcCWecasrC5MHopm8Iu3ObaRzV4D8/FxNfZ5ccpwc60iCJeLhWNPDNCYf6wgZynYLtNiFIF75TCxYnAk4l2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQzLkTpX9PK9hpZIEqk++SEHEIfazB38pzR+44MOG9g7rXfm+
	20HkEQZwvJRr25mEuZb7S0mWpU3V8W5AxXRIIGMqfVL5lxy3WMtQ6bBtc7Ev5J31EA==
X-Gm-Gg: ASbGncuOozA3HEi5FHRVXp+MMLo0srYpTHO7Qf0i+1UlFnbxOd1504ILFqYRvjUtvIz
	o4Ya6uoyOWYGUZZLRNXDr6AdJyzFXOLypse6NTH3yYpk8Vix4elPM5yaXiAYn44ykuWBHRktzEA
	mCAyN5jvliGRtQEfbDY9Luwnyn8s+vF3FapS5VzmwQJu7QqrXlx8gb0wxQqi6D7pQ1AFnlg6+Ru
	Rx3jHkGQU76G+b+SW9zOxygtIXk0HGtPzegwTjKtEhFCO19C6h1XEMVuLWgqYZM+T/qUct5tFgp
	bwDyKPAjNUvIzefrf9t4WgDCtMLn/X8Dox2fMdZugU/OG9NR8yR/lSSwJPRXPBb++h43Jk2bD3Y
	swkl+KmfpNH2kqhx3KVB/k+ZuLr0Un6ZqyiKoeerKptSpE1ggoNFuJ334QXg9k5BB5YzFKLfND2
	VQOZZBGaLS1tDuPTfIbaTKp13sN4w=
X-Google-Smtp-Source: AGHT+IGlRYtrFj/4YjKWjf1OzOHSeLUgv3Uc7+FXohdQ3S1q8hcdNvpoDApiTwcA0/LloW0V+MPPWw==
X-Received: by 2002:a17:903:19cf:b0:294:fcae:826 with SMTP id d9443c01a7336-2984edeedffmr89237465ad.59.1763024056517;
        Thu, 13 Nov 2025 00:54:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/4] zram: introduce writeback bio batching
Date: Thu, 13 Nov 2025 17:53:58 +0900
Message-ID: <20251113085402.1811522-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rework of Yuwen's patch [1] that adds writeback bio
batching support to zram, which can improve throughput of
writeback operation.

v1->v2:
- moved pp-slot ownership to req before submission (pp_ctl doesn't own it
  anymore after it's assigned to the req)
- do not take spin-lock in bach_limit handler
- dropped wb_limit_lock
- moved wb_limt accounting to pre-submit and completion stages
- introduced simple wb_limit helpers
- more comments and cleanups

[1] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com/

Sergey Senozhatsky (3):
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock

Yuwen Chen (1):
  zram: introduce writeback bio batching support

 drivers/block/zram/zram_drv.c | 410 +++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 326 insertions(+), 86 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog


