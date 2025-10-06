Return-Path: <linux-kernel+bounces-843510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5FBBF9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD11D34BF03
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3BD2DC764;
	Mon,  6 Oct 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKiqWG8R"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20126561D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787667; cv=none; b=Ag+CwQsliieEaWSA2jGW3V06tutNb1jUxiXtTHtPt7j5jMRvI1tORL8bXxN1ssLhsVtgY3y9ph3HFRVIiSsIyyg6EtaQMm+JS9SW2kOkFqVbxFZd2rjfE8STXREi4eGfbZgZk5I8wIc8IeOGH0+wrzV5tvEHUXOhN6hEjpw01Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787667; c=relaxed/simple;
	bh=SDk0ccNxqbagGL5JM2RvP/qQ71Mw0w3Sux7TGmbM89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK8yy0awdqdK59gvxNWNdvJwwi0zoxAZTlZyKDP5HDEzfY4eF2R45eGlL+FJQ0A2rlMUkRuFumKpNUzX/6vfT9pEskzeHMZIVCT1XLGwudB5qMIe8viPlZFFubKtj2+vBQSZw56hayZOQwJON0oM9jLfKS3QjkoARjPZGO8sVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKiqWG8R; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-85d5cd6fe9fso432052185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787665; x=1760392465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHzE09hpsw0lAJL0J8v7uFjrU395EJVLjHASm1HYY4s=;
        b=AKiqWG8Rit6wYf5ZiVdmg8+/v1KXWj4nmZsVctvwomGDm0n7gDoJJ0r8KWy1p+GNrW
         etLpFxXI0rSy0zFcAfvUEEokPC7lWv4wcoJgfZYvHYiTLo9AayEw4L+/3K/9e6Ja7Mid
         fsjkmVT4mjtyHDTsxv9HQRgqe/6zur9RJNhncM8qSzQmMmdu4yheLf8yTdMGe4zRvWXs
         svSGF9Co7WWJJWsDkBacnJ2LO0Wz+/NlC+IMjvKzyhpbyiohcAqGMjY7p6g2s1FA+OjS
         KiajEEZ0I3ofYgyJUQOsRRRzOhtsDRwyMB0fVNkG80wAwzt/gCqzA11N54EhiD5eHYT2
         HkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787665; x=1760392465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHzE09hpsw0lAJL0J8v7uFjrU395EJVLjHASm1HYY4s=;
        b=BHhYdF7qu31BYBhXwBdq56sI4lUDAQZpHW6Ifdq31FXss+SCuuwt+/ubHYz4jYGMGr
         hgeM3trmw/H+YQYJqo0MICKatGN0BiNT+ZdP9tGNALrTW9YohpHoZ1cSSWUqtMRV823E
         xtltOJ+1ToBcJwDotGlWlGXROsvo7xIWKEYqCM80/tU0KM/4ITRpwssw6EIYptFpq5oe
         LmhNt/CLI1QJJm5mDW2qols2fYL3NdDJZxzQcilbmqqwM/JpMpYfkCwj1CaRGAWg9zbu
         zifcOgj4IeAiyAPLUVEJH/YrXSup0/sTk+L9eHNY3bT/KYEcjKUZEYsVJ6AdQZiq/sAF
         Mjkg==
X-Forwarded-Encrypted: i=1; AJvYcCVznRbPeJbXAzj3etbhIBDnnCsiLQ362LF5UNsUlmx3hviSOfSJ7vztCQudPt8zIzW/3CI2sQQ6MynBves=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRW7hFKSfd1Q6ZYvH1uVP5kNqN5/Izlh/uTbX9u+wnaHmQeVJ
	B1w/DpaAprJpOd5ibmMHF+0vl+uYHq72+V8gtFqN/06+ehfrpw8zRCbw
X-Gm-Gg: ASbGncuzRZMdtOcKwmKRUdJYqbrY+2AZgHR0+nQtuWnbNcgS+A7VUZAxdt4+pGEIV5u
	xj7nRY7a2LGt4Wr/tIJxoFiZGo0Qj/96Q+SArUe/Ivs0hfXXSIyS38GlhLFWcmbg4Xp1/xfTknE
	7iMcfizjxypHmIAvhkZvlfAmfCKvkLaAZB7/qpo4dnkwPgvUwDrvJ89oONlqSoYng9PhWB0MfMv
	lryQyzkrlFzi1GOgMY6LUBQAzYyjdejD3cwBzcz0I6dCEWzDDnZUEpBCUBbybmPnUPuI9wvzgF7
	Cl41tDuBPFllzSs78fD/bRH51Xoev8dVO0zbWDEbdvrT1obueBwRPDH/C8ihUzJjV2/Ftu2kvYw
	G89hKRZBCRjveThTDzrN1gDgLUrwb/VJmpHDkVg1t/BJJE2fsDyAg+rag93M=
X-Google-Smtp-Source: AGHT+IG2LvrD5cGaVRdPojLb3sWgPRcj64j9A2zviwnX8ynP3ZNTQ1PYKRgkchhEsVFBNjv83jnmsQ==
X-Received: by 2002:a05:620a:3950:b0:817:4e4a:6969 with SMTP id af79cd13be357-87a3b891276mr1586802785a.78.1759787664836;
        Mon, 06 Oct 2025 14:54:24 -0700 (PDT)
Received: from fr.lan ([81.200.23.195])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-87771129478sm1314168585a.1.2025.10.06.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:54:24 -0700 (PDT)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 3/3] hwmon: (peci/cputemp) add Intel Emerald Rapids support
Date: Tue,  7 Oct 2025 00:53:21 +0300
Message-ID: <20251006215321.5036-4-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251006215321.5036-1-fr0st61te@gmail.com>
References: <20251006215321.5036-1-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to read DTS for reading Intel Emerald Rapids platform.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index c7112dbf008b..b350c9a76894 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -364,6 +364,7 @@ static int init_core_mask(struct peci_cputemp *priv)
 	case INTEL_ICELAKE_X:
 	case INTEL_ICELAKE_D:
 	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
@@ -539,6 +540,13 @@ static struct resolved_cores_reg resolved_cores_reg_spr = {
 	.offset = 0x80,
 };
 
+static struct resolved_cores_reg resolved_cores_reg_emr = {
+	.bus = 31,
+	.dev = 30,
+	.func = 6,
+	.offset = 0x80,
+};
+
 static const struct cpu_info cpu_hsx = {
 	.reg		= &resolved_cores_reg_hsx,
 	.min_peci_revision = 0x33,
@@ -563,6 +571,12 @@ static const struct cpu_info cpu_spr = {
 	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
 };
 
+static const struct cpu_info cpu_emr = {
+	.reg    = &resolved_cores_reg_emr,
+	.min_peci_revision = 0x40,
+	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
+};
+
 static const struct auxiliary_device_id peci_cputemp_ids[] = {
 	{
 		.name = "peci_cpu.cputemp.hsx",
@@ -592,6 +606,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
 		.name = "peci_cpu.cputemp.spr",
 		.driver_data = (kernel_ulong_t)&cpu_spr,
 	},
+	{
+		.name = "peci_cpu.cputemp.emr",
+		.driver_data = (kernel_ulong_t)&cpu_emr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
-- 
2.49.0


