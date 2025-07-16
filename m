Return-Path: <linux-kernel+bounces-733944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C8B07B12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5FC1C24B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367B2F85E5;
	Wed, 16 Jul 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFKTPmQH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5902F85D6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682708; cv=none; b=NewPMBy1wLNeNoFy8JQ62R2WAdri65gDQonhA3n7Ojt1R3Pi1uziTe06PvCoBaoLpMaDl4pVRgb2/FpfT7LjqN2xtb8uucaZdsKq3uADCmvSUYyprdQxGy1aGj9HOAyAnxmt0w2Fby6SNwfsZO7voVgMGAMhauWT9YSkXd0a8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682708; c=relaxed/simple;
	bh=JRiJ26sImjZZNvW6uY9bmrbxPyx7a4op7ENavgK5FhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mme3etmovbUwkp1tt0Ip2u/6AfCapLLsSryLWUhbAUG3dEQEK5wkc9ByRq6siZoQz5NT9XKMth8xJn2MjkVUaQC3u95GxylgSiQ7P3Ecgw5tnhsIqZPTzTSqzwJP3qH8pgfJ54ITcK8muq5KJ9NeBYn+iAXIKbGjN8gWgWAkNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFKTPmQH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNTJPf1qrtrVminYo7MF0aXGvyuZuOKZUtlz/hKO1+E=;
	b=PFKTPmQHvhngI/0qJQ2YU2+DR5gXQHTDZwWNwc6j8CK9eKxjgvoBV1Q4E7xctDPT2XwArq
	H20MDhDCYcO8C24DKHA/0Q+Pu1NLiYFRQk4d/ikicnS5+TjyydgIa7UpVhVBsKhay1LrNS
	TxC46lQtjeBbku+XoF8QhwPSeNtB9OY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-8nBeXmVYMjOwXgB8F_F3Dw-1; Wed,
 16 Jul 2025 12:18:21 -0400
X-MC-Unique: 8nBeXmVYMjOwXgB8F_F3Dw-1
X-Mimecast-MFC-AGG-ID: 8nBeXmVYMjOwXgB8F_F3Dw_1752682699
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65CD218CC6D4;
	Wed, 16 Jul 2025 16:17:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.192])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6609D19560AB;
	Wed, 16 Jul 2025 16:17:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 16 Jul 2025 18:16:28 +0200 (CEST)
Date: Wed, 16 Jul 2025 18:16:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>, pavel@kernel.org,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Message-ID: <20250716161624.GD16401@redhat.com>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
 <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
 <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>
 <20250704092144.GH2001818@noisy.programming.kicks-ass.net>
 <de7e327a-202c-4b28-b372-2d648c680dbe@kylinos.cn>
 <20250707084214.GD1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707084214.GD1613200@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I don't like the patch Zihuan, but

On 07/07, Peter Zijlstra wrote:
>
> Anyway, this seems to suggest something relatively simple like this here
> should do:
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 8d530d0949ff..8b7cecd17564 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -162,20 +162,22 @@ static bool __freeze_task(struct task_struct *p)
>   */
>  bool freeze_task(struct task_struct *p)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&freezer_lock, flags);
> -	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> -		spin_unlock_irqrestore(&freezer_lock, flags);
> +	/*
> +	 * User tasks get NOFREEZE in do_task_dead().
> +	 */
> +	if ((p->flags & (PF_NOFREEZE | PF_KTHREAD)) == PF_NOFREEZE)
>  		return false;
> -	}

I don't understand your change...

It probably makes sense to avoid freezer_lock when PF_NOFREEZE is set but
it can't change the current behaciour, freezing() -> freezing_slow_path()
checks PF_NOFREEZE too and returns false in this case.

Oleg.


