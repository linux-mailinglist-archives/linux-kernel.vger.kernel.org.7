Return-Path: <linux-kernel+bounces-874592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB50C16A40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9891E1B238FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FD34FF7F;
	Tue, 28 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/HR/dWG"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C8158857
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680435; cv=none; b=fvuIb/v+Q+wwZuBi2SgjYq8LVva1P8U9qwW0ufBUHFeokgq+swokSJSVDd3Q70RDktPMuKrOT1a6y+GXC9wSbrHjPYmgYUnxzc7vCpU5jBbSiZB1Iu7/FZZro/KWos4sfuxsjIxfS6Iax/SUEhNPGoppGo2geEt8G12Vqu4vf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680435; c=relaxed/simple;
	bh=To5acIYuKxLI7VmWBBln4+MVx0ugLM3XHMdYhItqD6k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YJlMe4yUYbKFNcOBH5nrFs/HgOPbwooEoKWNxP5crDTdycIVbTGCGN34S8kovzH+3McngHIMrKJ/NAq6AeJXIPQL6dvqi7ou2jy0sUMUOw+aylrn11x9T8FnbANWNpYjYsNjg25D6YUV9kzH8Pkajs0KZonEeUjiRWZW+gc+NO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/HR/dWG; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-89fcdd9f931so415190085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761680432; x=1762285232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=klmAEOBgnK8V0krntMXnjM4cr8IdVdSgq5C2UUbnczQ=;
        b=i/HR/dWGVm3Dmsu8GTZTkgpRirSKGhbSVtGpvnSeAivjw2oQ4/yyYpvA1wIXRz32IO
         FRcV01jX/Pm/gsVAG7FeqGgeBLvUgeGFVqPvKcZDYOMSeEeFgGt6QsjkVrdjCwJCTnpY
         XMPdYusGbdT0cFZDBasuL9AdqQHkonMKOPj/36vCkY8KtgeL/J/q6HrLXPNzYuMdC/6K
         KIm4enTWIOIQbMjKVsBhTI0pjNyYm5f8obmQ7+xoy9C+3xzUG+yUby60BlfrXDtn8axM
         8u0e/eNn3wCv5yROYSu1PfgI5XAFl7rokvxwtwTm6svM74YCLQlWxVjL0ydCY3NONBgb
         BM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680432; x=1762285232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klmAEOBgnK8V0krntMXnjM4cr8IdVdSgq5C2UUbnczQ=;
        b=HsCN31i7+zBjde843t9DNBz0QEZEf4SALX8lWMwBYZuiTSOMdfqfGfO4yd0IlvfQAI
         EedizRFdnZjKr327TIN0JPv55rGxkPehXwG4xCQamkRI741ssBHxEoanV9fx20b+v+Yx
         CXnAQFToN22EfCqJRBNitJeH/AqjcnYiRW1zNob2oSyMHyQAIt2pM3jZJVdXhOSsw2Vd
         8SkBNo2jnO3sCTpgVfvIFuTkChQmcctG8NQOwEnllMr1eH5AtaG1H0EKlA/rDQsEZ+US
         +JMZ7VMdq4jK/6nl1ocjAxZ3SP3uMwqZ7c5SXs7V/wXiQwGxKTpPPmgeNgBKr1TG4DgS
         qNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWr48rgLmP5tW+joO96YTOHpGlq4ABk5e0VEaPABSZytmVnE0XvPjv8ZDv2Ot8kr+pR5gc0Ql5DyH3PHoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mh/o9wWGiyJGOf7n0fLb65ZcRJ3ykgP30HKQToiZslyjQpYr
	6d+DwZvEC8lDuGC6AVkNJsO0QTlfBg9GSKH3oTwW337U1h7oU3R4tlDWwFOrsqAdtnAcvcwBLPe
	OPA==
X-Google-Smtp-Source: AGHT+IFVO1CqGnWuA7TXA7gqNnWQ0zNCmjHiQKbhFId0ZmPSRBmELfYFPsXfnUDloIvO5lq/eIrrgreMPw==
X-Received: from qknqa3.prod.google.com ([2002:a05:620a:6483:b0:859:f095:3f58])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4016:b0:8a3:f8c2:5f01
 with SMTP id af79cd13be357-8a8e5d92995mr76595385a.72.1761680432512; Tue, 28
 Oct 2025 12:40:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:40:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028194010.519411-1-rmoar@google.com>
Subject: [PATCH] MAINTAINERS: Update KUnit email address for Rae Moar
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Update Rae's email address for the KUnit entry. Also add an entry to
.mailmap to map former google email to current gmail address.

Signed-off-by: Rae Moar <rmoar@google.com>
---
I am leaving Google and am going through and cleaning up my @google.com
address in the relevant places. Note that Friday, November 7 2025 is my
last day at Google after which I will lose access to this email account
so any future updates or comments after Friday will come from my
@gmail.com account.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d2edd256b19d..2fcf7e4a5cfd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -642,6 +642,7 @@ Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
 Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
 Quentin Monnet <qmo@kernel.org> <quentin@isovalent.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
+Rae Moar <raemoar63@gmail.com> <rmoar@google.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
 Rajendra Nayak <quic_rjendra@quicinc.com> <rnayak@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..eefcff990987 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13601,7 +13601,7 @@ F:	fs/smb/server/
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
-R:	Rae Moar <rmoar@google.com>
+R:	Rae Moar <raemoar63@gmail.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained

base-commit: 9de5f847ef8fa205f4fd704a381d32ecb5b66da9
-- 
2.51.1.851.g4ebd6896fd-goog


