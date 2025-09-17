Return-Path: <linux-kernel+bounces-820615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907BB7CD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA691C20166
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B231A7E7;
	Wed, 17 Sep 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W7ZV9dM6"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D030CB3D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110988; cv=none; b=tQHB8B6y8fUr7Dc2T4sJfvcnvgF9yfUMNgVD/01vZ3eNSiluKlzaRTJPPycEiD2H9j+V23IvHcuJjxKWomP50cB81Y9gEb31jl02XBYMCf4lEy9zNKNMW0FJ7/3idGIM33PwBEUGUIyeCwaupXnGoHNtZi3NN/1fzH7YPciGRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110988; c=relaxed/simple;
	bh=pWAp+enihdVGwkQw1B9IjT9uZhcvd2Ivu2Cou6yb00I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co6c7B06yXCMceB37o0ZNU4O5su4LyxfqD0OHxd18t8ZsU7UeauDRHmqUeAWCmKJ1JR8QdutFNwM8jaAOPep8bGRdMFNALzeE3ZzEm388ULB3VzBrxj8ZWpCEwm5K5BZDv9HIFk1As8meuaix2YYVxeQisnJ1odAuJVZ7PRjaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W7ZV9dM6; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1006471166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758110985; x=1758715785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxZ3+rLWm8Lxy+EHVqksiJdCm4z0sfQ0FHsCPWMh5L0=;
        b=W7ZV9dM67jjXOM38AJx6/beDVtPuolFRM8ex+/1o3whGuGYpdnSf7cNDBx74co6s3N
         c6mH6eIfJEtf5jQlShe+HdALl8Y4JKzzZ8rqRg/9BXvD3uLF6ptxS/k30ES21EqETnJE
         oBUG2nh4Tz8wnKWSP1HOxhhmvcs68HlNkaInm8hU4pi1LShhbf7iBqGeyIKR9vKfHHRi
         ye94nBM5vN5L7OQWPz12h1b8xo7hZOSTCo+KOTIkhKgYDMgYZxlOy4SzMwyem/onRQqD
         6OCMQuyv3PG9S69jXA2anQDCEjd+PbeWjY1qndcoOTzZbulUSKiskRu4pNLw+E4igJMC
         pEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110985; x=1758715785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxZ3+rLWm8Lxy+EHVqksiJdCm4z0sfQ0FHsCPWMh5L0=;
        b=TRn5TwaKa1VUI9LK11j8lu4uN2MIh1fFnjXpr9Tt3aWBck5ko980LjlyQRbuE0wdGG
         sPkOdLqwiZ2lC3pmps5xfinigYoHW8htNt08dYdh9vpE+IqIUngI2WqyitNwywkExJxe
         V2QXIZta/FjWkCh5zi0kEhH9LjpKnfQA7QGnB4U4lYQz4SdZo9dl91WHnT6Y0f+brsYB
         tYivW1j5rfezUpUE/Q/9B+8yNKHxlLoKfF99hrn9qRuYWDJ8y6dE6zQ/zq81ltPBRc9t
         H9MGk2Q4/rcy0tLEnnRySeGMqBbXvM/XBf7gLuf5uOYAmIFSrAwbfUxinYaaCTBadc00
         UGeA==
X-Forwarded-Encrypted: i=1; AJvYcCWSAY/IAndAGgji+3uOAQuU5dlykjBDkYU1kxXSOHYYOyyu6b57DoyZFGbIaEFu74q2hdwfsN40P7DxphE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLwf/0ea5hKlK9m+CMDQ65oVlIvd4zjB8fYJNw/pzwqA++kkZ
	pRTEWz7a68uFTT1zGXZRX30CQDe6SLY26HqCr6pwk6tJEukd9nlmfEH86wHGwcNjZS8=
X-Gm-Gg: ASbGncv3Lv2Qv5za+Dt+cd13FAo7r33bVjrrsYNjkzKKimzj8mQ3L6atTR2bf3m6v+4
	aWy+MY6JScACQFE44Xo7BUcLt+oSgIF99tN1gVToU8crcxIaS7H03gzmpYoJ2DeDpNfknHaGGKA
	t8M2bc0DWvHDI+QxCMBuZB6YCNPhUlvnqaIfbKL7h28w08jfLR+tqKc6JrXG7rX5jVle2266Vts
	gy2VksU8S0bR6kY72cHUZMqUPOD6/KkYFqT88FwsdE9Ybzui3Q7ldtNhhH+f2jI6puUiaZ8+T5R
	o0fKEu/hTmO81XL7Wgf2xUIbc9wrtiRPaKZLUDN1hBp9oVwprc5x7LC6hg564pW9ltbLeWVkaxu
	mwIwqG7XbepDz04VSLmZxE39AH6etb/hyZyrcyKvH1+th
