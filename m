Return-Path: <linux-kernel+bounces-769443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29279B26EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD00BA27842
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966920F087;
	Thu, 14 Aug 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InIJc+Jc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nyzbv9do"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C0319858
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195655; cv=none; b=OtBHhnKSe+bftM0XvY/l8DAo0uHsttV6nGzmTj0ijN0BepQZ6BwLlayVI1lgKi7Gn9hUKQT09lAG698yu5qXCGiRWDi12yusg+erj/auSdndOBVAv22r1CeGdTMMUG0HUTKhgu/58CfI0vTD4ysxu3siBgAzNIHO5VdsYncXLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195655; c=relaxed/simple;
	bh=NbJBUoAr8dpXr2foHPEcOBhIxAe6SQfArQe+qyvCFOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsPMnItvcPk2V1IVh42yAJq/YxmBy1Ik0akrHwp5JmwCYCJ6Ieh6x4Age9Y5v20sK0VjVVyqXaGsnpINhW3Ja0eg75alE+og24/KUOjOdg95mbOJQyN1wl783iMD9Vu35uE3m6+JhzpSPcMRqfCFayFesJx2Tne/jQJU48D3EFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InIJc+Jc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nyzbv9do; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755195652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8d3KnhJoDWsK7AvQElKRmG3+5uDCNmBXtjH9PkBAD1E=;
	b=InIJc+JctkWDpRFejBDg2AsaCCVYbI1e7xQMX4NGtadD34mg/vVIl8PcGpSjPJthSfk7q4
	/+tGFGnV5SiLZE4bvsrZLT10LyGSzj+3yx7P4MDVD/vfxHckz26zOsUdGxCycsv3W2r5kr
	Mdz2Gjmy5ZNXyHFa5rr4MFsYa4zFVpSFJVVM+iNb9TcckbRGbCdTytN/x8lyu9q2Ktl+hm
	BTjp2IuPhj/ZFjvzZpe1af3SzVGAVzblVjLW5XQVKPbrId03NyuJqUywRpaVSz2hHCTREC
	s9orETdP4MCurI5iIhSDXV9XEZfKwt4Ne3vnc4YAIy3GKzfxzIpUVygGGTP9NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755195652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8d3KnhJoDWsK7AvQElKRmG3+5uDCNmBXtjH9PkBAD1E=;
	b=Nyzbv9dohiptLEMUexZ3OHPoCVoFf2F++KHOBjQ0veDQow4BZVUUMp+y+LQUZ6aVireGPG
	FDW2gy8CbdUEguAA==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
In-Reply-To: <402952DE-F930-4F03-8482-E39025A6222D@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx> <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
 <87o6smb3a0.ffs@tglx> <402952DE-F930-4F03-8482-E39025A6222D@oracle.com>
Date: Thu, 14 Aug 2025 20:20:50 +0200
Message-ID: <871ppd7ojh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14 2025 at 07:18, Prakash Sangappa wrote:
>> On Aug 11, 2025, at 2:45=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
> Is it ok to fail the sched_yield(2) syscall? The man page says
> sched_yield(2) always succeeds(returns 0).

I used it because it's simple. In practice we need a new syscall w/o
side effects.

> Also, is it necessary to force kill the process here with SIGSEGV, if
> some other system call was made?

Yes, because we do not trust user space and any violation of the
contract has consequences. Any kernel facility which interacts in such a
way with user space has to be defensive by design. Assuming that user
space is neither stupid nor malicious is naive at best and has been a
source of big gaping holes forever.

> Ideally it would be expected that the process should not be making any
> system call while in the critical section and is using time slice
> extension, other then sched_yield(2) to relinquish the cpu. However an
> application process could have a signal handler that gets invoked
> while in the critical section which can potentially be making some
> system call that is not sched_yield(2).

The timeslice extension is canceled when a signal is pending, so nothing
bad happens. The kernel already revoked it similar to how rseq aborts
the critical section on signal delivery.

If it doesn't work with the POC, that may be. With the stuff I'm
polishing now it works because I tested it :)

Thanks

        tglx

