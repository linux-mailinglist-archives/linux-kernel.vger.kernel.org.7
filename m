Return-Path: <linux-kernel+bounces-756723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB37B1B858
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5928625A75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606E293C52;
	Tue,  5 Aug 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH76YZPF"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811C291C3E;
	Tue,  5 Aug 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410854; cv=none; b=nvthyck1NftdL73PJsEGKEPnQ/pDf6ld2wrflPufBonNBGixwa8pnZwHTPgIQvTDuRdw7gXW1MnkpPH/hC5bKUGDALmej1hSkcfeXe40blnu9FOMDwMhPTU2ojnuFhNBfvUY6OMNQZngPqlCcbbNV6OK+mxcYMl3Si3qvRBflvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410854; c=relaxed/simple;
	bh=tF65PXhkOzWY/Nr9yG/G9amh/Bayj25Uf9hB29HafnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwb4hK3FswNbSP6DrqVlOF64Es8YY365pRm53VOhjHzpHbkpJ4X/Sk6iERUA5W3ZK9QvXGNSxQOp6dlRa6H+8+4p0iOhlloeQs4TVqUADCXj9aGVNintMtNJkbvB9bN44wMjJAxAcw0cj7ImPk2cRmGNXW/tNCSxhqt1HheIyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH76YZPF; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71a39f93879so678307b3.0;
        Tue, 05 Aug 2025 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410852; x=1755015652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDs8MlFPdGXXGi6TlMzCzWKbAeHvaPRj6HPGrEA8aHE=;
        b=UH76YZPFTodTMz2S1dZSgyRu7Ofk0NCtHo6jiMWezVzukGumiU4ztfb3rC6OYzemlh
         PHudyD78ExAtLlOYNh7N32yI7mMFclCJMfA63k5p+v+lmpO11eUBZnWKSoEMtAwnQMj9
         erxZzIHdzfKjF5a32AYAl0L3cH1v9L3Uc++TckQLokNaAad2eAoDJmOnWM2pehW4hQCy
         Q+dXD+XUIcCjaRdRDrFsymq6wszRPmgS6ve/bbZSVqhfbRvVIyNoaFAntZ1TGv6duMiJ
         LyRP2H3owWbRebVIwMQik5i7RJni/1BvNr1eNn/cqLvzHyjKFRvzG98H89r52j6b4gp8
         TwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410852; x=1755015652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDs8MlFPdGXXGi6TlMzCzWKbAeHvaPRj6HPGrEA8aHE=;
        b=pUHsKGg+xIj4gYjutihbWl7ufmuw++kiNAjgkeC/vkXIocHhe1P9dqLXXINNljblkS
         LuosPUF9sfrk8pBb0EnbYZLvH/98C4V6mOaKSwXlz/kJnjCZZXTbtag6BIAj7bN/Pq3+
         Y6FPr9NVnNQcEL/BA89H2nHx4Pp2i9cYtGRGu1w7dJ6tqY4WXWvzvkwSpyxSG/5lttdf
         MzfkHfnZXx9DfHVZYN9n3dPETd/3dEqAxlKgUlSw4VUtMZe3qi0Rh36R4POeyVQNS7j2
         UDUxZ/ejzPigWWpYJRtFKxcf00sNfdXUl9gb8iPhwZXrWePElOoYp4wtCa8orvHKT5Hm
         izng==
X-Forwarded-Encrypted: i=1; AJvYcCUWG+eOW/URyC5BQQx0qFxt6uGSYPYDdOOQ7L3sAm8tXiSs+ojZ3eycJ4HaN1gwWCXBDA3HUyTXDiV6m2oT@vger.kernel.org, AJvYcCV1kKzgeLZdBuvUePDczSKFiV717c+MoIo4hfK2QbVAM+ZNLUtnw+GGoEGtpadXW6EjWjOS8mGuGBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LbMsQD5182LvYlIpbbhEry0PqKP0gKsJ1mr/60wKuQEP8ZBG
	Q2mfQNZNbmljRwmgFfaKxxzTDElsApq4sr9suZClLfpBTAAvlBZl7Z29
X-Gm-Gg: ASbGncvbozcSIbxnDTfUqv5Tg/Trpd/hHSW7jOPDnlcz2qg7Nq5U1y5zx1AaodvZpyz
	6I+yZ5ygZvtHLmKGTx6bEgPwbBYs7dNUW3gq2ZO6uu7M+d7bmHEnrcnChRKHCB0oFwSIf4Jzl/H
	Ed61LcgRDP8dxIkMM1BUaHxtkqEGI3OE5Xh6HuDvVY6HPXWcO/uhcxwcKOUE4N6plKAR033iXVA
	TIlzQMQ5uVU4dwN+pIJHIY+byTZZRpNsQxkesDEOJMkBIiL0EK/Rd5bIJPlI7AR/O28p+p7imsq
	+0Q8WoDgAeQfoovS95hKJpPi9YW6pM2Qo5ZtAEGRw7W40qQbEWwZL8AwmzHNQw4ynABL3cbkxro
	KXQcoGwzlNUhI5G0iUyzTeUs9CMcQL5d7rTmmbg6y396pQeF8opSS3Q==
X-Google-Smtp-Source: AGHT+IFnyMpRgYiV7oRfT3D4U/J6G+wtU+eDsuK0pB5vtb532dpTisNQyFGaJtTj/nzk7d4QMO8Fuw==
X-Received: by 2002:a05:690c:6f04:b0:70c:ceba:16 with SMTP id 00721157ae682-71bc7edb174mr5896047b3.17.1754410851928;
        Tue, 05 Aug 2025 09:20:51 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:51 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 1/5] mm/damon/core: Add damos_destroy_dests()
Date: Tue,  5 Aug 2025 11:20:18 -0500
Message-ID: <20250805162022.4920-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch adds damos_destroy_dests(), which is used to free a struct
damos_migrate_dests. Currently, the contents of a struct
damos_migrate_dests in freed inline in damon_destroy_scheme(). Moving
the code to a separate function is useful for when damos_migrate_dest
structs need to also be freed elsewhere.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6b797120d2f2..a851c8bc2e52 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -914,6 +914,8 @@ struct damos_quota_goal *damos_new_quota_goal(
 void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
 void damos_destroy_quota_goal(struct damos_quota_goal *goal);
 
+void damos_destroy_dests(struct damos_migrate_dests *dests);
+
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..07b4fc5a9790 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -359,6 +359,12 @@ void damos_destroy_quota_goal(struct damos_quota_goal *g)
 	damos_free_quota_goal(g);
 }
 
+void damos_destroy_dests(struct damos_migrate_dests *dests)
+{
+	kfree(dests->node_id_arr);
+	kfree(dests->weight_arr);
+}
+
 /* initialize fields of @quota that normally API users wouldn't set */
 static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 {
@@ -451,8 +457,7 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
-	kfree(s->migrate_dests.node_id_arr);
-	kfree(s->migrate_dests.weight_arr);
+	damos_destroy_dests(&s->migrate_dests);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.43.5


