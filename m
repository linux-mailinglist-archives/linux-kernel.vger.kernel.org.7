Return-Path: <linux-kernel+bounces-775903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1BCB2C635
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4326188B494
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5142340DAE;
	Tue, 19 Aug 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hq2+On4+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11342C11DF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611426; cv=none; b=DVX/K+kD554MPq+q4ROlAbs5aqpvN3f1mc/W0ruCDRHLB9SueEpWb/n7yWYUCWMG+6ewWJAHtAcEJryIdcq0UaPcp2sSMA96wzcIS91DZFBdWW/KkLn4Ijd+9TFy4Kf5xDs/mxySoqJ09Fk6nop7BQYNpgbXf5/raTENRHAv1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611426; c=relaxed/simple;
	bh=aPg0EOi2wT/pNZEkViBNqGcjkH5qXe7EpXYJf/CrbjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cbil5KhXr8LAHfehzhSHuDrDwg10M7QHa4oCAAPocz5uN98AgS8bnF8H4YfY1hUuXCe2Dp28S4I/qvyt4jQ68GFo8D4jVUY0dCKZlE2Jcffw7B8Fsja0BTQBQR1+gx570HNu1rzunSnMAvk43Tz/WzMXkbcouoxZOwjmKOF/pVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hq2+On4+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445818eb6eso39884095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755611424; x=1756216224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fLkDwiiUZSss6sfPf8N7ZCd7V1JUEtWvKlq+l/gMKQ=;
        b=Hq2+On4+zn1TOQGV/+8K0Vnh4p95ZhhZulZLEd3pkmkdbf0sDVxkUb6QYc6kDbXT/I
         zC/YeluKV7syUBI7fZb0L1PYfPoo2PoyHA46hHtSRoxkBs2FzX+fPj2ZiVEYONprKdYy
         CZPQyVMin1sME9e8BjkstRzAbvtDGYblhF1bNh0fqvu/BozVVfZokH1B4dFSbwOXuUNp
         pNx7m3VgIyP1N9kkAUgCLYWMymTXMxpF+BNz/NH1cz2UDP/3A9/L7HQ9hO4SaodTD57s
         e85vy04DqsBGDCt37ejNkFRf6NZLY7F0U9BGhoCvxliwc9m+p/N4toHHBcIof9cAZjmU
         YIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611424; x=1756216224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fLkDwiiUZSss6sfPf8N7ZCd7V1JUEtWvKlq+l/gMKQ=;
        b=ndvLPzwOTuMp2J+wLDf7eLV4VUoMn1lZcME6j59jDaIcLfg6g30GAYz72lKirjduxV
         jwpQNdN/WXZRLqUAdFnrWn3v2auIfs5ytOt9RSj/k8FYycBkxv9AxdE7mNW133g28xkf
         mHmFfyZ8SPWS3I7uTZczWSXorJ7w2vpsvzF0iJeO+a0XJW90EdgiiDJf5yTqHlio3U14
         QMJ5dkPI7AIzFE4nkeIWiSuXTrq/BtSjYxTkRk78A+aIzktCf23migcO0V9oedLglPCV
         Zl9S4Vnjr1DxgysAAAF5QmkiBB15j3W0UpQ3mYZa/6/yPW1a/zldvlRMMAOZDX2K8xax
         jKzA==
X-Forwarded-Encrypted: i=1; AJvYcCWDNbd2nnp7c2mwDN4pf8Xn3zwMyUs0rM/88XD/4JI4D8HF+kXZdnPQpkRdqSMHoMSlMjBxfFRIzVK01pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3RWLwUN2zNx4lH+eADa8DfBgjYCq41NI7SiAQh0axuJ3keSs
	6NZv6GB60Ui+wOveStfBger14dqGPSk+ATmKB6HKd3cAxG1HIXojPF3TORpeI4B881BUZUcOxAd
	M4DzW92M=
X-Gm-Gg: ASbGncvOKDrafYe1hVMkHOQlhWY+f/jGwH4b/3UL9CNQOlo9/zQcsULjJh+neETUs0N
	MepPCFf2YUfUKzdDPptIQq1NIfd/4CkuJ4l1IqVRydknb/iP3Iri4PDbOKwURNYzxRuWjCJDxqZ
	Vzmr+ST8TPGRpG6SFN5DjFcpWmlpFBzSSc0Wg/zKTcFQin1n3Gqc1hYnSwp9Oee3cI9EdHQmXir
	cK60YvMLWb6bJlrwCtvjS8rBziqV43cN3ngtJd+Rxx69IvyQiBMj/SHFQK7TcuMRIEqLzj+NU5I
	iMFUyO1CdsvWfQL7r66lL32fgUcEkUhJXKtlL8x/T551qp6tlraBpKdNwQPxqfMH6o+isDQ2Ugx
	n7PC0cPoTriV0FD86ecFa0S9yM8bJfgfY4sQ+ejUjg1VHIIDF2Lgku73b
X-Google-Smtp-Source: AGHT+IESvYgemIySPSxA386V71buITJEB5A1eQjLKfmg5oq42Sd+h+mzvTGReO0QPPNPP/g2BvgHbA==
X-Received: by 2002:a17:902:d488:b0:244:99aa:5488 with SMTP id d9443c01a7336-245e046e326mr36849155ad.30.1755611423589;
        Tue, 19 Aug 2025 06:50:23 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5533c4sm109937815ad.140.2025.08.19.06.50.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Aug 2025 06:50:23 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH 1/2] riscv: remove irqflags.h inclusion in asm/bitops.h
Date: Tue, 19 Aug 2025 21:50:06 +0800
Message-Id: <20250819135007.85646-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250819135007.85646-1-cuiyunhui@bytedance.com>
References: <20250819135007.85646-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arch/riscv/include/asm/bitops.h does not functionally require
including /linux/irqflags.h. Additionally, adding
arch/riscv/include/asm/percpu.h causes a circular inclusion:
kernel/bounds.c
->include/linux/log2.h
->include/linux/bitops.h
->arch/riscv/include/asm/bitops.h
->include/linux/irqflags.h
->include/linux/find.h
->return val ? __ffs(val) : size;
->arch/riscv/include/asm/bitops.h

The compilation log is as follows:
CC      kernel/bounds.s
In file included from ./include/linux/bitmap.h:11,
               from ./include/linux/cpumask.h:12,
               from ./arch/riscv/include/asm/processor.h:55,
               from ./arch/riscv/include/asm/thread_info.h:42,
               from ./include/linux/thread_info.h:60,
               from ./include/asm-generic/preempt.h:5,
               from ./arch/riscv/include/generated/asm/preempt.h:1,
               from ./include/linux/preempt.h:79,
               from ./arch/riscv/include/asm/percpu.h:8,
               from ./include/linux/irqflags.h:19,
               from ./arch/riscv/include/asm/bitops.h:14,
               from ./include/linux/bitops.h:68,
               from ./include/linux/log2.h:12,
               from kernel/bounds.c:13:
./include/linux/find.h: In function 'find_next_bit':
./include/linux/find.h:66:30: error: implicit declaration of function '__ffs' [-Wimplicit-function-declaration]
   66 |                 return val ? __ffs(val) : size;
      |                              ^~~~~

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/bitops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2ba..d9837b3cf05fe 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -11,7 +11,6 @@
 #endif /* _LINUX_BITOPS_H */
 
 #include <linux/compiler.h>
-#include <linux/irqflags.h>
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-- 
2.39.5


