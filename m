Return-Path: <linux-kernel+bounces-742198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A613CB0EE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FC97A730B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC728727F;
	Wed, 23 Jul 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ9OHUB/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712127FB2B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263591; cv=none; b=jLQta/S7Bk3ye34s4ebb4DVYbgpE3qy7x4xFHv71EM6uTXN564vUAnP03AlsSTUFIV1wo24AxXB6wTb83CzHyIpLc3SDfbKF37UmlZVxYiHSEue/kk1F7caVHw0jX6FOsT8HPIRUKUEVXApUW9bfp7JsMifMvb4lw2FLPzkz1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263591; c=relaxed/simple;
	bh=ZZMiOkTKAuH3HUG6tIfNAaC62+aY169CITOS7lDGBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMxqjLNyhKUJjKugON1A0PQoCT7vTxHysQ1eJe1FRaVY+kinvFgOCfVjYVuN4GpII1Lm2/3E23t7xJ/RUX9xtsmVoSPrOXnqgimB/jbT10F/iX+gIOERPBTlgXT8r0fGUjvDrKy1b2RS9Z/u/5Mr4kINXMpCGLTpdRX4GXpkyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQ9OHUB/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753263588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InZjvz0gNDpy0srRvycWJ6NrK0VNQixWGEtUgtzFMpY=;
	b=hQ9OHUB/URLQk33x67hkPMGyNqxdpsziDZrpNCyltLw0v7D3HzuBBalw9yAWG/QiUYY2GB
	2NrYLVo4cGZu5TOpIc5IJ8bE9EB0hMoSn0Avd/DU5GsP6QLd2j56xvI6y6Z69KBdICG0kS
	yN8eAC9NYARSzUI63phX3WhcrrDUTVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-DYDLXrWfMjm9CT6AckOlvA-1; Wed,
 23 Jul 2025 05:39:41 -0400
X-MC-Unique: DYDLXrWfMjm9CT6AckOlvA-1
X-Mimecast-MFC-AGG-ID: DYDLXrWfMjm9CT6AckOlvA_1753263580
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AF101800286;
	Wed, 23 Jul 2025 09:39:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.165])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5A12195608D;
	Wed, 23 Jul 2025 09:39:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Jul 2025 11:38:32 +0200 (CEST)
Date: Wed, 23 Jul 2025 11:38:25 +0200
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
Message-ID: <20250723093825.GA12884@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
 <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722230341.5a1cc5e5@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/22, David Laight wrote:
>
> On Tue, 22 Jul 2025 15:21:48 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > 	{
> > 		char ok = 0;
> > 		u64 q;
> >
> > 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> > 			_ASM_EXTABLE(1b, 2b)
> > 			: "=a" (q), "+q" (ok)
> > 			: "a" (a), "rm" (mul), "rm" (div)
> > 			: "rdx");
> >
> > 		if (ok)
> > 			return q;
> > 		BUG_ON(!div);
> > 		WARN_ONCE(1, "muldiv overflow.\n");
>
> I wonder what WARN_ON_ONCE("muldiv overflow") outputs?

Well, it outputs "muldiv overflow." ;) So I am not sure it is better
than just WARN_ON_ONCE(1).

> Actually, without the BUG or WARN you want:
> 	u64 fail = ~(u64)0;
> then
> 	incq $1 ... "+r" (fail)
> and finally
> 	return q | fail;
> to remove the conditional branches from the normal path
> (apart from one the caller might do)

I was thinking about

	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		u64 q;

		asm ("mulq %2; 1: divq %3; jmp 3f; 2: movq $-1,%0; 3:\n"
			_ASM_EXTABLE(1b, 2b)
			: "=a" (q)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx");

		return q;
	}

to remove the conditional branch and additional variable. Your version
is probably beterr... But this is without WARN/BUG.

So, which version do you prefer?

Oleg.


