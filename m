Return-Path: <linux-kernel+bounces-740221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EDB0D18A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A41C22D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AB28C85C;
	Tue, 22 Jul 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19xSivaZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966D5A79B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163886; cv=none; b=lhD6awklVgQZz2FJMYwFwZMcKWB/aUSGdMiiutCGhasicON55nDKgKb//w9sDuF1ZRzpa23ye/vyrgNAZx4nqWuGc2LPOZmfC12NvjoM8HW1lVt9i4/a4q9vlLV+/Q/MAEpUQf6ZyvoCStkmAChmp8XpATe+qv1EoHjMUCjxQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163886; c=relaxed/simple;
	bh=n72cdPXZeJHHjVF29bmi3yU2+tOfineR66XrhqtYQ84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=murc0CUqegrzs7iRbieweaXfgkQebnG9W7wuUT+95nSzbXOOuClY7K+Ltv9P8a7fgP+sdN/WLSnfvb/pGrbHGk5yoKn0kXbtaIb0P6FzF4U9owROKTFVeGNOyB3KOFnoRPeye0ZOx7+8b8JHoqEDxTg+JeorA2T2rJ+uBdVUtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19xSivaZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so7693761a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753163884; x=1753768684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDAaESfRoBj6PBmfDe7VrvhxCfzBMJy2IiWm0LqLkHY=;
        b=19xSivaZs08bcqtFK1Vo7WjL57OpufVbxxvnhFadEGHpXOxzRCxgZ2NJvfTjA/Z4zo
         1gBOnMfVZT8U9Sea7z/e7ZrBJorK2TMj/OaSx40mjkyOMkW/vHlhZK3sGv64wDgtH/PU
         wMoZ0wNjEbJ2IiIHcEXLi7I5ie3FB5caL98beNJktZMtA5h593/86fkqAKRvmZ1S6C7L
         yZTHJBFeRKBmE5detRhi9TI6E6p0trEweoiHVZcvfp8rb3xeHyB6xFrNwtpAsttBpKPB
         DyEPDrLf4ZGDVzhjrwMhdC92eu76IawRhOTeV82Zl7A5Yu5shj/kTIdftMUMPDlDzPse
         m8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753163884; x=1753768684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDAaESfRoBj6PBmfDe7VrvhxCfzBMJy2IiWm0LqLkHY=;
        b=S3Hx/mkz7biNIAgyBbzINq/mf65tcbfKWWXX3IJo8NJ5Y8f/eO+awbTUOoxKENbUfD
         qvATOGqarEPcDFCKcmuTNTRoYEHvwL/stJWvCnJ8SjGTu14vEcklMqPALPnDSzvMa/qT
         FNC9rQxtAzkR4kpNykieRDV3wslCY2hMVyd2ymGbepprgc3k0xJyVdFP34ntdvAHDIHt
         syCmu1MWmSLLaJoqE+/pfDqpT+cPGVXFpmJdaRaxcZRCvTGpJXXepwn3WsJfUpF7a07u
         6JGed/637tGnrBz7gloSq/kI60s8WCQHQyceWvMgjRs2aywTwePXUdwGJ8EgM/0n42rW
         4w8Q==
X-Gm-Message-State: AOJu0Yy9BGc4jbaaojTBRoDR8htU1neoeN0nYg2n41SvEzhsrPomtzkx
	EOxh7E3xsO3qEL/wApZfBQ5o2XQFCJcHHxg6OBzuSCA1Et5Ss5jFIOrNTBVk9BSKAVAY2Wn1ob6
	qoq55nBzH1Wk6pzg5y9xxs+fu1dPuKahlQQcAuWLfKbkTkQKGZBRzUB3o1+1tAJ2t1cJ/zYcCxj
	f3oqUgKybI96VQKAtiIcXZbR9sM2yydGGTOEdSKlZ/H8O4cK6APQ==
X-Google-Smtp-Source: AGHT+IE2pHLovgOnNgX0qu5gbs5FeLa7ug3A+DGcUIVn//cp0TcsogJ3mKsYujLB7FQmXE+y53tXZaDOE0Qv
X-Received: from pja3.prod.google.com ([2002:a17:90b:5483:b0:312:1af5:98c9])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c7:b0:311:fde5:c4b6
 with SMTP id 98e67ed59e1d1-31c9f3efe45mr33500923a91.6.1753163883862; Mon, 21
 Jul 2025 22:58:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 05:55:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722055611.130574-2-pmalani@google.com>
Subject: [PATCH] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>, Beata Michalska <beata.michalska@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

AMU counters on certain CPPC-based platforms tend to yield inaccurate
delivered performance measurements on systems that are idle/mostly idle.
This results in an inaccurate frequency being stored by cpufreq in its
policy structure when the CPU is brought online. [1]

Consequently, if the userspace governor tries to set the frequency to a
new value, there is a possibility that it would be the erroneous value
stored earlier. In such a scenario, cpufreq would assume that the
requested frequency has already been set and return early, resulting in
the correct/new frequency request never making it to the hardware.

Since the operating frequency is liable to this sort of inconsistency,
mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
invoked when a target frequency update is requested.

[1] https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/

Cc: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a1fd0ff22bc5..4a17162a392d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -910,7 +910,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.50.0.727.gbf7dc18ff4-goog


