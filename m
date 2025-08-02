Return-Path: <linux-kernel+bounces-753989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8FB18B69
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842EF1897AB5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1681FDA94;
	Sat,  2 Aug 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJIl9GYL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034C1FCFE7
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124281; cv=none; b=EhlTk22yRJ4JZHTDp8YW+5HGzpKl2dW2eAHRXIs1OeuzsyAnMqKwPDHQNtucD34J/qaURL4mzI2PnLZ9oKzqyboYCkj1WmQo7EyKBLVEgFp8FYz1/M7Ai7InqMLTU4c0lf5NLiO0aJCFSmcvcREW5cDEF3Asl4PoQId8KGSv9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124281; c=relaxed/simple;
	bh=ItuvhfOs35uTIENVwyKdz4c2hH9SsfZ7M2hXM3LUQt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNp/4Lhz0U9jYzg/q4s5gjfFZOlSs66PVxvB5u6ICArbu0snZq8zheUa/xZWs/VtSt0r81l43DmlG0FRAgqpQAmtbgV5DSmTVvqKJj9vzG8UMtcAl0g642KUzqS+jTHgqEZU7RNvUyvwqfn7c5h83sbMHHF9LIT/6O2IJfZVp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJIl9GYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754124277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iheZ9AMJX+ksT97d62rdstW21f8FHMP+8lB4dgVffws=;
	b=IJIl9GYL3dbTyWQFLFXpdI3H46WEOf9KkWpBL9WMhfQYyab+k9kLOwz0v8JFIeBsrHcC5k
	N2l93J6a4+hsbDsnNAt7GJe6OoZ+KX0gCT/eQQFZXAu55zf/FhwoH6ExlzbWo/X0uWRHiv
	PMcAc0yECy1yVxnsoq3wpAkU2KQkXBE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-efaDcNWWOd25VbGqbZz4ig-1; Sat,
 02 Aug 2025 04:44:33 -0400
X-MC-Unique: efaDcNWWOd25VbGqbZz4ig-1
X-Mimecast-MFC-AGG-ID: efaDcNWWOd25VbGqbZz4ig_1754124272
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15CA119560AF;
	Sat,  2 Aug 2025 08:44:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B8E1B1800B6A;
	Sat,  2 Aug 2025 08:44:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  2 Aug 2025 10:43:22 +0200 (CEST)
Date: Sat, 2 Aug 2025 10:43:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xiang Gao <gxxa03070307@gmail.com>, brauner@kernel.org,
	mjguzik@gmail.com, Liam.Howlett@oracle.com,
	joel.granados@kernel.org, lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802084316.GA31711@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802022550.GT222315@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/02, Al Viro wrote:
>
> In which conditions does that happen?
>
> > 	__task_pid_nr_ns+0x74/0xd0
> > 	...
> > 	__handle_irq_event_percpu+0xd4/0x284
> > 	handle_irq_event+0x48/0xb0
>
> 	Huh?  Just what is it doing inside an IRQ handler?
> Hell, the notion of current process is not usable in those,
> let alone any properties of such...

Well, at least get_curent() should work in this case...

But we can forget about IRQ. I guess the problem is that if the exiting
task has already passed exit_notify() and it was (auto)reaped, then, say,
task_pid_vnr(&init_task) will crash.

Not that I think the exiting task should do anything like this...

Oleg.


