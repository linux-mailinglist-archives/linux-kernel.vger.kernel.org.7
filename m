Return-Path: <linux-kernel+bounces-724830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FEAAFF758
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3791C41EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A33280331;
	Thu, 10 Jul 2025 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrGZlAE8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184692236F4;
	Thu, 10 Jul 2025 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117090; cv=none; b=tCTC5aCvrsXzJX5y+2waNgKbk2XfdVKpVfT34hoL+TzzEmxtSAXYFto2I8BR4j+GzMSIIO0ZCS+oMyDlP+1ABejFuND4JdfzPup51i5nv63jZn0aBqd40m72O4OyQ0CBJtfgnGq2mqViBeuNlh/ytWVGTDqeVKymcWfKwUswrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117090; c=relaxed/simple;
	bh=6k9ny1GTn5fIfPV1V7m+CcoEnlggA69s3V5SdxJTNNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hvnDSeI28YwTQ1finQOZD87XY2lIMZmGyCOxGlzZi3Nva6Nq6JNV58H34eLOwM6KG7BnF4EwXO3+bOykrTUwrKDuBOLC15bWeCYdmKnGQBLCEfdB1kKNajYsNBWRSz334KNjzu30AIkLJhXEua3p9RgTVzRtu46VbjEKVRnIDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrGZlAE8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c8f179e1bso6885755ad.1;
        Wed, 09 Jul 2025 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752117088; x=1752721888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3iTK0xRJkvHPTArb3XwTsXQQPSVAfnPVJGf87kQ4yU=;
        b=GrGZlAE8+KpfiVAYXW+5xE0AMWeNuLqAWuVXi9Lk+DlHgMgMy+7eEkoo84H2qF+5Pr
         2bDsvIvxIUKJCkdz0ALtPUfG/lRlV59Nt9pAXLVgMjZi+aWAAEHQniSmoZyZxXJZhked
         1KOGypdq5XD52snz/AyK3BlZgPtQJQYv2rV6CR7KjgV/cT0iOFGjTHh3j/HiLyTpJTle
         qZN6ZhUfEB/qKdgyF1q8XIpDtNBKOqyn7vihkgSfJFQ3dcpXupq86fxE/eFodqZO0PiK
         z/IsNp4/apYe7DA6LKGK1gdirE/PzVVhU9LP+NXz9QTeE+DrNjk2pn7PfFdvOXhQym2F
         5/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752117088; x=1752721888;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3iTK0xRJkvHPTArb3XwTsXQQPSVAfnPVJGf87kQ4yU=;
        b=TGXdEdrN/rK+VpjyLNxa9ICAjZG4tuV4jytqpFdrRz5NPEecpcBSyVs5rV+OIRxOQd
         KtIxmy9ZHRrKVxtJHtM4G6KNbEj4WFhoO/GWNQFATwdvyoipjDdjLzgKdSzZcXsNmMbC
         7KEtU1OrpWXjeoamkExHwVRurC5dlxS6BfydTlXhC1oVrVt1WjgCIkQV+WvPR23UpBmw
         Lchh5YbTSKQSrPr9MIERTtPXRqVbWy46wQGm0kRl63bCX908UoTP9XnGp6zqei4MUALQ
         sMxe3f+to+ppcyHzIQ87zrnEaoKLTVPcXUXJq5LDjl/5vsyYk98MDab1hsHEafHN73EU
         ooGA==
X-Forwarded-Encrypted: i=1; AJvYcCXH/C/JN8Wod5l5Me33AxSxIXSk2YTS3r8PtV3LVssQnom3/OE90IHuzrMG0F3cM40O0EfdiWSANSJm/m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8v8ZMCyHeicT0OJ6obqk8zYjJXjajRM8S5fERhXmWn0BFOUsw
	4oAHpTYyqllSTqDk/1FLlPd4dJUv6m1LGX4fTZXTNg6u3ZvryHiYAQGl
X-Gm-Gg: ASbGnctr7ces1xxpS2bawVfeUhILszOmdBC+6mrMwf4XaKfI4zFq2IOvvI+J9k5e5EW
	TuNQCZDNvoVylOV3mU/I0MO6bJtwcR0s95nV8z86cn+YqVrBwthWgAJZeqY3lfP4tf9MK4c3klI
	YgEQFa9Pv5zDP2LEhUxtFHSpBkgZtmtkS0UcuPwYnp9LKjb+0bQ9wvZ0ylWfyIEpovkC2eThusb
	lBiyQ24Ra1vlj/SoNukFSSjB4BCbDYU9jfBPokDE7pyA0ikan6bVJ3Zp118339TzL9UjvQ2H8YK
	RfYMHuRVpsG5saDnsIDyRAX09F5WoCXrpNTFYS/0KWf6b92HD07wICJYO1bRpw==
X-Google-Smtp-Source: AGHT+IFmrq886azfH/tPjkTaEK+iXXI1YlqKzH/qQEuCCP/1WbtHFkipEj98s93R54HCRpB+wmhqrg==
X-Received: by 2002:a17:902:ef48:b0:237:ed38:a5b3 with SMTP id d9443c01a7336-23de47c31bcmr11061745ad.8.1752117088357;
        Wed, 09 Jul 2025 20:11:28 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434c9cbsm7230045ad.202.2025.07.09.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:11:28 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:11:12 -0300
Subject: [PATCH] platform/x86: alieneware-wmi-wmax: Add AWCC support to
 more laptops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-m15_r5-v1-1-2c6ad44e5987@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE8vb2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwNL3VxD0/giU13zxJRUYzNTg+REEwsloOKCotS0zAqwQdGxtbUAsAZ
 Ax1gAAAA=
X-Change-ID: 20250509-m15_r5-7ade3650ca48
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=6k9ny1GTn5fIfPV1V7m+CcoEnlggA69s3V5SdxJTNNA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5+nFzLVI6pe6LO3XPDvO7YDbb8/+06Q9y7rFZ1JiYb
 Pi77khQRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExk3U5Ghl28kpd/MNgHnKww
 qfy4fNkDNStVrZX2/+YVit+Rf3bDmp/hv2dL3dNbky0+h/lcOq93OOzUIrF9NbXOjnZvb5TruO1
 ZzQUA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support to Alienware Area-51m and Alienware m15 R5.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 20ec122a9fe0571a1ecd2ccf630615564ab30481..67e5dd0f140aa73ac73ea99fbe081a6b08e520ec 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -89,6 +89,14 @@ static struct awcc_quirks generic_quirks = {
 static struct awcc_quirks empty_quirks;
 
 static const struct dmi_system_id awcc_dmi_table[] __initconst = {
+	{
+		.ident = "Alienware Area-51m",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware Area-51m R2",
 		.matches = {
@@ -97,6 +105,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware m15 R5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R5"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware m15 R7",
 		.matches = {

---
base-commit: 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a
change-id: 20250509-m15_r5-7ade3650ca48
-- 
 ~ Kurt


