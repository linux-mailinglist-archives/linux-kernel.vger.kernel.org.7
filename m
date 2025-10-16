Return-Path: <linux-kernel+bounces-855981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7AFBE2CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E319F5E433D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189373176EF;
	Thu, 16 Oct 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct89i0NE"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41B21CFF7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609670; cv=none; b=quF8FFXH2a2k29kdwmNERHe3yGV/ZrcgLUDt/AgZRdY7+zZ3PMjjG7xgJKoUInSN0uSfGFl9pQ7AGlLhimZRjO3l4Vuwl+GGh4X1PlGKdvYxLs6QvxLN3tYI5hiOVNPdm6UpTFwzM26XWU+RwM/mTs8HflvwtYvpWfKZpJCnQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609670; c=relaxed/simple;
	bh=XZKUAjyZgpvAwblfyeQgsopbnMMEUhfjgY6Tm3Oz3L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmvHrFWF1mlOYfERfik2fnlWlT8qKkvDvuHqj6hk8jdXiVxMjBeHGbpEdXyEAUv1LfH1NbT5WhEx3ng/ytPFJZsMHjY4W/wMHmYh7E8XwRZFjGM+SuyldCDSIP8bxXNbS8vF9ayVxitdLimAg+YEXUsUtB9a1/pJsJVMWSd8RR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct89i0NE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7841da939deso549507b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760609668; x=1761214468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9sq1sHLY+EjUWXH8CqIvCdYzysiw4Kh2V1/GcaOrnU=;
        b=Ct89i0NEVSaOmaMKiSBNNgZAjsmZHGEfmFsgUXWd2Rbxf0ESJ49nj4IP9w4nmfAxhY
         HpdA7yD+gs1S4bVnh15Co/vI9HoQtZq+QxoAOknZQwQa87A5YVxCBhAu/dUOwWJ9gh2u
         6JqQKLcR/WihpDrXlkX0bk3KmAG66UOhnsaYGqx+i+13aYzfTw8Nowv+YQyyjOmhpDbG
         Fqg3nSyukbfGWRyL4agqaOhLgVfUuLvrWg6AG8B+G5bUDy7Naj2zKVfSnAcIOdJg4Uf6
         p1kHSFs7Q3IpZwjAVRAQBXoQbLB1ntoFZ+1rO/oECy40dv7J98VVzms/aT0Sd5TAa4x0
         AWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609668; x=1761214468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9sq1sHLY+EjUWXH8CqIvCdYzysiw4Kh2V1/GcaOrnU=;
        b=h6aSHgSv57wHxBj2xMrn2vDI6/dYFqjQEkcmo6r9VMhmueSygjQx/vLku3tKmDKv75
         x+Ma2pjMygJoAEJfQqgC+Sgnbi1ykUwmMxBkNQJFjMG1bYRDLGnayuYb0tAk5yRGaRf4
         dzSBE1y9jFJKNrvaq8ujGvYhRuntHO7B+qAh8pJt/c+V0nzI+9Q5hxgS7zXTYtsulfIB
         B1WtU5QtSuKncPVenDJN5Sf4MbMvrKEep1gFalPcrE1wv5O4uNCwO0rQ6pzGmElBmdxY
         kreAv9pGRB+jPnr3LDI4cHEQbDhewIY4xrQ42P6hqt1Cbo2AAgnjaRHtA5TDUlWn5Mwk
         du+w==
X-Forwarded-Encrypted: i=1; AJvYcCWqB8CGpWWH3baRAqH6gHwPHLWqwbOg0BIAmIG2BhTR/OV0JAl6f0J29Rq27U9xHkLCIeyG3bb9LpH7xls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmc9vGAGpjiJ5p7s2mVVqnL9cK0NBFQURcegM3RM0f2ID6I0DT
	bWOKMIEYl1omFUdB6YP9Cw7N60RVzxBsldOGuLNJXtHrsLLeBK1lF3RN
X-Gm-Gg: ASbGnctjnhboV6qjtwsGNxnucRR0n3VTcAhJ+Cqk6owrUMlLFUn3pQvfqqzFD+ld3hh
	xuY37ZL8dZk05rxqPzpbYxnHZEUcMWGdet/zRZl5GvU9+zBmEqkJ/iIGt/c67ynz/zh1byRjdKT
	tTcGKb/229NKIWH7EnLkrPo/NMi88eTWTOisCURCP4RE5w2gwikH+X3YvFyGZoga/S8FJhdyK61
	NMColtX2zRzKQ5CmPdtmbGtTKgnqHkYTu3wq77lx3BHM2LZF1W6JXb8ZFLn94lO8sgJtJPoT8+c
	sxyYBfQ2UliiRsv9lnDMqeoultashsmlW6164viWjcrJ/NgIE1bCkBtWnlOmtcQClkVcLZBpSAE
	wdjiu4AJ2suKkwXJj3pMRIPMK5S5jPQBk1YnVeW1DwJpIqCDxGUkIBfXO7N9U52IGWleNNVsOv1
	4z+qJTnlGl
X-Google-Smtp-Source: AGHT+IGLE/qfueQx2g3nGpqw2YlqTxW+JhbVxunJJ+/Wqm2YsG92PSaHEbFuJXHHMe7R0GXRUUe5bg==
X-Received: by 2002:a05:6a20:4311:b0:334:a198:e5e5 with SMTP id adf61e73a8af0-334a198e8abmr1388680637.20.1760609663534;
        Thu, 16 Oct 2025 03:14:23 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm2354263a12.9.2025.10.16.03.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:14:22 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from get_outer_instance() in propagate_to_outer_instance()
Date: Thu, 16 Oct 2025 15:43:42 +0530
Message-Id: <20251016101343.325924-2-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016101343.325924-1-shardulsb08@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

propagate_to_outer_instance() calls get_outer_instance() and then uses the
returned pointer to reset/commit stack write marks. When get_outer_instance()
fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_PTR.
Without a check, the code dereferences this error pointer.

Protect the call with IS_ERR() and propagate the error.

Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking
using CFG")
Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches/bpf/pull/10006#issuecomment-3409419240)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..ae31f9ee4994 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_verifier_env *env,
 
 	this_subprog_start = callchain_subprog_start(callchain);
 	outer_instance = get_outer_instance(env, instance);
+	if (IS_ERR(outer_instance))
+		return PTR_ERR(outer_instance);
 	callsite = callchain->callsites[callchain->curframe - 1];
 
 	reset_stack_write_marks(env, outer_instance, callsite);
-- 
2.34.1


