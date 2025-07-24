Return-Path: <linux-kernel+bounces-744421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347AB10CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBD5A6BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21322ED14B;
	Thu, 24 Jul 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwFZiSQV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC772EAD1D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365412; cv=none; b=Yb4g6lRttRJEesuRGxRD+r2XdVNf0XtYJuJX5AELezTYHz5vlTLck79KFJl6QhlF9HJP5b8FWf/CEKer0a8DAfZLkXjtoVORGeHaKAv9LWlr+yosYFyVw+BtfVFFZlOnKwI960MIh61wBHulpWTDUuYWOcGibjtm1yp9qcqmTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365412; c=relaxed/simple;
	bh=yDgqovov3P+BgQJIgQIcPJeeBOVhAaLQJOWmJvGhnm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXg+fAdZYPzvCjwAWnckgbCXwa2vYTW4v7epOoUg/J8llCDAMLlzRZnDTlroZPO7NSiuYzbTnvt1LIOTCjqGzBMtfr0rX3cRJkNXPCpxoVHK0S8/cyjxpz4UehkmXGayrUtRIgzme1QDs3adow6j8xtCZkD9xocG0eKg4IKw5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwFZiSQV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45555e3317aso5296945e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=jwFZiSQVJYWsamCDFeiyWQiJ3l/lmU7kS3tELReNf7RPsOKXGDXYGlWUMofbznWnLw
         8ZnZ1porHZcgssDi+CbL/Nm4MVmuNi2l0vKRD7VTDAoimUJoblalg2o+NqLFQgq6YvSJ
         phfuCAjdAtTiLT/9XNloAnkBqNCM0xkC6j+phLm04TSGt8Fq+yFcCh3Uy5EFmcCdnOR6
         cPIKZdFJos5wrXSPtaaeGbXhStNFIWhGew6+hUqzuDMNoMCgOyv7hMD+aIFhRM1QbNaw
         T0mAS/mSYMrXQf/WBLp34BXnb39XN4U3ImwgOQAqkZ2UQWp5Exo2pQmuK5X9xRzfG5Jt
         WZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=XvopozCl9cfid5AvoyRMtypgPhgLP46q35r0rlYjKxeYV8pWe7C3o3hxgXGLeWKrSW
         64LGUY7JTA7FauYagTJWMNZttPvHZevtD3jGvBh9u7oexXNlyedaeYpt8vr98YsFiO39
         dTTK+xUGZ6PiZTiWCtOkthe4gOzNe9WaINdOnrQAV26lIISp3sFKfK/rMRaU1ivYYa1T
         i5jiAH9C/e44icN4aso0liD6Xen1J/+MtZyGiGKvsqmjAqEtnnh9BpnairGgFwuMDFLv
         Hh0DI4/xouVhG/p5B+LJWUpDFy3PhKT51N5PasMwq55PioxpYh1EYj7ADctXlh45aNAY
         jvvA==
X-Gm-Message-State: AOJu0Yyc3fb62MIhLgEdi9TDrqZCjIj+X5g+sM9Y9zHislvmrj3wiBdT
	i/J4JXYPAuXJubao3uA6cfx8oS3V740cJLYLE+0uCznbC2cTPCFzRjNbIrsCXgwzzwbWkeosA5W
	1X/BKFYo=
X-Gm-Gg: ASbGncvQphVbDbBaj4MsQkHgdwmMLdJJ88KAVtX0OReuK+5oqr+Aui11E8Yg+vEy8g7
	eFrulJzzEd99TwtAjwGBL/q0V8aZDAAJtmc++aZKW96tHnY+FwjCFdJmNFnt6Se8P/AJQYbW1d0
	q8WqnL+6D8LkqTFFzXrZcvD3tpiqSzbhCiy4wMXORtdbt46o5taB7kM5xnQfSBMOXlf1ILZo9qx
	dWA2YaIyNahelBR0xnUg4HRwgg/xNmwzzEqRMg3nVQJPB6KJtNPGZvQY0789xYnnwN+2yPcqenE
	WVkmfgT+e8Ckxeo1483iCZyQJeUGJf/5P+/5vLu02V3wUhKHXR6w7q5OcY1dvUat2HRmriWFc2x
	AxVfubS/WG8oMTz6/7ZGqnKxNWpQeHZAO2hkIE+/Gb95GvPPjIajcqY05p2JHJPtebhsZg0g2j5
	jp04AkKNJGAkWZ
X-Google-Smtp-Source: AGHT+IHN52iDsRUI3MC45fB2NHZ78a+PI04sVz+MJmf9Pj70BNaVdCA6rPCjq4NJ6xqIYAMwjrcKOA==
X-Received: by 2002:a05:600c:4693:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45868cff3ddmr60788825e9.20.1753365406597;
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
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
Subject: [RFC][PATCH v2 27/29] kallsyms: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:10 +0300
Message-ID: <20250724135512.518487-28-eugen.hristev@linaro.org>
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
 - kallsysms_num_syms
 - kallsyms_relative_base
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/kallsyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..442dc13d00cf 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,19 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/kmemdump.h>
 
 #include "kallsyms_internal.h"
 
+KMEMDUMP_VAR_CORE(kallsyms_num_syms, sizeof(kallsyms_num_syms));
+KMEMDUMP_VAR_CORE(kallsyms_relative_base, sizeof(kallsyms_relative_base));
+KMEMDUMP_VAR_CORE(kallsyms_offsets, sizeof(&kallsyms_offsets));
+KMEMDUMP_VAR_CORE(kallsyms_names, sizeof(&kallsyms_names));
+KMEMDUMP_VAR_CORE(kallsyms_token_table, sizeof(&kallsyms_token_table));
+KMEMDUMP_VAR_CORE(kallsyms_token_index, sizeof(&kallsyms_token_index));
+KMEMDUMP_VAR_CORE(kallsyms_markers, sizeof(&kallsyms_markers));
+KMEMDUMP_VAR_CORE(kallsyms_seqs_of_names, sizeof(&kallsyms_seqs_of_names));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
-- 
2.43.0


