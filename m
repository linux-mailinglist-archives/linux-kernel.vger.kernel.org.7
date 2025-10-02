Return-Path: <linux-kernel+bounces-840236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149BBB3E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B43C30C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31B205E26;
	Thu,  2 Oct 2025 12:36:24 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550528641F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408584; cv=none; b=g93C2wmDR5DMe30om+f/Abadi36dYqnCF30KeLcbQq2p6+JjfgOV00dauEmTGoIS1CdDes7c3sBzFTXfbfCvAk/FCPHpIoFD1PuZtnR7qTjHTKjwmaPODWsjvp+QiTgDxRUvm5kumbgFY3Yxs83vGyF7OUGk55jRxjn1EXHTEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408584; c=relaxed/simple;
	bh=K1ZN9t3MdWMg4kJzpTOCTOC/yGyvTS4NMdf0NiQkp9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVuq5xFyb8nekuUpDF28xb9E8gfhlfpRvQoVlJUaLGWxmnKAZtom1tDE9GeUim4l7vLf2wWy5T1rZFT07p/JwbvxnkKMoYGWg/ZCBcCd9TNVipwZT8QcbO7OQro7wOxHMHmHbNVVvojPMnHWX5MTXKAqE54F9KYYNohvTxDi4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e363118so8759275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408579; x=1760013379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBlodwS+anVQZ01YfkUn1gudQWI1rvI4IORZ7L6X7l0=;
        b=XrO5zcDDCxsJCeU1ml7lR+QXaDt8+vD5NoxswB41WcLd9MdmcVpOssdRLNA1BVMbad
         +7qkTATDpJkBlyP48CKAsmGSIEJs1JyaUdW4hMhE057hKFUekVfaCIF48x9PJrydQ6J6
         yiCwtsL+ewxPsQ1VeqKR75qtfaLtDJLC7Qg7kJfd3MuW+0Vs37Fvldoql1CDySbf/yzz
         aeTgrO9FCC1cE46PlVLlsSVRAEUa2a//xnojK2eQf+ySwoLGcKuyL6Kk6nBRk6uBnuTC
         7NTnmxitd62xnHxDN+z1Z4q/4VjmXIXwd190o9BxvS+oF7a3C75tITGqWwMriHIgYA/9
         nNGw==
X-Forwarded-Encrypted: i=1; AJvYcCXsoUfaQ7rM9jj5J4XtTzugpP/Ef2EpmrLNZOESI8CQZDxxFeFESHQBxiTw9+DRy9M+v/HVYomE8U++b+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0eouoBfjKnkL34ZvenGfpGhKOK5WvxHWC7izF7xMvSdb/tE3
	N7fxsMlMqxLtdPv6OfMB699axBvjV7dIeB8Rxh2aNykpPNm4zyIGuB7I
X-Gm-Gg: ASbGncuKF9wBZRPoW437ADakeD5K23+bWaiDe74qsrDhH4nqQ211eaTbLHtM1mavgLh
	nM/qkh3yToB8kEaHgOA6T6OfPf2Vt+q1TDt9sL/w2T45b1duQtH7Kzehe8OlZ63uLddwNsmNNwE
	kO13XLuqSPqUIDs9IXJjjRQC+hZYmeEX3+GBQ2RjjO3bKUbIuoTymnaCwKTWObRaC8vpTqKFMWI
	xf+v7PRWrOLr/7bq7XJHwsxrWEsvukfUII+I94zyu3FkXquQvhZU47Y1GzCCWmvEmtOL+X7owbZ
	ZiRpJ0U4Wkrkh3z40KLubA/eOAS2ykY802gty1spELQfmUtOPDsEOmEdoILDHkC04sdaREt/Ehg
	HGNX1NGZD3S+kuoAJb86wO50sy95B+/uxPe2++Poyietxo3fn2VARfhBexn1KBsyU
X-Google-Smtp-Source: AGHT+IGVheM6RSlx3YE6NvwcvVuLtj6nTKyzR3btS5SvDL3E/dJ2MMO9/HKo8LarFebhRVCcSrUQng==
X-Received: by 2002:a05:600c:c4a4:b0:46d:996b:826f with SMTP id 5b1f17b1804b1-46e612dcfd0mr58976855e9.25.1759408578482;
        Thu, 02 Oct 2025 05:36:18 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693c33adsm32449075e9.18.2025.10.02.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:36:18 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] tools/rtla: Remove unused optional option_index
Date: Thu,  2 Oct 2025 15:35:39 +0300
Message-ID: <20251002123553.389467-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002123553.389467-1-costa.shul@redhat.com>
References: <20251002123553.389467-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The longindex argument of getopt_long() is optional
and tied to the unused local variable option_index.

Remove it to shorten the four longest functions
and make the code neater.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
 tools/tracing/rtla/src/osnoise_top.c   | 5 +----
 tools/tracing/rtla/src/timerlat_hist.c | 5 +----
 tools/tracing/rtla/src/timerlat_top.c  | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 844f0468953c..df0657b78980 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -524,11 +524,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index defa1eb63bee..1b5181e66b17 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -376,11 +376,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* Detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 02d3ffd2cf4b..c432ef5f59e7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -840,11 +840,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 607b57f2f231..82e227d27af7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -604,11 +604,8 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		/* getopt_long stores the option index here. */
-		int option_index = 0;
-
 		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
-				 long_options, &option_index);
+				 long_options, NULL);
 
 		/* detect the end of the options. */
 		if (c == -1)
-- 
2.51.0


