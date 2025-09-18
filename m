Return-Path: <linux-kernel+bounces-823118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C61B85949
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54771188AC77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767630CB43;
	Thu, 18 Sep 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSc3huhr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682B30749E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208926; cv=none; b=buPsQgQO0+xsvwyNZCxrx+Mgl44zra3TWP9l8bZy6zICnqlhifTBEtJ2+ZYUfedDvNXdIPtPAlwV3UDMuEWehCc88RtLKGifAA9HRTzyfdU/oAK7qSQAEtjmLUektbUC0FugHfgc/BreWapbsm9R/BP34PxKw/TdqwSkyjS7heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208926; c=relaxed/simple;
	bh=19JUBe/eWFjY1eJPFjFbgYEuygvl1/xR3A2FpDYhrSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibyN8eV7JZtDP41nDUArI6L7NinynieRz8AWIlJH7IJMbwRtfyDW0CoB/76DrfH+BWTrIWmbcxBtoF29PJnKaV3xAugdXBbeF0ZI5bS+9I5fu4hv9Vy05K4a3o9brphgGGAivDPETTYbNn3ut+sgXHV8zCR+z2j3KEBbLer952Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSc3huhr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0428b537e5so144565866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758208922; x=1758813722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8aunPXuW0oLXWlX0LK/89ePmy5RZAtcytO8FLXy+dY=;
        b=DSc3huhrmDmoj4cereUrZlcMpXZtZ1IIKCiD+RyVTtu5Y3ged1mzYsQ2M1rEVUxKau
         YuZnLjD0ByG2PiaXJZGDPkBTW+jJXyQg6phqCzPcpllpd/Gx+JttrpVgfeA1aQQcRWnz
         AuagurC25Yry4EH0JO/Gohcd6a57UFFH3DJesJfTnCncQkyGRytGbUbeUZjzVK4fPwRe
         9eransP2qUEFLPX7WrLP/H5fV/szk72LWCENG2I60tEIy9MiGyiE4L8MwLzVfQFcmhnE
         VFlF6HXabCWF3scDJWPJeGZPbfF8kSjSHadPiUdDbal9i9lzR07kzPSRK3ufEhQkoS+L
         qc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208922; x=1758813722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8aunPXuW0oLXWlX0LK/89ePmy5RZAtcytO8FLXy+dY=;
        b=waDOBm1GkpbImMpeLGr2V2KYJqOIuDufTY3x0i4R0PIUZc6MuvrzCGQwRvz5zzFkk1
         GsgW/tqgiGn7bOgv2CSwy+T/jRNWYyvOwlY7zex/7LHsOuAWWTWJCISudCutlldGT7lU
         dbfM+0BPDYsp0qIeVvnjy8r/fsRWCjgKJDSwpBoGkgnU+XKNZMq7hj4p47gr4Veju3PR
         NKZem4TY5zAy1qbVyWmicFe98Vs0sxlhWt1TrUaTzDJjhyd7B7o5l4E+2q9e3xD6lFsJ
         bI7BDQQmMl0camykhkM6g9UJHnE6J9r/2gbbv9h1SUzL6vErdPHBO1SMgQSvGTPDBlL1
         Qu6A==
X-Forwarded-Encrypted: i=1; AJvYcCUftnJzD5Dt3ZgY/qzdXRFlTbxhaGuIPiqVq2V3Iwaz1o3u82TlRrQ/s4F2+hTra+joM/KZMpDaxptKjP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNdZYHud1c7JmDFFD9yjnrdG5ftM32ac5Ng1htLO+FDmbdlR0
	DLTRF5ZKaDNF2iPiOhBkkfzz18jxYpbQMUWbnBMW2qALuWPcAcRe7WS1baDQ4e2ZNR0=
X-Gm-Gg: ASbGncuswNLrfx4qlZFbHmmmgrCsn7/ui85WBnFehmCZRCFX6hrHUXgfn4QjjvWR00Y
	T+Ztx2VoO2kwW5BvGyn70zG8S7xtmvKIPGDoPfdWMQCdlJVTftmECGLNHTwfOIbZRNcdvrhjic4
	omLKNMpgOtMN6DBfHxxg5WNDUAW4aSniSRhvYz6wrl/3Oog4sHxdWYEsv022IRRGrgqra3K9M3+
	lo44KjVWdoNKjoWeMWSLmj3rmqO9nAxaVkQDqvrTz6blekCQjwuURZVcCD2Kzh8RC5D151tL+uA
	WFqLD86zsQEdR5FsmWuVyvYAW/H3b0+tdO5wFxyDq66AwObdRgNEM9uBw4H51239OwvpmCzZnhr
	efb9qyH1ioQvpUdy7mEHIkvb0/MmMwGgiRowLX5APveVm
X-Google-Smtp-Source: AGHT+IHBRH23Qw10vU05yObYjXRGFafDzwotddvqBSn8tTA1uBbT0UIvEPqPtAaxIkSDrQM/d/C4IQ==
X-Received: by 2002:a17:907:747:b0:b04:7ad5:b567 with SMTP id a640c23a62f3a-b1bb559911cmr635688566b.16.1758208922065;
        Thu, 18 Sep 2025 08:22:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73bb6fasm215069266b.39.2025.09.18.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:22:01 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:22:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] printk: Introduce console_flush_one_record
