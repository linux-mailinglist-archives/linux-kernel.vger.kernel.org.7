Return-Path: <linux-kernel+bounces-853246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A8BDB020
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BFF19A078F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD32C15A8;
	Tue, 14 Oct 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zv5Y4XiB"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09C2BE652
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469121; cv=none; b=UE20kuZFP3U5fwBQ46oelu7fnTofA3vZ67HuZAb8OrmeHQrnICUgFEE40JcByZH8CEI4nysl2HkZQkHRFjx+0AZ3C7opsvA2TYqQdSx2Pl3PRgUclNV6TjncHkSdJikZ4/DhShuNK/GfsV3TDrw1A+VpfWLd5SMZlnUn99Zaxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469121; c=relaxed/simple;
	bh=UQnXFdfx5dWAH9sx3W0jjTCJ0moJLOzBU+mWcv09QMo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V062geknahA6jNxDvGvIKeYq43uwTteaON9Q0d0ZwMHAvCRos5b8g6kMiNfZR2ZV9QiEmZK9neeny/QkmBHayJg+e3lit9FtOakdlKqHrXv49TERt+VIsK2sjdO2pmktzIFGLQxyxNBVaO8x1Vo2IofI96oa2oX2JiKQ6oUO04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zv5Y4XiB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso8356648b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760469119; x=1761073919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HetZVCC/q2AyiLAEyoUW1UONBOG5swbtHLMRVYpsp5s=;
        b=Zv5Y4XiBQb77RQlcfD8Id+dp6GbdF1d04YfymkHCQGCt3q3ZyqL7z6aPWEK7NCwiRt
         dq0F8F0fXQz5oT/4inhNCLgSdEG5Z24NevaAQsslTZs2rte4cgChmMxtROsJLRkOh5r7
         PuJiv4/A4MAN4CChCmvsNORwv6gMye+CwXy4jAH4nnM/vZmabANupfWXk1uLZgYYburS
         vY5NYo7NMZt8/s6Nn521ZQYpa1RPrS4cFjftrM+LNiZVMpuZXzmkz/LXG4oV71LK0htY
         +aVb88LfC9UYJyFbuHji8PPoDMTUk8W10ovVZZv8K3etKpwFbV8HiScrcBskS5+n0uZn
         QTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469119; x=1761073919;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HetZVCC/q2AyiLAEyoUW1UONBOG5swbtHLMRVYpsp5s=;
        b=WRS759lU01xg5BM/rqhlupymhHvbSe3nsBHFg61vqFC2NxLlnAIEvjeJn5NJYVXleh
         BGIBXOqa/Af29CLjZjhWs/9iJ55IiOTjHBeKymwxEkwOYKWclxvOU57X5yPSB16COjft
         uZzGSsdOQ4wdkXHKWU4qMVM6l+5n0xKQkUU1rlH+2PWS0QElXCyuLgJdAo2dc6SfcloX
         R6y6fwkHgqz3odJT0hhjhKjJFqQSQU6SgHk0Sq1NYNgSm+FMUoZ+YloQR/17AJogRIZV
         JY4Ksaou8XqxzIdJ2N5Fd5VWtPFpMxgOnbriCxLzSyKOt6zOoxMvjbplKAEdmOaGDPlZ
         jVRw==
X-Forwarded-Encrypted: i=1; AJvYcCUh7NL20NQbETDeWrJaf1TfqJGiryDbdRRfAUkYUi/tqAbBn3vWYKDElZInwgkr7PZtfv2IiGUaH199GAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAe5RG9hYWO67YY/+Jaq9QBbbfL/Nolup4k8TK66aspVOqgjY
	7NpmfkMVKMs2QDBLiNlsrclFXaj8IVYxto1UOt1Alg2JOJVdVvATpTVj52tJplJSScgJzQ==
X-Google-Smtp-Source: AGHT+IGqxn8ztfvetOUDjhKisKtCGCDVJ4GZc/Y5aNTZgsAPMD/o+pkKchgR04YWi9BC/7CxTDwJF9c=
X-Received: from pga19.prod.google.com ([2002:a05:6a02:4f93:b0:b55:1aa:d75c])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218d:b0:32a:ce3e:fb9b
 with SMTP id adf61e73a8af0-32da84649eemr35608986637.59.1760469119535; Tue, 14
 Oct 2025 12:11:59 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:11:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014191156.3836703-1-xur@google.com>
Subject: [PATCH v2 0/4] kbuild: Fixes for AutoFDO and Propeller builds
From: xur@google.com
To: Alexey Gladkov <legion@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Bill Wendling <morbo@google.com>, Han Shen <shenhan@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Yabin Cui <yabinc@google.com>, 
	Sriraman Tallam <tmsriram@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Rong Xu <xur@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Rong Xu <xur@google.com>

ChangeLog:
  V2: filter-out -pie in scripts/Makefile.vmlinux_o
      This fixed the failure reported by kernel test robot.
      https://lore.kernel.org/r/202510120709.Wx3q4Ppg-lkp@intel.com/

Rong Xu (4):
  kbuild: Fix Propeller flags
  kbuild: Disable AutoFDO and Propeller flags for kernel modules
  kbuild: Remove MFS flags from Propeller profile generate builds
  kbuild: Add config to assert profile accuracy for aggressive
    optimization

 Makefile                   |  9 +++++----
 arch/Kconfig               | 11 +++++++++++
 scripts/Makefile.autofdo   | 12 +++++++++---
 scripts/Makefile.lib       |  9 ++++++---
 scripts/Makefile.propeller | 20 ++++++++++++++++----
 scripts/Makefile.vmlinux_o |  3 ++-
 6 files changed, 49 insertions(+), 15 deletions(-)


base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
-- 
2.51.0.788.g6d19910ace-goog


