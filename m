Return-Path: <linux-kernel+bounces-652002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E7ABA5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE511B68A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F949280CFF;
	Fri, 16 May 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEh3d5px"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79A280A5C
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432764; cv=none; b=iq96pZ/UwIwtD70DBl+EMkCL+7HN3gmwczHV/MFW81NP27ZGot2IGX5hsyTnWwHgWi4Cuak0Ss7ALbsZC4ex8yay8DVw8YmiuiRupUt9PPBsOVavriiA+7fkYWt1T6yy3DNDEEUjz+u1uqWhJ5Tseg8FPhMBTzMEK9/X5mWftQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432764; c=relaxed/simple;
	bh=MikFEr4HqqS+pVF8rj06QgpGwG6o3rHfGWhDct6+D2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b7OXiVtetWQWhmqLyf5aWSjmF3oNax9c6IJvCLeoaP77lL2vZ8IBGDFqOfklVnlJXHNURQ6H+aIVI76lfbjjjPn3/DSFkjIWP5GdzMob/bMdogV5OLISdhbwyRZ03vga+Ud+PlworHB9jPp5L4eVKKsUJ1M3fUA5Dv/Q/f3x7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEh3d5px; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c54b40096so2866436a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747432762; x=1748037562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=od57Uif9JXwzPGg1ZsXd/H6KCCp4Qwcw4ZkcBnz9lJ4=;
        b=nEh3d5pxvlTqxyvgANcPXMJ6+CRud7mB3LLIuGO5gGpDXJjlErOHHojbBV+zZ+s+KW
         F+heuqxNoqhlDX+2bGtoe2swKmefSCJOJUWAIkbJyokyKZaMARdtsdWMCfZInX8/ceSD
         NcsPKyXL2T3PtOPl0NL3UeHREPGNwWoNMPuSpcrnfA8g0hUoqrLQRpNXvulMAjJLVzgN
         NT+GmuxYTy/wvP3RZKi+/qZwGdkNA/cQszgfP8NSt/qAu/3gHWMaiVux/hqt1LXXUuiq
         TNL2UQCzr6Ra9TF7QqYl/4etE/gEyg27C/gw3oCF47NcocIwRLMbDHCvg2OYmRdFWS/l
         c13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747432762; x=1748037562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=od57Uif9JXwzPGg1ZsXd/H6KCCp4Qwcw4ZkcBnz9lJ4=;
        b=WACbiRKJc7o8ZYtKUvPRQRYaZzvaLsaBzBygK5RnAAboN03GpmdlDcfjma8ELcy81C
         trvoo67ULAoMLTTB6N+xcghtWjwjy9JQC5AXC8nIMgixy+GLS+YKm3h+ftkKdW15jqQo
         wImT38REABPYt0a/QUCghxAjdFxDiVoQZ0+RVoc6Itl4w5vvj6C7MhC/Ab74/7PE1R22
         zYv4/PJaLZSYj6BfFxSYVCy/DoFeUHXKugiq0TFVFFhDSoUEEXukkfr8o2GzPjqNY2+k
         2U1+JopRKfdPdTL13+bjVCZuBmfRJJceK+21HhXy35kqSWXTPMbfU1dJ6nCyuSzdlyhQ
         83sw==
X-Forwarded-Encrypted: i=1; AJvYcCWNbIrt5uLszatLgkAwy5qjKroSyGtgCggB/WgGFCH2+CFon3/86LhKfdL6+AiyXl09q53nCp9zpkIErUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuQzF4utGRZqDo24uVQvL0O9JjG0L9Z+SkjZpMf4/a8d6xJs4
	CqWsIC9eAiTlTDSlBoIv3QELyG03hooAlDFnmcaFzqbHuayVRpbIaI/C07C/p9B1dzxxEiFf+Vj
	YEsXwFA==
X-Google-Smtp-Source: AGHT+IG9bNv7a/9QPFZUcyZf2gm8jW+54q4wdOSEKXquqXb4UQPxygJn7Tlt+dka9X1WlTQqm+fkqYZJZdc=
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:308:65f7:9f24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cc:b0:2fe:8282:cb9d
 with SMTP id 98e67ed59e1d1-30e7d5a8ab9mr7357576a91.28.1747432761942; Fri, 16
 May 2025 14:59:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 14:59:07 -0700
In-Reply-To: <20250516215909.2551628-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516215909.2551628-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516215909.2551628-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: selftests: Add __open_path_or_exit() variant to
 provide extra help info
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an inner __open_path_or_exit() API to let the caller provide additional
information on ENOENT to try and help the user figure out why the test is
being skipped, e.g. for files like the page_idle bitmap needed by the
access tracking perf, which is dependent on a Kconfig.

Immediately convert /dev/kvm to the new API, both as an example and because
users might not know that some architectures/setups require loading KVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a1fc52bbdf7a..ee29e5d0c5ad 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -247,6 +247,7 @@ struct vm_guest_mode_params {
 };
 extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
+int __open_path_or_exit(const char *path, int flags, const char *enoent_help);
 int open_path_or_exit(const char *path, int flags);
 int open_kvm_dev_path_or_exit(void);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b21ba80e3015..b133f2b1dbf7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -26,15 +26,26 @@ static uint32_t last_guest_seed;
 
 static int vcpu_mmap_sz(void);
 
-int open_path_or_exit(const char *path, int flags)
+int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
 {
 	int fd;
 
 	fd = open(path, flags);
-	__TEST_REQUIRE(fd >= 0 || errno != ENOENT, "Cannot open %s: %s", path, strerror(errno));
-	TEST_ASSERT(fd >= 0, "Failed to open '%s'", path);
+	if (fd < 0)
+		goto error;
 
 	return fd;
+
+error:
+	if (errno == ENOENT)
+		ksft_exit_skip("- Cannot open '%s': %s.  %s\n",
+			       path, strerror(errno), enoent_help);
+	TEST_FAIL("Failed to open '%s'", path);
+}
+
+int open_path_or_exit(const char *path, int flags)
+{
+	return __open_path_or_exit(path, flags, "");
 }
 
 /*
@@ -48,7 +59,7 @@ int open_path_or_exit(const char *path, int flags)
  */
 static int _open_kvm_dev_path_or_exit(int flags)
 {
-	return open_path_or_exit(KVM_DEV_PATH, flags);
+	return __open_path_or_exit(KVM_DEV_PATH, flags, "Is KVM loaded and enabled?");
 }
 
 int open_kvm_dev_path_or_exit(void)
-- 
2.49.0.1112.g889b7c5bd8-goog


