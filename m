Return-Path: <linux-kernel+bounces-804782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEAAB47CEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318863BE34F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653D21578F;
	Sun,  7 Sep 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkb/pllJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD9157A72
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270963; cv=none; b=fF+xDNv/y2ZU7mzjJhroCbhvaZF+hlNvS3ER5bsseb/Vp9ajFZrcwrdOt0uwJQBhyVv2xW8Rr1Q3+R8BTnhGSV9KlqFf8t8nGBBrobj6Mqi+0oRPLtbbbinftNbXG+MPuvAaKjPnjK0GPeJhbqbkjpUCOlG7LGAUcXKBu8GiFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270963; c=relaxed/simple;
	bh=B+u6XgKMyYyPWYw9hDeq1ebbo0neUq4Kx+1xh/D+aek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbEG/YsBq+8t4zlzAN6Vv+f9raxdWh5EslMDHOsD4k0475dqQsWksAepIeiCvNXK6pCOrsUTl1cJE5dfGH0bh5/+lp0a5YNc6K9s1kxJMcK4c/Ml+OLE3Xr3MSQpYY0IR8tF+CutxkL21nXDc8KJ/ApUjnbQM8UNehvBthSEqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkb/pllJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b02c719a117so660820866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757270960; x=1757875760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NAiKKbWMAZGMkQfKHixLzrdvNKYNue2EU7kkocIu3c=;
        b=lkb/pllJaR1G4BJsnjNeLyzExJHcSPfR9O7dtWUYK/049fMhhveuGS7adP45g3DEkw
         l4aTl3a45vhCpNdrIljFG2M0Rqy909Y9umyZTf4qbFjLTlyqNTOoiQdlHsxHdbkayRLd
         FAovSr6c7snaq1d9/nFFkwItq6SdEnXGNy41yiEBbindmieG9Shj9hGyOvNuwYYpN/Pz
         9grT0KTqF6jsCmPd/HDWM8D74BBcAxENrXpD/v6X1vD7t2Ogdl6e7UG9nju6levg/B8q
         7vw8KaF+NOf4iC5QPo/nVyx3xyIobHVLQwBJVZPG6cHee+GBrpjgdbNl8Vk+2ZvpE9JO
         lt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757270960; x=1757875760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NAiKKbWMAZGMkQfKHixLzrdvNKYNue2EU7kkocIu3c=;
        b=QqUo/nUSM5rIKkbzboyERIIudwNceCeM0HPgj3wSwmzzhZzD9wn7GRqYaE3UYCOEcm
         QuidNV3cYB7D4XG5qeUrhk28OVNdP4JKkOGnIwGiyG8neteG3H2LUjfW1jKlFui4vETz
         b0LJjT1P7kZz3kvkmqxEdCBU5kJal4RtW7bWvOv5xl2Hggm2URvH4iSBTeyfHnkNCHtm
         ZToFVN6rs1JZAcqobGgJazZ1yKKjVncN74OybDx41HvaJr7qH+m5hvedZlSHdzF/m+oB
         04dll8bqcPuPUyHGaVi4CjD5TfkCHaxCu5ANA/ESgM2oL2hcI0NUnwF26NgSw0Yg8u+t
         KQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUctKQgSBy98C7tTpYGEY3RDKLxpPMeA5GjqVReEyHbmFUsuo1nbUi2Q2dFxaY/seb5cI11F9IoaszbwUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNiF44CyrNzx/gTBkMw1SInqXWw3tKY0rymDoXIWeJcfbTJFT+
	MpQI4hLndGGJHnJSITdhMvLJXWrbBo3jCHWXDoZb3aXOV+8LLXp5REfU
X-Gm-Gg: ASbGnctakyls04wyNanwUDDsDSkOCpUpVS6V6EOR6IV3thpRfsCZHIU1r40TE5m+N4/
	pW9r6V06HTFx7EUDZZFVbo0oRxJLN0HECgVekkp94QCDWwgzD0HsE3J9055fyPJ9Y8P3/SQZgI2
	2VNzeOiCGmDj0YV9eaqeUrJpgpatIBxzqatXcN1U8GnXvNJw0wLHk/WbYwMHTh2WhRdJMSvkufW
	78MC/yxVWVqyTtYPES79lrdTDRPmwL1wp/8sla997fc+MeEixfod2A6lyXCqvwbQWM05PkyKDuG
	HoyJgbC0qWKYRqN1EJUUJwFBLniQwC0Y3F+ez+MELhIIJ8nN8QFDImGgQzy9x7EUHad9g3z7kGt
	zJJJqT6/IeNjEdH1VL+Eht8w=
X-Google-Smtp-Source: AGHT+IFixl11lPNiGvl/IAVeCHfhyXmbkM21yRIMVZB7M4Jn6J3F1mrw7gB4lwL9OFqBQx8MLYkL4g==
X-Received: by 2002:a17:907:c05:b0:afe:a615:39ef with SMTP id a640c23a62f3a-b04b13cfb31mr495757966b.9.1757270959635;
        Sun, 07 Sep 2025 11:49:19 -0700 (PDT)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff032125e2sm2346381366b.77.2025.09.07.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:49:19 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND -tip] x86/percpu: Use BIT_WORD() and BIT_MASK() macros
Date: Sun,  7 Sep 2025 20:48:46 +0200
Message-ID: <20250907184915.78041-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BIT_WORD() and BIT_MASK() macros from <linux/bits.h>
in <arch/x86/include/asm/percpu.h> instead of open-coding them.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 332428caaed2..725d0eff7acd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -23,6 +23,7 @@
 #else /* !__ASSEMBLY__: */
 
 #include <linux/args.h>
+#include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
@@ -572,9 +573,9 @@ do {									\
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
 ({									\
 	unsigned long __percpu *addr__ =				\
-		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+		(unsigned long __percpu *)&(_var) + BIT_WORD(_nr);	\
 									\
-	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
+	!!(BIT_MASK(_nr) & raw_cpu_read(*addr__));			\
 })
 
 #define x86_this_cpu_variable_test_bit(_nr, _var)			\
-- 
2.51.0


