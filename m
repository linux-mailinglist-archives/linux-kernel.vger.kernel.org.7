Return-Path: <linux-kernel+bounces-785520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7AB34BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EF8243C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC02264B9;
	Mon, 25 Aug 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LR4v2Mja"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45423F405
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153831; cv=none; b=EjJEx2NVYnjdsmzMnsHu5MXhEwfkk9ZP/HCJfblcjKmJyeni74XFgTonSAUhIkvloNOCLy7CMHcAbFotIRndMRR6cy2WIZ3es1U5Ult1hYdVYD5pOn+AxJU1hRmedxrJmO9QJzY0xfOTTdnbOwcCnFQA5NHCvoaSGztWFfppvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153831; c=relaxed/simple;
	bh=Mrzsmo5o+hV9TCUwdFUBZczgfb4weRxv0GFuNSY+ZrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alvdQGpWC9Cck4i1SxFWNGTExgpk2ZDGWWVv5TCz2x/EwM+4QuGl0MAHMPLA/KSL9Kxf2xdiPMXQ6kInjO8n7IeD9rk+Rn3jkKkEM4cizJ3VWpdbW7UeBFvJTYvDq6hRjCaqfRFXzNT46Nd7ecdJ+cONzx7M3Hu0a8zeXfPSkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LR4v2Mja; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1756153817;
	bh=Mrzsmo5o+hV9TCUwdFUBZczgfb4weRxv0GFuNSY+ZrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LR4v2MjaycId2o+Q+vXgvcbgjl2FrSPMJK4Cs6A5OeUU+0GPXxUZXs0b/RlXGCBVM
	 mSTg6Y4xDV5HNzW2oNoNxOhThJ+RO+opr3OJaBcXPuRojeDN107zO5AQ0jOqdEYvb7
	 B2vAG0kj380XOBgLNlbi8xgccJyHajpUuE4KgvBUocbgD8Ztfl0C5jSm5MlM93muMo
	 bl0ouimq+X1EQC66Ix72qafOyAfv/0J7iZKBvbaB5L00ErVRnM+grvaImosNW+u2ax
	 ZWhqgMy9LK/rLW3Zvm6rQpiplrjADy3WjRScVIEQPxrhs0sThPLEyi6i6J7Zj7u2ir
	 HBAx7obVKSIpA==
