Return-Path: <linux-kernel+bounces-886289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1CDC3531F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C13566840
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6C308F1B;
	Wed,  5 Nov 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q4GTdxZt"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A689307AD0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339426; cv=none; b=uZlUrSDOYCPgvNv5giaHjPrlDZH0RUPbS3ote80rfhniKmf6iGXA6fGhfJDcYsrtvKaTQCdsIZUuhYhQdAcFMZNRxBdAmyWwHcvbj+9DKS8HTl6umrprAMgVq20ecuQhMHtauAYhfQqQZ2Sy5Ik7eWM2Ox3jdmjihTzd0mg8bCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339426; c=relaxed/simple;
	bh=5ncYwZOdDAa7zp4r3G0JNN9+yFlDyFnmUr7zh5/4c8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6gYZHAeZQhOonnfdhfw4bQv9m0orhqW3rFKQO+hVghUWLqb0LXPe6RvSO9ZSYaceSpeCXKCE0oERWglmB2FuHIdB25O5FFRzzYiuPQwbcpw2dwNcVkTYowXPRRzIwjXkNpeYn0en8ASOJkh0igCimjbpsymSOCWCMNsA/L9Hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q4GTdxZt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso5529450f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762339422; x=1762944222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOg575q+25ayG10zmWcUoW+NcCmP37KI1gSHHkg0YZc=;
        b=Q4GTdxZt/bgvQc3yh4X2sgbJGl/+pXAD25HcaRn9C0PnpY1PVQS8ySWWqbRyCz8dVO
         rq+lLbrA2jzqiIdhV0nVkL8nEC/fdWESypshVB35P76hLnJHATeahbwmIlCBEgzdP94P
         E9WSYAG8FZwlyH1eJGk+J6ObODsmgEuQn77bkhcBUOEVw+ONugB0niMEmR9g29HQT2nz
         4UiafZwslxx6yAohDu1H1zifKoC5cWkk/ikcZna0lx55pXoRsO7E01S4KemTdGjh2VZj
         0S8cWWWTcl9LC8AD37C9TliO36kGfK+7twrL1ZmQLTYRmYk8jIZkZkv4SUllrEvZ/Sk8
         R7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339422; x=1762944222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOg575q+25ayG10zmWcUoW+NcCmP37KI1gSHHkg0YZc=;
        b=av0CQY+n5wECKlQImtsn9M5JJrgKEZYaJZ4zM1poP197cezCO/3z6HCRjkhJtAuOjs
         XK6pFHO/gCEPu2pWLvY23gcX6QqQaKI8ThkfUTiOnerDJ7x4r1z3+aMqEys71AKOwyyo
         sn+iAXRtDFHOzYt+/3gXHcbyWvGx6Uhq/CT/8AgkfE9WFWuY9NTqklfmO6IUI0hcuMUJ
         8f4sBxsiu+KO5p+9+5dHN3VFQjhXAI73lpSYDLQz+xPasL2QTZ4FZMkm99ClMQZOEM4y
         X2UOKbzwltHPYA1QIug+bd4pLZz2AvQ9+xI5kiscqGL7X5WnCGASATrWA3EjU1iOaTMs
         IfKw==
X-Gm-Message-State: AOJu0YwBVysTPLRgAc3Yhfi51XfQc+kje9EVC6sXkAoNcCmGpgZqmwlL
	QEpKHEXwdvEN8X5AEJWuieEYI0uS+Fq4keZQLzMIaujN9mK/hD5hlIAoSOQGARqRlj18mi78QYV
	dTK8V
X-Gm-Gg: ASbGncsVxqUp4COm3lOzduFREbkYH1SEaZfPkHW8dtUhH2C/he3XGS3O6JiLh/Ijc5M
	ErxUImpNHN2dXuUx4hAp/4ERvlx/CbLdBGnmFsNwqgwSrUCI4JtgdKHXW8XRYkPeme6Sol9qSCP
	BV997+3BsuO7hGwlebOOEIJylkDOstqRgOkXYiXVYw26E6flonOJEnpUKRE3IH5I7NS41VhcUAs
	VZNx5YX3iwVeFvDvldOmylUV2Zk4ngVokui7kCuYl+ixH/3q4bE6PuvLpw6WGGNwZo66n1gj8Zt
	E9Y/b8N9AL0Sn9NETUO4zOVwqDdxdEhucMGwDedButfr3NjmR19nb882Sz0TMU1gKdW7IgP7h15
	xiIOlbj8qFywyAer6UkrxJCU8tTT21oKSa0hSx17zrhlhqoomwXxyjXepCX+RGKeVShYB0cM4Rt
	ygTheSEMfD94PPoITk2an7YoiI
X-Google-Smtp-Source: AGHT+IFRYEzSqZ0DH3kYBMuibsFe+SQOCxQZR0nK3Bmb8zKZRQYwkg39p8gfm+b/51wl7qdNrlNrHw==
X-Received: by 2002:a05:6000:1acc:b0:429:cf88:f7aa with SMTP id ffacd0b85a97d-429e32cc368mr2084506f8f.9.1762339421745;
        Wed, 05 Nov 2025 02:43:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5a7fsm9976206f8f.24.2025.11.05.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:43:41 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio/adc/pac1934: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:43:30 +0100
Message-ID: <20251105104330.111057-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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

system_percpu_wq replaced system_wq, so change the wq in iio/adc/pac1934.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/iio/adc/pac1934.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 48df16509260..ec96bb0f2ed6 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -768,7 +768,7 @@ static int pac1934_retrieve_data(struct pac1934_chip_info *info,
 		 * Re-schedule the work for the read registers on timeout
 		 * (to prevent chip registers saturation)
 		 */
-		mod_delayed_work(system_wq, &info->work_chip_rfsh,
+		mod_delayed_work(system_percpu_wq, &info->work_chip_rfsh,
 				 msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
 	}
 
-- 
2.51.1


