Return-Path: <linux-kernel+bounces-744411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD6B10C77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2011CE01D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3082EA491;
	Thu, 24 Jul 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6mxlAnj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D12E54B2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365404; cv=none; b=DiFoZzvhBv8DqDTYXpwYv0amQFxdSFl7jrkVCu5JCNSPxwGMba19uTbV1SzXJ2n9wkiwHkvUPmaDgaTpr/pq8W3HmY5/2wIPrETvu4xAxx9IcdwacT6ZrBLM5pOH/13j/4JQTXQS1amSY/GNiTtKmK/n1FwasopP2QPF5r55L7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365404; c=relaxed/simple;
	bh=17QGeEGZ9coLnHYcyt7u8QDI4NZW28xAVJJwsgh3bn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLypHw5EIQb79gUJLVf/Ycx6bSahrA/23ftfci400rAUcd+5Ewg6Wlbb9XDrkIGnAqB6NvEAnFhtW03bSyQF7TRfrGfVdmI37jbT3AcawIE9NXGYD11XNU5FJRau/NW2zKS310gxhJoO6fWLcdMnxxa1ROKOU3f3WYdT48Y2CAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6mxlAnj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6846105e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365399; x=1753970199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=C6mxlAnjxxjv8X3k7Jnlv4sZr9Pj4TpM/k4nKrykg4D0lOJYUyc523/PaxPNtpEJL/
         TXdsZL+OlLgXOkacE0AtbuEMn4kpSzX+yHu9F2eDDir2xZ8YNwP7wPzFLOjiUvx0Xj9m
         LKLhOoAcHEXYVrjUsjP7Ga5v4BeuXxRYovBExttSURq+FqlMGJFitUcqGrI98yXatdGd
         SRAbA2++JzajT/CvO7GQWsAcy3obbNBjvf7AtoDaX7Ig/8krnLnaOT34aaaG16Lpv+dC
         GM52ktZzXM7zphMDsSTG9mUdN9y3OtIjMOOtcyA5x4tQcjZuMA8VQJ2wR3zQ+pgNFloA
         +AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365399; x=1753970199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJKFOh1t0BpMtsqdCvtkoNZefWX67AppBNjz3MRLfF4=;
        b=ishhORMhgp3UOx6b483wfDV0QW9Db87FxHQ7/I9IOMEa1lll7WQn3EsfbtF4Y0ucXi
         6enD4+PRg2MP5IqP+Bj+nCTMelSFmcPQeQSWm6M4sFPVfrc5pr2JqnBveqSBlKuBQP0K
         XL3bl6HGFjiUAwsts5rWHlNLENKbkrpayeZ9LHMOO5H47otAyLVci5iQ9JktWLg5vbz0
         GiE9RueBUVvY5Ty8zMnyUI+k4oUaW9tYq8jS5pVJvzyRApygpiAchy2AFtBlm87f1FYM
         FtRXcyyJuP6wui7KqksVXQrY7Fv0hqtNR7lzTH0IpFdKkt7+xtgBcRZXipHoWB5ILzWZ
         AUeg==
X-Gm-Message-State: AOJu0Yzt7D9QtgmoVk6dMRz66J0z/Mt/NtoedzkJtBd9QGxCSMhHRYxk
	spaJE4pNYAdDyios77E/Bm5pKs9S7vUf0DrOQARXMYuw4ncDppMNZcyvyZrspjMxQqGQ7ttB7xm
	dT1c6alE=
X-Gm-Gg: ASbGncuB0rL+ss+lrP8c2FgEs/BwXYD8fgqJwJK1vqskwByGJtEIzw9Lq68XFalXe/+
	BsXFKqSZbbT9T+hSjvbUxpoyq3v6atq85fBchlppp1rDe7EQBNgJsS5Zg945bphvT9NiNHjWwqy
	AOY4W1KVcxBPmHlo1txx8zG9LwU2txJhNf3IU/hBEK+VhGUx1wk2BoEHhTxEyX5vRrhX7l/fTxe
	Qei5DOjXxVTa67JPwZ1zmihfaE2aYpb0yMORb6zKjPot72S0sn+FxKvhfzk3sGtFGOGmdJWrQpX
	f2/or13Sqpq3NRMYIdTpXogwVU8hDIGRi5hQcIkKMwaTaWrLpx8m1Vb5wpDuiv1jaAIPaPojEtA
	Ar+aLI2wg10wrrGXRS8r0xhNewQwrHg1Ia/LLglQlq0PKvtRsAAP+yPMvTurrIlu8tT09ORcGOE
	vjEKZ7eUUcwNVV
X-Google-Smtp-Source: AGHT+IFBpfszojCM9BH8+214LoTonUL/68z7rgbLH3wV7lPKq/S6zSGoTIX7zNxB5lRzwaUzCOOn2w==
X-Received: by 2002:a05:600c:3ba0:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-4586ef5cdb4mr25803445e9.31.1753365398629;
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
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
Subject: [RFC][PATCH v2 18/29] mm/percpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:01 +0300
Message-ID: <20250724135512.518487-19-eugen.hristev@linaro.org>
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
 - __per_cpu_offset

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/percpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index d9cbaee92b60..0cfe4d7818e9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/kmemdump.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3342,6 +3343,8 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+KMEMDUMP_VAR_CORE(__per_cpu_offset, sizeof(__per_cpu_offset));
+
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *
-- 
2.43.0


