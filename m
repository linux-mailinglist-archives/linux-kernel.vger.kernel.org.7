Return-Path: <linux-kernel+bounces-830536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26936B99EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA4A18979FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80C2FDC2C;
	Wed, 24 Sep 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG4BIQA9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84292E06EF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718273; cv=none; b=U0wilUgkSfTwyOwbmj2EmWxd4NVRkezR3PbEMeGCakbqGxMBMRpzO3W4T7SJ0KGV7SJQA5Y9X46eky4TnAmNtvV185GwVGfK9j60zaGSG3K1R1735qJwQVl5kBLfN9KKSQ3xrXitSpze/aFybwEqSW9BJtLFWg2HDOnrMO1bgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718273; c=relaxed/simple;
	bh=RTQTYZTiz2YYOPaT/MkK88YrNEGe0k4y4vUiJM9oV9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJeRNqbhwYd5zfT78ePHKfLBCZb82/JqHDj27n3iORunl4qoEv8RcfnLUB9+75YUvmdG71WlVw621iagCYBxRCJLtQ5MQECFipoJrbb/xJgjkwbloNP1BfN2eaOQvcHVNMV/eOCKGsMjPZFkDSeqgT5OM2j7sV2Wsmt6kl9DnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG4BIQA9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758718270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTQTYZTiz2YYOPaT/MkK88YrNEGe0k4y4vUiJM9oV9U=;
	b=WG4BIQA9rHsOJ70SKNNnABvQtbuj6cDHHS7wMpXiSQfDr2/ScUMP9GA9ONoYI//D4hZ7Dj
	RzC0xeoj9MXtokL9fSw5f4oAITfG2ZL5Yni+rOjOCt7bBvuGxZWct44ZV0pm4JtlrAHjKH
	S5gOiFhSEoPEfGNFZh59tCUYIV3Je6E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-PvkmhR6fP--M8zTnbb8_Mw-1; Wed,
 24 Sep 2025 08:51:06 -0400
X-MC-Unique: PvkmhR6fP--M8zTnbb8_Mw-1
X-Mimecast-MFC-AGG-ID: PvkmhR6fP--M8zTnbb8_Mw_1758718265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3741919560B7;
	Wed, 24 Sep 2025 12:51:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFF741800452;
	Wed, 24 Sep 2025 12:51:02 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:51:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <20250924125101.GA562097@fedora>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora>
 <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
 <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora>
 <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CpzOrJ/+7+dHBlWP"
Content-Disposition: inline
In-Reply-To: <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--CpzOrJ/+7+dHBlWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > >=20
> > > Two more points:
> > >=20
> > > 1) Security lockdown. Security lockdown transforms multikernel from
> > > "0-day means total compromise" to "0-day means single workload
> > > compromise with rapid recovery." This is still a significant improvem=
ent
> > > over containers where a single kernel 0-day compromises everything
> > > simultaneously.
> >=20
> > I don't follow. My understanding is that multikernel currently does not
> > prevent spawned kernels from affecting each other, so a kernel 0-day in
> > multikernel still compromises everything?
>=20
> I would assume that if there is no enforced isolation by the hardware (e.=
g.,
> virtualization, including partitioning hypervisors like jailhouse, pkvm e=
tc)
> nothing would stop a kernel A to access memory assigned to kernel B.
>=20
> And of course, memory is just one of the resources that would not be
> properly isolated.
>=20
> Not sure if encrypting memory per kernel would really allow to not let ot=
her
> kernels still damage such kernels.
>=20
> Also, what stops a kernel to just reboot the whole machine? Happy to learn
> how that will be handled such that there is proper isolation.

The reason I've been asking about the fault isolation and security
statements in the cover letter is because it's unclear:
1. What is implemented today in multikernel.
2. What is on the roadmap for multikernel.
3. What is out of scope for multikernel.

Cong: Can you clarify this? If the answer is that fault isolation and
security are out of scope, then this discussion can be skipped.

Thanks,
Stefan

--CpzOrJ/+7+dHBlWP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjT6TUACgkQnKSrs4Gr
c8glqAf/V/fg56oCmCv+HaFs3LvmQyEljhq0JJy17N25yTd+uBaKlL/RQs/qTsez
VrTtD5K5M/dKzlI9hpUM+/RzrxvYy65ZPp6CIfo1eBCRTUpmLZeUXYnZfjk/oU7A
8lL4qXt4sohUnt52FX6jT0io63SgZfzVa+ioe2WDZmh/YVkIi9JNjxhH5HJMuUPU
MxS53WDukYaEaBUJSi4cs/QdjcCudEzZBaeP1FjC6uoeZQ/3lT6Ozr0YGNeHHLUT
XRG0dL1oq9ABmi7Yy2UHwmqj+4cT2964SErwJUesi+a7ij4/ZL2osb1aurT098ZC
e75vuYwusPi8KJrYkzuXOLpAWMW6EA==
=+t3/
-----END PGP SIGNATURE-----

--CpzOrJ/+7+dHBlWP--


