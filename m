Return-Path: <linux-kernel+bounces-749630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE95B150C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F04A547704
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9429A31D;
	Tue, 29 Jul 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ln8baY/d"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4D28F933;
	Tue, 29 Jul 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804876; cv=none; b=ZLhIkx9r4oazJxxo4o+45lYEvEh52Ia72H+9QYxYUg05S+i7RU9TWGYXgoIyR+94LyHa5XvEv3wxWLwgvZzyecjjL/I8z8nU1CvxHExiJipoDmTw+qSTw0p1SlxOT6ZbkajALFavJsTMA/wQrrWxAlvYby+3fDCPAvI0EgaRXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804876; c=relaxed/simple;
	bh=5HP2M179wFfBIkz0uRt1rlhTpkYMNAW4xjew1XSepmU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DYSAnvWx9hm0/sr3RqMlOWHyfL+YGMFKJnBiCaHXpD8QqNj1bkXqroBC+67MZk2Bvvqi7426m8rPFVeDXWAjjVL1GBhilEBbwplUKGeYLrJzC5+GKMzNJiM+b0zPgHHhyJ19pImwWDzeY0/19SO9j22wW7LiZKNpItq3gxqPQ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ln8baY/d; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753804871; x=1754409671; i=markus.elfring@web.de;
	bh=5HP2M179wFfBIkz0uRt1rlhTpkYMNAW4xjew1XSepmU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ln8baY/dw/mraEI1BhTWOL4s2V6mOQavLLzJPiJBGQE3gJ4tfD+9c4iWsuuvLq1x
	 xfQ//HOQPHvH4qysy5yJ+LVzts5ziojmdrIdU8iQ8tBxbAVb78CFqP1YuL45Socrv
	 urWY4qwrVeNQ82wKB9PmYGgHGfYKz7iGEOCx+htBQ8VZ8uYddUaOGiPFlB9hJe5CT
	 DM27tLRwSWF+1aLMcQ+yMCkf5V7fLFYic72IBHNVgcXlHt1nqPnsvowxMu/arvQwu
	 /8VgEgJSK7d8oUH8CzN4/YAWGXS9H67LWz2vXo6SUFTqeRm96hMGjAevM8xAkd8fT
	 4nTRaCae9oSEGMwluw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1v4NFz2QX0-00WhHW; Tue, 29
 Jul 2025 17:55:09 +0200
Message-ID: <8b25d279-c6fe-4f9d-98a8-c5ddf70a4b9a@web.de>
Date: Tue, 29 Jul 2025 17:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dishank Jogi <jogidishank503@gmail.com>, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joel Granados <joel.granados@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Ryo Takakura <takakura@valinux.co.jp>, Thomas Gleixner <tglx@linutronix.de>
References: <20250729133340.9613-1-jogidishank503@gmail.com>
Subject: Re: [PATCH] kernel/panic.c: fix checkpatch erros on style and
 initialization.
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729133340.9613-1-jogidishank503@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:srgyXKz3UNkyLrpSxCjN+qfLoxOg0e6hQhCYqkk3olyJYg5A2h2
 FJmz1wNwLMqyRFcUQprZpaq7fhO5XahmD7iO42bAbC2EAzqLHKCjzLyEZgYzA9tTVAy7JkO
 M+n3dr6WSwyMEK7TjOekRtgu6ERfXD8ImBfsr7w0uLTcl6SxKtomd90dkjZfdYc2vf3nZOl
 Q8nZGZgB33styjuN8Zn3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BvaH4uwb+as=;eghNh+tPDo1bl5WWssSvAl+lwWN
 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
 tPmaOuad63FYbTMH8qCV33I=

> Fixes:

Does your wording approach contain a description conflict?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n81

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n145


Please avoid a typo in the summary phrase.

Regards,
Markus

