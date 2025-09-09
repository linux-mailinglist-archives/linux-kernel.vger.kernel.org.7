Return-Path: <linux-kernel+bounces-808400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE6B4FF47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7C1C21098
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A73451B6;
	Tue,  9 Sep 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJcGfFr1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2ddDEaT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A83451D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427836; cv=none; b=Thq5/DyRjKPC1qa+rcAN1Cr2OJPiZUuaEJ/lEFdZ7JsG1igMbwL12qv38UOGfjUBspJUxf/Kn1rjI2C7vRN2MKjjWt+y9xSsTSDw4YYJMumvXY1w9ijEZ6FTvCsHYQvd5tghIilwQwuHVIx7jIVd61SOag2rQ42CGh7uG293jVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427836; c=relaxed/simple;
	bh=M5svAHzkipeo6JblunyqQxlNE3zvU2z9UULrfqp3VrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n83tJDSj85Xb5hi881eu5rITsQKBX+20ZUMNHotfjsgoASRKVu/WeENe8cSlgEGhJ9anW6cvsDEZ6wbk13lqT3QNrpaKJkT4lKbho1UpWdM7GQ6GPtWzdoMxfdylw+WwZzCHyTDq6gUDNN1MUGM8ekQl5icObPtorUCwWQz8Exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJcGfFr1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2ddDEaT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757427831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5svAHzkipeo6JblunyqQxlNE3zvU2z9UULrfqp3VrA=;
	b=oJcGfFr1rksMzLrazCvGv06Z9ENMD7YoYPf/ZmgTE7wLZo2vYifaG0hiue8LE5jWcXkeOW
	8f2QOArwzb1/Mgi+5iloPynO1/BTHZ78ga1ud5Vyt/hG8s1JAVrkCk7PUrLhSOLitwFAhf
	eMaxlALJD5gobhYRFQPYKrG7dz4siXDoPASGyC9P/ZJCccPNxy6LNA9z2C3nwrEEFXiQsA
	5DPZZ0hYO/6YUjgCR7/3YyV8BhINlFosiAKg/GKlY8FdMk6FU72ttjr8puQoMg3u3OHBWt
	MPtjbC8g9v4bMnqGStylHR7UMm/4Lxo5JRam/+/vtJRqeofIF/S8x/8H+0etFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757427831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5svAHzkipeo6JblunyqQxlNE3zvU2z9UULrfqp3VrA=;
	b=s2ddDEaTcNXlPd99azukgVLOZVpiBp1MrlrZfj5tbC9Ti6XWSHKJK55ZnN+TPJeHXW2yaj
	QWL9JyvHuPAJHBCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <aMAwMz4vWC5u9OpN@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
 <aL77aq4gZBsn4epT@pathway.suse.cz>
 <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
 <84segwjbxq.fsf@jogness.linutronix.de> <aMAwMz4vWC5u9OpN@pathway.suse.cz>
Date: Tue, 09 Sep 2025 16:29:50 +0206
Message-ID: <84h5xbk8ll.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-09, Petr Mladek <pmladek@suse.com> wrote:
> The problem is that wctxt->unsafe_takeover would need to get updated
> after acquiring the context. And might be reused for different
> consoles, ...

You are right. I think it is best to make nbcon_write_context_set_buf()
available.

> But wait. I do not see any code using wctxt->unsafe_takeover.
>
> It seems that the motivation was that console drivers might
> do something else when there was an unsafe_takeover in the past,
> see https://lore.kernel.org/lkml/87cyz6ro62.fsf@jogness.linutronix.de/
> But it seems that no console driver is using it.
>
> So, I would prefer to remove the "unsafe_takeover" field from
> struct nbcon_write_context and keep this kdb code as it is now.

No one is using it because the nbcon drivers are still implementing the
"hope and pray" model on unsafe takeovers. The flag is an important part
of the API to allow drivers to maximize their safety.

I think it is too early to remove the flag when there are still so few
nbcon drivers in existance.

John

