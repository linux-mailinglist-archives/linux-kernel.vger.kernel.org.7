Return-Path: <linux-kernel+bounces-853247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA20BDB029
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBAA33560C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A62D24AD;
	Tue, 14 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHHOw4dX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A142C11E9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469123; cv=none; b=nbmwGlOOv17Iu+VjUwvvh1duTV6kBqxqAWNoTgb2YdfG7xVo28llsTyslzlZh96i80eNuhiYa+TJ6FbOBzjfooTDJBAC7IT3tV/Pe/hyeCkEMdTb6PFxaBuCHcET4MylwNCfdtQZi1HjfWv1c1JpeyVPKVGrMAWs2h2SdKgWimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469123; c=relaxed/simple;
	bh=Z9yUVxIkowXTHwcyq+ZT+xotxWpz/KTmbCCNOsZzoq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsSPGGR+JTJ7x6bB2XkoyJOwZoNF/CrOzRdNSq4fKND0BhOG3wzcGzfrogGYuA8Vr/j/nvPBnkVpVrm84Xu05GBC51lDqaLBU+2jd6jp+QDMRh4SGWf3PRmalLp/mxpwzAJjQCwd/uy03jOsGk+c8BPVqWafNq2AxFBmm+BrJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHHOw4dX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2711a55da20so63966555ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760469121; x=1761073921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3lFnKz/buX8A7hzo0yPwqvqVkIBT1MLx/6+Tb3hA3A=;
        b=OHHOw4dX3y6uIfwGWStBFcCoDsNeZCHthcRK51dxVoDE7MoRqHZtgU2u6xXHNhti2K
         mpXgGNGcCsW8R5wPCygj/Iwsp5wMxBMYHfWO3GdpoDei75xUoUM9xvmjZQ86nJc9xnza
         lb293MfccEzrDimy41h1n0Ee6CSsyWtgBzVKxXQh2Z/o9BMtZa+V/K6h51DxeEOY2k2j
         +GJ8mgBIQi07+s70luqbGb8BoA8YfV4xBep5quJhz3v1I/8SXwBPqOpWS723WEkmbDgv
         ky6L1TSB8xQlhvYeCpZRuw5CiU55Jnn7WunocWsvM1JrcP3p0AHTdrjfXWm1vUh8Uca/
         iTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469121; x=1761073921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3lFnKz/buX8A7hzo0yPwqvqVkIBT1MLx/6+Tb3hA3A=;
        b=uJvyPJW7d4NB6QaauL9n1HBhIns3oNQ09HRpoBRoA0nivaPoAHza7stWLw3/xxzz0p
         DQtHlDUR1lGYttyK7ckkm2/2BnR/RzBe0e4kYRLxLpoUZZaxOH8eNuFn+VTz2BKVZo0L
         NYgdQOkqAMZdmBiHrfBieaFKrNyQ5q0UHhOhfHa5lmXYrLdSD+9NtcXPgY1ZyD/+0fBy
         0CfypxspAq8SamFgIJXzlt+uKhtwXebn8vEfWvR9cRFb0ZVGMlilOR2WFVpk7EcPycRK
         a+gxCqB1PhGlPrHfeyVj6lmfVPL+Wfu2wyHdiFGZGCl9Bdif4rtClss4aWqVbx21bqgp
         tYvg==
X-Forwarded-Encrypted: i=1; AJvYcCUa8ppfAIPbg4CHajpL+Dz+I+f4W3EVaDGtNrlN6aLWff62NTrpH+wMSR0jxJ2+HU+SkNqgEmYuYRJQkd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HhGwujGMRpHT1zaQ9Cq9bjwbN/tmv8rDdqUU9ax2DYZHSJjY
	OQC49zFChsW7abfZm8X5flHAC17iWqoIXkx2kfVcuTcE//I16rbxzn7TwKiyfQQ/NWF9dw==
X-Google-Smtp-Source: AGHT+IGhtudmZk2HkKUXkkd19MrqCMSvGqxz7BKn42nJ882EUoEPCOxNGbxtd22yRlb577G1ZSIkw08=
X-Received: from plrf4.prod.google.com ([2002:a17:902:ab84:b0:267:e559:12b])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef10:b0:27e:eabd:4b41
 with SMTP id d9443c01a7336-29027216505mr361986115ad.7.1760469121238; Tue, 14
 Oct 2025 12:12:01 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:11:53 +0000
In-Reply-To: <20251014191156.3836703-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014191156.3836703-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014191156.3836703-2-xur@google.com>
Subject: [PATCH v2 1/4] kbuild: Fix Propeller flags
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

Fix the code to enable/disable Propeller build flags to be
consistent with the documentation.

Change-Id: I992c6dbb4f25c80e7d983a17f4a798bb000d53df
Signed-off-by: Rong Xu <xur@google.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba5df66f..53c02fc3b348a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -121,7 +121,7 @@ endif
 #
 ifdef CONFIG_PROPELLER_CLANG
 _c_flags += $(if $(patsubst n%,, \
-	$(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(PROPELLER_PROFILE))$(is-kernel-object), \
+	$(PROPELLER_PROFILE_$(target-stem).o)$(PROPELLER_PROFILE)$(is-kernel-object)), \
 	$(CFLAGS_PROPELLER_CLANG))
 endif
 
-- 
2.51.0.788.g6d19910ace-goog


