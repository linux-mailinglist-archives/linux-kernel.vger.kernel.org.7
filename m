Return-Path: <linux-kernel+bounces-855609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2BBE1C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3A294F74D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F542E0924;
	Thu, 16 Oct 2025 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A49Er5t7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69E2DF3FD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596424; cv=none; b=Wk3tCFDjSaaNfYLvcJe7c5/lWB7PbpjWfeI4XKqRQgBpGFdhIYrwB8TRCMb2+EiADKLLRYZEdwg8pRj2L8POuMxPigTm/1OdcK7GTVg6Cc1zBG+wu0XHL5pI4OtrX1c9s1lCUkIbZBw4H20GEd74iUEqapZdXPgGpBEmGkSB0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596424; c=relaxed/simple;
	bh=QKb8w/8hbst0a+9TwekydxZ6WrijWkE5zWV3Dq/QQe8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQxIyvoafyXq3LYwLBp5J8MJUdUN6AVC3gJajgI1n1eRXA4mblCqJvbtYA47EGQ0p1F2sXtMReGAeLAX5oeHTJ4/xAKI24EJc00AV8MVWXRt5x5HMXaWBEUI3cIGQMOxoXhJhJo2kQg1ixvrel/kf4nu96r3E3QpsrO9NkxsIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A49Er5t7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2907948c1d2so3904295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760596421; x=1761201221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfUa0xZMS6R7Q1Qb3ANotsbTV7zLT44xaUq7MOxEAto=;
        b=A49Er5t7VmXUls/sovrlbcu7oEtjYbjA+4BSXe6adfQVaLGRHrH9FmYSIPhKH5/A4O
         pDvlbEJ5Fu8JrnC3V/K3aq0DflyA3j/4/+UNT2KGxkPXtXdqw86ZGAYAACR4ZmTfjG4C
         X2o4oGGoNaGP5IgSVLNcLYNJRy29AqRp7Casd5+IHHN9hWb2+FDH0NFhBLEVOnkdwmZ/
         Q0MmTcEECXwJK2jYBPI9lJVozLYfl3V6AINqP/oEwVxNGirWWHDktddvMJuPBINPuq7o
         dJ+r1BlMz4Tfl4Q8Rdui53edIBCyFcDLzkg+sYEpYmWU+wCxpKU30S0o76n9SaVQfNRX
         dVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760596421; x=1761201221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfUa0xZMS6R7Q1Qb3ANotsbTV7zLT44xaUq7MOxEAto=;
        b=A498Zmo8wod8DyUSQRLZu+vCO0h03bYRTWNxq1cHXY8tOJnEIiwVvEkXW22mJt1Xlk
         wVYUsbQky80pJYtvcKXuvKkDpnoW9eK0k54d0I4S5nzEUPjloKzvb4PCpC3gKJgHv89h
         W2ZIbWDtantyQ5e8QJblQKz65KA0cebqlXLZsnVJifv61LcssZCjLHGAyvEYZwgN7k+k
         WF+vWAFKL7HaRpYr+EUzO78iY/XmV6T53yaDoJyS59huj1LLNU4d2NQECb5JL0IOKqRe
         fDvB33/Oy1GGFtMHyhob+Y5eCLts+GALhIFZ28IbPpUfCN1daSZZJ8+nsyLDE6Jc6tLn
         8LEw==
X-Forwarded-Encrypted: i=1; AJvYcCVjhcP4d1lK/wESLFOAI7WHCoYHiY4kiq41wH6iuZYhSOE1khFYv1mF6P/0gFpMiQBysWbXHrQKxSDwME4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2ptFGkQATqxIpFF6YxVj8+9+sAsC9z0WgmZHuExld5P/DkDf
	/BcGILtAzhw3ttCvu6Qi1vxn9qZvLU3o6i6TAvpLmbVJl5z3xMiTcaUO
X-Gm-Gg: ASbGncsqoMrXLO8aPkzFZcOsS6AdC3zidpC9BaPW/5qo4eF/fIT1xJaJG3W0UbqaV9s
	kAa53iY9DXSzGvbIh+/IR9mpCgBU9JOHMCpZ5Yv9g3zmHoyFI8dgM+/YMmOmacagy3rO8A+DGbX
	BIcjdq3ekPLfcDrx1Ftc49DPOwy5y/Nx0sZXJdRCZTiY8pEx4QF+Cye0/juMZoUIqYKAYjz9zrT
	b0U8aM2zr0ieSo4IJOKcU5dgSdIkyMBdWRojKWrH1l7lWGM1XiyDwVQ+Q9YoiMj8W2Qqdc18xD8
	r8BVWfPGLD/Do/QLumlBXwT7CSvJ9J5JFI7vwt6vgZuhpwDdZ1rL+HMbLMkjB9LV+rS2q75c4fL
	OCc0zZ9XrOPrxMJ8dlhf6QKO5M4ps1r+KhZd0Tp5Dr4AOMmbrJQiSEjMJ3xLNetlT8Teq7fjNkC
	7OZ/DEMorx
X-Google-Smtp-Source: AGHT+IFe7AnGlJKRdPXtAXtDrlYBOMrGQut8mm29jTw2MsQFhyVfc5kvmXoawfVDwok7GPGA99X1Eg==
X-Received: by 2002:a17:903:4b2f:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2902721332amr388254785ad.12.1760596421435;
        Wed, 15 Oct 2025 23:33:41 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a999sm17738365ad.9.2025.10.15.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:33:40 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	shardulsb08@gmail.com
Subject: [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error path
Date: Thu, 16 Oct 2025 12:03:30 +0530
Message-Id: <20251016063330.4107547-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __lookup_instance() allocates a func_instance structure but fails
to allocate the must_write_set array, it returns an error without freeing
the previously allocated func_instance. This causes a memory leak of 192
bytes (sizeof(struct func_instance)) each time this error path is triggered.

Fix by freeing 'result' on must_write_set allocation failure.

Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking using CFG")
Reported-by: BPF Runtime Fuzzer (BRF)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
v2: Resend with complete CC list.
---
 kernel/bpf/liveness.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..1e6538f59a78 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -195,8 +195,10 @@ static struct func_instance *__lookup_instance(struct bpf_verifier_env *env,
 		return ERR_PTR(-ENOMEM);
 	result->must_write_set = kvcalloc(subprog_sz, sizeof(*result->must_write_set),
 					  GFP_KERNEL_ACCOUNT);
-	if (!result->must_write_set)
+	if (!result->must_write_set) {
+		kvfree(result);
 		return ERR_PTR(-ENOMEM);
+	}
 	memcpy(&result->callchain, callchain, sizeof(*callchain));
 	result->insn_cnt = subprog_sz;
 	hash_add(liveness->func_instances, &result->hl_node, key);
-- 
2.34.1


