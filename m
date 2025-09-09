Return-Path: <linux-kernel+bounces-809151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BAB50949
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281315411B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318D2877E0;
	Tue,  9 Sep 2025 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRHSjRuW"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891B2B9B9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460855; cv=none; b=Uh5fQ3xlepxkNsnCN4FTcHqt+32gzxl2Z+5NzIf8QoaAdx2aXcvrTmEF4+0qVo8TjzSzIZ4UqB64r/RdYVLbOLfPM9vIRLOGPrx5/roS/7EniJRoTu74s/PoTLqcwHgy3jKCFUm9DcZ3iZ4GFpC1fWJOm1/+NV7byZ7Axujt8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460855; c=relaxed/simple;
	bh=aU0USlCcTiMH13AEurHM1ttiDB6pDNnBlhK6LZetq2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B464IALCTwCi2xTQEQvvs0vimu+aNmkmZ9mIv5YfMd+EKKh/HQuAQaSUag+fsAA1fCV1nAWf51kGJ+u/8GF5+47NUnF/fO7VE7W0FOZkKhQPrZDB+Nn9UZMrObCmPYOuUKwasNhy4C7x3y0mVmfy2K5wmnUryoQpj1Uh9wWf+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRHSjRuW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24caf28cce0so145727045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757460853; x=1758065653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXSTG2Hw61qjXt22u9sHybV2+YxgWVuc3hF7N60zsf0=;
        b=FRHSjRuWFh2OIu1ZsMYwqZyV5VRUbpa9z9srSdO4+KNqHN7JUWoQGDs/T7uF+EJW+P
         1yXexTSfKpz6h2fcIfYh0srXJb7P7kFDEbff98uJzTmrS5qCFzUZ4kdsrsCKy6wPThGq
         T+C3AlQH7zhobR39fSL4y8MAcpnE/F4e0Sokw4x41Gr7d+fmLA6TqwgTctb1whg+ML4K
         bNLYs+u/V0rDuSsX6tzr4T1wJKGnKvyoxTVVSSP43rh26LtRJZqeCM+4eYAAwAVrCBdY
         6tKIxcjAG1vSOW8rNT8/SAM4PkK7cgjCwv5ttFZCgrvEA54GKdyTt2cEGoczbLC/nUIG
         ZEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460853; x=1758065653;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXSTG2Hw61qjXt22u9sHybV2+YxgWVuc3hF7N60zsf0=;
        b=Ukgji/Yb6z5BnHT5gns+F3N7btAbEg2MafwomgNpjKGSX8H/eZacVIa2N80EVMW2Zc
         Zu+fCM5Zs9X+cYcIR95ADyWO79zzSv4R6vSRCs/IMGbBK5MIuNH149Yr76lsNoRbB63W
         mx91z77X01nQTuBKPTIh7wnrqKSTZviIPaQOH84JT0LFU/JiriexM5adZJYWVesJFzu+
         ENiuG+1rY9wwdPDPEHl5HvIGfR6QzazCsIBY3TWzkmHOCQCig5Q7mXIkAmioQPIjsG07
         GvhPvodDKN5HSzxX/5fJP0bCXvwGpmiWSoCzwwSi2A9uCmfaXRG1V5zWKzLLgSgAlonc
         cSow==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+L7/YEzoDFT6c9+iq5qMC41TskmrFv9Mxtp2p/mWRvW2rD85ak8spKPKZT5J3h0clJskFHAMG6J3B9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBktWQZC4xBClvnPTtqSju0pbH1fO1TzdEkEKrNQS6bdXd03B
	A/gV1BvviwJ3HbmkDZTSORyO17Sw3Zw6Wxb27H7ipTvr1UZ2Qefu0vaTnyJoy1OBeEyHxxs295f
	OyOG2mg==
X-Google-Smtp-Source: AGHT+IFJgHZa3+zvruFKL+nbXgevHIEGRIktfPiZlMC9mp0yCbO3eiifrGu9e5eBy2AJJ5ymyuaa+Bx3oq4=
X-Received: from pjyd16.prod.google.com ([2002:a17:90a:dfd0:b0:32d:851f:b1f0])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e848:b0:246:d70e:ea82
 with SMTP id d9443c01a7336-2516ef591e9mr226436865ad.5.1757460853523; Tue, 09
 Sep 2025 16:34:13 -0700 (PDT)
Date: Tue,  9 Sep 2025 16:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909233409.1013367-1-surenb@google.com>
Subject: [PATCH 0/3] Minor fixes for memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Over the last couple months I gathered a few reports of minor issues
in memory allocation profiling which are addressed in this patchset.

Patchset is based on mm-new.

Suren Baghdasaryan (3):
  alloc_tag: use release_pages() in the cleanup path
  alloc_tag: prevent enabling memory profiling if it was shut down
  alloc_tag: avoid warnings when freeing non-compound "tail" pages

 lib/alloc_tag.c | 17 ++++++++++++++---
 mm/page_alloc.c |  9 ++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)


base-commit: f4e8f46973fe0c0f579944a37e96ba9efbe00cca
-- 
2.51.0.384.g4c02a37b29-goog


