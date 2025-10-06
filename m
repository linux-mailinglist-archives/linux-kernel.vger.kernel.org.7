Return-Path: <linux-kernel+bounces-843509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4DBBF9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6503C39D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC41F4C8B;
	Mon,  6 Oct 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK9VHRl0"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0F262FED
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787665; cv=none; b=uiPXLiJiYWfKoxfQZRajSG/O0KVegY3Q5BT7ivS+WSThHg0/rfGldQvMOPEAUKUHOLkkIKqPKbnJLLSDd7WAlmjIy4f6ks0Zv6jQuQUAgXH5JfsR9iSk5BCNZnAWVC2QbtuhtYm4WEiyV/K73SWu2z+ADeQY3XPBRL5cwHlHUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787665; c=relaxed/simple;
	bh=lcwr7p7IeenqPSqZwD5YJmYNSJcgYSh3rTbWFbZvh5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzMqhiTplkig7OYMeaIqHocM+osdmCryTmP5LEG8g1QHN5YazYA+6pBwolAJN3NSjLdlVlZ4FQjqX+2j+uQ7N6gY4WFCkYybWDmWza/LY9R7El3G97mt13b1/rCApeQpXNRI8F4p06O2Bw6mGpu8qwDorgTpvkWSTyFUfFWCGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK9VHRl0; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4d9f38478e0so54772371cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787662; x=1760392462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q6YwOnteWkXrFVfwwt3UMJd59Tc05yv6Qyt+3nvVpc=;
        b=MK9VHRl0C7xTbRgycWkLpie2uS7POKLl1hZZA/J/ZeIrOnfcJDzE+zrMiLG2ptcHFT
         lFvTOo8to+yWN3PTV9mApv/AnDqoIr9fD1I2s0U7TIcaAKHZ9+8lTgXQhQk0SwLDREQn
         ontLrRD0KiHhu2ZIHOcuVQTJ2z/O3GnQ0nonYJCHQokmRoU8O+4EB1uX8u465nSa2ndq
         NFQ/5RDH0ck6U4E9efRbQZQRYLWAc5tBOVSx99AL4YdT3MxIp2NS2GNsVQbXSZE0kZCz
         GY9pOS9XuNLQrxzs055arWkVCxV1ZUaD5HYR3hqC8E5WfGv4S4k987u7KeTQ6d9MZ/Xp
         hhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787662; x=1760392462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q6YwOnteWkXrFVfwwt3UMJd59Tc05yv6Qyt+3nvVpc=;
        b=k2Y4U23h3YiBFLur0iDxNAv+mvHl1DVUpgJBwZCWQfxSRhcHKXSdC6qnMWKHAq66yK
         iD/mHWZGWyhLgvhmY9HI4TGx5gsk/uN9nhYX8A4pCXH+Sk0Av7YudFGQoOm0b07Blw90
         8/Tk1DT/ls4QYbT915pi4Lekz/RsejXDVcPC7pbqVUXWzZgJ0BX5YGKnccKY9UTmWbYW
         64DP2JH7FcNDhqgyQGzLFEhKGx8EjI6ZOPkKo2gTYwmerg8PMqgzUGKmGG2ft2gpGHTk
         YLoLf7YkJ+oa1gnT15cFlmUg3Sq8+66Kn377neSFVUaRoiZ84YKFCEwg+z/Zd8rNQx/i
         n6jA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7obwN+v9Jpd02Rw19B9MQaIMjM0WxMHNdw2CymFDHFP20ZPQ/xhtSBodOpAdcEWy4dzxwblbfJPP6kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQENBb4UaWOIBcFCXITItul01jt+wRsHjpgLWIw49M9U9KJea
	ctO67XMUC6vUsNN5bQ9b9F/r97Vx3+U/rQ2H23hdWcf+hmOs+JxIJoc4
