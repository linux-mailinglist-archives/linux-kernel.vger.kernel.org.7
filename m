Return-Path: <linux-kernel+bounces-757455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9718B1C257
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D0117E965
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7B288C95;
	Wed,  6 Aug 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RtVuhH3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uqfy7bVe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68571F5846
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469858; cv=none; b=NKU1RUtE/fPU8Z7Sk/uuGXq/QYz1q2gBSybx8Wa4OcKE9hTFqVK9XEQFsjsG6P0kiumHZqdoCLmpvziMn17zekEsXd71qixfKnyhtkVeqqlhl0knm25d0jZgFS+kJv0JqR/EDJumwuu6EhG3EK9lumCRowFRn0BhlvCVtCXmW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469858; c=relaxed/simple;
	bh=+boGnkpnHMCXTrz/MJ9UW/7bneMxcELM4II12Q7+dpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWXvKjdpkLudPm8B1v6FYdnuinOCUhovfq3n+Wxy9LS18I+XH3m6omXMDNi6eknZnTOuMg1jkaPIaanCY2jikrzKxLbCe1Dh8N7Gz6pvC8tLwIfKlRLetgZirwn/iGw58+lAzSYTJKMzjLdDfd9f+RlfZqjbe0JGsrIILF71HrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RtVuhH3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uqfy7bVe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754469854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+boGnkpnHMCXTrz/MJ9UW/7bneMxcELM4II12Q7+dpI=;
	b=4RtVuhH30zRWUfizMkRyogrZSqIgflESQR5TKIU97E8qEDHnq5btOTxuhrSkPikTzg8wS+
	kY0kc7YJpqzYlL+Y293Qz4LmmfpbZLmNA6LcSNtSBVUzJmqKP05ffzkj+ahtuojF5ddRWo
	Skvu4O8BnCjl8O8houaAK7FDd9tFiEe4hzyPa4zKlUN42jlcX6hInUqozFr7ekyi6TSCnO
	ur4lda7RN7OQQq9zMy3Awcdek9izn0v9X3LwgHBiLIldJ0sGK5adp2IvYJwyWjeWv7F3Kg
	u5JzvYG2yKI9uR6RC/0/fEKdZHqz25ZM0E7lzzHnumAcApUQnoho12BXbs6uXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754469854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+boGnkpnHMCXTrz/MJ9UW/7bneMxcELM4II12Q7+dpI=;
	b=Uqfy7bVeRt8JyuHpqex3jgyCXsa7Z/0ah8zAfdUEfmqE6RfCgqNjMnbGqG65tamKk4i3dY
	UdF8P4Y+1kls19DA==
To: Wake Liu <wakel@google.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, wakel@google.com
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
In-Reply-To: <20250805162153.952693-1-wakel@google.com>
References: <20250805162153.952693-1-wakel@google.com>
Date: Wed, 06 Aug 2025 10:44:13 +0200
Message-ID: <87ldnwet5u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 00:21, Wake Liu wrote:

Why are you sending the same patch twice within a minute?


