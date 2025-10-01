Return-Path: <linux-kernel+bounces-838909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DCBB0677
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8773C6A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD6D1F8BA6;
	Wed,  1 Oct 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTjLFWR9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AD1E5B71
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323766; cv=none; b=Q+O1FoiETSVgzLY8UHB4t6gIZ6r35k2fo+fkGGvL8ZHoDVhmBeEUTt+9pQSilIDokBKr+h6PCbTutgNibz5b6riCC7FHmGecJSF+gOrbMj5z48gxlFxmeUtE56NqKuVmII3hiX24ofzJr7vSDBlt+IIdPFLypMduyqzLYKMLof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323766; c=relaxed/simple;
	bh=XSb4lZeUC11vVHC3qAE1HO8lVhiaodyHM4xbnI8Dum0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HF6rRQiyEttoj/94SiCuEep3DJNkYxKflv+i0w8OE+ftKRoiIKZhYeujvS5MbX9aJxdUnIOr9evMEyuuO/oVCHe5ZRNOgqyw7JdRv7hKpcbKpzA++7iBP3mvHk4b3pdveUovv/5ZMsPWxt2xwO+YF3bhGemi4XkXNx64gYz/VK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTjLFWR9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759323763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/MIPDCJJz06RLWC3Ge5JUdjwlfnix7uDu/4qpsMWEc=;
	b=PTjLFWR9qvSAbFfVLi3ST/q2dQlKaq+3MH/junhQYYY3zkk1rU6vJBbolRupbwSYBLLYb3
	/MDXpdOtszzjqolNLn71cOj6+UfbBnftiJM2vtDiC88+Z+jgzxwKTouYsMlTyY7g1Q2RRU
	5L3JhXVhXU1KKfMU9uzS3MK8IFUHyTk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-E1P6B0rRPhqORjnVVtMhAg-1; Wed,
 01 Oct 2025 09:02:39 -0400
X-MC-Unique: E1P6B0rRPhqORjnVVtMhAg-1
X-Mimecast-MFC-AGG-ID: E1P6B0rRPhqORjnVVtMhAg_1759323756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45FCD18011CD;
	Wed,  1 Oct 2025 13:02:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68CC330003BE;
	Wed,  1 Oct 2025 13:02:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250926211415.GC2163@sol>
References: <20250926211415.GC2163@sol> <20250926141959.1272455-1-dhowells@redhat.com> <20250926141959.1272455-8-dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] crypto/sha3: Add SHAKE128/256 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2284487.1759323746.1@warthog.procyon.org.uk>
Date: Wed, 01 Oct 2025 14:02:26 +0100
Message-ID: <2284488.1759323746@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> I recommend holding off on this part until you have a try at using the
> SHAKE library API directly.  The dispatch to different algorithms could
> be done in the calling code.  This patch would also limit the ML-DSA
> code to fixed-size SHAKE outputs; is that really going to be enough?

Actually, ML-DSA also allows SHA2 hashes for the prehash, so if I use
crypto_shash for that, then I maintain the flexibility through that.

> When there's only a small number of supported algorithms, just doing the
> dispatch in the calling code tends to be simpler than using
> crypto_shash.  For example, see the recent conversion of fs/verity/ to
> use the SHA-2 library API instead of crypto_shash.

That's reinventing the wheel.  Why have crypto_shash at all if we're going to
encourage people to ignore that and use a union and an enum/ops table.

Is the goal to get rid of crypto/ entirely and use lib/crypto/ instead?  Not
that I wouldn't mind a better crypto offloading API - the one we have kind of
sucks, especially for offloading to async crypto h/w (sorry Herbert;-)).

David


