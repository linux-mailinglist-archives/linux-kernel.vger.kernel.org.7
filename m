Return-Path: <linux-kernel+bounces-817075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79211B57D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21047A81AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E32324B2E;
	Mon, 15 Sep 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHFxLhMl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDC31AF27
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943655; cv=none; b=KpID3tJXM7kTSU7L9pTHLdgPH5xeWXMJEjjfXLDrg3WrUPkaV34OU8XyjTL638uvmQxcsNdJOHF0qEndS64y8dR1irl2BNSKFg7oqoC0AssklqhFmz8eCMoS730O82ilKC2BWaJAoEq+SJzmfpnNsfCAH7gWBfgt4PrxPW0SULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943655; c=relaxed/simple;
	bh=zzmRDyWIbNoIr3Au/5Tj6mx4iv2XRG8hZbeLUABQGtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY9n9lIj1s8uQyJ7yZJozFw9SWHAim/OEcVDJ6HP/t1gZNafYFCM9TyMS4zIFoXztyEYZSoEemSybXA1lS5jsG33pKlTnApCsdk2OvKwxSmlDy2Xi461i1TztnDB0fVD0uxAK9DO65GniKWZLY7yjpTavc11V3vSgcspeXPqlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHFxLhMl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5720a18b137so1962910e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943651; x=1758548451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPM/RQw3qfB6SHnbP6cmmYEVv3tF2K8hF5e6CKHShmM=;
        b=UHFxLhMlvghu94pYV1401VZgySvD87vJydoWoUnSPJLXl/aBPlBAqvw65nJHfmwyv/
         Y5vnOj3Ne42+vIVs6Hf04dkmuqVPQmQiS+tCaevAqLF0IxUrr5tqW6N304wg8yGl9pKY
         pTHny14Uw/Ho9HKfMJ0rR7HN1LqnOzOk8Mce/uosJS2OB7MKhuXM5O9I26tB0dHXzFuL
         GkUaJdpxkRPy7csRTlKsCbKGoBK7eZHONQkx5oHdl+xAjDuW/BaUoMl8HN5VviIkvYrP
         RhaJOu87vnk1u3imnrr5BOoH6axuoqjK5LRS3Xjm+oBMiBEyoeAO6EjYzXPtzskO4659
         DeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943651; x=1758548451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPM/RQw3qfB6SHnbP6cmmYEVv3tF2K8hF5e6CKHShmM=;
        b=lL8CpsDdBf3h/bf0WYvBm9OANDrXMReu4kqMgq0eVMI++UQT03kKPHYlNAe4kNjvfs
         EcVxHuIHQzw2oouqA1rymclNOurNDVVgQnxtzBbtYNNiXBKbB5QK9p6yq7w0pnqjjpvb
         +tzR64EeeWAQvpD3vXpwD0sD5msVPlaymYkX3LgrFQXBCKuTIbNwEL8JMnzak2CvAhtg
         +r5DOKSNJ60a7f9o67TusK1wbpZVcmirttSIIaS9iozO2UrFKWTxgkVQ66J1Xt7x0xHd
         iSQUiQ1DMde1l8kShjWHbdFKdM2VH0N+eJqbaqhwS6NzxgTJib3phr2GJ+6Uh44naawT
         6ODg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbbOnF6M2v2NhDr4Kf8UEwLYVqDRuhn535TrImCHqOGgHAjqXBu2rFzp2aILUfCcx1cPquR+odo+ybUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCeNywlpo7NZCXCZHNpEzCboAGcWd0vf+OQVxXg9W/pM70pxq
	Sg5VqX2eVFJz3WEpilSForJEvVfHqaeE7aeCxDsGFFT8XWKBQCYDK8Uu
X-Gm-Gg: ASbGncscQPKEZly7UvNpZ+0afW56yKcG5wtiTa3DyuHU3ufVAX4gC7rDC0AnZR9ZH10
	NCKvI12Jh3MRbeGwaZyiHfgIz/GD23puto5QtBN3JBcWLzhTImyFqcsMsBxWXIhQZ6Pn7hDfj1J
	YYLkqCPJ/f06vJnkTFiJ4beTR+31L1NXym5anjbPCcXo7v3YteBC4mrAPGCuVu+T0QaS5DA0+2T
	JhTWbX8WaDyy2YCEsRSBa2vvzGc0HghClcUhJQojctakFrnWS4lcT9EEq+VJqOB5ZpXcpj5TwYq
	slorQ+PIZzrKWXcOYneKHUMbrMEHi8CAMRb9S+c7J2UODDEZoV34DH86vBxVIi99d1HAnQc33u/
	Llk3WQa0fWHF0olFOysBmYuW33gY=
X-Google-Smtp-Source: AGHT+IHWeAiSGD+Y8L07HJ5oJgNmCTN7ELdgooFHDZo/26SY4EvrD6cS7mv9RdmLYMUc1s119miMrg==
X-Received: by 2002:a05:6512:3c9e:b0:55f:6f1b:24f3 with SMTP id 2adb3069b0e04-57049f1a38bmr3720025e87.15.1757943651044;
        Mon, 15 Sep 2025 06:40:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 09/10] mm: Skip might_alloc() warnings when PF_MEMALLOC is set
Date: Mon, 15 Sep 2025 15:40:39 +0200
Message-ID: <20250915134041.151462-10-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

might_alloc() catches invalid blocking allocations in contexts
where sleeping is not allowed.

However when PF_MEMALLOC is set, the page allocator already skips
reclaim and other blocking paths. In such cases, a blocking gfp_mask
does not actually lead to blocking, so triggering might_alloc() splats
is misleading.

Adjust might_alloc() to skip warnings when the current task has
PF_MEMALLOC set, matching the allocator's actual blocking behaviour.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/sched/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..dc2d3cab32ef 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -318,7 +318,8 @@ static inline void might_alloc(gfp_t gfp_mask)
 	fs_reclaim_acquire(gfp_mask);
 	fs_reclaim_release(gfp_mask);
 
-	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
+	might_sleep_if(gfpflags_allow_blocking(gfp_mask) &&
+		!(current->flags & PF_MEMALLOC));
 }
 
 /**
-- 
2.47.3


