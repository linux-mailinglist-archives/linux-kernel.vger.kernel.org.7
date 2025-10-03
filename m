Return-Path: <linux-kernel+bounces-841495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC57BB7866
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC101B20AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4D24A06B;
	Fri,  3 Oct 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DyC4cZ5y"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5214A23
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508369; cv=none; b=e+KqzdxzXPO1cDqvSXRF0XiSiRf4FiJIR5hJ1phE1iPTFeAZG5uMVh2bI+ynI03rCpnqk8VMyXQc/1Kp4BzNWpB0XOaRMkjW2J8Gj7QwnYeXhmNRoNsIzIr2ml+78dhUVHEK4X/GHMB67cgkg+6f+FbgW8azO3V6lnbmYXGqHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508369; c=relaxed/simple;
	bh=uM5ulUl7hyKtJMLBK7vIlU8DupL5OoxllQKMX9JZPkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCi2Y0ov754NlHmydcteJb2Z5R8uzFyumA8bFbm61UfDCFiKq8BziwIo8HWeA5e1O0gIBsNX1oHV+UrQKSmgRX7Wr2XtipFyvlrjpaxtcjfbxwLJIjV3+xs1OWly+//PH7qFPgyWvH1Momy6pGtV9LeOUHvTdVjPl9iIm69/45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DyC4cZ5y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2187426f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759508365; x=1760113165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ANl4yX/rzyRJQfAcTKUc2DIObrnzBMi0w3geyhQO80=;
        b=DyC4cZ5y6002gz/bzle8o9DMPkuDt3Uwbq3Drc+26zkg1hyeUk/6vq1XNFreY3OTnV
         8DVsG1alCLNEABO00GO7OFMMum7G/vRhwgroVVPDv5q0fxl84Wk5ijWQPnEJP3jBD6K0
         Zk/JnMAgjYuxDHkxvmdyilT6P6n5CMpF/I0w7NEYEk/iT+jfVYaBZQY53MnVCw4c2OtJ
         mAO4ZJmkGjNpAHMYR7wmKm0wfk/x7LErb+07Tlo/NHk8fvez+C+KyLyCIdTaQZeiDdxR
         pVdS76ewO3m2UiNr4x0LrzaaPHWhd1UKERtpzK3Ya76+cqOh64rDoNhJPdcxxZdAR0V9
         wLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508365; x=1760113165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ANl4yX/rzyRJQfAcTKUc2DIObrnzBMi0w3geyhQO80=;
        b=BJKBYEAymFIGfU/LolVAU7ZbjU6ypz3DJ3j9kaZr0naeHKCFXE4mpykU5DIVAMSKwc
         kY5b7FMVLa+gCLue1r1JwaE4RTvQPsQ6QiitkbJaLhj+LMaNatQBgCkP6aMB+k4982w6
         GlEy7L7+/CMWIJ86tS32tcrc9O96mahUFWuRkHsxKacu+aYtCQrlY5Mof8m++J34Md3o
         ftah+xgHlBS9CoaerI298vcGGGaXT6kg8eM4VtBiuR37xODaMtGe8UeDa0bP0T35jfto
         b3CYzeBdNxIQSCOqRag6lHmpNiVNl9JwZv1XNsiySv4K73c/WKnB0TEbmpzu6xLkh6BM
         ScxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwgwaKoD1OvsvGtllXNemxaBz6dT+y8HJcow5kKP8bCsBNAdG4W9PUEhu+GihI59XvmpUui6AK2K6PRb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJg84pyJ7Qhoo8dt2PZRFEOfX1lTIXuXR462BoxMa3fs8omIo
	InBmJKocGmM5qBB4tj165TMgVAcVar9R6VlX/jIXSRL6tEl0fFVF4n8QeKVC0eeyORs=
