Return-Path: <linux-kernel+bounces-841550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E5CBB7A19
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BF17347312
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5572D6E70;
	Fri,  3 Oct 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKNXxZKq"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E82D6623
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510640; cv=none; b=MJ/Gf0NSAVgeobwB9BQZcvOI4nDBcyomOAkQNRp5n2THoNxN6Ni1u3UtysA55Btg+eaS3xD6fBJcLUNPVJXUuV+yhKxD+UO4MsqGOcDsbts+hNEIesWObYGbPy70ZeNn48LLdxZ3+h+bg2YSxNfptSeN5WodOzopnFFAXOYZpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510640; c=relaxed/simple;
	bh=VETzmhskgy2gGSCLQDKYYKYMqgGo9olkdwWOkSmLYMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P1U07kgXRYmUsQ4cjQ8XDnYWD610hHY9/a2vzDHhdK2Phtvp6ylCSraS3QTpB14L14YwYDvyLuK1ziPnm9Uv3e1i0c30JY1ABaP/maAhOKDABKIxTeQYc8NsJNaRXibgG2Ps0J3FerDnBamiAWu0ZjWmxuazUtaUDpgOaxmrjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKNXxZKq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-632c9a9ceb1so2813454a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510637; x=1760115437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNiFQQNauVccraDTrRrQTcaIcb2g61nKpElsZ5+Rl7k=;
        b=AKNXxZKqDa34bkZn6xzBAVSk1jQsy1lkhh8MYS5r9Qy/1/Hn7IiBfUNELqjBrgZrmo
         nMvAYrWksJ8wXekwDXj5G6Hmlpfozmkj1UXTj3aEqCq0ZVB1sMAwubH/EAPLpdtoFo77
         fBMOhN+xrkHma2LXpv7kPoMomLoOIRuqCTMJYapa55bL9d1xoX3priCgAEISIUBU+iR1
         FWvs4VBQXjD+dBk+Mg0wQnvbYh9yXmdh1R39b7P0ZREklCfuOdP+2SzX9XsqO5UaLwci
         VbhsH8DkkXmVPYw89NxpcWMvEjYvrywLFPykBJqHqGb+5MC2g4JVpsWBATY4EY+LjEF8
         K+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510637; x=1760115437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNiFQQNauVccraDTrRrQTcaIcb2g61nKpElsZ5+Rl7k=;
        b=T2BbIQZXaY9Hw/SjMa6FlXaf+c4gEUt/phYModbVg3XpUH0K/l239ZyDeTWzi7zhOy
         x3zfXObwjH6lFMIilS3IzuoXZYQPppR21BE3cfDf5vTzjpMcekl/F04HFZOxEpiXExz4
         h8Dz9L5P29eNoEOWJoT0It6w87l4sbm+knT33eUdio/lm3TKQ75S4IEKCc4TeFvdOReT
         MOM+th/GtfV5WQSMBkARLhBBJ5qXgrj3cwqIgRA1zJbMq5TSS0AQisoL/L+den1oJ/DQ
         ouPCSC2VMvXApd4w4z2b/HdAGZxf5OA9Pd6kcQDCuHV31yWlzF/88Spz8ka45xBkIegO
         AYRA==
X-Gm-Message-State: AOJu0YzoRdqM5UroZLPWgdZqA95kfhtsMuRu0bgg2o7vghmkFeh1mvjD
	Mp66VjfQcR4xDLkhDjneSUl8V/A8a8BOvAj5KlCJnSXsvY5SBHm5V+5XcV5bc6KkIKAPtnB12MF
	C355hohEs77QhYg==
X-Google-Smtp-Source: AGHT+IFH97A5VIYjVoQxc58D5OI7FpmzXDhAh0HKWdmhphmD7ch+v+cJnlLToxPHbzV3jHYL/vTRG8k6Nwqvtg==
X-Received: from edrt17.prod.google.com ([2002:aa7:d4d1:0:b0:634:b3cd:6750])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:847:b0:634:b4af:f53f with SMTP id 4fb4d7f45d1cf-63939c27d69mr3780173a12.26.1759510636836;
 Fri, 03 Oct 2025 09:57:16 -0700 (PDT)
Date: Fri, 03 Oct 2025 16:56:41 +0000
In-Reply-To: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251003-x86-init-cleanup-v1-1-f2b7994c2ad6@google.com>
Subject: [PATCH 1/4] x86/mm: delete disabled debug code
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This code doesn't run. Since 2008 the kernel has gained more flexible
logging and tracing capabilities; presumably if anyone wanted to take
advantage of this log message they would have got rid of the
"if (0)" so they could use these capabilities.

Since they haven't, just delete it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e3f17df57df7b12338f3c0ef4c288..9e45b371a6234b41bd7177b81b5d432341ae7214 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -504,9 +504,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			continue;
 		}
 
-		if (0)
-			pr_info("   pte=%p addr=%lx pte=%016lx\n", pte, paddr,
-				pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL).pte);
 		pages++;
 		set_pte_init(pte, pfn_pte(paddr >> PAGE_SHIFT, prot), init);
 		paddr_last = (paddr & PAGE_MASK) + PAGE_SIZE;

-- 
2.50.1


