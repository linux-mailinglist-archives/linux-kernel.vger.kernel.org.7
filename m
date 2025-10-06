Return-Path: <linux-kernel+bounces-842706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB79BBD5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7880B349C59
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C99213E9F;
	Mon,  6 Oct 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkrAlUws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKFtt9dE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9D33993
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739490; cv=none; b=BRSSfQak93c1xM2xz9rIGqgO8TbBLEGgXG+RtsTLzXp/7U9nKnrfcN2fSkSXlll0rfSsNFbMITH8U/v1ZcbMbn99+96GQ6aqEaD633+aQOpfhCmm5jexMVbkOCEOdwv5Lq6P6+bB4Ln7IO67ibskh7MpVkmkQJcIVguMvX1UsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739490; c=relaxed/simple;
	bh=/bDKBKLqO8NLLmrLZz1pQqgzcrI+/whlYpUwPEG7xYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STRpDDTqFiCORUSSOJb8asFFCn6DFv3LxECYyF9qQNI9Aeu/rHuKksYtmh04cDAR472/882gTX08PGhqTWJMj5rmiisq5Eo4bn/IkaJpnp0L95lLO/spkJ/RCNd8LVeLBOgnidjsdRa0I1eoHKNdtU/dLMJZg1gbthgmGU5xdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkrAlUws; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKFtt9dE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759739479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bDKBKLqO8NLLmrLZz1pQqgzcrI+/whlYpUwPEG7xYc=;
	b=PkrAlUwsg3dAdcz7ZJt2rLm0NbtZq/Hfl5ccwLle/DhAs7+lM2dqZETNVguisKqU8lWZvX
	/74c1Yo0aP710U+DZ6TKV5jPzyq6qETpeU0NcUt6RGfvafP9RO6cnmsojv7VF/gRklEZz8
	iNlh9Ydinw9W09RhEiW+g/YqvlMg0fXul6bY4Vy2S2T3JdtlS4BHnB392bf8NmI9sXI0rr
	95ptSuMqvG8duLnOuorBJ2C3CviyQ9cUoTDd1+Y63Znb4SSdaFlcelzE3QFc8xqbOZdu38
	ppM3rya8WgjQKAJjuSsUYWUw5HKwgut5HWVvTHU3jXEi8K5WnES1OvICuRjExQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759739479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bDKBKLqO8NLLmrLZz1pQqgzcrI+/whlYpUwPEG7xYc=;
	b=nKFtt9dEDGUiFSq27YMWNJ6yeTpuuhokEvNbP76nfHSafx6+y8A/s/tCqNKr7fyOpM7UYg
	NdUON0cC8SxszVBA==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
In-Reply-To: <68f9b7d000ec433adef02294552280902590f762.camel@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
 <84h5wihdqu.fsf@jogness.linutronix.de>
 <68f9b7d000ec433adef02294552280902590f762.camel@suse.com>
Date: Mon, 06 Oct 2025 10:37:18 +0206
Message-ID: <84y0pomnxl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-02, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> I fixed all your suggestions and published my branch here[1]. The only
> change that I didn't fixed was about the "Context:" change that you
> suggested, since I'll let Petr to thing about it, since he usually has
> comments about it.
>
> [1]: https://github.com/marcosps/linux/tree/nbcon-kgdboc-v5

Thanks. For v6 you can add:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

for the rest of the series (patches 1-4).

John

