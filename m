Return-Path: <linux-kernel+bounces-736378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32AB09C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9BAA80011
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A18218AC4;
	Fri, 18 Jul 2025 07:14:19 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0D215043
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822859; cv=none; b=N7ASUtQzQorZhX/zQRqlurqJmxj5UZj51PIkUye3xOuZYKAoqIO5uiQ2ZUonJwCxow/XcGP7zG3O18sjylugsvP0tvKg6rNdzi6DTuQpsZvjCfxx9pvlv42KdLHpExsfXcPxJNy6rpDSf7tfmY8KaEWEYcSp/x/ckbjdc0Tnq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822859; c=relaxed/simple;
	bh=UkY8E80JqoRe54HrCdpYzLB8WKG3Ltq7hxZXSW87Tkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efdcOd0gTUHzUCY/TYWJUPH/Bo2b9Pqn0wOaC4CIO5QWn9T2w3YGqtZ+tRJ2aT6fxrg2oDTaIRV/93r5iZll00bsdfLJTlQjnrI1W0XaTwuV5w+TplxVwlOIF+AppsoqT7yaLFPwpToYt/9HZQSSbbsLPxTPfaDFqMIjLRoWSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <sohil.mehta@intel.com>
CC: <aruna.ramakrishna@oracle.com>, <aubrey.li@intel.com>, <bp@alien8.de>,
	<brgerst@gmail.com>, <chang.seok.bae@intel.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <oleg@redhat.com>,
	<peterz@infradead.org>, <rick.p.edgecombe@intel.com>, <seanjc@google.com>,
	<tglx@linutronix.de>, <vigbalas@amd.com>, <wangfushuai@baidu.com>,
	<x86@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix potential NULL dereference in avx512_status()
Date: Fri, 18 Jul 2025 15:12:50 +0800
Message-ID: <20250718071250.36019-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <89987231-37ce-4d49-a1d7-6e699e8ab0d2@intel.com>
References: <89987231-37ce-4d49-a1d7-6e699e8ab0d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc12.internal.baidu.com (172.31.51.12) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

>> Can you please share any other warnings that were triggered before this
>> Oops message? Also, I'll try to generate this locally. Any specific
>> configuration needed for reproducing this apart from CONFIG_X86_DEBUG_FPU?
>
>I was able to reproduce this on a system with X86_FEATURE_AVX512F. The
>issue only happens while reading arch_status on a kthread.
>
>$cat /proc/[kthread]/arch_status     => NULL pointer exception
>$cat /proc/[user thread]/arch_status => No issue seen
>
>Can you confirm that you are seeing the same behavior?

Confirmed, same issue here.

>Unfortunately, avx512_timestamp resides within struct fpu. So getting
>that value for a kthread would mean going through x86_task_fpu().
>
>I am wondering if we ever need to expose the AVX512 usage for kernel
>threads? If not, then we can do what you currently have but without the
>CONFIG_X86_DEBUG_FPU restriction. All kernel threads would always print
>the AVX512_elapsed_ms as -1.
>
>However, this would be a user visible change so we should probably get
>more inputs. I tried this experiment on an older kernel without the
>above issue. Among all the active kthreads on my system a handful of
>them show a valid value for AVX512 usage. The rest of them all show -1.
>
>PID: 2594
>CMD: avahi-daemon: running [SAP.local]
>  /proc/2594/arch_status content:
>AVX512_elapsed_ms:      46032
>
>PID: 2729
>CMD: sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
>  /proc/2729/arch_status content:
>AVX512_elapsed_ms:      396656
>
>To keep the older behavior, we might need to consider moving
>avx512_timestamp out of struct fpu. Though, I am uncertain about its
>implication.

I think avx512_elapsed_ms should logically belong in the FPU structure,
as it's a field inherently tied to FPU operations? To keep the older
behavior, we can set CONFIG_X86_DEBUG_FPU=n, maybe?
Is there a better approach to ensure kernel threads always correctly output
avx512_elapsed_ms. Directly get FPU struct pointer without using x86_task_fpu()?

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..f989bc125e9b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1859,9 +1859,10 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-       unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+       unsigned long timestamp;
        long delta;

+       timestamp = READ_ONCE((struct fpu *)((void *)(task) + sizeof(*(task)))->avx512_timestamp);
        if (!timestamp) {
                /*
                 * Report -1 if no AVX512 usage

