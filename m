Return-Path: <linux-kernel+bounces-857712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD3BE7CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12591562A47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8552D8DB1;
	Fri, 17 Oct 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OPU4IcZy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2426B764
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692986; cv=none; b=QNsrl7bARI/2NUlnuXfnbRyFZ/I+fqhzmRMdv8AIrFPbOdZ5qGVYHL9TsL+3DeV+w2LuWv1JaaFyLBWiEC6tCIJLgfdqjnWs6dwB+xj/PkjbfHDHB3W9/wkvIagp6oaT+fiDzoCmGueRk3B8PVqwNskrTo0tTv8JA7vZVjfF8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692986; c=relaxed/simple;
	bh=GHLhHztdv4ciXwKNLGP33XgpK02Mk46v21Wg0XYLneg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzp25uGCtWOB49X4DyxDQWgYUII4OGhsV/9Rr3MluohKbGbyVhANM/cRxFxsoq+WoLopjQsENrzxBrD4Kpc1Z1toXExlUg1sME6n3t0rg8sRUJmPiCHhod61m/gafY/uuS5+tWn+5QOF8q8tGNMjgGJp8NVgvO+hz9bVomnWzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OPU4IcZy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427007b1fe5so963965f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760692982; x=1761297782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8eKIZZDBFPnFWMgL/iPK3gecISpT2qwaYqhfjFtVtc=;
        b=OPU4IcZy7CpQAjAWss/QSZYM5QuXmdFT3nlJL4xS4EzK3s9stGJ2o4OkhKvVRp2eos
         Af/qLvoSFxBJy8MF5BMpqEyQisYny3thxt1RjB8mtEcV/NBg1K8jmNRBgjk2Peog91V/
         KnX51MSpQnpjWH+zJFzuEwpNaMfCKaTpAOiXV5e70X2wdD0Te8qh5jviI62rpVDirnJw
         tmKJ/Z/Fo+zDYHjBw5yJl76TMZOhNfkyE5EC5bZlE25Ddt15uH0ajn4NgFZJ37KKw5HF
         6IguEmjMY2Dwa4bNtZn6OOZUOQyMC/c9YpWgcogkNUmkI/IFLuytMbECBeYEjjJGXYYu
         9wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692982; x=1761297782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8eKIZZDBFPnFWMgL/iPK3gecISpT2qwaYqhfjFtVtc=;
        b=ukcwPHuJ2cy7K+HY4yJhkgk4P6R1yRMBmaDUlvf4LxSkBVzih+HbJF3uqQVCj7vjjq
         2nzDLUUzR1szRKh5S2AUzMufJ+wmcHlUwj0o8js9NI30jVoGFdJAN+pIQT5k87njJMtO
         i/9BVL/xJB7tibnVUQbRFEs8b0n1CREkb7k1pgaNufAUxC+GQkmoRklh/oNGeATXY2i1
         e80tIouwiOvDUJmNMRXdl+I75JPNpQ8sW9zM2bOWO4q14pTW2kGFM7TZ8CI9ifyzwHHs
         2ROdISdUrUUzzBlRI3Vgjt5GxgxwNyanl88Trf+yYe/lPEQgA3atglVhpvZqOXsQIarc
         fUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3O/mdR3TcBJBCUI6tk8Acd9sBxpYdEyoQqjhdGtcFnJUEOpSkayVy3k4pMeJZWLzZPYTebBocvA98r7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwSmOlYHK+SC/cl724CnYfaWbgd4QSSGT9joHOb7LJu5Hp5Pc
	o6ilZtd0k2rmJMn2pkfVDJmzZkANrwGuDs7G3H3JapJ+q5KYeoLjO+0jCFOYTjv9NeM=
X-Gm-Gg: ASbGncut4k8f1JUfDeA7bxYnrQA91DBiLI9oufqYAI2ultsWqWgk7WinHcf2FNuPYHS
	q+i1KygrQwKbUYvCQzQUrh0vuhtc1JG3u3RPSW8JFzJT6TJx6feFdnT6/htUjt+li5fwgZztIZH
	beueDn9seO2oD+U2djyR7mWU+h8MjL0wl1NqPyx8dDNtrAwrPjYLfrHpUj8TJ3zSM4P9RONgGLQ
	pAiYk0FHBXPKUURDTGaZor7e2f40leFj2yhh9IaLgcoRshLibPtCgtGBWdFLYXGdzsWM6pSpkmE
	8mP3RhO4+WjN/XeO+ZvZ6J2mVa2UKYMIz6x8surV2INzPLNVy69fiyQBEBrVHLXZkjI2UUMwrF3
	yoGhC78TaVjbkJNDUxLYz1WsjpEo8+LIq9O2GsIf8HQ0p5Oqrsy6oIAgVrUlS1z5LNStpbDkCdR
	AEHIY=
X-Google-Smtp-Source: AGHT+IFBvM0yq0FAMRFQ5AUMtzJSBiUFOQlgXN4zTl2zbqeWXMV25+z9lNm5vk3i62WDfH3CKzQnvQ==
X-Received: by 2002:a05:6000:2f83:b0:424:211a:4141 with SMTP id ffacd0b85a97d-42704d92e5bmr2250835f8f.27.1760692982135;
        Fri, 17 Oct 2025 02:23:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57ccb1sm38878789f8f.8.2025.10.17.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:23:01 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:22:59 +0200
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
Subject: Re: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <aPIK89sCve-evf7y@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
 <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>

On Thu 2025-10-16 11:47:56, Marcos Paulo de Souza wrote:
> KDB can interrupt any console to execute the "mirrored printing" at any
> time, so add an exception to nbcon_context_try_acquire_direct to allow
> to get the context if the current CPU is the same as kdb_printf_cpu.
> 
> This change will be necessary for the next patch, which fixes
> kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
> such consoles. But to print it first needs to acquire the ownership of
> the console, so nbcon_context_try_acquire_direct is fixed here.
> 
> @@ -207,11 +208,26 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
>  /* Dynamic kdb shell command registration */
>  extern int kdb_register(kdbtab_t *cmd);
>  extern void kdb_unregister(kdbtab_t *cmd);
> +
> +/* Return true when KDB as locked for printing a message on this CPU. */
> +static inline
> +bool kdb_printf_on_this_cpu(void)
> +{
> +	/*
> +	 * We can use raw_smp_processor_id() here because the task could
> +	 * not get migrated when KDB has locked for printing on this CPU.
> +	 */
> +	return unlikely(READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id());
> +}
> +
>  #else /* ! CONFIG_KGDB_KDB */
>  static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
>  static inline void kdb_init(int level) {}
>  static inline int kdb_register(kdbtab_t *cmd) { return 0; }
>  static inline void kdb_unregister(kdbtab_t *cmd) {}
> +
> +static inline bool kdb_printf_on_this_cpu(void) { return false };

As the robot pointed out, this should be:

   static inline bool kdb_printf_on_this_cpu(void) { return false; }

> +
>  #endif	/* CONFIG_KGDB_KDB */
>  enum {
>  	KDB_NOT_INITIALIZED,

The rest looks good. With the above change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

