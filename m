Return-Path: <linux-kernel+bounces-888525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88DC3B0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCBA14FF61E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946333DED9;
	Thu,  6 Nov 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIC/eUSF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66604337B8A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433626; cv=none; b=NEn79sqrGRtmgLgjpzrHb7po6qny/q47B3P1CJgQmIAKEJGInSn9j9VSeVbmc7jI42bXyd6mZ9aq2grRWVXK8rttR6SvGYPHZOrhIb4y4KbzFaikezeU8tkAGg9rhOyP0lNXtiQGKwAJ4ABcFiFEzd9l8qOw4Ood7cUmajy0krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433626; c=relaxed/simple;
	bh=7aRplSUW6kRxQPV1HlG/HN4UwlXrr6wHRd070gm8Gy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOhuQ9eaUZSfYpaqEaXYnw4A7m8uiA7WE7QWTFGVUV4FBxP6RL+P15GDYbZ+INTyR+e/cnCXumYpGXvcq2lfpl0uQ3LlNUCvuh4wrwQ8Vg9G17kPnyMcOHoFoG3+i4o8yxVpz8njy0k1gY+fOnkOaSmsqkdKXdLBcArvE/dZGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIC/eUSF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so643270f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433622; x=1763038422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3F/6Pnt47lpVjXos7n4gvnzZgK+tzG4a7nXCFmIfgo=;
        b=FIC/eUSFRkr68T3/WrgHjrvM1/YhYI/DYHAjvefGMgJktSb/zwNXg+7BQjHvkYKWqq
         1JYxNOpTzZm7I00RSs1qYUSFv51TdDK6cutj0x3HW6SdQmd+9LVWwHCnoFTR+OgKHGfJ
         EOywxGWAYX5JEdRgNapQbhpld0zFbKEaXPm24jBs5+fi0cO3umLwP6P3FZIO+syfrNhm
         ScxEh6PKz5e/C83KXYwhHsrxotC1//MLpF+Tbn4JNmVLKdUc6FXEhL5QYz7G3FIlUP7s
         uhrZRzfC20KDWdw5Yvw21iTo/CxTNCFX2PI94C29ryCQ9peC+u/x0KJ9dLZcrip2N4Uw
         6uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433622; x=1763038422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3F/6Pnt47lpVjXos7n4gvnzZgK+tzG4a7nXCFmIfgo=;
        b=mXds5BNVqX/WHZ/cHHdgzm70ubnxoN5H7FadZoXVNa+yTD6ZcORTB5vXmZPtlfrV2W
         5/qeoxMur1kZuOJ4xMRY1T3i9J6M4PqwXhE8VW7Zi0OYG9rDUBIMpRDDwnatrVjlW++X
         sP7FQqYZ0PFtJG4/2D+Ce8DepOjcmz2EBIdDVpCCKl5dS2+FVAzyBB8nKKwPjWu0r0PB
         eWi2WmwaOzl7Wb0hylg4EPCFcBvF4S0BoJvSlnK6SvkBolzJwfdp4+yoJ0/RxXC56e6b
         k5XsGJmXDvLp1uUPmhX/00JH1mRi/ziSVKBBhvo5dCAbCnUokXlhRRg7VuVDttK4T11P
         8QKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrJU65k5P/XP5axYL5ZTKq9qLcyCJW6+HRxNBEMMkUtdqpjfH1sClxbuv9BUtSQoownbwJoig3MxOaKKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVcWsU9ctzcH9oYSOW3h29veyah8789a/gzUShx0eaRRd+Gq7
	LIybDzZBRAbDXe/q3HveldqzzwHBuzl8OuIdUTOjCanspwbkdwkWqSM=