X-Google-Smtp-Source: AGHT+IEiPsKGkN/Uq1H8HSxXA+gLbV8eTjrBUjU0AsRADHTNUdgsScaxG3DVDMRBuqTKXekvFmA2yg==
X-Received: by 2002:a17:907:7eaa:b0:b0a:333:2f91 with SMTP id a640c23a62f3a-b1bb7e35ed1mr229890666b.40.1758110984541;
        Wed, 17 Sep 2025 05:09:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0906a9640esm904166666b.110.2025.09.17.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:09:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:09:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <aMqlBvIBZJTkKD0l@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-3-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-nbcon-kgdboc-v4-3-e2b6753bb566@suse.com>

On Mon 2025-09-15 08:20:32, Marcos Paulo de Souza wrote:
> KDB can interrupt any console to execute the "mirrored printing" at any
> time, so add an exception to nbcon_context_try_acquire_direct to allow
> to get the context if the current CPU is the same as kdb_printf_cpu.
> 
> This change will be necessary for the next patch, which fixes
> kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
> such consoles. But to print it first needs to acquire the ownership of
> the console, so nbcon_context_try_acquire_direct is fixed here.
> 
> --- a/include/linux/kdb.h
> +++ b/include/linux/kdb.h
> @@ -207,11 +207,17 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
>  /* Dynamic kdb shell command registration */
>  extern int kdb_register(kdbtab_t *cmd);
>  extern void kdb_unregister(kdbtab_t *cmd);
> +
> +#define KDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id())

The condition looks inverted. It should be true when the CPU ID matches.

I actually think about using similar approach and naming scheme
as for the similar API checking @panic_cpu. There are patches
in -mm tree which consolidated that API, see
https://lore.kernel.org/r/20250825022947.1596226-2-wangjinchao600@gmail.com

In our case, the similar API would be:

/* Return true when KDB has locked for printing a message on this CPU. */
static inline
bool kdb_printf_on_this_cpu(void)
{
	/*
	 * We can use raw_smp_processor_id() here because the task could
	 * not get migrated when KDB has locked for printing on this CPU.
	 */
	return unlikely(READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id());
}

> +
>  #else /* ! CONFIG_KGDB_KDB */
>  static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
>  static inline void kdb_init(int level) {}
>  static inline int kdb_register(kdbtab_t *cmd) { return 0; }
>  static inline void kdb_unregister(kdbtab_t *cmd) {}
> +
> +#define KDB_IS_ACTIVE() false

and here to match the style above:

static inline bool kdb_printf_on_this_cpu(void) { return false };

> +
>  #endif	/* CONFIG_KGDB_KDB */
>  enum {
>  	KDB_NOT_INITIALIZED,
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index ff218e95a505fd10521c2c4dfb00ad5ec5773953..8644e019e2391797e623fcc124d37ed4d460ccd9 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -248,13 +249,17 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * since all non-panic CPUs are stopped during panic(), it
>  		 * is safer to have them avoid gaining console ownership.
>  		 *
> -		 * If this acquire is a reacquire (and an unsafe takeover
> +		 * One exception is if kdb is active, which may print
> +		 * from multiple CPUs during a panic.

Also here the "active" is a bit ambiguous term. I would use:

		 * One exception is when kdb has locked for printing on this
		 * CPU.

> +		 *
> +		 * Second exception is a reacquire (and an unsafe takeover
>  		 * has not previously occurred) then it is allowed to attempt
>  		 * a direct acquire in panic. This gives console drivers an
>  		 * opportunity to perform any necessary cleanup if they were
>  		 * interrupted by the panic CPU while printing.
>  		 */
>  		if (other_cpu_in_panic() &&
> +		    !KDB_IS_ACTIVE() &&
>  		    (!is_reacquire || cur->unsafe_takeover)) {
>  			return -EPERM;
>  		}

I am sorry that I did not suggested the better names already when
this new API was discussed in v3.

Best Regards,
Petr

