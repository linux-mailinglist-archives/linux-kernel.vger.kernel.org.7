Return-Path: <linux-kernel+bounces-803359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A16B45E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7634E3D62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399423D7F8;
	Fri,  5 Sep 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRAq79L7"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217830215C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089511; cv=none; b=uyPT0XPDVEQvO+QPjKpaw/uUiiITKQne8wX7USSZUQ/No0pXfiCwDjiPUGf1RZN1XNcI/ekp/BenOZro4L0ZskESwdzv0U9XkWty9LG7ymQibdJNr5PyJBZF1L/KUCGIf97au4qyy3mCny08y8Yw1yphTrjP7oIdLAb3LxxKnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089511; c=relaxed/simple;
	bh=guIcHIKYeFDX9C4HN1q3ElT4g6Ed4YixRaeM6K0q/jg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CrVyJA8terkRxZkh/UZfuRiqHCfzRY4ochmXc8zAa31XJfikEDXhF2fuOBRrgEXioRMU7tUu8mIx/UeikWrRCofc+bP1YtHggvNr7ihcnDlxf2Zm396TJbaUMbasinrKqJwWKq6VRUgB8zvI7lngAXPBFYpWvoSes88KmlCQWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRAq79L7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso1517893f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757089508; x=1757694308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdHOLLqwx7tJvI93Mas6xLDQ23Ec8f9ZA36n15YArp4=;
        b=eRAq79L7IdKxIQ0U5MWTvvq1wEVbWiyEJO9pnkSgrHFQlJnCFNZDXh6G/5udLVndS9
         hZQjGvjD95LloAlmYscmLALZG16dwQJCJmxKG0LSL2mwLGTXL6Qsgh4xKKwKTCXYTFG6
         AkLSTDP0BThkHLEy498+Onhtj+HGj6odz5eYl61PV++Q3y+5bvqUo9XXM9ZIq0ZLQE5f
         LybZ0vIu1+HTPSxDlS/3gJfrFXaaiStlKmizdh08D0b3faNgh31x8PimgMSY0OwIXnNf
         KKpEy88Vhsu/B2jI7mYirANleouWssbHAcs4Jf7qjEYQFyEuyZxj94rAQ16d0b+kxT+U
         voSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089508; x=1757694308;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdHOLLqwx7tJvI93Mas6xLDQ23Ec8f9ZA36n15YArp4=;
        b=e/8W6KZCk+KVoB57CHBEGKxIzcDvTz5E4wHbbK0Hytifmy04SOvUQfXD4ArRDY4m6G
         tzjL4ObbQKZV8VV1opTfce1NtvO2V/cJ5uqGVMKhM++iaDDf8hVHGpA/XqiS9W2wBju6
         ovgFOyKaRh8eHMYX2dEDcCZUUm4X8reGNDOegyxPiEdrRPknP31hgnz9VOT/g2d06iVg
         WmAPP95jqqF2JZL4HfqyGdSx9tAYTvzf5oLqrRxY++4w5T5i0kHJj/ytb620eoYz6emN
         fqU8AjYCPAVwaW2lxHX5a8nZVr9MA8R5Ls+yb3KZNYiqRSDer1Hn4ihYhzgcASYtazt2
         zVuA==
X-Forwarded-Encrypted: i=1; AJvYcCXhckeopuX5JglA2zUafrqDOmMiYFmtWwEjdbY/UfFRn330clmUeCM8mKOEP2AVfXrpmgSgM3DxUpwPy40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQwcrZJksKvCOSUPLpgKIMKAeV2EueB1gpj3LSkU4D8afYS9H
	isXN6Y2qN0p4OGKztPg5dE3Zhg2842ohiH6RskA1lS+vbtMHvblGegg6Y9Dj049Tcu8vArVJeb9
	pkyj/uA3CksmQrg==
X-Google-Smtp-Source: AGHT+IFCF8RSEKc2M561aTeMp6Eg3cFM8Srz5/Q2pYIUE/bN9+Udlr5Snzmc+NupcbxxSPDUPWNVnLF2ct7JsA==
X-Received: from wmbhg14.prod.google.com ([2002:a05:600c:538e:b0:45c:b52d:d2ee])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4284:b0:3e0:152a:87b8 with SMTP id ffacd0b85a97d-3e0152a89b4mr5750276f8f.8.1757089507832;
 Fri, 05 Sep 2025 09:25:07 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:24:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905162446.88987-1-smostafa@google.com>