Message-ID: <aMwjmJOVP5QW4rtD@pathway.suse.cz>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>

On Mon 2025-09-15 13:43:05, Andrew Murray wrote:
> console_flush_all prints all remaining records to all usable consoles
> whilst its caller holds console_lock. This can result in large waiting
> times for those waiting for console_lock especially where there is a
> large volume of records or where the console is slow (e.g. serial).
> 
> Let's extract the parts of this function which print a single record
> into a new function named console_flush_one_record. This can later
> be used for functions that will release and reacquire console_lock
> between records.
> 
> This commit should not change existing functionality.
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

The code shufling looks correct to me. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

See a nit below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3186,77 +3281,24 @@ static inline void printk_kthreads_check_locked(void) { }
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> -	struct console_flush_type ft;
> -	bool any_usable = false;
> -	struct console *con;
> +	bool any_usable;
>  	bool any_progress;
> -	int cookie;
>  
>  	*next_seq = 0;
>  	*handover = false;
>  
>  	do {
> -		any_progress = false;
> -
> -		printk_get_console_flush_type(&ft);
> -
> -		cookie = console_srcu_read_lock();
> -		for_each_console_srcu(con) {
> -			short flags = console_srcu_read_flags(con);
> -			u64 printk_seq;
> -			bool progress;
> +		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> +							&any_usable);
>  
> -			/*
> -			 * console_flush_all() is only responsible for nbcon
> -			 * consoles when the nbcon consoles cannot print via
> -			 * their atomic or threaded flushing.
> -			 */
> -			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> -				continue;
> -
> -			if (!console_is_usable(con, flags, !do_cond_resched))
> -				continue;
> -			any_usable = true;
> -
> -			if (flags & CON_NBCON) {
> -				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> -									 !do_cond_resched);
> -				printk_seq = nbcon_seq_read(con);
> -			} else {
> -				progress = console_emit_next_record(con, handover, cookie);
> -				printk_seq = con->seq;
> -			}
> -
> -			/*
> -			 * If a handover has occurred, the SRCU read lock
> -			 * is already released.
> -			 */
> -			if (*handover)
> -				return false;
> -
> -			/* Track the next of the highest seq flushed. */
> -			if (printk_seq > *next_seq)
> -				*next_seq = printk_seq;
> -
> -			if (!progress)
> -				continue;
> -			any_progress = true;
> -
> -			/* Allow panic_cpu to take over the consoles safely. */
> -			if (other_cpu_in_panic())
> -				goto abandon;
> +		if (*handover)
> +			return false;
>  
> -			if (do_cond_resched)
> -				cond_resched();
> -		}
> -		console_srcu_read_unlock(cookie);
> +		if (other_cpu_in_panic())
> +			return false;
>  	} while (any_progress);
>  
>  	return any_usable;

The semantic of the function was always complicated. It results
into duplicated checks in the callers.

I think that we could do slightly better in this particular case.
But I would do the refactoring in a separate patch to make this
one easier for review.

I played with the code and came up with:

From 7a3c930a12d7c0157f404a4a834d1f92f3070799 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 18 Sep 2025 16:57:58 +0200
Subject: [RFC] printk: console_flush_one_record() code cleanup

console_flush_one_record() and console_flush_all() duplicate several
checks. They both want to tell the caller that consoles are not
longer usable in this context because it has lost the lock or
the lock has to be reserved for the panic CPU.

Pass this information by clearing the @any_usable parameter value
which has the same effect.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 53daab5cdee5..2cceedcc3d34 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3175,7 +3175,8 @@ static inline void printk_kthreads_check_locked(void) { }
  * console_lock, in which case the caller is no longer holding the
  * console_lock. Otherwise it is set to false.
  *
- * @any_usable will be set to true if there are any usable consoles.
+ * @any_usable will be set to true if there are any usable consoles
+ * in this context.
  *
  * Returns true when there was at least one usable console and a record was
  * flushed. A returned false indicates there were no records to flush for any
@@ -3230,7 +3231,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * is already released.
 		 */
 		if (*handover)
-			return false;
+			goto unusable;
 
 		/* Track the next of the highest seq flushed. */
 		if (printk_seq > *next_seq)
@@ -3242,7 +3243,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		/* Allow panic_cpu to take over the consoles safely. */
 		if (other_cpu_in_panic())
-			goto abandon;
+			goto unusable_srcu;
 
 		if (do_cond_resched)
 			cond_resched();
@@ -3251,8 +3252,10 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 	return any_progress;
 
-abandon:
+unusable_srcu:
 	console_srcu_read_unlock(cookie);
+unusable:
+	*any_usable = false;
 	return false;
 }
 
@@ -3288,14 +3291,9 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	*handover = false;
 
 	do {
-		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
-							&any_usable);
+		any_progress = console_flush_one_record(do_cond_resched, next_seq,
+							handover, &any_usable);
 
-		if (*handover)
-			return false;
-
-		if (other_cpu_in_panic())
-			return false;
 	} while (any_progress);
 
 	return any_usable;
-- 
2.51.0

Best Regards,
Petr

