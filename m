Return-Path: <linux-kernel+bounces-782067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD98B31A81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F514B069D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8428830F80C;
	Fri, 22 Aug 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNl7cqW/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30902302CC7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870922; cv=none; b=KnliqsCS4MuNY4j2xQDCyJdFSXidhyeKY5/C8XjSq8A4mzY5eI6/eKXQKDAhzjm4fMMF09pJi8RDfjjcEBYqlzJd7iG91qt9blogjPb4IKyC+6FKZ16OlIrcyBMQ9cHg7ejXn0pQPBl+SDzgsuwDL0lh8y9PVcVg8YS4i+GnT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870922; c=relaxed/simple;
	bh=sVdC2hU/SSPlglTMWz1ueCPAtY4Ily5J6k4KXXBlx5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogNwsz+K9CCrpGO+yisXKXDybUbDpHEXGXEo3Q7f/hjFvDhfoxImTEzp0s93iap3OuruP8rNIWKkswUHrsqXsowJHMAW5z0jUtBfu6Y3BvkVrMrCGLibNWIdYzX6tt9feRLYGWHYgZMqKbzWbtr1WoWgsqUx03VQupWxTh+bNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNl7cqW/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7aea37cso280331266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870918; x=1756475718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv9g6cDQmujFG1oPRSFe6TPkH+3laec1tY9I5AIeBsE=;
        b=JNl7cqW/0LVW83rC4GYE4ilNNzDWstOKDywkrpJv49J68qUlJK3IPaFcA3v/mkXOy7
         fIwiV4iovDFruxaXADloFqiOy1c0P5yJkO8i0ynWNf4S0+j2nRurEoL/ifkruqtf9oea
         wsF75OXChcIFc1bZZovVrYkDXpkBPCovKFQ7KWG80bBZojkVbnMQNUrAqhLp4Y3i001p
         G/N4ClbWWcuVW9RqjZMApn47vafHErFomYFbLdmrdA88XFrV2V99bNWcr7CMGhtEcfbU
         Zpsw1fT+V3m/QKrYPRyCUwsEmYqPJOZT3tbPeLuwcEwFEobggTLHWxopXJMoDeNSsrlO
         RnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870918; x=1756475718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv9g6cDQmujFG1oPRSFe6TPkH+3laec1tY9I5AIeBsE=;
        b=oAFQIRPPreohIg+jeINW5hYDlB/yT8HzkAmTpDnxunMWJ+QXaWHbUpmr9J2zDqKosr
         ZdYEuu2fPe3R6waH8P3HK5PRHYsPmQ4E2g02NGmneXIHyW4Yyks5iAQ0Y9mn6EP+TGU5
         fIvV+I/IIhXav6S7qkH1NuSjYX8S/X9Cn791oWbrY8SnZ6N6yq0NppAGuD2zjDRzqrVb
         48oJ/StZh4u3dc5bPZKtmWDN5sTTwdaCFifuaCbhsQMNU43DPg110LNI3hh9MXd1L0U8
         3nrHO/hvtwgDI/wqtgzroDozRXrffxV+7Y1vk/ZSLV4DfcZvtdpGOwz6AHEViOOM01UF
         PXOg==
X-Forwarded-Encrypted: i=1; AJvYcCWgag7ona3jYCqzIlSJGfph4zPXS43+wdEzrHBFy2TdypPU3XJNTeGljiJpaeehTV4hqKUwBzKJrysxar8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ss86Wt2PQrFINTTjn4X6AGIZepllyN8+gTGVo+1ACWfqAnyZ
	jaBjWAt/bTfWibRz3GfVJg1BLaUKB6VJxGEGqxguPyWei9o1Ptplptwx
X-Gm-Gg: ASbGncsJ5j6+reGIakD2es1+47FNB1dP5rnVJOt4VJbWHUJvqbYWO7JGyGTbz5wUmvj
	xhFFnFLyxMy+WAOdvqOlm+DoFif91sOriFwXPKUOLcQL6Gh3yEWCmVtMRqKh/N6NwUuOCZa9TV7
	5cP4XY+vgSJXNG1sljhGMV+U5B1pBrNF1wpKwgVDuRWfHB73A7A50eYN7NAeA1bx8x3uL+jOJWC
	93DW1wcDr5wxOanrPxU12DLhE2TIeK7ZOv8aqgUtdX22d2PxqpxMS5UX0GlNsdebzQfFSQMIukd
	bsUUWqsr7Yz+CojQFImIZbNRDneS3vkddK5LIBmfDQuAnsBVuVWhz/LuhfAO2dbwJVVsL2VFOj6
	VuzBwbSukEpch+OfoJ8ia1hk9vekdKOtl3fGt
X-Google-Smtp-Source: AGHT+IGMrws2TvXqG52SlSp4a/tgZdhmkILCp0HBmaLsjoehzHc+bZRbjj7jqXlS+zcy5swwEVRl8g==
X-Received: by 2002:a17:907:7246:b0:afd:eb4f:d5d1 with SMTP id a640c23a62f3a-afe29742ad7mr246391666b.65.1755870918342;
        Fri, 22 Aug 2025 06:55:18 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:18 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/13] staging: rtl8723bs: remove os_dep/recv_linux.c
Date: Fri, 22 Aug 2025 15:54:17 +0200
Message-ID: <20250822135418.118115-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
References: <20250822135418.118115-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous patches the file os_dep/recv_linux.c is empty now and we
can remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile            |  1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/recv_linux.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 19c0525ec3e0..1768b8123f03 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -50,7 +50,6 @@ r8723bs-y = \
 		os_dep/ioctl_cfg80211.o \
 		os_dep/osdep_service.o \
 		os_dep/os_intfs.o \
-		os_dep/recv_linux.o \
 		os_dep/sdio_intf.o \
 		os_dep/sdio_ops_linux.o \
 		os_dep/wifi_regd.o \
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
deleted file mode 100644
index 193725cc60bc..000000000000
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#include <drv_types.h>
-#include <linux/jiffies.h>
-#include <net/cfg80211.h>
-#include <linux/unaligned.h>
-
-
-- 
2.51.0


