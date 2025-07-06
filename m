Return-Path: <linux-kernel+bounces-714113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B5AF6349
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 22:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E48178B38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E01C1F12;
	Wed,  2 Jul 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7L/Owgv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgzLR8M8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CC2DE6EB;
	Wed,  2 Jul 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488014; cv=none; b=EgdVVhk7a/aQ1Mzf8pmS60VsGZgOPKCKckMkRfEPB9DRykpLJIoPxJq7PCSEc/MsdL7wrpzvTUypEirUqCs/DByYVwpkz3WhaAWqTzrwbNkmItvlTcxB7PCjygBrmwIdcOt2bLIwOaHQR9HHRwMEFPeB21WT6W+JweSmrzcojhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488014; c=relaxed/simple;
	bh=2/GrOQX5iJnK3synSs+QF5grTQ2fhp6/pPB7Koocnt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enIKInyaAXJQS9KBVxXexG6PeTWdp6JIKMvhDBsNjN7jSVZgaCGi3H8OnDGHVve5gECW1BlzpKvZCoSMuegOCrtyjhlAf3VCcDjO0Y9m73gYGdcevgzZxkqTYNlkuAX6rGGVfg+bTb4ynALt54O18H35IRdm4+tBznY1oYdXjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7L/Owgv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgzLR8M8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751488010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/GrOQX5iJnK3synSs+QF5grTQ2fhp6/pPB7Koocnt0=;
	b=A7L/Owgv5+xorslidldtvsqk8oKZbHoTg+oETceJ8B7a3zmzHhDXl8L3ociTSwf2dCq+Oy
	v87VAFRKbBAYKHPpH1cu2J34qQSoqO4XwaMDHGz4fhyxVgnFtjLySlV6yWRry1ZAKsGMa3
	tZ2Wlq8YKv5mFOBojXWoaIlTkR8HrQ+7pccGMG9RtxyJLm6GOLejjF+FebcEV6VfFc+nmT
	8q58eux8sZ4sFwjYQ4tQc9FV7rRGZXe5Dga2NBFxEErRZh0wRhnFA4OQwSBzZhGNBa6M2B
	/aeLd1jxt2Ps8A0QlZFIEnCuT0m2oT0qZyaNxLqdRX+IdfkqFui6AjDWcwLs0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751488010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/GrOQX5iJnK3synSs+QF5grTQ2fhp6/pPB7Koocnt0=;
	b=KgzLR8M8+gXAgGNYam2L6BVqF7oU574rXIqDEhpy+FHgDYlU1WD7OUZ9BTdL7WF5wGEhLX
	MDnyD2t0vfFZMRCw==
To: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Terry Tritton <terry.tritton@linaro.org>
Subject: Re: [PATCH] selftests/futex: Add futex_numa to .gitignore
In-Reply-To: <20250609190927.89655-1-terry.tritton@linaro.org>
References: <20250609190927.89655-1-terry.tritton@linaro.org>
Date: Wed, 02 Jul 2025 22:26:49 +0200
Message-ID: <87v7oajq46.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 09 2025 at 20:09, Terry Tritton wrote:

> futex_numa was never added to the .gitignore file.
> Add it.
>

This lacks a Fixes: tag.

