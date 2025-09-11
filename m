Return-Path: <linux-kernel+bounces-812490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD284B538D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49C2B64782
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FF35082D;
	Thu, 11 Sep 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDXyDJpQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFFr/485"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0B352098
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607156; cv=none; b=a19sI96emUVi42EAwWtIdNZ7sJq4IDeStaXXBFt0SXqTcEAm8Tc3QKfd2jE4NMml2tnjCAoIg3rAfWwJzh5mvC91ahmUXrgTZxdEVUbCAnTXKi3MT99vN/q8JHVmYkS2gluHZwfa6VTfjQHjBqXb3yNhqjE+rPi2yMR9H5UvV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607156; c=relaxed/simple;
	bh=gZnRkIwo+R4sRadUL4BTK8350ukasNULlJLKoGVv1Jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLEmufUFXY2iPgx7HKsLmmr8Q5Jq3k5PCJ2EtJMNQ6rEKRudidITp5T5rE1hM21hBpz5GFKST0vyPSJWXUdLT+wcc7/hRpnUxsx75FWmY5g8+C59cy3xduvlmfGjYaqB29zYScRcLav0nRmE4huImm6zKsHN4i/whE31iCdZi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDXyDJpQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFFr/485; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757607152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eJw5MnZV2BIDwczGalIRnCvulLiYt2egtKyQgbZAgs=;
	b=CDXyDJpQ+A7OStCOaYCPj5MJt+7Abdl71Jjs+TE/3O90DEBs0jj+g198loAJR4xArUVQhI
	tS+fEchCewB13fi9G5T3cIc4u6AR3ed0O26J3/Uwor/nBCgbUIY8FwzGxUQSb5hWK1JGYi
	ixcbbVkrOdmNTb2e/tTdLU0rj2NcTbQE6ruH7gKNxpG8bCFBR6jqE+8230Eufiazchgi5k
	EJbh++kr06qJBZgEqgA595LqjVsT34YIdkfjaa5htkNq7nN2UyB/MCpCiMvJfL8s1uBxD6
	tgscoBSZWVxK5ILOHoeyfANxJpf0vhGxylo5JiMgN3lBXm67ymhMHCN251mk7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757607152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eJw5MnZV2BIDwczGalIRnCvulLiYt2egtKyQgbZAgs=;
	b=rFFr/485C9ARP4H/u1JWSOyDMG8narGNBO/asGFBv0qRny1nWqOj0WjufQxMpYDLbJYUEW
	sI+wq6VPO6CMfzBg==
To: Petr Mladek <pmladek@suse.com>, Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
Date: Thu, 11 Sep 2025 18:18:32 +0206
Message-ID: <84bjnhx91r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-11, Petr Mladek <pmladek@suse.com> wrote:
> diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> index 2282348e869a..241f7ef49ac6 100644
> --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> @@ -56,7 +56,7 @@ struct prbtest_rbdata {
>  	char text[] __counted_by(size);
>  };
>  
> -#define MAX_RBDATA_TEXT_SIZE 0x80
> +#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))

I guess this should be:

#define MAX_RBDATA_TEXT_SIZE (256  - sizeof(struct prbtest_rbdata))

John

