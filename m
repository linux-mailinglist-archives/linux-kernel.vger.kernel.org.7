Return-Path: <linux-kernel+bounces-862910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80501BF682C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0F3D505B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EF330331;
	Tue, 21 Oct 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="W0oSm8ss"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5F355040
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050544; cv=none; b=FNhLTru3v61X8fELgX2SJQI6oybaOOdzwuQKxO9w2/TY5dH+NswvwzbbJ5XvTcs0q11XL/WlvWJBRRCr1az7G7oRdM1EDgrv80nFRWqrVnmPVBc5ERFPJpg7qpR7QEhTr0OqwBape9nyobQJkJOJ6jT2EqThUm9eTrXJ7EsPf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050544; c=relaxed/simple;
	bh=kZl7K/EZ0V7AqsFLwQW2yci0m3Jf7pMTBFK1AheIjOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhd9qu+HWdYaEdI67j1cv5wdOLQqXH1qNKw6Rzo2dvsEDtXDUfg9LuwplYtqypvru9vTChneRVUm4ehX/MJZBRBvuoNyKDfl+BUhaPAhuKkyUK35erQ8i6h7kuAg0Vi08K0dkQfdaOPVmlc5N1D1DIpKlgBRv/xk/IWT9A+hq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=W0oSm8ss; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4486107b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761050540; x=1761655340; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOn3UfMwHh1btp/pv4pFbIJEXlaH8RnvbklOwiTYonE=;
        b=W0oSm8ssV2AjbCZqzIzzEfGt5iGG5MhFQE/6p9JdxLenQQcaKZuUzxnvoBY0IzRdLG
         FBkpxJ+4cbXgMFRjejm/4RqF2/Sy7oOHqi3FSqmSfn/S2dQsUvWGckXKm0rJyLtl+yDp
         8SClCTLktir0MHkx85bkOEmTY+CkBzHz3c3do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050540; x=1761655340;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOn3UfMwHh1btp/pv4pFbIJEXlaH8RnvbklOwiTYonE=;
        b=RGxEIRrVu+OZoksRsrCGDwX5e2r2ytb6weTNWjlfRMDNKJ2wztZSgC5jMQld2be+de
         6gliQ8NMuaO8CUP02Y0uFE9uQeXvTDWY9nz8OBrYY5O0kPgYnMXuZJjxhLrUFq8pA5v2
         Xe7hjiNLpUFdtDfzgjg29eavHnAOADCwcYDyldenlw+eKSgRHKQQCPA2v/P/y6NpWDTs
         3wyCOkDp+um8lm/0cTXLKHMKlPfQpnTg017JAgMvREZKfCJj7kce/y4oa0FRoxt4it5T
         /TchXXUEKwRHF7Txp2AeqFMOdvb4JNrHEjDMb3nErZDmMB9qFPp2jNJPX7yimQivSiJE
         YhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3CsoTe07Bi/5LklufiTdx96Izu7LXJ0/bDOWoZnjAyISlhOuEGAVfjUeJsYiG2t5I7TktDuF5OzXNqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6j69sr3paHOhfWqxtMvU1An/0as6WO/XDouH6DRJED+OgUh6
	sCUuX84MMbwid68nOqnfmZ27JrQZXPopCG7GtI9XQFR9u3rrUHOsAt3eqwaUjZpM9M5Jas2Z42m
	eRZ3JU+M+EW2YWF0eIEEUJKDEomj49B1t+moXEzkzpyYzJKrhCzcIsggl
X-Gm-Gg: ASbGnct460k89sSuT2xiamiWi6vwuiPP+sA+1xL8N8Drne2b/CR4swzCejj3l8VgTX6
	X0G0J2uz3CrwID/pCB5gxuTzRH2eXOd0zimWXOz9QhvoO+bLG6bbC//M2VSK+fU2iaF/2K68jzN
	dRUqh+B2Qn8Olc1WT8IoIH9YaPUOyJ1x2fXt3ZhjdptkdBp+4Iqsib1oy9Amkl25nB9DVKaNlsJ
	sNCohArqvPyhf7mtcUUH4WLAKBDlDW6SE8VvHx5yfW+SPU/QZrkjewA9v8ZmmA9/dJQFSSeP5uB
	ihofHGCYsysLC5Goz0V9PsyqOM3O7wkrE4SE8Ch0t5lMRELJwC/oyViEu+zp1ZpEequvdiHICe8
	5jB1d63I40UMclrAp116C5nzi9CdyIAsOdARLdwxMSnkrDVY6pw//w8JfpBGQT8z8/+Zx7K4U7h
	SBqaQtcFxgbnbOyH+W09FGwGVWwV0QwmC3O5CLaGpMP4LU+NgwLUazPfSm6ZiFUdJq+8FxZRPQ1
	IhX
X-Google-Smtp-Source: AGHT+IEdeUXEXYB4HW+XJo5SGpW27qmFvB4vzdwV++QmVAp0pZvJ7IJ1FNn2t13Bf9YjqW/yklyShg==
X-Received: by 2002:a05:6a00:b96:b0:77f:1ef8:8acb with SMTP id d2e1a72fcca58-7a220a57f31mr18163889b3a.13.1761050540290;
        Tue, 21 Oct 2025 05:42:20 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f159csm11264417b3a.46.2025.10.21.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:42:20 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: jpoimboe@kernel.org
Cc: peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] objtool: Fix warning in check.c when validating stack frames
Date: Tue, 21 Oct 2025 18:12:13 +0530
Message-ID: <20251021124214.25276-1-biancaa2210329@ssn.edu.in>
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
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a5770570b106..64c54225f875 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3947,7 +3947,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			return 0;
 
 		if (!next) {
-			WARN_INSN(insn, "teh end!");
+			WARN_INSN(insn, "the end!");
 			return 1;
 		}
 		insn = next;
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

