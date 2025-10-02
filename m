Return-Path: <linux-kernel+bounces-840115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD68BB3923
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A033D420341
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D52DC33F;
	Thu,  2 Oct 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h/jMcbZ9"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923452E8E04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399917; cv=none; b=HDKoScjRjWPYbYDvN8h5SxEGYJzjxnPrviOHjUsZmeBh1FObfyJMwPrFgWn4lWhFEGZ+1FizftW7roWrboVEWEi4dBd+2YiYsD8OQPL1XhfI+HwPrSuc1TtZxTwD4GCACX8oujjDU5BElwHk95nLBb3npJJg0I6WoMgEpnC3OS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399917; c=relaxed/simple;
	bh=3DZGPUVfINzn9M18pJFNdHGKgILIpIG43AKZLu4U4hk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rO96pK9v+RNnWaOJIIZsXUNzLcMHw2yKtccZ5kl4wYvqHDJrs5V0ex5bBu0oK4Ji8FtU1M7vtiJtYTlReb8z2AQGeDAU3M2lW92k347/CykilLiWihkEa68FztkWEdncKLnBriBAPHSPFfKk10Jz6U540c+4i8SApvCOdWpQ1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h/jMcbZ9; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759399604; bh=e2cGqQZioL2jBdVD9CKHeGOlxseyAb6Dt+AG4bgrTAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/jMcbZ9UbDo8f630e0O7YcuFyrebhk5PKff7FvzKHbC7Vpp4TosaWg8RLSGL3RGm
	 OW7ItamRYy0aibceYDhiXUMJiFLoeAhWjCxKJu6uC52GxGKrehnXuRXhTd14W4nSOX
	 tf/26G4aabQ2tumeWjW9iL8sjGw9v0Av6yPTNn8k=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-XMAILINFO: N8i9SvusUD3bxrxtkjX67Qk9yJUQYqygSzIxXmxnYAjJE8avjA3XVeVUWSEZYF
	 jQKBHpkFUZYIOoTXObb+CDi6wF4K9JFy7lJ84ZyCeGkGuNMGkiOPlJHHlSLNJUNkhJoLgiC5yCHay
	 nkuXMs69ZMObiNpogf4sJniHUoPiyNjrfr6zX0u7qQcdBksTMVpSfKD3PuqaO4JxJudwcIPbvjnXi
	 TGlIlj9qzMozFsN8MNzqEphesEOYaNG2NzPt1YVa+k4v1bUQ2qCt13ssKaSa0IS4ZjXqqamZdvx0A
	 PWDTWabBuX1c+3n0vAigklHyNJiZq14EqxplxJG4B3U0uD6BlNgTEeokiC8WbhHZ/UooK2eO4oe1A
	 9b334la8ubst8tuxK9vXv4/mWlO4xHauEWg7EV242nQtoNpp63ihZFBquRWqi4122iPUd3TdmTy4K
	 MjoAcqkuGdiZsyb/cnkcZ/AIn3Z6KGzRQIQre8y9q716zY+H9CfakLW+RL6X3a9V+itP6WMmW07tC
	 6iNgWlKYwpEs1YXYoXv+G1zM2lxaXMyFfEQ3rKWsCKD8V+10PfE5qHfZP6slRfA+A7ZmkOloAHhPw
	 9geeCCfWew0At+J2VCb/QrHlf2aWMnatHerPH0RmuD3nNjC9YcJSgHK8lXdDJTx7mncGSlVITFPW5
	 enx+9Uokvgzx9DRCVex7zo30hHAGn7KmSv0LWtNIMKG7oG06ZVy1+4FDZz+qwlx72Zv8Kfq6/vmq1
	 DHAVcSnxhfCry65TuKWgYFNcSKCHfrfoTpBUW7gihsaWRHHCuaMfArb6W8Oz0nlqn4N0ZytueMw3f
	 IcHIOO3l/SVr2jPxdQCNvEQxzTnSinns5XJ5kPx5yR2jBmHRLH4s4mWfeN80zE2nQwJImYx7dCaqJ
	 ly+tS5h/kspyk2b90lr9A6sVgAA//VunGRAuFnU1uww0OrklZGXvHkd9l+qhpAy6lpe2ZwxiIfuRK
	 EU+Fk6S11qEN5yCp88Nt65snWqt+5x6gOOzfrjFfvHO0/Gxptwdb+3y9ECiEPzXWlkLDQ4Rmrzug4
	 A2kg9jRMvbcpv/cxosDsArZ/61fANdakP0iDxcT/voLJeXwktJDwzR4QH24LX/J7w6YZoXkSKJ62d
	 nz4=
