Return-Path: <linux-kernel+bounces-744401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94AB10C71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A36FAA5A54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255562E7167;
	Thu, 24 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th3aUFFI"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C42E3B1E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365395; cv=none; b=VQvlaah8BnliGbIjWvNwV8+XHAkw9GzPhPhFdDx5NCp3HXEr3sgkRpqyQGUJg2+SrV70CVC9imgcZ+A592egSnnFHpyZ55yHivXZwI3lPbSVgzCsCEBaTFwyXt1sNO5qURapgji+BsjDtuVTDVDaxHRtboKOSIZmmrDPFZ7j1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365395; c=relaxed/simple;
	bh=WYZcYfuknZj3jTFjyz/2YrsteC6Vf4UuZMKZmSw4y2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj5RgZZYsT7m6X0DTn9/+o0EmOT14sPY9+jVBf2XRkrdv7dv5Kb5hF3rZkEj3uRGvkKt6qDJgjmdQZ6E1nLBuuDjKhjmWrcuusig4W1Cj2A0/F+RjbQBVZMIntilMDyGHPFtBRA+rfOgjwNSIkdoh59RbgYisQrBgltkVlZm8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Th3aUFFI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so491264f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365389; x=1753970189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=Th3aUFFIQkGTV6sknzNIOajf27et1WQfLB29fQi7HkufV807DZOWxXheL4MoEi3zZ3
         g902QOkIy0IAJTWMNe5iSjJJUGhTKHuis+4rkDDgWUm27kzTq5615hdX0D1j2gyCp+eK
         JFh39ehqr0lZ6HQkTVfimzsFXYG/ZBJZAkPt/FFTfoekOqtl1ud7Ru6xpM/402OFXp9m
         X9UfeqYaRwjAmhvhFYd2MPMKeq9sZTcWxGXXIrwQsMItziTSrEtm9pWWla2DI0cmEc69
         B2qYsUcWWtp123urQK3cXCBMbWlYXXo8Vvip0LCdwhqw7XcijWppADMQJftEF70WvlZP
         JxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365389; x=1753970189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=754ZhLeV6aTccnAi72YeZAlKqe4sOON/R6H0mwMKOfI=;
        b=cXdNwKyrXJitbae6BirWXm1+r1FAatIPnEmEyHd+BL2Puy8XfrAe1Wr1c2v2O9FhnS
         zUTfRRLxpWippZY/MAwiN2bmaGzDvc2reBP+z8t9GRlK+eBADesi7ezoLmcKeaYz/g2i
         MzrweOCmavwRNaBk+jeauzwugJtlve+Cr7d7kBDDUo3saXBAkij92qKycHMqySGwNtRb
         Z0ylHSsYyd1/SdM2whTYcOBjH+5slm4lxn2x4U4FQ8ABzbkroj0FaCMe21jB7CLO5lrL
         HgtWxwEP/1P387H/0JDuvslU0l9+QwtMMLCGRXciY6K5Y60xO9UBPWaZDSRPlRv1sfSh
         WXOg==
X-Gm-Message-State: AOJu0YyAxHJGBz6iuX+OKMkzO0hcvmNxQR3cEQWoGO1U2HeksqolRUhj
	dMYAgLahtSJ1Guxfvrogu2iqOHWQPdpvQ5ddDnn2wav1YBP1vBAFnwucWLTzKLeurBS4CletrzW
	sjAxW3nA=
X-Gm-Gg: ASbGncsRw6IL2+ZgpkrBAZ3E8Gkucr6DEPyUB2M/lFnz9FskW5uBJ4tUU+9p2LNsVk4
	oFVMzzY1R2DcEsRGXTjwwZKLz4QAczMzMvsOgZqfWg2c0pgTH6ltFk56rr5owQP43zq0nR2+JdS
	1G/i9/suxyOHK8RrA2Ahjw3bTwt2FA9OUfQkNjemkuVbZCdF52qLmBpywK4FTW7GMk4EVwe/uVV
	WVcQUJLxBbwJineO9PSc3lNU4u1judXdsbydCYpfKVoHZWwPS0XKwuFX29IF+637FfOp9eo3DU2
	RO4zoGWSbjYfIwZm+2Wg4uays8lbn/3EpPoc3frxXXMuhxZMYykTACKxsCaoSILVKP/O0gQyJT0
	nnuxfgkny5gnfi0RqERXKVDv+OKIwRsqyF5sy8IvZo9H1Npm1gMYQjuAgDVJ8zyl3TUDC0owQqT
	/oql+KlFDCEkRPXOETQVot/LQ=
X-Google-Smtp-Source: AGHT+IHl6TFfQx8To8y+XEm2d27DSKV0h+MO3rvshokYEfPVyki8zgMiinC0EkzG8gsJheCG6bV65Q==
X-Received: by 2002:a05:6000:188b:b0:3a8:2f65:3745 with SMTP id ffacd0b85a97d-3b768f11dfbmr6433064f8f.51.1753365389405;
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:29 -0700 (PDT)
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
Subject: [RFC][PATCH v2 08/29] cpu: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:51 +0300
Message-ID: <20250724135512.518487-9-eugen.hristev@linaro.org>
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
 - __cpu_present_mask
 - __cpu_online_mask
 - __cpu_possible_mask
 - __cpu_active_mask

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index faf0f23fc5d8..d48e4dd979e9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/kmemdump.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3092,18 +3093,22 @@ struct cpumask __cpu_possible_mask __ro_after_init
 struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+KMEMDUMP_VAR_CORE(__cpu_possible_mask, sizeof(__cpu_possible_mask));
 
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
+KMEMDUMP_VAR_CORE(__cpu_online_mask, sizeof(__cpu_online_mask));
 
 struct cpumask __cpu_enabled_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_enabled_mask);
 
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
+KMEMDUMP_VAR_CORE(__cpu_present_mask, sizeof(__cpu_present_mask));
 
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
+KMEMDUMP_VAR_CORE(__cpu_active_mask, sizeof(__cpu_active_mask));
 
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);
-- 
2.43.0


