Return-Path: <linux-kernel+bounces-740671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191FB0D787
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F223ACF69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DF2E06DC;
	Tue, 22 Jul 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC6M2931"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6A1ADFE4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181520; cv=none; b=GPcN3YN7yvGuvL4zfPpsAzOrVvkPYOxD7oIQJJXklI9zCTZEj92k9KDNr1tSURZ1vjekRY+ZcFkQsyvbs4EwTkOlch2LhR8RbbCYa4IWH1uYzphZk0AzwdzeOrPpFMFUEbnbMrEv8+rM52PE6o/0+znRikdp0izDVbpbiLutpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181520; c=relaxed/simple;
	bh=EmtQaHBBqvXF8TRmduEhCY/k8xKYQ5N6t06eZ20tw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/sNAXp0Fd/8zAfTMkZsX5JaxOYuSYuAGSb/4W9bg1NZBMtQkeHQuT7lukkLbyL+gi3KpQuoTvXlTlFIyR1sDpMM9j5Qbqkrcf45rDS6GuONJrPDqtM52JOeQlmswyZxOTlGzPVwebSSwOSR4yTwvPvZ+g3ZCTFRR05/KoaEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC6M2931; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753181517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2A6GqyZiCgCOV16EoyO661L38WmuIcBtmRY7TRDQ19U=;
	b=PC6M2931RR6FNLYeLGbrnqEtc6obFa0LaVw7hlYZIjlhdgayN9BiEGIP1X1y6olgQoHQN9
	nBe9lx20CLnRrtqwbUsQ+UGQ5C0z/UW3HhESltu/77KxjG4bBGpqWkAIn8EH/5HawhpZ9B
	DLShvI+Vgm8mAxApk8FEgQI7EBLR+fg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-sd78svTiOWeuI3epI8xj9g-1; Tue,
 22 Jul 2025 06:51:52 -0400
X-MC-Unique: sd78svTiOWeuI3epI8xj9g-1
X-Mimecast-MFC-AGG-ID: sd78svTiOWeuI3epI8xj9g_1753181510
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBAFB19560AD;
	Tue, 22 Jul 2025 10:51:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 65C5A1956094;
	Tue, 22 Jul 2025 10:51:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Jul 2025 12:50:42 +0200 (CEST)
Date: Tue, 22 Jul 2025 12:50:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722105034.GA2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721192053.58843751@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/21, David Laight wrote:
>
> On Mon, 21 Jul 2025 15:04:22 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
> > fit u64, this matches the generic implementation in lib/math/div64.c.
>
> Not quite, the generic version is likely to trap on divide by zero.

I meant that the generic implementation returns -1ul too if the result
doesn't fit into u64.

> I think it would be better to always trap (eg BUG_ON(!div)).

Well, I don't like adding a BUG_ON(), but OK.

> The trouble there is that (an ignored) ~(u64)0 is likely to cause another
> arithmetic overflow with even more consequences.
>
> So I'm not at all sure what it should look like or whether 0 is a better
> error return (esp for div == 0).

I'm not sure either but x86/generic versions should be consistent. Let's
discuss this and possibly change both implementations later?

> >  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> >  {
> > +	int ok = 0;
> >  	u64 q;
> >
> > -	asm ("mulq %2; divq %3" : "=a" (q)
> > -				: "a" (a), "rm" (mul), "rm" (div)
> > -				: "rdx");
> > +	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
>
> The "movl $1,%1" is a 5 byte instruction.
> Better to use either 'incl' or get the constraints right for 'movb'

Agreed, thanks,

> > +	if (ok)
> > +		return q;
> > +	WARN_ON_ONCE(!div);
>
> I think you need to WARN for overflow as well as divide by zero.

The generic implementation doesn't WARN... OK, I won't argue.
How about

	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		char ok = 0;
		u64 q;

		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
			_ASM_EXTABLE(1b, 2b)
			: "=a" (q), "+r" (ok)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx");

		if (ok)
			return q;
		BUG_ON(!div);
		WARN_ON_ONCE(1);
		return ~(u64)0;
	}

?

Oleg.


