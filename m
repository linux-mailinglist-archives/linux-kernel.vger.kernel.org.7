Return-Path: <linux-kernel+bounces-802268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECBDB4501A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3EFA448EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC8267AF6;
	Fri,  5 Sep 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoC10umj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0ajjj21"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA011263F2D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058080; cv=none; b=OkQ8h4TzueogHT+WLgPQBTTm3RsAo6qrg6sXkVkEyjhd+az8VLlbQ4DuLC44vdohKN+rFEv2i56JUnuPbsPiF91jqxnDaMwrq4ViolbOjkJK8Hbq+zk95enWfWcLCjif0iUbEwGm3Cgh7OSb52IvSgv4EsSByWZzbk4p0ivP8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058080; c=relaxed/simple;
	bh=XOgAgqtP8AdI/ZiqUUOrcsnAl/+L4+N2dBwsUg7H+xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+Y6Gt2Dqym5s4C9jVWbMTVftyKBXMBO7fBhV2veyztbjfhjpNYdNd6BYe7jriE3XTDIcPJ+NEE1oYDfAY/GDkDYCJQsbUXVwweRdcWll5lafmhGFuGdsbUDaR1jnCJ1KgOskm3MBfJJJdXTXudUhbXuE+2kyRcz6XqKiUfigug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aoC10umj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0ajjj21; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757058076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgAgqtP8AdI/ZiqUUOrcsnAl/+L4+N2dBwsUg7H+xo=;
	b=aoC10umjTUQa7xE5qwG77ipt2x/l99uDdNMWZlOheHsaCbTrYW7OvzD05cQYJ0m8aouWTC
	59/Kdprs5Wxuu77v/3XYGxHh1rIA75JxqO5sk2jHx/IH8hDSGIuSf/hq4hPgU1FVHW5UMd
	Sa2AVBiB2LoiIxgeSkdArBJ2npOMWk9tZTaT9bsQpwFR0pG/zwXWcUmzcqczWAFByK99e3
	pCD+FDJCQlyWFnHcrAbF/22BwzfFg8ijYzxguvQ8HotVwKLa5nTI9aTtK50A83tGD3QAX2
	n1qHMJCrE7kAk9GAJU7BxVgfsOEduhJ8MJ8uSmMZyjZcOQRbNz7uAB8XJtp39Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757058076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgAgqtP8AdI/ZiqUUOrcsnAl/+L4+N2dBwsUg7H+xo=;
	b=Q0ajjj21DVV05pcwqafYB0prXaqnKHGB1iwePlY5FQ/F5081MZPzH0T3zwDUuFU+twBql2
	VVicjwlucFe0IvAw==
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Xianglai Li
 <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/2] tick: Remove unreasonable detached state set in
 tick_shutdown()
In-Reply-To: <5d9fe6d9-d694-6a46-96be-9f7306cd9be0@loongson.cn>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-2-maobibo@loongson.cn> <87frd2xlat.ffs@tglx>
 <5d9fe6d9-d694-6a46-96be-9f7306cd9be0@loongson.cn>
Date: Fri, 05 Sep 2025 09:41:15 +0200
Message-ID: <87y0qtwdlw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05 2025 at 10:04, Bibo Mao wrote:
> On 2025/9/4 =E4=B8=8B=E5=8D=8811:57, Thomas Gleixner wrote:
>
> It is not easy with my poor English to spell out the comments :(
> How about the patch like this?

Looks about right.

