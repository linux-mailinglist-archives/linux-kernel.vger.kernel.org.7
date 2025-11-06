Return-Path: <linux-kernel+bounces-888712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB9C3BBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A872D42550D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31EB3446AC;
	Thu,  6 Nov 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evjM1ED7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6E330D35
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438812; cv=none; b=HaGKWSH/aM30tWWAXEB85TyA8u4A4kHXmuoQEznrOcK5cmLowkkxIsygTzwVw4dCT9FbdJ7gDdWQkF91YH3ow+omM9Ny+yJsxsJKFkhYWZMlCdmwUOBgnnZDN83+tDFgnvLMqoSWcWkKsAvSZkHaCWOJvmF2GeXd6u1YAbK/32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438812; c=relaxed/simple;
	bh=L7FDkgspg8idJWLA2cOev6SpZ/+CA6hgRhvjcEZuen0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICN59Dv5thSUopZvoqyYe3IPrJILr2W8BOZgf1gEJL/bFVNXNrCtfuxGpFlwhSAHEEZWHhhjqmebPIa1u14nFEZbjf3fhgeRHHGcSZxizrvXvnhBF6a32qLs7+spCyb9/UEGhmwmPFJuvM8bAjuGMIvKq3KxWvzYc5nBlFrJzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evjM1ED7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429bcddad32so782207f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762438808; x=1763043608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSb/NpcULPsnZf31wjwvg0SCqpDq9sJbuWNdJIPEv9w=;
        b=evjM1ED7L9dqtlaafXhoTlIkcdBq2zax/QqTUKCoaUwBAIu2U8lIigI09bDELYRn4b
         qXzeTb/Ei7YnAMme6U5tut8ipJb/wsCMq6/gwo8feHyqUiWkqccynUQP1se71bFliUEM
         unHJtelFVEp7CsZwy6oQPcbWF4mZKf0oQ0i5pgyGaQMOn24sWUelxe9mJkiQmZPm5AYK
         9Jd3Pn4iAluuxE6tHJrZiOkMRrMBmSDWkekySRpWoMqhxd75SzGKwzYa2dMcRGSXEsmX
         77rDvXtNCqom3egS1K31UieTB/fvz0nQ7TJE/5s+qV3oBYo98t8m8DWij17G64PGTN/L
         vxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438808; x=1763043608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSb/NpcULPsnZf31wjwvg0SCqpDq9sJbuWNdJIPEv9w=;
        b=FIi21MqUFsR7ACYCd0wpfpwr1739/Wkod9MDQEm7r3NZVnkvmjIiOgcTz5LJ2e4CuR
         H+212qTzEux1ruHCYWacn0O1nv0vJ6a7SlIU8ADrpdbLhLvSklpENJ8sc5qX5KfMFytP
         XRC3X4SBYjEK2HOh1DHhQflEKXGjxv/tGiLIDqHnsoXQ5Bww2tpzN555X08zQw6ba5JR
         O8WknsnY5jiNR1tlusv40V9lkbVeonhRameB1i9J9Qbx06Gj3TDz1ZhAW8onclr/B36z
         2W0W83eZ8VvKv2OuHwDszU1OCR52Q++o5s9hYLHu2CaWzXeqXVfm9YiSW42jtf7gd7CT
         4FTw==
X-Gm-Message-State: AOJu0YyGqY+Ad2IFW6PdVcMnDyFkq24OMHVXAiUQGGDejXNCbX34dVXh
	Mo1Yk1JbIruVMwVgP+YAfI1uPx3UiAzBYoWL54zno4S+17QnJ4MFkm4D/9eoB3qy8fR9tI9jx6c
	B9EQQ
X-Gm-Gg: ASbGncvTpCAKi13GkYTZCTrK0ON8xejjTjiIPXNJc2rLwbn/al9tEdheegci6XlF1mz
	64GUUzTF03MKKFRvYyus+xEwL3JLLE9bEWzvdmwfrg7WYuZKjyduUqdqJkDoA42lAoQFOV4X4Js
	ZXk42GgJf0ViNwzceNl8bTgVWNwH4HjNDzVrU7ZJa5vGyVyuOJB2e+mEBmBcsa4qn/XSO6J0LP6
	2vYsVbX3gNozQwNKSoc3WHrKJ5w1fai7zDjXG5WbjfslIB/J8GlPHmac+vQtgggnc30D00Hznx5
	l36D11cjkiHO65P9ObslCrnOr61qC9X53SMX+0Ewl2qktxigr/lDGaRqh2zvoU5dK2HPxLx37l+
	aaYRAEosRzf7y/CDQe/s/dwtVBGiqZNJNyyR7PHdDnaksczUOFZlnSTYWggC/KjKAHJpDxvCvOe
	1voFHiwS9zKNmDyrB6HGR9cBo=
X-Google-Smtp-Source: AGHT+IG8qhh+/UrI5Q6YrzncjND/C+ekwN38TtxEM1DW+cP8lXWnciboSuRATzLEsHz8zGksZ8qqxg==
X-Received: by 2002:a05:6000:4014:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-429e3340173mr6525520f8f.58.1762438807877;
        Thu, 06 Nov 2025 06:20:07 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49be96sm5255531f8f.35.2025.11.06.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:20:07 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/4] Input: gpio_keys - replace use of system_wq with system_dfl_wq
Date: Thu,  6 Nov 2025 15:19:52 +0100
Message-ID: <20251106141955.218911-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106141955.218911-1-marco.crivellari@suse.com>
References: <20251106141955.218911-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This specific workload do not benefit from a per-cpu workqueue, so use
the default unbound workqueue (system_dfl_wq) instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818..5e875771a066 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -434,7 +434,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 			      ms_to_ktime(bdata->software_debounce),
 			      HRTIMER_MODE_REL);
 	} else {
-		mod_delayed_work(system_wq,
+		mod_delayed_work(system_dfl_wq,
 				 &bdata->work,
 				 msecs_to_jiffies(bdata->software_debounce));
 	}
-- 
2.51.1


