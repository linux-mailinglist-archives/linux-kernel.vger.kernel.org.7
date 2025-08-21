Return-Path: <linux-kernel+bounces-778825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17989B2EBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E9C724117
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3622D540D;
	Thu, 21 Aug 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxTbJJqq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80372625
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745437; cv=none; b=jZeL4nS1bFqkS61PxZsNbAJwkrqAJ4XZBD6KRT/xG6mJLJL5IKVosVRvwSgMQw/shlVeVZJyleRdOxhBiBPRxIb9uONRa6WJ8zV9qy/hMxUFzpHrrMx2CeQAqzQazld0RbaQaNGyLlZko5e5QuSLvKnzziDMcwWuyakiutV+O1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745437; c=relaxed/simple;
	bh=WQxV8eCKHDLNTYuB8FbxXXtqUtwpbbCpHsCWGZ5+d4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LeDXLvwJrLv8ZPnSk1N4TdU/5irjDJRQnAWUfQRrD58+rHF3kimgEZnAqmN27kBoBYweqNanZlgkLqlcLJLDzRaqaU8n23A4Lrn3+AS8FZItLttizmCHby1gJ6gKgr9piiWvE05aYrr4CLm7bZqWnBQPsBRxZgRIZVKZe+fLUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxTbJJqq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581187c6so7412965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755745435; x=1756350235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsyX6nC2qbqoa3IXoqz2x0SSkvlofANuq+KCkgDhw1s=;
        b=QxTbJJqq9OFEoSbSAmDvGDR+vK9UrFvowhqeRG5QcbTiYp9LDhOCvcnUOOMKxklpci
         MZoukyNKWHtH47c79aRZMigr3xdrcDhHmZI4RG4JycFEUnvkt3/ykVWGxN/6sdOW6urf
         wQQ/Pipr3DrXQsNcDFNVSQyPJgotV8GGJgW3fYdTAvF0nxZlx10AUxpFaBYbGIhPEwG+
         mH6pZKXmdc4BeLgOhzR14953CVEmwfp7uZxdaTnqkAknh9XdEPGjjlPvbzAdFsaIPAUi
         EbvF8UXl/cjpV9ST9BiRTNTHjIVswtcAdlYQqvk7Nmty50RghoFJyhtjln9dnHga5t5N
         HcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745435; x=1756350235;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsyX6nC2qbqoa3IXoqz2x0SSkvlofANuq+KCkgDhw1s=;
        b=wjst1EMoUgiWtvgwrjkkzAxwf5OJJAjoG2CaVuEaXOH/YQKbP/+1n2IfXviFL1plyG
         BhZfBurscBICbCFabQ2onOHH7UaqdJoKVURmA956UQBTtURtz5L9Ss+QQgLaVDi1DiD/
         WWfDziQfutDnC+JhLGtbIKcfctKDKB3djNMPfvQ9cWnqB62z6AqXtgzFyAvsPkWEf6z+
         mihbMBV7LFkr/+CnDwJxLNH1k1Kkw4vIbGux2zSKL8DG6Tiu4K+J5KjHuXQuXYfclVUz
         Iszspwin3585YEFWLe+Fe5jkhpJDGHCZpQrp3qrXDr+SE9rti/mpwTvYNCt++vJ4z9/n
         N8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxivyZIqXjPdcB3Fmke4BILEguItCqqpjdbY6qIpGGT85wnR55iHDurFIHn7LB26lJBgWHXnPM15T6UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8uAd9cwcMgTQ4x1T98Cs0uIn6YKpsuSMcJQigE/ouSpfYmrc
	+Ckk53kWYSGq2zKXYrewpjnCFWKP1PqRJYCHbobhKa6Za/0gjLcb3QzdWJDXRnBrG6w4ANKfVoW
	U/++fJz+Nd/Weotz6WPaSjrdpOA==
X-Google-Smtp-Source: AGHT+IF0xP14Kr/6iRhQeskJ7eOXNJ0cD0inA3ghPz9y2YArBHaAeKeUcbp0uSaUE723wItGWda/EaS2MDoc0Rymdw==
X-Received: from plhv13.prod.google.com ([2002:a17:903:238d:b0:240:5505:5286])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:15c3:b0:245:fb83:25da with SMTP id d9443c01a7336-245fec07a9dmr12898165ad.22.1755745435498;
 Wed, 20 Aug 2025 20:03:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 03:03:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821030349.705244-1-almasrymina@google.com>
Subject: [PATCH net v1] page_pool: fix incorrect mp_ops error handling
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Minor fix to the memory provider error handling, we should be jumping to
free_ptr_ring in this error case rather than returning directly.

Found by code-inspection.

Cc: skhawaja@google.com

Fixes: b400f4b87430 ("page_pool: Set `dma_sync` to false for devmem memory provider")
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/page_pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 343a6cac21e3..ba70569bd4b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_ops) {
-		if (!pool->dma_map || !pool->dma_sync)
-			return -EOPNOTSUPP;
+		if (!pool->dma_map || !pool->dma_sync) {
+			err = -EOPNOTSUPP;
+			goto free_ptr_ring;
+		}
 
 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
 			err = -EFAULT;

base-commit: c42be534547d6e45c155c347dd792b6ad9c24def
-- 
2.51.0.rc1.193.gad69d77794-goog


