Return-Path: <linux-kernel+bounces-842325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE8BB9802
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB28189550B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B215665C;
	Sun,  5 Oct 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="caieUuLO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB41C72
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673818; cv=none; b=HPb+c8HGdFrwdIosVpCZ0wavzPkH55PgZ8zPvu2ryz9a9v7Z8EtpEu55WZQYKfcdnk0H1HjcBrwLEqjLqEtdhiLUFGOi0OYxg1MAyfyw0x4S4HCGz/8ugPbaobu9JKIDx14mdsShT0iFHKX91Yqap9ryNEFhesCRKUozOKZJiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673818; c=relaxed/simple;
	bh=MAFD07L/qdoSHf4v2SEn6E/CYOVj3EJRG/rAgBIkzT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKSEL5kIloyprHESw00FNOmtyUId1zWVDkyOk1WAKQAxV9WduqsxOBXyxOzcdfN0gBOwTh5zkNP9TXrOAjt35+6xQ1dsYJAOm7NzbGh2XHNGrbfEkDbEQ0ZXzZB38fYwVRJdCh7OtVRYlqm2ARQvfsNmyMalw9inj+lZdzpftIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=caieUuLO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781251eec51so2979956b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759673815; x=1760278615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Yc/qvWyblSLPI0SiPJftDPwPdwcMYxlKtDo1UXOeD0=;
        b=caieUuLONTz78R8CVc1sc0p2nrZAfpjJtwn/PcWDttD0CKpPhFJKgwyHQFeEkDp/RL
         wPM0eUWzJVmfLNtFvCpxPoCrJLXEr9J6cf0DZsBYhOMIb2cW7/6dAih5fQerbZSC8Vl2
         SXAfnI6xNEkqk6yqQpqBvpBw8cJVZl4S4yYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673815; x=1760278615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Yc/qvWyblSLPI0SiPJftDPwPdwcMYxlKtDo1UXOeD0=;
        b=TfVA/EWHlCCr4Q997x/siEQzUt/Kjuf4rSfsd8joGNnxfWq7xmNFBAqtAN+RF0GYPD
         9Svzsf/0XO/fPi09E1I71/x7ZDDA8lq8dKProOwfSA+Uo1SqvpzJlar8s6FiGS6Odym0
         UNBdJRO6L3eKLhH/Gfi9nRJuV4SKvwzacChxZrPONcztlUXJNXDkkfkHECOWtqRu2oSy
         XH9auqyDBrN/5GUOZ10kcMcGQ7uRGLFdKyMl4z8XV1XUrELYWLzArrTUnVeOF3tztuke
         gZMx40W4R3BJcNIuRi/NfxYaskb59Ui4s4d40GpX4K1/Ccep4Os8NduKIEl7AzDRxtWt
         k6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDFOHAEHzudtv2jJhWTFmJzm37mNJcXhrXiFDTT/YJukgh5zBqVSsftsQ6APa8iC+4ABia6kQ05LM6Cmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQRVJ8A+U1lQzURmQK/DEqlLVN0KVHPotXvl7dE0RZsIohXUW
	e4UBwL0xIY2g7uqgo6YVytUnENzpw1ZNe/a0YVvel4rlZ6xJeb/xvZFw6SLMd/G01Hw=
X-Gm-Gg: ASbGncsC3/2MqXAKPxOEHdBtwdku1xRw1l6uh/RuNYO7PhDLJc0pV/5wtnJC6kPKuE7
	tgYOxJ8rU7R8nIfRuSuJULFp2n2obLKiAN33AzIURqrEdkmrDs6zVFRUih8vXl7JBGd4dC/sR4K
	7vaP9Ccc8SOO7m013byi07NNQQ5PVg6sZT+oTFIWJLHS/HiXvUBtFf+s24FnZAn0rcaWMo9N+RQ
	HMUjx+rwpKnFUufQFkRM7r4WvK4Yx2hCFPtQlnxJzsTtTWJ4By5vy7nonOFGuuyKN/MhhcyOrkX
	EawUOJGRqUor6hkiatC0tYAyqwNuMyChZ/7ClsOFtEm1LmRXgXmS2uJxSnfZvRBxBj/LkAsVReT
	VehCMaDRpNKkLGqaWMbFyMCJvfdttGSopTOUQRIBawBL0HAbAZ1yTm4Kz4k1+OhVR3TIWnqiXGN
	XfChIgdAe4jBlBb4X5sR56Cfb7UrA=
X-Google-Smtp-Source: AGHT+IHv+ZAL726mjCcBPtX6Ov3fWGZ0otnwsg5g72LayUkZ5zc7c370lf0Hek7AOgVQSc0P0/wuXw==
X-Received: by 2002:a05:6a00:13a5:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-78c98a40a56mr9244933b3a.3.1759673815518;
        Sun, 05 Oct 2025 07:16:55 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:a866:8cc0:feb5:15ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm8301295b3a.24.2025.10.05.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:16:55 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH] trace/ring_buffer: Fix locking order in ring_buffer_map()
Date: Sun,  5 Oct 2025 19:46:36 +0530
Message-Id: <20251005141636.12405-2-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251005141636.12405-1-ssranevjti@gmail.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
 <20251005141636.12405-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The kernel's lockdep validator detected a circular locking dependency
in ring_buffer_map(). The function was acquiring the per-CPU
'cpu_buffer->mapping_lock' before the global 'buffer->mutex'.

This violates the established locking hierarchy where 'buffer->mutex'
should be acquired first, leading to a potential deadlock.

Fix this by reordering the mutex acquisition to lock 'buffer->mutex'
before 'cpu_buffer->mapping_lock', satisfying the lockdep requirements
and preventing the deadlock.

Reported-by: syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..82c3d5d2dcf6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7222,9 +7222,10 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
-
+	
 	cpu_buffer = buffer->buffers[cpu];
-
+	
+	guard(mutex)(&buffer->mutex);
 	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (cpu_buffer->user_mapped) {
-- 
2.34.1


