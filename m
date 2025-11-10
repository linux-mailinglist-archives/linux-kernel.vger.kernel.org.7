Return-Path: <linux-kernel+bounces-894167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84783C49658
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298193AEDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13131814A;
	Mon, 10 Nov 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw0+zobw"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C92FB619
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809861; cv=none; b=T+T49r7d5VytRDuGL9+2puMNat6yE+58TeHyWCnCsiac+zf2syZypD7zS4RZHW3IpyVF2pczqyhRrAeyFwVzPJyipmdSyzq61gKpMbeCxC/RbS3V8toKSWuH9hkwZEbwwoTpkAXHTqDcvq923hdwQS0dyOsMRlo5OFHOHC120rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809861; c=relaxed/simple;
	bh=AXwOsvNHcrg3b/xIFEO3iB4vuSkeRwuajiro4QVim/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwqZoiG7jqlCPObivgUHHOVxW/rMMmmoh2CQ/3G7QQTElYPSDGODRx+uRoLeyCSBdsYWk9F3LAsOe/+X0HTjF5VkjbatrzqZpVw33DnFzX1usAqEQR9TlmciGY7OnoeHCijY2rWXeAg1+wVI7MuhFiDeagYS2ZAjoq3phft6r8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw0+zobw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso4179482b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809859; x=1763414659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KXMP3YTBEJQDC8qyumy/gdnz8eZPTRPmd2cRgftQJM=;
        b=Fw0+zobwo9VJ97T7ZOOX1ykBe2WN2o/xHy+siMrSuiL28GxPyNTNECdctLIfyHGQuw
         u00IrSBL/TgifvSQ7C0paowtXYghBxGKgD7j2UmX3QQTiGdmbWF/t5GL/Mw0a7p4UorY
         RFKWFEFDFuhirV3HUkRyxeKv2/Ki3pr+jx4MNAwo/tZ6++kYb3S/BHRWLt4y5GXhiYv5
         6tm3FGsIVpwRkf4iMNgB8gRDiBc/BkGisT+lMRYLZbX3s+LFDStK7+9om746u5gM40Tj
         GDt3tJ+DJYOVSSHwuIQ665J0SmzBu7LVk7Bexh2+X/xLkRdb9/ehgFlFfCOhwGK2EL/M
         Maiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809859; x=1763414659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KXMP3YTBEJQDC8qyumy/gdnz8eZPTRPmd2cRgftQJM=;
        b=Whqzd0ReT7SgIMaxioGMTU9RRRg3MeMO+T18bTmMcmrMvF2sGaIqD1Ja2OmV+muDOs
         ICkW4fvvaERj2fjROdBDkN/Nnyx2I+PiDrf/XZoVnDt3VS2gG8XleH+Bz+Xg5CrA7Frs
         3e6GtVHKaH5wUxOSfhKts6Teymgw3fFcaBUYFZV8yrFEChGsL9Q7Ulowfmvxim/TX8/n
         DhCyjUWtCgfQN+BMsXgJAuuejGD9YPtS85CPGaVkNNSv78a2TPc+Z8E4c96IrPvQ3Xq+
         KmczrMKmojnhVoa5PLdpc7RW/kaBtd1H4evmWN+x8Z/qRn9/eRW+rx4dPZftyJLcY2Qw
         bYow==
X-Gm-Message-State: AOJu0Yyq8x1SY4AO4q8Q9CWfQSLR2bFRf+DPt03in8FImXJmfDee3NBV
	sgJ9dKHgyL62REJWO3zyDi4yi0hu8mNfiglVpkd5hpxQzOHkNLb8EQhYG9UCbg==
X-Gm-Gg: ASbGncvrAQ0H/RWrvybeiQjOQ3PlHdxSDnkT3SsuhX/eP7GMKG8LN0aXq7hxIQxHbYs
	x+Oxz8NLfgkbioBq+NDWDKouhQw54SrzhwoVjzYzKSXbwX7qeMdDJUot8jzcCZ4AeufXTxLgyky
	kJyRptmldsj4Hw0Me1ux7Tc4ae32pJUtskjBq3JjCcONPlSIoTZDbx3QxOKbOLXAwKo7Ba+QY//
	Pdjj3CZND4O9+3jBpE8r7jowWpM/r0Ysh73UifS+ke5ZHiZwagCtwAgdZyT9PU49zhlJtb/pl/m
	85BwP2zXnZDD4HZarLGePnnNqqy91l+fMMb36KKJGQRfHEoxhQucfqz0tSifvLFjZXOCq9nS6iC
	RDt2ueNj3p/D20uPpBaMRznUXOPjJoVWscT80iZvwksuLebw7s70rdcUC1w==
X-Google-Smtp-Source: AGHT+IEHPLSt+JgUdkt6OWsQf4d5bNQ8F8YavX/A1nvjIHSLvmymZwhbfZMlvkfGvG0razr+l2O8sg==
X-Received: by 2002:a05:6a21:32a0:b0:33e:eb7a:446b with SMTP id adf61e73a8af0-353a4496e78mr13436084637.58.1762809858819;
        Mon, 10 Nov 2025 13:24:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm13174657a12.36.2025.11.10.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:24:18 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
Date: Mon, 10 Nov 2025 13:24:00 -0800
Message-ID: <20251110212400.282952-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110212400.282952-1-rosenp@gmail.com>
References: <20251110212400.282952-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helps the buildbots catch potential issues.

Remove ARM64 dependency. ARM32 can build this now.

Remove HAVE_ARM_SMCCC. On at least x86, it seems to not be needed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..bbe478cfba6b 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -141,7 +141,7 @@ config FW_CFG_SYSFS_CMDLINE
 
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on ARCH_INTEL_SOCFPGA && ARM64 && HAVE_ARM_SMCCC
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
-- 
2.51.2


