Return-Path: <linux-kernel+bounces-832807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A21BA06D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFAB327A48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE08303A3C;
	Thu, 25 Sep 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="O/GBpNmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8oeF/Ih"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D98502BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815284; cv=none; b=M8pdvOKQOy2O32DfuSWTDp5BpKvIksATrK9rccIWI76aanVz7OKbQoKpOJw89cXVWQphhvn84H29lxGuEDUzsZCyTPn2K1hjNi4dyFneMyxjn9HgTNbvjxclXauPRK5r7oJIjEqVpvuzO+sa770SIjYKXcKibWVMmjdJ4z3SpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815284; c=relaxed/simple;
	bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FFYpLcWD4NOidCC82bNURHuYKCSL8sPkWT9l0/PYp0IPn1eAoXCTLUf3myTv6mman5KjhI2VPSJIeWbxpqOSan4yNXH3IoPUM2QYzW8L1NwOaj0kHxJYfIK1xrvZkgHWBoS4c4nn41/H36Z1hxZSHUclSlVwUzvEq9ZSNcdRNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=O/GBpNmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8oeF/Ih; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A214414000B2;
	Thu, 25 Sep 2025 11:48:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 11:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758815280;
	 x=1758901680; bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=; b=
	O/GBpNmBS+Nf0OPIBgj2sj/PDCIKeC0j5S2VVZ/EOrg3RpCAU3O98ukVzvwuk6/A
	IRP8G7IkQvw+wQgSi683mZspBDS2sdaxTOWNew9AG8gAxO1q3BfTDUMYR2B91vN+
	W8UMVfnH1jI+IUfemiYRHmuBo66jnLXkG000inQvMG9kHmeL4C5yrhVl6iAwufAz
	osUIrj/clxIP2LdhsYSzBv9WFn0hK5HqgSrW2AO/rAHksurVN9ggGKu5z+WkaVsr
	SQhzVo4nAp5kXyaMci078CAXYEidGo9Wczj+iiHovW2kE8tSC6HwV3WSgBwjBq9O
	GoXgOqEqXg+QIpwQPwR9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758815280; x=
	1758901680; bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=; b=R
	8oeF/IhEmuwV1X10Hz/vmfXFPxZUoQodsiaYBo503hrl/K127xg28RinCpb4A1cJ
	XsrQvIPnXKYvoSzPQcn6ZXvWXjveWVqGttjwiohRynGKnCftDj7Op7+NetzYzQH3
	AvFbQNQ170uD3c7BHGOvQBJz+HJAT1n44ybrSejzLXgNGvaBOtK9TGdWsXuCM52A
	Db2vYxAvJ4FjwF3frZQX6e93yhQQiAzvVefhRUzVHeAbm6iOkWo+kpfuhDVqHrEk
	+gXknvR3vza7fruiTLX1HLeJAgyGAiYDoKfZKsIn6y1EAIzuhmyt30xK0Ncnon+H
	Bduc7Ok85uxQyL1H36ALA==
X-ME-Sender: <xms:L2TVaNqxig2ibN9a8thygIfSXKBuRM0_mG1WY_1p0xER15CC2rkuJg>
    <xme:L2TVaN4bSMNyhV3UbGo-6kG4GKYyIj8W1aHCoIHk4qOU_57Yj8K1S_f4asbXHArxw
    nJwdPumtYF5_UUF5w6she-zXai4bhDA27AXcZB240bGkuQzW5HpCY2X>
