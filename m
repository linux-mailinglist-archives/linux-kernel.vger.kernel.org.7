Return-Path: <linux-kernel+bounces-730588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42587B046AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415C07B1755
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B026A0FF;
	Mon, 14 Jul 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDl2Tu3G"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBE26981C;
	Mon, 14 Jul 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514594; cv=none; b=oI7MrNB1/fqpvMtGsaoPeA6OWUjjtU1KoizY34X7fIIlZ8tcqxeS7orvqQtpmJZvy5kYU/8rMasnnEyZZc4o7sGTqnAu8/aq1fxJxtQlIQuPicMk+PJqKARbF84C9OZJCfohv0M4uqoIO2Gxv7/zSYHYdqQeeQdJcFw0fVq5xDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514594; c=relaxed/simple;
	bh=702I2Xwr0JQ1IzYyTXKZ+lciKW71YsfSJrx3+/tsmDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9j9yY2or3uB1H9En8T9JfrXvph4G+MqXWge7fvTYuITzRtCHF+PNh7QvPYKAK++U9M5XKcYeKU0giJbVquymrz0epga5189pvv2MuOGJtgWOHl5hhoAHE++FPwM5ixQnO8xexyKu+SNgkqlWDS4giL2nyD/ebKEpTyFS5sUyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDl2Tu3G; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45611a6a706so8673045e9.1;
        Mon, 14 Jul 2025 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752514591; x=1753119391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whUhsMYYpwThm2v5rZLxNpKJQfD1DjrRBCSUO99Y8vc=;
        b=lDl2Tu3GIE+kPw2V2gP+055KawNd7A34iX3++h5gwvMJv5xfQC1Xz4clYubx2/v4FX
         SzhHWMIn5EFv98Xt//FhLC1nYMXm2bBs0aTxbM4rhi8BffUx2Uv8hNXWYQaP2/y8Ub8j
         99Rpz2dlTSWiw9SN0mtMZ0ZLf8rolBlfJTSwZAiPs+j37ZZsbSVn0blbvfB62SJMhY1P
         F6Wu4w8KSaag91+OA+5dXfiP+bgryMkAOEb25G2JiLgaYKiDzMD+XAnIyhbfotg+dOdg
         qdb0cKEWJkkRU0xfE5sHv/wQM6mCW4UkETk2mlussSb/JVu6PALAWp0f2oiNH0SkmNZi
         lrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514591; x=1753119391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whUhsMYYpwThm2v5rZLxNpKJQfD1DjrRBCSUO99Y8vc=;
        b=WgXZe8jWbg+EjE2jc4IOHugDQOzHnfbOkP89nnO/TOl1SGZblGtAG9tLijsPVosfJ7
         48vM1Swt+Zi6XPeG5xGfJJHfqg4YDzATipxD/yW0LvV3ozl2CAnFcRSZp6y6H0dQxsBU
         t1TEfeqZR3jDYxzazE56UNNR4mFb4z/mMyd6YZX1qFP2drw3P1AlPieQsZS8xgyzi19M
         kBLoAAI1H+Wppjb50zfzfRfuK080EgTxHmMDSaqkjuuXN6zuQb6t7mDE7HPRD85g/uHz
         6pBguWSREc8alfm0xvcHnyUY0EhCDz46K8Ixgbt/huig2viE0C0csBf3309Ia3am+6X5
         pbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUErz9Evg3IRsmLACBPRbrvSQ+GWysBJsC6lWT2SayjR2PvAS/NTWmJ58AkAE3fZ9fVYmNEMgwfOBitxJOrzjg597JnWg==@vger.kernel.org, AJvYcCVqAySnLd3N5doIB/PQJBrDJPLblLi51k8OnhpqClc/T4PQ/SN+aFKJmgdCmn31rzNVRsIdhWNCxsGNMm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkf9Q6vFN1lncXw5j9SlMyG+6AEUrvldoK/2YrmOuRbn7Y8btp
	88RacIDN+cCBcHC8UgulZxk5Zj3Z6RLyYFAzb9OEgtec4F3ZfQYB7tBC
X-Gm-Gg: ASbGnctWU/eS62jYP0h6trh2F6vSThrymbG3qTzlrHEPXIL1GTiO1E1xu+qEzqfY4yo
	Y0QwTTKRyxn7+WhwMOlrWfKHoxUI2Q5d+eXTrNy+W/2HOu7UdFMAwJywV8ciWlCJHgTJW+TUxwR
	bt/488GzCYVECyIQVfb4hewocSlpQ02ajAbnjd+hjC3qXpwhe6ZV5kZortSIInKojuZ6o+KcEGP
	3OIsTldKBJ40HMRmWkHuSEh3OpBKZVec+Izc6DCofacS4YQ17PFBxknARtHo6eSsej3ub8FAkIm
	hTkpMsBoEXuUmeLaNeHvYBgaLJjo073uDGwhVnPxhBB6p1PGDJMudVx+iUEmuPa5qBPk/3Dx0YX
	PWNbQ5Q34sYXcpPa4Ge+WIyq6HkHXIXBnd6A=
X-Google-Smtp-Source: AGHT+IHeyRgu3Ju/cPBEeClqWZwWBy/pwydoSQ0VoKQwAWsBZ/0ZDZbXqnqiqgjJrU/tfvWCrkKIPQ==
X-Received: by 2002:a05:600c:608c:b0:455:f6cd:8719 with SMTP id 5b1f17b1804b1-455f6cd8ac1mr98728775e9.20.1752514590145;
        Mon, 14 Jul 2025 10:36:30 -0700 (PDT)
Received: from alarm (92.40.201.95.threembb.co.uk. [92.40.201.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm13152531f8f.60.2025.07.14.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:36:29 -0700 (PDT)
From: Dale Whinham <daleyo@gmail.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] platform/surface: aggregator_registry: Add Surface Pro 11
Date: Mon, 14 Jul 2025 18:35:40 +0100
Message-ID: <20250714173554.14223-5-daleyo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714173554.14223-1-daleyo@gmail.com>
References: <20250714173554.14223-1-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This enables support for the X1E-based Surface Pro 11.

Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 .../surface/surface_aggregator_registry.c      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index a594d5fcfcfd..e08d029e0856 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group_sp9_5g[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 11 (ARM/QCOM) */
+static const struct software_node *ssam_node_group_sp11[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_sensors,
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_kip_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_kip_tablet_switch,
+	NULL,
+};
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
@@ -485,6 +501,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
+	/* Surface Pro 11 */
+	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },
 	{ },
 };
 
-- 
2.50.1


