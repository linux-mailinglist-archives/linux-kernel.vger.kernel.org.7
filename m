Return-Path: <linux-kernel+bounces-831120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D175B9B961
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9D017947B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AB24DCEF;
	Wed, 24 Sep 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBIlxJ10"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E724679A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740606; cv=none; b=XOrgXf+wvmFMOZYVlUMNFUdNXrtgVQHTCWrkJHPTJiuDBMNzd4kl13O4nQLivFuPd209J8m5rbxXt1/EWKZnd8Lx3+P8454xbrbeSwNTUNTNfepPijp2rfEoqr/Y9NEDPyoalCxq+W7J82/g+JG+v92wd7Eb8bn7/j4eEDaaGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740606; c=relaxed/simple;
	bh=svtYRVGVOWiQOwGeQLqrRvGYBYlTxeSGi1nAMXidbZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GABrFYTMRCWQwIUSFCGLBf+j6OycWjbYKgHtd/AmzCMCt9nqgg8yu3O7J0L/4Gepck4TZ22M6Vub7DchLCjbJVo6YA3zGus43r5uKOFkeMKO54FojZtGw8hWt8L7d4ya10Ee228K4bKb496cAZiNPanQ6wpRWU3VC5z9k1lvVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBIlxJ10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758740604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svtYRVGVOWiQOwGeQLqrRvGYBYlTxeSGi1nAMXidbZw=;
	b=gBIlxJ100chrgopChZ9bgpWzhZegHp5JIpAu7nArVCixWzKEfrtD8xs8TGF+qs8p9AV8lv
	OwnJOOz+txFHz8LRNH7qnDRAeIWJsR0M/p1zvU4zPGPNkUV+2tcLAFiWIy7BnLgkLTeAUK
	p9uuP+5hqlEsUh+CMkdo57mMiC3nsus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-q4nOE_dQORmW9pfmQoS9GA-1; Wed,
 24 Sep 2025 15:03:20 -0400
X-MC-Unique: q4nOE_dQORmW9pfmQoS9GA-1
X-Mimecast-MFC-AGG-ID: q4nOE_dQORmW9pfmQoS9GA_1758740599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83EBC1800357;
	Wed, 24 Sep 2025 19:03:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 931C9300018D;
	Wed, 24 Sep 2025 19:03:17 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:03:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250924190316.GA8709@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
 <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora>
 <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="io8Dp1r+z0FFF6O3"
Content-Disposition: inline
In-Reply-To: <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--io8Dp1r+z0FFF6O3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:28:04AM -0700, Cong Wang wrote:
> On Wed, Sep 24, 2025 at 5:51=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > > > >
> > > > > Two more points:
> > > > >
> > > > > 1) Security lockdown. Security lockdown transforms multikernel fr=
om
> > > > > "0-day means total compromise" to "0-day means single workload
> > > > > compromise with rapid recovery." This is still a significant impr=
ovement
> > > > > over containers where a single kernel 0-day compromises everything
> > > > > simultaneously.
> > > >
> > > > I don't follow. My understanding is that multikernel currently does=
 not
> > > > prevent spawned kernels from affecting each other, so a kernel 0-da=
y in
> > > > multikernel still compromises everything?
> > >
> > > I would assume that if there is no enforced isolation by the hardware=
 (e.g.,
> > > virtualization, including partitioning hypervisors like jailhouse, pk=
vm etc)
> > > nothing would stop a kernel A to access memory assigned to kernel B.
> > >
> > > And of course, memory is just one of the resources that would not be
> > > properly isolated.
> > >
> > > Not sure if encrypting memory per kernel would really allow to not le=
t other
> > > kernels still damage such kernels.
> > >
> > > Also, what stops a kernel to just reboot the whole machine? Happy to =
learn
> > > how that will be handled such that there is proper isolation.
> >
> > The reason I've been asking about the fault isolation and security
> > statements in the cover letter is because it's unclear:
> > 1. What is implemented today in multikernel.
> > 2. What is on the roadmap for multikernel.
> > 3. What is out of scope for multikernel.
> >
> > Cong: Can you clarify this? If the answer is that fault isolation and
> > security are out of scope, then this discussion can be skipped.
>=20
> It is my pleasure. The email is too narrow, therefore I wrote a
> complete document for you:
> https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rp=
djWa_g/edit?usp=3Dsharing
>=20
> I hope it answers all of the above questions and provides a clear
> big picture. If not, please let me know.
>=20
> (If you need edit permission for the above document, please just
> request, I will approve.)

Thanks, that gives a nice overview!

I/O Resource Allocation part will be interesting. Restructuring existing
device drivers to allow spawned kernels to use specific hardware queues
could be a lot of work and very device-specific. I guess a small set of
devices can be supported initially and then it can grow over time.

This also reminds me of VFIO/mdev devices, which would be another
solution to the same problem, but equally device-specific and also a lot
of work to implement the devices that spawned kernels see.

Anyway, I look forward to seeing how this develops.

Stefan

--io8Dp1r+z0FFF6O3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjUQHQACgkQnKSrs4Gr
c8g6GQf/dmqLH7btBgBhJhQSXIXjdWf+M92gUSUpXzizVaSB2xUrl68p4xZlWEzc
7ijpcKjxMVVGeUgLU7ziduh4sS/Pu/GclMmyTU17mrlVCZjbJsxwz4NmcbWJbvjl
sne3cnef4ov/U/AOPKpTLWHdNMLVvtCltuc+bZ7uS2Zeae7u0ZLWUgZUllddDu2y
OjZBAa4PxbDLrBvm5btURx7kzh4t3bP4TAcKC4GkEngI47jyl5E4XTEWYpFUSEEF
PrlgE+22skiH038nIpmPvHvQhfeM52npehlqBajdFjgmpTMOeNjDNTR0mM+b8+nr
UtE9Nt0gu32myYQUKVwt+vAfC7hNBw==
=9wqm
-----END PGP SIGNATURE-----

--io8Dp1r+z0FFF6O3--


