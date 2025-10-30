Return-Path: <linux-kernel+bounces-878400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904DC20817
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7873ADB12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366AA21D58B;
	Thu, 30 Oct 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXB1Xurm"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCD258CE5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833214; cv=none; b=qDLAPNlQcz3PuZVzFi8YxeOnV6/O0G+wLZUBKTGwlNQQMGLxxNSGWTyFiNqgANKV9q5oSNdPHrKHGAZtfXaYoUprMZJaT5XIzLCBTi8p5LR4x6Mhb9FYZp4FpZAuiO/8nv2covn9Nc0ByLIgWgwAsWqS+QWBc8XznSzJ7bAJQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833214; c=relaxed/simple;
	bh=3DgpKVB/pSLud0xT/8QtkusLF9mlVr6jh1ABunswCBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qro/z2TqU0OGQ0K5jUK167fV/V1sJm4u9VeopA+89B1rS3TeW3tHHajrHGk0zcsJsd77aZCUZ9jaUMtbmKcSkX1MeHxL8BgyJms1zZkJeVJCnidqs3vawYsV/quMyXzIzvpzBDzo8iCLOXVkri6c74sUWgcSJjDcCdEIowvSNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXB1Xurm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bca51so968247f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761833211; x=1762438011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z2y268+hKCDediNpvDReY8JSoVIK2MB3lP7GMYcaQM=;
        b=MXB1XurmwwgRZTZUt5Ezw1bdA7PbeWHy5nMbGM8GvCgTBnL2YktXqaQqjXAIGN7LYY
         wcDOCOrBy5bW8/yxbIiEGqCbX3LvIsEf0U7hcUgtK2IzIxn+BBOKBWkOruoHiXBJR+XK
         T2hrGKvJh8m8jpKPhD0V9w685lc60izu3OyqG8N6sDugq53wsasZzPFa72QOCRQjoYrQ
         rMszMlbGrlAJ9UFCmwMydbeixRC48rGtDE+cPXdqvaDMEQ5wKLz2iqyBpxfhBXKbWQNm
         1LrnfC9baYEiWyMI08+blshEiG3Npxfmrr6C2FLMopgtBQx/khXPpoGCmD/PKfirYmmU
         vRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833211; x=1762438011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z2y268+hKCDediNpvDReY8JSoVIK2MB3lP7GMYcaQM=;
        b=DFu3HGyn+1/w1HSGuhjvO0Zry5xuN5VZaloV1VWyleqfTFhabp4SP5jbrZjftVOSyF
         o0PVsE6Uy2WMc1FwpJ+EnMXZYRBySp24Tp79KPw0KOK8TDsxXkPrAThwqKhfPu7dMACF
         kzbZtvSvViyKH29/uX5r2EPwhZJnp/mWRgKmUT6/0g4AsGag+LESFGUYiPAUtgpCD3ju
         +5i/04LnFtdt/yvNOM2KJxfyBCOFi6Fi3rw1hZ3p4Lit7pYZfZIAviO5Thn4lHwqfnnx
         QJYUKgRoqwWn5Egc9LErSMIoG0o8/T0+lNmwSnh7gsniIZRGyngaoWimzUCrzlMe8YnE
         vZTA==
X-Forwarded-Encrypted: i=1; AJvYcCXDdEX6+yqVloS0yDZuxDJTZhTxtLZa3v0N86dy2byZCglkXtzdBJ2yI9Zt6eOt4hUZjDZNSPh7OYMRUQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4ozfZ2fN4cGiLD8rwkizc/N0JwC+vw//kus+RbRdpa7iMmOl
	zihb6M/hW6FjxgkXz9fCdW59rSy+LlmP4pn5KpSsjJWjNX82vPdRq8CE80SyD9Fgy2A=
X-Gm-Gg: ASbGncv4GINIAv4JaZaI26S2OthLznzH1sLebl+bFLzONhN5mo3lAUXEeld3YFyUBLY
	QArUZobZuS5q54Xegw8SCiDrWH9rionETR5IYIJvoAz+xep9P5PIAR5VKy/htaETBaKSKmj86U9
	yRy7NmvBVIC4KsynY6ZRT6kaXzYyOZ1ZiaG2s/rPRM4ZFTa6wkAwyh2Fec6NP666BLMQBksj/Ho
	6Gjj+Bwss0RAPBZlMdhsI8sDdyJZwEzNeCXUVTY6HQFFe37QuADZTwAGglac78p2BrNspoZvfZD
	G8/uwJPR8ayspLysMxFzJEny2eYfO6kLugZoB3j+RC+ldfyagfndrhe2v1sLr3Omwhk8Py44AGb
	DEKdoqQttxd2pyuF+yueaUTueUrsBC8Y7RJs1dHq8EkxwhDoeFKPjaF2R7nbkrKK7xDLgg9N0HI
	oAhjUaTQG5zA==
X-Google-Smtp-Source: AGHT+IG6drLSzISITQtrS4jmzAyvc6V24O7Wr+2A7hxxgw0K0PARg4Kgeq+PQdUUvgvdHjEJZwIocg==
X-Received: by 2002:a05:6000:41cc:b0:429:b751:792b with SMTP id ffacd0b85a97d-429b7517c53mr2017418f8f.32.1761833210892;
        Thu, 30 Oct 2025 07:06:50 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm33438674f8f.26.2025.10.30.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:06:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 30 Oct 2025 14:05:27 +0000
Subject: [PATCH] dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKZwA2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3azE3NRi3bTMCt2U3MT4pMyS+NzE4mxdMyOTlKTUJAvLxLREJaD
 mgqJUoBqwwdGxtbUACyPxD2gAAAA=
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Guodong Xu <guodong@riscstar.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Clang doesn't like that (1ULL<<(64)) overflows when initializing a
global scope variable, even if that part of the ternary isn't used when
n = 64. The same initialization can be done without warnings in function
scopes, and GCC doesn't mind either way.

The build failure that highlighted this was already fixed in a different
way [1], which also has detailed links to the Clang issues. However it's
not going to be long before the same thing happens again, so it's better
to fix the root cause.

Fix it by using GENMASK_ULL() which does exactly the same thing, is much
more readable anyway, and doesn't have a shift that overflows.

[1]: https://lore.kernel.org/all/20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com/

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8248ff9363ee..2ceda49c609f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -90,7 +90,7 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
 
 struct dma_iova_state {
 	dma_addr_t addr;

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251030-james-fix-dma_bit_mask-624dbeb89afa

Best regards,
-- 
James Clark <james.clark@linaro.org>


