Return-Path: <linux-kernel+bounces-598355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45DA84538
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0631BA2DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6D28C5B9;
	Thu, 10 Apr 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRH7a5BX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283228D85B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292526; cv=none; b=dMM/U9qq2jZrm8mv+6cZ+ZKKJwjAcGUoA692tfDVElKjz/PqoFNkyMPTx1Qa+2MUgb1cypPbARyI2fsBNCncmpmutk+Qg8v1iIsRkhKwFtHPBW6/bPKzZYey+RcYyLyeXevtugl+WeHWO2Yid4wx7mEhie7Wp+uY5bGFr7n3LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292526; c=relaxed/simple;
	bh=c7VVRQXrhzgfIlMjr+TpjXTvNCRF1v445ixvQETbT+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fG1hN8SLy6YAPN6PJx12qwbUa5p5Kxm04oBZ7enwdxC18MnymKUoPSGleUPlqyB0Kd/aPQJRB3x8UbzShW9yGNbYl2w4ABY2ow8v3Djzwn1fLh3S6m0fLCjSMqdP3Rs3ok5E1pE8XhGAvInuq/tPbsWr618Ht9vVgg/ChYfKYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRH7a5BX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d08915f61so4929035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292523; x=1744897323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOh+IRGczBamQjnnCYnCR7O3Qkx4ta7ti5u2qxCyexk=;
        b=oRH7a5BXIVMl2WzWDgYkBvEIvoahMb1DbRXVYqg27ybI000V8qrjA7HBZTO2vQGPfi
         +6rFgUaGJI14p1kjig/Zln3/HUD3eWDkI4ItRgrIIQlq1iXHYz8mrE2aqXs48fdZD4xt
         aIziUcIlq27+PpdHced+nxi+p+f7XtpEZV64JXmtJl3jaaoDIoe/xezibebqD/x0iudR
         0Wj8/ysrAZFaxKKaF/PfrmQ0/CzPgHDOEdi5x2cFWRm4b3jhxNDS4rKbshTCLIHFhKR3
         jGM9sbNRor6R1GdA2LlNYMvrERuBO/yAy8jkofxjYsWr6RZhMeCCufkyfS5/0zARyDwt
         32eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292523; x=1744897323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOh+IRGczBamQjnnCYnCR7O3Qkx4ta7ti5u2qxCyexk=;
        b=OWHJFp/6SM00SO/kgYaz9JCMQt1afLpMtQchTLEQdBy5E8Blt7ZCLNi4OzGwTtPXUu
         MQdNsjAP1GwMaMKO+IO0rnpUsS8FK3C7CR2EgPtaJqOxBU0nWqj2I6yQNjoOZhlb6lG5
         FayKL7Jm36qesPoZaVS/Vb7lpTCIKdZTpMvudNISci5SglIf4PKPb7vbcDJy1+pN7kTL
         FAN21hh7bB8sef3D+OH7vLbfo8sUP/9A1+oNxSqijD/ipuJGmeiEU27JLySThSmsyMeN
         vUr0J39Ab4epFufXtpuifNL9yaQCdIp77ws3kvbdl5ts+UrCPvt/SCZBXTdfHNYB80/l
         1d7w==
X-Forwarded-Encrypted: i=1; AJvYcCVAsk8NzSfvuBU0272REGww98Jjlu1CPsbafInCWp4VcTszibPVucZ0um8gZkYC9a+JZhRZs5K7HwKz/m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfPT+Q3iYo+Lho/t1u0eZog0tfiEgAHE9k+SvjcKi523EMqBRr
	+salf8oZe6wuXqm2cmO3fQQyIvN2AXsA8dBL20ciNgYog3u6slnKJq8bIcse/NidVevgdQ==
X-Google-Smtp-Source: AGHT+IHlh93oL9mKoWPZ8xOYA3DwDprouXIOHdb9NVnXRG5y9eYSfFLcWKwT5Rx6iE1dQlUAN4pF5K0M
X-Received: from wmbeq5.prod.google.com ([2002:a05:600c:8485:b0:43c:eba5:f9b3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19d0:b0:43e:afca:808f
 with SMTP id 5b1f17b1804b1-43f2ffa2ee7mr26677755e9.31.1744292523066; Thu, 10
 Apr 2025 06:42:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:29 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=717; i=ardb@kernel.org;
 h=from:subject; bh=X3JfDQ3/BuCITBPYEHh2vS/KH9MRV7HSxm9OJYaOaHg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qQnnWN6GX+s0/hHHK/zwBN/KK5prDScuMDvg/Dz00
 afpPftdO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEtrQy/JUKWSp+5LqmLasU
 f9ZDuwAHRm4V4RT7x/6zRR/N/a/1XZ6R4eC8BdplW9cqCGc8D1q2+W7RbgOd5z8C3EUF1fb3fKm 7ywwA
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-24-ardb+git@google.com>
Subject: [PATCH v4 11/11] x86/asm: Retire RIP_REL_REF()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that all users have been moved into startup/ where PIC codegen is
used, RIP_REL_REF() is no longer needed. Remove it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/asm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index a9f07799e337..eef0771512de 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 
 	return p;
 }
-#ifndef __pic__
-#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
-#else
-#define RIP_REL_REF(var)	(var)
-#endif
 #endif
 
 /*
-- 
2.49.0.504.g3bcea36a83-goog


