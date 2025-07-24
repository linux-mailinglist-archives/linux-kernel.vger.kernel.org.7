Return-Path: <linux-kernel+bounces-744417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ABFB10C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51558B03AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E582E173A;
	Thu, 24 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDK8xxre"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131802DBF45
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365408; cv=none; b=qtd7nWHL4QsNIQLkCXAY+pBtb3uQYB3fsS0Wkj6ffbLFbIWN0GToOQlWVFH8zc/+uxc/IF3gVkc5yUfiKOFk/9LoDRpNEy0ZjsJb0DugA19q5aMZQ4kdWKn4ZZJB127a6kc7/lPIS6bwOQoyKh8jUVFreLWJ2UUKL3ikLtEXilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365408; c=relaxed/simple;
	bh=X7sQWVi2ES5AdRRit9jippI6XjHYlOeEQQ68I6dFb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaM4FgMHC/3KOfOf/sCEELA6s+guZfG8RFGqU6e5hp8AOhV77161LX1dwu/NAkIDmMcnPe9wwRejw51XUBRH5OT1LlwTjO7TM20daAmON4wAycGRoFq1B9jwlcpdOPxInaZXHwr3mehv6yohq66YVAOdLv14u7xlwNmBxeDaG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDK8xxre; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso10996505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365404; x=1753970204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=hDK8xxreujp3pWqlOMBgHmmfxII1+ZylRyCnatQz8Hk0KNv42+sXlYYp46lcSWd523
         4LuB40mwAABhQX7sjVmSidiHpqHylox331Mjz4+Lchqvwum1GNawBGl4vQ57S7M+BsH+
         vZkkP2Mv1RO4CpOAvit+S8EBWTHEIOFr3SehSdTDrky7xm0ndHSqS4Cov+H+OZSN1Q92
         o77CgsrPAOIQ51h59pGKu40MHnFCuMgl6JMJhv6JcB6E3QJZqv1yx31SbUUXPSj0Nv+s
         NwxZaXNRDj4Xckeql1Mrll1FKb64A8a/27wwvKfM9If0OvfszU/UF6rmMUUqGVbUJG/9
         acsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365404; x=1753970204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=V/f99wUe3vCQFUaf4S69M6PDpWHcFCOGxuw4Fb5lQASIP0RKLLOruS+h8ToI+EB9t5
         T0Y+63KM9i0tLsECEMLQS66UC9bBmfpkCXP3LRPEi4y0pBaiO0H7HKs0eQ3Y5hd/R6w/
         ssfANN5ciF5Ca46XLEOQgXOd7C6LWkeOT2Pd6G4VUqpxHDOwXLl6Pt/ZzF+kTPd3sWth
         PtU+N5cNU18UrcucQGwuyebSYH/6uv4Ga3UF+8poSvxtnNFI8jHrYY8Ll8H99to5mrR5
         AISGf2RlHAnvZgZQJ535no2eKGNhiz/Hu2Dag5KKvp7Q8jzXCNJLoqSg51ZIVrqLqlaN
         Lxwg==
X-Gm-Message-State: AOJu0YyhazwtDA2KNbHdx92Cqi3qfrH0LqPMJIkkLLBp/Tqn1mOlrxFR
	uEWoyl0JLogErnK8QxR8fjpmDJa8Cjonf+UUh+YFBF6kWohQKsfbGDIPn1NG3/10kz7ZrHXeTG6
	TF+e27N4=
X-Gm-Gg: ASbGncvSusG45SQz6/qtCss9HUQC6/R1i8GDeI30MLMOrLOi0vRudmstiLITK4eW7AB
	OpWAmxlwTi/OCDwxscIuhci3mygcSK8lwrB/k/3Qolv6PGbM2+wYsKDhxYtdIXUvNfEvKXEc8yD
	4pFh7eHFDwnWu6lXs6XbI99t/t5vunor2SkOLKrRvKSu3oZiYD/YkproC1ZOzSXM75lmf7JCiBM
	1oI0/dVokoqXsijqPjA+62hGwkQqCOLlGsC4UWtisCATgF60rK8PL7kXrvOyMxoV4rbPtu5P0ds
	g84zDedPU1HWZGIktEH8G1VihyKHVPFLJoNvq41uYn7LB/3BFWFDgYo2sGki8ZPzL1GieEz9PfX
	u//blMTQR7wN0PRluPqQySpUzWrU8Sw4JzRUL2B0VU7hjdUxCfvh/5UDOBoBYNMt0xNo3rFOPxE
	FJOmmjGVDiiqmk
X-Google-Smtp-Source: AGHT+IGKgu4NRvfPslcwd+sSrmwQP//isSIOnofkVKYWLLSsjM6dUJOy4a8soeLJ5d7o54vF2kp7ew==
X-Received: by 2002:a05:600c:1c22:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45868d31a2bmr69596125e9.18.1753365403699;
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
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
Subject: [RFC][PATCH v2 24/29] kernel/vmcore_info: Register dynamic information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:07 +0300
Message-ID: <20250724135512.518487-25-eugen.hristev@linaro.org>
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

Register vmcoreinfo information into kmemdump.
Because the size of the info is computed after all entries are being
added, there is no point in registering the whole page, rather, call
the kmemdump registration once everything is in place with the right size.
A second reason is that the vmcoreinfo is added as a region inside
the ELF coreimage note, there is no point in having blank space at the end.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f8..d808c5e67f35 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/kmemdump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -227,6 +228,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+			     (void *)vmcoreinfo_data, vmcoreinfo_size);
 	return 0;
 }
 
-- 
2.43.0


