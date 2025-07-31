Return-Path: <linux-kernel+bounces-751975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB29B16FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CDA1AA813A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F62BE035;
	Thu, 31 Jul 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASMpT1vN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582B2BEC37
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959360; cv=none; b=pynkZYDuCu1T4ZqriHhSyCbA84ubnwc7dIluBPHMTi/a9UV4vhHvJG8Nt90g3b1YcMohaHWQUMMa5cNszD8cckeb+W4ANfQkQ0C0936sfNH1UquqNBjbiiCBrWpsAORxVCgjdwbfKsRLY7jqfi8FLVBeDvRPuOb5cJlC58XEnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959360; c=relaxed/simple;
	bh=vT8thxDnBUGhaNRv6bsofTBtiZ0lHkJZ4bEOP0XyyPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0GWbk2rsNEUjmx/My1J2dYZN4t7W8oy0c+D7K+BYd912wHE83ZcOI0ueJwwU9xf/g9cNgnsiywdtknZAJQ3FycpLWCdnm8uclgbZEzNiRDIJRJZu6Zr+Rm/MWdBzCR7v+FToGdv5KEENPR1bhCwrXF6Juu2fBsN7B3YcStICfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASMpT1vN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso8030185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959357; x=1754564157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gXvphQYm+11VPSF+20asdPzpBx6sInxbMMeHrwqe5s=;
        b=ASMpT1vNryvQ/OCl+dveCRua1gduYwwm73mg7koLtNHFaV+XdbfgenWb4I1inWKgKJ
         9EXTE8MXhAytAoUyf1iab12Kg+MwDTlVlhSZfSGZjVNAvohOKdXZVscOwa9M//t2L5IL
         riRBNp4AUnwK9Sng+smkK3Hqvf1WJQzCDyoUhqLwE4trD6HUwUM9n4uXDfrzfA3AVgd/
         Rcu2nHqVjUNtDmIZePLtDBHA4WLCrKksnQRcaK1efOPlWjEojt5GN9fsjuSr7ZflXO2b
         0NYteaovpWyEcLpP31BQLfFkqPSxXFzc8lugbxo7PboURvWYaOOwPIhnpHn82ARdGbGc
         +Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959357; x=1754564157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gXvphQYm+11VPSF+20asdPzpBx6sInxbMMeHrwqe5s=;
        b=Py1gr2hhYn39lWquZNN9Y7I2W0kw8paR8mMV9IOhM90f6EnatLQEhjLeEL+mUtCyHu
         UeqSmjKpdrPFi19Li03s1GUztWDZtUEn22ckYY780mI5EJeDVLKhXn/yctYlru9JF6iD
         O0HXt6lBlGqg0BN4wbNhQlGE1u1uXm18JnwccnILqqcLDgSAH+z7KI78r+c7+EJSaIa2
         AfffX003LWtPvb9nIzqbWCoekNupmmA8FEIK88aVNkgSj8f+qT/ictXR4HyytMJ6yycG
         xtMLUxg4fgGCYAIq8qCTPoaCXeGX6xkshqAWLW128LKZQXIi3PdEXRFwHv0m8W0TLDzm
         d3bw==
X-Gm-Message-State: AOJu0YxOrUDNMFbZG9SH6Dhal+0lZi5oGigQnd679WGBNOrLHImdhOtK
	PK28UgxFyqt1OKgAWy+PNXfpFiejJcTfF49+qijzzb6FoYVab6HoTsLG
X-Gm-Gg: ASbGncsGoQe+oJvcguaUWmagv2OgIwlWNjTWdSZpWQyEfdarh5canQ/0pk9HX1WUyq+
	TPny5A+IVbZxvl6KKtGrgz9zxdwQVweMlATQpq2snZE+fqTf9epQvIz13ityUJyACYKyr6YTriY
	zzbW4lAnKWdMc2x8dM9SSaEBFezr0J9++HCxGvek3NqJAPeVHw+zVXefIlr1BzrjoroXLWfFnLI
	F46B7D2fkEaCkAbw6U9tyuL87MQWJGuyZLOe8tE7fLyWNNxlftj6i5GMmC33bV52QJNQbKD/E22
	4DRJ+GafrxK4JLdrYYKbhXkL2G8fStpKC+EdJVTQVjdRyAX6vGAO4Y3S3JE3753Vh10nppK69ps
	rUR704otXioodxTyP0fI=
X-Google-Smtp-Source: AGHT+IGq5SMvbmCocSEtPogcy4KMJShnp1ajdGQDUdrBwgclE/e7ildXHY/DEML0ulK+Q4iVwIcpKQ==
X-Received: by 2002:a05:6000:4305:b0:3b7:9173:6964 with SMTP id ffacd0b85a97d-3b79501d723mr5493498f8f.49.1753959357229;
        Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v2 16/25] sched/core: Cgroup v2 support
Date: Thu, 31 Jul 2025 12:55:34 +0200
Message-ID: <20250731105543.40832-17-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Make rt_runtime_us and rt_period_us virtual files accessible also to the cgroup
v2 controller, effectively enabling the RT_GROUP_SCHED mechanism to cgroups v2.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 63cb9271052..465f44d7235 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10300,6 +10300,18 @@ static struct cftype cpu_files[] = {
 		.write = cpu_uclamp_max_write,
 	},
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
+#ifdef CONFIG_RT_GROUP_SCHED
+	{
+		.name = "rt_runtime_us",
+		.read_s64 = cpu_rt_runtime_read,
+		.write_s64 = cpu_rt_runtime_write,
+	},
+	{
+		.name = "rt_period_us",
+		.read_u64 = cpu_rt_period_read_uint,
+		.write_u64 = cpu_rt_period_write_uint,
+	},
+#endif /* CONFIG_RT_GROUP_SCHED */
 	{ }	/* terminate */
 };
 
-- 
2.50.1


