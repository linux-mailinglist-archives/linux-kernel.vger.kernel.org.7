Return-Path: <linux-kernel+bounces-744413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2AB10C91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FCB17F09F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564A2EAB90;
	Thu, 24 Jul 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8SJYDLa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D42DCF51
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365404; cv=none; b=P3WaVBqCktLZ4IomL+iqX3w5hEfBlC7sQDOrOBAEkektOvyGyG82wdG7sKle4yCNLXvyEgJHK2q6q/T9ZnM3HJuealkXOPXTZXqpCFkXL9CfWqVtKmAtBuhpghFfekZDCJbwYcXDWYslWSr1pG86x3fZv/OdiMRVyY9z5MPz72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365404; c=relaxed/simple;
	bh=+cBbT6O+Tv94TMabrjEFapPNfjw9qG0Ap1lk8pPj0JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ3URfrfia2WDMLcpXPcUhhLIGdfdKBWK1/zUSmsd9mkY7XPgvEPg2xg68NRbUrNQQAkqn/M3cUbggWIELdE5NJLwS1PyddgdcPcN2hv9YNB1OoRnKdnGpD9kYDfcOUbStgV6TdpDK1lTJerGpMFzpO7o6A1RMgP8E72C2v++xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k8SJYDLa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561ca74829so10973395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365399; x=1753970199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYTWTc09XiaelzjVtYPzYhjlFtDK3ChqlxDovLkTtoE=;
        b=k8SJYDLaVrQBu7nJiAugL1b+RnxDGdXK2HghIEILwuyhIuapFZ08wm2arPcsVtyAGz
         lRDnHc/J8Oazdnt9gudw2jEdE9opbImrUxArZNGpi7AtJuWiI9nCbFU1rljwaD/1FpSV
         N1F6hBSBkTmBUfLKZ6grgFt69thIZNzcmZzh/yNZ13ktqFZwrbxS2zs26JjExJqECzjX
         WcLGXjZAlG1Ccx/JPMdpzJjcXbXG9u6cb68AumCE5jJxPEzGleBkQV5IcyWD1MrLStBc
         8kzj2RJYG6ld5yMvA0zKwyNVaEi77GRKspbDpkrtaXEuypVijf5rbr6mJAxYLAeafyQo
         8z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365399; x=1753970199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYTWTc09XiaelzjVtYPzYhjlFtDK3ChqlxDovLkTtoE=;
        b=BH7qZ8sG+dnIw/BgS9bGjveLexcYjzscoygChk6wJJH5gC97HOCd6wxOZFlfo57YO6
         CjKoYR4pdoOoqqty+wzhVk5+OpwFUdvXTexYvw/s3AeqNh3olmbTUDqqPDeKmzGCeyln
         XnQGgF2J55dmRTModM/8spKksumBMgWwnFtdGOAe1N00iqU4BD2pWhbKSxPRrsP26iNU
         C4UIYYuJOG55bfqekgryil7YBSlxCPoFlPoINfV7264TUE7jgFxQKEv2AteCuSrU+JSz
         YWCOfLsLxZr+XXZc0bum7uDpHbGyhbb2Ev6wrugxppAz4yOW5vR0O53Oig7x4+Z18Fli
         UgwQ==
X-Gm-Message-State: AOJu0YyvfOpHIORJuEh6tYWVOrLgyWZLD0tQBzxpW0hbLhHKbIqSIMfw
	B725+2Cmcvc6aruNsJadpzx/s1dFRBIhMSaic3YbnWQPjAgOY9n1gIKd4/oDJvkOOYwZhH43RCW
	0dXqEfR4=
X-Gm-Gg: ASbGnctYOl4+fetDMXoiRFaQ+vCe0FwY3+HHrVxkawuURvgMKPUrTJZzK4jYA9SWohf
	5iTI/RD46BiddLIIeurmxwlVRAzmn6SI5//ZRGX0SrDMeel3ULb7bEVXt7vN9nPEYeEbLu2R6Ux
	azpQgRMx8ceYqU0wEvH1HwVF3NcQhO4algv1JvNSxqsylZVGwhZK/4nZwNlpMHGQJTKXDa7ZNVM
	hhriAfn8S81YqUgqt+l8MJG6IO5z/9OD9api40WDxaPt37UPoLzBPSIuopSiZUTPL/ajvPcN1rM
	r1oIGzqMRlMnDt3tZrnemuPZNtt0h8tpaAPRdsZimXMAAjFB38ADS090zkUWFoZMckZJCnmlNKv
	falnPzzluTgN56bj6WeJMbwRAV8Rxcxmhug6tM3C4aKEvYmr8FhtP5RhKRMdj1O5kq8q5bbgtj/
	WOAf/c69+tvCkV
X-Google-Smtp-Source: AGHT+IFkEigCZ6sJ1rjDkc3I8yrqrXhO4W8lU33Z9QEAlANeXLFiBfl+v0dIWKjOVtP26nHzmGjQhQ==
X-Received: by 2002:a05:600c:1d22:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45872668487mr2491595e9.30.1753365399512;
        Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 19/29] mm/mm_init: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:02 +0300
Message-ID: <20250724135512.518487-20-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - high_memory

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b..fd577f988f79 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/kmemdump.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -52,6 +53,7 @@ EXPORT_SYMBOL(mem_map);
  */
 void *high_memory;
 EXPORT_SYMBOL(high_memory);
+KMEMDUMP_VAR_CORE(high_memory, sizeof(high_memory));
 
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
-- 
2.43.0


