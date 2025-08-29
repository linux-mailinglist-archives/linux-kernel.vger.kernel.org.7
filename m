Return-Path: <linux-kernel+bounces-791434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC5B3B6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA8A4E1A22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F12F617B;
	Fri, 29 Aug 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cFedn/CB"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DD2ECE82
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458465; cv=none; b=CBEGoXuXc4WVFPZX0cwqyj5oUT81g9TMJovQ9Yah4cAcgEEjEMCDkndzQYjFjDE/WUk9Bubwx1E+Vbv/plb5mRIpUCl5uDkXA57IDFiAlQQOu2p0sN6Pj14CYRi/o4WnS2D612i0vWmbLa2ij6SB7Bxnle7mwKWx59YU8EIH2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458465; c=relaxed/simple;
	bh=G6NzGTVrpDs81stJ5QT4A0bK6csq8bzzEKutOI64VXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNOhcgtzAdlhMWNlSm65H66srrZhJ4KmLpL3YfLOhc/2QCryR+lgc3bkJpAN9Mi3/zZOvdIbWFNpCMiZdq/NCMrYlW4e0uinGK7bC3kgIsxgJIXpL+PZbYQuy7wBOEejf5bPCbs/GTwKMN2yIwBcYue5WvIqCHy3Y9PnNCH95Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cFedn/CB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso1376651f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756458461; x=1757063261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHsFOCN9HBPfTp+3qJi0ndRfEXrSipRtZtKnzK1hfrY=;
        b=cFedn/CBrUxjNrHu9pJqqy3KUVa8hdg2wN60fkYXbhDRiW7Tzn6ct/VVYq73BTv+fj
         PrRY0nygxuzXqhqdZZRgv2T+aixQzr6Ouy/omJSsasejaAnWRK+iTOetVTSeZzzZn85l
         KlDk8HeB7to6ehM6KXa/d22sbPxPbVufblyHHTP8YHh28GrRAOaWoBLww1bALWLcIvJh
         Zmb62iS3M5zDpzvyNn1b7M+CI8HDihn2yGbH9rxBorEHLyemD3vsspcCsmUWgDbq1tDP
         T/u8I1ZYV6rVu2OwpuoWPDmQbhVTGYy4hXsrhZtKLhJ8QOaKfEt8NRSV330YltPQ2eNe
         BsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756458461; x=1757063261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHsFOCN9HBPfTp+3qJi0ndRfEXrSipRtZtKnzK1hfrY=;
        b=YKcEzqRzjiXpPiBojlaUMOQX+Cy1vzi/t5kA0ZDiNlA6q/J/kjVHw/gBSYoWkgOW+g
         AVNpn7/WRCQEh/aKuvi11a9m1fqg4Hty8lKmgQRg6fN7G4VwwXjSDfbekG3UasrBqs7J
         AXpQmH4LatVoAVi73vDZEUtB8HWFLezcENWteC38uL4meFOGXF1ZLf66PNp5Z8ymecVZ
         9NBUffX6AazatdMa4ZLijCuCXZLtdviTOCrZSpH95b1xQf07wN14oS/ZP9WeWmyFho0U
         XwwLjSVLfEUyLSbp5z3Jp7/ItKcVrRvWl9IPWZeJrwq/jAeuEYnSmyV7y3okCT3UsCNw
         WCnA==
X-Forwarded-Encrypted: i=1; AJvYcCXy2Mnc40euIR5rhjqvznJDo9sEcPTuBDlTFCWmtBV5mV+ojhfImSmop6D0rKGHrU2LV5PT4oOxQVBSgTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGN73qI7tGHjWfHLU5OsXDS2tBvdGb0MkyYrrkW9NPafJwlFv
	+2+DjTqpD+aw8yk9EluUDelOA/73ad0+WBap4W5kKrjlYgC/FaDcuXxEI/NSinVh/eA=
X-Gm-Gg: ASbGnctbwkyEGWoNHvzVpHdlOqvEAtgMJMZ8Mp7KPoRsEYr8p8Ml7pzpEgHGC0Xk9yx
	+gEv+u483+MBebEns5j/f6wWGi+mjs9UqbkMq0ZpQhimRxX5Xd1pKwq26a0/tPnkdRQUc/mEDeF
	j/cun2Bu1pQRuoGwROLAIzcxB4gxM8QMMZWs9Y1rXikW9zwvCtDRY2+U00oLzUUWoWvjIhYrnUN
	+IYKgPR1i8k848zG1VbnvZ8PZxK2jgulKV8vZfnt0yfVXMwXNg4mcrwr6Y7qCXjh5b1PdXJW6RH
	5NgmOtZCiIYzbF+Thxmu+9SMHl4FCX3sPSWQ2i4tFbAOAGWejYa+n3zRUbG9bfiUZCzEBeukigr
	y1HuWqfzi86cbuq4Hs2hirmNZJ9XTcKomO1Sg14lGBJfTSGsRmQ==
X-Google-Smtp-Source: AGHT+IEQlpOdkOq6rxIeeWmNaS5Lz3aiqP1fn1/KRHgTvSLr3fliJD6VsAF/Pvip5DahmMfXaaxe8Q==
X-Received: by 2002:a05:6000:401e:b0:3ce:2116:bf8c with SMTP id ffacd0b85a97d-3ce2116c444mr3732921f8f.51.1756458461226;
        Fri, 29 Aug 2025 02:07:41 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d8ebdsm2560942f8f.28.2025.08.29.02.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:07:40 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ARM: module: Ensure the override of module_arch_freeing_init()
Date: Fri, 29 Aug 2025 11:06:44 +0200
Message-ID: <20250829090726.834456-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function module_arch_freeing_init() defined in arch/arm/kernel/module.c
is supposed to override a weak function of the same name defined in
kernel/module/main.c. However, the ARM override is also marked as weak,
which means that selecting the correct function unnecessarily depends on
the order in which object files with both functions are passed to the
linker. Although it happens to be correct at the moment, the proper pattern
is to make the ARM override a strong definition.

Fixes: cdcb07e45a91 ("ARM: 8975/1: module: fix handling of unwind init sections")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/arm/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index da488d92e7a0..55ca3fcd37e8 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -484,7 +484,7 @@ module_arch_cleanup(struct module *mod)
 #endif
 }
 
-void __weak module_arch_freeing_init(struct module *mod)
+void module_arch_freeing_init(struct module *mod)
 {
 #ifdef CONFIG_ARM_UNWIND
 	struct unwind_table *init = mod->arch.init_table;

base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
-- 
2.51.0


