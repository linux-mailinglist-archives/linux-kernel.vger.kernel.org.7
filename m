Return-Path: <linux-kernel+bounces-722309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC6AFD7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C184D425E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AB23C4FF;
	Tue,  8 Jul 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtqML/T0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C818E02A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004667; cv=none; b=CT0V4XWJVziumbxJ6SNfu/KFaxyg57gm71SwFmTgv0PSrvc145uBSfrlxltFX8e3oTMqRXbnA/UBZKHu2wi1bEOTfPgj8mLmI6Jg8WS1nnn6ibBQ93PV0+aCHO4j1Pi1uVKzdIewgy1qAQpgzYns88X12ptSxw4n+kJkrgBWmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004667; c=relaxed/simple;
	bh=3W01dS28+sBmQz557shX2kn/QrQq3Ky2Im+D6oEOqn0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=G1IWdTCjJckRzl4Gf3CRlKDFzLhxICYej5lwu/16nUkIfLxdPuF92UX42/F6axSeet1h0aS90Tfa6LYSyHqDlISeWJhOIeYtOjZeT6IZBge8M8hlvuSc2adBi60FH7HhvkmwnkTUEkJdxmH1XhQ84bZVQWIxibbpnEq3itXEuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtqML/T0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752004664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HGjclnOAXK9019FQJQ+HU3FhyBNdDo7cnQ/RXk00nA=;
	b=LtqML/T0seG3HQWGUPi5fm+U7BW9Zg5oWbXLPPcXXB+18vGenLxILgoA3U2u5TXYymmXAm
	/YVGnlrJWhNvRZFWVpqdiiQkknYpdjR1vrXbALQtuXih8y0a3MSQa9RBmjM6LrEDqCvYnN
	6LfMDlS0XOC6FIKO0ASxgy3UgLPJhEQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-c2RbVfKTNfuw-4QkRLBgkA-1; Tue,
 08 Jul 2025 15:57:39 -0400
X-MC-Unique: c2RbVfKTNfuw-4QkRLBgkA-1
X-Mimecast-MFC-AGG-ID: c2RbVfKTNfuw-4QkRLBgkA_1752004657
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33F3219560AD;
	Tue,  8 Jul 2025 19:57:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCCB519560AB;
	Tue,  8 Jul 2025 19:57:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250708120336.03383758@kernel.org>
References: <20250708120336.03383758@kernel.org> <20250707102435.2381045-1-dhowells@redhat.com> <20250707102435.2381045-3-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    "Junvyyang,
                         Tencent Zhuque Lab" <zhuque@tencent.com>,
    Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/2] rxrpc: Fix bug due to prealloc collision
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2687075.1752004650.1@warthog.procyon.org.uk>
Date: Tue, 08 Jul 2025 20:57:30 +0100
Message-ID: <2687076.1752004650@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon,  7 Jul 2025 11:24:34 +0100 David Howells wrote:
> > +	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
> > +	__set_bit(RXRPC_CALL_RELEASED, &call->flags);
> 
> is the __set_bit() needed / intentional here?
> Looks like rxrpc_prefail_call() does:
> 
> 	WARN_ON_ONCE(__test_and_set_bit(RXRPC_CALL_RELEASED, &call->flags));

Actually, it shouldn't be.  I added that first, then realised that wasn't
sufficient.

I also realised there should be a third patch I failed to restack onto the git
branch.

Can you take the first patch and I'll alter this and repost this patch and add
the lost one?  Or should I just repost all three?

David


