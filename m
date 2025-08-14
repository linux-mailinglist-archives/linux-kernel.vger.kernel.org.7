Return-Path: <linux-kernel+bounces-767883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB74B25A15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0DF5C04F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7219F11E;
	Thu, 14 Aug 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwfPBscA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA91C147
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143401; cv=none; b=hb3Eammmzy5kQEn1OTLDoe9xLaBSTRV/zyV7kqMM0kGu9Ks6d74a5Wfdx9zWsFqKLnXGcw2LaZ5PFys9hqf95AUxhta5Tvd/4fNKZAiM7ES/Jvo5cvrraSIgdZRPjs5UZGcWsT6KqSXIiGOTEC0DyTGpaN0PtZRIJwRuquO5rYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143401; c=relaxed/simple;
	bh=lPqVj0G2DyYaPAyDFCY0tiqWUW0qi8F2eqgmFFWHkGg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IItmhsykNNzGpcqrXHe5VjhsaPw/RNPlm1nNQzITPD5bR2cXuw0aIV1UxOdf7AzxYjGF4HZGAJuNNmE6MojE92AQc1kzmUL0E/V0TLrkTrD0xgahmPsplCJcXWu7b7nlhIRaax7jKzQ5+6vI/GyQnf5JZiRUusrJGBF+m3jaaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwfPBscA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174b1ae5so345266a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755143399; x=1755748199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hty7WDnaEU1uIGqarmiq9SVgicWc3FSueIb95VGagqo=;
        b=DwfPBscANp4qL+xpUo1q2VHbGKwm+VxX9vvw86LN0fiwPWZQ74zct6zU2k7ut7BJP3
         JwM9lzGPIRAYNFupf7WQ4L+uTEZ8Oy9RiozzQ2Nq3xQMkx+/hID8QThbFMK2hKT7xux1
         yy/g2B38bpKMzoIxq8cW7KyhfDusABFp668A4sgW/uJAuamTInywMJwWpZIFs0uKItgX
         uW1pzQOb7/Bg8OIutWjJiIwkh0xf55EfuifDA3+gTxUf1zun9FgX112yGv9QZvre7/ET
         nGndstmSxr72IrwXAMTKWE+1Ivmb/TAZjn/d/1hP4IjmrBzvW6y5aMze7JfaEu6gJcP8
         iPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143399; x=1755748199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hty7WDnaEU1uIGqarmiq9SVgicWc3FSueIb95VGagqo=;
        b=D0fKZmyxEUpPaxDWWqZcNV5uhblMEhuaCbRyJZWddXn5x+E23tXpxUjbuItVmavMr5
         OYsT2UiqxC7j98HuSx/ZmNyn5EeOR6S5DLNDZVtfXc+PAw3bN7RDBdhOoDD5Xf5idSX7
         eU8g0GIilGDHG4O+qa7G1NdU5MbahygLGwY47gC8w8/WEwsw+wrQGuL0/xKADEvlikl8
         zcb5eu5PEXA1cQDuLGzquyJWALwlOVEYF6j2259V1A4p4kit11fYdFMBU/T3ZMgvF/Bg
         m0hAweTxGl0aIznn0+Xi+VTJposeZC1Ig/sjILF2svWUeyJjDWdT2rQj1KafdSsUvRHc
         MiGw==
X-Gm-Message-State: AOJu0YwmG/EtMvGzpuJ2630cFEXo+ozpsoBotbo6ReOF60JSTR+zguz9
	PhD5cPLTcYZJnBLDmWY+1cbpDB3+exEW6NaLOcbd9xvZ7Fw1ZnRGKRfHhkHrR30fkw9kRXjhxoz
	5OF3cWlzGiErJaWmYmhRzKBC42SU/Ll0iUFGnpc/qqRJ2dSLXqYXR4R4db71Edbf1C354bbAmVu
	ePv09aAmr0wNAqklDyfGHe2ZLKHKcN/jQ4uTmjsQEjtkhY
X-Google-Smtp-Source: AGHT+IGP5l6poYO1hNSVO0axML0Qny4BQvfhvBjEuphbMon5a4DVHWpJScEWvwJsXpAb320jG1BdEDNKsug=
X-Received: from plbp6.prod.google.com ([2002:a17:903:1746:b0:23c:7695:dcc5])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:240:48f4:40f7
 with SMTP id d9443c01a7336-244586c27demr23010895ad.39.1755143399315; Wed, 13
 Aug 2025 20:49:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:49:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250814034953.3980271-1-inseob@google.com>
Subject: [PATCH] lib: parser: Fix match_wildcard to correctly handle trailing stars
From: Inseob Kim <inseob@google.com>
To: linux-kernel@vger.kernel.org
Cc: Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes a bug of match_wildcard that incorrectly handles trailing
asterisks. For example, `match_wildcard("abc**", "abc")` must return
true, but it returns false.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 lib/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/parser.c b/lib/parser.c
index 73e8f8e5be73..62da0ac0d438 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -315,7 +315,7 @@ bool match_wildcard(const char *pattern, const char *str)
 		}
 	}
 
-	if (*p == '*')
+	while (*p == '*')
 		++p;
 	return !*p;
 }
-- 
2.51.0.rc0.215.g125493bb4a-goog


