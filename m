Return-Path: <linux-kernel+bounces-870040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9CC09CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DFD58036F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43E313E12;
	Sat, 25 Oct 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k61x73+Y"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0B31352C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410020; cv=none; b=GnErW9z3OJccd1ZZCD1/i1W2sVHs6VW1SB58JRoIA42HhahDEt/pmxRxNW4RKJaCwGY+Sl6Pyo3HKKfDq209jUOE2d723sAY7tIJymiv2QiQqCpONnLTG7cbyLXegsASdttJd3LjXb8YiWllPyLXKiaJPqgU4dHJIn63TZi93gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410020; c=relaxed/simple;
	bh=7GwbfwFI4OnHwDpWdSIvynNWO47LZso8CXPD0pWl0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgQrFLLCNo4ArHHujz0phbaJV3a6NaCVzGIYaq2SfQ11yS0cnvWJrq1hMCBWkHBhxNx5DOt9Qhn/wl5m7UVc7409zFVhyJX+rVVx4VCsvrD6v9Rdq9oc5QqYhwALg88FHwDXXBJZ+EnV1T2ANNQGcm9NPBDN1z/K9aRzMx+rYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k61x73+Y; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so31066506d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410018; x=1762014818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=k61x73+Y1RYjuUy31WY8Bh5vjekgdLShcM1zhnsOhVlzkYY6Nlm9ftAa5Q6NQ3MMw6
         Q1OcUXhqeyV1iogg1y9xps6jNUErn75QVfXIfwBeFV980xGjDaLF+vFwUUb52Mw1toc+
         SuyY9yls6ExAltaagEBPCInvdrjl4Nn3ECeS2AFA4+UW5OA3IR1fZXHge1fLoDczZHvD
         mLbqiQRShAWLI/5e5Ygf5gjk7rcSWpDiSyHOYAX2hhauhSxB7bWYUfi+P0wI3T/r7XZW
         16qEImeIIL4h+MB4wZRwh6gwAtulubNFg+sFy+4Cl/gnPoB0QVRDaeRieaKyF88rZ91j
         G61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410018; x=1762014818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=Xnq7nzih2nDvx77kdL+bHiLpVdFmaYhF8ESt+OCyJBfH8FuUXmpzZwKHCnRoVG6O1C
         v7NvxWux43DowLYKfLxoCfn/oax/l8i0JVqNQ+GscXi8sTvsIcG2O93tRmZ+GKvZwj10
         JnSk+pfIntGuQPas3i3mTo1UaCzoVhvWXuMRzlT9lyvn4zEKmSBqHo6UbJXaDWRuEMs5
         1DHuNuBbByB9WajCQaARs5m+nGIjLC4wJz3HOdkulT462LjyWJOcQcTzVKaTI962bL0l
         Tx0D8LgQEH+xLSn8QPqUe+TBIkjVbM959werk9BfDya/FvIRRme/KnUJ3K9h/9LbX/sv
         pH8w==
X-Forwarded-Encrypted: i=1; AJvYcCXBHhlfFcu18I4f6P9AG/YFCw499+i2aAJ+JFV525nRsF1w33RRObbDfb0QNjpbzGpZxHMHE3emWo4KcVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPss8zE+wL41guud36pqhMim2tWHI1xhhwfZy/RTpsiIBTMM+
	+QG57f+053zE8B6jK2kXOVAfgwz1nG9ZL1eCIWkRUPp2V/7HhfZ6+ayL
X-Gm-Gg: ASbGncvxiPYrYla4n9ihdd/rCWMu+843HR04ivGikhG4zipAkIrhbI+h8udjkxt5qZL
	PNVjDIMxlrvT636TN8IuqUyflFdfZamjcdpveNz0XVNAZsLVREEGvIZl0mFG8ZY67vn7aP0ZLty
	XYMhp1FzMG9Zj9Fx2WlOjcnyJK/y+wu4CueirTubmiJzKpokHwdzz8QU2LeKMpCZvpmM/xUX/Hk
	hlfNkUqgD3ph6fxeeDduoyDBSTwXrcFZJXVkD13kado3BFEYXszgrBhr4/5uLpJ0bLoEMK1lhCc
	45TlteY7aZkbAd845P2FTBnL4qgT5xGGTE/9wnGoAk9djOdNCEi+sRusyhA9zbNx2qBEGX/QZhb
	Px5polLKTDQ3DiG3vUk8gQ9uYB/cPYKfloXeYl1CMXXUT0ltE5Yzu2cgZmk266gVeuUNVse6qnT
	ezRp7MDR8=
X-Google-Smtp-Source: AGHT+IHWOynP91XK0eWWEmP39+HpO2WIYG1FD6QWp9GErpLHI7PIM/nM4hfHX/dVKVXslC7yeirnSA==
X-Received: by 2002:a05:6214:508f:b0:87c:27c2:2c0e with SMTP id 6a1803df08f44-87c27c22f10mr333708616d6.59.1761410018091;
        Sat, 25 Oct 2025 09:33:38 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8a1bsm16461146d6.8.2025.10.25.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:37 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 20/21] fortify-string: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:02 -0400
Message-ID: <20251025163305.306787-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/fortify-string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b3b53f8c1b28..0c95cdcca736 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -11,9 +11,9 @@
 #define __RENAME(x) __asm__(#x)
 
 #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
-#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(BITS(1, 7), r)
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
-					 FIELD_PREP(GENMASK(7, 1), func))
+					 FIELD_PREP(BITS(1, 7), func))
 
 /* Overridden by KUnit tests. */
 #ifndef fortify_panic
-- 
2.43.0


