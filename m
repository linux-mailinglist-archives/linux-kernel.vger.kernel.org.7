Return-Path: <linux-kernel+bounces-868580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F8C058B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3241A05EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DB30F94C;
	Fri, 24 Oct 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ATC/7WXd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878853081D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301162; cv=none; b=d6VULEMo1T6IgPyHNOIuZq6BeWuU4BG3pDpQyxJU3emR4pqnDvNvcDe3GvFDjIF+n+QD0eS+HrEGok0rDgxrbcgxAnIyEGda9sxyKzSDK5PUhnJLIkhxFjpvQMqqqwFCIdONCaPiTAKLNB3AY/AUED7/jyKvzmJDyHQzHM8BlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301162; c=relaxed/simple;
	bh=Oi1ByVHeEu2zWSl2sH20SGmEO9NEsvJ+ngc0jBxXKMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GywyzZcuU1yM+uNnoOu3CD3HSD+ffHaHoVAkIApQXNfpz89N3ThMo9vulbRk/EFpEJ6Y91X1h/5t0Fo+rTepaYS8njKvhZDf5bXgi8Gmu8Y2HVmhO1PCe0kt8WTudFnAr4u51uI8BOS/H8K2jeGHmlRh4R9QNAT6xM7ptuiQJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ATC/7WXd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42420c7de22so906377f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761301158; x=1761905958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hej3NvQOVSwgl8c1b8LmD8roMKr+o3O+e3J3aSquuOE=;
        b=ATC/7WXdkR9aeX3eD1Y5uuUup5vioboVcIM4znaid3M6GMBUL6Z3/WezTFXg8ChzZM
         EfsU8aAPFQKDqOIIMk/P0LE+3O4bWP+Ey4IBmExw2SwIZLqk49ETDoQKt76ZO3ro8dLG
         4kZgLy0zKvkiUXdR12f+BRjSjk+S+aKTm6N3bSJv7mERgCiH/MJwm+E6U4BC63X8FDof
         096ZqAn/ieOC3q0SxrE2Yl+XVvYU8/tb3Kp2RvMthLt9yyyLRX4eZUercZK7E3ouqt81
         7xsEbFHO/v3oiKTn+f4uF5rI34PlqigdF/9gheomkNJMiK8C7SkYyml85MOXjTGKM4no
         DpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301158; x=1761905958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hej3NvQOVSwgl8c1b8LmD8roMKr+o3O+e3J3aSquuOE=;
        b=EjVQEl2ybsgjqLR+QnH86lHocJYnjCfQoZBwHGe5px4kBaKuJybN0u70UagLaprL0f
         As4d9FfuWW+7sgqDhrSIkGNz9ov5vvLj81t/LEB5D6QNpM1qqKtoTiS2PkXzAk5HBmUw
         dJ3VJ/OlvkN1wwnzpt4rdw0+4teaSpi0+IUfxgya03S4Hw7clNImu5V742gV6jaJ5sWX
         huPFiVdL6ECJ9Hrq3O8AvZRJ9prSkH2TZUntb4el4P+gHApbIEEucMgPTYdTDuhaq5a3
         7npc0fHYUU9E2KPLoVMA5D1XsS1kViXHXN7hYAWy7cz1AvKLD2dQ8VgkB3+Xqbfn5nAv
         lYFw==
X-Gm-Message-State: AOJu0YwJqxMFqBC3L+gZQ+xiOuO/ckKRu14e+Z5SPdxdubuCgI3D6DfC
	M6h6bIQW6hr9UTrX9yjmjoq2T7zqIyERnr0jd3OXyBDlsfsK/QuQPQEYJmvcU1aM7I5jl6bXPVV
	4c9Vc
X-Gm-Gg: ASbGncsgWoT5lVezlkaUNNatdwp/R9qauRkiRMdPO+kM2low1HxEwgGJES1nwWvM7z0
	7cRzVLRe2j1jaCCjoXp9I+n4R3JZtc90VbLLz8zZZtTLW5YPTqJgz1/79wVudZz8oIXC3A+dk2p
	A+YyV/Ezcxp5qxjbSdI8GjiPGHLo+LDGKdCb1KFql55o/6dJC2CEvqIl2gDXgIawqSfDGQqjUgy
	n9z0bcq0AOy+HnhCR2Xo0t8jSTZGZJWJk2UdHlHD8ynFtvBKMdt7vs4aPdQFZUHQ5maxRi1UDcj
	RzPTIYGQMxakWxGuLjQWkSGB09jgvLKvKEWsY3aUVskf0v5XQolVhK/b/jETJUUphVKHM/AnP+e
	BhgoY3Yve4Bhe0d+5YPOONQkQAR1hGEal85hkwO8yKcv2IR3SCMjkmqxGMrL8jw9gHe4cabyNn9
	yo3iLCyuW3YsYG3vpJH+fXQTq5E8QTYh1FFC0=
X-Google-Smtp-Source: AGHT+IEkJHkd+PPIVsbfRDip0CBU6v0MtBY4CPu9sZNoe9ovulbXyDrIMxugN4ezuaNuHNIvHPdX1w==
X-Received: by 2002:a05:6000:2087:b0:429:66bf:1463 with SMTP id ffacd0b85a97d-42966bf1618mr4602739f8f.44.1761301158555;
        Fri, 24 Oct 2025 03:19:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f52aasm8372695f8f.12.2025.10.24.03.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:19:18 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] devcoredump: replace use of system_wq with system_percpu_wq
Date: Fri, 24 Oct 2025 12:19:03 +0200
Message-ID: <20251024101904.146351-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024101904.146351-1-marco.crivellari@suse.com>
References: <20251024101904.146351-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 37faf6156d7c..9596a27d00ce 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -125,7 +125,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	mutex_lock(&devcd->mutex);
 	if (!devcd->delete_work) {
 		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+		mod_delayed_work(system_percpu_wq, &devcd->del_wk, 0);
 	}
 	mutex_unlock(&devcd->mutex);
 
-- 
2.51.0


