Return-Path: <linux-kernel+bounces-600686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB3A86356
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D55B3AD580
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397E21C167;
	Fri, 11 Apr 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGwhVadp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571726AD9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389213; cv=none; b=GZf4DwbWYAB+8vARjrmpiImhh9NgrC/UlQikOQ+Mm3Nw+bqJqJDIy5nKpY419pYjWisKcdf77CbGyp/5QkmoF6+SKgF56qabVKP+XYq6De5YSsQHClIcjUndqQgDJZvGVKTF3QPzBerVXU9QWriG6fDCyy1CA/JsS9F6pihoqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389213; c=relaxed/simple;
	bh=om9nbYY+KdTzhbx+Sci7wStJf0iLFQJL8AB1prjTKfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx8gMq5dHfLH3EAT4mJgUni3KuYUnA/zcU464g7AuYgOyBfuWYQkKoUvejuUCHnl7RqOcdBB7Mw6XSF2B8KS42lq8xt7J2VoqjSjihQFSt6pjQcHU2Tk2gosk0oxmv7QqGfqhiQyQdd7WfgUTHcVVCDBaoXl3XrQrPI1QzEAkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGwhVadp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744389211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaXhGD+EESkN0U5oQ1NX+Je+maGDUC3Z+TV9kV3doiU=;
	b=PGwhVadpxrq453G79e4pHBRatPpVj45s3orU7rMEtWrfwYo503+EupkNYHUjNRbpkb5pLh
	9rKyjiYEVpr0tvAc9b71T7lZ6eGoowBmwFb0cZuK2Lpq9L0md2ZSHbcAhUHIixJWIWKlvx
	+RXoxczMMc6IqWrADN6xYVuSmsgbbUk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-ZH1NnPKVPMW98a8LUrDwLQ-1; Fri,
 11 Apr 2025 12:33:27 -0400
X-MC-Unique: ZH1NnPKVPMW98a8LUrDwLQ-1
X-Mimecast-MFC-AGG-ID: ZH1NnPKVPMW98a8LUrDwLQ_1744389205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A75A1954B36;
	Fri, 11 Apr 2025 16:33:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A5DB91955DCE;
	Fri, 11 Apr 2025 16:33:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Apr 2025 18:32:49 +0200 (CEST)
Date: Fri, 11 Apr 2025 18:32:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv2 perf/core 1/2] uprobes/x86: Add support to emulate nop
 instructions
Message-ID: <20250411163242.GI5322@redhat.com>
References: <20250411121756.567274-1-jolsa@kernel.org>
 <CAEf4BzbvMYJf5LLxwamYpzzu=Sewzti-FR-9o4AGfU+KZu0b1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbvMYJf5LLxwamYpzzu=Sewzti-FR-9o4AGfU+KZu0b1Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/11, Andrii Nakryiko wrote:
>
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -840,6 +840,12 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> >         insn_byte_t p;
> >         int i;
> >
> > +       /* x86_nops[i]; same as jmp with .offs = 0 */
> > +       for (i = 1; i <= ASM_NOP_MAX; ++i) {
>
> i <= ASM_NOP_MAX && i <= insn->length
>
> ?
>
> otherwise what prevents us from reading past the actual instruction bytes?

Well, copy_insn() just copies MAX_UINSN_BYTES into arch_uprobe.insn[].
If, say, the 1st 11 bytes of arch_uprobe.insn (or insn->kaddr) match
x86_nops[11] then insn->length must be 11, or insn_decode() is buggy?

> or, actually, shouldn't we just check memcmp(x86_nops[insn->length])
> if insn->length < ASM_NOP_MAX ?

Hmm... agreed.

Either way this check can't (doesn't even try to) detect, say,
"rep; BYTES_NOP5", so we do not care if insn->length == 6 in this case.

Good point!

Oleg.


