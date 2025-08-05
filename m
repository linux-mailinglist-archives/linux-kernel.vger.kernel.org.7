Return-Path: <linux-kernel+bounces-756990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57993B1BBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF318A5D11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFA25A326;
	Tue,  5 Aug 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uC31QA0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VK166dwQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C5EEA6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430470; cv=none; b=OLa2axOD2kFKmcqEOYFjD5Eup5Gb11EwoCoF1hx0AzMdG5HLY7i6TOxxwGg2M5IKX8wXJl1xDy0JALvmu3A8lOWiHIn2g36U37J2ZI11/drBRmqmxf92YtKaBcF8YDq3xgBLXAVifb7gKFRgrZI4KFXIbhLSeptI6xOaM3ZjIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430470; c=relaxed/simple;
	bh=yYeG1V6t4ZHRjGttv1pJDmBATEHcfx0p5yuWagvDGXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOSqT4pLPobYKCjU6WlzuaNVX92yeds4QmQ1OO0rk48Z1upQ0NJeFZHrUxVEhw2zeZHIgK9VwHVAmwZrJpJady7WcM7BXlA1py7wL3hVDowr8elTp36Y9nlaGj5h0yDgeSDTu77qWOUIEWvtg2aYG8Ki8x+LtlbWIb6Ln99vaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uC31QA0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VK166dwQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754430467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLCk+N1CEF+OQ37UtR8LN9SHMYLGmt5Mn4Kf7hVjXto=;
	b=uC31QA0gtnktRHnmxfzIlR++SJWu3B+riqv2IUEaewtBMhpnYTgR288qjbmOjQ1qJfZshL
	mWaWvQCMXVtzNktd6BnuFLurjaAUDfjmeBV+a6agJVSbC1ncLxiFMKabcjw/mqyDF2U9R1
	9J5ooaymYybSIZNgLqheCFkkDNCqqGUcEa20UJCENWgZSjKV6tz1OzMq3PBBIQ/7VoNSND
	lkiPNawnakRAjEVU99/ejo0xEUA8Kp/X0ZLuQhXjqyfNiH7MPEz7vxSEnNaEkQXf763MEf
	68nlgBlpaEXPhbJP7hXEFoog/iVjLh+HyPzo6JOk+PNs4tlFEhYPVDWwjDzovg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754430467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLCk+N1CEF+OQ37UtR8LN9SHMYLGmt5Mn4Kf7hVjXto=;
	b=VK166dwQKu1w1o4hmRDEfRAhhSYQNy/UDIE8FTbH1y9akAIF3aASNCTj9tIqa8BrW7kJGN
	UJmoFZrNtdY8u9BA==
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, mingo@redhat.com,
 peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, linux-kernel@vger.kernel.org
Cc: jann@thejh.net, keescook@chromium.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, Pranav Tyagi
 <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH v3] futex: don't leak robust_list pointer on exec race
In-Reply-To: <20250805154725.22031-1-pranav.tyagi03@gmail.com>
References: <20250805154725.22031-1-pranav.tyagi03@gmail.com>
Date: Tue, 05 Aug 2025 23:47:45 +0200
Message-ID: <871pppfnjy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05 2025 at 21:17, Pranav Tyagi wrote:
> +
> +	if (IS_ENABLED(CONFIG_COMPAT) && compat)
> +		head =3D p->compat_robust_list;

This still does not compile because the dead code elimination comes
_after_ the compiler decodes this line. I don't even need to fire up a
compiler to predict the error emitted when CONFIG_COMPAT=3Dn:

  error: =E2=80=98struct task_struct=E2=80=99 has no member named =E2=80=98=
compat_robust_list=E2=80=99

No?

There is a reason why I suggested you to use that helper function.

You are obviously free to ignore me, but then please make sure that the
stuff you submit compiles _AND_ works. Otherwise if you are not sure,
why I told you, ask.

Please take your time and stop rushing out half baken crap, which wastes
everybodys time. I don't care about your time wasted, but I pretty much
care about mine.

To be clear: I don't want to see this in my inbox again before next week
and then it better be correct.

Thanks,

        tglx




