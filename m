Return-Path: <linux-kernel+bounces-741397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDAB0E397
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB871889154
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB192820B2;
	Tue, 22 Jul 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaqTl2U9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52123B60F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209615; cv=none; b=cluRCKAti928M5WF4p7MUksie+0nVeH1YM2OJwVIiJ4iURorfztAX4ceKTo+LFO3/6I2wNkHx6n8DcnMAd/pfCTybbzE/aJehKC/KB2RUuic0SvqURD0HaPRvhzlLavBJJGOS95eMn9/LcA/Y+lHp8DO7pMeuA0bfKr8sUqJW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209615; c=relaxed/simple;
	bh=hDMUXTgz7Hc86jPQuUcegZKFiRyhVh9fcABSo4hn81M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6PDr2gv4KgobtQyr4+moMZR+2YlmdC9trMcRF0jbGjVV7n5pjZ97NrsMej5bONHOYqExN58OUshK7jxDJCigVNURA+eaI9SeiLEll6Cr1keJh8mxAyUx/BYlAxWRBn8Lj9+ACQ/VwHatNbrf+uXPk1F4vmNGIpSmvx0y0XBwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaqTl2U9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753209612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K34+Z22KT3elEsXYwXLyG4pL36Sa3R8d3KGcbmmY2fg=;
	b=BaqTl2U9Kyh2bfQnrupXCfxYGM/bau6Kz5+bqUwFSyP4zIqk+0ZyMZ7xaSJod90dJ3tUq5
	EYjaPdA8/2BM0689hINZ+3CGWSjwHAy/DJCuqOrYZdsOD9vv+1gwRghRQoLENYN+qqFIKg
	7MDXikpP25GIHqZ7PSFunR9nfco/fJc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-Yr2wKIQkM-m1T2obASVdUg-1; Tue,
 22 Jul 2025 14:40:09 -0400
X-MC-Unique: Yr2wKIQkM-m1T2obASVdUg-1
X-Mimecast-MFC-AGG-ID: Yr2wKIQkM-m1T2obASVdUg_1753209607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E5F11800295;
	Tue, 22 Jul 2025 18:40:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B76918003FC;
	Tue, 22 Jul 2025 18:40:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Jul 2025 20:39:00 +0200 (CEST)
Date: Tue, 22 Jul 2025 20:38:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722183853.GD2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
 <20250722175807.GC2845@redhat.com>
 <548B24CC-2E58-4CC5-9025-950408BDCAA5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <548B24CC-2E58-4CC5-9025-950408BDCAA5@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/22, H. Peter Anvin wrote:
>
> On July 22, 2025 10:58:08 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote:
> >On 07/22, H. Peter Anvin wrote:
> >>
> >> On July 22, 2025 3:50:35 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote:
> >> >
> >> >The generic implementation doesn't WARN... OK, I won't argue.
> >> >How about
> >> >
> >> >	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> >> >	{
> >> >		char ok = 0;
> >> >		u64 q;
> >> >
> >> >		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> >> >			_ASM_EXTABLE(1b, 2b)
> >> >			: "=a" (q), "+r" (ok)
> >> >			: "a" (a), "rm" (mul), "rm" (div)
> >> >			: "rdx");
> >> >
> >> >		if (ok)
> >> >			return q;
> >> >		BUG_ON(!div);
> >> >		WARN_ON_ONCE(1);
> >> >		return ~(u64)0;
> >> >	}
> >> >
> >> >?
> >> >
> >> >Oleg.
> >>
> >> Maybe the generic version *should* warn?
> >
> >David is going to change the generic version to WARN.
> >
> >> As far as the ok output, the Right Way™ to do it is with an asm goto instead
> >> of a status variable; the second best tends to be to use the flags output.
> >
> >This is what I was going to do initially. But this needs
> >CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> >
> >Oleg.
> >
>
> But that's what you want to optimize for, since that is all the modern compilers, even if you have to have two versions as a result.

Well, this 'divq' is slow anyway, I don't won't to add 2 versions.
Can we add the optimized version later if it really makes sense?

Oleg.


