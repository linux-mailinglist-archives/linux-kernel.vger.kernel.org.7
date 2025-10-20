Return-Path: <linux-kernel+bounces-860653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A743BF09E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B411886603
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21492FBDF5;
	Mon, 20 Oct 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0APQoRq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605D2F745C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956777; cv=none; b=DpQmKPnIry+08TnnQY13XMPr/zSDpOdNbICP17eHpNENw6r/SZ7AvtoG30BuphOLyrHPFYiDzYOXHL5IqC6KzLpFuMJme8Rye36HMtNX9fZJNycRoT70yS+BdoQqpehUHodjogjf7h5+R3aeTnaY3XuBBPejxNbFRFO2OoG9zQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956777; c=relaxed/simple;
	bh=o06m2Hf5UOiIyCqy5/tbbq/q4Q+Pk/aECUU71C46ncU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=AnfZ7VYN79dKuNaCjZzltQO7L0L2f9lK6iXKEl+DmfqdIERtQXNtSuOnxvw+XvrFaQuayK58Jb3600VA0RO+KY6wNVbcK48bBiQ/P2CQLxdAX787mR2Qp4P3xGQKbbc+SGM0mJHJzfrtSMKvxKZkk8Pp/RqeNqtmWGGiZhXSf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0APQoRq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760956774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o06m2Hf5UOiIyCqy5/tbbq/q4Q+Pk/aECUU71C46ncU=;
	b=X0APQoRqG4r8SHjUT6z6for62AO1S3ksB4p6aImUj4Ov/vquGJhIBLQG+MpBaxwtc6cYKq
	/jE8qGqiToJmATb+bcHUqw3dMjaNKFxh3XnTP3XiCF7bOWwpDQG1RmRCH7vKXm4fCSbzmt
	QIKh2NUAkVw/dFHFmajeLJynFHc5pxk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-e6ZhlrVvPHugF73JmB980A-1; Mon,
 20 Oct 2025 06:39:31 -0400
X-MC-Unique: e6ZhlrVvPHugF73JmB980A-1
X-Mimecast-MFC-AGG-ID: e6ZhlrVvPHugF73JmB980A_1760956770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5900B195609D;
	Mon, 20 Oct 2025 10:39:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 458EB19560A2;
	Mon, 20 Oct 2025 10:39:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aPXfzd0KBNg-MjXi@archie.me>
References: <aPXfzd0KBNg-MjXi@archie.me> <20251020005038.661542-1-ebiggers@kernel.org> <20251020005038.661542-4-ebiggers@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    linux-s390@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 03/17] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128, SHAKE256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1062375.1760956765.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 11:39:25 +0100
Message-ID: <1062376.1760956765@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> > +If selectable algorithms are required then the crypto_hash API may be=
 used
> > +instead as this binds each algorithm to a specific C type.
> =

> What is crypto_hash API then? I can't find any of its documentation besi=
de
> being mentioned here.

crypto_shash, then.

David


