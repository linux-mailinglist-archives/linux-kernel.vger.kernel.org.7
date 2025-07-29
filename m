Return-Path: <linux-kernel+bounces-749592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D2B15054
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2D7189A911
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BA881E;
	Tue, 29 Jul 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am9Y7coD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4ECA4B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803712; cv=none; b=NN4a7rmseOpP08F+EjK7euxSInSI3432xWGJd3TBIATOfjluyDsy7JJmDkwpWOt2w3OBX/W2KOuGEWf1QPlLX+Ab97QIh99whFGYBDlxasqgEbNg+roizO0rtaQB1NWXwF/7oa3tzIAXuK7n7znhmmbwlWQsiQ9YPhlQvBAk0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803712; c=relaxed/simple;
	bh=vISfz5sdL11RdnhGuLlTC8sk7lElm/m3E0L3DESxM/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxNzirz2BRSAX+BanNtO3MHbHZ8eRXgNz6KoK5yKOSmokxujCGMJfe3BKfQfYs0At1PxjA+ARX/wMNRJkTHLCJHAO208v0P8N6h2hDQvpoWxFiakWiyhM27hpyvODSzuzRQ1nM4odtb2VUoKowGi8tWcwlDvVG3MG5BzCSYTjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Am9Y7coD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753803710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1J7AmMn/wOMGDOuHEtuhBMnA2xG0K8EqVBM4GAg58o=;
	b=Am9Y7coDjwbLeMB/OpALD9IinfXdwb0gsl2JjcKpc08V/O321pFTIMga38gWPyspPbTDqX
	5pIpbaat12jyZTYM1mYrs5dqY3ieqT288PW/Zzksd4WKNwZzfWI897qJNc/QTL0V3C3bGt
	I54Tx3I02v7korAEkHJe6+jZhVYsBrM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-HS0o7SEVN9WA6ti8LWAS5g-1; Tue,
 29 Jul 2025 11:41:44 -0400
X-MC-Unique: HS0o7SEVN9WA6ti8LWAS5g-1
X-Mimecast-MFC-AGG-ID: HS0o7SEVN9WA6ti8LWAS5g_1753803702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79D1D19560B1;
	Tue, 29 Jul 2025 15:41:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 924701800288;
	Tue, 29 Jul 2025 15:41:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 29 Jul 2025 17:40:33 +0200 (CEST)
Date: Tue, 29 Jul 2025 17:40:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fan.yu9@zte.com.cn
Cc: tglx@linutronix.de, frederic@kernel.org, peterz@infradead.org,
	brauner@kernel.org, iro@zeniv.linux.org.uk,
	joel.granados@kernel.org, lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next v2] signal: clarify __send_signal_locked
 comment in do_notify_parent
Message-ID: <20250729154025.GC18541@redhat.com>
References: <20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/29, fan.yu9@zte.com.cn wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2252,8 +2252,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  			sig = 0;
>  	}
>  	/*
> -	 * Send with __send_signal as si_pid and si_uid are in the
> -	 * parent's namespaces.
> +	 * Use __send_signal_locked() instead of send_signal_locked()
> +	 * because si_pid and si_uid are already in the parent's
> +	 * namespace. send_signal_locked() would incorrectly modify
> +	 * them when crossing PID/user namespaces.
>  	 */

Somehow I'd still prefer the previous version which simply kills this comment,
but as I said I won't argue.

However. It seems to me that the new comment adds another confusion. I'll try
to recheck tomorrow, I am very busy today.

Oleg.