X-Gm-Gg: ASbGncsh8K4/r9FdvJtW0bSNG/Idr2jsg2GyDml7deu8hcMxMpFuL5l0iLHWK3w/g8z
	FIxu0BCgOtHThp3CQmFJDQOAdVzzftKnHGvzKCFWanGtJ6MEaaiB8aRya3HXN8amXI3rp6LSlLa
	hYyc2nY+8TyY82BsHKQWnuFb63+A48s5jG9JZVK3Ni5YogX/ZlUwKuWun8yNjf7rr/h5S1H0Gxp
	kqYQfYlGhIeDsupJRO4UkoAI5EJd2jhi3ngFwB+7wpn1pSV4VT6rY3bMqF+wospb2bqSI1aDuK4
	tBGA7iKBnlyM+8YKqJCEFid69HSQRMHw2yXzff6A/ZmWeoOHbFkmqvKH86pNgUY1q7RTHxreRs8
	GjJOwKMohRQulryvhPhg72NrVWqTe+qRw3mSRrnIYuQ5zJz92Dg==
X-Google-Smtp-Source: AGHT+IGii9OZMsSG3ZRa2GiF1Pd8XwKeeEDHWsz2q9+XLsz6amt1hhNccm22PcL6tasagLbeS6B57w==
X-Received: by 2002:a05:6000:2504:b0:3ec:df5a:90d with SMTP id ffacd0b85a97d-425671c5331mr2366715f8f.60.1759508364935;
        Fri, 03 Oct 2025 09:19:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm8543221f8f.33.2025.10.03.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:19:24 -0700 (PDT)
Date: Fri, 3 Oct 2025 18:19:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
Message-ID: <aN_3id2CF7ivC42R@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de>
 <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
 <84seg3gd89.fsf@jogness.linutronix.de>
 <CALqELGw8wtbbihLsOcNgnV2vGoSR7kD8_tHmt7ESY4d3buwrLQ@mail.gmail.com>
 <aN5Pp2cFf_pedhxe@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN5Pp2cFf_pedhxe@pathway.suse.cz>

On Thu 2025-10-02 12:10:50, Petr Mladek wrote:
> On Wed 2025-10-01 17:26:27, Andrew Murray wrote:
> > On Wed, 1 Oct 2025 at 10:53, John Ogness <john.ogness@linutronix.de> wrote:
> > >
> > > On 2025-09-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > > > Alternatively, it may be possible for console_flush_one_record to
> > > > return any_usable, thus dropping it as an argument and removing the
> > > > return of any_progress. Instead the caller could keep calling
> > > > console_flush_one_record until it returns false or until next_seq
> > > > stops increasing?
> 
> No, this won't work. @next_seq shows the highest value from all
> consoles. It is no longer increased when at least one console
> flushed all pending messages. But other consoles might be
> behind, still having pending messages, and still making progress.
> 
> Honestly, I do not know how to make it better. We need to pass
> both information: @next_seq and if some console flushed something.
> 
> Note that @next_seq is valid only when all consoles are flushed
> and returning the same @next_seq. But it does not help to remove
> the @any_progress parameter.

I thought more about how to improve the semantic and came up with
the following patch. It is supposed to replace this one.

