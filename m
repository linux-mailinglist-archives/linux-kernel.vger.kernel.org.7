Return-Path: <linux-kernel+bounces-720820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876BAFC0BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C3516B35A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9291A239D;
	Tue,  8 Jul 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB3YJMQ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D54A33
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941088; cv=none; b=pW02tdwv0fRI1r0FDsziF5+ociplLCyjGVKKodDnoFjSO7OTILw+d6/iMThQwbZf8z46Tr4NCg1TFsVZ7EMHL2Ci3lkQKrzwnh9ZaGShajvdLJgj7LjEJgowoNOmrOmYYQrSxFDoKReelvPA959xu+Je98CGJiRdwmo57ZsJNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941088; c=relaxed/simple;
	bh=WjOwar9nISLB+HE31lzL5YcZc25ykfu1+0wxHlhBLQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL31SbrV3OnARtPVhjmaZtF1iWSTFy+SkAFWBiN5A0UTREUkjLUZsaVHeYmLxn+WiG8/kgJbU3ZJFhf9Sujpq2OUq/Z+EooKkbu/D22xNGx38jhLr0851KXlTnsLN33VRC7skRq+Wh5p6yw7u9IdV3X2BcXd1vSYh5iv1hht+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB3YJMQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751941085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fMvL92Sm5kh1mOLxAAsXEEdK7mOeKVFhUdHSXN8tn6A=;
	b=CB3YJMQ30xAPa6Ly1+eRoQ0TTQ6jSJ4ifkyUAXqWDhVQ2dnankha0RJBOggfrtqU6lRiNM
	LUsdeMuSrE6V3C8HvValtmCjCMiawJPc3LmitABumcTCCihknh8aTfIrSh0W8G/HT8M9qq
	n0dFfdTSXqU9av4W+5U3ImvzQdUTDp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-EfYjRXIDMhmWYxSE06A3Ig-1; Mon,
 07 Jul 2025 22:18:01 -0400
X-MC-Unique: EfYjRXIDMhmWYxSE06A3Ig-1
X-Mimecast-MFC-AGG-ID: EfYjRXIDMhmWYxSE06A3Ig_1751941078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36CB718002ED;
	Tue,  8 Jul 2025 02:17:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 75C6D30001B1;
	Tue,  8 Jul 2025 02:17:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Jul 2025 04:17:11 +0200 (CEST)
Date: Tue, 8 Jul 2025 04:17:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Li,Rongqing" <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [????] Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250708021703.GD15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
 <20250707220937.GA15787@redhat.com>
 <20250707182056.66a8468a@gandalf.local.home>
 <20250707183331.029570bf@gandalf.local.home>
 <42f5344b80e244278aaf49f112498e02@baidu.com>
 <20250707215322.0e4ec431@gandalf.local.home>
 <8f68278c4a454fd79b39cf21d4c0974f@baidu.com>
 <20250707220529.19eb2a74@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707220529.19eb2a74@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/07, Steven Rostedt wrote:
>
> On Tue, 8 Jul 2025 01:58:00 +0000
> "Li,Rongqing" <lirongqing@baidu.com> wrote:
>
> > But mul_u64_u64_div_u64() for x86 should not trigger a division error panic,
> maybe should return a ULLONG_MAX on #DE (like non-x86 mul_u64_u64_div_u64(),)
>
> Perhaps.

So do you think

	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		int ok = 0;
		u64 q;

		asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
			_ASM_EXTABLE(1b, 2b)
			: "=a" (q), "+r" (ok)
			: "a" (a), "rm" (mul), "rm" (div)
			: "rdx");

		return ok ? q : -1ul;
	}

makes sense at least for consistency with the generic implementation
in lib/math/div64.c ?

>  But it is still producing garbage.

Agreed. And not a solution to this particular problem.

Oleg.


