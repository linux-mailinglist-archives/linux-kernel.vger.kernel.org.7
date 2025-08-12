Return-Path: <linux-kernel+bounces-764385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27BB2225A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3919189C2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558472E7BA5;
	Tue, 12 Aug 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g+0Y/5nx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2312E62D8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989452; cv=none; b=hopzdhuCiOtar60uFNJ4qABFEGnTFdaP5X4HHKkEAwiz0Fl/4OHSASfnadRuubeKVVmzh9CePPzspXB+fLgrK/pSIrBgY4OszmY41CG43xOKfBtkPuR+t4o6IGeIMFo7Kx/1HDDkmE465O6rnMRTMQd2fd7cv/qWdZWv4XkjPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989452; c=relaxed/simple;
	bh=E5jcBn3sV2aUmuDFeWJOAnGKn2umqAnu8zd+iJy0J4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeHGW+WoX4m8n9VwzwotYoPkIfuY9IIFZCiQ6HfVylHAzJl5ox2PtUwdwtb7ts8cpeLM2ETzVfIEpRI3C2K+aLKtPqWnXmZ0rl7OLmuUr7ixp0j6vKcup9I8doW5iGv0VgsBKOgcVJ5U6tZYy4AC6a0n/vAbHsV/3W8G16bTItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g+0Y/5nx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459ea4f40afso9381435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989449; x=1755594249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itAcwp1tL7JmEvs/VclPDqKZmFhrZKHjpN5MTKoCPt8=;
        b=g+0Y/5nxI1+6uP6XdS3aPL4AeXdC1cEHVM68osydwLIWeNx/8Np6qZ8JpmBcC6EZX2
         M/tFhL/EAsPQlqdqR2Mmep+eUN8qmjY9D7y9uMXFkJ52y7894mJMcCWqFb4IxwlWaHIM
         3anI6IZMb5CfmV//P+/MkLJXU1sE85hZ685H7QmqnEsrW4XM7i3p8oNpG2KMe3gHhv/8
         od29EXkFggrunFq7XfDDj+pfCO2yrcZDe0kXgK/oOvt08FfldpigfLg50QeFu098P50r
         i/UmuD2WBookjo80ZG3ILwlnH8wxrynGZ7O7f8u9I7yPJ9T+BygdTZYkpB1zCWK90tCm
         G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989449; x=1755594249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itAcwp1tL7JmEvs/VclPDqKZmFhrZKHjpN5MTKoCPt8=;
        b=kiyXKzQFC+DqxAd4QMju707ql73ONj5+nEL8zOU5Ez9oRMUPF0iKZsAzwugGRT+NHV
         gGI7IN1rOgaL0ahjGdsB+Igao7F7T7vraOlQA2TuFxanvP5y1b9MWX/jyY213HnNOWBg
         CbODFgl+SzU8KBGrzOvk9zwL0/dbab6eqYpuaTaRYwq6aV6k4PO9jooUS57USnZz1feg
         YKiNBXiGqXZqjwHaAWIFhe7vc1RoxC30Ewp739ZaZpyvtzzhvQ58VhHFYUqBG0N5fuQu
         Gn97KCrbWZV+DXqV266y+ddyxb+VaERqDkHD4/kwoPTNTFGyLC4yu1gKX5AlqohlOCxc
         5h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE5MJO+XpedJzWVNI0S/Cgd4D/CiKhT5ztcbsRcfa6r3pO+XMBCg9wt7iJ8GrVg9FQGFBBOSwdnXPuLyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4MUoYYzp3iz3/WSMZvKwcYJfap6ykUtiq0u45k7nN0bvj/Tz
	eFjmAvXDQj3b/mr/9uIH+wSUtVj0yOvMmSxuH/bvgLsX0z6KYrtPoquEvvxaDgpNdSo=
X-Gm-Gg: ASbGnct0YP1f+bV4tWPIVkPbl08//4FNeUjbZZs1kL2AePvxVMUHHDeCHp4NjXc2fLo
	UoznLDOajzvQXbaTQygxZPDPEgxs51+PQwfOwHbAhmBcFHeTmExaT64hg45coH1WzKQLVbixaow
	PM68UkO3nNwH01Op6A+n8vxoULkJf8V246qx70xxOSXa72eqKU5Y9AtK4/fkTouZCeoxiqwPpiP
	wplU6DoyYsPBA6k3Gjh9cTgLm0GNQCsgyP9pjipykhGWrD8ZUwGorhwKVJFrN5T8jkX5C7tPEmU
	tT6bM6theYlM+IROZMApiU7w+SNgCi0eGHVihI1cXFdwBuYOjnavzsmBjs1X3PohjvIlLAOOz4r
	D0gdCPdU71sTofMnLio7tkMkbJJyu6A==
X-Google-Smtp-Source: AGHT+IEKfx5/IibgOl7zdUM/KxazaaZ9Kt824Zr9oOR+gNUohGNLWWuXxmaBUI2dt+CetFzava53Sw==
X-Received: by 2002:a05:6000:2c10:b0:3b7:99a8:bf6d with SMTP id ffacd0b85a97d-3b9142bcf85mr298562f8f.11.1754989449200;
        Tue, 12 Aug 2025 02:04:09 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5887b7fsm287090205e9.30.2025.08.12.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:08 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
Date: Tue, 12 Aug 2025 11:02:55 +0200
Message-ID: <20250812090256.757273-3-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

emit_ld is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: 19c56d4e5be1 ("riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 10e01ff06312..6e1554d89681 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1356,7 +1356,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
 			/* Load current CPU number in T1 */
-			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			/* Load address of __per_cpu_offset array in T2 */
 			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-- 
2.50.0


