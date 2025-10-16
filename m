Return-Path: <linux-kernel+bounces-856347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27801BE3ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B3424227
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935433EB0E;
	Thu, 16 Oct 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH4Yxt9R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F72AD11
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625264; cv=none; b=joqInXS5/AkrqpxBPzRLpWFdumPXZaFz7r8Z7fwFY8flgr86KNUKPE8D7HHXTcH47EoaK1R49GddJqSweWx+nO222iCHQrlD1MP2ou+7z68w7YOlogrOcuAA5CHUl+Stg7C3g2rgxvk2HDS48+kjz6V6gYa3hqsVZs1TDBIwtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625264; c=relaxed/simple;
	bh=Uw9k3Nn2rAVurZJW//6Yil6Gpc0P5pF/kG2hQ2RNlUo=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=VcLoCTbV+JcGd4MWhvEJTZqT+AKOvOq8CKnO+8zxGN13mtxqU7LwRrsNU3s6SoXI94tjQ8tcVQuShxpaBS2T9c2Q0IER9I9ZSmKk2k20TcV25d+5sicz9NFH7DGv0/MSCjp1V8r6iAb5o6m95oJYH1RMs/ZQRHrXNe4JxkZUcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SH4Yxt9R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760625262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ACompS8RN1HL21dOAoG+qrfrbuwD8dNCF47B5bieXU=;
	b=SH4Yxt9R6O7HpLWmSgom6NA/PxNZRasAkgorL1t9epB699Uc0O1xJ0yFq7qjBYzaRlC1wk
	vK0y3yiNiR5XfHTr8EdzNC4++LSgFR0dHdzn9PPR5bWKd7al5AMzg0BNiYFdtQDAOchzoh
	rdQMjnhGdhPiNn7OMxPrlkRyMg6HdBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-d-qVbRfDMYKZyfu0-a4OuQ-1; Thu,
 16 Oct 2025 10:34:18 -0400
X-MC-Unique: d-qVbRfDMYKZyfu0-a4OuQ-1
X-Mimecast-MFC-AGG-ID: d-qVbRfDMYKZyfu0-a4OuQ_1760625255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6332518002C1;
	Thu, 16 Oct 2025 14:34:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 760101800579;
	Thu, 16 Oct 2025 14:34:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <286100.1760618158@warthog.procyon.org.uk>
References: <286100.1760618158@warthog.procyon.org.uk> <20251002162705.GB1697@sol> <20251001152826.GB1592@sol> <20250926141959.1272455-1-dhowells@redhat.com> <20250926195958.GA2163@sol> <2636609.1759410884@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] crypto, lib/crypto: Add SHAKE128/256 support and move SHA3 to lib/crypto
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <363388.1760625251.1@warthog.procyon.org.uk>
Date: Thu, 16 Oct 2025 15:34:11 +0100
Message-ID: <363389.1760625251@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

David Howells <dhowells@redhat.com> wrote:

> I have ML-DSA working as far as being able to load keys and check signatures
> in the kernel - but hit a minor bump of openssl not apparently being able to
> actually generate CMS signatures for it:-/.  It seems the standard is not
> settled quite yet...

Actually, openssl CMS can generate ML-DSA signatures, but only if CMS_NOATTR
is not specified.

David