X-ME-Received: <xmr:L2TVaDiVsxodL4LmNUkp1Z2bpAFsKaMx03h5euE3aWnJoE-fF0sgJpDQ5IBFw161mLC4Y8m6Mj4gSi13hHbjSrzELkqBDSoeX44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpegtggfuhfgjffevgffkfhfvofes
    thhqmhdthhdtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhi
    grnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtueehheehgfff
    teeiudehteeuieehfeehtdevhffhudelgeffueeivefghfffleenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtpdhophgvnhgrmhhpphhr
    ohhjvggtthdrohhrghdprghtlhgrshhsihgrnhdrnhgvthdplhifnhdrnhgvthenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
    higrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgrshhhrgdrthgrthgrshhhihhnsehsohhlvggvnhdr
    tghomhdprhgtphhtthhopegtfigrnhhgsehmuhhlthhikhgvrhhnvghlrdhiohdprhgtph
    htthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhrrghfsegrmhgriihonh
    drtghomhdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrghnghihuhgrnhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:L2TVaL6rC81P2MnLeQXLG-DPDWw2kWRhEws9MeVzcsqmrt6QhTRU4Q>
    <xmx:MGTVaAHvN7H1BeqiLDRqYpEyC7tOnofgGx_PI0QT-fZvWdLECM7W_w>
    <xmx:MGTVaFIUqaXye2U6E0-brzIggOQ6bI-KMzsiTd-lQJqfbAI-Giqi0g>
    <xmx:MGTVaFiMKBGmXSTda75Rh5rNw8QTnpQntpmbkkXqXWSzR1wb5nNdDA>
    <xmx:MGTVaN_ntiCc4vGSs6_4JTLw3piLbXyzWXwKHEJrVUavoHdmSQVCW3Pi>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 11:47:55 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Date: Thu, 25 Sep 2025 23:47:43 +0800
Cc: linux-kernel@vger.kernel.org,
 pasha.tatashin@soleen.com,
 Cong Wang <cwang@multikernel.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <bhe@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>,
 kexec@lists.infradead.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> 2025=E5=B9=B49=E6=9C=8819=E6=97=A5 06:25=EF=BC=8CCong Wang =
<xiyou.wangcong@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This patch series introduces multikernel architecture support, =
enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.

Hi Cong,

Sorry for chime in here, and thanks for brining replicated-kernel back =
to the life.

I have some experience on original Popcorn Linux [1] [2], which seems to =
be the
root of most code in this series, please see my comments below.

>=20
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation

I=E2=80=99d agree with Stefen=E2=80=99s comments [3], an "isolation=E2=80=9D=
 solution is critical for adaptation
of multikernel OS, given that multi-tenant system is almost everywhere.

Also allowing other kernel to inject IPI without any restriction can =
impose DOS attack
risk.

> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)
>=20
> Architecture Overview:
> The implementation leverages kexec infrastructure to load and manage
> multiple kernel images, with each kernel instance assigned to specific
> CPU cores. Inter-kernel communication is facilitated through a =
dedicated
> IPI framework that allows kernels to coordinate and share information
> when necessary.
>=20
> Key Components:
> 1. Enhanced kexec subsystem with dynamic kimage tracking
> 2. Generic IPI communication framework for inter-kernel messaging

I actually have concerns over inter-kernel communication. The origin =
Popcorn
IPI protocol, which seems to be inherited here, was designed as a =
prototype,
without much consideration on the ecosystem. It would be nice if we can =
reused
existing infra design for inter kernel communication.

I would suggest look into OpenAMP [4] and remoteproc subsystem in =
kernel. They
already have mature solutions on communication between different kernels =
over coherent
memory and mailboxes (rpmsg [5] co). They also defined ELF extensions to =
pass side band
information for other kernel images.=20

Linaro folks are also working on a new VirtIO transport called =
virtio-msg [6], [7], which is designed
with Linux-Linux hardware partitioning scenario in mind.

> 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> 4. Proc interface for monitoring loaded kernel instances
>=20
>=20

[=E2=80=A6]

Thanks
- Jiaxun

[1]: https://www.kernel.org/doc/ols/2014/ols2014-barbalace.pdf
[2]: https://sourceforge.net/projects/popcornlinux/
[3]: =
https://lore.kernel.org/all/CAM_iQpXnHr7WC6VN3WB-+=3DCZGF5pyfo9y9D4MCc_Wwg=
p29hBrw@mail.gmail.com/
[4]: https://www.openampproject.org/
[5]: https://docs.kernel.org/staging/rpmsg.html
[6]: https://linaro.atlassian.net/wiki/spaces/HVAC/overview
[7]: https://lwn.net/Articles/1031928/

>=20
>=20
> --
> 2.34.1


