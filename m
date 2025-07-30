Return-Path: <linux-kernel+bounces-751379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B173B168E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FB51AA531C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36622B594;
	Wed, 30 Jul 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvPvF4ep"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465D19E7D0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913309; cv=none; b=dK3OF+Ckl900K1lyXj17yZQjmzHzkhu2z3T8ZPk4HqtRq5xN1E5l0lZ28yjDgkoyB4CXDMYh0cuCBwqGh/VsxZYXG+VXHTm7CXZIdJeEAVX/cQISyP5UCfEpXd/7lTxPRcFitg9+bvWb5hKdC+94y/jpyuqMbMYD/Xjx4uNZ5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913309; c=relaxed/simple;
	bh=PNDe9DmLpP8vQLE52QVnejDJ8eVQpGsQIZ1TWehA3sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nAl5fdNWkGKq4yqRTWm0mm/5fKz0btdR/Pm0YkSPLxBNiU8LDJgrEGYomOqvpPF0a7r7cQaDP3AY4/y/tDXetE86ePzcj6ooRO2fiTOb4TvlLp0rCSL14Of/R4yLq/6eTye4Jo9EzKo6zTOBzjkCqCNk2sJQ/Bc9UanE4Fdc9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvPvF4ep; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so347668a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753913306; x=1754518106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYPSzgAZClucp9advPGtHTtoMvoPpzZ3Dtwk5mdPmjs=;
        b=IvPvF4epxARvaMU2dcOHI7Sq+MA37Grm6Ef7xZt6iPi8BBQ7fpm9+Q16UMw4fV8qOt
         Share2RzPf9VvT51LUiA/sPra+vgldUvw12bpm17SIuUPokp9kvFoWbHXpT0vl6FPs4c
         iyMS6m3++ARyE5gOAQ1ayCkSEmH6kyV9ZQxpx5xIAe5KclaoUDlFRcwW7Us8RuLy8rSx
         Fq6kh+33E7s/2mhLT4DpJmvCq+eoUJX9A4cZIfcSKV0kbBxzJSmmrFoov8/1llp9FN5/
         RLTM9SNdECGKost5cm3+I2w07iH6eoTNdrbHKrNxwpPCgttOSv9dxemSZ6mdm1HgKEnw
         0vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913306; x=1754518106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPSzgAZClucp9advPGtHTtoMvoPpzZ3Dtwk5mdPmjs=;
        b=u+dpkTyMxNHQBUEe0h4XTPTrxruGSr7V2cGTDGBrxepBJgX5VbiLBlx9ZN1TV2qjwg
         gro0Qy5xSUJ3G9JzT0kiZnyYvCAxKB/TJ+Zc0AUNCW4ol9jga4rXfV04xlDbY5ThsvzY
         v7ij39qt4w91Pc9VACKcMufvyazk+efsiqXFX8pNgpKl0lO/qPptboiVWacqH+NStbQe
         3Jn5TBFo3TXGh5zW42TXVBVLlG4VkJ7I0JAZZSUSV3VIt48rWAtmUN4Ak5XdqnoMHbvg
         F/2vIgKeZY5s7/arqHyw5Bf/k3QwxgRFhlc6/w26l82HDHnv/CpHf61NV0B9U3yGFsxm
         Me/w==
X-Gm-Message-State: AOJu0YwuEswBXKSIdj3kO8WAjt8B+R3AJlEuKSECy2dgANs3DEKJwKoR
	MFCzZBTrdmf7zcWyQ3SVaayxd1gIk2NWJt8/EBxh5V9jxADAYGpZD04FnYNdUFBbr2IDwPoFNPv
	XWfqMLDdltTUOmZCyNo9WplRIFzBhFcOQpxrRkXfadfq5jkQ0TQgkF2eoU85HMHarNg2u+aeK80
	Fw/GbwEs0fnXvpwPFTOimJ4g85fTkCCv/QGk4w79Hf3RthMckh1w==
X-Google-Smtp-Source: AGHT+IGZ3NDO6jUkDRlidOJBUV0Ja1bR3uiB0LRR/EOuhSKjhT4aH0bvvbHvHtK+qePEip623lThmruu6pu6
X-Received: from pjbnt5.prod.google.com ([2002:a17:90b:2485:b0:2fb:fa85:1678])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3907:b0:311:fde5:c4be
 with SMTP id 98e67ed59e1d1-31f5ea6b6bbmr6169503a91.35.1753913305877; Wed, 30
 Jul 2025 15:08:25 -0700 (PDT)
Date: Wed, 30 Jul 2025 22:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730220812.53098-1-pmalani@google.com>
Subject: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On a heavily loaded CPU, performance counter reads can be erratic. This is
due to two factors:
- The method used to calculate CPPC delivered performance.
- Linux scheduler vagaries.

As an example, on a CPU which has a max frequency of 3.4 GHz, if we run
stress-ng on the CPU in the background and then read the frequency, we get
invalid readings:

./stress_ng --cpu 108 --taskset 3 -t 30s &
cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq
3600000
3500000
3600000

Per [1] CPPC performance is measured by reading the delivered and reference
counters at timestamp t0, then waiting 2us, and then repeating the
measurement at t1. So, in theory, one should end up with:
Timestamp t0: ref0, del0
Timestamp t1: ref1, del1

However, since the reference and delivered registers are individual
register reads (in the case of FFH, it even results in an IPI to the CPU in
question), what happens in practice is:
Timestamp t0: del0
Timestamp t0 + m: ref0
Timestamp t1: del1
Timestamp t1 + n: ref1

There has been prior discussion[2] about the cause of these differences;
it was broadly pegged as due to IRQs and "interconnect congestion".

Since the gap between t0 and t1 is very small (2us), differing values of m
and n mean that the measurements don't correspond to 2 discrete timestamps,
since the delivered performance delta is being measured across a
significantly different time period than the reference performance
delta. This has an influence on the perf measurement which is:
((del1 - del0) * reference perf) / (ref1 - ref0)

Previously collected data[4] shows that cppc_get_perf_ctrs() itself
takes anywhere between 4.9us and 3.6us, which further suggests that a
2us delta is too less.

If we increase the time delta to a high enough value (i.e if delay >> m,n)
then the effects of m and n get mitigated, leading to both the register
measurements (ref and del) corresponding to the same timestamp.

When this approach was previously proposed[3], there was concern about
this function being called with interrupts off but that was later found to
be not true [2]. So, waiting for a slightly longer time in between counter
samples should be acceptable.

Increase the time delay between counter reads to 200 us to reduce the
effect of timing discrepancies in reading individual performance registers.

[1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-average-delivered-performance
[2] https://lore.kernel.org/all/7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com/
[3] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
[4] https://lore.kernel.org/all/1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com/

Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4a17162a392d..086c3b87bd4e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -718,7 +718,7 @@ static int cppc_get_perf_ctrs_sample(int cpu,
 	if (ret)
 		return ret;
 
-	udelay(2); /* 2usec delay between sampling */
+	udelay(200); /* 200usec delay between sampling */
 
 	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
 }
-- 
2.50.1.552.g942d659e1b-goog


