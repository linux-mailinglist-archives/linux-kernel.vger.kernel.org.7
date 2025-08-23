Return-Path: <linux-kernel+bounces-782823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31CB325BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CFE588D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3717555;
	Sat, 23 Aug 2025 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/LoIvV3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009E17BA9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908431; cv=none; b=adVb7wzqCM8bm11Z0z1mmhaJQYyLhjSivCmisdcged/Bk7izbK9T/p7LGsdOrjhDLUMkgXcYYmId6dkYR/gfLK1j8skN7FG4asHzLMAs8Lml9XcH05d0rHNV0J0Cgad1rxGi+iAx0BCfU/p+ElQ9KZjLpQaOTt6hpEy45CXhj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908431; c=relaxed/simple;
	bh=IzXBy0JDm5P7DeRxtoCFvOVrJJzRcpwGhg/ODLS/f4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhw4tIfRrOEETIts9euQEsL1migCvmG5zYEPaG+3UlhwJSsVlK8EBaUafaLLl3052X46e4prGxVzQ/IDYd47qTyz6zHexBZ2Lh0gb/8xD6TzPcc2y6rPbe9BHFRb/3bf6a1CXt8AYYLGsdTWzDyyYEgTPkN23HyAITkyAsFMKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/LoIvV3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so2898175b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908429; x=1756513229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkunMuqOTjzTmYvfp0kTEUrdTSxEiMipgCHfYoiQGpg=;
        b=C/LoIvV3G5gGWak0Zg6/TA3X1Ee+kQiFe8bRwpI7RqJtMtZ/7rkbRdN2fstSA5S5V5
         E1iOEXKfiTMUrWtTe5EdZPI0wL0IQlNIvxvH0mL7DDUsV6zWHxbg8c9TebQ2t/rNlUWN
         8YS+qyzEZNETXoW8jhGOsBSfprRw84MCZBoTkzo0dnG33URLhIWlvzw+KwaHIek5gdig
         utGKizGKOYcdJcfqf2Nf6aPQSPVlHPlklF456hMkVTZkZJFAagapprQBxmiGly1Sfz2T
         VLSqicJxy/9pvuW0oIyZVDjGI3tssbPA7IfOy5iOwWDRyjDPiYvQVcGN3poeYfuTAlso
         b0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908429; x=1756513229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkunMuqOTjzTmYvfp0kTEUrdTSxEiMipgCHfYoiQGpg=;
        b=dnO/yebp2nUHQs6ojgvCweaa/G8g751tepAG1CwBGvRxi0Wb9dR847RExrtgi1kKcm
         zy1kzKt4PHYnmokkl49n8tCMyFTzfo6wCTwE9hel2LSL6TtPXDgRh0L51FNNR6YECTfK
         YkT3hJPlKfuwd7pXhaifu7yMBBDUK8Wz5u3u3exR+Cii6DwO7/Lhd1BYIivJBWai4eLz
         ttYwcroPbqzSK/IE9sEhh0vVfXk5G4VsRMNG5UjctFEshunOUMwAUJ2SJT3EeKs93Yfr
         uansj7z+0HTObXfuyAzjn7VzgZx8o6c8Ic2ZMlHSJmlDmwaKWqQbywMX3VJfCKFlzqMj
         u/6A==
X-Gm-Message-State: AOJu0YyH+MkAfovUCfUbHGwCCn58gUs8Y5PeIrDQtNxWqMc39mJzLIkt
	Y6jmxzLenfPScW6pYqj6rQjjqQmGSdnopE556iLyt9QcFTuSCIDjo1+BAfbzPKPX/Tv0f5w4c22
	MH/PMdc9qlBGjcrpglPTRqVcGjRCM2Bi3OxRB/SUY/NZYrsHnM1vmBG3QGFR6/Dh5TO4EX774Gi
	9t4jnKnn/cB9/g3AUT6lDmmlDBQslmcVo/BpXOyAQHJMKi5ioWRQ==
X-Google-Smtp-Source: AGHT+IH2meIMrbfg6cA0DiATMI+gqKbNcFZVYHUt9TbVkruM9LnU8cXpri5WfeUocsKnglMv3dRahkUsS8Mf
X-Received: from pfbfa6.prod.google.com ([2002:a05:6a00:2d06:b0:76c:555a:bfaa])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430a:b0:233:927b:3ffa
 with SMTP id adf61e73a8af0-24340b7ca46mr6933649637.12.1755908429227; Fri, 22
 Aug 2025 17:20:29 -0700 (PDT)
Date: Sat, 23 Aug 2025 00:17:50 +0000
In-Reply-To: <20250823001937.2765316-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823001937.2765316-1-pmalani@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823001937.2765316-5-pmalani@google.com>
Subject: [PATCH 2/2] cpufreq: CPPC: Don't verify cur frequency on governor start
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"

Opt in to not verifying the policy's current frequency when the governor
starts. CPPC's get() function is known to return unreliable values,
so checking against that can mean the frequency gets set to the
unreliable value even though the governor (and user) didn't intend to do
so. That in turn causes unexpected performance drops.

Cc: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4a17162a392d..7fd6c03bb726 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -910,7 +910,8 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS |
+		 CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


