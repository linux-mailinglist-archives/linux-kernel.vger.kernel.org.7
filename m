Return-Path: <linux-kernel+bounces-824041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94137B87FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA41BC12C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9B286430;
	Fri, 19 Sep 2025 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPq6jfBH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA02765D0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262678; cv=none; b=qCZo6kcE/M2pFKAkB4yM5hEAOpzCMdElH90YeGLyZ0T5dEjZ5ydHmbbm8la+hyssDuK5VHMmEVvLJjLBWICcJY3Ta9/OB/k2jnpF3gekoLiqOK5mnxzQK2utikI/4c53BRzAC3OamsMnkb7JuAVS9zYX60eKKtR6rrIM+zLDQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262678; c=relaxed/simple;
	bh=Zu3k/K3mWSrVWZWf/1c9DXzQdLKRbQiCTLWy7TplHVw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PibDYuZNLoEnC0mxWKk8Jjc5Y5ttMRqLE7MUKcC5V7j8FBmu+Q8mxRnrhdE2dgrBnh48xebegq2zCBfq4G9/zDm/11a6aIICKjPypb/Y8wxJ9mmL6X4qC/FybbRzXw6Z2/8ZhTK25bzGKqxCt5ULWlg4Q4RR4N0/C5bsMRiyNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPq6jfBH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758262675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zu3k/K3mWSrVWZWf/1c9DXzQdLKRbQiCTLWy7TplHVw=;
	b=RPq6jfBH7UkfYAm1e58BvPLHNOvr+zgOL9NcrmrJu6RRuvY/4fPG/QUo+vLsGaID9fZ7A+
	1UuZwfZLbO5agWAmqCClUOSWe8tkIgl2T1EP1vE/AM0qB6JyEuL4rQPxmRIZFAHIdtXyoz
	YbDyNG71Pe/EW5cdSBUO0Mxggttt7YQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-rHSEGkCBM5yVyzsuygZzuw-1; Fri,
 19 Sep 2025 02:17:52 -0400
X-MC-Unique: rHSEGkCBM5yVyzsuygZzuw-1
X-Mimecast-MFC-AGG-ID: rHSEGkCBM5yVyzsuygZzuw_1758262671
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93666180028C;
	Fri, 19 Sep 2025 06:17:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1E7E1955F2D;
	Fri, 19 Sep 2025 06:17:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2952535.lGaqSPkdTl@graviton.chronox.de>
References: <2952535.lGaqSPkdTl@graviton.chronox.de> <3605112.1758233248@warthog.procyon.org.uk>
To: Stephan =?us-ascii?Q?=3D=3FUTF-8=3FB=3FTcO8bGxlcg=3D=3D=3F=3D?= <smueller@chronox.de>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    "Jason A. Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA-512, SHAKE128, SHAKE256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 07:17:46 +0100
Message-ID: <3788819.1758262666@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephan M=C3=BCller <smueller@chronox.de> wrote:

> For a multi-stage squeeze, it is perhaps not helpful to zeroize the conte=
xt=20
> here.

Yeah - I've seen this now that I'm starting to trawl through your dilithium
code, so it will need adjusting.

David


