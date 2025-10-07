Return-Path: <linux-kernel+bounces-844203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBFBC14B8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 152D634E8D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CD2D94B4;
	Tue,  7 Oct 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDU9J0+H"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3E2DF152
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838338; cv=none; b=Tu11/MCMFCrtidH6/D7XwVnXeZGb1h3QH6DMBZEyYI4g/3JJWfslNBhRjIYQ5XCbDExuxGb3qxcXcc6ZOB7Ul4gRELIor1IaIYYQ1gG4O7hgn77F7iAQ5jfRqTbGOBVZsPbJA1RQyqZSSaums7q/IwDj8GT2Y6e4014ySOU+cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838338; c=relaxed/simple;
	bh=uXkrELMKCfsRaWYxU5mXegkCFCKgEu54miTT0hVrswo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXmzr9IE0dq2hlBQOWVs4xqH8xelqkYtIULqsbKZD3qeOaLiGRJand3CSCKJS7gOIrdCJ2yK1zZ6bRLnMhAF/iYUIJjbwf0XIt1lc4lj9D1ep6SX0JkSZWGRgdcAc7aIIpq8Sr1/1mXni5v7QpxVn36SngmsmSBrxSGDJtztlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDU9J0+H; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57ea78e0618so7000669e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838334; x=1760443134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ut4udALSNwNlfbYZc3Tgg1u2DqNTE4rygUYw4A2JFg=;
        b=QDU9J0+HvLDTZFrUrxoR8FB1nkf/ZkGjPW44S+i3PaYQeb7HEW4FocjEy9Uv+tw8jF
         DhoqQ9qqdOc0/jOuxjG7uJmToTjCshsTS7P1KuSGmB/uW65kfBzdfMvlcT1T/o3tjB1S
         dST4XqHIh8hEB5pCMyAdv9cjDDubZpQMNOD4Vhh1e7FILBH4oPdwB3r7D8CtZpgxBeQX
         YconBVbJgmfJldBTWBhIj6gzTBG/zVu1/MGFc2x4iL8bm7kkiWRrq5JKAO0pDEoq40oL
         LRKjS/KemIyVqAUVNLt8TsVxh+9aP6aNMdWrNN2uwL4i5AjueDB3xA5iJ+PNMsCNi5nq
         /5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838334; x=1760443134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ut4udALSNwNlfbYZc3Tgg1u2DqNTE4rygUYw4A2JFg=;
        b=Wei9XW4k5JqVekGLPwT8w/nB3e9n9Z+Kn+ptla6ax4WFCh7gY+jEunYhmdjC1QF+9/
         it/BvrqlzrvLx+ic4HGlaJn+ap9sVuE1GzEHmvXIOGhistZ5/11qyhmtCH4PXcdW5vUG
         zmXqvFcy8OEIlo1WOBQr9a0MUdXD6zS1BsjTpzaJx3wCsh14Qaiy75X83en3fzOdFTuC
         12b5ezTgMWAHgc2MXH3xiohKlXkZxAqiRf71J2NguyzGPrOfDsYDsQab4v7itgsxOZ7K
         b6YinXtTQ0lBthoE7tGfT5Nxm07OrIt+NQDEK/VwBJ3NwSCG5dfVhyUupaPR++OVMNr0
         Bjbw==
X-Gm-Message-State: AOJu0YzMEcm87q08i+FjQxz9HWvGaHpd2EvREc2+mBaYm6DVuo/KcwR9
	O3rqMZHtZoAVWCkvFrA/DENZt5ZbOLCYtwTe7PGmt80jsLRTY554L8Dl
X-Gm-Gg: ASbGncsMwfYkF4c0zEt7V9YKv6jHZGPcxsGV5OO54ujbDQjn4kG5LDygg7xvPhha2K6
	R1ncyLRPDwi9jpV/tdasTHnc7IXaiutNooPi4QpC9j4Vd5OXp/PeOCo4c6WlWgwX1coL4oBYaMq
	GQc6yTgB/0LWIuamlClKgSZZqRti4dL6tSZsrJL7jtB63GukuN+0iNHC4YKaLy1tWqvsiapvX+L
	QpeNwsVTBqC1fsU1szSiSBcLsReKWRxBBsjTeUW1rC7INdmnWw1Ok87reHou6+oEg9A7gyPlWEs
	PyLzDJ5UrXzyO5IKwumneWd0W6NHfG0fuABsL7Ld75LjKwwP9/MuHgn6bUeSUeUq4eU83G0mpzk
	pN+SgEIUrREVtu4jwQEf1jRtLrKoWgeLPLhD3vQ==
X-Google-Smtp-Source: AGHT+IF9hiTWhCe1Oqso+uN0BybHSEh0X/p2CShjwG4LdtO5K/sFgcxScdEgvNjZD6t+gVwSik5F2A==
X-Received: by 2002:a05:6512:3a92:b0:55c:d62b:d0fc with SMTP id 2adb3069b0e04-58cb96631fcmr4719071e87.10.1759838334241;
        Tue, 07 Oct 2025 04:58:54 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:53 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 6/6] riscv: vector: initialize vlenb on the first context switch
Date: Tue,  7 Oct 2025 14:58:22 +0300
Message-ID: <20251007115840.2320557-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vstate in thread_struct is zeroed when the vector context is
initialized. That includes read-only register vlenb, which holds
the vector register length in bytes. This zeroed state persists
until mstatus.VS becomes 'dirty' and a context switch saves the
actual hardware values.

This can expose the zero vlenb value to the user-space in early
debug scenarios, e.g. when ptrace attaches to a traced process
early, before any vector instruction except the first one was
executed.

Fix this by forcing the vector context save on the first context switch.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/vector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 901e67adf576..3dd22a71aa18 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -120,6 +120,7 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
 
 	ctx->datap = datap;
 	memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
+
 	return 0;
 }
 
@@ -216,8 +217,11 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 		force_sig(SIGBUS);
 		return true;
 	}
+
 	riscv_v_vstate_on(regs);
 	riscv_v_vstate_set_restore(current, regs);
+	set_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
+
 	return true;
 }
 
-- 
2.51.0


