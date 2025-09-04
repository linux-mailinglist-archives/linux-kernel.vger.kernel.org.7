Return-Path: <linux-kernel+bounces-800462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA9B437F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AFB586D82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC582F7455;
	Thu,  4 Sep 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QkAMXDJV"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010429AAEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980506; cv=none; b=rfoqXbMtj+SoXW3XWf0mqT7tLbduTqkQW6CgOY49guMfV9VQYfY2vq2vdJm5HeXvU6igYLbvCR/fOXXVUEnbNfPuMKfgDLiesvNxVZWzdgGdyaMxQmhYhd3M6Gu1Omvdf4r86pzqwbAxTgJ4torQdiFw74DLp/oYiU8YQXqUZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980506; c=relaxed/simple;
	bh=p4yfjLax0byQtq3h1j0/1fmrSvj+b4Iifr5rdPKQGuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gum83QdvmiPnoKg+Ad93CokDLl969Ks//rvKQ3BiYgTw1iT/2J0fTdA3jwWtQixtyNnglLUb62LgK3U6s5wpojYjHsOeYhpT/19f7YgjvWo5VZLEaum+AuzJMkqbf+ZF1Le/joAFJ/4Bc/GkxVRxrgQ6ThjOYS/x4BQ9Mr2sWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QkAMXDJV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-249118cb74cso11190715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756980505; x=1757585305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DqoMSTfN4OT+UKkab33c3dLxBaAimyLjOFqiF5xYnk=;
        b=QkAMXDJVospu46U6JsTziQ02t/wEL/os+rI/8REny5GrGDHVv2Tjuo9X6tegTEEuTd
         JLJ4bVvDz5G2vWQziGuH011gH8rzkwU1Oa/mOB4hHwzfgYenHqWLXA22d2TwYIEOk6vl
         KiQpuGhKkAtJWjiiT1lE6RFnLmPts2m+M19MC2f9g1aQkSytNZAWPidbBbEN6SR8RMny
         78/bY6k2Pcmq0Rvn0T7EIADzsf/qq5m6psfshfe3MPYYtOEF8qB2rC1WUGP19j56ZqpT
         gS1bUbTr/Yx4Q+SXgxv5Yy7ueeJwthPAq/cGZyVPvPHRi8X7iBnJ80oSM+xuHBNx7XqO
         WAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980505; x=1757585305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DqoMSTfN4OT+UKkab33c3dLxBaAimyLjOFqiF5xYnk=;
        b=EUoXufGK0AS+uQ4uBV/Zth2iaG+/o2o+VSYY1ZL5DnUF9hySApXdE4wyjVyyKDwumQ
         5uomu0OQvz6vyr5bE/F2S8SYdzp82KCGsoYTbxCWTm3fpMNp39hP0kriIIYh5GhmOASS
         ey929ctKGFQ9slysyUBFQFZijJnBTkWtj9BHHx2s246ANci/5hICIUeWRhdF/vOqcstr
         i3OdwMcHXjK+WwkZJfpVS+eC33B05FImU19dnxDgNDmjG1IpMpQIQq+lRCqUmViVZQNT
         LS/tqntniBnk4QzXG2uncoeyK4uEbDt3S1hYOQ0Mz3pAQATYcbztKUNs2RP4H2yHTM28
         2XzA==
X-Gm-Message-State: AOJu0YwlLFxk3mV09oe0cd2qlGkTBPccH8m7m6HSJOh3SPaMsB/dJD1V
	ELqy8IotIKs13tPmRo/Y0RuM4/dGiEWejDXwfXYsGo9nID38zeXwZ83qzzRESYPON/DPZkA4toq
	mEdBNDA==
X-Google-Smtp-Source: AGHT+IGO+JhqStpiaCmWHClMJOJKG1m9D9ezvihsGMorMX0NkpYsgpxi2YwfBGX3KoLbaKeQ4is/4Kmti7c=
X-Received: from pjbpl1.prod.google.com ([2002:a17:90b:2681:b0:327:4fa6:eaa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cb:b0:248:fc2d:3a21
 with SMTP id d9443c01a7336-24944873f89mr207727605ad.4.1756980504749; Thu, 04
 Sep 2025 03:08:24 -0700 (PDT)
Date: Thu, 4 Sep 2025 03:08:20 -0700
In-Reply-To: <877byh2k13.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823161326.635281786@linutronix.de> <20250823161655.586695263@linutronix.de>
 <aKzBQRKuEmrNtCiB@google.com> <877byh2k13.ffs@tglx>
Message-ID: <aLllFObsXWOtaVVI@google.com>
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

On Tue, Sep 02, 2025, Thomas Gleixner wrote:
> On Mon, Aug 25 2025 at 13:02, Sean Christopherson wrote:
> > On Sat, Aug 23, 2025, Thomas Gleixner wrote:
> >> @@ -122,7 +122,7 @@ static inline void rseq_force_update(voi
> >>   */
> >>  static inline void rseq_virt_userspace_exit(void)
> >>  {
> >> -	if (current->rseq_event.sched_switch)
> >> +	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
> >
> > Rather than pivot on CONFIG_HAVE_GENERIC_TIF_BITS, which makes the "why" quite
> > difficult to find/understand, what if this checks TIF_RSEQ == TIF_NOTIFY_RESUME?
> > That would also allow architectures to define TIF_RSEQ without switching to the
> > generic TIF bits implementation (though I don't know that we want to encourage
> > that?).
> 
> Did you read the cover letter?

I read part of it :-)

> Consolidating on common infrastructure is the goal here. Stop
> proliferating the architecture specific hackery, which has zero value
> and justification. If people want to harvest the core improvements, then
> they should get their act together and mop up their architecture
> code. If they can't be bothered, so be it.

Definitely no argument on that front.

> I'm happy to add a comment which explains that.

And maybe a BUILD_BUG_ON() to assert that TIF_RSEQ != TIF_NOTIFY_RESUME?  My main
interest is documenting why the generic implementation doesn't need to re-raise
TIF_NOTIFY_RESUME.  E.g. something like this?

/*
 * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
 * which clears TIF_NOTIFY_RESUME on architectures that don't provide support
 * the generic TIF bits.  To avoid updating user space RSEQ in that case just
 * to do it eventually again before returning to user space,
 * __rseq_handle_slowpath() does nothing when invoked with NULL register state.
 *
 * After returning from guest mode, before exiting to userspace, hypervisors
 * must invoke this function to re-raise TIF_NOTIFY_RESUME if necessary.
 */
static inline void rseq_virt_userspace_exit(void)
{
	/*
	 * The generic optimization for deferring RSEQ updates until the next
	 * exit relies on having a dedicated TIF_RSEQ.
	 */
	if (IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS))
		BUILD_BUG_ON(TIF_RSEQ == TIF_NOTIFY_RESUME);
	else if (current->rseq_event.sched_switch)
		rseq_raise_notify_resume(current);
}

