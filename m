Return-Path: <linux-kernel+bounces-785480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634FB34B64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C0B241E89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1528725B;
	Mon, 25 Aug 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvD5vO/R"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99121DE2AD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152133; cv=none; b=CfHSOV27Wp4FOY8N8hUabyhfD5ybOykUkpYFwO5QRPrYME4tnufhKkeRzVUA8ka+rzbo9U1zfgrskhcwoiMX0jYiuYW3PMJnLLW2YUQVl6YMzy+V0qeNp2KdMR6mjaUSbOidXXgthKTXF7L5jJR1RA2nX+EXM830iWPrrY9VrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152133; c=relaxed/simple;
	bh=hS2yKnGdB41s4qjSVFsEUBtDZsVxGwnyA04V/SaH6gY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7PO0gXmXxJHWudnD0alF6ufC4DETeOAC0kPs9VnELQM5NAuetniXwrzBr5iyABQebwQsrxuVfYxe1rx+Ug2YaAUe7OQtnmBIoB6qinHLwYmYvudOglsdCPPZ22alKbUrfLLXf9qi4/UWr+lsB7lxLSq0xJcpS3PyKVSwCmQPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvD5vO/R; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3259ff53c2eso1987187a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756152131; x=1756756931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoR6YIwHJtvUagOnLOkmoGRsx1yN1r5Oa1sX+F7+C6E=;
        b=vvD5vO/Rd9ZG9iBGfzfMHomPTHdXC9DmsmCIHjdov0/7v1Z5StI8W39KwlPlQn1IM2
         c3GC60VnR+8oZ+bQb9AFkWR/p+tVAPL9n0P9y/9mYhMrrXRPJNiKPgL1jnW7AtsP048u
         l7JyUDrTJCs/EG8Uf59bhvIkqhpOzAWvP/v/MXNRawqyT/er6kAubtQMZAfNw5OLtivW
         yvz8b2JonNecFZFuXLsMMCnyUGHPEkp+FVv6s8K75+y1kbrZhHsXezoPeft1n3sfBMQz
         PrpHsy7rsv1S5LY0ZQLLkVIOpnJLw2RwnUkbSie4KtaJMQJlQ+OiiiYqo6+9RN0PvL02
         Ityg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152131; x=1756756931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoR6YIwHJtvUagOnLOkmoGRsx1yN1r5Oa1sX+F7+C6E=;
        b=lsaoHgBJCq/T+bqw5XiUgTuxWxNgs7pYxizwvvQHjLlgybQIivmj+MIz3/MYQ+7EvH
         2AkbeY2hCY3/B78yEXlv3eX9/n6JoeW4+btJm1otPgcjwZ13KsrFo3Uw4bSKKB1TbbJv
         V9Fa7i0zvonU3V1k55FdB5m4vFLh+WGqv/Ay6AEsgR5T97iDLn6m/ESj3XajjQXRKpso
         p0x+4Yt/8frismttkSkqW2JwDgA2MygPAjkaEZFeqhaDNmcFFTgeROwATxCa3NW5xRSJ
         aegfCLm3AX7ZA6SUbe3ARtiS7FO/wkk56VpGHdRaO1fq+dpAOAsOmZt/Of7eJMibGImw
         aOzQ==
X-Gm-Message-State: AOJu0YzL21PL/dn9Gi5t02aIew9oXFk2iV/UpejcXkaojgeldWO0vbXB
	mFXZPe4nJEAsmD82FvKlbMBS7Nt/UCd+z/N7xtSbgenGrkFsBBtaOC95MaJqT7f+B9QijrHkzqQ
	8xMaxow==
X-Google-Smtp-Source: AGHT+IErh0Rwc1Pg50i+dz/TlBQFBxoHEcwaW+qpqag5RCl7whZ6SglkBRW7OtqaDRA1qV57yhDqp7Ibzig=
X-Received: from pjbkl16.prod.google.com ([2002:a17:90b:4990:b0:325:7fd8:4675])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:815:b0:323:2607:f5a5
 with SMTP id 98e67ed59e1d1-32515ec659fmr13232246a91.26.1756152130745; Mon, 25
 Aug 2025 13:02:10 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:02:09 -0700
In-Reply-To: <20250823161655.586695263@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823161326.635281786@linutronix.de> <20250823161655.586695263@linutronix.de>
Message-ID: <aKzBQRKuEmrNtCiB@google.com>
Subject: Re: [patch V2 36/37] rseq: Switch to TIF_RSEQ if supported
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 23, 2025, Thomas Gleixner wrote:
> @@ -122,7 +122,7 @@ static inline void rseq_force_update(voi
>   */
>  static inline void rseq_virt_userspace_exit(void)
>  {
> -	if (current->rseq_event.sched_switch)
> +	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)

Rather than pivot on CONFIG_HAVE_GENERIC_TIF_BITS, which makes the "why" quite
difficult to find/understand, what if this checks TIF_RSEQ == TIF_NOTIFY_RESUME?
That would also allow architectures to define TIF_RSEQ without switching to the
generic TIF bits implementation (though I don't know that we want to encourage
that?).

Updating the comment to explain what's going on would also be helpful, e.g.

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 185a4875b261..9a8e238ae9d1 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -112,17 +112,17 @@ static inline void rseq_force_update(void)
 
 /*
  * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
- * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
- * that case just to do it eventually again before returning to user space,
- * the entry resume_user_mode_work() invocation is ignored as the register
- * argument is NULL.
+ * which clears TIF_NOTIFY_RESUME on architectures that don't provide a separate
+ * TIF_RSEQ flag. To avoid updating user space RSEQ in that case just to do it
+ * eventually again before returning to user space, __rseq_handle_slowpath()
+ * does nothing when invoked with NULL register state.
  *
- * After returning from guest mode, they have to invoke this function to
- * re-raise TIF_NOTIFY_RESUME if necessary.
+ * After returning from guest mode, before exiting to userspace, hypervisors
+ * must invoke this function to re-raise TIF_NOTIFY_RESUME if necessary.
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-       if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
+       if (TIF_RSEQ == TIF_NOTIFY_RESUME && current->rseq_event.sched_switch)
                rseq_raise_notify_resume(current);
 }
 
>  		rseq_raise_notify_resume(current);
>  }

