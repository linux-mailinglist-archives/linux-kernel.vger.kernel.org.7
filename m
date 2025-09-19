Return-Path: <linux-kernel+bounces-825228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79495B8B541
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A01B2779A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFB2D0617;
	Fri, 19 Sep 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POktaUEx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C3274FEF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317224; cv=none; b=GYqZK4r5UNFPvtdoehwFeZZEjq2MgQiE14XVWLMC8Z5Bb0DtJFWwQxrg/npABOl1qV/s38JOnYuzkPGJwZ/mPYuva7NQR99Eo2q3lSEXxbMwgmK1pciP0VsZG7TD6O1dnPkVp9U0oVaq4tnnx4Vt1N09ZgWvJu/JBzmcpJfif7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317224; c=relaxed/simple;
	bh=eRiZBzmsW8U/FLKqDEObRdR5WUIa1l9w6q/YY6idpnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naS/RfkxW3CnYajVQ164S+hYZ/NN/IkFA5eV3+tzK/hwLJ3Mhzno8emEjaxOXA13oc/NcnNhuW6DDU20MtSyaPiojr+0Dr6o3dguE8HAa4zVyycMoEeop18F9gbLLzMMwmpWAhllfKZyahBtvhCG6jF4gV6sNf7dO0yv0Sy0rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POktaUEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758317221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kUNBbkgUP7UkdLkjt7gNAUDoEAUE2pfBTAUAT+0Q90=;
	b=POktaUExy7rJ1fRixN7XTn+S8ItjTdabuA+VuTgq5KV316YL6eOdlApUJl5SOgLOuOuyit
	S5y5WUujiqgJ3LM/qw8MJ49+EdfByLEHDcD2pOg2NqrYFK+qfvQ93LIwTNbkfI6G3hEgFF
	0JjtGgl4u8uVW7I3M1LUKTjTELHxIng=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-Z8c109b3MmeDkNukUh-YgA-1; Fri,
 19 Sep 2025 17:26:55 -0400
X-MC-Unique: Z8c109b3MmeDkNukUh-YgA-1
X-Mimecast-MFC-AGG-ID: Z8c109b3MmeDkNukUh-YgA_1758317214
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7256919560B5;
	Fri, 19 Sep 2025 21:26:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB9B7180035E;
	Fri, 19 Sep 2025 21:26:51 +0000 (UTC)
Date: Fri, 19 Sep 2025 17:26:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250919212650.GA275426@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wJMNkTvE9gcHAHlx"
Content-Disposition: inline
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--wJMNkTvE9gcHAHlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
>=20
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation

What level of isolation does this patch series provide? What stops
kernel A from accessing kernel B's memory pages, sending interrupts to
its CPUs, etc?

> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)
>=20
> Architecture Overview:
> The implementation leverages kexec infrastructure to load and manage
> multiple kernel images, with each kernel instance assigned to specific
> CPU cores. Inter-kernel communication is facilitated through a dedicated
> IPI framework that allows kernels to coordinate and share information
> when necessary.
>=20
> Key Components:
> 1. Enhanced kexec subsystem with dynamic kimage tracking
> 2. Generic IPI communication framework for inter-kernel messaging
> 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> 4. Proc interface for monitoring loaded kernel instances
>=20
> Patch Summary:
>=20
> Patch 1/7: Introduces basic multikernel support via kexec, allowing
>            multiple kernel images to be loaded simultaneously.
>=20
> Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
>            CPUs with different kernel instances.
>=20
> Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
>            communication.
>=20
> Patch 4/7: Implements generic multikernel IPI communication framework
>            for cross-kernel messaging and coordination.
>=20
> Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
>            identifiers for proper CPU management.
>=20
> Patch 6/7: Replaces static kimage globals with dynamic linked list
>            infrastructure to support multiple kernel images.
>=20
> Patch 7/7: Adds /proc/multikernel interface for monitoring and debugging
>            loaded kernel instances.
>=20
> The implementation maintains full backward compatibility with existing
> kexec functionality while adding the new multikernel capabilities.
>=20
> IMPORTANT NOTES:
>=20
> 1) This is a Request for Comments (RFC) submission. While the core
>    architecture is functional, there are numerous implementation details
>    that need improvement. The primary goal is to gather feedback on the
>    high-level design and overall approach rather than focus on specific
>    coding details at this stage.
>=20
> 2) This patch series represents only the foundational framework for
>    multikernel support. It establishes the basic infrastructure and
>    communication mechanisms. We welcome the community to build upon
>    this foundation and develop their own solutions based on this
>    framework.
>=20
> 3) Testing has been limited to the author's development machine using
>    hard-coded boot parameters and specific hardware configurations.
>    Community testing across different hardware platforms, configurations,
>    and use cases would be greatly appreciated to identify potential
>    issues and improve robustness. Obviously, don't use this code beyond
>    testing.
>=20
> This work enables new use cases such as running real-time kernels
> alongside general-purpose kernels, isolating security-critical
> applications, and providing dedicated kernel instances for specific
> workloads etc..