Received: from localhost.localdomain ([113.102.238.209])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 1A7B5A8C; Thu, 02 Oct 2025 18:06:39 +0800
X-QQ-mid: xmsmtpt1759399599twl7bi503
Message-ID: <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
From: Guangbo Cui <2407018371@qq.com>
To: byungchul@sk.com
Cc: Liam.Howlett@oracle.com,
	amir73il@gmail.com,
	andi.shyti@kernel.org,
	andrii@kernel.org,
	boqun.feng@gmail.com,
	bsegall@google.com,
	gregkh@linuxfoundation.org,
	linaro-mm-sig@lists.linaro.org,
	link@vivo.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	max.byungchul.park@gmail.com,
	mcgrof@kernel.org,
	melissa.srw@gmail.com,
	mgorman@suse.de,
	mhocko@kernel.org,
	minchan@kernel.org,
	oleg@redhat.com,
	paulmck@kernel.org,
	penberg@kernel.org,
	peterz@infradead.org,
	petr.pavlu@suse.com,
	torvalds@linux-foundation.org,
	vincent.guittot@linaro.org,
	will@kernel.org,
	yeoreum.yun@arm.com,
	ysk@kzalloc.com,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	dakr@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	Guangbo Cui <2407018371@qq.com>
Subject: [PATCH] rust: bindings: add `rust_helper_wait_for_completion` helper function
Date: Thu,  2 Oct 2025 10:06:17 +0000
X-OQ-MSGID: <20251002100616.19216-2-2407018371@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002081247.51255-37-byungchul@sk.com>
References: <20251002081247.51255-37-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> -extern void wait_for_completion(struct completion *);
> -extern void wait_for_completion_io(struct completion *);
> -extern int wait_for_completion_interruptible(struct completion *x);
> -extern int wait_for_completion_killable(struct completion *x);
> -extern int wait_for_completion_state(struct completion *x, unsigned int state);
> -extern unsigned long wait_for_completion_timeout(struct completion *x,
> +extern void __wait_for_completion(struct completion *);
> +extern void __wait_for_completion_io(struct completion *);
> +extern int __wait_for_completion_interruptible(struct completion *x);
> +extern int __wait_for_completion_killable(struct completion *x);
> +extern int __wait_for_completion_state(struct completion *x, unsigned int state);
> +extern unsigned long __wait_for_completion_timeout(struct completion *x,
>  						   unsigned long timeout);
> -extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> +extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
>  						    unsigned long timeout);
> -extern long wait_for_completion_interruptible_timeout(
> +extern long __wait_for_completion_interruptible_timeout(
>  	struct completion *x, unsigned long timeout);
> -extern long wait_for_completion_killable_timeout(
> +extern long __wait_for_completion_killable_timeout(
>  	struct completion *x, unsigned long timeout);
>  extern bool try_wait_for_completion(struct completion *x);
>  extern bool completion_done(struct completion *x);
> @@ -139,4 +134,79 @@ extern void complete(struct completion *);
>  extern void complete_on_current_cpu(struct completion *x);
>  extern void complete_all(struct completion *);
>  
> +#define wait_for_completion(x)						\
> +({									\
> +	sdt_might_sleep_start_timeout(NULL, -1L);			\
> +	__wait_for_completion(x);					\
> +	sdt_might_sleep_end();						\
> +})

The DEPT patch series changed `wait_for_completion` into a macro.
Because bindgen cannot handle function-like macros, this caused
Rust build errors. Add a helper function to fix it.

```
error[E0425]: cannot find function `wait_for_completion` in crate `bindings`
     --> rust/kernel/sync/completion.rs:110:28
      |
  110 |         unsafe { bindings::wait_for_completion(self.as_raw()) };
      |                            ^^^^^^^^^^^^^^^^^^^ help: a function with a similar name exists: `__wait_for_completion`
      |
     ::: /root/linux/rust/bindings/bindings_generated.rs:33440:5
      |
33440 |     pub fn __wait_for_completion(arg1: *mut completion);
      |     ---------------------------------------------------- similarly named function `__wait_for_completion` defined here

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0425`.
```

Signed-off-by: Guangbo Cui <2407018371@qq.com>
---
 rust/helpers/completion.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
index b2443262a2ae..5bae5e749def 100644
--- a/rust/helpers/completion.c
+++ b/rust/helpers/completion.c
@@ -6,3 +6,8 @@ void rust_helper_init_completion(struct completion *x)
 {
 	init_completion(x);
 }
+
+void rust_helper_wait_for_completion(struct completion *x)
+{
+	wait_for_completion(x);
+}
-- 
2.43.0


