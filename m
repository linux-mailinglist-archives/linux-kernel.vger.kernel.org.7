Return-Path: <linux-kernel+bounces-722683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60711AFDDB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDFA180000
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA61F17E8;
	Wed,  9 Jul 2025 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdeZERMm"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30F1E9915;
	Wed,  9 Jul 2025 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029279; cv=none; b=ry5qfFy6zaksm6YVTTx1GSf0XANnlU0ka9V9KowQtbhhCQ1efIdS2IF+FtPPsL4GtUGYMMHLZQMDV3nTm2tmrpzxYPJyPQCuEDvzglhWsYIQqnyZRLF9S6qnLm8oMw/lhDIYpTbakjy2lCqVOIJJ0b5IdmYJz3js0KBPnaOcIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029279; c=relaxed/simple;
	bh=LYCvRX4GND48sxZPjt/8rvX52pFLQzPUFx/IGFXepak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYRpjshnXpFSnRUnBKIYFWcN7iQQ0NAO/FBcuEQz1Gm98TemloJK1WNC7uLsxvDh4MTbA96hZC0ZRHMYxJ6w4YUpke9a1aVCAE8OfhEnauYYIM/vUghlLe5C/WLx5On9rTuRFKO6Wlg4ZS/L1BXnSfLBAPQSg6chuLWooAQzfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdeZERMm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso4440720a12.2;
        Tue, 08 Jul 2025 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029277; x=1752634077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt3xJUsmRNuFj7mVdok6VzjlqWA5ZFnW4qry3w6ipOw=;
        b=FdeZERMm4mntj150gb/UVP6f4vyVCTHS6oKQLUiwlstILQz4Ziq/sIb6LCOaprVTVh
         L7SkDFARlPyH9kcm5gSXOQSaN9aWYfUcAFW4iEOCx8QahKmFqbkck6rH7ABBb9OGloK5
         R2bp6tEwm8WmJKeI49W4VQFVpENNVMOSbEvhlkVuWU5SErZH/iVlRiDK1eWqT2tkE9yJ
         BApYNyLMFpf4SIbU8sGZYVgk8IQsiyL8ba8ouKaO9MPhTEo6AJ8EbpNpKCOoQiX7Osdr
         iYhiQwxOt8KYkD5n/ysvG7iSpCFJQhG89CG/6/ig3MdnnAlLqnsORqPUpFm5+Y+9TxbL
         tV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029277; x=1752634077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt3xJUsmRNuFj7mVdok6VzjlqWA5ZFnW4qry3w6ipOw=;
        b=acf9EKNmJFEQUxF97SVYkpEKVsNFOhumzKU/2uPu6S38vqFC5tjGpDLK//baTGxd6U
         mIF3afYMPPWKxMzVLx55ClJ3hJO7gDhNmbaBjG6BBFV6orzBh8nA3GFRXgAFUCGf+A4v
         BcDoqk8tO6YyDWsm/GYz5cEGfYqv5ghp50jhVcCOVFU4zFeVOBKBzhk+6+eAJ8GX1hZ6
         eYCAXyu/Ql5b/jvFeyLJCjC7jN8xIh7MGU8RqmG2EckBCwhfq1erHpG6ztBAVcoPO60T
         e8ryK+YFSJY7HQzP22TNJxrAe4kQBi0+29LVI6jpb7Pi8UNuFKdfAeloqYDptR2mM7dZ
         92Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVX47mpew7feVg9TKUAeqxN4hh7lfPe/ieLt7X86iZZH2tYKL4uToUFi8JPdA5P+dx7ZrAEoToT8sSD@vger.kernel.org, AJvYcCWijbwOizn0Jl3fFHLfIuvRvKV/UsBo7djrrsn18/uCAkobM9n48c1+1kC1vOLvCSnwh2qiv66weqjioRZ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0cuHhPPnVBl8MOmxdzAi3TkzgPK4+Jy2uQwite50rlSthKf0
	bd+EUDp+QavpDSceiypE/exxJWAYwfmBHQ1m3FIGpB0A+4z4hhUT+wq0R+3YAA==
X-Gm-Gg: ASbGncuFxlUKV5ZXNyGWvuoKnvpZDEV6U/HIzDwWOysKo2itoQmY0mN9rjqXi5E9iNN
	a9bC3lXMhUF+hlD0swUs3wdVQ7NuVIkcfzNFJhpz2Emh6IJx9bihoG99qzkY+5gDYJC3KWfFrUZ
	7Fsr77UEgIvK6+6tn6F5TsyWP4CVvZ0lIVjVShlbL9c3kPzWs6azJH6xfdwyUtbqWJrjW2QQ1P7
	jrACnKfamvrztronyWCWxMvRN8/sOyxs9JrVRLajrFNtet4Ccrlzd4kliA+67MaMyqW25yblXFc
	W+D2CydIfj1yq8fZUZA+42mAO6mvOL2MnYBDOR/dfsOquRQMPuXgASWC9y9thBaNRYjG3Ezby46
	1OsY2qAJY6JmcfFo=
X-Google-Smtp-Source: AGHT+IFfJtz8y+bke9bUUcK/cGdmMuoZJtCIDSrgjZjmUgo+3c2EkK2UtetMN3fEwLU/at8aN++NUA==
X-Received: by 2002:a17:90b:3ccb:b0:311:ff02:3fcb with SMTP id 98e67ed59e1d1-31c2fde5a55mr1376797a91.28.1752029277227;
        Tue, 08 Jul 2025 19:47:57 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:47:57 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: reset: add BCM63268 ephy reset definitions
Date: Tue,  8 Jul 2025 19:47:27 -0700
Message-ID: <20250709024740.194520-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for resets in the ephy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
index d87a7882782a..676a62c9777b 100644
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ b/include/dt-bindings/reset/bcm63268-reset.h
@@ -27,4 +27,8 @@
 #define BCM63268_TRST_HW	30
 #define BCM63268_TRST_POR	31
 
+#define BCM63268_RST_EPHY1 0
+#define BCM63268_RST_EPHY2 1
+#define BCM63268_RST_EPHY3 2
+
 #endif /* __DT_BINDINGS_RESET_BCM63268_H */
-- 
2.43.0


