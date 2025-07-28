Return-Path: <linux-kernel+bounces-748487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47CFB141BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143C04E1BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD721FF4A;
	Mon, 28 Jul 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcLm/sVS"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FD145346
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726178; cv=none; b=AbuOCgpAl20A/WFyw2OPUiWhXsbdN0sPJf5s+dKBOowF4ZvNS1fbMe3yG4auNz2fxTi5sA4MQG+5ngGpremxRuAmoJ7ORoipgcGv1AANiRXdWxoZxZ7ioEZ15acfFlLfyi8TjzB41Xi1qBiBoG1XUCTqVhqaURWzF+Jij5gLKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726178; c=relaxed/simple;
	bh=+FlY3E0ZjRA607mo18/5+bEouVj75CIuQzKLKbjAlSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOd7X8h/cf+TU/b3ZggKkyFCg0XRR4e3w17b/Ds0OAF2WThPWwUpWKKRC4uvdWXEMifC4XeaT491gOkwouCKY6L57jlO2s4w9OXSKMVFrI8fvBipNm73wUdKXd4DQYRSiVp8tF8jm7yCftvAQIdaAD0uqCArp8ssKLPYRbrb/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcLm/sVS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31e3d29b0ffso4348475a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753726175; x=1754330975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFyuFpUhZphoYk4DGQ6VvTOXkhHNbgDR8X4Cux/T2KE=;
        b=IcLm/sVSSpEiu8feh83CL+SZu26xXbRmZQ/f+34F7xvjJ4RMB/yrykqkZqhoV18gVN
         MHqW6h/QFfIHksyNdhpj+Zex5VGyp9v7q6urZNiu341MsYfntEFpNqxE3/KyBqzjNM6x
         BWc1dzB/GWKenW8Dj0oVq8StM0VZApRtfNDSds6Qkd1JhcXpQfN83spZ9halHzw+icMI
         +CS+rZ/1LYlr/FzAgG8wjzi4+PHk72szLmyfgtIaaGdKE61/s839xfu4vkQpvA25B49r
         4sjEjQ9gJDblmo4XbJrxSRxs8AZKnv9nCnu8Lk6IeBlYxim+YvRPPOfFeiIfWoe5eIR9
         9RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726175; x=1754330975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFyuFpUhZphoYk4DGQ6VvTOXkhHNbgDR8X4Cux/T2KE=;
        b=u4xFPcnXoT2VKYgUUfSFuyVrw/aZx2b3YnqsGvbT+AtxOj8ERqHtXPT9dEVIqF0iqK
         MnTC+Nh/tbXQVyo+vI9nkbWfiHZ7Im29JwS7/O8BaGJpFeYmfTby5KHGLZnOu/eu0EKO
         X/TC2l38n6hZM4nFIwuUUKIFJd/C1CMMFOQJUTroAvKNrCcvGKzUBD94/Ya1hoJ6Rwyk
         M/ArMaj9AmtQ/6StIcSYfFKC4rzT0yce9R8NKbeyVMk4Cpb5o34Xz360AyNEt3317eLA
         fF15Lbn6c4N0JoroOa2mpD/2agDHwty4cWXvldpw3qomgGRH71IdtHfMErFbKIZL96vp
         ZYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXsqn2n5CBugCC1UHz5Oq7RWOKMhaJyLTjf6swfQ9wwEFyevdgN4CbNWezJ6Df5jZ+9QMlzMuc2znqV3aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0HU1OL+jQMpqbtjAPuQMODKlpI5n87oDHNL+Y8Kb1rolgBV6
	kB3GSOxtoDctyfc97yRyouTph//PX5s0D3SwVJkRiq/Shs2Wx+WCYhTb
X-Gm-Gg: ASbGncvXktWJ9+P4euW07jqJm0E/4bKWa3tGh7/HWEUnkJAMWpsc1i4D+44Kz81ZdCL
	q02jivbkbA3XIyPT/t2W20YHNcglqP56L6s4QZVqtUhhy2fygAOUZQA25Kj6cPpR4NRN4+GqSKX
	a3lN2OAZ01mx7tz5xKd8sgUJxhkH2MIxm+zIPV+OrA3USh4ah/SB9IAwYT0TCzROyuZ4s74ZfyM
	6jM04mFkdUzPTWGk0nGeYT/sRlQDQ5g/S74SF22miVJDf/9lr2XM6C8O/Dv9+pa4nJeVAcF1gN+
	kB3PCMbgDTSgOBRG8xYL/NXNdLkHaxFfJUl9T6m0MKpTS9Fp8Y2ooFMWUuhoas0+dP4CsM5mAao
	Yzyc+t/qcFBXs7H/+TIFpA3u6S1exZWLqhOmY995b
X-Google-Smtp-Source: AGHT+IGU7DOXRU8+ySmDoc7SCFB9gwHZdwrk+S0WvxATJHUO1RxUFbJHDn6CEY6bIFAzN6xoZL+r7Q==
X-Received: by 2002:a17:90b:5623:b0:311:c1ec:7d12 with SMTP id 98e67ed59e1d1-31e77afe58fmr17207421a91.23.1753726174719;
        Mon, 28 Jul 2025 11:09:34 -0700 (PDT)
Received: from archlinux ([205.254.163.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ef172abe3sm2821498a91.39.2025.07.28.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:09:34 -0700 (PDT)
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
Subject: [PATCH] x86/intel: Fix always false range check in x86_vfm model matching
Date: Mon, 28 Jul 2025 23:39:23 +0530
Message-ID: <20250728180923.160966-1-suchitkarunakaran@gmail.com>
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
upper bound (WILLAMETTE). This triggers: -Werror=logical-op: 
logical ‘and’ of mutually exclusive tests is always false
The fix corrects the constant ordering to ensure the range is valid:
    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_PRESCOTT)

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..3ec1555cbdc3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	} else if ((c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_PRESCOTT) ||
 		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
-- 
2.50.1


