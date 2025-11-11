Return-Path: <linux-kernel+bounces-894847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBEC4C3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E701F3A6D13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227872D29CE;
	Tue, 11 Nov 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EHVry8E8"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B528152D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848095; cv=none; b=aEFB5/l0YTw8Moam/UWbZWetzJVAhtDPDi588SY71Bk2gyYPa35UspG95MPAKUzgpqGxvyuT+NeFhAdVdddOHI4e9kbtB/VyYb8eR0VB3Q8QHYvm4ZoY8n0KqyHELkwl5X94Kzbp+X3DPTU8pjB1j6v7Q1FyXztHiyXQizorr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848095; c=relaxed/simple;
	bh=ZWOhjIZT19z1FgMJ4W65UrXvXj7QaeVs3B6bBqx6tY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAsO79PgJgO/BkJ7gSnHPeoHRavF6V6eQmwbQowbgQdBzFN+9QxxXO6Mf31RUZEpzsG1rkhoWbM4v7C8E0cbt7GGgYbm/sEC1XdjgQeQoP2VSpbE4MClqLNTzgHdWSTZ82NdBP3JNllRufBrBx3iZ/1UmOSuQbwu7TGdm6WB4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EHVry8E8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gp9/9y3RyInbo1zHhoe1nnmyp2UIryqOQflQEaRXeV8=;
	t=1762848093; x=1764057693; b=EHVry8E83nJPcrWMz+9bt2r0Q/cNOuUjd/+MXmPN90h8CPJ
	B4gZdNMjJF0MXwvD9JidSNNYdIdjJKfdFB3KYYZmifK4HHpRiZT1JsUYh8OCxNqFqFPDZ8ASgGUg7
	Lgh+PSi4Mih0MDh/P/OU3ItA2inuSjui9hwK6uUDH6aRB6ttmCChvGLMtb8p1vwPpm2dSTKqeU67k
	P23G9U2vt9BvbeuGeVtlGNbAHCcAo1r98rHUtXJpsx8tBwFvBhvlRfXRupWVPuUbifjMdDEkmBpK9
	En+xKKNVS8yr6XkGMQcIvCI5UqCQDHXF9A+E99k2FFY2WGMKnACNZE7GMl4m2Hxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIjJd-0000000F38R-3cdE;
	Tue, 11 Nov 2025 09:01:26 +0100
Message-ID: <0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
Subject: Re: [PATCH v13 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, hch@infradead.org
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 09:01:25 +0100
In-Reply-To: <m2framxerm.wl-thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
		<aRGs8lPjH22NqMZc@infradead.org> <m2framxerm.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-11-10 at 21:18 +0900, Hajime Tazaki wrote:
>=20
>   What is it for ?
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
>   - Alleviate syscall hook overhead implemented with ptrace(2)
>   - To exercises nommu code over UML (and over KUnit)
>   - Less dependency to host facilities

FWIW, in some way, this order of priorities is exactly why this hasn't
been going anywhere, and every time I looked at it I got somewhat
annoyed by what seems to me like choices made to support especially the
first bullet.

I suspect that the first and third bullet are not even really true any
more, since you moved to seccomp (per our request), yet I think design
choices influenced by them persist.

People are definitely interested in the second bullet, mostly for kunit,
and I'd be willing to support them in that to some extent.

However, I'm not yet convinced that all of the complexities presented in
this patchset (such as completely separate seccomp implementation) are
actually necessary in support of _just_ the second bullet. These seem to
me like design choices necessary to support the _first_ bullet [1].

[1] and then I suppose the third, which I'm reading as "doesn't need
seccomp or ptrace", but I'm not really quite sure what you meant


I've thought about what would happen if we stuck to creating a (single)
separate process on the host to execute userspace, and just used
CLONE_VM for it. That way, it's still no-MMU with full memory access,
but there's some implicit isolation between the kernel and userspace
processes which will likely remove complexities around FP/SSE/AVX
handling, may completely remove the need for a separate seccomp
implementation, etc.

It would, on the other hand, make it completely non-viable to achieve
the first and third bullets, so given your pursuit of those, one some
level I understand the design right now. I'm yet to be convinced,
however, that those are even worthy goals for (upstream) UML, what use
case would that enable that we really need? Especially considering that
over a longer perspective, NOMMU architectures _are_ on their way out,
and UML will certainly follow once that happens, it won't be the last
remaining NOMMU architecture.

So the only value I see in this is for testing over the net couple of
years, which really doesn't need any sort of significant optimisation or
less reliance on host facilities.

Where do you see this differently?

johannes