X-Gm-Gg: ASbGncvqCmOXhBD9GlZ/iEwWI69rlpLM+tCk+QR5pPTKZhw3ie8UdEufOvw5yZ6qrOx
	IiTWQjsLHRzouo1hYVeLsoeD8waV3Q4VSjw66ExRt3Juntn3oAhnzfpOXW0hYANeZTbidDPHwDR
	BY52wJWeE4vO2ALM95Q9JQdbRk/q8iVl07fr5UmlipMl1vaV9UTNJucsTGK6PwEeSXaJ3HDA/We
	TuxliXL8RZoa1TnvNqe0AP3rgsDfhamdpM2pvCstui7sNDOmxSFqyiGeRjB7nAxCYg9OiGq3LPX
	o8lhgZw9Pmy0/bPpmKAEXIISRGtt7prZRqZQ257z5jlXKAKd0/GDx9TjBhQ7rLDUIuoYvySw4R0
	JrEF9L2H0vmWkIuxW6/RPQ//LP31LVC+2lyA7L+D5qUdM88VCIwJHyTL6NZWqFKz2NfPyZuUdfy
	FkJP7hr38t5c8MNS7TIr2/JQnAYTpbfom37JSWbBaa5gnjBRhM7N2Kl/Q=
X-Google-Smtp-Source: AGHT+IE5q5ICdDDBK7g4wnCXX0jnjR/QAHVpDJVspbKXccSBPyw3RSDN+ilC4Bc2cp04IBzrsLidPg==
X-Received: by 2002:a05:6000:615:b0:425:7cf6:5b9e with SMTP id ffacd0b85a97d-429e32c831amr6689558f8f.3.1762433622302;
        Thu, 06 Nov 2025 04:53:42 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:42 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 11/17] bpf: Track stack spill/fill in bcf_track()
Date: Thu,  6 Nov 2025 13:52:49 +0100
Message-Id: <20251106125255.1969938-12-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track symbolic values across stack spills/fills.

- On spill (`save_register_state()`), if tracking and the source is
  non-constant and the spill is narrower than a full register, derive the
  appropriate-width for the spill slot using `bcf_mov()`.

- On data writes to stack slots (`check_stack_write_*`), invalidate any
  previously spilled pointer symbolic value by setting `spilled_ptr.bcf_expr`
  to -1 when the slot is clobbered.

- On loads that coerce value register sizes (`check_mem_access()`), if the
  destination already has a symbolic expr, cast it to the loaded size via
  `bcf_mov()`.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df6d16a1c6f6..3f2981db1d40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5286,6 +5286,10 @@ static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_
 	*dst = *src;
 }
 
+static int bcf_mov(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+		   struct bpf_reg_state *src_reg, u32 sz, bool bit32,
+		   bool sext);
+
 static void save_register_state(struct bpf_verifier_env *env,
 				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
@@ -5295,6 +5299,11 @@ static void save_register_state(struct bpf_verifier_env *env,
 
 	copy_register_state(&state->stack[spi].spilled_ptr, reg);
 
+	if (env->bcf.tracking && !tnum_is_const(reg->var_off) &&
+	    size != BPF_REG_SIZE)
+		bcf_mov(env, &state->stack[spi].spilled_ptr, reg, size * 8,
+			false, false);
+
 	for (i = BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
 		state->stack[spi].slot_type[i - 1] = STACK_SPILL;
 
@@ -5437,6 +5446,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* regular write of data into stack destroys any spilled ptr */
 		state->stack[spi].spilled_ptr.type = NOT_INIT;
+		state->stack[spi].spilled_ptr.bcf_expr = -1;
 		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
 		if (is_stack_slot_special(&state->stack[spi]))
 			for (i = 0; i < BPF_REG_SIZE; i++)
@@ -5566,6 +5576,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 
 		/* Erase all other spilled pointers. */
 		state->stack[spi].spilled_ptr.type = NOT_INIT;
+		state->stack[spi].spilled_ptr.bcf_expr = -1;
 
 		/* Update the slot type. */
 		new_type = STACK_MISC;
@@ -8025,6 +8036,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			coerce_reg_to_size(&regs[value_regno], size);
 		else
 			coerce_reg_to_size_sx(&regs[value_regno], size);
+
+		if (env->bcf.tracking && regs[value_regno].bcf_expr >= 0)
+			err = bcf_mov(env, &regs[value_regno],
+				      &regs[value_regno], size * 8, false,
+				      is_ldsx);
 	}
 	return err;
 }
-- 
2.34.1