Subject: [PATCH] soc: samsung: exynos-pmu: Fix for CONFIG_DEBUG_PREEMPT
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: krzk@kernel.org, alim.akhtar@samsung.com, 
	Mostafa Saleh <smostafa@google.com>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Booting the kernel on Pixel-6 with `CONFIG_DEBUG_PREEMPT` prints the
following WARN:

[    0.784187][    T1] BUG: using smp_processor_id() in preemptible [000000=
00] code: swapper/0/1
[    0.784328][    T1] caller is debug_smp_processor_id+0x20/0x30
[    0.784433][    T1] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
7.0-rc4-gd69eb204c255 #1 PREEMPT
[    0.784439][    T1] Hardware name: Oriole (DT)
[    0.784441][    T1] Call trace:
[    0.784443][    T1]  show_stack+0x34/0xa0 (C)
[    0.784453][    T1]  dump_stack_lvl+0x7c/0xb0
[    0.784460][    T1]  dump_stack+0x18/0x24
[    0.784464][    T1]  check_preemption_disabled+0xf8/0x100
[    0.784470][    T1]  debug_smp_processor_id+0x20/0x30
[    0.784476][    T1]  gs101_cpuhp_pmu_online+0x40/0x108
[    0.784483][    T1]  cpuhp_invoke_callback+0x188/0x2d8
[    0.784490][    T1]  cpuhp_issue_call+0xec/0x240
[    0.784494][    T1]  __cpuhp_setup_state_cpuslocked+0x140/0x2c0
[    0.784499][    T1]  __cpuhp_setup_state+0x58/0x88
[    0.784504][    T1]  exynos_pmu_probe+0x2a4/0x380
[    0.784508][    T1]  platform_probe+0x64/0xd0
[    0.784516][    T1]  really_probe+0xd0/0x3b0
[    0.784520][    T1]  __driver_probe_device+0x8c/0x170
[    0.784524][    T1]  driver_probe_device+0x44/0x140
[    0.784528][    T1]  __device_attach_driver+0xd8/0x180
[    0.784532][    T1]  bus_for_each_drv+0x90/0xf8
[    0.784536][    T1]  __device_attach+0xa8/0x1d0
[    0.784540][    T1]  device_initial_probe+0x1c/0x30
[    0.784544][    T1]  bus_probe_device+0xb4/0xc0
[    0.784547][    T1]  device_add+0x4d0/0x700
[    0.784550][    T1]  of_device_add+0x4c/0x78
[    0.784556][    T1]  of_platform_device_create_pdata+0x9c/0x148
[    0.784560][    T1]  of_platform_bus_create+0x1d0/0x370
[    0.784563][    T1]  of_platform_bus_create+0x234/0x370
[    0.784567][    T1]  of_platform_populate+0x84/0x178
[    0.784571][    T1]  of_platform_default_populate_init+0xf0/0x120
[    0.784579][    T1]  do_one_initcall+0x68/0x2d0
[    0.784585][    T1]  kernel_init_freeable+0x2d8/0x358
[    0.784589][    T1]  kernel_init+0x28/0x168
[    0.784595][    T1]  ret_from_fork+0x10/0x20

As this value is only read once, it doesn't require to be stable, so
just use "raw_smp_processor_id" instead.

Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/soc/samsung/exynos-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-=
pmu.c
index a77288f49d24..338f4758a089 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
=20
 static int gs101_cpuhp_pmu_online(unsigned int cpu)
 {
-	unsigned int cpuhint =3D smp_processor_id();
+	unsigned int cpuhint =3D raw_smp_processor_id();
 	u32 reg, mask;
=20
 	/* clear cpu inform hint */
@@ -361,7 +361,7 @@ static int gs101_cpuhp_pmu_online(unsigned int cpu)
 static int gs101_cpuhp_pmu_offline(unsigned int cpu)
 {
 	u32 reg, mask;
-	unsigned int cpuhint =3D smp_processor_id();
+	unsigned int cpuhint =3D raw_smp_processor_id();
=20
 	/* set cpu inform hint */
 	regmap_write(pmu_context->pmureg, GS101_CPU_INFORM(cpuhint),
--=20
2.51.0.355.g5224444f11-goog


