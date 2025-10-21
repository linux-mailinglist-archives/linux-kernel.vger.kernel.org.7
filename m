Return-Path: <linux-kernel+bounces-863038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B1BF6D79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C353BE76A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800312F39C1;
	Tue, 21 Oct 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="cORgOf6z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB628643A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054134; cv=none; b=nQD4Uzg+RuEOp4jLOqyfRLrOCR+N0FPoosHpWGRvA5N4tIQd2PocJ37Te9YGNFVaB7VfRMK4zwwh0B5p/RzAsEZ2IMMx7H0sg4kcPwLbW9hMO+wj2Uccy4fNVzcs5QUHdz+6j6TpxZ9A5TvWrR1qpPmeqcbog+xw+CljsSYVyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054134; c=relaxed/simple;
	bh=hYA3KojpeRNwJewN+MiogDAEmdEUjmfCmkzsC1EU/qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYRIIX8/vTR5i6e5gW6jfd4VqCA0ZK1RId/Mp5JRDD8iBNu3UoeYgBXQpcDsyMYXv7F6MR9Y13SeKo/iMyV2Hw3vDt1Ip1VzCggL4LkLY4b4+uYuL3C0tcXVhMAd62yiHrkb7hz6YGX+5UYtA391WhvmCzPr4gOHbFWYLE1LTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=cORgOf6z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so70341725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761054128; x=1761658928; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmPp39oEsxJ3tmSOf1Xh5rPCdie1LzDsNWNKPmEBGds=;
        b=cORgOf6z4zjb3heFCPeCmFSYxpEpou3shQNuTMBEoJvMZLCT5/XKtWKUc9cZGCYpqX
         4jRfsbPy6j6yOR3uJNIaY7QzaXBO3DmjA5I9pUXGt1jHT2QIhTLX1xXu6xilj127ghUA
         9wbZ7ybeQ7/fcrRXg0dL7ie/gCjsF2V3tLNvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054128; x=1761658928;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmPp39oEsxJ3tmSOf1Xh5rPCdie1LzDsNWNKPmEBGds=;
        b=flLmwV6GFD4b/5ABJ+rxwyHBp1CHRNJLWzoVtpX/0OKA74cv4krP0rgTWsBeSmU31A
         rigy078ZVxrkShU8gfCsm6Hh7GXvhurd5OkKPysQrEEAJlZEv3HCukZEREPL6Ef4reuj
         +LlBe38UFZOoGEZsePH7A+w/Bltf/Xad68WLrh1AZi4B+rXWOw5aPZLxj+Wv+COjisR3
         HNYG7Y0NubHNGwqbJffd8sMCJEvlkjrox2HGfJ0tn+UX9ezdC/F2545TXYj6YEtV2epf
         4/PIihpPNVN8CpGtaHcVBfhB7KbT35MFX5ok4VyobyF/0Lpw7aly+3OTVMB34ELhL6qX
         g2Iw==
X-Gm-Message-State: AOJu0YxgoG19eJ/NdgpS9ZWv8v8IurqOI8gkf/gUYvRp4yMPSuWTcGhF
	pWyDBWkLn2ewNnbmBqyVlpKOfvNvL0mREo9TAJ8c1zeJ9FBKPwIJ3rP87GxrD5iVC89YkKUodxF
	0HWdBVIDuQolA6/XL6rN471uKrDVL5jB6WLFIvFkQyCuZnsqBn/DD+w+YCahsgjH6WFTqJJZWFj
	A=
X-Gm-Gg: ASbGncvrO9eKni8PFYCWLfbLw3uWZ1k0GKCIcqV4KPpL2PoDhhoOzloKkrO0dC07nEO
	XpuyhcG5fsAtxD/+FZV0fwQTyQISR+ZAvNJRyiTJDFgAIiLIoVi/Ojb9uTTyENnB0HIDohHbThe
	JkdJwJOWR5ekxhRfhLCqC7j2Xm9JA91x0t5oDlxQ/KMXrxepEDyvx/C/L6HjhyBmV9IsRAtVKr/
	IpVvbpZ/Cla0A+cectq4yZgBjxhmKDzzyL2zAiLw/oie3K98URZr0+4nfUeqo8GSoxzM5p82a2q
	1RfLqrhl0GdZaDtq1brozn5HN9WXH3FPKsLwmM7Y5M0+5yfNCbhh3pjRLqbJUfc9//d7ndX9w8R
	YljSECAgQDpqLNxbC2i7n8uUH9LigYR/5DO2OK/9Ofzq5Iu+QZUIlCdeNeEEK6UJpe7A4KnoEed
	SoAoCeT5uDtMw5QWgIxxfhbnz7iQDqY+OzsN2+ZCfoQgIsDvBzl3E0sezXMwUrY6/ia1XQ7YvHT
	OkX
X-Google-Smtp-Source: AGHT+IFUy845JQIhQhJ31SvndC/h74SW2fYlHAu95jVp84sOxh+sqsDJbz9pTthCtWNMhD5KCmuZhA==
X-Received: by 2002:a17:903:19f0:b0:286:d3c5:4d15 with SMTP id d9443c01a7336-290cb947798mr253465695ad.36.1761054127743;
        Tue, 21 Oct 2025 06:42:07 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdceesm109078925ad.81.2025.10.21.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:42:07 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] spelling fix
Date: Tue, 21 Oct 2025 19:12:01 +0530
Message-ID: <20251021134201.30710-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/edac/i5100_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index d470afe65001..6a7c417094f3 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -557,7 +557,7 @@ static void i5100_check_error(struct mem_ctl_info *mci)
 }
 
 /* The i5100 chipset will scrub the entire memory once, then
- * set a done bit. Continuous scrubbing is achieved by enqueing
+ * set a done bit. Continuous scrubbing is achieved by enqueuing
  * delayed work to a workqueue, checking every few minutes if
  * the scrubbing has completed and if so reinitiating it.
  */
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