Note: I created this patch on top of Linus' tree as of today.
      It already includes the patchset (-mm tree) which consolidated
      the panic state API.

      Namely, this patchset is affected by the commit d4a36db5639db03
      ("panic/printk: replace other_cpu_in_panic() with
      panic_on_other_cpu()").

      It is enough to do:

	  s/other_cpu_in_panic/panic_on_other_cpu/

      I am sorry for any inconvenience.


Here is the new proposal:

From 30f5302b11962f8ec961ca85419ed097a5b76502 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Sat, 27 Sep 2025 23:05:36 +0100
Subject: [PATCH 2/3] printk: console_flush_one_record() code cleanup

console_flush_one_record() and console_flush_all() duplicate several
checks. They both want to tell the caller that consoles are not
longer usable in this context because it has lost the lock or
the lock has to be reserved for the panic CPU.

Remove the duplication by changing the semantic of the function
console_flush_one_record() return value and parameters.

The function will return true when it is able to do the job. It means
that there is at least one usable console. And the flushing was
not interrupted by a takeover or panic_on_other_cpu().

Also replace the @any_usable parameter with @try_again. The @try_again
parameter will be set to true when the function could do the job
and at least one console made a progress.

Motivation:

The callers need to know when

  + they should continue flushing => @try_again
  + when the console is flushed => can_do_the_job(return) && !@try_again
  + when @next_seq is valid => same as flushed
  + when lost console_lock => @takeover

The proposed change makes it clear when the function can do
the job. It simplifies the answer for the other questions.

Also the return value from console_flush_one_record() can
be used as return value from console_flush_all().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 58 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fa9bd511a1fb..6c846d2d37d9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3142,31 +3142,32 @@ static inline void printk_kthreads_check_locked(void) { }
  * context.
  *
  * @next_seq is set to the sequence number after the last available record.
- * The value is valid only when this function returns true.
+ * The value is valid only when all usable consoles were flushed. It is
+ * when the function returns true (can do the job) and @try_again parameter
+ * is set to false, see below.
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding the
  * console_lock. Otherwise it is set to false.
  *
- * @any_usable will be set to true if there are any usable consoles.
+ * @try_again will be set to true when it still makes sense to call this
+ * function again. The function could do the job, see the return value.
+ * And some consoles still make progress.
  *
- * Returns true when there was at least one usable console and a record was
- * flushed. A returned false indicates there were no records to flush for any
- * of the consoles. It may also indicate that there were no usable consoles,
- * the context has been lost or there is a panic suitation. Regardless the
- * reason, the caller should assume it is not useful to immediately try again.
+ * Returns true when the function could do the job. Some consoles are usable,
+ * and there was no takeover and no panic_on_other_cpu().
  *
  * Requires the console_lock.
  */
 static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
-				     bool *any_usable)
+				     bool *try_again)
 {
 	struct console_flush_type ft;
+	int any_usable = false;
 	struct console *con;
-	bool any_progress;
 	int cookie;
 
-	any_progress = false;
+	*try_again = false;
 
 	printk_get_console_flush_type(&ft);
 
@@ -3186,7 +3187,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		if (!console_is_usable(con, flags, !do_cond_resched))
 			continue;
-		*any_usable = true;
+		any_usable = true;
 
 		if (flags & CON_NBCON) {
 			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
@@ -3202,7 +3203,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * is already released.
 		 */
 		if (*handover)
-			return false;
+			goto fail;
 
 		/* Track the next of the highest seq flushed. */
 		if (printk_seq > *next_seq)
@@ -3210,21 +3211,28 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 		if (!progress)
 			continue;
-		any_progress = true;
+
+		/*
+		 * An usable console made a progress. There might still be
+		 * pending messages.
+		 */
+		*try_again = true;
 
 		/* Allow panic_cpu to take over the consoles safely. */
 		if (panic_on_other_cpu())
-			goto abandon;
+			goto fail_srcu;
 
 		if (do_cond_resched)
 			cond_resched();
 	}
 	console_srcu_read_unlock(cookie);
 
-	return any_progress;
+	return any_usable;
 
-abandon:
+fail_srcu:
 	console_srcu_read_unlock(cookie);
+fail:
+	*try_again = false;
 	return false;
 }
 
@@ -3253,24 +3261,18 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	bool any_usable = false;
-	bool any_progress;
+	bool try_again;
+	bool ret;
 
 	*next_seq = 0;
 	*handover = false;
 
 	do {
-		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
-							&any_usable);
+		ret = console_flush_one_record(do_cond_resched, next_seq,
+					       handover, &try_again);
+	} while (try_again);
 
-		if (*handover)
-			return false;
-
-		if (panic_on_other_cpu())
-			return false;
-	} while (any_progress);
-
-	return any_usable;
+	return ret;
 }
 
 static void __console_flush_and_unlock(void)
-- 
2.51.0


