Return-Path: <linux-kernel+bounces-748887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D5B1473E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DD53A7248
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43122B8A6;
	Tue, 29 Jul 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+RVg8XH"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC82E3708
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763192; cv=none; b=RESan2v/MxjLmDXD0K1vqerY9Zqz/WmswTrh9fj8BS1Xg/bSN1ferSoYPatg9Ee8MPIlSytx0MMVPiZNVIw0sBsEBo4yNDbV3/awcZgKlkxY/Kh8pQruhcuxgUypyIcIcZWwiTZ+uwAnrEZqVTYaFsVhy821phg1ryJ2Y8dRq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763192; c=relaxed/simple;
	bh=CvKeu58IXrAdvxQcD8lmzf7MZU2YYjTVYOF+YIPPfv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSgdpQVQpFBNzORVgOxdCcJPDDI6qFuXFRqHQnS+MqSAAKaW2ni894IhydJCNHDnkbGjnhTwI9Qz0tZJ1l/PLPJJ8VUjx0UUxIY30PfLGwPDQ1Pgg39I+FEaGIabaSajQq3rrSDOVGndCn1VB6ELETFff7RWlR546fQnGWQfk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+RVg8XH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-769b19eeb3fso280803b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753763191; x=1754367991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ilKaDFR6OrZjzX6D5Zrq3NqUyxXJfxnBkaqIM4VqV4=;
        b=m+RVg8XHHGK757Bc423bnu4gFOrBg4UiulyOpOZkxvgk7Qzuc4l54beRQQI5kOXR8S
         chjpZnqW5WJ0C6dztPXjFnULO0SiOcJnyLP++Bw1aLpAFJweM07SABy6m15qMsi2kEq7
         EKOozCNo+XPF3WGFAUQU7HUnCDPfOabFHHZblfGul+8cAzm2JMvzG9hKLmidyXNJ1HVs
         eQVEWaP88SONLxJDcVOFwSniDRjCW3S8td0DudUFvGgwqPRyoxWRPG9SNo0sVXPenvsC
         mTcVw1ayQQEMbz3TzKUy6Tq3WEGC3bWbHDon0ftP8N8flWJtt+ZvhUMlv7gjbi0ul18U
         qN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753763191; x=1754367991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ilKaDFR6OrZjzX6D5Zrq3NqUyxXJfxnBkaqIM4VqV4=;
        b=Rj3VE78UGIbJ+9MhxSuOt5ENUeFWbJnibg0TcbKxKHpIkE6v/pQhQIl64JZxigIQVX
         WcVPLIj7NVgKMM1wOpFa09pqUGNKxNDzC4Rpyh+nun2sI1zx3tcTYZI5PaeyO1jbTAi7
         kooXVM7CYC0o+V/wjyHz3YRpg1AqbWmO7F4aeJIWmnz9Pn7Jmve1Ce350IhyWw2XdBNS
         tFq6i4Y1k090kMyDY0F0D7rLCXahGiXtf6DGVkqXK3y9Ct5GUnAHDuShLrNj4Og0eC0d
         N+hB2T9URfoMSN0rzOmnEetCV9KXR4+1BMZmj0KM/B2KBAPWh5LJgCkzel5XcxhNRZqK
         EH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN3bmvjWHdmuMa9fQh0IL9uhOYUt11IP/9xbusYuDOqsbJ4fWeTszsONUXYTPQb3GIu2ejrbZ2k44hwTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5+tWoNmBMnnUJf4+pZtrMVz/iHoTm8pc0BEukDPwLfvorCDV
	amoA8OR34iSHftxm0rqG6hxUPowugi19MDKs+9wO8rbjQeHvbKmdLq6P
X-Gm-Gg: ASbGncsUL5daE0xmTN9P7udS097pNtGXTlINKkkRLFHmqIJ8y3bWjbikugObx644mnw
	mOZNzrdV7O78XqHQhH+uAp+ECvv+AVLWooD2XkU8ZwMH9C/e8YhKTilH8kCyJckMYuTgtnxedEB
	wXvC7cSd2gqV3EHULoPBnyHegW6iR3Z3Covmefq0KOofKiTrVe/ZxY3v9pLHTd+BFyn5JLiUV0M
	pXJJO49Y6Q0GZmRqSZYvjShUdjD2ICwI1xqHAnIw09YDrMOYUYUwmhkgJtsV22RslUIXMBGSYcS
	9CCdlTwJZ9NYkC0egpKSMCeM+lafF9loAjcNM00dEtQvwVda5CDpjYGncpaOOXzmVAu92GAICNn
	BHfq+ci/CQIBsvlAIojIeJzXaGlwA5Q==
X-Google-Smtp-Source: AGHT+IG1Wq72gaOcqPtisiStSjKio1cSFV42RF5HqkyXJmQ4IEvYZhzGHHenUOoI0rFgFuBCBhkGDw==
X-Received: by 2002:aa7:8885:0:b0:749:93d:b098 with SMTP id d2e1a72fcca58-76339370d7dmr20500083b3a.22.1753763190556;
        Mon, 28 Jul 2025 21:26:30 -0700 (PDT)
Received: from archlinux ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76419d84234sm6742570b3a.57.2025.07.28.21.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 21:26:30 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	darwi@linutronix.de,
	sohil.mehta@intel.com,
	peterz@infradead.org,
	ravi.bangoria@amd.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v2] x86/intel: Fix always false range check in x86_vfm model matching
Date: Tue, 29 Jul 2025 09:56:21 +0530
Message-ID: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a logic bug in early_init_intel() where a conditional range check:
(c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE)
was always false due to (PRESCOTT) being numerically greater than the
upper bound (WILLAMETTE). This triggers:-Werror=logical-op: 
logical ‘and’ of mutually exclusive tests is always false
The fix corrects the constant ordering to ensure the range is valid:
(c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL)

Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
constant_tsc model checks")

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Changes since v1:
- Fix incorrect logic
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..6f5bd5dbc249 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
 		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
-- 
2.50.1


