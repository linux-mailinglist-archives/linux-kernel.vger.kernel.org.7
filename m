Return-Path: <linux-kernel+bounces-751102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3D7B16544
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11DB1AA12DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3712DCBF1;
	Wed, 30 Jul 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40XEz7qJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qv2nk8XE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15011DED42
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895813; cv=none; b=q9CjYEyPzSKjKPhbuDw0H3JhYe0MdNz37K61+kSw/bDH1hlLMmo7QJsv4fG4EdbMPlJEee7S5VHv84QfyiQybu3ZDpELRo/USbTiIaNpr937+Np3LsnaGdWEmXIiJtvi2QJLOP3HsBjdmxBJSzU08JQMmWUinLxtTxmRLs1999I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895813; c=relaxed/simple;
	bh=oWSLXZirdZ1YnhfenqYrCAkT8GZemooo/gk7czlZzmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQgYuYfWtvXPLfL6YFUh0LjFAQ5YIi6zPGbHtUEmZLQR25YvpppGUYLFoucIgqarRdsvm9wG1/+qsnQ6u+fp6P65z35ND9YbUOJKP/FF7KOWWaFQaH8S5lsYSlulSAs9SbSYVQ1ZRQ6HuSqyKGM7QX2Tb0H/wJbM+AtMi6TjHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40XEz7qJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qv2nk8XE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753895809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03d1+hnd/r5gd4PjOr3ScKy2oefYPd8tyuOLUsSzzWU=;
	b=40XEz7qJhHCTVWUBFXHK70hIyzqgZWdc3ffyeh3kKe6YwgnPFCSbnxwEL98YjF9PKrfXPJ
	5c/WbhCJFsn98kobQFhqzdJ8rNRrfkrGjyydZOFumLJv0L57ROsFsu2N2RG0Pa8mp2ExrF
	jF+fJHyC1vSmHZx4vWrChR+b5Oz1PIiBv7szhnHEFBCZ4tfNiYrGMaOmh+oWfvQ+N3/Sso
	NAtLMlR3udUZPKcCg5r6m2/iQIU52HPPXGhsSE2OcyhGRrOLPXnUo307q3UM20QExaTrKa
	9oBWSFr65OCaXTX7jOpGlPFn2FMSm4neAUDRlWFthz+JqaiSgB/NC9IZfsF3uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753895809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03d1+hnd/r5gd4PjOr3ScKy2oefYPd8tyuOLUsSzzWU=;
	b=Qv2nk8XEJN7WfKS4mt5WOPhDxiZI+wqH9TNiBEUOVJn+oaabXm89A/tcFYPPFdOT2Uzqcs
	vaT4LnsJvXQl/uDQ==
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org,
 jann@thejh.net, keescook@chromium.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] futex: don't leak robust_list pointer on exec race
In-Reply-To: <CAH4c4jKmj2gwmW2LS8CuGyw6phtiN+=_Bef8_pSEzjnbsqPOeg@mail.gmail.com>
References: <20250607064444.4310-1-pranav.tyagi03@gmail.com>
 <87cybdp7to.ffs@tglx>
 <CAH4c4jLjSBxbd3bqkdgcCSWqXURratANgnbq9negrSU283xHpg@mail.gmail.com>
 <87frg3ss9s.ffs@tglx>
 <CAH4c4jKmj2gwmW2LS8CuGyw6phtiN+=_Bef8_pSEzjnbsqPOeg@mail.gmail.com>
Date: Wed, 30 Jul 2025 19:16:48 +0200
Message-ID: <87pldhioov.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30 2025 at 20:21, Pranav Tyagi wrote:
> On Fri, Jun 13, 2025 at 6:38=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> I face a small issue while refactoring the common code in a helper.
>
> The main obstacle to a full refactor is that the native and compat
> syscalls use different user-visible types (size_t vs compat_size_t,
> struct robust_list_head * vs compat_uptr_t). Because put_user() is
> type-checked at compile-time, I can=E2=80=99t unify both into one function
> without either unsafe casting or weakening type safety (this is as far
> as I understand).
>
> The best I can do is refactor the common task lookup/permission
> logic into a helper, and leave ABI-specific put_user() calls in thin wrap=
pers.

These are two different SYSCALL() implementations, so they
can deal with the difference sizes of put_user() there.

Thanks,

        tglx