X-Gm-Gg: ASbGnctzDkW2gA3q7iiWEq2PAMsbmqmsR0xYIs/dAI4jd46lJ+FVo3g6f/iTD+4+ISE
	Ysd8JHMKGGJEcC8dH6DjCz2TitPD25le0fucZm8zGBp0zPibd5zRHzAlYLWWtB2GdXQfHeb+Oc0
	4+qPvbx+y/r7O5oliqVnx+mgW9yGq4jGKWCpk95gJcsCRgHvH1yIT01kXsOhVlysueC+S2qyzB4
	esCP4w5hVDju0HvitlGGmSS/YOnmGLK2FG4yLuXiBcQ9VaEJUlGn/hnu0n2VT9OU4FC46JazcWP
	i41qVx3vBw6f91/7G3nEZg6ByVejtNsLJ1RdRuh7By3BaNlTYjSQ3ZfwWkPjgkKbJbW2W06+CgD
	86Ipkyt9R/kqurSrXEaTf4T5mql74NpBomAHOVg==
X-Google-Smtp-Source: AGHT+IHchaEbDnZ8Ri0i8FvX4Rk3xyBgP25U5vpYrxC0Nu/hB8ro4Sxja78hVg7UibwtHsPynnNHWQ==
X-Received: by 2002:ac8:5f0e:0:b0:4cf:1eba:f30d with SMTP id d75a77b69052e-4e6de86ab3dmr16256151cf.23.1759787662397;
        Mon, 06 Oct 2025 14:54:22 -0700 (PDT)
Received: from fr.lan ([81.200.23.195])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-87771129478sm1314168585a.1.2025.10.06.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:54:22 -0700 (PDT)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 2/3] hwmon: (peci/dimmtemp) add Intel Emerald Rapids platform support
Date: Tue,  7 Oct 2025 00:53:20 +0300
Message-ID: <20251006215321.5036-3-fr0st61te@gmail.com>
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

Extend the functionality of hwmon (peci/dimmtemp) for Emerald Rapids
platform.

The patch has been tested on a 5S system with 16 DIMMs installed.
Verified read of DIMM temperature thresholds & temperature.

Using Sapphire's callbacks about getting thresholds because it's same
platform/socket.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 drivers/hwmon/peci/dimmtemp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index fbe82d9852e0..a281476c7a31 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -32,6 +32,8 @@
 #define DIMM_IDX_MAX_ON_ICXD	2
 #define CHAN_RANK_MAX_ON_SPR	8
 #define DIMM_IDX_MAX_ON_SPR	2
+#define CHAN_RANK_MAX_ON_EMR	8
+#define DIMM_IDX_MAX_ON_EMR	2
 
 #define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
 #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
@@ -571,6 +573,12 @@ read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 	return 0;
 }
 
+static int read_thresholds_emr(struct peci_dimmtemp *priv, int dimm_order,
+			       int chan_rank, u32 *data)
+{
+	return read_thresholds_spr(priv, dimm_order, chan_rank, data);
+}
+
 static const struct dimm_info dimm_hsx = {
 	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
 	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
@@ -620,6 +628,13 @@ static const struct dimm_info dimm_spr = {
 	.read_thresholds = &read_thresholds_spr,
 };
 
+static const struct dimm_info dimm_emr = {
+	.chan_rank_max  = CHAN_RANK_MAX_ON_EMR,
+	.dimm_idx_max  = DIMM_IDX_MAX_ON_EMR,
+	.min_peci_revision = 0x40,
+	.read_thresholds = &read_thresholds_emr,
+};
+
 static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 	{
 		.name = "peci_cpu.dimmtemp.hsx",
@@ -649,6 +664,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
 		.name = "peci_cpu.dimmtemp.spr",
 		.driver_data = (kernel_ulong_t)&dimm_spr,
 	},
+	{
+		.name = "peci_cpu.dimmtemp.emr",
+		.driver_data = (kernel_ulong_t)&dimm_emr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
-- 
2.49.0


