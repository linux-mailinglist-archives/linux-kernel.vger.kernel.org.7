Return-Path: <linux-kernel+bounces-682282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7362AD5DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EAC3AB003
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93F283CA2;
	Wed, 11 Jun 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E626VUp2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC8C8FE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665401; cv=none; b=jAc/97kv/0mh26XWt1SgXelQtD3A1CenWSd7+nM3Y9Ff18c2Qp90ifGn7dnpNm54snBAS8E/wxnQ4QObBICblfo1QkcSACawOF+Bjnk8KFaRocqFzXA+G8B4/oky7t3BYWTXvJwNxoBG5euGKic4nFgYSJiclyc8xKZvXaVFEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665401; c=relaxed/simple;
	bh=bu4xPoBt76F+Eq0kat9hmnO6V+OwxxMkfVAKZ5Yj/Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPfjYXUwO/Y10jPgsWBPwjN3DEM+v2+O1liztwJ99XVaaDPPrV3KSz7bf2J9WyY6QlVtH1uhgGgYvUrGC7yLttjGSkC0dWkGD88lZcPP5WiUs3pa29mTDHbY00Ornp6WNh1Ypg+yENMSWdKO6+g9/scFNs+6M/m0n8HrYRgy3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E626VUp2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749665398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oj/ZmTISV0zLWehd/r37qsP548vbvorWZeWxWtJq4lI=;
	b=E626VUp2CmjCuXZXjRAzgEZmf68ITYqAowwl3vKRAR8UexDJOQudBp86wafBIVt7PmcNCH
	thKmqW7PCc0Wsp2Fr21UnQmIvtwXtwOND9E3MsqwD9I+Vnh3W0to3WKnjNaBIZw86f9vBU
	ThP4NqXptlTbb8zXI9yylfcOHyNZNbs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-RAzo4OtWPCGHAzNAxIKJRQ-1; Wed,
 11 Jun 2025 14:09:54 -0400
X-MC-Unique: RAzo4OtWPCGHAzNAxIKJRQ-1
X-Mimecast-MFC-AGG-ID: RAzo4OtWPCGHAzNAxIKJRQ_1749665393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D0DC19560BD;
	Wed, 11 Jun 2025 18:09:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F108180035C;
	Wed, 11 Jun 2025 18:09:52 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:09:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
	pbonzini@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	darren.kenny@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost-scsi: Fix typos and formatting in comments and
 logs
Message-ID: <20250611180951.GA190743@fedora>
References: <20250611143932.2443796-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gL1+kZGNyJIUcrAQ"
Content-Disposition: inline
In-Reply-To: <20250611143932.2443796-1-alok.a.tiwari@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--gL1+kZGNyJIUcrAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 07:39:21AM -0700, Alok Tiwari wrote:
> This patch corrects several minor typos and formatting issues.
> Changes include:
>=20
> Fixing misspellings like in comments
> - "explict" -> "explicit"
> - "infight" -> "inflight",
> - "with generate" -> "will generate"
>=20
> formatting in logs
> - Correcting log formatting specifier from "%dd" to "%d"
> - Adding a missing space in the sysfs emit string to prevent
>   misinterpreted output like "X86_64on ". changing to "X86_64 on "
> - Cleaning up stray semicolons in struct definition endings
>=20
> These changes improve code readability and consistency.
> no functionality changes.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/vhost/scsi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gL1+kZGNyJIUcrAQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJxm8ACgkQnKSrs4Gr
c8h+5Af+Pw6W/Lmi0FuHsDBbsZP4bq67qUmcf5R9aAbd6M6bpBLfLwsQOolA4RG0
3pewOLgln11imSS632hXDd3KLntR2IoW1t0iwdHwfXX+/wzc3FuEdMahpsscEVxx
ont13Xst6s6C134RD1RSti9uJlqU2KpjnXlKgMjswVSbgO3YoBcCTlTubramxWIR
nxlwlghg6s9QTCqoCoCd4w6cNyKuYUF3AOZnnL0uTaomu3kRHjipN3cbzoVl+c5X
M/OnNP08C1WVhsapy/GvGZFa/PUysPqCacprK4FKkJH3WThZ7Z25SkTa+/zyiTO1
QiJBcXiNYrgyuzuicGpTiU0SStERnA==
=HVM3
-----END PGP SIGNATURE-----

--gL1+kZGNyJIUcrAQ--


