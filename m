Return-Path: <linux-kernel+bounces-764386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E0B22262
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0AA18837D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A252E7F0B;
	Tue, 12 Aug 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jl5Y9VlQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4602E7629
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989454; cv=none; b=tsUgOW/iUfF431GzGtARftJvTwNyc/tyCpJtInmwzFBXkBDvDT9lu4JBBOUWGxYglxUStLtdav8reE5aqy4MMOlBqDpRNQwVdORTo2srnG01P8fzmc7slZvRAdE4yLLtfsB+cfwdVSKFMb6CHYZ4zIaWmTvu1Hkk5MDQz06wDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989454; c=relaxed/simple;
	bh=jX+YEQB0b2jg/94uudyOzj3RkscIhZDeVVogCJzZ67M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrLdkxRXWyZ3aR7vCIaJlEY9mpUMMXrmCBgoe3/sPPsV0cS/NKeJ9jhJm4vcJlV3vy1ISML6r3B3My7vnbgwypMVrmk1awJub7N5eXhMZ3eNIxwld+DmqKS2oDcw0bmAFzmXEn7yD4rcisLBHNFYUn6zOnsd/TGgotbNBV7ASs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jl5Y9VlQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-456127fa3d6so7959705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989451; x=1755594251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=Jl5Y9VlQtRQgQ0wZapz6JmbwaoLFP6lFy1uOBPSW6zPTVaSiKkYXXB5/Yhgdk1f51I
         aGHyOg6b4cD8a3Kr7Ltqg58lvN+v4yVURDZMvVqtbPkIaw3tKOPS79iH014g3A5A0JkP
         Wxlpf89JlXrZlcWb8ktgo63426JPiVwEdADeP2uBM7vGnck3b1cZCsZme+0fdyfH0amo
         4TJtqmOuYApTj/a32MhsDZ6q9cKshyt/wnYvQlLGX42XnybAOXYgbsRvjsQPwNYum9TN
         OsFDUVTpnM5jppqVIzV4necufmbZruyzAhpGOmYdU+A3roIz1SWpvAEgdYX+XbURfzjB
         HqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989451; x=1755594251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=xU3jfqm+ko2N9w40lsQPvW4xXeaeHCD/EYKfMPDTkzWzhjpHxFKxgH3LAIIlyzhZkc
         U5OKAjM0R0KcWGRxUiFfAjBvvi87qijdue2nwS6cXoZ2c/TVhIatZLqqP2h1J2TY+j/0
         e82/H7p+8varoM3u0kxCP+xH4H6rmQA9MW5xmgrHLKY/YsImOqlSjBGhcVmrttos/6z5
         fd5S1/E7ZZ0TOkK/UtN9SndsH/Eo1Wrb0XGWHDYP84LBvpwoq6i2Lwo4r312KULntlrP
         Rek1foZlL0oDcY1ZBGKG9aSdW6y7cdrBXqi9jAle7mtw86NyeaW9se12siaUhs5JFSuq
         XJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWUzNrbDF02hqROP++L1YxF6cJ6zCLCFEg9dn7pmGLz56IZfM/3iqTLdBoxcIqpa9OLGtw5fx004LGjdrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zpMtbhPuWuOB34Etks6LP0iQd+C9TnrNEyUrr2XV7R8uWNAB
	IGjfVDqzxXI/3KeuIIyCI99Q9LZzipZ5aa+U84OvOEq0LvlCvurXMeeXFc1/HQF3iXQ=
X-Gm-Gg: ASbGncuF2PQoCE4Xus/OsMFvvFsuZtYjKe6Oeh2FWjSsHJQhvhxbtouWK1gF3z115qI
	ZbQORzGBEIVebipE/UNfCYD460HBCah/F01RWetjf5Ft/+JLhPEvT55Ir2QYGmHmE9AJrcpVhGm
	XrVXLnfq8QQ7oq0CtAeoMhcjARNCunXLNDsr05SCrgfw4WN/ZihVC05DOUV7Dfv5dBH5JEI6G82
	Wyk5E8q4QAr2Hq0PjO9em3muZrenR9myDuwHlmiS/VILuTb2RM0UP3z+2M7XZuditomIzd+2ZEl
	G3qNXMDtpjnretrQ/GndVcrcy/7FDr8oxP9VvRrE35dV/1hry6U4G+pI59FfUW3JccJbjVyqLbz
	DFjzQvaIDTV+Gtz9HzPO5ReB3BN2dWw==
X-Google-Smtp-Source: AGHT+IFBefRRbVz8mjWqcsAPH9QQgYekCVsZTS4QORs3XTzsM/mOl+JX5+dSUj2YaHIFPPZ1EW6gKQ==
X-Received: by 2002:a05:600c:608c:b0:458:a753:f3a1 with SMTP id 5b1f17b1804b1-45a1404e5b0mr2724695e9.3.1754989450650;
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a053a9019sm104340625e9.21.2025.08.12.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
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
Subject: [PATCH 2/2] riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
Date: Tue, 12 Aug 2025 11:02:56 +0200
Message-ID: <20250812090256.757273-4-rkrcmar@ventanamicro.com>
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

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 6e1554d89681..9883a55d61b5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1763,7 +1763,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			/* Load current CPU number in R0 */
-			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			break;
 		}
-- 
2.50.0


