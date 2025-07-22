Return-Path: <linux-kernel+bounces-741358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA6B0E32B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7593E1C85E19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE8280A51;
	Tue, 22 Jul 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUcx40e/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7C279DC4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207171; cv=none; b=ibAziCchSlmUzmOKRjBqY1OgyRSWD5i2eWbdIUbbCeJNmcH+D5esETfqoGtUid6v/uDEm3XmZb6B3e3RkCavHoov8Jx56C19YjgeF+mWvTQLnAoJj9EbBcABGeO4CzX1u6rajl7sdzdMLBN7CtlPRJh8lVi2Zkm8rROlAMN0gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207171; c=relaxed/simple;
	bh=czaYoBEurRMRb+9N79DjVDatKAVLUHXTeVHfQTimLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neBOJwPcoeTbjM0y+XI7Rc/qQNIWb8EfKYKm3YYyCIvh/HSFRgDLYv8WVfmnFYL96HWzplqo9FhOk36cfu1qOJQh4uIav2ePauIY08EmwGF1fbtQ3MlOcSYWndSt0QjVUREXeh3MD/bnRm8JCCYrypF3RsXCRrc6Y6ENdtjPqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUcx40e/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753207168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nxph+5cHIivsGtMSNfnw31CbFRsbsVvb6kQWxmkU7o=;
	b=PUcx40e/gHMNVauuAr4WbQCFeeEltJ8WwzrNxyOmElT9e0SyelBnDUfGKdrsjxWQb+S5Pu
	Orp7tYmNNlHy8PUjvBNyBeUbubJTedNxcHHzwhnElB+Jxs4YpO57/Df/BVirKefx8Bapwr
	MxbrVtfdTDKU1Xi9bmhLXFXpsrBSquI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-xC33Smn6P3ytJoRBJvUlrA-1; Tue,
 22 Jul 2025 13:59:23 -0400
X-MC-Unique: xC33Smn6P3ytJoRBJvUlrA-1
X-Mimecast-MFC-AGG-ID: xC33Smn6P3ytJoRBJvUlrA_1753207161
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16AA119373D8;
	Tue, 22 Jul 2025 17:59:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5A3E6195608D;
	Tue, 22 Jul 2025 17:59:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 22 Jul 2025 19:58:14 +0200 (CEST)
Date: Tue, 22 Jul 2025 19:58:08 +0200
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
Message-ID: <20250722175807.GC2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/22, H. Peter Anvin wrote:
>
> On July 22, 2025 3:50:35 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >The generic implementation doesn't WARN... OK, I won't argue.
> >How about
> >
> >	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> >	{
> >		char ok = 0;
> >		u64 q;
> >
> >		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> >			_ASM_EXTABLE(1b, 2b)
> >			: "=a" (q), "+r" (ok)
> >			: "a" (a), "rm" (mul), "rm" (div)
> >			: "rdx");
> >
> >		if (ok)
> >			return q;
> >		BUG_ON(!div);
> >		WARN_ON_ONCE(1);
> >		return ~(u64)0;
> >	}
> >
> >?
> >
> >Oleg.
>
> Maybe the generic version *should* warn?

David is going to change the generic version to WARN.

> As far as the ok output, the Right Way™ to do it is with an asm goto instead
> of a status variable; the second best tends to be to use the flags output.

This is what I was going to do initially. But this needs
CONFIG_CC_HAS_ASM_GOTO_OUTPUT

Oleg.


