Return-Path: <linux-kernel+bounces-827006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C340BB8FDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC8177D21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A002F39BC;
	Mon, 22 Sep 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIH08oIx"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D72F1FD6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535036; cv=none; b=IdfD8RbWw6b67TnuJHlHiFqzloRChsDKYPOaM69igx2pwKgdbHMdRB6szBqzGOTGqgscdyW0qxbU/jXnLz7oRhcdHJUNQpDrEQeBRKkxgmyo/o94d5Ina7w5NfmcXn15Kiyd5Vyj5IT/Cvkdm5px+b40YYLDBrCqH9cQG3p2nBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535036; c=relaxed/simple;
	bh=aGGkftEpxyeRpjslshbiTPf2LwpPozzlIOEJ76hTs5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jnp/MAq53bec6hZ1O+o1nIIQ3a7ej9sU+XS3+88EdmO1fa/GQaphut86X7zWc9dQCQGVSMVjnNU3AdVUAStazALtCs8UyQppIOEyME+ZHXcb2XVi4yZjlhEbztR4EajjU2MkIjLyd8/aX+2uDiqWXAmf13PLNlHtyeR59iSQUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIH08oIx; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77f32d99a97so725689b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535034; x=1759139834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu1DRFWIn6g/S08K2Xn4LJu9FjWj8PhXp8/3RimhhlY=;
        b=NIH08oIx5QU/YpCFVzvoQOfbkH8ypV7yqnZ+s9BQluF8x9XlyeskalBoU226H4nXM+
         F7/YjI5Bjpf6UcwQ9dvJ0XP/uFO2fKCTKUsBB3tkgbZmQKuz4ewqIdUswxl3cvXNfbj5
         hfGu673P0RK5F7XHEOn5IllFhMmvWWS6xFHNu8wecvHpjiUvaoNgtUX+NRNfFnjdQswe
         LIrRxeI58cQVbPLje/BEdxvVvO0iB8jTgWTPq2TfW8N4wnMVE4niKoTZyUcSwIwK8L/R
         ovq1xETzBO5GL8C6wqwXBUTOBivnpeoacmLm9LjCCiDm1ZMDnRzC9fca3d7wJ5PoWx1h
         0ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535034; x=1759139834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu1DRFWIn6g/S08K2Xn4LJu9FjWj8PhXp8/3RimhhlY=;
        b=G9IQai+wp4tp5jJ05dvO+Ok24BSHcDFtTkSBvpx4Yxn4Ie6+dZ2Vh3xJUK7+USV11u
         /MMYs53eulU4noLwYhfH6BvdG910BU5PqP9c6dHf6+W1kmrbFvDksQ5oBYqH0LUcZt0E
         ClIzi1BROrwE1/zSClNivQqrvYJfClO1w3GSBilbJ5brU6RPdqfNdcufl8YToR4ukyZp
         d+nGasGdDMEj+iHyvKDEnkOdug/mb5gR+2Lwo2hYnjRIrvFigcnpRPQcLIYkCMOlNpHI
         8b1lyj2rO1gnNRj426M8PaN5in25O8esB8Ge1hWvPAFTDtBiD2eXdjqRt6Ee7aXVuWzh
         XCBw==
X-Forwarded-Encrypted: i=1; AJvYcCV8lVZU1t7oybzaPVQsxULudY+mSzN9c9ozAmEq1H6x/S3ohW8C1w9rsxxbKXa5YF1mxluaPjIzAiapN78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQ4ZKhxD+dTmXGGUn+T0bkQ4TX4OkeyJN4mqogpS4b4OWzzeg
	z0tMC/jDdgCCc5tH7jUnf6eNMe/jMHr/HPzX2Bn2EXAX62vd7QKL44lb
X-Gm-Gg: ASbGncuY+5xos2qhkq+Y9fwpHqpbq2bgAoXaLiqzmWZyyNsov6fG4ZKS/JPTU/q/Cy4
	Uf7c1eAO1UG/vV0HcJnTrIWg+R0qOl8f0xDi6vXu1CqDLL0y/KVQUaDQSqhcYmhmp1dBHd6lmgq
	9cXwxJiT0Yp45zPWRJGXxg0+FToP6aGhzoPcMZqa06q63SeUA+aCRMssqWqyyjTRvmIdzKX2YOU
	o7aEo+79RblD3gZr5NRafh9sIt12q/Hf/khuCgd+dD0GI2otj4HSRUbqMu7Z5dULKrCgnPxgfsB
	aOTFRHQ825uV6oUoiecT/roMgThaLDOy06dCjlfeBBPAb0+kj4mN3SzgzV2+SueIy0mZISMwjW6
	tLlADzvcT/psh4t+VXLM=
X-Google-Smtp-Source: AGHT+IG6aUD2BXk367svr6qPDDtyFsE6lFVvuUPRjFT+LwrXe9OqmErDCeuBdEpr9uAx55UpJqgzdw==
X-Received: by 2002:a05:6a21:3283:b0:262:b539:b889 with SMTP id adf61e73a8af0-2927182fe2bmr18289538637.40.1758535033614;
        Mon, 22 Sep 2025 02:57:13 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55283ea850sm7286870a12.13.2025.09.22.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:13 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: jolsa@kernel.org
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
Date: Mon, 22 Sep 2025 17:57:05 +0800
Message-ID: <20250922095705.252519-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
Therefore, we can store the "is_return" to the last bit of the "data",
which can make bpf_session_run_ctx 8-bytes aligned and save memory.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2360579658e..b6a34aa039f6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2269,7 +2269,6 @@ fs_initcall(bpf_event_init);
 
 struct bpf_session_run_ctx {
 	struct bpf_run_ctx run_ctx;
-	bool is_return;
 	void *data;
 };
 
@@ -2535,8 +2534,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
 		.session_ctx = {
-			.is_return = is_return,
-			.data = data,
+			.data = (void *)((unsigned long)data | !!is_return),
 		},
 		.link = link,
 		.entry_ip = entry_ip,
@@ -3058,8 +3056,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_uprobe_multi_link *link = uprobe->link;
 	struct bpf_uprobe_multi_run_ctx run_ctx = {
 		.session_ctx = {
-			.is_return = is_return,
-			.data = data,
+			.data = (void *)((unsigned long)data | !!is_return),
 		},
 		.entry_ip = entry_ip,
 		.uprobe = uprobe,
@@ -3316,7 +3313,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	struct bpf_session_run_ctx *session_ctx;
 
 	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
-	return session_ctx->is_return;
+	return (unsigned long)session_ctx->data & 1;
 }
 
 __bpf_kfunc __u64 *bpf_session_cookie(void)
@@ -3324,7 +3321,7 @@ __bpf_kfunc __u64 *bpf_session_cookie(void)
 	struct bpf_session_run_ctx *session_ctx;
 
 	session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
-	return session_ctx->data;
+	return (__u64 *)((unsigned long)session_ctx->data & ~1);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.51.0


