Return-Path: <linux-kernel+bounces-893297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC18C47035
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57C9189024E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40F3054E1;
	Mon, 10 Nov 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR29Dl4K"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD1303A3C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782550; cv=none; b=ASZC8ZRsP6IpM4wgv2ga0ocZ1qr7EEithr/zH0K0WxOFiXVQ131fy/0UZSMDBPpNrIID7HL/V1xp9FFXVEzcUphl8w6WqfalSau6fhuy3ac6/wQXIvcMnz/ULgYqTN8GxJiGdj2of05SZMk3sjFTQRUVK+R3CeKNXcifoWWX/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782550; c=relaxed/simple;
	bh=TQ7h6Mz2s/JbJILiZ/3bEy00deZQ+pPh63bYADHti9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2O1MStfOV7lLS8oae14KOwFsZCxTPgd+6996ymLsVrs+2MI1zeQ+WnaLfnjGvou0/MA3PH+PDWI/70siYe/ckKOhy6mpVOMPP1cTYNiTNLAhhbgg/jFR9Qvu7cREfMu9Dy0tQDxSLKrZ4NuDT/jLD73PhyiKndxMdCxDFlGj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR29Dl4K; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ade456b6abso2510058b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762782547; x=1763387347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=ZR29Dl4KN1Zo58bbUU+Ac+1Q2bFeTsgjFrXYOD5LbL4xxNITq8aq24ahp49uM2fZxs
         /+2Kko/5gsbrtw+oEcjz+feHL5dtKEzTo5c4yjM2ezHFKpO5oDthn8AXoAIvfoRsGQE4
         dnas0Ar1lNsFT00QPcBGPPvDiLWWFTgfbuUfeOUv0VTmSIM5lYazX73gY7XYMtjWtFcC
         9J3qho6jmbnhW/yrtS9yxwvpPK+pijgUWmhtO9nYYVprrGl29hN0jDUjcwhUSKtF/gPY
         yacupPyZOz7vOG6oG6VuOeLtNquK6YOBkDsm8ayJ7Db7Jy4JTDm6Qwvsozp66UmkY85G
         u1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782547; x=1763387347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/QXwQnS4eai1OeNWeo93T9s/bj/XOu9GVduo6Pa63U=;
        b=nkLYecsIfwJfH+3zvF6rUikbQljpAeNuanjXC+fSQ4i/it5jjLb0y6iqA+7jROdufd
         sMaAbqrM2cS203ASf5ipcc0hhMJuVhZ8k8ZwF6eByJrt3/0MC+dq69bCK/ZpmSMtJHhR
         UxHQNQAv1FlvMTAq3ywPX2/0aBhyBI4uZHMKxgfyvmw/KHzDmL2kWQuNChNxuPx/Yc/C
         2KX5zSTJr1eN0xQNPx3LM9tG3LJb3FAet6BdzBsOgKA0P0L+bEYrKgZRhXtPPwuveL+y
         Z2WDj3hrWuSdCGwTw5PA1wGOdPUqgWCAhg6jRNXh+m7c/FdNPYHQ5VHVKUTXmusFvxcp
         M0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUJmqoOXZtkTjtKEiCC0d7B8Yzle2ZWILygarWABna9SOCmUpu4rnnUyUvrTFhtlGj5sdWCnDIpEfRIapo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpmed15HleghQy6MnPE8ry85LPnv6PGPV4FEt6DoehudFkj1dR
	x8cWQqbGvYfvDQH5zkhaCZKZXBKG3bebBuq+LEC0WpN4DrPdtGaYPJpF
X-Gm-Gg: ASbGncsKXaMLiCI6PdGwouFcdiY7LeguL3aaTRAKNiiX6EwEZHU86QLTSOFcHkYhexC
	UF3aCdvMeyKgTS/gbjksoX6ea7nDjYJnInWD89NJm0tliZHiqSRX0NCe3fF7Or0XrvZyECmaUzF
	nsOAFI2GUBS39zKYTAZVFaDXEvbzaRjtFfeNPyt3YL/xX8+BHYGX4DYIzDbDI9nxOkaxljv8VCG
	Hns8cFG2/vVd0QimtEE7me2GBVa9rkCDMKnNl6Bq/63MCkiF23hcCYeuW8tmpcH3TIgc7Ek63gr
	PKYsZRc2lrQ4dlcTfvykVz0M/BT1p5KTEpPSTzMapwf1itNchuYZ1RMWKqq320CjC66O1DpwjCz
	u46tsmI0v5owc+JvIu2X7KQdeBz8/Lj8HuMU/OwAv6plMi03l5OKzW00qohDshFANNHaT1XwSPF
	D/KgujvR8be6g=
X-Google-Smtp-Source: AGHT+IEoH96+sjPLREqC+n2bvCIzOJwtJGtj0Xw/w+23Qs6yfYObqzh3NEEEQcrylABhRl8Rgvzm6g==
X-Received: by 2002:a17:902:fc8f:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-297e5413468mr105009555ad.7.1762782547210;
        Mon, 10 Nov 2025 05:49:07 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccca64sm146648475ad.105.2025.11.10.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:49:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mingo@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: simplify the kernel_count bench trigger
Date: Mon, 10 Nov 2025 21:48:58 +0800
Message-ID: <20251110134858.1664471-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the "trigger_count" in trigger_bench.c and reuse trigger_driver()
instead for trigger_kernel_count_setup().

With the calling to bpf_get_numa_node_id(), the result for "kernel_count"
will become a little more accurate.

It will also easier if we want to test the performance of livepatch, just
hook the bpf_get_numa_node_id() and run the "kernel_count" bench trigger.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/benchs/bench_trigger.c        |  5 +----
 .../testing/selftests/bpf/progs/trigger_bench.c | 17 +++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 1e2aff007c2a..34fd8fa3b803 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -179,11 +179,8 @@ static void trigger_syscall_count_setup(void)
 static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
-	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
-	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	ctx.skel->rodata->kernel_count = 1;
 	load_ctx();
-	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
 }
 
 static void trigger_kprobe_setup(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 3d5f30c29ae3..6564d1909c7b 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -39,26 +39,19 @@ int bench_trigger_uprobe_multi(void *ctx)
 	return 0;
 }
 
+const volatile int kernel_count = 0;
 const volatile int batch_iters = 0;
 
-SEC("?raw_tp")
-int trigger_count(void *ctx)
-{
-	int i;
-
-	for (i = 0; i < batch_iters; i++)
-		inc_counter();
-
-	return 0;
-}
-
 SEC("?raw_tp")
 int trigger_driver(void *ctx)
 {
 	int i;
 
-	for (i = 0; i < batch_iters; i++)
+	for (i = 0; i < batch_iters; i++) {
 		(void)bpf_get_numa_node_id(); /* attach point for benchmarking */
+		if (kernel_count)
+			inc_counter();
+	}
 
 	return 0;
 }
-- 
2.51.2


