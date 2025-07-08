Return-Path: <linux-kernel+bounces-721611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27FAFCB9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777B41C207D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340E2E0B47;
	Tue,  8 Jul 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwgaJE3J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78932DCF4F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980285; cv=none; b=iBUT6z3cxphSQ5ZTGV8O9MWwk4dIDGhvBM9F2jrOSkwp61V33QAQ0mUIzgYAqecaBdPsZv6OVxOAe93i753to4SzuIa9Foa/MmlIXIjZQxiEu2L9cbS/CVbiVbepk8KMDZZtjB3/iv2kpfKV2mDsIy5QBrTm0pxs1sI+5czCvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980285; c=relaxed/simple;
	bh=ftZW5DJj/uGCnAjofm7ZiI4VACZQNUgo788vwOq1/Mc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D4/3qyOMjzn1+Haq1T4RR+Swk3EzBggeNdvg/aQyN9yiDWTAFsoKnoP1Fm5cd1KxNybsfb1ildzQxcpSt+XWrerWpsNpIXPLjqxfpLT7DZGgNrL60cFTlzzdR7r11F7CsQkOOtakgZklHtFqiot85LmKJZ7l4CS/d2yUuIexcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwgaJE3J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751980282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjPriJJqrj/AJJIvWQC42ot5Nut875tMuPgSWTCg0/M=;
	b=FwgaJE3JhWyTB2hqvL7CFjOr1BT9No0cOBDHztjwrDRRLb98p6u4r1qfzzLTQURTAfynrP
	9G+I0qSoVeSvhu1CwbtYsSd+/oFGdp9DCbP9Lm7Zsf5oSvu8IWGDi3YzP/ROAxgRsGuvWI
	RErWwYfG592npLJdfj+BNXzn3rWYiis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-alqNjx_AO0i-ADQ_PoB-0g-1; Tue,
 08 Jul 2025 09:11:21 -0400
X-MC-Unique: alqNjx_AO0i-ADQ_PoB-0g-1
X-Mimecast-MFC-AGG-ID: alqNjx_AO0i-ADQ_PoB-0g_1751980279
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DBD218DA5C6;
	Tue,  8 Jul 2025 13:11:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D00C19560B2;
	Tue,  8 Jul 2025 13:11:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250707054112.101081-1-jiayuan.chen@linux.dev>
References: <20250707054112.101081-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, mrpre@163.com,
    syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com,
    Eric Dumazet <edumazet@google.com>,
    Neal Cardwell <ncardwell@google.com>,
    Kuniyuki Iwashima <kuniyu@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining space calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2554852.1751980274.1@warthog.procyon.org.uk>
Date: Tue, 08 Jul 2025 14:11:14 +0100
Message-ID: <2554853.1751980274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> The types of the variables involved are:
> '''
> copy: ssize_t (s64 on 64-bit systems)
> size_goal: int
> skb->len: unsigned int
> '''
> 
> Due to C's type promotion rules, the signed size_goal is converted to an
> unsigned int to match skb->len before the subtraction. The result is an
> unsigned int.
> 
> When this unsigned int result is then assigned to the s64 copy variable,
> it is zero-extended, preserving its non-negative value. Consequently, copy
> is always >= 0.

Ewww.

Would it be better to explicitly force the subtraction to be signed, e.g.:

		skb = tcp_write_queue_tail(sk);
		if (skb)
			copy = size_goal - (ssize_t)skb->len;

rather than relying on getting it right with an implicit conversion to a
signed int of the same size?

If not, is it worth sticking in a comment to note the potential issue?

David


