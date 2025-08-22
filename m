Return-Path: <linux-kernel+bounces-782602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DCB32294
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F295C5C39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFC2D3A70;
	Fri, 22 Aug 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1tptwAk"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CC2D29DB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889322; cv=none; b=UVzmruFRyPVNpBsZ8tl4hSBfldfAafiZHj/N9AqJPDhTuoe5xLFOySgZHv39hftuGS5tIZzLOOOr+5uqNBP3DsTK+cGMSz3lrvoiJty8tpbMRLEKOUajCrxUjHw7LiYo4ayw5HkoUsSzzaJUjlr89WOLus9U5YbdSeb4wiHoDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889322; c=relaxed/simple;
	bh=n6toBV9/E43mV3bFSotlKlEdZsvEcL1F7i2m03IpKuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqE0J5IwH1Tm/+igTKfhYGrCTfaLPBVO/of9xxfGzoMasWmQKMsI5O+EQcsQBmRuYodoMD9XOriXemH/0nOau+XrIQltmXc0vf6VMN/01TxpnE5r3jshTpzvs+LaxDvZsIghMMuA+ymAcZ414HXa645HIDgBGCgAeoMgGqgYhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V1tptwAk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b471754c159so1665804a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889320; x=1756494120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2KczgQGxGJ8RIuPHcEG6UwnRo5SfqUAX44DQ5/YPlA=;
        b=V1tptwAkrHo+XI2Oy5KCfSSuHgJFa3Da8djykD6hCv0urDVZH5kP8gIfuDfWHGF3Bf
         1xikgeghIb32ibwPsERe8gCM9tFY86YxR+dxfBreQMWy/P/UOEFRgqCre+oOQ388/oKe
         EaZabHCDeLNhmPDQymcq8H141kEi61iv2ksrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889320; x=1756494120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2KczgQGxGJ8RIuPHcEG6UwnRo5SfqUAX44DQ5/YPlA=;
        b=ES9jZvLR0IiIJBey6eyTfuzVZbmbNrLYZmxAjFilqi3fEuxldCVkc0OR8E5YlliUG/
         3HUWoUuGC0dUkK+ro8mNcNsWzljhpt48qzYdM/coYSqzPNpE5eaZDgVTBKMceHym6jOC
         /C7sCHx0W4eE6Vnw4Z3rOHlYvJuZGA+VxG499/ZNy4WyjNPvV40mS1NTlNkk65EFvbr+
         tz4ZiwwCiYTjV5QPjpxxrQy4CCP3XqJe3e7HygOq2JDarsei/RBMFmYYDa/n+dcctRSm
         yBJHpcvbqTnv/iKSTKq096UmdsQ968RKVBlCywolJrkznME+4JDd4StfS7N3RVFJ5tQv
         uNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkE7Nm5ftFrvWx+wDfZuzgjYhM0VOueBLUqFhpjsqkATbvYRsi4uZbBDKnvAVpf64Sw062qO4iP8+d9HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnqD0R0tsDiSrLZSSrv+Z+O3zqLInTzl44BpSGU7MovlrE5Ln
	ivCQGKMvktJlGzQpKUazW2ukZnGZGMCyKz69XkcEnIthUlED3JHAqRmEZIZ2EO67PQ==
X-Gm-Gg: ASbGncuA/2lmvgZOu2oi3O++KRKr/vYlfq0yZUH3iT4LMvFDB8LCCUJKCrQiQq9hyfa
	FXErjxJm/H9mejtpY3mlmUsIDa3sNYALbfOX9+PDr4V5U6ovS+sEXIzucgsRlpwm0SK5RT0QmNR
	l+ndtxBHFlkZiGwdOxU915KsKtDwGI4qDdMLwsSucPF6/StJt87yETp+tn+CDXx7Cm8OJgnMoFu
	1uqwRhVyADXDYDLQULGKXJbW4BpZEVpJTkozLmT2zq0GdogV21ZVz5h84qYwn8Tzb2Z+QewXYHE
	j2IjZfKWkf6iIsJeqna1J+mI+9Mc5v7xSE/zbfJPuktP/4PJMb6EDRcOYPh44Y2mUbFJg7uSLPF
	vh+WQwENqWXJesqMrR5C/I6w0UfgOrc1evFjMsxF6+kNkjnKPIuR2TvHSaZGdAD+D87Gbnw==
X-Google-Smtp-Source: AGHT+IEkAYbFXJfvERFeRy+iBP0RnG0l2hEWY0aJzOQFI/VovM3OrRaH1jMB6Vh2mtc7UdBmAp8Gug==
X-Received: by 2002:a17:903:228f:b0:246:61e:b562 with SMTP id d9443c01a7336-2462f1d5493mr52797145ad.59.1755889319635;
        Fri, 22 Aug 2025 12:01:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cb8b4b98sm472066a12.19.2025.08.22.12.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 6/6] genirq/test: Ensure CPU 1 is online for hotplug test
Date: Fri, 22 Aug 2025 11:59:07 -0700
Message-ID: <20250822190140.2154646-7-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
References: <20250822190140.2154646-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible to run these tests on platforms that think they have a
hotpluggable CPU1, but for whatever reason, CPU1 is not online and can't
be brought online:

    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
    Expected remove_cpu(1) == 0, but
        remove_cpu(1) == 1 (0x1)
CPU1: failed to boot: -38
    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:214
    Expected add_cpu(1) == 0, but
        add_cpu(1) == -38 (0xffffffffffffffda)

Check that CPU1 is actually online before trying to run the test.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

(no changes since v1)

 kernel/irq/irq_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index bbb89a3e1153..e2d31914b3c4 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -179,6 +179,8 @@ static void irq_cpuhotplug_test(struct kunit *test)
 		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
 	if (!cpu_is_hotpluggable(1))
 		kunit_skip(test, "CPU 1 must be hotpluggable");
+	if (!cpu_online(1))
+		kunit_skip(test, "CPU 1 must be online");
 
 	cpumask_copy(&affinity.mask, cpumask_of(1));
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


