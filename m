Return-Path: <linux-kernel+bounces-841228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B1BB68FC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D95D48036A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC127281D;
	Fri,  3 Oct 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuKLof1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEF25A338
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492194; cv=none; b=NK7EnJcWIJQBzlniy+OVsxzQXoHkaddVY5J5j71c3r0S1vcoekLzmXrklxTgb2ocpg3DpToFCGD7tkZkjbHVKYVNS5OB8UH1KMN6qziPQROpWFVGzeNJ+nqVdV6GlijQ8U/sFDgrXmeLW4xUYUVQwElJqH4VBNy4xjaoRHDvf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492194; c=relaxed/simple;
	bh=ChVp9KK5VYC24c4PGIVC8sIuSiyWxtH3Wug7gY5L/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBPYCwX6pHFGFbAhIC7HixLcInqHFZlMZyqBoBXEkOQdfa6qFbhwLNG8w323sWwP9sZFz8UfwHUipOnYaRNuWThwtNDdeoe1yulTnsTnrrxSsQRGXb601bNah+Kg1bl/RE+MdQFWkOTM2nmvkchLnCN7YBdT9HQgEonaXmq8f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuKLof1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759492192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSqrqsAeKH98aMV7qW4Dfz7O++V6OieZSCKqHyzEpCM=;
	b=HuKLof1axR1LsMlVvIY0eAL/W73CGeZnLBtFNzs0HlEpQ1u2SApE4k03R14Big6xbCZbCk
	Rsx1nE231jMiIEe7PqqMwz4JtzXlsft4i1e1T9ejEloNH6Ka4uCd3lP594z+3Ocrv3uI7q
	xRjWXsSV/jvqSBQcVqVyzOjk5zmYPak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-kEFwZDOLPLaNPfrwhYlYDg-1; Fri,
 03 Oct 2025 07:49:48 -0400
X-MC-Unique: kEFwZDOLPLaNPfrwhYlYDg-1
X-Mimecast-MFC-AGG-ID: kEFwZDOLPLaNPfrwhYlYDg_1759492186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E501800370;
	Fri,  3 Oct 2025 11:49:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4FF0C180035E;
	Fri,  3 Oct 2025 11:49:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  3 Oct 2025 13:48:23 +0200 (CEST)
Date: Fri, 3 Oct 2025 13:48:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers
 execution
Message-ID: <20251003114814.GA14763@redhat.com>
References: <20251001132449.178759-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001132449.178759-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/01, Jiri Olsa wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
>  
>  	handler_chain(uprobe, regs);
>  
> +	/* Try to optimize after first hit. */
> +	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>  	/*
>  	 * If user decided to take execution elsewhere, it makes little sense
>  	 * to execute the original instruction, so let's skip it.
> @@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
>  	if (instruction_pointer(regs) != bp_vaddr)
>  		goto out;
>  
> -	/* Try to optimize after first hit. */
> -	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> -
>  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>  		goto out;

Acked-by: Oleg Nesterov <oleg@redhat.com>


