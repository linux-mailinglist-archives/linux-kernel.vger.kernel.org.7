Return-Path: <linux-kernel+bounces-644807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88368AB44BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD6A7B0C55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12729ACF0;
	Mon, 12 May 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtsJcUvQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE2298C2D
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077138; cv=none; b=Km/a9H42qsp7UsNmxLM6UG84JsOIHnEHQtMbtwHUXCYVIB79SIkKtl0Ay0wYZplk1qVf6TeDerYYH5oXoeYpB4YMJlUVr3QpHIfkpUglNkavgRB7VHKeA/zXvHaZNK7teQdEQ+P6+0JS+pgD0I9dwIDvqL4nzUBxHwPjOb8jfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077138; c=relaxed/simple;
	bh=oNpZWzxML1Y9AUwsTEbmGl1GQM0zru5fkRJMmLZ/LBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GCE450xvAtE6vujsmMoBn/PvNHZLV7lbiPkCGULcnIo6Lnf8Xq/9J/4kE81QUXpJncnWXEb6VdBOQLRnYkI58pHNv+GGYQD8btA9dotyyQENkC1K3IZtrJP0T98ditBJ8J4E+Tf+LeUbcW5KU8ICmN9HIX8R7iD+uVxOPcrtBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtsJcUvQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so19129455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077135; x=1747681935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI3lpf4o3BFZ6Wf9RXkL6mjd94Q743aLN5UBFJjS89I=;
        b=MtsJcUvQhXAhY2LIUETIUwb+OIdcX1QVmkHNJ0w343mGKoeY5C+rAJeMAL3fQ9nRHb
         X3sEeS8vFbWrNaV0plKR9x3IX4qbn1srRvgR7umXIuEnQoKDRsksQFtqiImYjqdmNoTm
         M09AB0uyaPi5dY69XjgXZ5guavtrjJKgfKmiZtYhDbw+PkVXk+iF8+OBpUoUvU99y+X3
         66QwzWRHi1825l8Kp8/m15PzRAk6Cx1CQkjHbpqaEAqNzn04y0xJMjjaO9Yg0lgO0HAJ
         Q/dR8276IIR+39eeVzct4xkJkJ/VS8NeDCaFi9TGEuZ6J78KRrehUptQaiEZ2iLW3VXL
         UuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077135; x=1747681935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI3lpf4o3BFZ6Wf9RXkL6mjd94Q743aLN5UBFJjS89I=;
        b=JdISO1f/3seGCd/uxJAGlFe/nTRFghpfGuWDbuG672mh643EbfT0JXgXTZHPwfvn4j
         U7UcVU0X1QM/UY42/J2SEt1IwbPs5mWHEiffmrLYfNr410vdC3vaypyOKAo+TnVfgOkX
         +m828YSPdLdrUJ21ocbZ7YCDTM99vBj686bGh45URub9cFnjZoUJmgvVJiopMcSyyRA8
         3znYS1qX3s1qUwGWowrjSotM0VZgpKzdX5PEAR6C8qWiOFCkwNIY4DgEb0ruC2wkuQsT
         jQAA/b/cnJSLMDLxjl8sY7bg9VjvyAkIfWDjS3Wy2KwSJvvC6pqXMvj33FpK+CekFY6+
         BR2A==
X-Gm-Message-State: AOJu0YxO/zYLliUW9QhvTxzw5BEc5Ax7IDINrq7hK0WePeXzQ+7Eywpb
	7x/tcDXAn+xYrI7YrCxUIqwkTzcsrEFFE+HkFM3OpgAAhMF9bsQmj46az2oCFVhKOMzelrb+/1y
	4YLTm/SJiyq84PhPVC+CK/moEY4c1EaVK7y3CHOpuI0Sbu+1JXbeHcecl7lrFXv4Du1ljaJtNme
	+TV+Ch1ig+O4V5gvmQc61jCt9+8pNlpQ==
X-Google-Smtp-Source: AGHT+IGCXNDr+jh6bOr352X5CVhqqUzwrHtlwyq9ZxtmuJ2vjkk6u7svwBp8YAU1ah6nGYR5VkFGnYjf
X-Received: from wmbej12.prod.google.com ([2002:a05:600c:3e8c:b0:43d:b30:d2df])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3481:b0:439:9737:675b
 with SMTP id 5b1f17b1804b1-442eacba7b1mr5246275e9.7.1747077135091; Mon, 12
 May 2025 12:12:15 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:56 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=ardb@kernel.org;
 h=from:subject; bh=mya2OfKi8dRdyM/BzZK5KhM5tXbVnj0PSSJLpQKVmKE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPbrBNeicjUn71hpXK/sM4ZOafjuMfpxY/9nIk4/HT
 +4bp0tHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEjKaYb/LgGWLmtaFzQ3CGX8
 tUvRCXJm3rvm6ftch41KG3U+N/zrYfjv6VhheMg93PVbFsMto/XvKj5a2Um8Ym9SjL0+O2D1f2M OAA==
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-44-ardb+git@google.com>
Subject: [RFT PATCH v3 21/21] x86/boot: Get rid of the .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is now empty, so it can be dropped from the
linker script.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4aaa1693b262..af8bc4a6f6c3 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -160,11 +160,6 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
-	/* bootstrapping code */
-	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
-		HEAD_TEXT
-	} :text = 0xcccccccc
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.49.0.1045.g170613ef41-goog


