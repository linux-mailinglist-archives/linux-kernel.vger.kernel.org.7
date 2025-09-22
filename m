Return-Path: <linux-kernel+bounces-827418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 294ACB91B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA5D423D20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101611F4C9F;
	Mon, 22 Sep 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYCKkNu1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07627260D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551322; cv=none; b=eojjFor27zf50jeF0P2azVHulYeYsidfdh9YOujToQaJ6GzWuwU+IkVcWF+B5mjBRTgw52VdFKgZfVNm2MMj0AHh5PhTCzjklhzDvVCo0ESFvmlqEDjWRxCURvfNy8ygs6IbFyGUBLJNv2t73JRQJS9np5+8onzSSNcGiUGgSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551322; c=relaxed/simple;
	bh=mZHzOWV+oYS7NM+O/EnxL1NZMPrx+NYmi9n1hVl/0UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLJgsRmqPFoijnQ3gyd0tmTHdL5FJt6bF2bJ+eks3pO7WRrkfl2uTTExvLS2ul61RSNAH2htneRWVsSFkjtExIlUv5A/jvvJm0GckHuNM1tSRr7vItu2THggd9ilmdPAalC47jOdtMnwVqmzxrjG4OlvE5sxBj5k1zRn/IK/XM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYCKkNu1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758551319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mZHzOWV+oYS7NM+O/EnxL1NZMPrx+NYmi9n1hVl/0UI=;
	b=WYCKkNu1JhXzcKgbLzjxBSHvJcVNyL/D03bA+wWpJoE9+iJGGsmJ8zDYoDxYUBC2YMs9ud
	L1xc6gBTAv0abBXuPvxto0FubkIDRqrMyvFPWAgn+uC4uKGYtdNsKDC0e5jMFgrz0rHNjE
	huMuMF2hRsdRgA+HGZ7EVnUZszB5H5Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-0ss1WCFdPea5agxgnXoSyA-1; Mon,
 22 Sep 2025 10:28:35 -0400
X-MC-Unique: 0ss1WCFdPea5agxgnXoSyA-1
X-Mimecast-MFC-AGG-ID: 0ss1WCFdPea5agxgnXoSyA_1758551314
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE8121956055;
	Mon, 22 Sep 2025 14:28:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7F791800446;
	Mon, 22 Sep 2025 14:28:32 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:28:31 -0400
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
Message-ID: <20250922142831.GA351870@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bw/30tv/Tia50C1o"
Content-Disposition: inline
In-Reply-To: <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--Bw/30tv/Tia50C1o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabli=
ng
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CPU
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> >
> > What level of isolation does this patch series provide? What stops
> > kernel A from accessing kernel B's memory pages, sending interrupts to
> > its CPUs, etc?
>=20
> It is kernel-enforced isolation, therefore, the trust model here is still
> based on kernel. Hence, a malicious kernel would be able to disrupt,
> as you described. With memory encryption and IPI filtering, I think
> that is solvable.

I think solving this is key to the architecture, at least if fault
isolation and security are goals. A cooperative architecture where
nothing prevents kernels from interfering with each other simply doesn't
offer fault isolation or security.

On CPU architectures that offer additional privilege modes it may be
possible to run a supervisor on every CPU to restrict access to
resources in the spawned kernel. Kernels would need to be modified to
call into the supervisor instead of accessing certain resources
directly.

IOMMU and interrupt remapping control would need to be performed by the
supervisor to prevent spawned kernels from affecting each other.

This seems to be the price of fault isolation and security. It ends up
looking similar to a hypervisor, but maybe it wouldn't need to use
virtualization extensions, depending on the capabilities of the CPU
architecture.

Stefan

--Bw/30tv/Tia50C1o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjRXQ8ACgkQnKSrs4Gr
c8iFTggAnVrECy2HUHacKiUoa/0O6N7WnJASVkoIOOM6+CKjlG2uzF8tSvls85dZ
ybO6yoTpnuEGFQXEAyA7aB3vc3RK5xxhtowcXnQpV6tzpGRKgEdLyCqvwq0DnOiu
aQZwB7XPmWVeROXSZgHpfEF6CYIthQBDpbTMBjQyGxCzD2VQf+GL9Je/3Dd7HQe6
LdVemRZrJqRh3HxHH0JwDAIBDeP4VKZWOme7qPE0si/8DUPx+2DPECH/HesiPm2t
/J5O8u71QN+D1X3M0V90uWC3udRQcTXSqgQUHSLPvV5V3bfRxFHi/nvRNGLElRzj
kKmT/NrKeONOTt+0Q0iKH5mcW6XvAQ==
=On8H
-----END PGP SIGNATURE-----

--Bw/30tv/Tia50C1o--


