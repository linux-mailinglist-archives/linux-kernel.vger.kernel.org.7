Return-Path: <linux-kernel+bounces-745600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4CB11C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C601CE4A08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB92E88BB;
	Fri, 25 Jul 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHv0AXcP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15512E3B1E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438405; cv=none; b=Ahb62bPV9fzamq4kvTbIsfVmHEO27Rny9k9RWKvM07WvZ0D4Jd/QZ7GKmemTZghx4Rj4z5+491FM7AEpg3zQSGIQ7WGkTUekS9ftZB2EB1wBYfDFS1N8siLipQVQ9erZkcuWrsJLp7BN9d1kX38w6LEc4t7P82nFnSLYB0h32VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438405; c=relaxed/simple;
	bh=zZcTUNp9cNjGBHFz/f/iY7t58Atx50QRcowAI6ussBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH/ZmPEj4wqVPoaw1WBOKDVvAtiDhIIIQctkXvQLcQS70BDrP7LFv01Y0eQG1RaEMNPX4YUOmb6vLppzIlz4rBJlwMsa5nNWijHW4q4DNWc3szFeGF2i0U7L8wUOkx4Quea6MYU31pJKjLzcPpELQYonFNdoS2tvGawVGb9d4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHv0AXcP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753438402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RiyiJg6Da76VPB3NW5Wirqo8zfUU6YesQDOlG/xh6fU=;
	b=ZHv0AXcPn4BE8tpsvKx8SbYdHdse925Uwe/YJcDYmUQz9dAatM62F4TTMqNV7z1xaff58G
	RzPzlfvadEqSTFJesLWY43+lPgEJv9VMPcPFgUIpW9Nn19GZjPGRzEvSIrixjhFJxb8JHZ
	+IeB0eUUFIZDJ1vNlY1ElsdAuTIlc8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-UiTHYvl5P9ST1El7iuKf3w-1; Fri,
 25 Jul 2025 06:13:17 -0400
X-MC-Unique: UiTHYvl5P9ST1El7iuKf3w-1
X-Mimecast-MFC-AGG-ID: UiTHYvl5P9ST1El7iuKf3w_1753438396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 204CD19560B5;
	Fri, 25 Jul 2025 10:13:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 66FF51800D80;
	Fri, 25 Jul 2025 10:13:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Jul 2025 12:12:08 +0200 (CEST)
Date: Fri, 25 Jul 2025 12:12:02 +0200
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
Message-ID: <20250725101201.GA8700@redhat.com>
References: <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
 <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
 <20250723093825.GA12884@redhat.com>
 <20250723224831.4492ec75@pumpkin>
 <20250724081125.GA10980@redhat.com>
 <20250724082547.GB10980@redhat.com>
 <20250724111426.GA15444@redhat.com>
 <1225B7DD-BF29-4091-A956-FC312679E9BE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225B7DD-BF29-4091-A956-FC312679E9BE@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/24, H. Peter Anvin wrote:
>
> On July 24, 2025 4:14:26 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote:
> >Finally. If we really want to optimize this function as much as possible,
> >we can add the CONFIG_CC_HAS_ASM_GOTO_OUTPUT version as Peter suggests.
> >I guess this should work:

...

> >> Forgot to mention... Not that I think this is a good idea, but if we don't
> >> use BUG/WARN, we can probably add EX_FLAG_ and do something like below.

...

> Seems good to me.

Thanks, but which one? "asm goto" or EX_FLAG_XXX_AX hack?

As for the latter. I took another look at asm/extable_fixup_types.h
and it turns out we don't need a new EX_FLAG_, this version

	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		u64 q;

		asm ("mulq %2; 1: divq %3; 2:\n"
			_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_IMM_REG | EX_DATA_IMM(-1))
			: "=a" (q)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx");

		return q;
	}

seems to work and I guess it is the absolute winner performance wise.

But to me the main question is: Peter, David, do we want to add
BUG and/or WARN into mul_u64_u64_div_u64??? If yes, then this version
won't work.

Oleg.


