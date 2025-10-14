Return-Path: <linux-kernel+bounces-851652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F072BD6FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B651034EB86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500F24BBE4;
	Tue, 14 Oct 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cTnEiGRL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C01D8E1A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405366; cv=none; b=pKHg8CjKatdVtD1djuba9FTZQF76YycfOT2I0Cp88SuwB2Y6N6OU2xyZOunHoq8Vho7/QmmoEJXR4RhZUAWTpgS4G6VyVwSoUTJGmCscPk8019axsf0IM1cMdkpjYDxWkmIur6M+3V7JeosUJuFf1NKvRFN9dZ0Tcu7xlyzMxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405366; c=relaxed/simple;
	bh=nJSdfogjb2rHqBr+pH3YduWxFZZZpB8B7pUM1yZOq38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTcIVp8fmiCF6T9QeVcGx7PrMbQmd9YEZ4eAWdl5q1LG6LFVrNmOzNjiBLqkpBEqGMlNW61GeFPe+XHD9Crl8az+cC3DFm2LeWT64KQKFMzeioaFJ8SEk3DxD3iO5aMHpCDvjEsT6ubbQnWDV1Xr4rNq4k6/vDZK7RB/hw3XYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cTnEiGRL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4572209b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1760405364; x=1761010164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLeUYNYOgquFvJomJppcfRGs+Aprs7J6ta2ymwmxjM4=;
        b=cTnEiGRLRNBysVTPZlMKmvAmT7uqtkpqj8kYNu2XS59jXrUMIXXiNg8OJvJ1lTtiV2
         eGHyD6vJR9vb8ehUHIcrmfw4YjMDbHAlX8mcPFeW4zqyiqguLwy5ZF4bjj2J1LAcDL/u
         DqzuQuEOq/iaRsqSsIplDoialSLfuEl/FZPCcVnP6pq3iJP+pfXYWwus90juDH6dfYwu
         2FJ9fV2UUePvqHXCcJr7umEWih2AYdSrSaOcTCZ0/s50Foh5x1Vn78FXCIEFvDW0MpmD
         ZrH+BvHdwmUIfQmxoRXWUrmS3yymROM9/GrALSUg1LS6hFwte4YZNouhaNFUd7BZGEQs
         GxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405364; x=1761010164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLeUYNYOgquFvJomJppcfRGs+Aprs7J6ta2ymwmxjM4=;
        b=Ah6CV2kfBM7eWir4KK2/8J8yPlkXB23tnmO0q5wZFb8vyORWkYNcKkRDIUlVhM8p65
         t+WNteOZHp+c1d0EWYJQZXDHKdi02qdExHOCq4Vl3K0Eh4OlOANODVyxPzzeU4fNmxvl
         Meph/Cgh/i6+V5fNc3c5xfep31Lw9MQyswXEaBVU+3e+2clzi+jqMJOGWpNgIftbZaxc
         OiuDOXS5FNP+gA3bFWeO5sXMbFelg2IZfOd5j6U4EH3NrSHUAAEvFWDCsnzATC5epGxN
         UaRtW+Avzrx9yddcWnqOugStHC2g2P0U+nJekBPocu1g+koBdzQ7qgXczadDO3UztbmN
         ulaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUewLtbaSNtsjpcMIcNR3aInqqOzm2UnvS9yI0XeMpPHtxk2eGC+CPBUpEZsaRfKM/IZ/WmlPhoE5Vle2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUt8Ss5MPUEU1QnX8Xvv3w54LTi91s1hP2CinnHNuqmrDczdjB
	aoA72VtQ8398H0OWeY3xFTzGafnAEvdhEmf03y+wmxlDFypYRmQcKfrqZV0QTQF4eQ==