This reminds me of Jailhouse, a partitioning hypervisor for Linux.
Jailhouse uses virtualization and other techniques to isolate CPUs,
allowing real-time workloads to run alongside Linux:
https://github.com/siemens/jailhouse

It would be interesting to hear your thoughts about where you want to go
with this series and how it compares with a partitioning hypervisor like
Jailhouse.

Thanks,
Stefan

>=20
> Signed-off-by: Cong Wang <cwang@multikernel.io>
>=20
> ---
>=20
> Cong Wang (7):
>   kexec: Introduce multikernel support via kexec
>   x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
>   x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
>   kernel: Introduce generic multikernel IPI communication framework
>   x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
>   kexec: Implement dynamic kimage tracking
>   kexec: Add /proc/multikernel interface for kimage tracking
>=20
>  arch/powerpc/kexec/crash.c          |   8 +-
>  arch/x86/include/asm/idtentry.h     |   1 +
>  arch/x86/include/asm/irq_vectors.h  |   1 +
>  arch/x86/include/asm/smp.h          |   7 +
>  arch/x86/kernel/Makefile            |   1 +
>  arch/x86/kernel/crash.c             |   4 +-
>  arch/x86/kernel/head64.c            |   5 +
>  arch/x86/kernel/idt.c               |   1 +
>  arch/x86/kernel/setup.c             |   3 +
>  arch/x86/kernel/smp.c               |  15 ++
>  arch/x86/kernel/smpboot.c           | 161 +++++++++++++
>  arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S       |   6 +
>  include/linux/kexec.h               |  22 +-
>  include/linux/multikernel.h         |  81 +++++++
>  include/uapi/linux/kexec.h          |   1 +
>  include/uapi/linux/reboot.h         |   2 +-
>  init/main.c                         |   2 +
>  kernel/Makefile                     |   2 +-
>  kernel/kexec.c                      | 103 +++++++-
>  kernel/kexec_core.c                 | 359 ++++++++++++++++++++++++++++
>  kernel/kexec_file.c                 |  33 ++-
>  kernel/multikernel.c                | 314 ++++++++++++++++++++++++
>  kernel/reboot.c                     |  10 +
>  24 files changed, 1411 insertions(+), 19 deletions(-)
>  create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
>  create mode 100644 include/linux/multikernel.h
>  create mode 100644 kernel/multikernel.c
>=20
> --=20
> 2.34.1
>=20

--wJMNkTvE9gcHAHlx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjNypoACgkQnKSrs4Gr
c8jDiAgAg+cJ1RtnT6VtPZ4iFMdU8taG28VItTHeoGu8v+SDyVctvyYYKUHpmW1x
YZGWILjIz9LhjSqbVktIdavzMa/cGZBkWz6oWEdeEu0+uIUarlX3xQnSxSaHP9Js
anZypzajok9Byzw7uQBHs2piynVAUEo34cMwq0jEGFXj817RLsx5mObptUJEFpgE
mo3h4uzt6Pn8ASWpYve3zdr1TgpafXg1ljHoYpSR3CXjaUWfD1ycpFFag/k9l9Qv
XPpGN8iviPGt5BwMvIvlMRKlc3vVg+l7wFwiunZpJ8ehsVh+Sj23ji0HKVNS94X5
0kD3uiFZX97QuMHLzUX6QlNNzFyQNQ==
=3ZjT
-----END PGP SIGNATURE-----

--wJMNkTvE9gcHAHlx--


