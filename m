Return-Path: <linux-kernel+bounces-740889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B7B0DAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118586C6368
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB32DEA8D;
	Tue, 22 Jul 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+pkVyKm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEC1E87B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190594; cv=none; b=rXRYi4op/I9jg+6LChYfUyol4avTW8jfjnvsjfOGiU9y9b9mx0PUy6IYTxJOfcZAWES9cLmZC2thNZWnuyI/a2BttJ6gLdhukNuAyWREJQvNGXXHXJaWt7eUWq362bEV7X5tvneVRuCzW/JBhk+PFm7yo6qPmi5DZDyjPH0Spd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190594; c=relaxed/simple;
	bh=F7zgOjGynLG0e1h5SgggMQDUXHUhSi8vh+4msWiqhLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIk3R0LTsZZ54j5crwMg9emAabLHSgWWKKOALpNlmTI4YgYTUV+SDAyVhgi3CEqQXHn7L2CvG8Iwm0iII40dcMDf15eJh29OgNq7bUjBkVES3Y1ILWBqxMeyeNJ3LHtHW8YEkNbgKxLj1sPnZYMPo/bzf/TKnb92y1lI987zzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+pkVyKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753190591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/UAzx9bFVrxWBaBFQYHutx8ZvPa4hdtccuMJFT2KKY=;
	b=N+pkVyKmsY1VbsNKqMcMxc6BhtXvy9r219sPkY9PQuU4JHC242UoBJcIooigILeJ/NRFMA
	Uuu5SCbh7oeO/fyYmCaZemoFGQZDZduB5L/YgkmzgzROsA/BkG6/7R3fZi9BmYSDayiwJG
	3h2ZXV5vnATNqNl8NZXgy3v/2J7knIw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-ylNM2Z98NF-AX7fnPGTr5A-1; Tue,
 22 Jul 2025 09:23:09 -0400
X-MC-Unique: ylNM2Z98NF-AX7fnPGTr5A-1
X-Mimecast-MFC-AGG-ID: ylNM2Z98NF-AX7fnPGTr5A_1753190587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD50C1800C2F;
	Tue, 22 Jul 2025 13:23:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2DB2B180A306;
	Tue, 22 Jul 2025 13:22:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Jul 2025 15:21:59 +0200 (CEST)
Date: Tue, 22 Jul 2025 15:21:48 +0200
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
Message-ID: <20250722132147.GB2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722130947.0c97c96a@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/22, David Laight wrote:
>
> On Tue, 22 Jul 2025 12:50:35 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > 	{
> > 		char ok = 0;
> > 		u64 q;
> >
> > 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> > 			_ASM_EXTABLE(1b, 2b)
> > 			: "=a" (q), "+r" (ok)
>
> That needs to be "+q" (ok)

Thanks... I will never understand the asm constraints.

> > 		if (ok)
> > 			return q;
> > 		BUG_ON(!div);
> > 		WARN_ON_ONCE(1);
>
> I know there are are a lot of WARN_ON_ONCE(1) out there,
> but maybe WARN_ON_ONCE("muldiv overflow") would be better?
> (The linker will merge the strings).

OK. If you are fine with this version I'll send V2.

	/*
	 * Returns ULONG_MAX when the result doesn't fit u64.
	 */
	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		char ok = 0;
		u64 q;

		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
			_ASM_EXTABLE(1b, 2b)
			: "=a" (q), "+q" (ok)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx");

		if (ok)
			return q;
		BUG_ON(!div);
		WARN_ONCE(1, "muldiv overflow.\n");
		return ~(u64)0;
	}

Oleg.


