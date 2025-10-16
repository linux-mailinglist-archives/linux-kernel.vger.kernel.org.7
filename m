Return-Path: <linux-kernel+bounces-856924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E335BE576E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606971893683
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1B2E5B2E;
	Thu, 16 Oct 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3WCvZeI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDE2E5418
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647909; cv=none; b=D4P4DWd3n9/HHapG6FOUHBkSCgj/XxtYPOXH3XKKbOm8Po4e7UuQFm8tFzFsc8+ThWCYGScHshAr2f1sHIhYz3lbNsfiDMsfck7mleVf7KxAB7T7bui8W4TKc5gu+8Cl9dBQBjdjkJAMweJtMAzUE1Hqctg6HAhQQbbqYKqmX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647909; c=relaxed/simple;
	bh=ELYvw7ZAYoD/qvF4+0zHGfAH8XjqxESr5Bk1ckhjTsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uFwfidZFXk9yUE7qrP0kZK5o4WR+GJ+7i+EMoMhxQ6iPGhPiMB83COowCIwi+Lfu4ADGGLrDuboH82JUqWzFkchPE+B2A8rhcfBgF/o109hfFZCaNQI0XL5SSMj79V8kznrwngOn/OgXxKPsmxuOJ9u9nTwGCLUmf9Tt697dk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3WCvZeI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so2085737a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760647907; x=1761252707; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3x/uHpEqiK/yR3zaxN8TiBftfzYVsJOeZiUqjKGmJC0=;
        b=N3WCvZeI7EjTOuhJpjZvzWZZ30mN5zRw76kcX7/Yge0X9/dF7Jpq7aUV5a3BJFyIF4
         XJatFbqas28+a7LSvQQC2RqDLR94r6tAzN8aSd1rityTHYjYhO4OCGKWtuqBFXmgNQLC
         JeTkuBITC5ey8FUbxKw9/TdtZS2hkzulB/QRP66/L2f9Gdr8UJ8PZJqrleyd8GrlhKEe
         2OAOrafEp1XwxnNjbdj+YnvZyHiEZ0oAMBr+wgjhp5cpiOZPxCGVqHDepJijLdXJm7nD
         6m3HTnP+jgAu3GPXjfZzsFeoanvCqEj17Tt0eSa8x7xz1SYUR+bneo9tJzTmUYJuEGku
         oBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647907; x=1761252707;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x/uHpEqiK/yR3zaxN8TiBftfzYVsJOeZiUqjKGmJC0=;
        b=G39fXAbfpO9kogDq5K3QgAdGWQp8DD2cuAc3XjGOrxy6+ZcGA0gO+YOUdGTUuZl88B
         x2kY24PeA7ToutikiycSBSDhrHJMeH4Fa1bv+9mStPrbMVMzOLbhDzviUfBTFnExDQaX
         fatYL/81au4BZCMpxEqcyQn5l0jEijNazPcGQNFvwm1jTu+4INB1jCtTfPLuFaavXwDL
         MLALk+fdrroiZwK4fzPpbHyuq48xDeM+4UFQZhSC4vJbuLveGKO0A6hUkYQs6VjJO2O1
         urKT26dgYPLevfueX2j2jI71+UivCVOWkqmaL4Q5eSn8Qm88xl7mEaojfheTTsoSUoP7
         DoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl6PtFonJbl7ax4pD3vlo6n/BAQFkINQUWIpXcGN3ZmJHwFb1Vads9+kDztKEtTQ2Al4ccLc4qp03LpzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQaAptsb8YZRL6wuEra/sIrZ3oYgbkrvGY+0L0hs7oBsV0IDF
	ap2dKWsJBALh+OPB7FQ7AZiR1rTOTDEDzgLYgRkNZWc6uPUC1tlwz9dsq/qOwLEA2exeqPDi3Mz
	4C0tzejO6UQ==
X-Google-Smtp-Source: AGHT+IHfet3YXaizTDWcf4cES9vB97PcTVbDuttutuWSnMKXiMdllyjCZASSKesyfzsvND89p+bwGI5ALSmM
X-Received: from pjbft18.prod.google.com ([2002:a17:90b:f92:b0:33b:dbe2:7682])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4b:b0:335:28ee:eebe
 with SMTP id 98e67ed59e1d1-33bcf908bc8mr1187370a91.30.1760647907329; Thu, 16
 Oct 2025 13:51:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:26 -0700
In-Reply-To: <20251016205126.2882625-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016205126.2882625-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016205126.2882625-5-irogers@google.com>
Subject: [PATCH v5 4/4] tools headers: Remove unneeded ignoring of warnings in unaligned.h
From: Ian Rogers <irogers@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

Now the get/put unaligned use memcpy the -Wpacked and -Wattributes
warnings don't need disabling.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a4464fe73..d51ddafed138 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
 
 #endif /* __LINUX_UNALIGNED_H */
-- 
2.51.0.858.gf9c4a03a3a-goog


