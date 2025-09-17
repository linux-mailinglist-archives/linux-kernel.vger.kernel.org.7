Return-Path: <linux-kernel+bounces-820020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C2BB7C8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FB34817B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FE29BDA1;
	Wed, 17 Sep 2025 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8aicn3L"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00A29898B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089379; cv=none; b=B13brPRgaMaqA9uevaFzwIi8IJD0ZyV9+1hagzFN3akRdsAvGUta+VGoaQgOd7DFnenf/qxl2rMAzdC/8J5l340+wCZlfADJt/ksYG2pJzURfzzv9Rw0QrL8jyqRHL9Cgz++2Umvk63XgGzClAIoQ+Y8ci9oHLViujkrxagTGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089379; c=relaxed/simple;
	bh=sFbuMNox4i9aaUKyaARF6W36sL4xybBDCMsqhDSWuRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5AaUukAM6GSvEzMEnZj8I8RsuTGBmt4HdqowPR74ujGmRszTmcK4eZ69jK2qGYc+HsN//5XwFKZ/feFX/3TR+F+hc4AFp+4tbssIeEycPRREX37pTjY4nvS7HEVzNWDJlhq0yAK/wikRnphoj2i2fk/8n+vv+7pNiXmXYpRdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8aicn3L; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-776b0100de0so463895b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089377; x=1758694177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utq94C3VxoGuQS3QuI/fmnJBC+uMMJHBbGWmRbRXlAc=;
        b=R8aicn3LgkCJ6rW9Wx8Wvz311JCyTJHJDIvblHqlByDjsfmnSYkg41Xe4Jmq3wvyRU
         fewb00k0Jba5uaUvXXhg0dbyQVoaByBKVQsPxqGa5ULNWhBr3iMlCkiLEQJSPP0GL4UC
         /YlKNTWQeuJ6C81amSYfqrliVa/Zzj95ChC8cKEB8mQ6gax5uItmEOy9FxAKTyrFzqLv
         i3ojWCIW4nHSU4m7BzjznvzsmOudg0hGjwnNzibo3+vB+mtVnGPbrgeeBI/rHPZrluDF
         9x8IqtI2Wxz/zu9Bu6uVpgI9nPJXzZrTvwd9bJeh+may849EXw2mXXb4+8+EmRVP3oTb
         OSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089377; x=1758694177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utq94C3VxoGuQS3QuI/fmnJBC+uMMJHBbGWmRbRXlAc=;
        b=dsPjj++PfNejd3QacINXCfNGFHviuJwp9SytW5NZAIG0T2INJpwnalDyopZ79SE8Yu
         d9+gKQVe00DojVdByJMLpN1i7iNONo9BzPGHEon1HmCBHE2b2wZIBnorVlrL7tZjqipV
         gjfUdw6kssrf/2spxWMWnKFJo3Qu2D/inYS9EabZ+a6OWbmkLC9c24qbakif4Aqdhhw5
         HcDYbSYxaQWJG1paIrovIHim8Vr7YS0iJah5V0MhNpISEpBvmpdLYrxks0CpN+yyYTUg
         5hpSU55cm2AEglYKTGuSTi921MeaPyU+pqWfUA1oHlQejluCPEzkoNFE71AbjCthnMk3
         jamQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0OiU+D4Co6g/LuKuFvUK3bcEvG1Jsuc3URorvRFRpvM31RLMMk4t2ZgHwvoV248js6/yB34auEt9ibEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcRtVis4QurYw8una6DxPVGfN2SY6KMvlOv8way2N1b6+g1AZ
	AJk5fvd5HxhJt8Zee8yMLiuxaZ65X8wmrDdXCaFNYB5VQQRDPCooyD8Y
X-Gm-Gg: ASbGncu+9Xx3pB0H15QPTQm2xe5Q72Ci4letmqDgn3ghxSPT2Nfq9AHaAq6uFO93abL
	R0ceMdKP8v0TQMbKec/p6XIggeohGxEJa34weDz0JbiH1JpyedjMiI/6AVTXjfkjmS8JIeF8ZxB
	5genwYpb5eIJP4hvCDkvSmPha5LFOpltvxMaYswiL/LwE7JAN2KB3B4ohoTJ6piOyopBUPeTBLg
	5TqsJG37HdvLJuRWv4ThEhBa3nVRvBQ3JCFEnvUfvX8yrKdJ+KeGCH+ffBGerVFNFhNB9IMwqFQ
	pviA3rMOeuINc6KVv+wFy3N3PNEuUwq1zuwDLNf7j5cMqHYy1L7j0MHm/wWth6f4fg1T36+N0H+
	66fbQ0d6yXbE+VH9uX9w=
X-Google-Smtp-Source: AGHT+IHyE7wI/wBNXTL2G9Xu5VkmmyYEi5MPpXY5oaDnuD0UhDPs3k2sfKx40YqgmRplQY1pNY5FFA==
X-Received: by 2002:a05:6a20:430c:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-27a21d12a46mr1286345637.12.1758089377248;
        Tue, 16 Sep 2025 23:09:37 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:36 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 2/4] rcu: replace preempt.h with sched.h in include/linux/rcupdate.h
Date: Wed, 17 Sep 2025 14:09:14 +0800
Message-ID: <20250917060916.462278-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917060916.462278-1-dongml2@chinatelecom.cn>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next commit, we will move the definition of migrate_enable() and
migrate_disable() to linux/sched.h. However,
migrate_enable/migrate_disable will be used in commit
1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree.

In order to fix potential compiling error, replace linux/preempt.h with
linux/sched.h in include/linux/rcupdate.h.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..8f346c847ee5 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -24,7 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/atomic.h>
 #include <linux/irqflags.h>
-#include <linux/preempt.h>
+#include <linux/sched.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
 #include <linux/cleanup.h>
-- 
2.51.0


