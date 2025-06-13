Return-Path: <linux-kernel+bounces-685995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247CAD91B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A117C1784D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BD1F4E39;
	Fri, 13 Jun 2025 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aavRsAav"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F21F428C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829386; cv=none; b=dQ1IUcCdU9NPuyILiH5xzz6mynXZ90EIg9esHjyJlpHJBCWpn2Wl7AJ0dRzl1yF5lCd1WbbBUKihwljqRvYGGO8tld+tIoPd8nF6jDdXunDkrDrkXUyT8AoYFMYVpeWdjfMSGE5cCEzPuRfNY0GMDRVV3dVCRlkcLWKhBEE03jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829386; c=relaxed/simple;
	bh=hoCsq6j/QKc0XwkBBFJ9hkM8wZVBjSZmIpFJOYCNCng=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fXHC3D8SpfzUtXnxYh2LxKxgzM/zjmORecHCyhOQZAMKaOwa1M321GqOjl0eiL6Q39qjdIZYiFXDP8colmCNexOnvC5vJHNIWyHZ6p6eKtg2OtDE0ZTmke/9uwtCjfgEIH+g7JwvLZPvvchwWKN94vH7yAVYsm0hB0QX5K1le+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aavRsAav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749829383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoCsq6j/QKc0XwkBBFJ9hkM8wZVBjSZmIpFJOYCNCng=;
	b=aavRsAavptDFqIi/PlNG6Twpn9h9xCtryS6wtyVqoVz7KhgpPUAAArMLkyHjyy4S4Amk6n
	mHnom/IdwRQFBlPhsfBf3iC1BUmIVnFpAiZws3eWsjQYO679luzXcD2WNyA6KSkP5HK7K5
	o61oVg+IbumJ1XLnRK9+sJiDdF6SoUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-vXrS_N0UNYGyoFzGplMkLQ-1; Fri,
 13 Jun 2025 11:42:58 -0400
X-MC-Unique: vXrS_N0UNYGyoFzGplMkLQ-1
X-Mimecast-MFC-AGG-ID: vXrS_N0UNYGyoFzGplMkLQ_1749829376
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 985F61808985;
	Fri, 13 Jun 2025 15:42:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22BAB18002B5;
	Fri, 13 Jun 2025 15:42:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
References: <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com> <501216.1749826470@warthog.procyon.org.uk>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>, Simo Sorce <simo@redhat.com>,
    torvalds@linux-foundation.org, Paul Moore <paul@paul-moore.com>,
    Lukas Wunner <lukas@wunner.de>, Clemens Lang <cllang@redhat.com>,
    David Bohannon <dbohanno@redhat.com>,
    Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org,
    linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Module signing and post-quantum crypto public key algorithms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <502668.1749829369.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jun 2025 16:42:49 +0100
Message-ID: <502669.1749829369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Ignat Korchagin <ignat@cloudflare.com> wrote:

> > The not so good news, as I understand it, though, is that the X.509 bi=
ts are
> > not yet standardised.
> =

> Does it matter from a kernel perspective? As far as I remember we just
> attach the "plain" signature to binary. Or is it about provisioning
> the key through the keystore?

PKCS#7 is used for the signatures and X.509 is used to provide the public
keys.

David


