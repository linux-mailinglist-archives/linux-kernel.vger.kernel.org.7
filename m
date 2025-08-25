Return-Path: <linux-kernel+bounces-784758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC22B340AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137305E12EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F1274B3A;
	Mon, 25 Aug 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OjogKOac"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25118272816
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128564; cv=none; b=jYKX01z7qLgLe+IU7+p6NjKRf9bI354sy53honYubuMxxfzE+Yx8BtTUm8yrbseEZ2kIjedSzOb/TqGVBq7txpFrplN42eycB4RISIrfGqpUt0w82Z9c74h+Q8D8h5oag4zvQRAhg/qg7dzqMHhwhUeNR0gba+EtBLbN9xY5mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128564; c=relaxed/simple;
	bh=zhC7O3ETIu4N/4Xs63PaxH6/C3pmoOa+41VBz4XfTAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URClyM65xPFQXlvgADXZYqEPOBZXqhcqncgWE9e5QbXEloWQxWN/Ljn6EXwL+A60D7dct+7wmGYQ2VKoBMYQ0L/4qkbZgc8w47b2pyI+X4BoiEVwbQDmsQTUiIz/qNNdmK0seQes9AZHUzGAVzEvlvoQvJT1uOH0E1IlODeiaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OjogKOac; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b629c8035so3871695e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756128559; x=1756733359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/SuQXvlX5ZWnzROQaWwGQSibOi+ZV2YU9dbORJY9P8=;
        b=OjogKOacMm9lavwCQaI4lkzeBJVIEihDX/4kckzvnGtO6E8rHe2zd2tE8f/Co4Fgrg
         MriDd3ybiozNN30GEBGYJ17Zgo1uDScOu0HRElS4Tjk3k9V4GnLEqnTvGVP2ypcgs7AL
         NJGANYwpuRIu2JUDjS4eyK9Sk5MlKTbkeG+Ous7pEoGhkP6nZynCiZhp4cLpOcQb+2HW
         eKhIzZNtAhuaafpqQX5NQPxt6k0pmE+7OyPVHhrXNEI6EiwrS2NCPmjBJdF+/ejRA1sY
         LH6eAu2OLzIEH5EAXptF5JhGBEHaK5UZRN/giNBaVqbSZoi6Wb/PpjWFuC44P5Lzy1tq
         OEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128559; x=1756733359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/SuQXvlX5ZWnzROQaWwGQSibOi+ZV2YU9dbORJY9P8=;
        b=dNeTYOCPMdpDxj6mcdkKaDIgChD8ML0sLjW7H/3rnCuM877TEXwYVVEYnXTNM+0mEp
         NEL45u2lUPt7Zsm3JwjjAKQ4boRWvGneUIsG3joXHFub1geYSNk7m5gE7sFoU4l+kCY2
         vY3/Nt4ZnIljfLkx9k/jYvqqxYwfktY7MrkQGy+XyMIkdWWfMKOMpON4PhL+Zm2uHf5p
         WpShPPXc5V/Bzn65TfjyC9bSh0f5Uj6vm36HbNScQBS9iMDsjDSQ2x7qGoSy4YPocip3
         UBFsN454yuoNBMlLAdSxyurpSOzkXZl5MaiHa7TdUIXCR6J+odC4fbcBxRjUJ0WqPaEy
         x99g==
X-Gm-Message-State: AOJu0YwYIJGaimMv7uALegli67Lrruwr6fbusg/h4tv3mutI0DCws9pn
	vGEWa9SQb6kuh00nY++KdqNs33u0NtZ7j/Ld+hWyBDoORMUdntZuY0KBCDl2OxZHUPR3Vudlxnu
	XM1PU
X-Gm-Gg: ASbGncsF62pbYyFR6SohtQrx3zN7DUJVo/pod24BEXxFLQE0jS1W/7d5nqrbO+nrWSV
	ZnVxBIQkxHZtHPi0Lt+08gwVP8BBiWPtHpcGWciIfiTVxxhM0PptYRnJBJE4Ek9WVN0MHIsbLsZ
	dTB0jZe1V4xZLxES+FxCil/mAm5EhcWRLEuPkxUeCljHYdJJ9QA424IHDoK1lXv1fULiE+dcBop
	EdaEmVa/DmWeLNk8IRs6pUo74KIoFj8T7u2X4OLFm8OZFOevDei9gYuw2UryfJ+x2ji5cj9jdjh
	vRcLk1Ocdlt2/agpoBi6P5JeKNyj9azK8z9H0Mdm+s9gyZHSlq9fduQTrLdYpNNcHnG4PsJ9O2/
	isqcMoZmz1Y6tGcZL+qFVZ+2jQ4n0LHOR7QVf
X-Google-Smtp-Source: AGHT+IG6fF8ojJUqqUrbea/Nm0EkNd2dmJ12TOoBcRVYndwaYeWh32rPjoBgeffS+/+LpbCTorHbUw==
X-Received: by 2002:a05:600c:4f0d:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-45b588ac3c2mr65420645e9.18.1756128559223;
        Mon, 25 Aug 2025 06:29:19 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm11696632f8f.30.2025.08.25.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:29:18 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 4/4] [Doc] Workqueue: WQ_UNBOUND doc upgraded
Date: Mon, 25 Aug 2025 15:29:06 +0200
Message-ID: <20250825132906.1050437-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825132906.1050437-1-marco.crivellari@suse.com>
References: <20250825132906.1050437-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doc upgraded to mention future removal of WQ_UNBOUND.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 Documentation/core-api/workqueue.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 165ca73e8351..c8ece1c38808 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -206,6 +206,10 @@ resources, scheduled and executed.
   * Long running CPU intensive workloads which can be better
     managed by the system scheduler.
 
+  **Note:** This flag will be removed in the future and all the work
+  items that don't need to be bound to a specific CPU, should not
+  use this flag.
+
 ``WQ_FREEZABLE``
   A freezable wq participates in the freeze phase of the system
   suspend operations.  Work items on the wq are drained and no
-- 
2.50.1


