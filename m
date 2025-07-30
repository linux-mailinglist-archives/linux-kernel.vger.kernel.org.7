Return-Path: <linux-kernel+bounces-750670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F0B15F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B267B5655D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898A29826A;
	Wed, 30 Jul 2025 11:31:10 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDC286430
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875070; cv=none; b=AtRvyE0MbL32sYGQHC5nVfZPAt61PqE5E7EObMUoqDUYX8fPnj5AnHh6iVJBiVGUXERAU1VBw1k4uw+ssETUT+5kUu1OwQ7lwwc4mQeqCoKilzPmFUU2maRUUqHkQIkQS912Ty81hMgv4y7Xl+N9TtHPMuj7Iso1kCMGgYNNV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875070; c=relaxed/simple;
	bh=YkHa5N+rGDYjMcvUKUjbydpzppgu96HQeNrEoY5AQdI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=hewzahSgNh/3aa4HmmYwly/5kEtv6nEov1BhQemrOrWp/R2oWflrYxru50xTJNVNwSz3k11QZ7iCJUd7uqFkBn6GRffs0ZDD9cN30rw+kVx5zIl6LG/OtzidVr3/RPtTUisggQ0+Yir9vr3KNF+3R9RPVZKhFbco7js4C/DD/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bsVQV6Q1Tz6FyBs;
	Wed, 30 Jul 2025 19:30:58 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 56UBUpjO028702;
	Wed, 30 Jul 2025 19:30:51 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 30 Jul 2025 19:30:54 +0800 (CST)
Date: Wed, 30 Jul 2025 19:30:54 +0800 (CST)
X-Zmail-TransId: 2afc688a026e522-3eef8
X-Mailer: Zmail v1.0
Message-ID: <20250730193054087uexhTuUPGoX5Z14vWRm4A@zte.com.cn>
In-Reply-To: <20250729154025.GC18541@redhat.com>
References: 20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn,20250729154025.GC18541@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <oleg@redhat.com>
Cc: <tglx@linutronix.de>, <frederic@kernel.org>, <peterz@infradead.org>,
        <brauner@kernel.org>, <iro@zeniv.linux.org.uk>,
        <joel.granados@kernel.org>, <lorenzo.stoakes@oracle.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYyXSBzaWduYWw6IGNsYXJpZnkgX19zZW5kX3NpZ25hbF9sb2NrZWQgY29tbWVudCBpbiBkb19ub3RpZnlfcGFyZW50?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56UBUpjO028702
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 30 Jul 2025 19:30:58 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688A0272.001/4bsVQV6Q1Tz6FyBs

> > -     * Send with __send_signal as si_pid and si_uid are in the
> > -     * parent's namespaces.
> > +     * Use __send_signal_locked() instead of send_signal_locked()
> > +     * because si_pid and si_uid are already in the parent's
> > +     * namespace. send_signal_locked() would incorrectly modify
> > +     * them when crossing PID/user namespaces.
> >       */
> 
> Somehow I'd still prefer the previous version which simply kills this comment,
> but as I said I won't argue.
> 
> However. It seems to me that the new comment adds another confusion. I'll try
> to recheck tomorrow, I am very busy today.
> 
> Oleg.

Hi Oleg,

Thanks for your feedback and time! I understand you're busy today, so no rush at all.

Regarding the comment change, I'm happy to adjust it if you think the new version
is confusing. If you have a moment, could you suggest a clearer way to explain the
rationale behind using `__send_signal_locked()`? 

Thanks again for your help!

Best regards,
Fan Yu

