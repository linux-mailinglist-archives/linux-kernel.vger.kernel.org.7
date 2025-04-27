Return-Path: <linux-kernel+bounces-622175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09CA9E3D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3143B9120
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53C1DE8A0;
	Sun, 27 Apr 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW8AziDb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737A1DE3CE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745769119; cv=none; b=d5FcqZGx9OmdnKkFBjAzhWqz6vZHpSG9cij1IidtawTCxB4i3m+yyTqbFmuv6QsTtAhhlQ/Rp06bZGa0qb90HU9zoBLpocMO369EA31vDloFLm66bNGLaN1yow8Glxk+eRrri0ZW5rli1v2uG6soTZKPmIrMB5qQnkEm1jwN/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745769119; c=relaxed/simple;
	bh=fB1w5EdlophF9FygpQ1v2gxIq4Vfe+fEHjSkE38dAW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8EibkJuQI78j4I5EKOoXYnMoit0dv4SjC5vfcMCKTD9ACRJ4qoTf6HVTBBxj5qCEz6AvCiGV/x9jbI8MCv++dd4/bWqFjU8c1NkUhr0s5EMcBlI7h1F50kpiBIvUwDrAJXy9azfyntNofqyHTvshDLkOq8inI/elKj01pJ0IgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW8AziDb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745769116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEsO7LxrjwCVQiphxbxj8Q1M9BC5vnt9cQxUJ75ymR0=;
	b=CW8AziDbeyfLDs6qRpKHLpcEbNLInUvpzdHlWBwng1xnWGuXzcCLz5Ts+jUm4AsdRCMQ3+
	RvnsXFyjU+P4BxwEdDWQIQQAWu5oLyqbpI7D9YemWoweQozVsRNyfYWXBzjMrvfEFil9XT
	Fw6KV5p2ooTexnScc928NSoJrEmf2fI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-JrxdJ07tOBin5wljtoGs2Q-1; Sun,
 27 Apr 2025 11:51:50 -0400
X-MC-Unique: JrxdJ07tOBin5wljtoGs2Q-1
X-Mimecast-MFC-AGG-ID: JrxdJ07tOBin5wljtoGs2Q_1745769108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 625D21956088;
	Sun, 27 Apr 2025 15:51:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DA0BC19560A3;
	Sun, 27 Apr 2025 15:51:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 17:51:09 +0200 (CEST)
Date: Sun, 27 Apr 2025 17:51:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 09/22] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <20250427155059.GD9350@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-10-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/21, Jiri Olsa wrote:
>
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.

...

> +SYSCALL_DEFINE0(uprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	unsigned long ip, sp, ax_r11_cx_ip[4];
> +	int err;
> +
> +	/* Allow execution only from uprobe trampolines. */
> +	if (!in_uprobe_trampoline(regs->ip))
> +		goto sigill;

I honestly don't understand why do we need this check. Same for the similar
trampoline_check_ip() check in sys_uretprobe(). Nevermind, I won't argue.

Oleg.


