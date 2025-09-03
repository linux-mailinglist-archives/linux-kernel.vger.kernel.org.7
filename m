Return-Path: <linux-kernel+bounces-798449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB516B41E21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52518160244
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE259286428;
	Wed,  3 Sep 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6v6y2my"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C328466F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900853; cv=none; b=UCTQeDbY243yT/nwAAcA1lZyhWDZ/M7NKTfEVewmYWNY0Y5okRQd1lDv6yDRzCPV3jcujfnyaxsLmEONs7jTN6OMB8n/orfO3KQLtJhklbQzURIxOo6yICCgy+kPnF8YDH8xSK7KG5CNpugtMvXZuDjDPHtyCQ6A8xx5eMFldxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900853; c=relaxed/simple;
	bh=+grVyZxAWtKNFWpbultXM2V6yd2mmR2F3jJF5AT5BFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUHFmYgW+a+TSppsPRrSry5JQtokPxNrajc0+9+nk5N9JtDHgygkhbdybS4BQH92Tqcw5jFrfgSULqn8MKhJ5xo8qwhXwZXijvt/ZkEw3k8OeZTc8JLzOJvqltXzBwY1O8llqrjLRcnAlaiAtUi76rd9aFG0P6m5cECZ1moAaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6v6y2my; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756900850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nw6naDuPKKSADEwjZLNE9uKM8R6m9CFTff86lS75ms=;
	b=D6v6y2myBsfYHOJWPkVGh1cmyrtwYl0+jSTXGzcWtQuYUPivOXCk/7lsqYJ343vduS8omS
	teiiq27WMtH1wq5Mlc3XeO5WjkUgYfrCRxIQalgN1Fbr2yuskwC9SdEvQ+u3kp+sEeK6fi
	ugApB7AcK8kQeMxfdNL0+GqBUGmuAxA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--AUOuqbjOgiGyYcAnxfZKQ-1; Wed,
 03 Sep 2025 08:00:48 -0400
X-MC-Unique: -AUOuqbjOgiGyYcAnxfZKQ-1
X-Mimecast-MFC-AGG-ID: -AUOuqbjOgiGyYcAnxfZKQ_1756900842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B7461800291;
	Wed,  3 Sep 2025 12:00:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 446F31800446;
	Wed,  3 Sep 2025 12:00:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 13:59:19 +0200 (CEST)
Date: Wed, 3 Sep 2025 13:59:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
Message-ID: <20250903115912.GD18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Slightly off-topic, but

On 09/02, Jiri Olsa wrote:
>
> @@ -11144,7 +11147,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  {
>  	int err;
>  	unsigned long ref_ctr_offset;
> -	bool is_retprobe;
> +	bool is_retprobe, is_unique;
>  
>  	if (event->attr.type != perf_uprobe.type)
>  		return -ENOENT;
> @@ -11159,8 +11162,9 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> +	is_unique = event->attr.config & PERF_PROBE_CONFIG_IS_UNIQUE;
>  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
> -	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> +	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe, is_unique);

I am wondering why (with or without this change) perf_uprobe_init() needs
the additional arguments besides "event". It can look at event->attr.config
itself?

Same for perf_kprobe_init()...

Oleg.