Received: from [172.16.0.149] (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4c9j8n43QXz3g2;
	Mon, 25 Aug 2025 16:30:17 -0400 (EDT)
Message-ID: <f3131178-7e69-4d38-bb99-4b063f409a66@efficios.com>
Date: Mon, 25 Aug 2025 16:30:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [patch V2 18/37] rseq: Provide static branch for runtime
 debugging
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.421576400@linutronix.de>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <20250823161654.421576400@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Config based debug is rarely turned on and is not available easily when
> things go wrong.
> 
> Provide a static branch to allow permanent integration of debug mechanisms
> along with the usual toggles in Kconfig, command line and debugfs.
> 
> Requested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |    4 +
>   include/linux/rseq_entry.h                      |    3
>   init/Kconfig                                    |   14 ++++
>   kernel/rseq.c                                   |   73 ++++++++++++++++++++++--
>   4 files changed, 90 insertions(+), 4 deletions(-)
> 
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6443,6 +6443,10 @@
>   			Memory area to be used by remote processor image,
>   			managed by CMA.
>   
> +	rseq_debug=	[KNL] Enable or disable restartable sequence
> +			debug mode. Defaults to CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE.
> +			Format: <bool>
> +
>   	rt_group_sched=	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
>   			when CONFIG_RT_GROUP_SCHED=y. Defaults to
>   			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -34,6 +34,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #endif /* !CONFIG_RSEQ_STATS */
>   
>   #ifdef CONFIG_RSEQ
> +#include <linux/jump_label.h>
>   #include <linux/rseq.h>
>   
>   #include <linux/tracepoint-defs.h>
> @@ -66,6 +67,8 @@ static inline void rseq_trace_ip_fixup(u
>   				       unsigned long offset, unsigned long abort_ip) { }
>   #endif /* !CONFIG_TRACEPOINT */
>   
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1893,10 +1893,24 @@ config RSEQ_STATS
>   
>   	  If unsure, say N.
>   
> +config RSEQ_DEBUG_DEFAULT_ENABLE
> +	default n
> +	bool "Enable restartable sequences debug mode by default" if EXPERT
> +	depends on RSEQ
> +	help
> +	  This enables the static branch for debug mode of restartable
> +	  sequences.
> +
> +	  This also can be controlled on the kernel command line via the
> +	  command line parameter "rseq_debug=0/1" and through debugfs.
> +
> +	  If unsure, say N.
> +
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
>   	depends on RSEQ && DEBUG_KERNEL
> +	select RSEQ_DEBUG_DEFAULT_ENABLE
>   	help
>   	  Enable extra debugging checks for the rseq system call.
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -95,6 +95,27 @@
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>   
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
> +
> +static inline void rseq_control_debug(bool on)
> +{
> +	if (on)
> +		static_branch_enable(&rseq_debug_enabled);
> +	else
> +		static_branch_disable(&rseq_debug_enabled);
> +}
> +
> +static int __init rseq_setup_debug(char *str)
> +{
> +	bool on;
> +
> +	if (kstrtobool(str, &on))
> +		return -EINVAL;
> +	rseq_control_debug(on);
> +	return 0;

Functions used by __setup() have to return '1' to signal that the 
argument was handled, otherwise you get this in the kernel log:

kernel: Unknown kernel command line parameters "rseq_debug=1", will be 
passed to user space.


> +}
> +__setup("rseq_debug=", rseq_setup_debug);
> +
>   #ifdef CONFIG_TRACEPOINTS
>   /*
>    * Out of line, so the actual update functions can be in a header to be
> @@ -112,10 +133,11 @@ void __rseq_trace_ip_fixup(unsigned long
>   }
>   #endif /* CONFIG_TRACEPOINTS */
>   
> +#ifdef CONFIG_DEBUG_FS
>   #ifdef CONFIG_RSEQ_STATS
>   DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
>   
> -static int rseq_debug_show(struct seq_file *m, void *p)
> +static int rseq_stats_show(struct seq_file *m, void *p)
>   {
>   	struct rseq_stats stats = { };
>   	unsigned int cpu;
> @@ -140,14 +162,56 @@ static int rseq_debug_show(struct seq_fi
>   	return 0;
>   }
>   
> +static int rseq_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rseq_stats_show, inode->i_private);
> +}
> +
> +static const struct file_operations stat_ops = {
> +	.open		= rseq_stats_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init rseq_stats_init(struct dentry *root_dir)
> +{
> +	debugfs_create_file("stats", 0444, root_dir, NULL, &stat_ops);
> +	return 0;
> +}
> +#else
> +static inline void rseq_stats_init(struct dentry *root_dir) { }
> +#endif /* CONFIG_RSEQ_STATS */
> +
> +static int rseq_debug_show(struct seq_file *m, void *p)
> +{
> +	bool on = static_branch_unlikely(&rseq_debug_enabled);
> +
> +	seq_printf(m, "%d\n", on);
> +	return 0;
> +}
> +
> +static ssize_t rseq_debug_write(struct file *file, const char __user *ubuf,
> +			    size_t count, loff_t *ppos)
> +{
> +	bool on;
> +
> +	if (kstrtobool_from_user(ubuf, count, &on))
> +		return -EINVAL;
> +
> +	rseq_control_debug(on);
> +	return count;
> +}
> +
>   static int rseq_debug_open(struct inode *inode, struct file *file)
>   {
>   	return single_open(file, rseq_debug_show, inode->i_private);
>   }
>   
> -static const struct file_operations dfs_ops = {
> +static const struct file_operations debug_ops = {
>   	.open		= rseq_debug_open,
>   	.read		= seq_read,
> +	.write		= rseq_debug_write,
>   	.llseek		= seq_lseek,
>   	.release	= single_release,
>   };
> @@ -156,11 +220,12 @@ static int __init rseq_debugfs_init(void
>   {
>   	struct dentry *root_dir = debugfs_create_dir("rseq", NULL);
>   
> -	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
> +	debugfs_create_file("debug", 0644, root_dir, NULL, &debug_ops);
> +	rseq_stats_init(root_dir);
>   	return 0;
>   }
>   __initcall(rseq_debugfs_init);
> -#endif /* CONFIG_RSEQ_STATS */
> +#endif /* CONFIG_DEBUG_FS */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
> 
> 


