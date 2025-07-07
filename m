Return-Path: <linux-kernel+bounces-720612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBEAFBE42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DF74A6F98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C6B259C93;
	Mon,  7 Jul 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZofK6Ll"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151C800
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927500; cv=none; b=p4sb5t4JXCkwX9PyEQ2Izd/5Ahnfwi46XsZwzFeYhPPG1zd4wQtE7Ba62WJi491pELp8yGG5WnzddTiEjNIXEuIH0FprZ20FS4C+Eoo8UL+Vq27iXcjyFOyGwDlIy1JW2VIKcOI1Ilw39trfv70w20nL5rB4Q6Lw6T7DgeimcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927500; c=relaxed/simple;
	bh=plx+fMI+rybtWwn7NZMF4AKSnaAHQCfmFYEX9bkJPLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyi3ShAlLon2iSm7VpbN/Fmzd+UrZGmH/3Jh4Q6Sb/qmZr2ZFsMhw1YtnyDolQ9Bzjs4lZGg9yV1qVU32QbCXAOgUt9WGSc1Z01Co4v4UYgb4G9IKyLCXGUnnURiej/WTRI1J4dSi5LXacOlIax6kkdDNikMp45ANYKZ0pvItEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZofK6Ll; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751927497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5OEi+9BHeekLk8bhDMoxCU3qoaXnzLRyCWqOXKGTJY=;
	b=LZofK6Ll0VutjigEUAsQDPQmn/GX9Ccg5ekTJUubF/t7LdXPXXofJYa3yURyw0mx9dloFV
	gHGH1/52aSjHpftgD2GLFUo4nxZYwLCzzbMWeapD1jXEpiyao/4d07DT/ZxC0X8K5g4+FQ
	64dhapfrKQhtRzwP4zxoJfpZkGrwTQo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-TDniujyNOIKQK_NIlCwWIQ-1; Mon,
 07 Jul 2025 18:31:33 -0400
X-MC-Unique: TDniujyNOIKQK_NIlCwWIQ-1
X-Mimecast-MFC-AGG-ID: TDniujyNOIKQK_NIlCwWIQ_1751927492
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91FBB1956061;
	Mon,  7 Jul 2025 22:31:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2A39D19560AB;
	Mon,  7 Jul 2025 22:31:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  8 Jul 2025 00:30:44 +0200 (CEST)
Date: Tue, 8 Jul 2025 00:30:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Li,Rongqing" <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707223038.GB15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
 <20250707220937.GA15787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707220937.GA15787@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On a second thought, this

    mul_u64_u64_div_u64(0x69f98da9ba980c00, 0xfffd213aabd74626, 0x09e00900);
                        stime               rtime               stime + utime	

looks suspicious:

	- stime > stime + utime

	- rtime = 0xfffd213aabd74626 is absurdly huge

so perhaps there is another problem?

Oleg.

On 07/08, Oleg Nesterov wrote:
>
> On 07/07, Li,Rongqing wrote:
> >
> > [78250815.703847] divide error: 0000 [#1] PREEMPT SMP NOPTI
>
> ...
>
> > It caused by a process with many threads running very long,
> > and utime+stime overflowed 64bit, then cause the below div
> >
> > mul_u64_u64_div_u64(0x69f98da9ba980c00, 0xfffd213aabd74626, 0x09e00900);
> >
> > I see the comments of mul_u64_u64_div_u64() say:
> >
> > Will generate an #DE when the result doesn't fit u64, could fix with an
> > __ex_table[] entry when it becomes an issu
> >
> > Seem __ex_table[] entry for div does not work ?
>
> Well, the current version doesn't have an __ex_table[] entry for div...
>
> I do not know what can/should we do in this case... Perhaps
>
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		int ok = 0;
> 		u64 q;
>
> 		asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q), "+r" (ok)
> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
>
> 		return ok ? q : -1ul;
> 	}
>
> ?
>
> Should return ULLONG_MAX on #DE.
>
> Oleg.


