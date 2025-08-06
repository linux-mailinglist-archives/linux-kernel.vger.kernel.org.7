Return-Path: <linux-kernel+bounces-758029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C88B1C9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6807F3AA0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D11289808;
	Wed,  6 Aug 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG+LElRL"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD1BA34
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498612; cv=none; b=kRV0jlEdQGUsIo46UKFdsWfVAWef1dcR8RlB9j93vIRCkFPA5Fs8BPEiCKByO3LSMU4DWTuwojNzcgC0IwNn4KMj7nGdQ8CCkk0VipGh9MIOq9rE2IDWTw2kKtkMBrDvnf3vNYU6yxkBtc4qENS0KKfMY0hWbBKXS2OdmuqNWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498612; c=relaxed/simple;
	bh=kSmjvSRxf/vc8KCM0gHJNuyEzYMbeq8aru0dlXWOIng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcwnbhSiZYpYOrsLgnvCfrcdTanid88obk9VMIq8Hj1S2b2cHwTvnVGdh1PJCNVo+8r1QTQTGc4pf9VLnQny18OYeoBPo/NRAyY8m9I+WV7GR+VdiCIaz8aY02IZIq0J4UkxcZb4+NpFlpG7o2Scb9dT3FV53mjJP8k5oroC0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG+LElRL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e90293000aeso85148276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754498609; x=1755103409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfMoFOux/IwUTu8sZ3bFuS6UukRdux0VsKTWxNGPjeY=;
        b=fG+LElRLMKd4qLs4Sc+J4AggUcE40eFZuqdnG70jTBbEvgfDiw1gAcDww7eQgfAN3a
         H/9si+u9gydzPRIWQYx9xupVKS27EiJJcBb7ekD/efsTV2Uh5mlpS0yiQPPAUBctfWa0
         gLLdgMyezqyzQQ0E3b0afzkcueHtuzGiyIzxt3ugFPTnY5shmJ1KbglnIg1rC7AvzzM9
         KLkbK8oZgbdLQLFSSMgIeC2wMcntqLu2vWKrCmR9JqxrQ5Vj6ZXKNmbBY8ZZrpDQreC8
         D9b+oG6ojVO2+Ng+HfMb5g8mNgvfTHDu4CawjoxfP9M1JQzH92bIxaIF8jG2ujSFraSH
         4R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498609; x=1755103409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfMoFOux/IwUTu8sZ3bFuS6UukRdux0VsKTWxNGPjeY=;
        b=q827/3Jyk4SWTqv2G71/8Fgxv1tUP3hd9pUg7BlJ0UunnJ4zqoGrjQ51RN1aNw6/1g
         jfM9gZb4WdG3Ljqes8BOhNp5RGsiVeGrKHXRUXOfaswN7kk3c4gzGD8lEWY/p+fSSFwC
         xVoxjPwZoMLgrBrR9cOfKXpy3Slt0pdkHcwaOa2aEkjcsbcRXv3V1J0jbd7qh/vwKcgX
         5BnTiJbskKi3Qz/7k6YDgzM2vYwZBptt3oliYZ9No4pXl6XRN8RviVRfaYJK4WYqaTYt
         nkJUfKDvsV46RR0le9ynzeVUsZDq+qsdFK70t3GzFOenSnNrhnX7mGtXG9OP1Ee0krw/
         l92Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf7KYnofYy4f/6fKCGMiZG0zMzzPKMx9zL7RCMp+TmOfbp5kpf9iygz9ptRKNiXct/55hFf3ZB/fprqcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6LEcSVM88iBUY9R+kCF3IR2hcokOsrneusMQkjHdnw+xVSF+
	F6ZK1UX6qaO94S6AiJqUkHs3190HtF73fsjBKmBiCkZob7W3gahvYTdAbEhikA==
X-Gm-Gg: ASbGncuhFIYf+DtuhyQajg88TUT8VF74a2Ir3qA45UAR4/Ys5otSf5bOqF5verQnf1N
	p2o53kZKCbFxlNHW6zZ4i/cHmeM2iaYYR0osMdkgkHKdB5RLjoPL5H7qvTqhPhsWDDsh4u9dhxJ
	pdus1RAMPbiw7Lpdz03gRYe90FpVqun/RBVRgW9ambQgA97VeP8fbvhOPK7Rn3xByePc2cRFTo6
	eNsTYIUNujF9V9YDV9d/UMU3gpGTdsv6hVPJl/kxN2OzUvE/lFe/vvdAVk4a2YLLyQwna3ryVG8
	by48Qw0dAVGrfq3D/d5sv4NwNRBcp30frHDZyThoOiwJoRFGIQmJeyOotkPIU2TSjG5pdMydcBi
	jZoY36ehJYEDXrVffafg1P1QQ4/wvo7z4lJR21XdKbDk=
X-Google-Smtp-Source: AGHT+IHot5TzlAaP22OS8ozlOyxx1qWLdYvYF4U5lEEd5hmBmhG1Y0KHe5Op8KEKdPn4Q6MVr9HmjQ==
X-Received: by 2002:a05:6902:4a09:b0:e8d:7b84:cb46 with SMTP id 3f1490d57ef6-e902888c89fmr4326980276.32.1754498609332;
        Wed, 06 Aug 2025 09:43:29 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:f6a5:255b:e469:fba9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm5596151276.5.2025.08.06.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:43:28 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
Date: Wed,  6 Aug 2025 11:43:16 -0500
Message-ID: <20250806164316.5728-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
reset, even if the sample interval, aggregation interval, or ops update
interval were not changed. If damon_set_attrs() is called relatively
frequently, such as by frequent "commit" operations, aggregation and ops
update operations could be needlessly delayed.

This patch avoids this by only updating next_{aggregation,ops_update}_sis
if the relevant intervals were changed.

Cc: Bijan Tabatabai <bijan311@gmail.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
This patch came from discussions in [1].

[1] https://lore.kernel.org/all/20250805162022.4920-1-bijan311@gmail.com/
---
 mm/damon/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..1c3d8b92257c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -693,6 +693,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	unsigned long sample_interval = attrs->sample_interval ?
 		attrs->sample_interval : 1;
 	struct damos *s;
+	bool sample_interval_changed = ctx->attrs.sample_interval !=
+		attrs->sample_interval;
+	bool aggr_interval_changed = ctx->attrs.aggr_interval !=
+		attrs->aggr_interval;
+	bool ops_update_interval_changed = ctx->attrs.ops_update_interval !=
+		attrs->ops_update_interval;
 	bool aggregating = ctx->passed_sample_intervals <
 		ctx->next_aggregation_sis;
 
@@ -710,10 +716,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (!attrs->aggr_samples)
 		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
 
-	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
-		attrs->aggr_interval / sample_interval;
-	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
-		attrs->ops_update_interval / sample_interval;
+	if (sample_interval_changed || aggr_interval_changed)
+		ctx->next_aggregation_sis = ctx->passed_sample_intervals +
+			attrs->aggr_interval / sample_interval;
+	if (sample_interval_changed || ops_update_interval_changed)
+		ctx->next_ops_update_sis = ctx->passed_sample_intervals +
+			attrs->ops_update_interval / sample_interval;
 
 	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
-- 
2.43.0