X-Gm-Gg: ASbGncv+ssr7d7Kv9TMK5fCwIPAc88ktMW0THIZkSzF8YWWUZ5/2+hS3qE/QYBmBJmx
	Ah1w++J8asveAaNvK/qqcPyu5IRnN21bpLhXaB9o2p/93rb9VUhDwptW+2nvJcdDvO+sRVbIadp
	e14JDQFqWUGymr2jcc3Ru6qf+jCtsiC65voCmKuQsHRPc8InDYNMAyGT0KcpnOLdZNE3nooUIIj
	0Ot+0cLHPR9AXYR+oCnnzm3ECgGettD/Va8Uf0I6EgG7ru6s7XGQ7u+le2amQNLOvfISNDvqpJh
	X8frQZK1G23cZbjNzl6grAme+9Y4nJ4svTvFoQqDhEusgsM8AZJJzqTwTHw3VQYvsyfMlbqPeTw
	xL4ysSwZfZLCoQNCxtXWgk7Pd/P8LzQobrfwn8wFXNi8mdPGzuCqBgTZiVR4UFxa9fGheWMJAKr
	3hL2Rek0OH4q0=
X-Google-Smtp-Source: AGHT+IGk3J2HkKWyfEwFDjAZ/ejfgBPHcqeFPWkyssCDB1sgOqD77VvkIQDyFDL/7TBHgpncTjhkgg==
X-Received: by 2002:a05:6a00:1404:b0:781:1f58:ce6e with SMTP id d2e1a72fcca58-7939753d114mr26630520b3a.4.1760405363769;
        Mon, 13 Oct 2025 18:29:23 -0700 (PDT)
Received: from sushrut-work-nzvdj.sjc.aristanetworks.com ([74.123.28.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09651csm13103178b3a.48.2025.10.13.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:29:23 -0700 (PDT)
From: sushrut <sushrut@arista.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Sushrut Shirole <sushrut@arista.com>
Subject: [PATCH] x86/reboot: Add support for restart handlers
Date: Tue, 14 Oct 2025 01:29:19 +0000
Message-ID: <20251014012919.504258-1-sushrut@arista.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sushrut Shirole <sushrut@arista.com>

Other architectures (ARM, PowerPC, MIPS, RISC-V) support restart
handlers via register_restart_handler(), allowing drivers to
perform direct hardware resets. x86 lacks this mechanism, creating
an architectural inconsistency.

This is particularly problematic for high-availability x86 systems
in the networking and embedded appliance space. These systems rely
on hardware watchdogs as the final defense against catastrophic
software hangs. When recovering from a true kernel lockup, the
complex, multi-step machine_restart() path (ACPI, UEFI, keyboard
controller) cannot be relied upon to execute, rendering watchdog
recovery non-deterministic.

Add a call to do_kernel_restart() at the beginning of
native_machine_restart(). This executes registered restart handlers
to perform a direct hardware reset.

If a handler succeeds, the system restarts immediately. If no
handlers are registered, or if all handlers fail, the function
returns and the standard x86 reboot sequence proceeds.

This provides a deterministic recovery path for systems with the
necessary watchdog hardware while having negligible impact on
general-purpose systems.

Rename the parameter from '__unused' to 'cmd' to pass the restart
command string to handlers, enabling command-specific behavior
(e.g., "recovery", "bootloader").

Tested on x86_64 with a custom watchdog driver that registers a
restart handler for direct hardware reset. Verified that handlers
execute before machine_shutdown(), the normal reboot path remains
unchanged when no handlers are registered, and the restart command
is properly passed to handlers.

Signed-off-by: Sushrut Shirole <sushrut@arista.com>
---
 arch/x86/kernel/reboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 964f6b0a3d68..0d26ccd9274a 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -772,10 +772,11 @@ static void __machine_emergency_restart(int emergency)
 	machine_ops.emergency_restart();
 }
 
-static void native_machine_restart(char *__unused)
+static void native_machine_restart(char *cmd)
 {
 	pr_notice("machine restart\n");
 
+	do_kernel_restart(cmd);
 	if (!reboot_force)
 		machine_shutdown();
 	__machine_emergency_restart(0);
-- 
2.51.0


