Return-Path: <linux-kernel+bounces-802410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C71B45224
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507F71C24D83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C522FD7A4;
	Fri,  5 Sep 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/MqlPoK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BF27FB27
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062414; cv=none; b=lAyD5F5Z0j2E5erP1Be4gfhsPEW93u1IveiHQgxdoVH52V74/BGBmChUSkS0J8XqG1ycXFdZB2fILSa99pyXrwSkpfcGgIpe8J/RfN96AN0Za5QwenNSp9fC7zvwy1PJeb0ByYl8+3WixNU5T6bgKCoj1d+hxGSKq9AfsVgcIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062414; c=relaxed/simple;
	bh=dcdyIOSIHdWK4hUmpfn/IRSAzQGUbzHF2AD9bcA3XYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqI42Fcabbw/wisLmDfmq5vZikcg147hwNia+oRhVF7cz3C5/4SFswymDZTB7yQOtsxC5dmged6eAyitPGXSvl2IFoUkZrviJXhymePE88Fchl/YTBInO3gKVwOJnRMEcgrhXyE1Oz3iF0dj2PBim//Ob/BN83mC710wvoB4f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/MqlPoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757062411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcdyIOSIHdWK4hUmpfn/IRSAzQGUbzHF2AD9bcA3XYA=;
	b=Q/MqlPoKU7/gNf1sxgQP/KhEfGer7xlTzIt46Wzs8Qi4jx6hgyfbKP70ilggOjMKlgxt7L
	zpYjFqgbfCzLQh1/Yf0encufSSoa6kYyMvEHAZW05ChhNUxuOyEVsNsHKtFYpt/UJmyV22
	Oraw87W7k3G7nmHMUraHhvr+qxyOc/c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-yoJ3J4YrM3ORNbUgzmsrFw-1; Fri,
 05 Sep 2025 04:53:27 -0400
X-MC-Unique: yoJ3J4YrM3ORNbUgzmsrFw-1
X-Mimecast-MFC-AGG-ID: yoJ3J4YrM3ORNbUgzmsrFw_1757062405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA981956056;
	Fri,  5 Sep 2025 08:53:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B372418003FC;
	Fri,  5 Sep 2025 08:53:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Sep 2025 10:52:03 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:51:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
Message-ID: <20250905085155.GA12770@redhat.com>
References: <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
 <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com>
 <aLluB1Qe6Y9B8G_e@krava>
 <20250904112317.GD27255@redhat.com>
 <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
 <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com>
 <20250904185553.GB23718@redhat.com>
 <CAEf4BzYb=mqN84a8+xc-Du1QkUBYMgwAuStYqastJJHQE4Os5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYb=mqN84a8+xc-Du1QkUBYMgwAuStYqastJJHQE4Os5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/04, Andrii Nakryiko wrote:
>
> On Thu, Sep 4, 2025 at 11:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > That said. If you guys don't see a problem - I won't even try to argue.
>
> I don't, yep.

OK. Then I am fine with that too.

Oleg.


