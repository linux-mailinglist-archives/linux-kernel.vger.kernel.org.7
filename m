Return-Path: <linux-kernel+bounces-848792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D49BCE93A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A368E4E963E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7330274E;
	Fri, 10 Oct 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUhhkYu2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F730217A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130108; cv=none; b=dimw+OAn9EuChY9nTEg//Q2s7k3P7pJIMi2JEhDWyQBHAm2vmWOlM3HCC76V1vIaprlHCLo4TVn2VU0+tvZTwsAmPRcJrfuoWjz5XnPlbOCHGyb9LO5gw7HoqZGVb9v75PHOhHLbaHunHzclqTao77VM9PNSF3QUORjgRDntNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130108; c=relaxed/simple;
	bh=1tNnIlZv+wCE3kcdtXTHXlfMZ0yGaIOe9oMVqOUMQOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ypy6GVOUZ5rq1E8G6c3Z7feQWFvBsZSU5CQti12Ti+476rWG9YlWdfHx4xNI7l6aax6zyzSMtflzyhQizooRnPCNzpAR3FMI+FvreAGPZcrRBDBNWheuK4PR7/pvqUsdk7gcKE9O0oRW7gqwWC9rDtWRWfGgUTYV/TD2uK0R9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUhhkYu2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78117fbda6eso4331208b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760130106; x=1760734906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXUz0ruU1YA2Qg4rcZrXatiuVPj0CSzoMucbvJcULP4=;
        b=oUhhkYu2mNxYWUzWWEZWYy1sWdic+tifDAj/+JqpuVKx/QrGYospqJ1S+trj7wTylQ
         uoBHiqmGFbfWut0C9PrgjYr/mFSE1byHZeR1LFqjwaIjaq4q9bWQiV+EiGKOZnHrh6fb
         u4dxB1WguBtzuqouhhdI/SJOwPv/Aj5lEMlwt27IFeQb8j37oJ1VQRj8mbUTow066V1U
         I1O27QXVC/3B1+EA7VRGDshLSTsg6wWJqKqQPAba7yFgfctg3idV14zK9NKJ8Tm61dzW
         SVTit7JTBxUXKYF9g1QLaQUZXpDFitbYHfJbdT/7kh1Aa0Z6PhIE2l902Ot7TsTr5C4B
         54lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760130106; x=1760734906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXUz0ruU1YA2Qg4rcZrXatiuVPj0CSzoMucbvJcULP4=;
        b=lzVsjhHWAZEaNB1eln+1NvReFYRVwP0Rsu6pmyo+3pnLEu44Hj0rozU6L9519x61rw
         ljO1kbzufmzcjXWdc0NN/btvDRLLC7HsScQYE71iAQo3pLVfE0/neFC/zP+S1rxFtbOQ
         WpgXRRIY5Vl/1feEjOggSD0RbujE8zvqHqtPxaPawm0PhV2m7qm/YrRQu3Ie1MKC+FDi
         csIySgBsDcZKMly6rulhPTodfZneKRuNh/FJnnbmSzsqtw1fKaZc/f/mkfl8O1/jocfR
         iuSL+TxwJBgkCS5tp2/xfqvQ8k1X/qtj55Yyf0mxVdnmgX/a93Yh4v/tUkCZ6EpboYL0
         nw+w==
X-Forwarded-Encrypted: i=1; AJvYcCVzLBu1s80kymX+UXHoqktTOS+qtNoSDi8umR0q9sbQm0OBGptkIhUued9oKhaxi0WOqE2u0pAiQhJ5cdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXt5jicWQPCpw19iA6OW+wQnnRxhOoA+ePtHVzF2QSWAI2d6ZU
	NbmUxbupbPjhhNekpk+Y/vPF394io//6jkSDomUeGo3P9KWN4IqvWPOX6umJtJaJkYlNAg==
X-Google-Smtp-Source: AGHT+IEL18I3C/IsW+RSJN6mqkTxkt6ylMjhVG9XKQ6e/h83iNo20YGDVvCHYqnvKVi3lRioj4PMQpE=
X-Received: from plat12.prod.google.com ([2002:a17:902:e1cc:b0:267:fa7d:b637])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3148:b0:327:e59d:2cc2
 with SMTP id 98e67ed59e1d1-33b51148bcbmr17641763a91.10.1760130105796; Fri, 10
 Oct 2025 14:01:45 -0700 (PDT)
Date: Fri, 10 Oct 2025 21:01:33 +0000
In-Reply-To: <20251010210134.2066321-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010210134.2066321-1-xur@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010210134.2066321-3-xur@google.com>
Subject: [PATCH 3/4] kbuild: Remove MFS flags from Propeller profile generate builds
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

Propeller profile generation requires Machine Function Splitter (MFS)
to be disabled.

Signed-off-by: Rong Xu <xur@google.com>
---
 scripts/Makefile.propeller | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
index fa018098506b8..8c3e514dbcc04 100644
--- a/scripts/Makefile.propeller
+++ b/scripts/Makefile.propeller
@@ -13,8 +13,14 @@ else
   else
     CFLAGS_PROPELLER_CLANG := -fbasic-block-sections=labels
   endif
+  # Disable Machine Function Splitter for Propeller.
+  # Propeller profile generation requires Machine Function Splitter to be disabled.
+  # We use -fno-split-machine-functions to override any prior AutoFDO/PGO flags
+  #(in Makefile.lib), assuming Propeller options are applied afterward.
+  CFLAGS_PROPELLER_CLANG += -fno-split-machine-functions
 endif
 
+
 # Propeller requires debug information to embed module names in the profiles.
 # If CONFIG_DEBUG_INFO is not enabled, set -gmlt option. Skip this for AutoFDO,
 # as the option should already be set.
@@ -33,6 +39,8 @@ ifdef CONFIG_LTO_CLANG_THIN
     else
        _ldflags_propeller += --lto-basic-block-sections=labels
     endif
+    # Again, we need to disable Machine Function Splitter.
+    LDFLAGS_vmlinux := $(filter-out -plugin-opt=-split-machine-functions, $(LDFLAGS_vmlinux))
   endif
 endif
 
-- 
2.51.0.740.g6adb054d12-goog


