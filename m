Return-Path: <linux-kernel+bounces-879986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC231C24913
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E067C4656CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013734889E;
	Fri, 31 Oct 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAVGLrKR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B9347FED
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907208; cv=none; b=h1sxj8E1OPQMFZTjGy/iwvceobZb9c4SVc9eszPYmZd+j2seDZwUc2Rw+vE9rE52p+4d4ULQshtjc8Wt5HHq/bNArpg+oUQi9/1ic7bC1By/PkE4ZXc26IvWVxH+TowN3lkcUR48g7/O+sSD7aS4dkJHyaMvElXMlyxW39FpC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907208; c=relaxed/simple;
	bh=fX9clgG/AwrnKocsdMCV+xHB+ouI4s9+Hm3T3/663k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evpo7+9xXFNUFoDVeglFXIAfyZmmVG9kswZ0Le+MkcbrNUo/FcCa5l/KTO3eMGlAnR86GCkZwBmDkq0vYzzpb3MX65Z2m+OuHz77b4Vt+Vj+jvNz6AF0QWxhghtfgX7jdKMQXh01AOwaVpYEeQe95LNJdlgsklgUpO+y4IHI2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAVGLrKR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475dd9906e1so12549305e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907204; x=1762512004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xa3/Awesw6OMt3PSs2q2cBtqduLAjKaT7ji9cCCq90=;
        b=YAVGLrKRkzeQSotkiwpeCO+SSVOfJ0dUgCtrAbA0e6UUDwyhKykh4Y3INdlWhio/wj
         pAGyTUKkYM9kc0X4irzBaIfRHj0/cVISJRGxz6DJ1DPeaajmfvdTwkxHCUx5q45P//nN
         NyNdN8pssPmV1tZkLH69HZMhWkb6JA19leWs/RU0uExmWb9ets8NnAUErbL7cowCJTf3
         RrE3kyU7dwyC1iYVkC/buEsVf5bPdYGM1tvY17LoSymp6QVm81HU3qKQVfkp+vKQnR6X
         WQa5dqMpikxdBu2S09g9jTYwOTL1d3UuE/WvbKtlzAqAZZ0deptuhBuXYx0wODSlPRSz
         I/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907204; x=1762512004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xa3/Awesw6OMt3PSs2q2cBtqduLAjKaT7ji9cCCq90=;
        b=Ld+Ns2HRSysaeg/fxaoC8MG0N2MWCkW3LK094+DPal3bPtiWF/vWLRiYrIhY3saVN+
         JHu3Fpj3ngL1AxxD7lIM1tcqcUyix+U62lwOfKJfre+It7G+RE3x31qcBMYrLn13kSkV
         hEjib+RAXFxZCnRuIO9WmVH9LUKmFHSqeFffydPlkoUrbZ4I8TrsVwNvIVWRFqwXAVOw
         SF9X1cB1d8ZpgjuapHERwCWWrzYy9df2Pub5LQhBW0DZ8CyrrUoAp8mWLRt1yPmUm090
         Pc9diBDddI5FPpqmGJM0SY/zSOWTK5khmSslfo5zQHEi9Fy5hEcEZK6Rk+t3OpyyIV3p
         1dZw==
X-Gm-Message-State: AOJu0YzwIX1hFeLIDoK9nDUOufWUGTCYoXHQboUKo7n1S/2Bmmnf8K5h
	7DJIpYj+u7wddE/qU714IySGUdjFZWIIqn8llRifoDF8n8OPLw9XVkmBQaPfKNDWVs6anPv/eg=
	=
X-Google-Smtp-Source: AGHT+IFG1Dv0rjVcEt2/0GVVIUFS+KzXMYU0UsEadz9yjstPJXyipRoXNOS4eHXBONiuPbDNnDbrnIrq
X-Received: from wmwq8.prod.google.com ([2002:a05:600d:8348:b0:476:4b14:2edf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:538e:b0:46e:33b2:c8da
 with SMTP id 5b1f17b1804b1-47730890e99mr28895635e9.32.1761907204019; Fri, 31
 Oct 2025 03:40:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:18 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=ardb@kernel.org;
 h=from:subject; bh=JNFlhs5YlNOgtpbYMnFMguYKcFlrOPN7ItLaOkFoa/A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4r3azVwKvxa+e+bzxvzhjJCoDf0pmzLzjxfveskbc
 3b79c+sHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiL3IY/qmunjvvbXvjWee2
 punuZxcfZXy6++W/uyz//fM8bu+WUnjF8D/61YbAlb+lv9pt6nmpE1ux7mTG++LWrclW3s33r5W svsEDAA==
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-42-ardb+git@google.com>
Subject: [PATCH v4 19/21] net/mlx5: Switch to more abstract scoped ksimd guard
 API on arm64
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of calling kernel_neon_begin/end directly, switch to the scoped
guard API which encapsulates those calls. This is needed because the
prototypes of those APIs are going to be modified and will require a
kernel mode FP/SIMD buffer to be provided, which the scoped guard API
will do transparently.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 05e5fd777d4f..815a7c97d6b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -9,6 +9,7 @@
 
 #if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
 #include <asm/neon.h>
+#include <asm/simd.h>
 #endif
 
 #define TEST_WC_NUM_WQES 255
@@ -264,15 +265,15 @@ static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
 {
 #if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
 	if (cpu_has_neon()) {
-		kernel_neon_begin();
-		asm volatile
-		(".arch_extension simd\n\t"
-		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
-		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
-		:
-		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
-		: "memory", "v0", "v1", "v2", "v3");
-		kernel_neon_end();
+		scoped_ksimd() {
+			asm volatile(
+				".arch_extension simd\n\t"
+				"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+				"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
+				:
+				: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
+				: "memory", "v0", "v1", "v2", "v3");
+		}
 		return;
 	}
 #endif
-- 
2.51.1.930.gacf6e81ea2-goog


